<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- this is in request.subject.name -->

<#-- leaving this edit/add mode code in for reference in case we decide we need it -->

<#import "lib-vivo-form.ftl" as lvf>

<#--Retrieve certain edit configuration information-->
<#if editConfiguration.objectUri?has_content>
    <#assign editMode = "edit">
<#else>
    <#assign editMode = "add">
</#if>

<#assign htmlForElements = editConfiguration.pageData.htmlForElements />

<#--Retrieve variables needed-->
<#assign date = lvf.getFormFieldValue(editSubmission, editConfiguration, "date") />
<#assign place = lvf.getFormFieldValue(editSubmission, editConfiguration, "place") />

<#--If edit submission exists, then retrieve validation errors if they exist-->
<#if editSubmission?has_content && editSubmission.submissionExists = true && editSubmission.validationErrors?has_content>
    <#assign submissionErrors = editSubmission.validationErrors/>
</#if>

<#if editMode == "edit">    
        <#assign titleVerb="Edit">        
        <#assign submitButtonText="Save changes">
        <#assign disabledVal="disabled">
<#else>
        <#assign titleVerb="Create">        
        <#assign submitButtonText="Create">
        <#assign disabledVal=""/>
</#if>

<#assign requiredHint = "<span class='requiredHint'> *</span>" />

<h2>${titleVerb}&nbsp;birth of ${editConfiguration.subjectName}</h2>

<#--Display error messages if any-->
<#if submissionErrors?has_content>
    <section id="error-alert" role="alert">
        <img src="${urls.images}/iconAlert.png" width="24" height="24" alert="error_alert_icon" />
        <p>
        </p>
    </section>
</#if>

<@lvf.unsupportedBrowser urls.base /> 

<section id="addBirthToPerson" role="region">        
    
    <form id="addBirthToPerson" class="customForm noIE67" action="${submitUrl}"  role="add/edit birth">

        <p>
            <label for="date">date ${requiredHint}</label>
            <input  size="40"  type="text" id="date" name="date" value="${date}" />
        </p>
    
        <p>
            <label for="place">place</label>
            <input  size="40"  type="text" id="place" name="place" value="${place}" />
            <#--<input  type="hidden" id="place" name="place" value="${place}" />-->
        </p>


        <input type="hidden" id="editKey" name="editKey" value="${editKey}"/>

        <p class="submit">
            <input type="submit" id="submit" value="${submitButtonText}"/><span class="or"> or </span>
            <a class="cancel" href="${cancelUrl}" title="cancel">Cancel</a>
        </p>

        <p id="requiredLegend" class="requiredHint">* required fields</p>

    </form>

</section>

<#--
<script type="text/javascript">
 $(document).ready(function(){
    mailingAddressUtils.onLoad('${editMode}');
}); 
</script>
-->
 
${stylesheets.add('<link rel="stylesheet" href="${urls.base}/js/jquery-ui/css/smoothness/jquery-ui-1.8.9.custom.css" />')}
${stylesheets.add('<link rel="stylesheet" href="${urls.base}/templates/freemarker/edit/forms/css/customForm.css" />')}
<#-- ${stylesheets.add('<link rel="stylesheet" href="${urls.base}/templates/freemarker/edit/forms/css/customFormWithAutocomplete.css" />')} -->

${scripts.add('<script type="text/javascript" src="${urls.base}/js/jquery-ui/js/jquery-ui-1.8.9.custom.min.js"></script>',
             '<script type="text/javascript" src="${urls.base}/js/extensions/String.js"></script>',
             <#-- '<script type="text/javascript" src="${urls.base}/templates/freemarker/edit/forms/js/mailingAddressUtils.js"></script>', -->
             '<script type="text/javascript" src="${urls.base}/js/browserUtils.js"></script>',
             '<script type="text/javascript" src="${urls.base}/js/jquery_plugins/jquery.bgiframe.pack.js"></script>')}


