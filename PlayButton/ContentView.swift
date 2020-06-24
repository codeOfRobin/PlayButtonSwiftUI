//
//  ContentView.swift
//  PlayButton
//
//  Created by Robin Malhotra on 24/06/20.
//

import SwiftUI

struct ContentView: View {
	@State var isPlaying = false

    var body: some View {
		VStack {
			Button(action: {
				isPlaying.toggle()
			}, label: {
				Text("push")
			})

			GeometryReader { geometry -> Path in
				let edge: CGFloat = min(geometry.size.width, geometry.size.height)
				if isPlaying {
					return pausePath(edge: edge)
				} else {
					return playPath(edge: edge)
				}
			}.animation(.easeIn)
		}

    }

	func pausePath(edge: CGFloat) -> Path {
		Path {
			path in

			path.move(to: CGPoint(x: edge/4, y: 0))
			path.addLine(to: CGPoint(x: edge/4, y: edge))
			path.addLine(to: CGPoint(x: edge/2, y: edge))
			path.addLine(to: CGPoint(x: edge/2, y: 0))

			path.move(to: CGPoint(x: 3*edge/4, y: 0))
			path.addLine(to: CGPoint(x: 3*edge/4, y: edge))
			path.addLine(to: CGPoint(x: edge, y: edge))
			path.addLine(to: CGPoint(x: edge, y: 0))

		}
	}

	func playPath(edge: CGFloat) -> Path {
		Path { path in
			path.move(to: CGPoint.zero)
			path.addLine(to: CGPoint(x: 0, y: edge))
			path.addLine(to: CGPoint(x: edge, y: edge/2))
		}
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
