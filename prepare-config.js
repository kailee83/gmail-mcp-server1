const fs = require('fs');
const path = require('path');
const os = require('os');

const CONFIG_DIR = path.join(os.homedir(), '.gmail-mcp');
const OAUTH_FILE = 'gcp-oauth.keys.json';
const SOURCE_PATH = path.join(process.cwd(), OAUTH_FILE); // fichier dans ton dossier courant
const TARGET_PATH = path.join(CONFIG_DIR, OAUTH_FILE);

// Créer le dossier si il n'existe pas
if (!fs.existsSync(CONFIG_DIR)) {
  fs.mkdirSync(CONFIG_DIR, { recursive: true });
  console.log(`Dossier créé : ${CONFIG_DIR}`);
} else {
  console.log(`Dossier existe déjà : ${CONFIG_DIR}`);
}

// Copier le fichier gcp-oauth.keys.json dans le dossier .gmail-mcp s'il n'existe pas déjà
if (!fs.existsSync(TARGET_PATH)) {
  if (fs.existsSync(SOURCE_PATH)) {
    fs.copyFileSync(SOURCE_PATH, TARGET_PATH);
    console.log(`Fichier ${OAUTH_FILE} copié vers ${TARGET_PATH}`);
  } else {
    console.warn(`Fichier source ${OAUTH_FILE} introuvable dans le dossier courant.`);
  }
} else {
  console.log(`Fichier ${OAUTH_FILE} existe déjà dans ${TARGET_PATH}`);
}
