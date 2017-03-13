# MadEmojiMineSweeper

##Installation 

- Cloner ce depot. 
- Lancer le fichier MadMineSweepper.xcodeproj avec Xcode 8 (Swift 3). 
- Lancer l'application sur le simulateur


## Architecture 
- Le code est orienté objet avec pas mal de concept qui viennent du Paradigme fonctionnel, le tout est tres "Swifty" 
- Le projet est base sur du MVC plutot classique. 
Il y a donc les Models, Le `Controller` et le Moteur De Jeu (GameEngine). 

Le moteur de Jeu est l'entite referente des règles du jeu, qui permet de savoir si le jeu est terminé, qui crée la grille en fonction de la `GameDifficulty` selectionnee. 
Le `GameEngine` se charge egalement de la  mise à jour l'etat de la `Grid`.
*Seul le GameEngine modifie la Grid, la GridView n'y accede qu'en Lecture*
La GridView est en charge d'afficher la `Grid`. 

Le Controller Fait le pont entre le `GameEngine` et la `GridView`. 
Il n'y a donc aucune dependance entre le `GameEngine` et la `GridView`. 
Les remontées de donnees et d'informations se font en utilisant un systeme de Protocol Delegate.
J'ai mis quelques commentaires dans le code pour que ce soit faicile a comprendre

J'ai fait le choix d'utiliser UIKit (La librairie systeme d'UI sur iOS) car pour le cadre fonctionnel c'est bien suffisant et je n'ai pas intégre de Librairies Tierces.
###les principaux models : 
- Cell (Une case)    
- Grid (La grille qui contient les cells)
- CellType (un enum Swift qui vaut `empty` ou `bomb`)
- CellState (un enum qui indique si la Cell est `flagged`, `discovered` ou `hidden`
    
## Ameliorations Possibles 
- Ameliorer l'UI
- Ameliorer l'UI (Oui, elle est tres perfectible :) )
- Utiliser SpriteKit par exemple (Ou n'importe quel autre moteur 2D) afin d'avoir plus de libertés concernant les animations et plus de performances.
- Mettre en place un systeme de LeaderBoard avec les meilleurs scores etc)
