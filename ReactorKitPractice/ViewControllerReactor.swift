//
//  ViewControllerReactor.swift
//  ReactorKitPractice
//
//  Created by 박찬웅 on 2020/09/16.
//  Copyright © 2020 박찬웅. All rights reserved.
//

import Foundation
import ReactorKit

class ViewControllerReactor: Reactor {

    enum Action {
        case increase
        case decrease
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([Observable.just(Mutation.setLoading(true)),
                                      Observable.just(Mutation.increaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                                      Observable.just(Mutation.setLoading(false))])

        case .decrease:
            return Observable.concat([Observable.just(Mutation.setLoading(true)),
                                      Observable.just(Mutation.decreaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                                      Observable.just(Mutation.setLoading(false))])
        }
    }

    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let loading):
            newState.isLoading = loading
        }
        return newState
    }

    struct State {
        var value = 0
        var isLoading = false
    }

    let initialState: State = State()


}
