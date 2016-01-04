<?php
namespace Craft;

class MailchimpSubscribe_ListController extends BaseController {

  /**
   * Main subscribe action
   *
   * @author André Elvan
   */

  protected $allowAnonymous = true;

  public function actionSubscribe() {

    // get post variables
    $email = craft()->request->getParam('email', '');
    $formListId = craft()->request->getParam('lid', '');
    $vars = craft()->request->getParam('mcvars', array());
    $redirect = craft()->request->getParam('redirect', '');

    if ($email!='' && $this->_validateEmail($email)) { // validate email

      // include mailchimp api class
      require_once(CRAFT_PLUGINS_PATH.'mailchimpsubscribe/vendor/mcapi/MCAPI.class.php');

      // get plugin settings
      // passes list id from form value lid
      $settings = $this->_init_settings();

      $listIdStr =  $formListId != '' ? $formListId : $settings['mcsubListId'];

      // check if we got an api key and a list id
      if ($settings['mcsubApikey']!='' && $listIdStr!='') {

        // create a new api instance, and subscribe
        $api = new \MCAPI($settings['mcsubApikey']);

        // split id string on | in case more than one list id is supplied
        $listIdArr = explode("|", $listIdStr);

        // convert groups to input format if present
        if( isset($vars['group']) && count($vars['group']) ) {
          $vars['GROUPINGS'] = array();
          foreach($vars['group'] as $key=>$vals) {
            $vars['GROUPINGS'][] = array('id'=>$key,'groups'=>implode(',',$vals));
          }
        }
        
        // loop over list id's and subscribe
        foreach ($listIdArr as $listId) {
          $retval = $api->listSubscribe($listId, $email, $vars, $emailType = 'html', $settings['mcsubDoubleOptIn']);
        }

        if ($api->errorCode) {
          // an API error occurred
          $this->_setMessage($api->errorCode, $email, $vars, $api->errorMessage);
        } else {
          // list subscribe was successful
          $this->_setMessage(200, $email, $vars, "Subscribed successfully", true, $redirect);
        }

      } else {
        // error, no API key or list id
        $this->_setMessage(2000, $email, $vars, "API Key or List ID not supplied. Check your settings.");
      }

    } else { 
      // error, invalid email
      $this->_setMessage(1000, $email, $vars, "Invalid email");
    }

  }


  public function actionCheckIfSubscribed (){

    // get post variables
    $email = craft()->request->getParam('email', '');
    $formListId = craft()->request->getParam('lid', '');
    $vars = craft()->request->getParam('mcvars', array());
    $redirect = craft()->request->getParam('redirect', '');

    if ($email!='' && $this->_validateEmail($email)) { // validate email

      // include mailchimp api class
      require_once(CRAFT_PLUGINS_PATH.'mailchimpsubscribe/vendor/mcapi/MCAPI.class.php');

      // get plugin settings
      // passes list id from form value lid
      $settings = $this->_init_settings();

      $listIdStr =  $formListId != '' ? $formListId : $settings['mcsubListId'];

      // check if we got an api key and a list id
      if ($settings['mcsubApikey']!='' && $listIdStr!='') {

        // create a new api instance, and check if this user is on this list
        $api = new \MCAPI($settings['mcsubApikey']);
        
        $retval = $api->listMemberInfo($listIdStr, $email);

        if ($api->errorCode) {
          // an API error occurred
          $this->_setMessage($api->errorCode, $email, $vars, $api->errorMessage);
        } else {
          if($retval['errors']){
            $this->_setMessage(1000, $email, $vars, "The email address passed does not exist on this list", false, $redirect);
          }else{
            $vars['subscriberInfo'] = $retval;
            $this->_setMessage(200, $email, $vars, "The email address passed exists on this list", true, $redirect);
          }
        }

      } else {
        // error, no API key or list id
        $this->_setMessage(2000, $email, $vars, "API Key or List ID not supplied. Check your settings.", false, $redirect);
      }

    } else { 
      // error, invalid email
      $this->_setMessage(1000, $email, $vars, "Invalid email", false, $redirect);
    }

  }




  /**
  * Set a message for use in the templates
  *
  * @author Martin Blackburn
  */
  private function _setMessage($errorcode, $email, $vars, $message = '', $success = false, $redirect = '')
  {
    if (craft()->request->isAjaxRequest()) {
      return $this->returnJson(array(
          'success' => $success,
          'errorCode' => $errorcode,
          'message' => $message,
          'values' => array(
            'email' => $email,
            'vars' => $vars
        )
      ));
    }

    if ($redirect!='') {
      // if a redirect url was set in template form, redirect to this
      $this->redirectToPostedUrl();
    } else {
      craft()->urlManager->setRouteVariables(array(
          'mailchimpSubscribe' => array(
            'success' => $success,
            'errorCode' => $errorcode,
            'message' => $message,
            'values' => array(
              'email' => $email,
              'vars' => $vars
          )
        )
      ));
    }
  }

  /**
   * Gets plugin settings, either from saved settings or from config
   * List ID can originate via the form, settings or from config.
   *
   * @return array Array containing all settings
   * @author André Elvan
   */
  private function _init_settings() {
    $plugin = craft()->plugins->getPlugin('mailchimpsubscribe');
    $plugin_settings = $plugin->getSettings();

    $settings = array();
    $settings['mcsubApikey'] = craft()->config->get('mcsubApikey')!==null ? craft()->config->get('mcsubApikey') : $plugin_settings['mcsubApikey'];
    $settings['mcsubListId'] = craft()->config->get('mcsubListId')!==null ? craft()->config->get('mcsubListId') : $plugin_settings['mcsubListId'];
    $settings['mcsubDoubleOptIn'] = craft()->config->get('mcsubDoubleOptIn')!==null ? craft()->config->get('mcsubDoubleOptIn') : $plugin_settings['mcsubDoubleOptIn'];

    return $settings;
  }

  /**
   * Validate an email address.
   * Provide email address (raw input)
   * Returns true if the email address has the email
   * address format and the domain exists.
   *
   * @param string Email to validate
   * @return boolean
   * @author André Elvan
  */
  private function _validateEmail ($email) {
    $isValid = true;
    $atIndex = strrpos($email, "@");
    if (is_bool($atIndex) && !$atIndex)
    {
      $isValid = false;
    }
    else
    {
      $domain = substr($email, $atIndex+1);
      $local = substr($email, 0, $atIndex);
      $localLen = strlen($local);
      $domainLen = strlen($domain);
      if ($localLen < 1 || $localLen > 64)
      {
        // local part length exceeded
        $isValid = false;
      }
      else if ($domainLen < 1 || $domainLen > 255)
      {
        // domain part length exceeded
        $isValid = false;
      }
      else if ($local[0] == '.' || $local[$localLen-1] == '.')
      {
        // local part starts or ends with '.'
        $isValid = false;
      }
      else if (preg_match('/\\.\\./', $local))
      {
        // local part has two consecutive dots
        $isValid = false;
      }
      else if (!preg_match('/^[A-Za-z0-9\\-\\.]+$/', $domain))
      {
        // character not valid in domain part
        $isValid = false;
      }
      else if (preg_match('/\\.\\./', $domain))
      {
        // domain part has two consecutive dots
        $isValid = false;
      }
      else if
      (!preg_match('/^(\\\\.|[A-Za-z0-9!#%&`_=\\/$\'*+?^{}|~.-])+$/',
        str_replace("\\\\","",$local)))
      {
        // character not valid in local part unless
        // local part is quoted
        if (!preg_match('/^"(\\\\"|[^"])+"$/',
          str_replace("\\\\","",$local)))
        {
          $isValid = false;
        }
      }
      if ($isValid && !(checkdnsrr($domain,"MX") || checkdnsrr($domain,"A")))
      {
        // domain not found in DNS
        $isValid = false;
      }
    }
    return $isValid;
  }
}
