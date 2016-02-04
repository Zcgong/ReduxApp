//
//  Redux.swift
//  TestRedux
//
//  Created by Sacha Durand Saint Omer on 29/01/16.
//  Copyright © 2016 s4cha. All rights reserved.
//

import Foundation

protocol State { }

protocol Action { }
typealias ActionCreator = (dispatch:Dispatch) -> Void

var store:Store!

protocol Store {
    func dispatch(action:Action)
    func dispatch(actionCreator:ActionCreator)
    var state:State {get set}
    var reducer:Reducer {get set}
    var stateObservers:[StateObserver] { get }
    func subscribe(observer:StateObserver)
}

protocol Reducer {
    func handleAction(state:State, action:Action) -> State
}

protocol StateObserver {

    func newState(state:State)
//    func dispatch(actionCreator:ActionCreator)
}


//func dispatch(actionCreator:ActionCreator) {
//    actionCreator(dispatch: store.dispatch)
//}



//extension Store {
//
//    mutating func dispatch(action:Action) {
//        state = reducer.handleAction(state, action: action)
//////        refreshState()
//    }
//}

class DefaultStore:Store {
    var state:State
    var reducer:Reducer
    var stateObservers = [StateObserver]()
    
    init(aState:State, aReducer:Reducer) {
        state = aState
        reducer = aReducer
    }
    
    func dispatch(action: Action) {
        state = reducer.handleAction(state, action: action)
        pushStateToStateObserver()
        print(state)
    }
    
    func dispatch(actionCreator:ActionCreator) {
        actionCreator(dispatch: store.dispatch)
    }
    
    func subscribe(observer:StateObserver) {
        stateObservers.append(observer)
        observer.newState(state)
    }

    func unSubscribe(observer:StateObserver) {
//        if let index = stateObservers.indexOf(observer){
//          stateObservers.removeAtIndex(index)
//        }
    }

    func pushStateToStateObserver() {
        for so in stateObservers {
            so.newState(state)   // TODO filter States so.filterState(state))
        }
    }
}

typealias Dispatch = (Action) -> Void


//Helpers

import UIKit

extension StateObserver {
    
    func dispatch(action: Action) {
        store.dispatch(action)
    }
    
    func dispatch(actionCreator:ActionCreator) {
        store.dispatch(actionCreator)
    }
    
    func subscribe(observer:StateObserver) {
        store.subscribe(observer)
    }
}