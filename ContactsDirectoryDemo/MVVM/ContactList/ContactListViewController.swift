//
//  NZPhotoLibraryViewController.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit
import CommonCode
import Downloader

class ContactListViewController: BaseViewController {
    private var people: [PersonModel] = []
    private var contactViewModel: ContactViewModel?
    @IBOutlet var contactTable: UITableView!
    override class var storyboardName: String{ "ContactListViewController"}
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        loadConatcts()
    }
    private func bindViewModel() {
        contactViewModel = ContactViewModel()
        guard let contactViewModel = contactViewModel else { return }
        contactViewModel.startLoading = { [weak self] in
            self?.startLoading()
        }
        contactViewModel.stopLoading = {[weak self] in
            self?.stopLoading()
        }
        contactViewModel.successResponse = { [weak self] in
            guard let self = self else { return }
            self.displayContacts(people: contactViewModel.people)
        }
        contactViewModel.failureResponse = { [weak self] in
            guard let self = self,
                  let photoError = contactViewModel.peopleError else { return }
            self.displayError(title: "Error", message: photoError)
        }
    }
}

extension ContactListViewController {
    func displayContacts(people: [PersonModel]) {
        self.people = people
        contactTable.reloadData()
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            return UITableViewCell();
        }
        cell.setPerson(person: people[indexPath.row])
        return cell;
    }
    
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var detailViews = ContactDetailsViewController.instantiate();
        detailViews.setPerson(person: people[indexPath.row])
        navigationController?.pushViewController(detailViews, animated: true);
    }

}
extension ContactListViewController: UISearchBarDelegate {
    private func loadConatcts() {
        contactViewModel?.loadContacts();
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
        contactViewModel?.loadContacts();
    }
}
