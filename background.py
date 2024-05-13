import requests
import os
import subprocess
from bs4 import BeautifulSoup
import random
from urllib.parse import urlparse, urljoin

def download_image(url, save_path):
    if not url:
        return False
    response = requests.get(url)
    if response.status_code == 200:
        with open(save_path, 'wb') as f:
            f.write(response.content)
        return True
    else:
        return False

def get_google_images():
    url = "https://www.google.com.br"
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"}
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        soup = BeautifulSoup(response.content, 'html.parser')
        image_elements = soup.find_all('img')
        base_url = urlparse(url)
        image_urls = [urljoin(base_url.scheme + "://" + base_url.netloc, img['src']) for img in image_elements if img.get('src')]
        return image_urls
    else:
        return []

def set_wallpaper(image_path):
    command = "gsettings set org.gnome.desktop.background picture-uri file://{}".format(image_path)
    subprocess.Popen(["/bin/bash", "-c", command])

save_dir = os.path.join(os.path.expanduser('~'), 'Imagens', 'Google_Destaques')
if not os.path.exists(save_dir):
    os.makedirs(save_dir)

image_urls = get_google_images()

if image_urls:
    random_image_url = random.choice(image_urls)
    parsed_url = urlparse(random_image_url)
    if parsed_url.netloc:
        image_name = os.path.basename(parsed_url.path)
        image_path = os.path.join(save_dir, image_name)

        if download_image(random_image_url, image_path):
            set_wallpaper(image_path)
            print("Papel de parede atualizado com sucesso!")
        else:
            print("Não foi possível baixar a imagem.")
    else:
        print("A URL da imagem não é válida.")
else:
    print("Não foi possível obter as URLs das imagens de destaque do Google.")

