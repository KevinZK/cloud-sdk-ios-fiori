// Generated using Sourcery 2.1.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import Foundation
import SwiftUI

public struct CancelAction {
    let cancelAction: any View

    @Environment(\.cancelActionStyle) var style

    var componentIdentifier: String = CancelAction.identifier

    fileprivate var _shouldApplyDefaultStyle = true

    public init(@ViewBuilder cancelAction: () -> any View = { FioriButton { _ in Text("Cancel".localizedFioriString()) } },
                componentIdentifier: String? = CancelAction.identifier)
    {
        self.cancelAction = cancelAction()
        self.componentIdentifier = componentIdentifier ?? CancelAction.identifier
    }
}

public extension CancelAction {
    static let identifier = "fiori_cancelaction_component"
}

public extension CancelAction {
    init(cancelAction: FioriButton? = FioriButton { _ in Text("Cancel".localizedFioriString()) }) {
        self.init(cancelAction: { cancelAction })
    }
}

public extension CancelAction {
    init(_ configuration: CancelActionConfiguration) {
        self.init(configuration, shouldApplyDefaultStyle: false)
    }

    internal init(_ configuration: CancelActionConfiguration, shouldApplyDefaultStyle: Bool) {
        self.cancelAction = configuration.cancelAction
        self._shouldApplyDefaultStyle = shouldApplyDefaultStyle
        self.componentIdentifier = configuration.componentIdentifier
    }
}

extension CancelAction: View {
    public var body: some View {
        if self._shouldApplyDefaultStyle {
            self.defaultStyle()
        } else {
            self.style.resolve(configuration: .init(componentIdentifier: self.componentIdentifier, cancelAction: .init(self.cancelAction))).typeErased
                .transformEnvironment(\.cancelActionStyleStack) { stack in
                    if !stack.isEmpty {
                        stack.removeLast()
                    }
                }
        }
    }
}

private extension CancelAction {
    func shouldApplyDefaultStyle(_ bool: Bool) -> some View {
        var s = self
        s._shouldApplyDefaultStyle = bool
        return s
    }

    func defaultStyle() -> some View {
        CancelAction(.init(componentIdentifier: self.componentIdentifier, cancelAction: .init(self.cancelAction)))
            .shouldApplyDefaultStyle(false)
            .cancelActionStyle(.fiori)
            .typeErased
    }
}
