//
//  NZPhotoLibraryViewController.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit
import CommonCode

class RoomListViewController: BaseViewController {
    private var rooms: [RoomModel] = []
    private var roomViewModel: RoomViewModel?
    @IBOutlet var roomTable: UITableView!
    override class var storyboardName: String{ "RoomListViewController"}
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        loadRooms()
    }
    private func bindViewModel() {
        roomViewModel = RoomViewModel()
        guard let roomViewModel = roomViewModel else { return }
        roomViewModel.startLoading = { [weak self] in
            self?.startLoading()
        }
        roomViewModel.stopLoading = {[weak self] in
            self?.stopLoading()
        }
        roomViewModel.successResponse = { [weak self] in
            guard let self = self else { return }
            self.displayRooms(rooms: roomViewModel.rooms);
        }
        roomViewModel.failureResponse = { [weak self] in
            guard let self = self,
                  let photoError = roomViewModel.roomsError else { return }
            self.displayError(title: "Error", message: photoError)
        }
    }
}

extension RoomListViewController {
    func displayRooms(rooms: [RoomModel]) {
        self.rooms = rooms
        print("displayRooms \(rooms)");
        roomTable.reloadData()
    }
}

extension RoomListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as? RoomCell else {
            return UITableViewCell();
        }
        cell.setRoom(room: rooms[indexPath.row]);
        return cell;
    }
    
}

extension RoomListViewController: UITableViewDelegate { }
extension RoomListViewController: UISearchBarDelegate {
    private func loadRooms() {
        roomViewModel?.loadRooms();
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
        roomViewModel?.loadRooms();
    }
}
