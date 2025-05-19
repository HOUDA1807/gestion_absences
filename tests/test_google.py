from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import time

# Options Chrome pour environnement headless (exécution sans interface graphique)
options = Options()
options.add_argument("--headless")
options.add_argument("--no-sandbox")  # souvent nécessaire dans Docker
options.add_argument("--disable-dev-shm-usage")  # éviter les problèmes de mémoire partagée
options.add_argument("--disable-gpu")  # parfois utile en headless
options.add_argument("--window-size=1920,1080")  # résolution par défaut

# Optionnel : chemin vers le driver Chrome si non dans PATH
# driver_path = "/usr/local/bin/chromedriver"
# driver = webdriver.Chrome(executable_path=driver_path, options=options)

driver = webdriver.Chrome(options=options)

try:
    driver.get("https://www.google.com")
    time.sleep(2)  # attendre que la page charge
    assert "Google" in driver.title
    print("Test Passed: Google page loaded successfully.")
finally:
    driver.quit()
