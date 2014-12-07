<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <ns prefix="tei" uri="http://www.tei-c.org/ns/1.0"/>
    <let name="featureFile" value="doc('features.xml')"/>
    <let name="featureStructures" value="$featureFile//tei:fs/@xml:id"/>
    <pattern>
        <rule context="tei:w">
            <assert test="@ana">This w element does not have an @ana attribute</assert>
            <assert test="if (@ana) then substring(@ana,2) = $featureStructures else true()">The value of the @ana
                attribute does not occur in the list of feature structures</assert>
        </rule>
    </pattern>
</schema>
