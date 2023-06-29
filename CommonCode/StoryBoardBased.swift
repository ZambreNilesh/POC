//
//  StoryBoardBased.swift
//  NZImageDemo
//
//  Created by Nilesh Zambre on 23/12/21.
//  Copyright © 2021 Nilesh Zambre. All rights reserved.
//

import UIKit

public protocol StoryBoardBased {
    static var sceneStoryboard: UIStoryboard { get }
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle { get }
    static var sceneIdentifier: String { get }
}
public extension StoryBoardBased {
    static var sceneStoryboard: UIStoryboard { UIStoryboard(name: storyboardName, bundle: storyboardBundle) }
    static var storyboardBundle: Bundle { Bundle(for: self as! AnyClass) }
    static var sceneIdentifier: String { String(describing: self) }
}
public extension StoryBoardBased {
    static func instantiate()-> Self {
        let viewController = sceneStoryboard.instantiateViewController(identifier: sceneIdentifier)
        guard let typedViewController = viewController as? Self else {
            fatalError("The viewcontroller '\(sceneIdentifier)' of  '\(sceneStoryboard)' is not class'")
        }
        return typedViewController
    }
}
