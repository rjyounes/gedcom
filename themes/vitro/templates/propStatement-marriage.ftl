<#--  
     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.  
 -->
<#import "lib-sequence.ftl" as s> 
<@showMarriage statement />

<#-- Use a macro to keep variable assignments local; otherwise the values carry over to the
     next statement -->
<#macro showMarriage statement>

    <!--
    <#if statement.spouse1name?has_content>
        ${statement.spouse1name} 
    </#if>
    <#if statement.spouse2name?has_content>
        ${statement.spouse2name} 
    </#if>
    <#if statement.date?has_content>
        on ${statement.date} 
    </#if>
    <#if statement.place?has_content>
        in ${statement.place} 
    </#if>
    -->

    <#if statement.spouse1name?has_content>
        <#local spouse1name = statement.spouse1name>
    </#if>
    <#if statement.spouse2name?has_content>
        <#local spouse2name = statement.spouse2name>
    </#if>
    <@s.join [ spouse1name!, spouse2name! ], "&nbsp;and&nbsp;" />
    
    <#if statement.date?has_content>
        on ${statement.date} 
    </#if>
    <#if statement.place?has_content>
        in ${statement.place} 
    </#if>  
     
</#macro>