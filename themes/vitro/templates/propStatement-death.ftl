<#--  
     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.  
 -->
<@showBirth statement />

<#-- Use a macro to keep variable assignments local; otherwise the values carry over to the
     next statement -->
<#macro showBirth statement>
     
    <#if statement.date?has_content>
        <#local date = statement.date>
    </#if>
    <#if statement.place?has_content>
        <#local place = statement.place>
    <#if>
    <#if ! statement.date?has_content && ! statement.place?has_content>
        ${statement.death}
    <#else>
        <@s.join [ date!, place! ] /> 
    </#if>
    
     
</#macro>