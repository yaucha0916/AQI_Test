//
//  NetworkController.swift
//  AQI_Test
//
//  Created by 葉育彰 on 2019/6/14.
//  Copyright © 2019 葉育彰. All rights reserved.
//

import UIKit
import CoreData
class NetworkController: NSObject {
    let queue = OperationQueue()
    var mainContext: NSManagedObjectContext!
    var fetchResultsController: NSFetchedResultsController<AQI>!
    var aqiNetworkRequest: MyNetworkRequest!
    var dailyquoteNetworkRequest: MyNetworkRequest!

    func requestMyData() -> NSFetchedResultsController<AQI> {
        dailyquoteNetworkRequest = MyNetworkRequest(urlString: "http://www.appledaily.com.tw/index/dailyquote")

        aqiNetworkRequest = MyNetworkRequest(urlString:
            "http://opendata.epa.gov.tw/webapi/Data/REWIQA/?$orderby=SiteName&$skip=0&$top=1000&format=json")
        //queue.addOperations([aqiNetworkRequest], waitUntilFinished: true)
        let fetchRequest: NSFetchRequest<AQI> = AQI.fetchRequest()
        let sortDescriptorSiteName = NSSortDescriptor(key: "siteName", ascending: true)
        let sortDescriptorCounty = NSSortDescriptor(key: "county", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptorCounty, sortDescriptorSiteName]

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            mainContext = appDelegate.persistentContainer.viewContext
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                managedObjectContext: mainContext,
                                                                sectionNameKeyPath: nil, cacheName: nil)
        }

        do {
            try fetchResultsController.performFetch()
            return fetchResultsController
        } catch {
            print(error)
        }
        return NSFetchedResultsController()
    }
}
