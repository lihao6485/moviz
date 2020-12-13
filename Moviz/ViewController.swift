//
//  ViewController.swift
//  Moviz
//
//  Created by Li Hao Lai on 31/10/20.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let service = DiscoverService()
        service.movie()
            .subscribe()
            .disposed(by: disposeBag)

        layout()
    }

    private func layout() {
        title = "Discover"
        view.backgroundColor = .white
    }
}

