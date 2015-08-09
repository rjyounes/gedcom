<#--  
     This template must be self-contained and not rely on other variables set for the individual page, because it
     is also used to generate the property statement during a deletion.  
 -->
 
<#import "lib-sequence.ftl" as s>
<@showBirth statement />

<#-- Use a macro to keep variable assignments local; otherwise the values carry over to the
     next statement -->
     
<#macro showBirth statement>

    <#if statement.date?has_content>
       ${statement.date}
       <#if statement.place?has_content>
           in ${statement.place}
       </#if>
    <#else>
        ${statement.place}
    </#if>
         
</#macro>
