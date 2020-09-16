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
            return Observable.just(Mutation.increaseValue)

        case .decrease:
            return Observable.just(Mutation.decreaseValue)
        }
    }

    enum Mutation {
        case increaseValue
        case decreaseValue
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        }
        return newState
    }

    struct State {
        var value = 0
    }

    let initialState: State = State()


}
