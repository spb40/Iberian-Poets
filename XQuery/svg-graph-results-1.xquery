xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare default element namespace "http://www.w3.org/1999/xhtml";
let $personography:= doc('/db/course/iberian/data/personography.xml')
let $person:= $personography//tei:person
let $nationalities:= distinct-values($person/tei:nationality)
return
    <svg xmlns="http://www.w3.org/2000/svg" width="2000" height="125">
            {                        
              for $period at $pos in
              for $i in distinct-values($personography//tei:floruit/@period) 
              order by count($personography//tei:person[./tei:floruit/@period = $i]) descending
                    return $i  
              let $count:= count($personography//tei:person[./tei:floruit/@period = $period])
              let $sum:= count($personography//tei:floruit/@period)
              let $percentage:= round-half-to-even((100 * $count div $sum), 2)
              order by $period
              return
                   <g>
                        <rect            
                            fill="none"
                            height="20"
                            width="{$count * 25}"
                            x="137"
                            y="{$pos *20}"
                            stroke="black"
                            stroke-width="2"/>
                        <text
                           fill="white"
                           font-size="12"
                           x="{147+ $count * 25}"
                           y="{$pos *20 + 14}"
                        >{' ('||$percentage||'%)'}</text>
                        <text
                        fill="white"
                        x="0"
                        y="{$pos *20 + 18}"
                        >{$period} period</text>
                            {for $origin (:at $position in
                            for $x:) in $nationalities
                            (:order by count($personography//tei:person[./tei:floruit/@period = $period][./tei:nationality=$x]) descending
                            return $x :)
                            let $number:= count($personography//tei:person[./tei:floruit/@period = $period]
                            [./tei:nationality=$origin])
                            
                            let $total:=count($personography//tei:person[./tei:floruit/@period = $period][./tei:nationality])
                            let $percent:= round-half-to-even((100 * $number div $total), 1)
                            order by $number descending
                            return
                            if ($percent > 0)
                            then
                                <g>                                    
                                    <rect
                                    fill="
                                        {if ($origin = "Galician")
                                        then 
                                            "#ffed67"
                                            else if ($origin = "Aragonese")
                                            then
                                               "#75CC50"
                                                else if (($origin="Castilian") or ($origin="Sevillan") or
                                                ($origin="Leonese"))
                                                then
                                                "#008F8D"
                                                else if ($origin="Genovese")
                                                then
                                                "#ffff7d"
                                                else if ($origin="Occitan")
                                                then
                                                "#E89301"
                                                else
                                                    "#d45710"}"                                                
                                         
                                    height="20"
                                    width="{$number * 25}"
                                    x="{137}"
                                    y="{$pos *20}"
                                    />
                                    <text
                                    font-size="9"
                                    fill="black"
                                    y="{$pos *20 + 10}"
                                    x="137"                                    
                                    >{$percent||'%'}
                                    </text>
                                </g>
                                else
                                   ''
                            }
                        </g>
            }</svg>
