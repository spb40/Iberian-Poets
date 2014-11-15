xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare default element namespace "http://www.w3.org/1999/xhtml";
let $personography:= doc('/db/course/iberian/data/personography.xml')
return
 <html>
    <head>
        <title>Poets - Medieval Galician-Portuguese Poetry</title>
        <link href="index.css" rel="stylesheet" type="text/css" />
    </head>
        <body>
            <!--#include virtual="NavMenu.html" -->
            <h2>About the poets</h2>
            <p>Lydia's introduction</p>
            <h2>Data</h2>
            <table border="1" class="sortable">
                <tr>
                    <th>Poet</th>
                    <th>Nationality</th>
                    <th>Social Status</th>
                    <th>Occupation</th>
                    <th>Affiliation and <em>floruit</em></th>
                    <th>Period</th>
                </tr>
                {for $person in $personography//tei:person
                order by $person
                return
                <tr>
                    <td class="first">{$person//tei:persName/string()                        
                    }</td>
                    <td>{
                        for $nationality in $person
                        return
                            $person//tei:nationality/string()                        
                    }</td>
                    <td>{
                        for $status in $person
                           return
                               $person//tei:socecStatus/string()
                        }</td>
                         <td>{
                        for $occupation in $person
                        return
                            $person//tei:occupation/string()                        
                        }</td>
                        <td>
                            {
                           for $affiliation in $person                           
                           let $references:= $personography//tei:place[(@xml:id ) = 
                           $person/tei:floruit/tei:location/substring((@corresp), 2)]
                           let $floruit:= concat(($person/tei:floruit/@from),'-',($person/tei:floruit/@to))
                           let $location:= $person/tei:floruit//tei:location[@from]                                    
                           return                            
                            if (($person//tei:location/@corresp) and (not($person/tei:floruit//tei:location/@from)))                                 
                           then
                               for $reference in $references//tei:placeName[@type='short']/string()
                               return
                                   <p>{$reference||' ('||$floruit||')'}</p>
                            else
                                if ($person//tei:location[@corresp and @from])
                                then
                                    for $specific in $location
                                    for $reference in $personography//tei:place[(@xml:id ) = 
                                    $person/tei:floruit/$specific/substring((@corresp), 2)]//tei:placeName[@type='short']/string()
                                    return
                                        <p>{$reference||' ('||$specific/@from||'-'||$specific/@to||')'}</p>
                                else
                                    for $place in $person
                                    return
                                        <p>{$person/tei:floruit//tei:location/tei:placeName/string()||' ('||$floruit||')'}</p>
                        }                            
                        </td>
                        <td>{
                            for $period in $person
                            return
                                $person//tei:floruit/@period/string()
                        }</td>
                </tr>}
            </table>
            <h2>Some statistics</h2>
            <h3>Nationalities</h3>
            <svg xmlns="http://www.w3.org/2000/svg" width="800" height="200">
            {
                for $nationality at $pos in 
                    for $i in distinct-values($personography//tei:nationality)
                    order by count($personography//tei:person[./tei:nationality = $i]) descending
                    return $i                  
                let $count:= count($personography//tei:person[./tei:nationality = $nationality])
                let $sum:= count($personography//tei:nationality)
                let $percentage:= round-half-to-even((100 * $count div $sum), 2)
                order by $count descending
                return
                    <g>
                        <rect            
                            fill="#D45710"
                            height="20"
                            width="{$count * 15}"
                            x="137"
                            y="{$pos *20}"
                            stroke="black"
                            stroke-width="2"/>
                        <text
                           fill="white"
                           font-size="12"
                           x="{147+ $count * 15}"
                           y="{$pos *20 + 14}"
                        >{' ('||$percentage||'%)'}</text>
                        <text
                        fill="white"
                        x="0"
                        y="{$pos *20 + 18}"
                        >{$nationality}</text>
                    </g>
            }</svg>
                
            <h3>Social Status</h3>
            <svg xmlns="http://www.w3.org/2000/svg" width="840" height="145">
            {
                for $status at $pos in 
                    for $i in distinct-values($personography//tei:socecStatus)
                    order by count($personography//tei:person[./tei:socecStatus = $i]) descending
                    return $i                  
                let $count:= count($personography//tei:person[./tei:socecStatus = $status])
                let $sum:= count($personography//$personography//tei:socecStatus)
                let $percentage:= round-half-to-even((100 * $count div $sum), 2)
                order by $count descending
                return
                    <g>
                        <rect            
                            fill="#D45710"
                            height="20"
                            width="{$count * 15}"
                            x="137"
                            y="{$pos *20}"
                            stroke="black"
                            stroke-width="2"/>
                        <text
                           fill="white"
                           font-size="12"
                           x="{147+ $count * 15}"
                           y="{$pos *20 + 14}"
                        >{' ('||$percentage||'%)'}</text>
                        <text
                        fill="white"
                        x="0"
                        y="{$pos *20 + 18}"
                        >{$status}</text>
                    </g>
                }</svg>
                
            <h3>Occupations</h3>
             <svg xmlns="http://www.w3.org/2000/svg" width="1100" height="110">
            {
                for $job at $pos in
                    for $i in distinct-values($personography//tei:occupation)
                    order by count($personography//tei:person[./tei:occupation = $i]) descending
                    return $i                         
                let $count:= count($personography//tei:person[./tei:occupation = $job])
                let $sum:= count($personography//$personography//tei:occupation)
                let $percentage:= round-half-to-even((100 * $count div $sum), 2)
                order by $count descending
                return
                    <g>
                        <rect            
                            fill="#D45710"
                            height="20"
                            width="{$count * 15}"
                            x="137"
                            y="{$pos *20}"
                            stroke="black"
                            stroke-width="2"/>
                        <text
                           fill="white"
                           font-size="12"
                           x="{147+ $count * 15}"
                           y="{$pos *20 + 14}"
                        >{' ('||$percentage||'%)'}</text>
                        <text
                        fill="white"
                        x="0"
                        y="{$pos *20 + 18}"
                        >{$job}</text>
                    </g>
            }</svg>
            <h3>Periods</h3>
             <svg xmlns="http://www.w3.org/2000/svg" width="950" height="125">
            {                        
              for $period at $pos in
              for $i in distinct-values($personography//tei:floruit/@period) 
              order by count($personography//tei:person[./tei:floruit/@period = $i]) descending
                    return $i  
              let $count:= count($personography//tei:person[./tei:floruit/@period = $period])
              let $sum:= count($personography//tei:floruit/@period)
              let $percentage:= round-half-to-even((100 * $count div $sum), 2)
              order by $count descending
              return
                   <g>
                        <rect            
                            fill="#D45710"
                            height="20"
                            width="{$count * 15}"
                            x="137"
                            y="{$pos *20}"
                            stroke="black"
                            stroke-width="2"/>
                        <text
                           fill="white"
                           font-size="12"
                           x="{147+ $count * 15}"
                           y="{$pos *20 + 14}"
                        >{' ('||$percentage||'%)'}</text>
                        <text
                        fill="white"
                        x="0"
                        y="{$pos *20 + 18}"
                        >{$period}</text>
                    </g>
            }</svg>
        </body>
    </html>
    
    