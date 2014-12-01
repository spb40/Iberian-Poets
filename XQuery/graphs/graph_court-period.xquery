xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
declare default element namespace "http://www.w3.org/1999/xhtml";
let $personography:= doc('/db/course/iberian/data/personography.xml')
let $person:= $personography//tei:person
let $types:= distinct-values(//tei:place/@type)
return
   <svg xmlns="http://www.w3.org/2000/svg" width="1100" height="125" class="poets">{
                                    
              for $period at $pos in 
              for $x in distinct-values($personography//tei:floruit/@period)
              order by $x
              return $x
              let $count:= count($personography//tei:person[./tei:floruit/@period = $period]/tei:floruit//tei:location)
              let $sum:= count($personography//tei:floruit/@period)
              let $percentage:= round-half-to-even((100 * $count div $sum), 2)
              order by $period
              return
                   <g>
                        <rect            
                            fill="none"
                            height="20"
                            width="{$count * 20}"
                            x="137"
                            y="{$pos *20}"
                            stroke="black"
                            stroke-width="2"/>
                        <text
                           fill="white"
                           font-size="12"
                           x="{147+ $count * 20}"
                           y="{$pos *20 + 14}"
                        >{' ('||$percentage||'%)'}</text>
                        <text
                        fill="white"
                        x="45"
                        y="{$pos *20 + 18}"
                        >{$period} period</text>
                           {for $court in $types
                  let $number:= count($personography//tei:location[parent::tei:floruit[@period = $period]]
                            [./substring(@corresp,2) = $personography//tei:place[@type = $court]/@xml:id]) +
                    count($personography//tei:floruit[@period = $period]/tei:location[not(@corresp)][@type = $court])
                            let $total:=count($personography//tei:person[tei:floruit[@period = $period]]/tei:floruit//tei:location)
                            let $percent:= round-half-to-even((100 * $number div $total), 1)
                            order by $court
                            return 
                            if ($percent > 0)
                            then
                                <g>                                    
                                    <rect
                                    fill="
                                        {if ($court = "noble")
                                        then 
                                            "#ffed67"
                                        
                                                else if ($court = "unknown")
                                                then
                                                "#008F8D"
                                                else
                                                    "#d45710"}"                                                
                                         
                                    height="20"
                                    width="{$number * 20}"
                                    x="{137}"
                                    y="{$pos *20}"
                                    />
                                    <text
                                    font-size="9"
                                    fill="black"
                                    y="{$pos *20 + 13}"
                                    x="{130 + ($number * 25 div 2)}"
                                    text-anchor="middle"
                                    >{$percent||'%'}
                                    </text>
                                </g>
                                else
                                   ''
                            }
                        </g>
            }</svg>
