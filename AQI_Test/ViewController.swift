//
//  ViewController.swift
//  AQI_Test
//
//  Created by 葉育彰 on 2019/6/14.
//  Copyright © 2019 葉育彰. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var networkController: NetworkController?
    var arr = [AQI]()
    var fetchedResultsController: NSFetchedResultsController<AQI>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.networkController = appDelegate.networkController
        }

        guard let networkController = networkController else { return }
        fetchedResultsController = networkController.requestMyData()
        networkController.fetchResultsController.delegate = self

        if let fetchedObjects = fetchedResultsController.fetchedObjects {
            arr = fetchedObjects as [AQI]
        } else {
            print("nothing in fetchedObjects")
        }

    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndex = newIndexPath {
                tableView.insertRows(at: [newIndex], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        if let fetchedObjects = fetchedResultsController.fetchedObjects {
            arr = fetchedObjects as [AQI]
        } else {
            print("nothing in fetchedObjects")
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row].siteName
        return cell
    }

}
