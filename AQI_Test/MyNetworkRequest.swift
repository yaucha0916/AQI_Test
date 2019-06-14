//
//  MyNetworkRequest.swift
//  AQI_Test
//
//  Created by 葉育彰 on 2019/6/14.
//  Copyright © 2019 葉育彰. All rights reserved.
//

import UIKit
import CoreData

class MyNetworkRequest: Operation, URLSessionDataDelegate {
    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    private var innerContext: NSManagedObjectContext?
    private var task: URLSessionTask?
    private var incomingData = Data()
    var error: Error?

    init(urlString: String) {
        super.init()
        if let url = URL(string: urlString) {
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
            task = session.dataTask(with: url)
            task?.resume()
        }
    }

    //    override func main() {
    //        task?.resume()
    //    }

    var internalFinished: Bool = false
    override var isFinished: Bool {
        get {
            return internalFinished
        }
        set (newAnswer) {
            willChangeValue(forKey: "isFinished")
            internalFinished = newAnswer
            didChangeValue(forKey: "isFinished")
        }
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        if isCancelled {
            isFinished = true
            task?.cancel()
            return
        }
        //Check the response code and react appropriately
        if let response = response as? HTTPURLResponse {
            print("response.statusCode:\(response.statusCode)")
            if response.statusCode == 200 {
                completionHandler(.allow)
            }
        }
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if isCancelled {
            isFinished = true
            task?.cancel()
            return
        }
        incomingData.append(data)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask,
                    didCompleteWithError error: Error?) {
        if isCancelled {
            isFinished = true
            task.cancel()
            return
        }
        if error != nil {
            self.error = error
            print("Failed to receive response: \(String(describing: error))")
            isFinished = true
            return
        }
        //PROCESS DATA INTO CORE DATA
        processDataIntoCoreData()
        isFinished = true
    }

    func processDataIntoCoreData() {
        do {
            if let dictArray = try JSONSerialization.jsonObject(with: incomingData,
                                                                options: .allowFragments ) as? [[String: String]] {
                guard let app = appDelegate else { return }
                innerContext = app.persistentContainer.viewContext

                if let innerContext = innerContext {

                    for num in 0..<dictArray.count {

                        let request = NSFetchRequest<AQI>(entityName: "AQI")
                        request.predicate = nil
                        guard let updateID = dictArray[num]["SiteName"] else { return }
                        request.predicate =
                            NSPredicate(format: "siteName = \"\(updateID)\"")

                        do {
                            if let results = try innerContext.fetch(request) as? [AQI] {
                                if results.count > 0 {
                                    results[0].o3 = dictArray[num]["O3"]
                                    results[0].aQI = dictArray[num]["AQI"]
                                    results[0].sO2_AVG = dictArray[num]["SO2_AVG"]
                                    results[0].sO2 = dictArray[num]["SO2"]
                                    results[0].nO2 = dictArray[num]["NO2"]
                                    results[0].o3_8hr = dictArray[num]["O3_8hr"]
                                    results[0].latitude = dictArray[num]["Latitude"]
                                    results[0].o3 = dictArray[num]["O3"]
                                    results[0].pM10_AVG = dictArray[num]["PM10_AVG"]
                                    results[0].cO_8hr = dictArray[num]["CO_8hr"]
                                    results[0].status = dictArray[num]["Status"]
                                    results[0].nOx = dictArray[num]["NOx"]
                                    results[0].publishTime = dictArray[num]["PublishTime"]
                                    results[0].longitude = dictArray[num]["Longitude"]
                                    results[0].pollutant = dictArray[num]["Pollutant"]
                                    results[0].nO = dictArray[num]["NO"]
                                    results[0].pM25_AVG = dictArray[num]["PM2.5_AVG"]
                                    results[0].pM25 = dictArray[num]["PM2.5"]
                                    results[0].cO = dictArray[num]["CO"]
                                    results[0].windDirec = dictArray[num]["WindDirec"]
                                    results[0].windSpeed = dictArray[num]["WindSpeed"]
                                    results[0].pM10 = dictArray[num]["PM10"]
                                    results[0].county = dictArray[num]["County"]
                                    try innerContext.save()
                                } else {
                                    let aPlace: AQI = AQI(context: innerContext)
                                    aPlace.siteName = dictArray[num]["SiteName"]
                                    aPlace.o3 = dictArray[num]["O3"]
                                    aPlace.aQI = dictArray[num]["AQI"]
                                    aPlace.sO2_AVG = dictArray[num]["SO2_AVG"]
                                    aPlace.sO2 = dictArray[num]["SO2"]
                                    aPlace.nO2 = dictArray[num]["NO2"]
                                    aPlace.o3_8hr = dictArray[num]["O3_8hr"]
                                    aPlace.latitude = dictArray[num]["Latitude"]
                                    aPlace.o3 = dictArray[num]["O3"]
                                    aPlace.pM10_AVG = dictArray[num]["PM10_AVG"]
                                    aPlace.cO_8hr = dictArray[num]["CO_8hr"]
                                    aPlace.status = dictArray[num]["Status"]
                                    aPlace.nOx = dictArray[num]["NOx"]
                                    aPlace.publishTime = dictArray[num]["PublishTime"]
                                    aPlace.longitude = dictArray[num]["Longitude"]
                                    aPlace.pollutant = dictArray[num]["Pollutant"]
                                    aPlace.nO = dictArray[num]["NO"]
                                    aPlace.pM25_AVG = dictArray[num]["PM2.5_AVG"]
                                    aPlace.pM25 = dictArray[num]["PM2.5"]
                                    aPlace.cO = dictArray[num]["CO"]
                                    aPlace.windDirec = dictArray[num]["WindDirec"]
                                    aPlace.windSpeed = dictArray[num]["WindSpeed"]
                                    aPlace.pM10 = dictArray[num]["PM10"]
                                    aPlace.county = dictArray[num]["County"]
                                }
                            }
                        } catch {
                            fatalError("\(error)")
                        }
                    }
                    app.saveContext()
                }
            }
        } catch {
            print( error )
        }
    }
}
