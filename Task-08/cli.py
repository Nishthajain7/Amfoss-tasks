from bs4 import BeautifulSoup
import os, click, urllib, requests

def get_imdb(filename):
    url_for_imdb = "https://www.omdbapi.com/?apikey=43c308ea&t="+filename
    r = requests.get(url_for_imdb)
    content = r.json()
    return content.get('imdbID')

def downloadsubtitle(language, output, imdb_id):
    url = f"https://www.opensubtitles.org/en/search2/sublanguageid-all/imdbid-{imdb_id}"
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    lines = soup.select('tr.change')
    for line in lines:
        language_cell = line.select_one('td:nth-child(2) a[title]')
        link_cell = line.select_one('td:nth-child(5) a[href]')
        lang = language_cell.get('title')
        link = link_cell.get('href')
        if lang == language:
            print(language)
            break
    download_link = "https://www.opensubtitles.org"+link
    urllib.request.urlretrieve(download_link, output)
    print(f'''File downloaded successfully
Location - {output}''')
    return

@click.command()
@click.option('--language', '-l', default='English', help='Language of the subtitle')
@click.option('--output', '-o', required=True, help='Output file path or directory')
@click.option('--batch-download', '-b', is_flag=True, help='Enable batch mode for downloading subtitles for all movies in a directory')

def get_subtitle(language, output, batch_download):
    if batch_download:
        for file in os.listdir(path):
            if file.endswith(('.mp4', '.mpeg4', '.mkv', '.avi', '.mov')):
                filename = os.path.splitext(file)[0]
                imdb_id = get_imdb(filename)
                downloadsubtitle(language, output, imdb_id)
    else:
        path="/home/nishtha/Downloads/plan-9-from-outer-space.mpeg4"
        file = os.path.basename(path)
        split = file.split('-')
        filename = ''
        for word in split:
            if word != split[len(split)-1]:
                filename+=word+'.'
            else:
                words=word.split('.')
                filename+=words[0]
        imdb_id = get_imdb(filename)
        downloadsubtitle(language, output, imdb_id)


if __name__== '__main__':
    get_subtitle()
