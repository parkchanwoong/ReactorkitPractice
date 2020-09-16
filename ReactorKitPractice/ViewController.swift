//
//  ViewController.swift
//  ReactorKitPractice
//
//  Created by 박찬웅 on 2020/09/16.
//  Copyright © 2020 박찬웅. All rights reserved.
//

import UIKit
import ReactorKit
import RxCocoa

class ViewController: UIViewController, StoryboardView {
    var disposeBag = DisposeBag()


    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    func bind(reactor: ViewControllerReactor) {
        print(#function)

        // Action

        minusButton.rx.tap
            .map{ Reactor.Action.decrease}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        plusButton.rx.tap
            .map { Reactor.Action.increase}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // State
        reactor.state
            .map {"\($0.value)"}
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)

    }


}

