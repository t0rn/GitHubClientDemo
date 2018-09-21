//
//  TableViewDataSource.swift
//  SimpleGithubClient
//
//  Created by Alexey Ivanov on 17.09.2018.
//  Copyright © 2018 Alexey Ivanov. All rights reserved.
//

import UIKit


class TableViewDataSource<Model, Cell> : NSObject, UITableViewDataSource where Cell: UITableViewCell & ReusableCell & CellConfigurable, Model == Cell.Controller {
    
    var dataSource: [Model] = [] {
        didSet { tableView.reloadData() }
    }
    
    private unowned var tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        
        tableView.registerReusableCell(Cell.self)
    }
    
    func object(at indexPath:IndexPath) -> Model? {
        guard indexPath.row < dataSource.count else {return nil}
        return dataSource[indexPath.row]
    }
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        cell.cellController = object(at: indexPath)
        return cell
    }

}


