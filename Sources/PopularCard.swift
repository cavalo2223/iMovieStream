import SwiftUI
struct PopularCard: View {
    let item: MediaDisplayable
    var body: some View {
        VStack(alignment:.leading, spacing:6) {
            AsyncImage(url: item.posterURL) { phase in
                if let image = phase.image { image.resizable().aspectRatio(contentMode:.fill) }
                else { Color.gray.opacity(0.4) }
            }.frame(width:140, height:190).clipShape(RoundedRectangle(cornerRadius:12)).shadow(radius:4)
            VStack(alignment:.leading, spacing:2) {
                HStack {
                    Text("SEASON ONE").font(.system(size:9, weight:.bold)).foregroundColor(.blue)
                    Spacer()
                    if let rating = item.rating {
                        Text(String(format:"%.1f", rating)).font(.system(size:9, weight:.semibold)).foregroundColor(.yellow)
                    }
                }
                Text(item.title).font(.headline).fontWeight(.semibold).foregroundColor(.white).lineLimit(1)
                Text("Atualizado para \(item.year)").font(.caption).foregroundColor(.gray)
            }.padding(.horizontal,4)
        }.frame(width:140)
    }
}
