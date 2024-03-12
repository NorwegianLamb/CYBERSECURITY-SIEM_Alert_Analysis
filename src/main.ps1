<#
Author: Flavio Gjoni
Status: IN-PROGRESS
Description: Parsing a CSV file, cleaning it (need to add the handling for missing values and so on),
and retrieving users' properties from the ADUC to check for SUSPICIOUS cybersecurity alarms
To-Do: 
    - Solve problem with countries such as 'Czech" and "czech republic"
    - Create a list with countries with your company's presence
    - Create a list with suspicious origin (eg. north korea, ...)
    - ...
#>

# This function is responsible for loading and preprocessing the CSV file and using the email to get the country code
function Load-Csv {
    param (
        [string]$filePath
    )

    # Countries list to be mapped
    $countryCodeMapping = @{
    	'Afghanistan' = 'AF'
        'Aland Islands' = 'AX'
        'Albania' = 'AL'
        'Algeria' = 'DZ'
        'American Samoa' = 'AS'
        'Andorra' = 'AD'
        'Angola' = 'AO'
        'Anguilla' = 'AI'
        'Antarctica' = 'AQ'
        'Antigua and Barbuda' = 'AG'
        'Argentina' = 'AR'
        'Armenia' = 'AM'
        'Aruba' = 'AW'
        'Australia' = 'AU'
        'Austria' = 'AT'
        'Azerbaijan' = 'AZ'
        'Bahamas' = 'BS'
        'Bahrain' = 'BH'
        'Bangladesh' = 'BD'
        'Barbados' = 'BB'
        'Belarus' = 'BY'
        'Belgium' = 'BE'
        'Belize' = 'BZ'
        'Benin' = 'BJ'
        'Bermuda' = 'BM'
        'Bhutan' = 'BT'
        'Bolivia' = 'BO'
        'Bonaire, Sint Eustatius and Saba' = 'BQ'
        'Bosnia and Herzegovina' = 'BA'
        'Botswana' = 'BW'
        'Bouvet Island' = 'BV'
        'Brazil' = 'BR'
        'British Indian Ocean Territory' = 'IO'
        'Brunei Darussalam' = 'BN'
        'Bulgaria' = 'BG'
        'Burkina Faso' = 'BF'
        'Burundi' = 'BI'
        'Cabo Verde' = 'CV'
        'Cambodia' = 'KH'
        'Cameroon' = 'CM'
        'Canada' = 'CA'
        'Cayman Islands' = 'KY'
        'Central African Republic' = 'CF'
        'Chad' = 'TD'
        'Chile' = 'CL'
        'China' = 'CN'
        'Christmas Island' = 'CX'
        'Cocos Islands' = 'CC'
        'Colombia' = 'CO'
        'Comoros' = 'KM'
        'Congo' = 'CG'
        'Democratic Republic of Congo' = 'CD'
        'Cook Islands' = 'CK'
        'Costa Rica' = 'CR'
        'Cote d Ivoire' = 'CI'
        'Croatia' = 'HR'
        'Cuba' = 'CU'
        'Curacao' = 'CW'
        'Cyprus' = 'CY'
        'Czechia' = 'CZ'
        'Denmark' = 'DK'
        'Djibouti' = 'DJ'
        'Dominica' = 'DM'
        'Dominican Republic' = 'DO'
        'Ecuador' = 'EC'
        'Egypt' = 'EG'
        'El Salvador' = 'SV'
        'Equatorial Guinea' = 'GQ'
        'Eritrea' = 'ER'
        'Estonia' = 'EE'
        'Eswatini' = 'SZ'
        'Ethiopia' = 'ET'
        'Falkland Islands' = 'FK'
        'Faroe Islands' = 'FO'
        'Fiji' = 'FJ'
        'Finland' = 'FI'
        'France' = 'FR'
        'French Guiana' = 'GF'
        'French Polynesia' = 'PF'
        'French Southern Territories' = 'TF'
        'Gabon' = 'GA'
        'Gambia' = 'GM'
        'Georgia' = 'GE'
        'Germany' = 'DE'
        'Ghana' = 'GH'
        'Gibraltar' = 'GI'
        'Greece' = 'GR'
        'Greenland' = 'GL'
        'Grenada' = 'GD'
        'Guadeloupe' = 'GP'
        'Guam' = 'GU'
        'Guatemala' = 'GT'
        'Guernsey' = 'GG'
        'Guinea' = 'GN'
        'Guinea-Bissau' = 'GW'
        'Guyana' = 'GY'
        'Haiti' = 'HT'
        'Heard Island and McDonald Islands' = 'HM'
        'Holy See' = 'VA'
        'Honduras' = 'HN'
        'Hong Kong' = 'HK'
        'Hungary' = 'HU'
        'Iceland' = 'IS'
        'India' = 'IN'
        'Indonesia' = 'ID'
        'Iran' = 'IR'
        'Iraq' = 'IQ'
        'Ireland' = 'IE'
        'Isle of Man' = 'IM'
        'Israel' = 'IL'
        'Italy' = 'IT'
        'Jamaica' = 'JM'
        'Japan' = 'JP'
        'Jersey' = 'JE'
        'Jordan' = 'JO'
        'Kazakhstan' = 'KZ'
        'Kenya' = 'KE'
        'Kiribati' = 'KI'
        'North Korea' = 'KP'
        'South Korea' = 'KR'
        'Kuwait' = 'KW'
        'Kyrgyzstan' = 'KG'
        'Lao' = 'LA'
        'Latvia' = 'LV'
        'Lebanon' = 'LB'
        'Lesotho' = 'LS'
        'Liberia' = 'LR'
        'Libya' = 'LY'
        'Liechtenstein' = 'LI'
        'Lithuania' = 'LT'
        'Luxembourg' = 'LU'
        'Macao' = 'MO'
        'Madagascar' = 'MG'
        'Malawi' = 'MW'
        'Malaysia' = 'MY'
        'Maldives' = 'MV'
        'Mali' = 'ML'
        'Malta' = 'MT'
        'Marshall Islands' = 'MH'
        'Martinique' = 'MQ'
        'Mauritania' = 'MR'
        'Mauritius' = 'MU'
        'Mayotte' = 'YT'
        'Mexico' = 'MX'
        'Micronesia' = 'FM'
        'Moldova' = 'MD'
        'Monaco' = 'MC'
        'Mongolia' = 'MN'
        'Montenegro' = 'ME'
        'Montserrat' = 'MS'
        'Morocco' = 'MA'
        'Mozambique' = 'MZ'
        'Myanmar' = 'MM'
        'Namibia' = 'NA'
        'Nauru' = 'NR'
        'Nepal' = 'NP'
        'Netherlands' = 'NL'
        'New Caledonia' = 'NC'
        'New Zealand' = 'NZ'
        'Nicaragua' = 'NI'
        'Niger' = 'NE'
        'Nigeria' = 'NG'
        'Niue' = 'NU'
        'Norfolk Island' = 'NF'
        'North Macedonia' = 'MK'
        'Northern Mariana Islands' = 'MP'
        'Norway' = 'NO'
        'Oman' = 'OM'
        'Pakistan' = 'PK'
        'Palau' = 'PW'
        'Palestine, State of' = 'PS'
        'Panama' = 'PA'
        'Papua New Guinea' = 'PG'
        'Paraguay' = 'PY'
        'Peru' = 'PE'
        'Philippines' = 'PH'
        'Pitcairn' = 'PN'
        'Poland' = 'PL'
        'Portugal' = 'PT'
        'Puerto Rico' = 'PR'
        'Qatar' = 'QA'
        'Reunion' = 'RE'
        'Romania' = 'RO'
        'Russian Federation' = 'RU'
        'Rwanda' = 'RW'
        'Saint Barthelemy' = 'BL'
        'Saint Helena, Ascension and Tristan da Cunha' = 'SH'
        'Saint Kitts and Nevis' = 'KN'
        'Saint Lucia' = 'LC'
        'Saint Martin (French part)' = 'MF'
        'Saint Pierre and Miquelon' = 'PM'
        'Saint Vincent and the Grenadines' = 'VC'
        'Samoa' = 'WS'
        'San Marino' = 'SM'
        'Sao Tome and Principe' = 'ST'
        'Saudi Arabia' = 'SA'
        'Senegal' = 'SN'
        'Serbia' = 'RS'
        'Seychelles' = 'SC'
        'Sierra Leone' = 'SL'
        'Singapore' = 'SG'
        'Sint Maarten (Dutch part)' = 'SX'
        'Slovakia' = 'SK'
        'Slovenia' = 'SI'
        'Solomon Islands' = 'SB'
        'Somalia' = 'SO'
        'South Africa' = 'ZA'
        'South Georgia and the South Sandwich Islands' = 'GS'
        'South Sudan' = 'SS'
        'Spain' = 'ES'
        'Sri Lanka' = 'LK'
        'Sudan' = 'SD'
        'Suriname' = 'SR'
        'Svalbard and Jan Mayen' = 'SJ'
        'Sweden' = 'SE'
        'Switzerland' = 'CH'
        'Syrian Arab Republic' = 'SY'
        'Taiwan, Province of China' = 'TW'
        'Tajikistan' = 'TJ'
        'Tanzania, United Republic of' = 'TZ'
        'Thailand' = 'TH'
        'Timor-Leste' = 'TL'
        'Togo' = 'TG'
        'Tokelau' = 'TK'
        'Tonga' = 'TO'
        'Trinidad and Tobago' = 'TT'
        'Tunisia' = 'TN'
        'Turkey' = 'TR'
        'Turkmenistan' = 'TM'
        'Turks and Caicos Islands' = 'TC'
        'Tuvalu' = 'TV'
        'Uganda' = 'UG'
        'Ukraine' = 'UA'
        'United Arab Emirates' = 'AE'
        'United Kingdom' = 'GB'
        'United States of America' = 'US'
        'United States Minor Outlying Islands' = 'UM'
        'Uruguay' = 'UY'
        'Uzbekistan' = 'UZ'
        'Vanuatu' = 'VU'
        'Venezuela (Bolivarian Republic of)' = 'VE'
        'Viet Nam' = 'VN'
        'Virgin Islands (British)' = 'VG'
        'Virgin Islands (U.S.)' = 'VI'
        'Wallis and Futuna' = 'WF'
        'Western Sahara' = 'EH'
        'Yemen' = 'YE'
        'Zambia' = 'ZM'
        'Zimbabwe' = 'ZW'
    }

    function Get-CountryCode {
        param (
            [string]$countryName
        )

        if ($countryName.Length -eq 2) {
            return $countryName
        } else {
            return $countryCodeMapping[$countryName]
        }
    }

    try {
        $allLines = Get-Content -Path $filePath

        $headers = $allLines[0] -split ';'
        $dataRows = $allLines | Select-Object -Skip 1

        $selectedColumns = @('@timestamp', 'source.ip', 'source.user.email', 'watcher.state', 'source.geo.country_name')

        $csvData = Import-Csv -Path $filePath
        $csvData = $dataRows | ForEach-Object {
            $data = $_ -split ';'
            $properties = [ordered]@{}
            for ($i = 0; $i -lt $headers.Length; $i++) {
                if ($headers[$i] -in $selectedColumns) {
                    $properties[$headers[$i]] = $data[$i]
                }
            }

            if ($properties['source.user.email']) {
                $adUser = Get-ADUser -Filter "mail -eq '$($properties['source.user.email'])'" -Properties co -ErrorAction SilentlyContinue
                if ($adUser) {
                    $properties['ADCountryName'] = $adUser.co
                } else {
                    # Extract the user logon name (name.surname) part from the email
                    $userLogonName = $properties['source.user.email'] -split "@" | Select-Object -First 1
            
                    # Attempt to find a user by user logon name
                    $adUser = Get-ADUser -Filter "SamAccountName -eq '$userLogonName'" -Properties co -ErrorAction SilentlyContinue
            
                    if ($adUser) {
                        $properties['ADCountryName'] = $adUser.co
                    } else {
                        $properties['ADCountryName'] = 'Manual'
                    }
                }
            } else {
                $properties['ADCountryName'] = 'No Email'
            }
            
            if ($properties['ADCountryName'] -eq 'Manual') {
                $properties['CountryMatched'] = 'Manual'
            } elseif ($properties['ADCountryName'] -eq 'Not Found' -or $properties['ADCountryName'] -eq 'No Email') {
                $properties['CountryMatched'] = $properties['ADCountryName']
            } else {
                $sourceCountryCode = Get-CountryCode -countryName $properties['source.geo.country_name']
                $adCountryCode = Get-CountryCode -countryName $properties['ADCountryName']
            
                if ($sourceCountryCode -eq $adCountryCode -or $properties['source.geo.country_name'] -eq $properties['ADCountryName']) {
                    $properties['CountryMatched'] = 'Match'
                } else {
                    $properties['CountryMatched'] = 'Not Match'
                }
            }                        

            New-Object -TypeName PSObject -Property $properties
        }

        return $csvData
    } catch {
        Write-Host "Error loading CSV file: $_"
        return $null
    }
}

# This function processes and displays information about the loaded CSV data
function Process-Data {
    param (
        [object]$df
    )

    $rowCount = ($df | Measure-Object).Count
    Write-Host "Rows: $rowCount"
    
    $df | Select-Object -Property '@timestamp', 'source.ip', 'source.user.email', 'watcher.state', 'source.geo.country_name', 'ADCountryName', 'CountryMatched' | Format-Table -AutoSize | Out-String -Width 2048 | Write-Host
}

# Entry point, it loads the CSV file and after it has been processed it saves the new DF into 2 csv(s)
function Main {
    $csvFile = 'path_to\alerts.csv' # Insert own path to alerts.csv
    $df = Load-Csv -filePath $csvFile

    if ($null -eq $df) {
        return
    }

    Process-Data -df $df

    # Add countries where your company has branches in:
    $branchCountries = @('Italy', 'Germany', 'France', 'Spain', 'Czechia', 'United Kingdom', '...')

    $df | Export-Csv -Path 'path_to\all_alerts.csv' -NoTypeInformation
    $dfNotMatchAndManual = $df | Where-Object { $_.CountryMatched -eq 'Not Match' -or $_.CountryMatched -eq 'Manual' }
    $dfNotMatchAndManual | Export-Csv -Path 'path_to\notMatched_alerts.csv' -NoTypeInformation

    # exporting the csv with countries that are not in $branchCountries
    $dfNotBranchCountries = $df | Where-Object { $branchCountries -notcontains $_.'source.geo.country_name'.Trim() }
    $dfNotBranchCountries | Export-Csv -Path 'path_to\notBranch_alerts.csv' -NoTypeInformation


    Write-Host "Export completed"
}


# Calling the entry point
Main