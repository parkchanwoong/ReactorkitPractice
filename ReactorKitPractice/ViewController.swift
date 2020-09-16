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
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    func bind(reactor: ViewControllerReactor) {
        print(#function)

        // Action

        minusButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .map{ Reactor.Action.decrease}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        plusButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { Reactor.Action.increase}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        // State
        reactor.state
            .map {"\($0.value)"}
            .distinctUntilChanged()
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)

        reactor.state
            .map {$0.isLoading}
            .distinctUntilChanged()
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)

    }


}

