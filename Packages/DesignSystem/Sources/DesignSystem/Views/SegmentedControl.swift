import SwiftUI

public struct SegmentedControl<T>: View {
  @Binding var selectedIndex: Int
  @Binding var items: [T]
  let keyPath: KeyPath<T, String>
  let addHandler: (() -> Void)?

  @Namespace var namespace
  @State private var scrollViewContentSize: CGSize = .zero

  public init(selectedIndex: Binding<Int>, items: Binding<[T]>, keyPath: KeyPath<T, String>, addHandler: (() -> Void)? = nil) {
    self._selectedIndex = selectedIndex
    self._items = items
    self.keyPath = keyPath
    self.addHandler = addHandler
  }

  var outerShape: some Shape {
    RoundedRectangle(cornerRadius: 15)
  }

  var innerShape: some Shape {
    RoundedRectangle(cornerRadius: 10)
  }

  public var body: some View {
    HStack(alignment: .center) {
      ScrollViewReader { proxy in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 4) {
            ForEach(items.indices, id: \.self) { index in
              Text(items[index][keyPath: keyPath])
                .foregroundColor(selectedIndex == index ? .black : .white)
                .textStyle(.designSystem(.body(.bold)))
                .padding(.horizontal, 6)
                .padding(.vertical, 8.0)
                .matchedGeometryEffect(
                  id: index,
                  in: namespace,
                  isSource: true
                )
                .onTapGesture {
                  withAnimation {
                    selectedIndex = index
                    proxy.scrollTo(index)
                  }
                }
            }
          }
          .background(
            GeometryReader { geo -> Color in
              Task { @MainActor in
                scrollViewContentSize = geo.size
              }
              return Color.clear
            }
          )
        }
        .frame(
          maxWidth: scrollViewContentSize.width
        )
        .clipShape(innerShape)
        .padding(6.0)
        .background {
          innerShape
            .fill(Color.primary500)
            .matchedGeometryEffect(
              id: selectedIndex,
              in: namespace,
              isSource: false
            )
        }
        .background {
          outerShape
            .fill(Color.dark400)
        }
        .clipShape(outerShape)
      }
      .frame(minHeight: 44)
      if let addHandler {
        Button {
          addHandler()
        } label: {
          Image(systemName: "plus")
        }
        .buttonStyle(.designSystem(.primary))
      }
    }
  }
}

struct SegmentedControl_Previews: PreviewProvider {
  struct PreviewsContainer: View {
    @State private var selectedIndex = 1
    @State private var teams = ["Team 1", "Team 2", "Team 3", "Team 4"]
    var body: some View {
      SegmentedControl(
        selectedIndex: $selectedIndex,
        items: $teams,
        keyPath: \.self,
        addHandler: {}
      )
    }
  }

  static var previews: some View {
    PreviewsContainer()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.dark500)
  }
}
