import FioriSwiftUICore
import SwiftUI

struct _DurationPickerExample: View {
    @State var selection1: Int = 0
    @State var selection2: Int = 244
    @State var selection3: Int = 100

    var formatter: MeasurementFormatter {
        let formatter = MeasurementFormatter()
        formatter.locale = Locale(identifier: "zh-CN")
        formatter.unitStyle = .long
        formatter.unitOptions = .providedUnit
        return formatter
    }
    
    var body: some View {
        VStack {
            _DurationPicker(selection: self.$selection1)
            Divider()
            Text("Total \(self.selection1) minutes")
            Text("\(self.selection1 / 60) Hrs, \(self.selection1 % 60) Min")
            
            _DurationPicker(selection: self.$selection2, minimumMinutes: 1, minuteInterval: 2)
            Divider()
            Text("Total \(self.selection2) minutes")
            
            _DurationPicker(selection: self.$selection3, maximumMinutes: 505, minimumMinutes: 60, minuteInterval: 2)
                .measurementFormatter(self.formatter)
            Divider()
            Text("Total \(self.selection3) minutes")
        }
    }
}

struct _DurationPickerExample_Previews: PreviewProvider {
    static var previews: some View {
        _DurationPickerExample()
    }
}
