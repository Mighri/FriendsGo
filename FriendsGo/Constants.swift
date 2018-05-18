//
//  Constants.swift
//  FriendsGo
//
//  Created by Radhia Mighri on 22/03/2018.
//  Copyright © 2018 Radhia Mighri. All rights reserved.
//

class MyClass {
 
    struct Constants {
        //000Webhost
       //static let BaseURL = "http://lengthways-dopes.000webhostapp.com/"
        // Pc-Faster : 192.168.101.13
      //static let BaseURL = "http://192.168.101.13/"

        // Chifco : 192.168.10.143
       static let BaseURL = "http://192.168.10.143/"
        
        // class ViewController
        static let urlAuthMail = BaseURL+"getUtilisateurs.php"
        static let urlRegisterFBG = BaseURL+"registerUserFBK.php"
        static let urlverifUser = BaseURL+"verifUserInscri.php"
        static let urlupdateUser = BaseURL+"updateUserFBG.php"
        
        // class RegisterUserViewController
        static let urlRegisterMail = BaseURL+"registerUser.php"
        
       // static let  urlverifUser = BaseURL+"verifUserInscri.php"
        
        // class ListeContactViewController
        static let urlDeleteContact = BaseURL+"deleteContact.php"
        static let urlgetContacts = BaseURL+"getContacts.php"
        static let urlAddTelephoneContact = BaseURL+"addTelephoneContact.php"
        
        // class SearchViewController
        static let urlgetUsers = BaseURL+"getUsers.php"
        static let urlInvitationFG = BaseURL+"invitationFriendsGo.php"
        static let urlverifInvitation = BaseURL+"verifInvitation.php"

        
        // class AmisViewController
        static let urlgetAmis = BaseURL+"getAmis.php"
        
        // class importViewController
        static let urlRegisterContact = BaseURL+"registerContact.php"
        static let urlUserContact = BaseURL+"User-Contact.php"
        
        // class InvitationViewController
        
        static let urlgetInvitations = BaseURL+"getInviteurs.php"
         static let urlUpdateInvitation = BaseURL+"updateInvitation.php"
        static let urlDeleteInvitation = BaseURL+"deleteInvitation.php"
        
        static let urlgetEvents = BaseURL+"getEvents.php"
        static let urlAddEvent = BaseURL+"addEvent.php"
       
        
        static let urlGetUsername = BaseURL+"getUsername.php"
        static let urlDeleteEvent = BaseURL+"deleteEvent.php"
        static let urlUpdateEvent = BaseURL+"updateEvent.php"
        
        
        static let urlInvitationEventFG = BaseURL+"invitationEventFG.php"
        
        static let urlUpdateInvEvent = BaseURL+"updateInvEvent.php"
        
        static let urlGetInvEvent = BaseURL+"getInvEvent.php"
       
        static let urlDeleteInvEvent = BaseURL+"deleteInvEvent.php"
        
        static let urlInvEventFG = BaseURL+"invEventFG.php"
        
        static let urlGetInteresed = BaseURL+"getInterested.php"
           static let urlGetParticipated = BaseURL+"getParticipated.php"
           static let urlGetNonParticipated = BaseURL+"getNonParticipated.php"
        
         static let urlImportContactsFBG = BaseURL+"importContactsFBG.php"
        
        static let urlgetCorrespondance = BaseURL+"getCorrespondance.php"
        
         static let urlAddPosition = BaseURL+"addPosition.php"
        
         static let urlGetPosition = BaseURL+"getPosition.php"
        
         static let urlUpdatePosition = BaseURL+"updatePosition.php"
        
        static let urlGetLocations = BaseURL+"getLocations.php"
       
        static let urlGetFriendsOnMap = BaseURL+"getFriendsOnMap.php"
        
    }
}
