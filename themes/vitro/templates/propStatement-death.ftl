<#--  
     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.  
 -->
 
<#import "lib-sequence.ftl" as s> 
<@showDeath statement />

<#-- Use a macro to keep variable assignments local; otherwise the values carry over to the
     next statement -->
<#macro showDeath statement>
     
    <#-- 
    <#if statement.date?has_content>
       <#local date = statement.date>
    </#if>
    <#if statement.place?has_content>
       <#local place = statement.place>
    </#if>
    <@s.join [ date!, place! ], "&nbsp;in&nbsp; />
    -->
    
    <#if statement.date?has_content>
        ${statement.date}
        <#if statement.place?has_content>
             in ${statement.place}
        </#if>
    <#elseif statement.place?has_content>
        ${statement.place}
    </#if>
    
     
</#macro>