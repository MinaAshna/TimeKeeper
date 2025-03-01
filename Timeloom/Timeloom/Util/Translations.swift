import SwiftUI

enum Translations {
    case allEventsNavigationTitle
    case eventDetailsTitle
    case eventDetailsEndDate
    case addEvent
    case saveEvent
    case deleteEvent
    case editEvent
    case cancelEvent
    case endDateError
    case countdownYear
    case countdownMonth
    case countdownDay
    case countdownHour
    case countdownMinute
    case countdownSecond
    case accessibilityAddNewEvent
    case ongoingEvents
    case pastEvents
    case eventDetailsTitlePlaceholder
    case eventDetailsEndDatePlaceholder
    
    var localizedKey: LocalizedStringKey {
        switch self {
        case .allEventsNavigationTitle:
            localizedString(key: "all_events_navigation_title")
        case .eventDetailsTitle:
            localizedString(key: "event_details_title")
        case .eventDetailsEndDate:
            localizedString(key: "event_details_end_date")
        case .addEvent:
            localizedString(key: "add_event")
        case .saveEvent:
            localizedString(key: "save_event")
        case .deleteEvent:
            localizedString(key: "delete_event")
        case .cancelEvent:
            localizedString(key: "cancel_event")
        case .endDateError:
            localizedString(key: "end_date_error")
        case .countdownYear:
            localizedString(key: "countdown_year")
        case .countdownMonth:
            localizedString(key: "countdown_month")
        case .countdownDay:
            localizedString(key: "countdown_day")
        case .countdownHour:
            localizedString(key: "countdown_hour")
        case .countdownMinute:
            localizedString(key: "countdown_minute")
        case .countdownSecond:
            localizedString(key: "countdown_second")
        case .accessibilityAddNewEvent:
            localizedString(key: "accessibility_add_new_event")
        case .ongoingEvents:
            localizedString(key: "ongoing_events")
        case .pastEvents:
            localizedString(key: "past_events")
        case .editEvent:
            localizedString(key: "edit_event")
        case .eventDetailsTitlePlaceholder:
            localizedString(key: "event_details_title_placeholder")
        case .eventDetailsEndDatePlaceholder:
            localizedString(key: "event_details_end_date_placeholder")
            
        }
    }
    
    private func localizedString(key: String) -> LocalizedStringKey {
        LocalizedStringKey(key)
    }
}
