import SwiftUI
import PhoenixShared

struct MVIContext<Model: MVI.Model, Intent: MVI.Intent, Content: View> : View {

    class ObservableController<M : MVI.Model, I : MVI.Intent> : ObservableObject {
        @Published var controller: MVIController<M, I>? = nil

        deinit {
            controller?.stop()
        }
    }

    private let modelType: Model.Type
    private let intentType: Intent.Type

    private let content: (Model, @escaping (Intent) -> Void) -> Content

    @EnvironmentObject private var envDi: ObservableDI

    @StateObject private var controllerHolder = ObservableController<Model, Intent>()

    @State private var model: Model? = nil

    init(
            _ modelType: Model.Type,
            _ intentType: Intent.Type,
            @ViewBuilder content: @escaping (Model, @escaping (Intent) -> Void) -> Content
    ) {
        self.modelType = modelType
        self.intentType = intentType
        self.content = content
    }

    var body: some View {
        if controllerHolder.controller == nil {
            controllerHolder.controller = envDi.di.instance(of: MVIController<Model, Intent>.self, params: [modelType, intentType])
        }

        let m: Model = model ?? controllerHolder.controller!.firstModel

        var unsub: (() -> Void)? = nil
        return content(m, { controllerHolder.controller!.intent(intent: $0) })
                .onAppear { unsub = self.controllerHolder.controller!.subscribe { self.model = $0 } }
                .onDisappear { unsub?() }
    }

}