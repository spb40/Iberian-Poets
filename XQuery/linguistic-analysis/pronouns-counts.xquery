xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
let $docTexts := doc('/course/iberian/data/songTextsThirdTry.xml')/tei:TEI
let $docFeat := doc('/course/iberian/aux/features.xml')/tei:TEI
let $period := $docTexts//tei:div[descendant::tei:affiliation/@corresp='5']
let $modern := $period//tei:w[substring(@ana,2) = $docFeat//tei:fs[tokenize(@feats/string(),'\s+') = '#modern']/@xml:id]
 return $modern