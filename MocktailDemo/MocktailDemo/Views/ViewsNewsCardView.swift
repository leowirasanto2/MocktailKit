//
//  NewsCardView.swift
//  MocktailDemo
//

import SwiftUI

struct NewsCardView: View {
    let article: Article

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Source & date row
            HStack(spacing: 8) {
                HStack(spacing: 4) {
                    Image(systemName: "newspaper.fill")
                        .font(.caption2)
                        .foregroundStyle(.orange)

                    Text(article.source?.name ?? "Unknown Source")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.orange)
                }

                Spacer()

                if let published = article.publishedAt {
                    Text(formattedDate(published))
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
            }

            // Title
            Text(article.title ?? "No Title")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .fixedSize(horizontal: false, vertical: true)

            // Description
            if let description = article.description {
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            // Author
            if let author = article.author, !author.isEmpty {
                HStack(spacing: 4) {
                    Image(systemName: "person.fill")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)

                    Text(author)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                        .lineLimit(1)
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.background)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                .shadow(color: .black.opacity(0.03), radius: 2, x: 0, y: 1)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(.quaternary.opacity(0.5), lineWidth: 0.5)
        )
    }

    private func formattedDate(_ iso: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: iso) else { return iso }
        let display = DateFormatter()
        display.dateStyle = .medium
        display.timeStyle = .none
        return display.string(from: date)
    }
}

#Preview("Single Article") {
    NewsCardView(article: Article(
        source: ArticleSource(id: "cnbc", name: "CNBC"),
        author: "Sarah Min",
        title: "Stock futures rise after report says Trump looking to end Iran war",
        description: "The broad market S&P 500 fell for a third consecutive session on Monday as oil prices rose once again.",
        url: nil,
        urlToImage: nil,
        publishedAt: "2026-03-31T16:28:00Z",
        content: nil
    ))
    .padding()
}
