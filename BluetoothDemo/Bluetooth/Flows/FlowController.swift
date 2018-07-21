//
//  BluetoothBase.swift
//  BluetoothDemo
//
//  Created by Wojciech Kulik on 21/07/2018.
//  Copyright © 2018 Wojciech Kulik. All rights reserved.
//

import Foundation
import CoreBluetooth

class FlowController {
    
    weak var bluetoothSerivce: BluetoothService? // 1.
    
    init(bluetoothSerivce: BluetoothService) {
        self.bluetoothSerivce = bluetoothSerivce
    }

    func bluetoothOn() {
    }
    
    func bluetoothOff() {
    }
    
    func scanStarted() {
    }
    
    func scanStopped() {
    }
    
    func connected(peripheral: CBPeripheral) {
    }
    
    func disconnected(failure: Bool) {
    }
    
    func discoveredPeripheral() {
    }
    
    func readyToWrite() {
    }
    
    func received(response: Data) {
    }
    
    // TODO: add other events if needed
}
