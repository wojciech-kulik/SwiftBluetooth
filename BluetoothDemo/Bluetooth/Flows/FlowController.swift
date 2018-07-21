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
    
    weak var bluetoothSerivce: BluetoothService?
    
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
    
    func received(response: Response) {
    }
}
