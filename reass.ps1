# Définir les variables
$destinationFolder = "C:\Users\chris\Documents\SQUAD_DSI\CAGIP\temp"          # Dossier contenant les fichiers divisés
$outputFile = "C:\Users\chris\Documents\SQUAD_DSI\CAGIP\temp\fichier_reassemble.exe"  # Chemin du fichier réassemblé

# Obtenir la liste des fichiers divisés, triés par ordre de nom
$files = Get-ChildItem -Path $destinationFolder -Filter "partie_*.exe" | Sort-Object Name

# Ouvrir le fichier de sortie en mode binaire
$outputStream = [System.IO.File]::OpenWrite($outputFile)

# Réassembler chaque partie
foreach ($file in $files) {
    # Lire le fichier actuel en mode binaire
    $inputStream = [System.IO.File]::OpenRead($file.FullName)
    $buffer = New-Object byte[] $inputStream.Length
    $bytesRead = $inputStream.Read($buffer, 0, $buffer.Length)

    # Écrire les données dans le fichier de sortie
    $outputStream.Write($buffer, 0, $bytesRead)
    $inputStream.Close()

    # Afficher le statut
    Write-Output "Partie $($file.Name) ajoutée au fichier $outputFile"
}

# Fermer le flux de sortie
$outputStream.Close()

Write-Output "Réassemblage terminé !"
