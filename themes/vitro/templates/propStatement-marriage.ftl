<#--  
     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.  
 -->
<@showMarriage marriage />

<#-- Use a macro to keep variable assignments local; otherwise the values carry over to the
     next statement -->
<#macro showMarriage statement>
 
    <#if statement.emailAddress?has_content>
            ${statement.emailAddress}
    </#if>    
          
</#macro>