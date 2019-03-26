# Mélèze

Mélèze (modèle économique linéarité d’équilibre en zone euro) est un modèle macroéconomique dynamique développé par l’Insee, 
représentant la zone euro et y distinguant la France d’une part, le reste de la zone euro d’autre part. 
Il s’agit d’un modèle néo-Keynésien de type DSGE (dynamic stochastich general equilibrium) : 
en particulier, la modélisation des comportements agrégés dérive d’un cadre théorique défini de façon exhaustive à l’échelle microéconomique, 
prenant en compte les anticipations des agents économiques (ménages, entreprises…) et autorisant l’existence de rigidités 
dans la fluctuation des grandeurs nominales (prix, salaires…) ou réelles (consommation, investissement…). 
Les modèles néo-Keynésiens de type DSGE sont apparus dans les années 1990 et se sont progressivement développés 
dans les institutions nationales et internationales, dont les banques centrales. 

## Utilisation

Mélèze a été développé dans le but de réaliser des études de l’impact ex ante de différentes mesures de politique économique, 
notamment fiscales et budgétaires, sur les grandeurs macroéconomiques comme le PIB, la consommation ou les prix. 
En effet, du fait de son cadre théorique exhaustif et de la prise en compte des anticipations des agents, 
Mélèze constitue un outil complémentaire au modèle Mésange et enrichit dès lors l’analyse. 
En outre, la modélisation retenue à deux zones (France et reste de la zone euro) permet une prise en compte plus fine 
des liens commerciaux et financiers de la France avec le reste de la zone euro. 
Enfin, à l’inverse de Mésange, Mélèze intègre également une modélisation explicite de la politique monétaire de la zone euro.

Mélèze peut également servir de base de modélisation pour étudier des problématiques macroéconomiques propres à la zone euro (coordination budgétaire…).


## Méthodologie

Le pas du modèle est trimestriel. La zone euro y est vue comme une économie « fermée » au sens où les échanges de la zone euro 
avec le reste du monde ne sont pas modélisés. Deux zones ou économies y sont distinguées : 
la France et les autres États membres de la zone euro. Le modèle décrit le comportement de trois types d’agents économiques 
au niveau de chaque économie (ménages, entreprises et gouvernement) 
et le comportement de la banque centrale au niveau de la zone euro dans son ensemble. 
Les différents types agents interagissent les uns avec les autres selon des comportements d’optimisation, 
chacun cherchant à rendre maximal le « bien-être » qui lui est propre, et l’équilibre qui en découle à chaque trimestre forme 
la dynamique du modèle. 

Le cadre théorique permet d’écrire à l’échelle microéconomique le comportement des différents types d’agents 
et d’en déduire, en les agrégeant, les comportements au niveau macroéconomique. 
Les paramètres du modèle sont fixés à partir de valeurs issues de la littérature économiques 
ou de façon à répliquer des ratios ou niveaux empiriques observés sur les décennies précédant la crise de 2008. 

À partir du cadre théorique du modèle et des valeurs des paramètres, 
on détermine l’état stationnaire du modèle, où toutes les grandeurs en volume croissent au même rythme. 
En pratique, le modèle est étudié en écart à cet état stationnaire, considéré comme un état de référence. 
Autrement dit, on applique alors au modèle le choc qu’on souhaite étudier (réforme fiscale par exemple) 
et on simule le modèle sur plusieurs trimestres : en réponse au choc, la trajectoire du modèle s’écarte alors du scénario de référence 
pour donner un scénario « avec choc ». L’impact du choc sur l’économie (France, reste de la zone euro ou zone euro dans son ensemble) 
consiste à évaluer, pour toute grandeur économique d’intérêt, l’écart entre le scénario avec choc et le scénario en l’absence de choc.

Le modèle est écrit sous le langage Dynare (https://www.dynare.org/) et ses programmes de routine sont écrits en Matlab (© 1994-2019 The MathWorks, Inc.).


## Plusieurs options de simulation

Le modèle permet de simuler le comportement du gouvernement selon trois options différentes. 
Le comportement du gouvernement décrit la façon dont celui-ci ajuste les dépenses publiques à la hausse ou à la baisse 
compte tenu de l’évolution courante de l’économie. Les trois options sont les suivantes :
- réaction de type « règle budgétaire » : les dépenses publiques sont ajustées afin d’assurer la convergence du ratio de la dette publique au PIB vers son niveau dans l’état de référence ;
- réaction de type « gouvernement optimisateur » : les dépenses publiques sont ajustées dans le but de maximiser le « bien-être » des ménages ;
- absence de réaction : les dépenses publiques sont fixées à leur niveau de référence.


## Licence

Mélèze Copyright © 2005-2018, Institut national de la statistique et des études économiques

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>.


## Contact

#########################	FRANÇAIS #########################

En cas de question, merci de lire attentivement la documentation fournie (dossier 'documentation').

En cas de retours sur le modèle, merci d'envoyer un courriel à dg75-g201@insee.fr

#########################	ENGLISH #########################

If you have questions, please read carefully the provided documentation ('documentation' folder). 

If you have any feedback on the model, please send an e-mail at dg75-g201@insee.fr
