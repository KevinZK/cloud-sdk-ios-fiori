// Generated using Sourcery 2.1.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
//TODO: Copy commented code to new file: `FioriSwiftUICore/Views/_InfoView+View.swift`
//TODO: Implement default Fiori style definitions as `ViewModifier`
//TODO: Implement _InfoView `View` body
//TODO: Implement LibraryContentProvider

/// - Important: to make `@Environment` properties (e.g. `horizontalSizeClass`), internally accessible
/// to extensions, add as sourcery annotation in `FioriSwiftUICore/Models/ModelDefinitions.swift`
/// to declare a wrapped property
/// e.g.:  `// sourcery: add_env_props = ["horizontalSizeClass"]`

/*
import SwiftUI

// FIXME: - Implement Fiori style definitions

extension Fiori {
    enum _InfoView {
        typealias Title = EmptyModifier
        typealias TitleCumulative = EmptyModifier
		typealias DescriptionText = EmptyModifier
        typealias DescriptionTextCumulative = EmptyModifier
		typealias Action = EmptyModifier
        typealias ActionCumulative = EmptyModifier
		typealias SecondaryAction = EmptyModifier
        typealias SecondaryActionCumulative = EmptyModifier

        // TODO: - substitute type-specific ViewModifier for EmptyModifier
        /*
            // replace `typealias Subtitle = EmptyModifier` with:

            struct Subtitle: ViewModifier {
                func body(content: Content) -> some View {
                    content
                        .font(.body)
                        .foregroundColor(.preferredColor(.primary3))
                }
            }
        */
        static let title = Title()
		static let descriptionText = DescriptionText()
		static let action = Action()
		static let secondaryAction = SecondaryAction()
        static let titleCumulative = TitleCumulative()
		static let descriptionTextCumulative = DescriptionTextCumulative()
		static let actionCumulative = ActionCumulative()
		static let secondaryActionCumulative = SecondaryActionCumulative()
    }
}

// FIXME: - Implement _InfoView View body

extension _InfoView: View {
    public var body: some View {
        <# View body #>
    }
}

// FIXME: - Implement _InfoView specific LibraryContentProvider

@available(iOS 14.0, macOS 11.0, *)
struct _InfoViewLibraryContent: LibraryContentProvider {
    @LibraryContentBuilder
    var views: [LibraryItem] {
        LibraryItem(_InfoView(model: LibraryPreviewData.Person.laurelosborn),
                    category: .control)
    }
}
*/
