<# SYNOPSIS: Generates a list of 500 unique random full names for test/lab environments.
   DESCRIPTION: Combines pre-defined arrays of first and last names randomly. Uses a hashtable for fast
   duplicate detection to ensure all 500 generated names are unique.
   OUTPUT: names.txt in the script execution directory.
#>
# Pool of names for generation
$FirstName = @(
    'Kane','Brandon','Brone','James','John','Robert','Michael','William','David','Richard', 
    'Joseph','Thomas','Charles','Christopher','Daniel','Matthew','Anthony','Mark','Donald','Steven', 
    'Paul','Andrew','Joshua','Kenneth','Brian','George','Edward','Ronald','Timothy','Jason', 
    'Jeffrey','Ryan','Jacob','Gary','Nicholas','Eric','Jonathan','Stephen','Larry','Justin', 
    'Mary','Patricia','Jennifer','Linda','Elizabeth','Barbara','Susan','Jessica','Sarah','Karen', 
    'Nancy','Lisa','Betty','Margaret','Sandra','Ashley','Kimberly','Emily','Donna','Michelle', 
    'Bethanie','Synthia','Willetta','Izetta','Rocco','Helene','Freida','Eleonora','Contessa','Pauline'
)

$LastName = @(
    'Smith','Johnson','Williams','Brown','Jones','Garcia','Miller','Davis','Rodriguez','Martinez', 
    'Hernandez','Lopez','Gonzalez','Wilson','Anderson','Thomas','Taylor','Moore','Jackson','Martin', 
    'Furlow','Mcloughlin','Birden','Pothier','Authement','Adkins','Gros','Strey','Golson','Busbee', 
    'Lee','Perez','Thompson','White','Harris','Sanchez','Clark','Ramirez','Lewis','Robinson', 
    'Walker','Young','Allen','King','Wright','Scott','Torres','Nguyen','Hill','Flores'
)

$GeneratedNames = @()
$UsedFullNames = @{} #Hashtable for uniqueness tracking

#Loop until 500
while($GeneratedNames.Count -lt 500) {
    $First = Get-Random -InputObject $FirstName
    $Last = Get-Random -InputObject $LastName
    $FullName = "$First $Last"

    #Skip if name combination has been used
    if($UsedFullNames.ContainsKey($FullName)) { 
    continue 
    }

    #Tracks and stores unique entries
    $UsedFullNames[$FullName] = $true
    $GeneratedNames += $FullName
}

#Exports results to local path
$OutputPath = "$PSScriptRoot\names.txt"
$GeneratedNames | Out-File -FilePath $OutputPath -Encoding utf8

Write-Host "Successfully generated 500 unique names at: $OutputPath" -ForegroundColor Green
