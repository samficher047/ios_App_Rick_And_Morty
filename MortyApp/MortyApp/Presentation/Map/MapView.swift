import SwiftUI
import MapKit

struct MapView: View {
    
    let character: Character
    
    @State private var position: MapCameraPosition
    private let coordinate: CLLocationCoordinate2D
    
    init(character: Character) {
        self.character = character
        
        let lat = Double.random(in: -90...90)
        let lon = Double.random(in: -180...180)
        
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.coordinate = coord
        
        _position = State(initialValue: .region(
            MKCoordinateRegion(
                center: coord,
                span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
            )
        ))
    }
    
    var body: some View {
        Map(position: $position) {
            
            Annotation("", coordinate: coordinate) {
                VStack(spacing: 6) {
                    
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                        .shadow(radius: 4)
                    
                    Text(character.name)
                        .font(.caption)
                        .padding(6)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
                }
            }
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
