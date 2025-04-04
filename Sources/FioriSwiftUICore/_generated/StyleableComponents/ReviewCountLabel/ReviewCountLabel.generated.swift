// Generated using Sourcery 2.1.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import SwiftUI

public struct ReviewCountLabel {
    let reviewCountLabel: any View

    @Environment(\.reviewCountLabelStyle) var style

    var componentIdentifier: String = ReviewCountLabel.identifier

    fileprivate var _shouldApplyDefaultStyle = true

    public init(@ViewBuilder reviewCountLabel: () -> any View = { EmptyView() },
                componentIdentifier: String? = ReviewCountLabel.identifier)
    {
        self.reviewCountLabel = reviewCountLabel()
        self.componentIdentifier = componentIdentifier ?? ReviewCountLabel.identifier
    }
}

public extension ReviewCountLabel {
    static let identifier = "fiori_reviewcountlabel_component"
}

public extension ReviewCountLabel {
    init(reviewCountLabel: AttributedString? = nil) {
        self.init(reviewCountLabel: { OptionalText(reviewCountLabel) })
    }
}

public extension ReviewCountLabel {
    init(_ configuration: ReviewCountLabelConfiguration) {
        self.init(configuration, shouldApplyDefaultStyle: false)
    }

    internal init(_ configuration: ReviewCountLabelConfiguration, shouldApplyDefaultStyle: Bool) {
        self.reviewCountLabel = configuration.reviewCountLabel
        self._shouldApplyDefaultStyle = shouldApplyDefaultStyle
        self.componentIdentifier = configuration.componentIdentifier
    }
}

extension ReviewCountLabel: View {
    public var body: some View {
        if self._shouldApplyDefaultStyle {
            self.defaultStyle()
        } else {
            self.style.resolve(configuration: .init(componentIdentifier: self.componentIdentifier, reviewCountLabel: .init(self.reviewCountLabel))).typeErased
                .transformEnvironment(\.reviewCountLabelStyleStack) { stack in
                    if !stack.isEmpty {
                        stack.removeLast()
                    }
                }
        }
    }
}

private extension ReviewCountLabel {
    func shouldApplyDefaultStyle(_ bool: Bool) -> some View {
        var s = self
        s._shouldApplyDefaultStyle = bool
        return s
    }

    func defaultStyle() -> some View {
        ReviewCountLabel(.init(componentIdentifier: self.componentIdentifier, reviewCountLabel: .init(self.reviewCountLabel)))
            .shouldApplyDefaultStyle(false)
            .reviewCountLabelStyle(.fiori)
            .typeErased
    }
}
