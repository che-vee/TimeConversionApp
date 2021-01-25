//
//  ContentView.swift
//  TimeConversionApp
//
//  Created by Chepkorir Lang'at on 24/01/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var timeAmount = ""
    @State private var convertTo = 1
    @State private var convertFrom = 0
    
    let timeUnits = ["Seconds", "Minutes", "Hours", "Days"]
    
    var timeInSeconds: Double {
        let totalUnit = Double(timeAmount) ?? 0
        
        switch convertFrom {
        case 0:
            return totalUnit
        case 1:
            let setMinutes = Measurement(value: totalUnit, unit: UnitDuration.minutes)
            return setMinutes.converted(to: UnitDuration.seconds).value
        case 2:
            let setHours = Measurement(value: totalUnit, unit: UnitDuration.hours)
            return setHours.converted(to: UnitDuration.seconds).value
        case 3:
            return totalUnit * 86400
        default:
            return totalUnit
        }
    }
    
    var timeConversion: Double {
        let baseUnit = Measurement(value: timeInSeconds, unit: UnitDuration.seconds)
        
        switch convertTo {
        case 0:
            return baseUnit.value
        case 1:
            return baseUnit.converted(to: UnitDuration.minutes).value
        case 2:
            return baseUnit.converted(to: UnitDuration.hours).value
        case 3:
            return timeInSeconds / 86400
        default:
            return baseUnit.value
        }

    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert From") ) {
                    TextField("Enter \(timeUnits[convertFrom])", text: $timeAmount)
                        .keyboardType(.numberPad)
                    
                    Picker("Convert from", selection: $convertFrom) {
                        ForEach(0..<timeUnits.count) {
                            Text("\(self.timeUnits[$0])")
                            
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Section(header: Text("Convert To")) {
                    Picker("Convert from", selection: $convertTo) {
                        ForEach(0..<timeUnits.count) {
                            Text("\(self.timeUnits[$0])")
                            
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                
                    Text("\(timeConversion, specifier: "%.2f") \(timeUnits[convertTo])")
                    
                }
            }
            .navigationBarTitle("Time Converter")
        }
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
