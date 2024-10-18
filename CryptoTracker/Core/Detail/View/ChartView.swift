//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Arkar Min on 11/10/2024.
//

import SwiftUI

struct ChartView: View {
    private let data : [Double]
    private let minY : Double
    private let maxY : Double
    private let lineColor : Color
    private let startDate : Date
    private let endDate : Date
    @State private var percentage : Double = 0
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        minY = data.min() ?? 0
        maxY = data.max() ?? 0
        
        let priceChange = ( data.last ?? 0 ) - ( data.first ?? 0 )
        lineColor = priceChange > 0 ? Color.green : Color.red
        
        endDate = Date(coinGecoString: coin.lastUpdated ?? "")
        startDate = endDate.addingTimeInterval(-7*24*60*60)
    }
    
    
    var body: some View {
        VStack{
            chartView
                .frame(height: 200)
                .background(chartBackgroundGrid)
                .overlay (chartYAxis.padding(.horizontal,4),alignment : .leading)
            
            chartDateLabel
                .padding(.horizontal,4)
        
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1
                }
            }
        }
    }
}


extension ChartView {
    
    private var  chartView : some View {
        GeometryReader { geometry in
            Path{ path in
                
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index+1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - ( CGFloat( (data[index] - minY) / yAxis ) ) ) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
                
            }
            .trim(from: 0,to: percentage)
            .stroke(lineColor,style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius : 10, x : 0, y : 10)
            .shadow(color: lineColor.opacity(0.5), radius : 10, x : 0, y : 10)
            .shadow(color: lineColor.opacity(0.2), radius : 10, x : 0, y : 10)
            .shadow(color: lineColor.opacity(0.1), radius : 10, x : 0, y : 10)
        }
    }
    
    private var chartBackgroundGrid : some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis : some View {
        VStack{
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY)/2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
    }
    
    private var chartDateLabel : some View {
        HStack{
            Text(startDate.asShortDateString())
            Spacer()
            Text(endDate.asShortDateString())
        }
    }
}

#Preview {
    ChartView(coin: MockData.coin)
}
