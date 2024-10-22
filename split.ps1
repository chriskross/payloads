# Définir les variables
$sourceFile = "C:\Users\chris\Documents\SQUAD_DSI\CAGIP\nmap.exe"   # Chemin du fichier .exe à diviser
$destinationFolder = "C:\Users\chris\Documents\SQUAD_DSI\CAGIP\temp"      # Dossier où seront enregistrés les fichiers divisés
$chunkSize = 10MB                               # Taille de chaque partie (en octets)

# Créer le dossier de destination s'il n'existe pas
if (-Not (Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

# Ouvrir le fichier d'origine en mode binaire
$inputStream = [System.IO.File]::OpenRead($sourceFile)

# Initialiser les variables de suivi
$buffer = New-Object byte[] $chunkSize
$fileIndex = 1

# Lire et écrire des parties jusqu'à ce que tout le fichier soit traité
while ($bytesRead = $inputStream.Read($buffer, 0, $buffer.Length)) {
    # Créer le fichier de sortie pour la partie actuelle
    $outputFile = [System.IO.Path]::Combine($destinationFolder, "partie_$fileIndex.exe")
    $outputStream = [System.IO.File]::OpenWrite($outputFile)

    # Écrire les données dans le fichier de sortie
    $outputStream.Write($buffer, 0, $bytesRead)
    $outputStream.Close()

    # Afficher le statut
    Write-Output "Fichier $outputFile créé avec $bytesRead octets"

    # Incrémenter l'index du fichier
    $fileIndex++
}

# Fermer le flux d'entrée
$inputStream.Close()

Write-Output "Division terminée !"
