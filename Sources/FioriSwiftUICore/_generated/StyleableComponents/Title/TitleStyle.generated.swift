// Generated using Sourcery 2.1.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import FioriThemeManager
import Foundation
import SwiftUI

public protocol TitleStyle: DynamicProperty {
    associatedtype Body: View

    func makeBody(_ configuration: TitleConfiguration) -> Body
}

struct AnyTitleStyle: TitleStyle {
    let content: (TitleConfiguration) -> any View

    init(@ViewBuilder _ content: @escaping (TitleConfiguration) -> any View) {
        self.content = content
    }

    public func makeBody(_ configuration: TitleConfiguration) -> some View {
        self.content(configuration).typeErased
    }
}

public struct TitleConfiguration {
    public let titleIdentifier = "FioriTitle_title"

    public let title: Title

    public typealias Title = ConfigurationViewWrapper
}
