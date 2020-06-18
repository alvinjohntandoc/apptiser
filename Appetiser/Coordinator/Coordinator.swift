//
//  Coordinator.swift
//  Appetiser
//
//  Created by Alvin John Garcia Tandoc on 17/06/2020.
//  Copyright © 2020 Appetiser. All rights reserved.
//


import Foundation
import UIKit
import RxSwift

public protocol Coordinator: class {
	/// This will be the root controller
	var navigationController: UINavigationController { get set }
	
    /// Strong reference of child coordinators
    var childCoordinators: [Coordinator] { get set }
    
    /// This will emit if the coordinator want's to be dismissed
	var wantsToDismiss: Observable<Void> { get }
	
    /// Start the flow of the coordinator
	func start()
	
    /// Will remove child coordinator to childCoordinators array
	func removeChildCoordinator(_ coordinator: Coordinator)
	
    /// Will append child coordinator to childCoordinators array
	func addChildCoordinator(_ coordinator: Coordinator)
}

extension Coordinator {
	
    // overriadable
	public func start() {}
	
	public func removeChildCoordinator(_ coordinator: Coordinator) {
		for (index, element) in childCoordinators.enumerated() where element === coordinator {
			childCoordinators.remove(at: index)
			break
		}
	}
	
	public func addChildCoordinator(_ coordinator: Coordinator) {
		for (_, element) in childCoordinators.enumerated()
			where element === coordinator { return }
		
		childCoordinators.append(coordinator)
	}
	
}

