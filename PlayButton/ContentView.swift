//
//  ContentView.swift
//  PlayButton
//
//  Created by Robin Malhotra on 24/06/20.
//

//https://swiftui-lab.com/swiftui-animations-part1/

import SwiftUI

struct ContentView: View {
	@State var isPlaying = false

    var body: some View {
		VStack {
			PlayButtonShape(isPlaying: self.isPlaying)
				.animation(.easeInOut(duration: 1.0))

			Button(action: {
				isPlaying.toggle()
			}, label: {

				Text("push pls")
			})
		}

    }
}


struct PlayButtonShape: Shape {

	var isPlaying = true
	private var state: Double

	var animatableData: Double {
	   get { return state }
	   set { state = newValue }
	}

	init(isPlaying: Bool) {
		self.isPlaying = isPlaying
		self.state = isPlaying ? 1.0 : 0.0
	}

	func pointBetween(a: CGPoint, b: CGPoint, fraction: Double) -> CGPoint {
		let x = a.x + (b.x - a.x) * CGFloat(fraction)
		let y = a.y + (b.y - a.y) * CGFloat(fraction)
		return CGPoint(x: x, y: y)
	}

	func pointBetweenWithFraction(a: CGPoint, b: CGPoint) -> CGPoint {
		let x = a.x + (b.x - a.x) * CGFloat(state)
		let y = a.y + (b.y - a.y) * CGFloat(state)
		return CGPoint(x: x, y: y)
	}

	func path(in rect: CGRect) -> Path {
		let edge: CGFloat = min(rect.size.width, rect.size.height)
		var path = Path()
		path.move(to: .zero)
		path.addLine(to: CGPoint(x: 0, y: edge))
		path.addLine(to: pointBetweenWithFraction(a: CGPoint(x: edge/4, y: edge), b: CGPoint(x: edge/2, y: edge/4 * 3)))
		path.addLine(to: pointBetweenWithFraction(a: CGPoint(x: edge/4, y: 0), b: CGPoint(x: edge/2, y: edge/4)))
		path.closeSubpath()

		path.move(to: pointBetweenWithFraction(a:  CGPoint(x: edge/2, y: 0), b: CGPoint(x: edge/2, y: edge/4)))
		path.addLine(to: pointBetweenWithFraction(a: CGPoint(x: edge/2, y: edge), b: CGPoint(x: edge/2, y: edge/4 * 3)))
		path.addLine(to: pointBetweenWithFraction(a: CGPoint(x: edge/4 * 3, y: edge), b: CGPoint(x: edge, y: edge/2)))
		path.addLine(to: pointBetweenWithFraction(a: CGPoint(x: edge/4 * 3, y: 0), b: CGPoint(x: edge, y: edge/2)))
		path.closeSubpath()
		return path
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			ContentView(isPlaying: false)
			ContentView(isPlaying: true)
		}
    }
}
