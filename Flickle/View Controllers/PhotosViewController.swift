//
//  PhotosViewController.swift
//  Flickle
//
//  Created by Nate Armstrong on 12/10/15.
//  Copyright © 2015 Nate Armstrong. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    let viewModel: PhotosViewModel
    let tableView = UITableView()

    init(viewModel: PhotosViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.query

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 55
        tableView.registerClass(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.wta_reuseableIdentifier())
        view.addSubview(tableView)
        tableView.wta_addEdgeConstraintsToSuperview(UIEdgeInsetsZero)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBarHidden = false
        if let selected = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(selected, animated: true)
        }
    }

}

// MARK: - UITableViewDataSource
extension PhotosViewController: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(PhotoTableViewCell.wta_reuseableIdentifier()) as! PhotoTableViewCell
        cell.viewModel = viewModel.photoViewModel(indexPath)
        return cell
    }

}

// MARK: - UITableViewDelegate
extension PhotosViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let photo = PhotoViewController(viewModel: viewModel.photoViewModel(indexPath))
        navigationController?.pushViewController(photo, animated: true)
    }
}
