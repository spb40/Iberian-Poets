(: Finds archaic pronouns in sample.xml :)
xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $featureFile := doc('/db/course/iberian/aux/features.xml')
let $featureStructures := $featureFile//tei:fs
let $poem := doc('/db/course/iberian/data/sample.xml')
let $words := $poem//tei:w
(: let $archaic := $words[substring(@ana,2) = $featureStructures[contains(@feats,'#archaic')]/@xml:id] :)
let $archaic := $words[substring(@ana,2) = $featureStructures[tokenize(@feats/string(),'\s+') = '#archaic']/@xml:id]
return $archaic