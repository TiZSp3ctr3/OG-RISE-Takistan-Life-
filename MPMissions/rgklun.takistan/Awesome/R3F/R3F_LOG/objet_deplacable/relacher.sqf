/**
 * Passe la variable R3F_LOG_joueur_deplace_objet � objNull pour informer le script "deplacer" d'arr�ter de d�placer l'objet
 */

if (R3F_LOG_mutex_local_verrou) then
{
	player globalChat STR_R3F_LOG_mutex_action_en_cours;
}
else
{
	R3F_LOG_mutex_local_verrou = true;
	
	R3F_LOG_joueur_deplace_objet = objNull;
	uiSleep 2;
	
	R3F_LOG_mutex_local_verrou = false;
};