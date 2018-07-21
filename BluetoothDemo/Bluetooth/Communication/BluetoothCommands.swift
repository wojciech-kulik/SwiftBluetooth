//
//  BluetoothCommands.swift
//  BluetoothDemo
//
//  Created by Wojciech Kulik on 21/07/2018.
//  Copyright © 2018 Wojciech Kulik. All rights reserved.
//

import Foundation
import CoreBluetooth

extension BluetoothService {
    
    func getSettings() {
        self.peripheral?.readValue(for: self.dataCharacteristic!)
    }
    
    // TODO: add other methods to expose high level requests to peripheral
}
