//
//  BluetoothService.swift
//  BluetoothDemo
//
//  Created by Wojciech Kulik on 21/07/2018.
//  Copyright © 2018 Wojciech Kulik. All rights reserved.
//

import UIKit
import CoreBluetooth

class BluetoothService: NSObject { // 1.
    
    // 2.
    let dataServiceUuid = "180A"
    let dataCharacteristicUuid = "2A29"
    
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral?
    var dataCharacteristic: CBCharacteristic?
    var bluetoothState: CBManagerState {
        return self.centralManager.state
    }
    var flowController: FlowController? // 3.
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScan() {
        self.peripheral = nil
        guard self.centralManager.state == .poweredOn else { return }

        self.centralManager.scanForPeripherals(withServices: []) // 4.
        self.flowController?.scanStarted() // 5.
        print("scan started")
    }
    
    func stopScan() {
        self.centralManager.stopScan()
        self.flowController?.scanStopped() // 5.
        print("scan stopped\n")
    }
    
    func connect() {
        guard self.centralManager.state == .poweredOn else { return }
        guard let peripheral = self.peripheral else { return }
        self.centralManager.connect(peripheral)
    }
    
    func disconnect() {
        guard let peripheral = self.peripheral else { return }
        self.centralManager.cancelPeripheralConnection(peripheral)
    }
}
