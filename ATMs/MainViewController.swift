//
//  ViewController.swift
//  ATMs
//
//  Created by Karina Kovaleva on 26.12.22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private lazy var listVC = ListViewController()
    private lazy var mapVC = MapViewController()

    private lazy var segmentedControl: UISegmentedControl = {
        var segmentedControl = UISegmentedControl(items: ["Map", "List"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .systemGreen
        segmentedControl.addTarget(self, action: #selector(changeSegmentedControlValue), for: .valueChanged)
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupSegmentedControl()
        updateViewControllers()
    }

    private func setupSegmentedControl() {
        self.view.addSubview(segmentedControl)

        segmentedControl.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }

    @objc private func changeSegmentedControlValue() {
        updateViewControllers()
    }

    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)

        viewController.view.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.segmentedControl.snp.bottom).offset(5)
        }

        viewController.didMove(toParent: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    private func updateViewControllers() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: listVC)
            add(asChildViewController: mapVC)
        } else {
            remove(asChildViewController: mapVC)
            add(asChildViewController: listVC)
        }
    }
}
