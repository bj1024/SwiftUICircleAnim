//

import SwiftUI
// 波紋のような


extension Animation {
    func `repeat`(while expression: Bool, autoreverses: Bool = true) -> Animation {
        if expression {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}

struct CircleAnimView: View {
  @Binding var isAnimating: Bool

  var anim: Animation {
    return 
    Animation
      .easeIn(duration: 2.0)
      .repeatForever(autoreverses: false)

//      .repeatForever(autoreverses: false)
  }

  var body: some View {
    ZStack {
      ForEach(0 ..< 50) { i in
        Circle()
          .stroke(lineWidth: 2)
          .scaleEffect(isAnimating ? 1 : 0)
          .opacity(isAnimating ? 0 : 1)
          .animation(
            .easeIn(duration: 2.0)
            .repeat(while: isAnimating,autoreverses: false)
            .delay(0.1 * Double(i)), value: isAnimating)
      }
    }
    .onAppear {
      isAnimating = true
    }
  }
}

struct ContentView: View {
//  @State private var isAnimating = false
  @State private var isShow = false

  var body: some View {
    VStack {
      Button(action: {
        if self.isShow {
//          withAnimation() {
            self.isShow = false
//          }
        } else {
//          withAnimation() {
            self.isShow = true
//          }
        }
//        }
//        isShow.toggle()
        // withAnimation {
        // self.isAnimating.toggle()
        // }

      }) {
        Text(isShow ? "Stop Animation" : "Start Animation")
      }

      CircleAnimView(isAnimating: $isShow)
        .opacity(isShow ? 1 : 0)
        .animation(.easeIn(duration: 1), value: isShow)
      Text("isShow=\(isShow)")
    }
    .onAppear {
      isShow = true
//      isAnimating = true
    }
  }
}

#Preview {
  ContentView()
}
