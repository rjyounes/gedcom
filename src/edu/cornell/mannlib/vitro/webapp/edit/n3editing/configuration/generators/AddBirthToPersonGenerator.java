package edu.cornell.mannlib.vitro.webapp.edit.n3editing.configuration.generators;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.hp.hpl.jena.vocabulary.XSD;

import edu.cornell.mannlib.vitro.webapp.controller.VitroRequest;
import edu.cornell.mannlib.vitro.webapp.edit.n3editing.VTwo.EditConfigurationVTwo;
import edu.cornell.mannlib.vitro.webapp.edit.n3editing.VTwo.fields.FieldVTwo;
import edu.cornell.mannlib.vitro.webapp.edit.n3editing.configuration.validators.AntiXssValidation;

public class AddBirthToPersonGenerator extends BaseEditConfigurationGenerator implements EditConfigurationGenerator {

    private Log log = LogFactory.getLog(AddBirthToPersonGenerator.class);
    private static String template = "addBirthToPerson.ftl";
    final static String gedcom = "http://www.daml.org/2001/01/gedcom/gedcom#";
    
    @Override
    public EditConfigurationVTwo getEditConfiguration(VitroRequest vreq,
            HttpSession session) throws Exception {
        
        EditConfigurationVTwo editConfiguration = new EditConfigurationVTwo();
        
        initBasics(editConfiguration, vreq);
        initPropertyParameters(vreq, session, editConfiguration);
        initObjectPropForm(editConfiguration, vreq);  
        String birthUri = vreq.getParameter("birthUri"); 
        
        editConfiguration.setTemplate(template);
        
        editConfiguration.setVarNameForSubject("subject");
        editConfiguration.setVarNameForPredicate("predicate");
        editConfiguration.setVarNameForObject("individualBirth");
        
        editConfiguration.setN3Required( Arrays.asList( n3ForNewBirth ) );
        editConfiguration.setN3Optional( Arrays.asList( dateAssertion, 
                                           placeAssertion ) );
        
        editConfiguration.addNewResource("individualBirth", DEFAULT_NS_FOR_NEW_RESOURCE);
                
        editConfiguration.setLiteralsOnForm(Arrays.asList("date", "place"));
        
        editConfiguration.addSparqlForExistingLiteral("date", dateQuery);
        editConfiguration.addSparqlForExistingLiteral("place", placeQuery);
        
        if ( editConfiguration.isUpdate() ) {
            HashMap<String, List<String>> urisInScope = new HashMap<String, List<String>>();
            urisInScope.put("individualBirth", Arrays.asList(new String[]{birthUri}));
            editConfiguration.addUrisInScope(urisInScope);
        }
        else {
            editConfiguration.addSparqlForAdditionalUrisInScope("individualBirth", individualBirthQuery);
        }

        editConfiguration.addField( new FieldVTwo().                        
                setName("date")
                .setRangeDatatypeUri( XSD.xstring.toString() ) 
                .setValidators( list("nonempty") ));

        editConfiguration.addField( new FieldVTwo().                        
                setName("place")
                .setRangeDatatypeUri( XSD.xstring.toString() ) );
                //setValidators( list("nonempty") ) );

        editConfiguration.addValidator(new AntiXssValidation());
        
        prepare(vreq, editConfiguration);
        return editConfiguration;
    }

    /* N3 assertions  */

    final static String n3ForNewBirth = 
        "?subject <" + gedcom + "birth>  ?individualBirth . \n" +
        "?individualBirth a <" + gedcom + "Birth> . \n" ;      
    
    final static String dateAssertion  =      
            "?individualBirth <" + gedcom + "date> ?date .";
        
    final static String placeAssertion  =      
            "?individualBirth <" + gedcom + "place> ?place .";

        
    /* Queries for editing an existing entry */

    final static String individualBirthQuery =
        "SELECT ?individualBirth WHERE { \n" +
        "?subject <" + gedcom + "birth>  ?individualBirth . \n" +
        "}";

    final static String dateQuery  =      
        "SELECT ?existingDate WHERE {\n"+
        "?individualBirth <" + gedcom + "date> ?existingDate . }";

    final static String placeQuery  =      
        "SELECT ?existingPlace WHERE {\n"+
        "?individualBirth <" + gedcom + "place> ?existingPlace . }";

}
