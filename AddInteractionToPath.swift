
import SwiftUI

struct AddInteractionToPath: View {
    @State private var tapCount = 0
    @State private var baseSize: CGSize = .zero
    private var path: Path {
        let path = Path { path in
            path.move(to: CGPoint(x: 100, y: 50))
            path.addLine(to: CGPoint(x: 150, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 200))
            path.addLine(to: CGPoint(x: 50, y: 100))
            path.closeSubpath()
        }
        return path
    }
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text(String("Tapped: \(tapCount)"))
                    .font(.headline)

                // Approach 1: Not-so-smart Approach
                ZStack {
                    path
                    Button(action: {
                        tapCount = tapCount + 1
                    }, label: {
                        path
                            .offset(x: -path.boundingRect.minX)
                            .offset(y:  -path.boundingRect.minY)
                            .background(.red.opacity(0.3))
                    })
                    // not on the `label` path
                    .frame(width: path.boundingRect.width, height: path.boundingRect.height)
                    .position(.init(x: path.boundingRect.midX, y: path.boundingRect.midY))
                    .background(.red.opacity(0.3))

                }

                // Approach 2: A little better approach
                ZStack {
                    let contentShape: ShapeFromPath = ShapeFromPath(path: path)

                    path
                    
                    Button(action: {
                        tapCount = tapCount + 1
                    }, label: {
                        path
                    })
                    // not on the `label` path
                    .contentShape(contentShape)
                    .background(.red.opacity(0.3))

                }

            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow.opacity(0.1))
            .navigationTitle("Path + Interaction")

        }
    }
}

struct ShapeFromPath: Shape {
    var path: Path
    
    func path(in rect: CGRect) -> Path {
        return path
    }
}
