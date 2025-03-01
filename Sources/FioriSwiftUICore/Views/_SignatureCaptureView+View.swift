import Combine
import FioriThemeManager
import SwiftUI

extension Fiori {
    enum _SignatureCaptureView {
        struct StartAction: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(.fiori(forTextStyle: .body))
                    .fontWeight(.semibold)
                    .accentColor(.preferredColor(.tintColor))
            }
        }

        typealias StartActionCumulative = EmptyModifier

        struct RestartAction: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(.fiori(forTextStyle: .body))
                    .fontWeight(.semibold)
                    .accentColor(.preferredColor(.tintColor))
            }
        }

        typealias RestartActionCumulative = EmptyModifier

        struct CancelAction: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(.fiori(forTextStyle: .body))
                    .fontWeight(.semibold)
                    .accentColor(.preferredColor(.tintColor))
            }
        }

        typealias CancelActionCumulative = EmptyModifier

        struct ClearAction: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(.fiori(forTextStyle: .body))
                    .fontWeight(.semibold)
                    .accentColor(.preferredColor(.tintColor))
            }
        }

        typealias ClearActionCumulative = EmptyModifier

        struct SaveAction: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .font(.fiori(forTextStyle: .body))
                    .fontWeight(.semibold)
                    .accentColor(.preferredColor(.tintColor))
            }
        }

        typealias SaveActionCumulative = EmptyModifier

        static let startAction = StartAction()
        static let restartAction = RestartAction()
        static let cancelAction = CancelAction()
        static let clearAction = ClearAction()
        static let saveAction = SaveAction()
        static let startActionCumulative = StartActionCumulative()
        static let restartActionCumulative = RestartActionCumulative()
        static let cancelActionCumulative = CancelActionCumulative()
        static let clearActionCumulative = ClearActionCumulative()
        static let saveActionCumulative = SaveActionCumulative()
    }
}

extension _SignatureCaptureView: View {
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(self.getKeyName())
                    .padding(.top, 11)
                    .padding(.bottom, 11)
                    .accessibilityLabel(self.getTitleAccessibilityLabel())
                Spacer()
                cancelAction
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                self.clear()
                                isEditing = false
                            }
                    )
                    .frame(minWidth: 44, minHeight: 44)
                    .setHidden(!isEditing)
            }
            .frame(minHeight: 44)

            if fullSignatureImage != nil || (_signatureImage != nil && !isReenterTapped) {
                ZStack {
                    if let uiImage = fullSignatureImage {
                        if appliesTintColorToImage {
                            Image(uiImage: uiImage)
                                .renderingMode(.template)
                                .foregroundColor(strokeColor)
                                .frame(minHeight: _drawingViewMinHeight, maxHeight: self.imageMaxHeight())
                                .cornerRadius(10)
                                .padding(.zero)
                        } else {
                            Image(uiImage: uiImage)
                                .frame(minHeight: _drawingViewMinHeight, maxHeight: self.imageMaxHeight())
                                .cornerRadius(10)
                                .padding(.zero)
                        }
                    } else if let signature = _signatureImage {
                        if appliesTintColorToImage {
                            Image(uiImage: signature)
                                .renderingMode(.template)
                                .foregroundColor(strokeColor)
                                .padding(.zero)
                        } else {
                            Image(uiImage: signature)
                                .padding(.zero)
                        }
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.preferredColor(.separator), lineWidth: 1)
                        .background(Color.preferredColor(.quaternaryFill)).cornerRadius(10)
                        .frame(minHeight: _drawingViewMinHeight, maxHeight: self.imageMaxHeight())
                        .padding(.zero)
                }.padding(.zero)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(NSLocalizedString("Signature Image", tableName: "FioriSwiftUICore", bundle: Bundle.accessor, comment: "Signature Image"))
            } else {
                self.drawingArea
                    .frame(minHeight: _drawingViewMinHeight, maxHeight: _drawingViewMaxHeight)
                    .padding(.zero)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.preferredColor(.separator), lineWidth: 1)
                    )
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        self.isEditing = true
                    }
            }

            if self.isEditing {
                HStack {
                    clearAction
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    self.clear()
                                }
                        )
                        .disabled(drawings.isEmpty)
                        .frame(minWidth: 44, minHeight: 44)
                    Spacer()
                    saveAction
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    isSaved = true
                                }
                        )
                        .disabled(drawings.isEmpty)
                        .frame(minWidth: 44, minHeight: 44)
                }
                .padding(.top, 8)
            } else if (_signatureImage != nil && !isReenterTapped) || fullSignatureImage != nil {
                restartAction
                    .simultaneousGesture(
                        TapGesture()
                            .onEnded { _ in
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                self.clear()
                                self.onDelete()
                                isReenterTapped = true
                                self.isEditing = true
                            }
                    )
                    .frame(minWidth: 44, minHeight: 44)
                    .padding(.top, 8)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: isEditing || (_signatureImage != nil && !isReenterTapped) ? 0 : 16, trailing: 16))
        .background(VStackPreferenceSetter())
        .onPreferenceChange(VStackPreferenceKey.self) { heights in
            guard let height = heights.first else {
                return
            }
            self._heightDidChangePublisher.send(height)
        }
        .background(Color.preferredColor(.cellBackground))
    }

    @ViewBuilder var drawingArea: some View {
        if self.isEditing {
            ZStack(alignment: .bottom) {
                _ScribbleView(image: $fullSignatureImage, currentDrawing: $currentDrawing, drawings: $drawings, isSaved: $isSaved, isEditing: $isEditing, onSave: self.onSave(_:), strokeWidth: strokeWidth, strokeColor: strokeColor, drawingViewBackgroundColor: drawingViewBackgroundColor, cropsImage: cropsImage, watermarkText: watermarkText, watermarkTextColor: watermarkTextColor, watermarkTextFont: watermarkTextFont, watermarkTextAlignment: watermarkTextAlignment, addsTimestampInImage: addsTimestampInImage, timestampFormatter: timestampFormatter)
                    .frame(maxWidth: .infinity, minHeight: 256, maxHeight: _drawingViewMaxHeight)
                    .accessibilityElement()
                    .accessibilityLabel(NSLocalizedString("Signature Area", tableName: "FioriSwiftUICore", bundle: Bundle.accessor, comment: "Signature Area"))
                    .accessibilityHint(NSLocalizedString("Double tap and drag to sign", tableName: "FioriSwiftUICore", bundle: Bundle.accessor, comment: "Double tap and drag to sign"))
                HStack(alignment: .bottom) {
                    Image(systemName: "xmark")
                        .foregroundColor(xmarkColor)
                        .font(.fiori(forTextStyle: .body))
                        .setHidden(self.hidesXmark)
                    Rectangle()
                        .foregroundColor(signatureLineColor)
                        .frame(height: 1)
                        .setHidden(self.hidesSignatureLine)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(NSLocalizedString("Signature Line", tableName: "FioriSwiftUICore", bundle: Bundle.accessor, comment: "Signature Line"))
                .padding([.leading, .trailing]).padding(.bottom, 48)
            }
        } else {
            ZStack(alignment: .bottom) {
                ZStack {
                    Color.preferredColor(.quaternaryFill).cornerRadius(10)
                    startAction
                        .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    self.isEditing = true
                                }
                        )
                        .font(.fiori(forTextStyle: .body))
                        .foregroundColor(Color.preferredColor(.tintColor))
                }
                .frame(maxWidth: .infinity, minHeight: 256, maxHeight: _drawingViewMaxHeight)
                HStack(alignment: .bottom) {
                    Image(systemName: "xmark")
                        .foregroundColor(xmarkColor.opacity(0.4))
                        .font(.fiori(forTextStyle: .body))
                        .setHidden(self.hidesXmark)
                    Rectangle()
                        .foregroundColor(signatureLineColor.opacity(0.4))
                        .frame(height: 1)
                        .setHidden(self.hidesSignatureLine)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(NSLocalizedString("Signature Line", tableName: "FioriSwiftUICore", bundle: Bundle.accessor, comment: "Signature Line"))
                .padding([.leading, .trailing]).padding(.bottom, 48)
            }
        }
    }
    
    func getKeyName() -> AttributedString {
        var titleString = _title
        if (titleString?.isEmpty) == nil {
            titleString = NSLocalizedString("Signature", tableName: "FioriSwiftUICore", bundle: Bundle.accessor, comment: "")
        }
        var titleAttributedText = AttributedString(titleString ?? "")
        titleAttributedText.foregroundColor = titleColor
        titleAttributedText.font = titleFont
        if isRequired {
            var indicatorAttributedText = AttributedString(_mandatoryIndicator ?? "*")
            indicatorAttributedText.foregroundColor = indicatorColor
            indicatorAttributedText.font = indicatorFont
            return titleAttributedText + indicatorAttributedText
        }
        return titleAttributedText
    }
    
    func getTitleAccessibilityLabel() -> String {
        var accString = ""
        if isRequired {
            let requiredText = NSLocalizedString("Required Field", tableName: "FioriSwiftUICore", bundle: Bundle.accessor, comment: "Required Field")
            let labelString = _title?.suffix(1) == "*" ? String(_title?.dropLast(1) ?? "") : (_title ?? "")
            accString = labelString + (labelString.isEmpty ? "" : ", ") + requiredText
        } else {
            accString = _title ?? ""
        }
        return accString
    }
    
    func setEditing() {
        self.isEditing = true
    }

    func clear() {
        fullSignatureImage = nil
        currentDrawing = Drawing()
        drawings.removeAll()
    }

    func onSave(_ uiImage: UIImage) {
        _onSave?(uiImage)
    }

    func onDelete() {
        _onDelete?()
    }

    func imageMaxHeight() -> CGFloat? {
        var imageHeight: CGFloat = 0
        if let uiImage = fullSignatureImage {
            imageHeight = uiImage.size.height
        } else if let signature = _signatureImage {
            imageHeight = signature.size.height
        } else {
            return _drawingViewMaxHeight
        }
        if let drawingViewMaxHeight = _drawingViewMaxHeight {
            return max(imageHeight, drawingViewMaxHeight)
        } else if imageHeight > 0 {
            return imageHeight
        }
        return nil
    }
}

// View modifiers
public extension _SignatureCaptureView {
    /**
     A view modifier to set the title font.

     The default is `Font.body`.
     */
    func titleFont(_ font: Font?) -> Self {
        guard let font else {
            return self
        }
        var newSelf = self
        newSelf.titleFont = font
        return newSelf
    }

    /**
     A view modifier to set the title text color.

     The default is `Color.preferredColor(.primaryLabel)`.
     */
    func titleColor(_ color: Color?) -> Self {
        guard let color else {
            return self
        }
        var newSelf = self
        newSelf.titleColor = color
        return newSelf
    }

    /**
     A view modifier to set the mandatory field font.

     The default is `Font.body`.
     */
    func indicatorFont(_ font: Font?) -> Self {
        guard let font else {
            return self
        }
        var newSelf = self
        newSelf.indicatorFont = font
        return newSelf
    }

    /**
     A view modifier to set the mandatory field text color.

     The default is `Color.preferredColor(.primaryLabel)`.
     */
    func indicatorColor(_ color: Color?) -> Self {
        guard let color else {
            return self
        }
        var newSelf = self
        newSelf.indicatorColor = color
        return newSelf
    }
    
    /**
     A view modifier to set the stroke width.

     The default stroke width is 3 px.

     - parameter width: The desired stroke width.
     */
    func strokeWidth(_ width: CGFloat) -> Self {
        var newSelf = self
        newSelf.strokeWidth = width
        return newSelf
    }

    /**
     A view modifier to set the stroke color.

     The default stroke color is Fiori color style ".primaryLabel".

     - parameter width: The desired stroke color.
     */
    func strokeColor(_ color: Color) -> Self {
        var newSelf = self
        newSelf.strokeColor = color
        return newSelf
    }

    /**
     A view modifier to set the drawing area background color.

     The default background color is Fiori color style ".primaryBackground".

     - parameter width: The desired stroke color.
     */
    func drawingViewBackgroundColor(_ color: Color) -> Self {
        var newSelf = self
        newSelf.drawingViewBackgroundColor = color
        return newSelf
    }

    /**
     A view modifier to set the maximum height of the drawing area.

     - parameter height: The maximum height of the drawing area. Set it to `nil` indicates to use the max height of the device screen.
     */
    func _drawingViewMaxHeight(_ height: CGFloat?) -> Self {
        var newSelf = self
        newSelf._drawingViewMaxHeight = height

        return newSelf
    }

    /**
     A view modifier to set if the saved image should crop the extra spaces or not. The default is not to crop.

     - parameter cropsImage: Indicates if the saved image should crop the extra spaces or not.
     */
    func cropsImage(_ cropsImage: Bool) -> Self {
        var newSelf = self
        newSelf.cropsImage = cropsImage
        return newSelf
    }

    /**
     A view modifier to set the color of the "X" mark.

     - parameter color: The desired color of the "X" mark.
     */
    func xmarkColor(_ color: Color?) -> Self {
        guard let color else {
            return self
        }
        var newSelf = self
        newSelf.xmarkColor = color
        return newSelf
    }

    /**
     A view modifier to set the color of the signature line.

     - parameter color: The desired color for the signature line.
     */
    func signatureLineColor(_ color: Color?) -> Self {
        guard let color else {
            return self
        }
        var newSelf = self
        newSelf.signatureLineColor = color
        return newSelf
    }

    /**
     A view modify to indicate to hide XMark or not.

     - parameter hidesXmark: Set this to true to hide the X Mark.
     */
    func hidesXmark(_ hidesXmark: Bool) -> Self {
        var newSelf = self
        newSelf.hidesXmark = hidesXmark
        return newSelf
    }

    /**
     A view modify to indicate to hide XMark or not.

     - parameter hidesSignatureLine: Set this to true to hide the signature line.
     */
    func hidesSignatureLine(_ hidesSignatureLine: Bool) -> Self {
        var newSelf = self
        newSelf.hidesSignatureLine = hidesSignatureLine
        return newSelf
    }

    /**
     A view modifier to indicate to add timestamp to the signature image or not.

     - parameter addsTimestampInImage: Set this to true to add timestamp to the signature image.
     */
    func addsTimestampInImage(_ addsTimestampInImage: Bool) -> Self {
        var newSelf = self
        newSelf.addsTimestampInImage = addsTimestampInImage
        return newSelf
    }

    /**
     A view modifier to provide a customized timestamp formatter.

     - parameter timestampFormatter: The customized timestamp formatter.
     */
    func timestampFormatter(_ timestampFormatter: DateFormatter?) -> Self {
        var newSelf = self
        newSelf.timestampFormatter = timestampFormatter
        return newSelf
    }

    /**
     A view modifier to provide a watermark text to be added to the signature image.

     - parameter watermarkText: The watermark text to be added to the signature image.
     */
    func watermarkText(_ watermarkText: String?) -> Self {
        var newSelf = self
        newSelf.watermarkText = watermarkText
        return newSelf
    }

    /**
     A view modifier to change the alignment for the watermark text.

     - parameter wartermarkTextAlignment: The watermark text alignment for the watermark text.
     */
    func watermarkTextAlignment(_ watermarkTextAlignment: NSTextAlignment) -> Self {
        var newSelf = self
        newSelf.watermarkTextAlignment = watermarkTextAlignment
        return newSelf
    }

    /**
     A view modifier to change the `UIFont` for the watermark text.

     - parameter watermarkTextFont: The font for the watermark text.
     */
    func watermarkTextFont(_ watermarkTextFont: UIFont) -> Self {
        var newSelf = self
        newSelf.watermarkTextFont = watermarkTextFont
        return newSelf
    }

    /**
     A view modifier to provide a `Color` for the watermark text.

     - parameter var watermarkTextColor: Color?: The font for the watermark text. If this is `nil`, the default font will be used.
     */
    func watermarkTextColor(_ watermarkTextColor: Color) -> Self {
        var newSelf = self
        newSelf.watermarkTextColor = watermarkTextColor
        return newSelf
    }

    /**
     A view modifier to indicate if stroke color is to be applied when displaying a saved signature image.

     - parameter appliesTintColorToImage: A boolean variable to indicate if stroke color is to be applied when displaying a saved signature image.
        The default is true.
     */
    func appliesTintColorToImage(_ appliesTintColorToImage: Bool) -> Self {
        var newSelf = self
        newSelf.appliesTintColorToImage = appliesTintColorToImage
        return newSelf
    }
    
    /**
     A view modifier to indicate if the component is a mandatory field.

     - parameter `isRequired`: A boolean variable to indicate if the cell is a mandatory field.
     The default value is `false`.
     */
    func isRequired(_ isRequired: Bool) -> Self {
        var newSelf = self
        newSelf.isRequired = isRequired
        return newSelf
    }
}

private struct VStackPreferenceKey: PreferenceKey {
    static var defaultValue: [CGFloat] = []
    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}

private struct VStackPreferenceSetter: View {
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: VStackPreferenceKey.self,
                            value: [geometry.size.height])
        }
    }
}

extension View {
    @ViewBuilder func setHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
