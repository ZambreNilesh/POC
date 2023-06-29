import UIKit
class ContactsTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let contactView = UINavigationController(rootViewController: ContactListViewController.instantiate())
        let contact = UITabBarItem(title: "REST", image: nil, tag: 1);
        
        contactView.tabBarItem = contact
        
        let roomView = UINavigationController(rootViewController: RoomListViewController.instantiate())
        let room = UITabBarItem(title: "Rooms", image: nil, tag: 2);
        roomView.tabBarItem = room
        
        let controllers = [contactView, roomView]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
           return true;
    }
}
