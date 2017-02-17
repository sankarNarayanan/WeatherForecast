/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
This file shows how to implement the OperationObserver protocol.
*/

import Foundation

/**
    The `BlockObserver` is a way to attach arbitrary blocks to significant events
    in an `Operation`'s lifecycle.
*/
struct BlockObserver: OperationObserver {
    // MARK: Properties
    
    private let startHandler: ((AppOperation) -> Void)?
    private let produceHandler: ((AppOperation, Operation) -> Void)?
    private let finishHandler: ((AppOperation, [NSError]) -> Void)?
    
    init(startHandler: ((AppOperation) -> Void)? = nil, produceHandler: ((AppOperation, Operation) -> Void)? = nil, finishHandler: ((AppOperation, [NSError]) -> Void)? = nil) {
        self.startHandler = startHandler
        self.produceHandler = produceHandler
        self.finishHandler = finishHandler
    }
    
    // MARK: OperationObserver
    
    func operationDidStart(operation: AppOperation) {
        startHandler?(operation)
    }
    
    func operation(operation: AppOperation, didProduceOperation newOperation: Operation) {
        produceHandler?(operation, newOperation)
    }
    
    func operationDidFinish(operation: AppOperation, errors: [NSError]) {
        finishHandler?(operation, errors)
    }
}
