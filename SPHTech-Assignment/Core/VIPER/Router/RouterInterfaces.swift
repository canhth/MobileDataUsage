//
//  RouterInterface.swift
//  Apollo
//
//  Created by Canh Tran Wizeline on 4/20/20.
//  Copyright © 2020 CanhTran. All rights reserved.
//

import UIKit

// MARK: - Normal View Router

/// Handle normal UIViewController as root, with present & dismiss
public protocol ViewRouterInterface: ViewInterface {
    func present(_ view: ViewInterface, animated: Bool, completion: (() -> Void)?)
    func dismissView(animated: Bool, completion: (() -> Void)?)

    func showAlert(title: String?, message: String, actions: [UIAlertAction])
}

extension ViewRouterInterface {

    func present(_ view: ViewInterface, animated: Bool, completion: (() -> Void)? = nil) {
        toController().present(view.toController(), animated: animated, completion: completion)
    }

    func dismissView(animated: Bool, completion: (() -> Void)? = nil) {
        toController().dismiss(animated: animated, completion: completion)
    }

    // MARK: - Alert

    func showAlert(title: String? = nil, message: String, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // Need at least 1 action to dismiss the alert
        if actions.isEmpty {
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
        } else {
            actions.forEach { alertController.addAction($0) }
        }
        present(alertController, animated: true)
    }
}

// MARK: - Navigation Router

/// Handle UINavigationController as root, with push & pop
public protocol NavigationRouterInterface: ViewRouterInterface {
    func toController() -> UINavigationController

    func push(_ view: ViewInterface, animated: Bool, hideBottomBar: Bool?, popCompletion: (() -> Void)?)
    func popView(animated: Bool)

    func setRootView(_ view: ViewInterface, animated: Bool, hideNavigationBar: Bool?)
}

extension NavigationRouterInterface {
    func push(_ view: ViewInterface, animated: Bool, hideBottomBar: Bool? = nil, popCompletion: (() -> Void)? = nil) {
        push(view, animated: animated, hideBottomBar: hideBottomBar, popCompletion: popCompletion)
    }

    func setRootView(_ view: ViewInterface, animated: Bool, hideNavigationBar: Bool? = nil) {
        setRootView(view, animated: animated, hideNavigationBar: hideNavigationBar)
    }
}
