---
title: "Initiation à XForms : éditez vos données XML facilement depuis une interface web"
authors:
 - Josselin Morvan, université de Rouen
---

## Argumentaire
### Version longue
XForms est un standard pour la création de formulaires web. Ce dialecte XML s'appuie sur une architecture Modèle-Vue-Contrôleur (MVC) qui sépare la structure des données (modèle), leur présentation (vue) et leur manipulation (contrôleur), offrant ainsi les meilleures garanties en termes de réutilisabilité, de portabilité et d'accessibilité des applications créées.

Dans le champ des sciences humaines et sociales, où les formats XML sont largement adoptés (TEI, EAD, EAC-CPF en tête), XForms apporte une réponse concrète à un problème récurrent : comment produire des données XML structurées sans recourir à une édition manuelle dans un éditeur de texte ?

XForms facilite la mise en place de formulaires dynamiques et très complexes, comportant par exemple des répétitions, des contrôles sur les valeurs ou des règles de contraintes avancées relativement rapidement, le tout en s'appuyant sur la seule pile des technologies XML (XPath, types et schémas XML, XML Event, etc.). 

Plus qu’un simple langage de formulaire, dans sa version 1.1 cette recommandation du W3C est devenue un langage *Turing-complet*, qui adopte un modèle de programmation déclaratif où l’on s’attache à décrire ce que l’on souhaite faire plutôt que comment, et capable de soutenir le développement d’applications à grande échelle.

### Version courte
XForms est une recommandation du W3C qui permet de créer des formulaires web pour éditer des instances XML (TEI, EAD, EAC-CPF ou autre) directement dans le navigateur.

Reposant sur une architecture Modèle-Vue-Contrôleur (MVC), XForms permet de créer facilement des interfaces de saisie complexes avec des mécanismes de validation, de répétition de champs et de contrôle avancé des données — sans avoir recours à JavaScript — afin de produire des instances XML valides et exploitables immédiatement dans un système d'information.

## Public visé
Les chercheurs et ingénieurs en sciences humaines et sociales qui utilisent des formats de données XML.

## Prérequis
Connaissance requise des langages (X)HTML et XML. Des notions sur le langage de requête XPath et sur les espaces de nom constituent un atout.

## Programme
- Déployer une application XForms ;
- déclarer un modèle, des champs et des contrôles afin de produire un formulaire dynamique ; 
- enregistrer et modifier les données XML saisies.