//
//  CarListViewController.swift
//  CarСatalog
//
//  Created by Yaroslav Surovtsev on 11.07.17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class CarListViewController: UIViewController {

    @IBOutlet private(set) weak var carListTableView: UITableView! {
        didSet {
            carListTableView.dataSource = self
            carListTableView.delegate = self
        }
    }
    
    static let addNewCarSegueID = "addNewCarSegueID"
    var carList: [Car] = []
    
    private(set) lazy var dateFormat: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.dateStyle = .medium
        return dateFormat
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        addSampleList()
    }
    
    private func registerCells() {
        carListTableView.register(UINib(nibName: CarCell.identifier, bundle: nil),
                                  forCellReuseIdentifier: CarCell.identifier)
    }
    
    private func addSampleList() {
        struct Info {
            let brand: String
            let model: String
            let date: String
        }
        
        var defaultData: [Info] = []
        defaultData.append(Info(brand: "Tesla",
                                model: "Model S",
                                date: "May 17, 2012"))
        defaultData.append(Info(brand: "Tesla",
                                model: "Model X",
                                date: "Jul 13, 2013"))
        
        for element in defaultData {
            dateFormat.date(from: element.date).flatMap {
                carList.append(Car(brand: element.brand,
                                   model: element.model,
                                   releaseDate: $0))
            }
        }
    }
    
    @IBAction func onTouchAddNewCar(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: CarListViewController.addNewCarSegueID,
                     sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! AddNewCarViewController
        nextViewController.delegate = self
        if let indexPath = carListTableView.indexPathForSelectedRow {
            nextViewController.carForEdit = carList[indexPath.row]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let row = carListTableView.indexPathForSelectedRow {
            self.carListTableView.deselectRow(at: row, animated: true)
        }
    }
    
}

extension CarListViewController: AddNewCarDelegate {
    
    func onCreatedNew(car: Car) {
        carList.append(car)
        refreshList()
    }
    
    func refreshList() {
        carListTableView.reloadData()
    }
    
}

extension CarListViewController: UITableViewDataSource { }

extension CarListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarCell.identifier,
                                                 for: indexPath) as! CarCell
        let car = carList[indexPath.row]
        let _ = CarCellConfigurator(view: cell, model: car)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: CarListViewController.addNewCarSegueID,
                     sender: nil)
    }
    
}





