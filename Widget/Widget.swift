//
//  Widget.swift
//  Widget
//
//  Created by Benjamin Surrey on 24.09.23.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        //SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
        
        SimpleEntry(date: Date(), counter: .demo)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        //SimpleEntry(date: Date(), configuration: configuration)
        
        SimpleEntry(date: Date(), counter: .demo)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            //let entry = SimpleEntry(date: entryDate, configuration: configuration)
            
            let entry = SimpleEntry(date: entryDate, counter: .black)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    // let configuration: ConfigurationAppIntent
    
    let counter: Counter
}

struct WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {

            Text("Name")
                .font(.caption)
            
            Spacer()

            Text("1234")
                .font(.largeTitle)
            
            Spacer()
            
            HStack(alignment: .bottom) {
                Button(action: decrease) {
                    Text("-")
                        .font(.headline)
                        .frame( minWidth: 0, maxWidth: .infinity)
                        .clipShape(Rectangle())
                        .cornerRadius(16)
                        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                }
                .font(.largeTitle)

                
                Button(action: increase) {
                    Text("+")
                        .font(.headline)
                        .frame( minWidth: 0, maxWidth: .infinity)
                        //.foregroundColor(primaryColor.accessibleFontColor)
                }
                .cornerRadius(0)
                .clipShape(Rectangle())
                .aspectRatio(CGSize(width: 7, height: 3), contentMode: .fit)


            }
        }
        //.frame(maxHeight: 100)
        //.padding(.horizontal)
        //.font(.system(size: 28, weight: .light, design: .default))
        
        
        /*
        Text("Time:")
        Text(entry.date, style: .time)

        Text("Favorite Emoji:")
        Text(entry.configuration.favoriteEmoji)
         */
    }
    
    func increase() {}
    func decrease() {}
}

struct Widget: SwiftUI.Widget {
    let kind: String = "Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    Widget()
} timeline: {
    //SimpleEntry(date: .now, configuration: .smiley)
    //SimpleEntry(date: .now, configuration: .starEyes)
    
    SimpleEntry(date: Date(), counter: .demo)
}
