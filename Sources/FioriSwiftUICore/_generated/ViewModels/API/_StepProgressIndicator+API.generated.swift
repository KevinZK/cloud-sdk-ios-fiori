// Generated using Sourcery 2.1.7 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
import SwiftUI

public struct _StepProgressIndicator<Title: View, ActionView: View, Steps: IndexedViewContainer, CancelActionView: View> {
    @Environment(\.titleModifier) private var titleModifier
	@Environment(\.actionModifier) private var actionModifier
	@Environment(\.cancelActionModifier) private var cancelActionModifier
	@Environment(\.presentationMode) var presentationMode

    var _selection: Binding<String>
	let _title: Title
	let _action: ActionView
	let _steps: Steps
	let _cancelAction: CancelActionView
	@State var scrollBounds: CGRect = .zero
	var axis: Axis = .horizontal
	var stepItems: [StepItem] = []
	@State var isPresented: Bool = false
	@State var stepFrames: [String: CGRect] = [:]

    private var isModelInit: Bool = false
	private var isTitleNil: Bool = false
	private var isActionNil: Bool = false
	private var isCancelActionNil: Bool = false

    public init(
        selection: Binding<String>,
		@ViewBuilder title: () -> Title,
		@ViewBuilder action: () -> ActionView,
		@IndexedViewBuilder steps: () -> Steps,
		@ViewBuilder cancelAction: () -> CancelActionView
        ) {
            self._selection = selection
			self._title = title()
			self._action = action()
			self._steps = steps()
			self._cancelAction = cancelAction()
    }

    @ViewBuilder var title: some View {
        if isModelInit {
            _title.modifier(titleModifier.concat(Fiori._StepProgressIndicator.title).concat(Fiori._StepProgressIndicator.titleCumulative))
        } else {
            _title.modifier(titleModifier.concat(Fiori._StepProgressIndicator.title))
        }
    }
	@ViewBuilder var action: some View {
        if isModelInit {
            _action.modifier(actionModifier.concat(Fiori._StepProgressIndicator.action).concat(Fiori._StepProgressIndicator.actionCumulative))
        } else {
            _action.modifier(actionModifier.concat(Fiori._StepProgressIndicator.action))
        }
    }
	var steps: Steps {
        _steps
    }
	@ViewBuilder var cancelAction: some View {
        if isModelInit {
            _cancelAction.modifier(cancelActionModifier.concat(Fiori._StepProgressIndicator.cancelAction).concat(Fiori._StepProgressIndicator.cancelActionCumulative))
        } else {
            _cancelAction.modifier(cancelActionModifier.concat(Fiori._StepProgressIndicator.cancelAction))
        }
    }
    
	var isTitleEmptyView: Bool {
        ((isModelInit && isTitleNil) || Title.self == EmptyView.self) ? true : false
    }

	var isActionEmptyView: Bool {
        ((isModelInit && isActionNil) || ActionView.self == EmptyView.self) ? true : false
    }

	var isCancelActionEmptyView: Bool {
        ((isModelInit && isCancelActionNil) || CancelActionView.self == EmptyView.self) ? true : false
    }
}

extension _StepProgressIndicator where Title == _ConditionalContent<Text, EmptyView>,
		ActionView == _ConditionalContent<_Action, EmptyView>,
		Steps == _StepsContainer,
		CancelActionView == _ConditionalContent<_Action, EmptyView> {

    public init(model: _StepProgressIndicatorModel) {
        self.init(selection: Binding<String>(get: { model.selection }, set: { model.selection = $0 }), title: model.title, action: model.action != nil ? _Action(model: model.action!) : nil, steps: model.steps, cancelAction: model.cancelAction != nil ? _Action(model: model.cancelAction!) : nil)
    }

    public init(selection: Binding<String>, title: String? = nil, action: _Action? = _Action(model: _AllStepsActionDefault()), steps: [_SingleStepModel] = [], cancelAction: _Action? = _Action(model: _CancelActionDefault())) {
        self._selection = selection
		self._title = title != nil ? ViewBuilder.buildEither(first: Text(title!)) : ViewBuilder.buildEither(second: EmptyView())
		self._action = action != nil ? ViewBuilder.buildEither(first: action!) : ViewBuilder.buildEither(second: EmptyView())
		self._steps = _StepsContainer(steps: steps)
		self._cancelAction = cancelAction != nil ? ViewBuilder.buildEither(first: cancelAction!) : ViewBuilder.buildEither(second: EmptyView())

		isModelInit = true
		isTitleNil = title == nil ? true : false
		isActionNil = action == nil ? true : false
		isCancelActionNil = cancelAction == nil ? true : false
    }
}
