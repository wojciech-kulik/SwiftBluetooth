//
//  BluetoothPairingService.swift
//  BluetoothDemo
//
//  Created by Wojciech Kulik on 21/07/2018.
//  Copyright © 2018 Wojciech Kulik. All rights reserved.
//

import Foundation
import CoreBluetooth

class PairingFlow: FlowController {
    
    let timeout = 15.0
    var waitForPeripheralHandler: () -> Void = { }
    var pairingHandler: (Bool) -> Void = { _ in }
    var pairingWorkitem: DispatchWorkItem?
    var pairing = false

    // MARK: 1. Pairing steps
    
    func waitForPeripheral(completion: @escaping () -> Void) {
        self.pairing = false
        self.pairingHandler = { _ in }
        
        self.bluetoothSerivce?.startScan()
        self.waitForPeripheralHandler = completion
    }
    
    func pair(completion: @escaping (Bool) -> Void) {
        guard self.bluetoothSerivce?.centralManager.state == .poweredOn else {
            print("bluetooth is off")
            self.pairingFailed()
            return
        }
        guard let peripheral = self.bluetoothSerivce?.peripheral else {
            print("peripheral not found")
            self.pairingFailed()
            return
        }
        
        self.pairing = true
        self.pairingWorkitem = DispatchWorkItem { // 2.
            print("pairing timed out")
            self.pairingFailed()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + self.timeout, execute: self.pairingWorkitem!) // 2.
        
        print("pairing...")
        self.pairingHandler = completion
        self.bluetoothSerivce?.centralManager.connect(peripheral)
    }
    
    func cancel() {
        self.bluetoothSerivce?.stopScan()
        self.bluetoothSerivce?.disconnect()
        self.pairingWorkitem?.cancel()
        
        self.pairing = false
        self.pairingHandler = { _ in }
        self.waitForPeripheralHandler = { }
    }
    
    // MARK: 3. State handling
    
    override func discoveredPeripheral() {
        self.bluetoothSerivce?.stopScan()
        self.waitForPeripheralHandler()
    }
    
    override func readyToWrite() {
        guard self.pairing else { return }
         
        self.bluetoothSerivce?.getSettings() // 4.
    }
    
    override func received(response: Data) {
        print("received data: \(String(bytes: response, encoding: String.Encoding.ascii) ?? "")")
        // TODO: validate response to confirm that pairing is sucessful
        self.pairingHandler(true)
        self.cancel()
    }
    
    override func disconnected(failure: Bool) {
        self.pairingFailed()
    }
    
    private func pairingFailed() {
        self.pairingHandler(false)
        self.cancel()
    }
}
