//
//  MarketDataModel.swift
//  CryptoTracker
//
//  Created by Arkar Min on 26/09/2024.
//

import Foundation

//Json Data
/*
 
 URL : https://api.coingecko.com/api/v3/global?x_cg_demo_api_key=CG-m1dgjZ2xJE4T24QbWT4CY4Cz
 
 JSON Response
 
 {
   "data": {
     "active_cryptocurrencies": 14696,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 1199,
     "total_market_cap": {
       "btc": 36814897.277991235,
       "eth": 895488665.0266672,
       "ltc": 34914833974.450226,
       "bch": 6768686234.738433,
       "bnb": 3943454069.2699246,
       "eos": 4389414555701.809,
       "xrp": 4004368812610.237,
       "xlm": 24259253457400.93,
       "link": 193083295968.79153,
       "dot": 491204657018.81714,
       "yfi": 445252150.42939335,
       "usd": 2347488816889.891,
       "aed": 8622302949548.421,
       "ars": 2273532824955948.5,
       "aud": 3421530680303.891,
       "bdt": 280552388627454.94,
       "bhd": 884855392172.0233,
       "bmd": 2347488816889.891,
       "brl": 12851562276945.398,
       "cad": 3162062741373.0493,
       "chf": 1994501618471.7932,
       "clp": 2140604627457384.8,
       "cny": 16475380763578.332,
       "czk": 53006062736491.89,
       "dkk": 15714559638024.307,
       "eur": 2107345405899.6907,
       "gbp": 1758431100578.8938,
       "gel": 6396907026024.957,
       "hkd": 18268296474877.348,
       "huf": 834832342162376.2,
       "idr": 35530868919541520,
       "ils": 8717923211526.76,
       "inr": 196479510996446.56,
       "jpy": 339871778398135.44,
       "krw": 3121245166874797.5,
       "kwd": 716369077317.3872,
       "lkr": 709422066804477.2,
       "mmk": 4925031537835004,
       "mxn": 46021945467855.06,
       "myr": 9723298679557.941,
       "ngn": 3873168748762976.5,
       "nok": 24890060064716.91,
       "nzd": 3737474505191.452,
       "php": 131512196939191.66,
       "pkr": 655113490507980.6,
       "pln": 8991706137263.025,
       "rub": 216900074423223.47,
       "sar": 8806562041763.723,
       "sek": 23874949560562.117,
       "sgd": 3020950493612.166,
       "thb": 76494096842765.56,
       "try": 80192530261443.23,
       "twd": 74853202159759.44,
       "uah": 97240404860240.64,
       "vef": 235054055235.1849,
       "vnd": 57819935629398970,
       "zar": 40409555119501.87,
       "xdr": 1744987032124.5671,
       "xag": 72981455426.5005,
       "xau": 879862283.4585,
       "bits": 36814897277991.234,
       "sats": 3681489727799123.5
     },
     "total_volume": {
       "btc": 1288262.3040927472,
       "eth": 31335800.890197102,
       "ltc": 1221773460.979632,
       "bch": 236856380.68201023,
       "bnb": 137993138.67429018,
       "eos": 153598617061.12027,
       "xrp": 140124725977.5562,
       "xlm": 848903136103.1278,
       "link": 6756556452.359862,
       "dot": 17188705932.10785,
       "yfi": 15580691.611961458,
       "usd": 82145587131.28479,
       "aed": 301719920077.3384,
       "ars": 79557647910624.7,
       "aud": 119729493320.28732,
       "bdt": 9817359094140.32,
       "bhd": 30963711176.50504,
       "bmd": 82145587131.28479,
       "brl": 449714231308.93176,
       "cad": 110649941574.66634,
       "chf": 69793519485.5278,
       "clp": 74906096537404.66,
       "cny": 576522374163.4963,
       "czk": 1854839142865.692,
       "dkk": 549898989374.2465,
       "eur": 73742257858.92868,
       "gbp": 61532712806.84437,
       "gel": 223846724932.7512,
       "hkd": 639261805645.2996,
       "huf": 29213256484846.832,
       "idr": 1243330348447559.2,
       "ils": 305065956277.95575,
       "inr": 6875400076007.208,
       "jpy": 11893120250454.547,
       "krw": 109221613738422.95,
       "kwd": 25067875951.33141,
       "lkr": 24824779475947.02,
       "mmk": 172341441801435.9,
       "mxn": 1610444192185.5806,
       "myr": 340247021897.782,
       "ngn": 135533647119649.66,
       "nok": 870976927787.0077,
       "nzd": 130785303601.11212,
       "php": 4602001319353.58,
       "pkr": 22924361525479.254,
       "pln": 314646431813.9043,
       "rub": 7589976077466.775,
       "sar": 308167691502.44653,
       "sek": 835455204417.349,
       "sgd": 105712006041.03061,
       "thb": 2676755029466.481,
       "try": 2806174169808.01,
       "twd": 2619335264061.7095,
       "uah": 3402729799033.15,
       "vef": 8225237639.45555,
       "vnd": 2023290814421312.2,
       "zar": 1414050029598.5842,
       "xdr": 61062265029.34356,
       "xag": 2553837301.6184525,
       "xau": 30788987.51267685,
       "bits": 1288262304092.747,
       "sats": 128826230409274.72
     },
     "market_cap_percentage": {
       "btc": 53.67161429654366,
       "eth": 13.445755978191226,
       "usdt": 5.078259313012863,
       "bnb": 3.7009948752927526,
       "sol": 3.0182848309851242,
       "usdc": 1.5361690810883928,
       "xrp": 1.411265393759535,
       "steth": 1.0953371080933993,
       "doge": 0.7114552322920931,
       "ton": 0.6280005539404185
     },
     "market_cap_change_percentage_24h_usd": -0.9620993407254844,
     "updated_at": 1727341067
   }
 }
 
 
*/

struct GlobalData : Codable {
    let data: MarketDataModel?
}

struct MarketDataModel : Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys : String , CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap : String {
        
//        if let item = totalMarketCap.first(where: { (key ,value) in
//            return key == "usd"
//        }){
//            return "\(item)"
//        }else {
//            return ""
//        }
        
        if let item = totalMarketCap.first(where: { $0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }else {
            return ""
        }
    }
    
    var volume : String {
        if let item = totalVolume.first(where: { $0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }else {
            return ""
        }
    }
    
    var btcDominance : String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}){
            return item.value.asPercentString()
        }else {
            return ""
        }
    }
    

    
}

