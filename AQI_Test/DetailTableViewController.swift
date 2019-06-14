//
//  DetailTableViewController.swift
//  AQI_Test
//
//  Created by 葉育彰 on 2019/6/14.
//  Copyright © 2019 葉育彰. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    var aqiInfo: AQI?
    @IBOutlet var siteName: UILabel!
    @IBOutlet var county: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var aQI: UILabel!
    @IBOutlet var pm25: UILabel!
    @IBOutlet var pm25AVG: UILabel!
    @IBOutlet var cOValue: UILabel!
    @IBOutlet var cO8hr: UILabel!
    @IBOutlet var o3Value: UILabel!
    @IBOutlet var o38hr: UILabel!
    @IBOutlet var nOValue: UILabel!
    @IBOutlet var nO2: UILabel!
    @IBOutlet var nOx: UILabel!
    @IBOutlet var sO2: UILabel!
    @IBOutlet var sO2AVG: UILabel!
    @IBOutlet var pm10: UILabel!
    @IBOutlet var pm10AVG: UILabel!
    @IBOutlet var windDirec: UILabel!
    @IBOutlet var windSpeed: UILabel!
    @IBOutlet var pollutant: UILabel!
    @IBOutlet var publishTime: UILabel!
    @IBOutlet var longitude: UILabel!
    @IBOutlet var latitude: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        siteName.text = aqiInfo?.siteName
        county.text = aqiInfo?.county
        status.text = aqiInfo?.status
        aQI.text = aqiInfo?.aQI
        pm25.text = aqiInfo?.pM25
        pm25AVG.text = aqiInfo?.pM25_AVG
        cOValue.text = aqiInfo?.cO
        cO8hr.text = aqiInfo?.cO_8hr
        o3Value.text = aqiInfo?.o3
        o38hr.text = aqiInfo?.o3_8hr
        nOValue.text = aqiInfo?.nO
        nO2.text = aqiInfo?.nO2
        nOx.text = aqiInfo?.nOx
        sO2.text = aqiInfo?.sO2
        sO2AVG.text = aqiInfo?.sO2_AVG
        pm10.text = aqiInfo?.pM10
        pm10AVG.text = aqiInfo?.pM10_AVG
        windDirec.text = aqiInfo?.windDirec
        windSpeed.text = aqiInfo?.windDirec
        pollutant.text = aqiInfo?.pollutant
        publishTime.text = aqiInfo?.publishTime
        longitude.text = aqiInfo?.longitude
        latitude.text = aqiInfo?.latitude
    }
}
