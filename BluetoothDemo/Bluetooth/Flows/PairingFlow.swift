//
//  BluetoothPairingService.swift
//  BluetoothDemo
//
//  Created by Wojciech Kulik on 21/07/2018.
//  Copyright © 2018 Wojciech Kulik. All rights reserved.
//

import Foundation
import CoreBluetooth

class PairingFlow {
    
    let timeout = 15.0
    var waitForPeripheralHandler: () -> Void = { }
    var pairingHandler: (Bool) -> Void = { _ in }
    var pairingWorkitem: DispatchWorkItem?
    var pairing = false
    
    weak var bluetoothService: BluetoothService?
    
    init(bluetoothService: BluetoothService) {
        self.bluetoothService = bluetoothService
    }

    // MARK: Pairing steps
    
    func waitForPeripheral(completion: @escaping () -> Void) {
        self.pairing = false
        self.pairingHandler = { _ in }
        
        self.bluetoothService?.startScan()
        self.waitForPeripheralHandler = completion
    }
    
    func pair(completion: @escaping (Bool) -> Void) {
        guard self.bluetoothService?.centralManager.state == .poweredOn else {
            print("bluetooth is off")
            self.pairingFailed()
            return
        }
        guard let peripheral = self.bluetoothService?.peripheral else {
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
        self.bluetoothService?.centralManager.connect(peripheral)
    }
    
    func cancel() {
        self.bluetoothService?.stopScan()
        self.bluetoothService?.disconnect()
        self.pairingWorkitem?.cancel()
        
        self.pairing = false
        self.pairingHandler = { _ in }
        self.waitForPeripheralHandler = { }
    }
    
    private func pairingFailed() {
        self.pairingHandler(false)
        self.cancel()
    }
}

// MARK: 3. State handling
extension PairingFlow: FlowController {
    func discoveredPeripheral() {
        self.bluetoothService?.stopScan()
        self.waitForPeripheralHandler()
    }
    
    func readyToWrite() {
        guard self.pairing else { return }
         
        self.bluetoothService?.getSettings() // 4.
    }
    
    func received(response: Data) {
        print("received data: \(String(bytes: response, encoding: String.Encoding.ascii) ?? "")")
        // TODO: validate response to confirm that pairing is sucessful
        self.pairingHandler(true)
        self.cancel()
    }
    
    func disconnected(failure: Bool) {
        self.pairingFailed()
    }
}
