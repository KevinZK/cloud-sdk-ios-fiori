// Generated using Sourcery 2.1.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import SwiftUI

/// `CheckoutIndicator` provides a circular indicator that shows the state of a process.
///
/// ## Usage
/// ```swift
/// @State var displayState = DisplayState.inProgress
///
/// CheckoutIndicator(displayState: self.$displayState)
/// ```
public struct CheckoutIndicator {
    /// The current state of this view. Changing this property will result in a different icon and view.
    @Binding var displayState: DisplayState

    @Environment(\.checkoutIndicatorStyle) var style

    fileprivate var _shouldApplyDefaultStyle = true

    public init(displayState: Binding<DisplayState>) {
        self._displayState = displayState
    }
}

public extension CheckoutIndicator {
    init(_ configuration: CheckoutIndicatorConfiguration) {
        self.init(configuration, shouldApplyDefaultStyle: false)
    }

    internal init(_ configuration: CheckoutIndicatorConfiguration, shouldApplyDefaultStyle: Bool) {
        self._displayState = configuration.$displayState
        self._shouldApplyDefaultStyle = shouldApplyDefaultStyle
    }
}

extension CheckoutIndicator: View {
    public var body: some View {
        if self._shouldApplyDefaultStyle {
            self.defaultStyle()
        } else {
            self.style.resolve(configuration: .init(displayState: self.$displayState)).typeErased
                .transformEnvironment(\.checkoutIndicatorStyleStack) { stack in
                    if !stack.isEmpty {
                        stack.removeLast()
                    }
                }
        }
    }
}

private extension CheckoutIndicator {
    func shouldApplyDefaultStyle(_ bool: Bool) -> some View {
        var s = self
        s._shouldApplyDefaultStyle = bool
        return s
    }

    func defaultStyle() -> some View {
        CheckoutIndicator(.init(displayState: self.$displayState))
            .shouldApplyDefaultStyle(false)
            .checkoutIndicatorStyle(.fiori)
            .typeErased
    }
}