//
//  PreviewProvider.swift
//  CryptoTracker
//
//  Created by Arkar Min on 18/09/2024.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev : DeveloperPreview { return DeveloperPreview.instance }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init(){}
    
    let coin : CoinModel = CoinModel(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400", currentPrice: 60349, marketCap: 1192251241611, marketCapRank: 1, fullyDilutedValuation: 1267349676119, totalVolume: 40529231300, high24H: 61243, low24H: 58440, priceChange24H: 1853.49, priceChangePercentage24H: 3.16862, marketCapChange24H: 36380666713, marketCapChangePercentage24H: 3.14747, circulatingSupply: 19755618, totalSupply: 21000000, maxSupply: 21000000, ath: 73738, athChangePercentage: -18.1569, athDate: "2024-03-14T07:10:36.635Z", atl: 67.81, atlChangePercentage: 88899.12037, atlDate: "2013-07-06T00:00:00.000Z", lastUpdated: "2024-09-18T06:20:29.521Z", 
                                     sparklineIn7D: SparklineIn7D(price: [56247.93520956472,
                                                                          56447.12253444625,
                                                                          56662.77813018365,
                                                                          56614.289226885325,
                                                                          56559.514992330965,
                                                                          56645.186007159675,
                                                                          56821.186548327365,
                                                                          56964.913309410476,
                                                                          55901.74064288845,
                                                                          55973.8859302244,
                                                                          56918.38810970602,
                                                                          57513.11497228514,
                                                                          57749.3173909131,
                                                                          57571.61409552569,
                                                                          57583.58942979908,
                                                                          57561.05343117227,
                                                                          57314.02410795248,
                                                                          57479.54836290061,
                                                                          57510.798830398475,
                                                                          57624.35189196091,
                                                                          57935.45646898966,
                                                                          58218.67880572494,
                                                                          58120.23290678855,
                                                                          57938.797549689305,
                                                                          57888.36985638706,
                                                                          58253.63856478929,
                                                                          58215.39951897844,
                                                                          58026.009078758456,
                                                                          58091.00972656764,
                                                                          58057.08319565786,
                                                                          57659.95493558617,
                                                                          57970.459668913456,
                                                                          57927.30769053969,
                                                                          57822.685553282594,
                                                                          58087.38186620643,
                                                                          58358.331296075514,
                                                                          58365.418953508546,
                                                                          58386.380745154944,
                                                                          57986.46518718724,
                                                                          58060.35003707302,
                                                                          58134.82700804652,
                                                                          58155.62113177616,
                                                                          58013.497710735,
                                                                          58156.875844222704,
                                                                          58045.75605813572,
                                                                          57932.6955649952,
                                                                          57888.70178505414,
                                                                          57852.2686668971,
                                                                          57852.42404220491,
                                                                          57999.53338912729,
                                                                          57949.06426994313,
                                                                          58089.113778767205,
                                                                          58218.48942630179,
                                                                          57819.30771897093,
                                                                          57926.460287186324,
                                                                          58054.03118432944,
                                                                          58449.93476529068,
                                                                          59593.36696907746,
                                                                          59634.58338002218,
                                                                          59600.17719945084,
                                                                          59805.60489728142,
                                                                          59675.75547078083,
                                                                          59886.54177927379,
                                                                          60431.28098885077,
                                                                          60414.28977610074,
                                                                          60620.62747295754,
                                                                          60590.86543654763,
                                                                          60480.46260923191,
                                                                          60419.12908298475,
                                                                          60334.796787248044,
                                                                          60240.273519966184,
                                                                          60001.15051060231,
                                                                          60026.432790818886,
                                                                          60070.48557496104,
                                                                          59968.41696998458,
                                                                          60014.00828587379,
                                                                          59819.902506818566,
                                                                          59794.75427824437,
                                                                          59776.159657963886,
                                                                          59793.05620420053,
                                                                          59966.60767673061,
                                                                          59890.30652647748,
                                                                          59910.77636141386,
                                                                          59841.35086761201,
                                                                          59780.44873391363,
                                                                          59823.33175552341,
                                                                          59975.26978669294,
                                                                          60064.75264543763,
                                                                          60064.432134572024,
                                                                          60013.882041044,
                                                                          60126.50434134393,
                                                                          60169.79899717741,
                                                                          60220.14355588191,
                                                                          60209.40011532449,
                                                                          60174.848181359004,
                                                                          60152.179161967026,
                                                                          60152.50056428418,
                                                                          60204.4991581917,
                                                                          60070.699708137254,
                                                                          59980.01117210122,
                                                                          59997.748304015346,
                                                                          59972.170926690655,
                                                                          60080.54021760577,
                                                                          60020.80352274349,
                                                                          60251.898335166276,
                                                                          60241.044621817106,
                                                                          59867.17271162391,
                                                                          59817.63931653717,
                                                                          60139.49558241954,
                                                                          59934.89630185745,
                                                                          59622.2393902769,
                                                                          59418.21608572046,
                                                                          58949.11369730079,
                                                                          58962.86324377677,
                                                                          58689.43905998534,
                                                                          58442.9634176284,
                                                                          58373.35584330864,
                                                                          58579.58396190821,
                                                                          58321.09535637939,
                                                                          58602.93079593577,
                                                                          58680.7927891159,
                                                                          58929.764480198406,
                                                                          58982.52543925611,
                                                                          58610.714110205,
                                                                          58800.54160959564,
                                                                          58765.12817618118,
                                                                          58499.64650639906,
                                                                          58374.725818389015,
                                                                          57912.77735736806,
                                                                          57905.67320656069,
                                                                          57860.077940136594,
                                                                          58176.37890208296,
                                                                          57863.95250925426,
                                                                          57890.44885024387,
                                                                          57884.533124725094,
                                                                          57986.08347484864,
                                                                          58236.257445578536,
                                                                          58251.27267436425,
                                                                          57767.78226883802,
                                                                          57839.48097393634,
                                                                          58098.16699183134,
                                                                          58129.353688610405,
                                                                          58264.61830815356,
                                                                          58532.70872200161,
                                                                          58569.71835994324,
                                                                          58790.090047016616,
                                                                          58722.162538473516,
                                                                          59094.149237134654,
                                                                          59055.53531671722,
                                                                          59228.508480328026,
                                                                          59284.755003367514,
                                                                          59163.77955715653,
                                                                          61231.62129710131,
                                                                          61202.01968568921,
                                                                          60970.25348144018,
                                                                          60976.857374660656,
                                                                          60563.415830997714,
                                                                          59973.9506205091,
                                                                          60375.03695473223,
                                                                          60174.66622543997,
                                                                          60155.64411695945,
                                                                          60061.88485600524,
                                                                          60163.834722174084,
                                                                          60124.06622749374,
                                                                          60367.12638253788,
                                                                          60514.12318125176,
                                                                          60355.3951320565]),
                                     priceChangePercentage24HInCurrency: 3.168617571727398,
                                     currentHoldings: 60349  )
}
