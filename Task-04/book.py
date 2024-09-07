import csv

def get_csv_file(genre,books_service):
    request = books_service.volumes().list(q=f"subject:{genre}", langRestrict='en')
    response = request.execute()
    books = response.get('items', [])

    with open('Books_detail.csv', 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['Title', 'Authors', 'published_date', 'publisher', 'language', 'previewlink', 'description'])
        for book in books:
            volume_info=book.get('volumeInfo')
            title = volume_info.get('title', 'N/A')
            authors = ', '.join(volume_info.get('authors', ['N/A']))
            published_date = volume_info.get('publishedDate', 'N/A')
            publisher = volume_info.get('publisher', 'N/A')
            language = volume_info.get('language', 'N/A')
            preview_link = volume_info.get('previewLink', 'N/A')
            description = volume_info.get('description', 'N/A')
            writer.writerow([title, authors, published_date, publisher, language, preview_link, description])
    