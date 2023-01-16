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

  public var body: some View {
    HStack {
      ScrollViewReader { proxy in
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
              Text(items[index][keyPath: keyPath])
                .fontWeight(.semibold)
                .padding(.horizontal)
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
        .clipShape(Capsule())
        .padding(6.0)
        .background {
          Capsule()
            .fill(Material.thin)
            .matchedGeometryEffect(
              id: selectedIndex,
              in: namespace,
              isSource: false
            )
        }
        .background {
          Capsule()
            .fill(Colors.Background.accent)
        }
        .clipShape(Capsule())
      }
      if let addHandler {
        Button {
          addHandler()
        } label: {
          Image(systemName: "plus")
        }
        .buttonStyle(.designSystem(.circle))
      }
    }
  }
}

struct SegmentedControl_Previews: PreviewProvider {
  struct PreviewsContainer: View {
    @State private var selectedIndex = 1
    @State private var teams = ["Team 1", "Team 2"]
    var body: some View {
      SegmentedControl(
        selectedIndex: $selectedIndex,
        items: $teams,
        keyPath: \.self
      )
    }
  }

  static var previews: some View {
    PreviewsContainer()
  }
}
