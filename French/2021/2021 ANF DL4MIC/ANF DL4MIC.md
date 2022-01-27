![Bandeau ANF](https://github.com/fabricecordelieres/Training_material/blob/master/French/2021/2021%20ANF%20DL4MIC/img/Bandeau.png)

# Programme

<table>
<thead>
  <tr>
    <th></th>
    <th>Mardi 19 octobre</th>
    <th>Mercredi 20 octobre</th>
    <th>Jeudi 21 octobre</th>
    <th>Vendredi 22 octobre</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td><b>9h00-10h30</b></td>
    <td rowspan="4"></td>
    <td><a href="#deepimagej">Deep-learning avec <br>DeepImageJ<br>Daniel Sage</a></td>
    <td><a href="#zerocoststardist">ZeroCostDL4Mic:<br>bien commencer avec Stardist/Trackmate<br>Guillaume Jacquemet</a></td>
    <td>Expérimentez sur vos propres images<br>Q&amp;A<br>Tous les instructeurs</td>
  </tr>
  <tr>
    <td><b>10h30-11h00</b></td>
    <td><em>Pause</em></td>
    <td><em>Pause</em></td>
    <td><em>Pause</em></td>
  </tr>
  <tr>
    <td><b>11h00-12h30</b></td>
    <td><a href="#deepimagej">Deep-learning avec <br>DeepImageJ<br> (suite)<br>Daniel Sage</a></td>
    <td><a href="#zerocostdenoising">ZeroCostDL4Mic:<br>aller plus loin avec Denoising/Pix2pix<br>Guillaume Jacquemet</a></td>
    <td>Bilan de fin de formation<br>Table ronde<br>Actions à venir<br>Tous les instructeurs</td>
  </tr>
  <tr>
    <td><b>12h30-14h00</b></td>
    <td><em>Déjeuner</em></td>
    <td><em>Déjeuner</em></td>
    <td><em>Déjeuner</em></td>
  </tr>
  <tr>
    <td><b>14h00-14h30</b></td>
    <td rowspan="2"><a href="#intro">Introduction au Deep-Learning:<br>théorie et vocabulaire<br>David Rousseau</a></td>
    <td><a href="#care">Séminaire d’application:<br>CARE/StarDist<br>Martin Weigert</a></td>
    <td><a href="#imjoy">Séminaire d’application:<br>ImJoy<br>Wei Ouyang</a></td>
    <td rowspan="4"></td>
  </tr>
  <tr>
    <td><b>14h30-16h00</b></td>
    <td><a href="#deepimagej">Deep-learning avec <br>DeepImageJ<br> (fin)<br>Daniel Sage</a></td>
    <td><a href="#zerocostqc">ZeroCostDL4Mic:<br>les outils de contrôle qualité<br>Guillaume Jacquemet</a></td>
  </tr>
  <tr>
    <td><b>16h00-16h30</b></td>
    <td><em>Pause</em></td>
    <td><em>Pause</em></td>
    <td><em>Pause</em></td>
  </tr>
  <tr>
    <td><b>16h30-19h00</b></td>
    <td><a href="#outilsos">Découverte et prise en main <br>d’outils open-source<br>Romain Guiet/Bertrand Vernay</a></td>
    <td><a href="#annot">Annotations:<br>types, outils et moyens <br>pour les évaluer<br>Bertrand Vernay/Romain Guiet</a></td>
    <td><a href="#tr">Table-ronde:<br>quels outils et métriques <br>pour le contrôle qualité ?<br>Romain Guiet/Bertrand Vernay/<br>Daniel Sage</a></td>
  </tr>
</tbody>
</table>

---
# Pré-requis pour la formation
## e-learning
### Acquérir quelques éléments de vocabulaire:
Vous pouvez consulter [ce site](https://github.com/HenriquesLab/ZeroCostDL4Mic/wiki/Glossary) pour vous familiariser avec le vocabulaire du deep learning ou vous y référer pendant le visionnage des vidéos.

### Se familiariser avec les bases théoriques du machine learning:
* Introduction au machine learning et au deep learning
  * [Partie 1 (15:57)](https://www.youtube.com/watch?v=RzN5RVSwrRw)
  * [Partie 2 (17:12)](https://www.youtube.com/watch?v=C8pPx-AbRHI&list=PLUukCwr0iCef9M7WUOx9_bJYJpvMxek6F&index=2)
  * [Partie 3 (23:02)](https://www.youtube.com/watch?v=Rb-4Yu-qLR4&list=PLUukCwr0iCef9M7WUOx9_bJYJpvMxek6F&index=3)
  * [Partie 4 (16:11)](https://www.youtube.com/watch?v=2US1r-cYJSg&list=PLUukCwr0iCef9M7WUOx9_bJYJpvMxek6F&index=4)
* [CNN principles (20:16)](https://www.youtube.com/watch?v=muY5FAn04FI&list=PLUukCwr0iCef9M7WUOx9_bJYJpvMxek6F&index=6)
* [Basic architecture in deep learning (29:26)](https://www.youtube.com/watch?v=a8XvknLW-Dg&list=PLUukCwr0iCef9M7WUOx9_bJYJpvMxek6F&index=7)
* [PlaygroundTensorFlow demo (15:36)](https://www.youtube.com/watch?v=zAN3xUBiaPI&list=PLUukCwr0iCef9M7WUOx9_bJYJpvMxek6F&index=5)

### Se familiariser l’utilisation de quelques ressources logicielles:
* __iLastik:__ présentation du logiciel et démo dans le cadre de la [NeuBIAS Academy](https://www.youtube.com/c/NEUBIAS/videos):
  * [Vidéo sur YouTube (01:26:53)](https://www.youtube.com/watch?v=_ValtSLeAr0)
  * [Q&A sur le forum ImageJ](https://forum.image.sc/t/neubias-academy-home-webinar-ilastik-beyond-pixel-classification-questions-answers/39218)
* __ZeroCostDL4mic:__ présentation du logiciel et démo dans le cadre de la [NeuBIAS Academy](https://www.youtube.com/c/NEUBIAS/videos):
  * [Vidéo sur YouTube (01:33:36)](https://www.youtube.com/watch?v=dcgU5WKE70I)
  * [Q&A sur le forum ImageJ](https://forum.image.sc/t/neubias-academy-home-webinar-zerocostdl4mic-questions-answers/54397)


## Un peu de lecture
En préalable à la formation, il vous est fortement conseillé de lire les revues suivantes:
* [Laine RF, Jacquemet G, Krull A. Imaging in focus: An introduction to denoising bioimages in the era of deep learning. Int J Biochem Cell Biol. 2021 Nov;140:106077. doi: 10.1016/j.biocel.2021.106077. Epub 2021 Sep 20. PMID: 34547502; PMCID: PMC8552122.](https://doi.org/10.1016/j.biocel.2021.106077)
* [Laine RF, Arganda-Carreras I, Henriques R, Jacquemet G. Avoiding a replication crisis in deep-learning-based bioimage analysis. Nat Methods. 2021 Oct;18(10):1136-1144. doi: 10.1038/s41592-021-01284-3. PMID: 34608322; PMCID: PMC7611896.](https://doi.org/10.1038/s41592-021-01284-3)
* [Lucas AM, Ryder PV, Li B, Cimini BA, Eliceiri KW, Carpenter AE. Open-source deep-learning software for bioimage segmentation. Mol Biol Cell. 2021 Apr 19;32(9):823-829. doi: 10.1091/mbc.E20-10-0660. PMID: 33872058; PMCID: PMC8108523.](https://doi.org/10.1091/mbc.E20-10-0660)

## Quelques installations
### Installer Fiji
Est-il besoin de préciser comment installer [Fiji](https://fiji.sc/) ? Vous le trouverez ici: dézippez l’archive dans un répertoire où vous êtes sûr(e) d’avoir les droits d’écriture.
Nos instructeurs ont noté un problème de compatibilité entre certains greffons (Labkit en StarDist): n’hésitez pas à dupliquer votre répertoire Fiji de manière à avoir deux instances indépendantes !

### Greffons et bibliothèques Fiji à installer
Voici la liste des greffons installer: cliquez sur les liens pour consulter leurs documentations respectives et avoir accès à leur procédure d’installation:
* [DeepImageJ](https://deepimagej.github.io/deepimagej/download.html).
* [iLastik import/export](https://www.ilastik.org/documentation/fiji_export/plugin).
* [ImageScience](https://imagej.net/libs/imagescience) (utile pour certains calculs réalisés par le greffon Weka).
* [Labkit](https://imagej.net/plugins/labkit/) (attention, ne pas installer sur la même instance que celle contenant StarDist).
* [SCF](https://imagej.net/plugins/interactive-watershed).
* [Stardist](https://imagej.net/plugins/stardist) (attention, ne pas installer sur la même instance que celle contenant Labkit).
* [TrackMate+StarDist](https://imagej.net/plugins/trackmate/trackmate-stardist).

### Installer iLastik
Télécharger et installer iLastik que vous trouverez [ici](https://www.ilastik.org/).

### Outils Python:
Certains d’outils reposent sur Python: nous vous conseillons de télécharger et d’installer l’environnement Anaconda que vous trouverez [ici](https://www.anaconda.com/products/individual).
* __LabelImg__: suivre les instructions disponibles [ici](https://github.com/tzutalin/labelImg).
* __labelme__: suivre les instructions disponibles [ici](https://github.com/wkentaro/labelme).

__Attention, concernant l'installation de labelme__: devant les difficultés rencontrées en suivant le tutoriel, voici une procédure simplifiée pour Anaconda:
Depuis le terminal, faire:
* conda create --name=labelme python=3.6
* conda activate labelme
* pip install labelme
Pour lancer labelme, toujours depuis le terminal, faire:
* labelme

### Macros ImageJ
Ces deux macros permettent d'exporter des ROIs au format XML pour YOLO:
* Version de Bertrand téléchargeable [ici](https://raw.githubusercontent.com/bvernay/ImageJ-Macros/master/xml_annotations_tools/roiTOXML.ijm).
* Version de Romain téléchargeable [ici](https://gist.github.com/romainGuiet/288dfec7fc2534fe7af027f88a971f9b).

### Outils indépendants
* __itk-SNAP:__ suivre les instructions disponibles [ici](http://www.itksnap.org/pmwiki/pmwiki.php).

### Créer un compte Google spécifique pour l’utilisation de Collaboratory
Certains workflow que nous allons utiliser nécessitent d’utiliser les ressources en-ligne mises à disposition par Google. En amont de la formation, il vous est demandé de créer un compte spécifique via [ce lien](https://accounts.google.com/signup/v2/webcreateaccount?flowName=GlifWebSignIn&flowEntry=SignUp). A vrai dire, les ressources de calcul disponibles pouvant être limitées par Google, il pourra être utile de créer plusieurs comptes dédiés.

---
# Contenu de la formation

Pour les partie de la formation ayant été enregistrées, une playlist est disponible [ici](https://www.youtube.com/watch?v=ttyilVGUCLQ&list=PLHrpBtlAiSe1Wzbv1KeFa19dlnMVCmNvE), [sur la chaine YouTube du RTMFM](https://www.youtube.com/channel/UCpziluNVb_ViZVaX0tYjuBw).

## <a name="intro">Introduction au Deep-Learning: théorie et vocabulaire, David Rousseau</a>
* La présentation est disponible [ici](https://uabox.univ-angers.fr/index.php/s/qBNkC2KdJ5BCZhw).
* Pour aller plus loin:
  * Pourquoi fixer la taille des noyaux de convolutions…. par facilité mais ce n’est pas forcément optimal: [plus d'infos ici](https://arxiv.org/abs/2110.08059)
  * Courbe ROC Kézako ? : la réponse [ici](https://en.wikipedia.org/wiki/Receiver_operating_characteristic)
  * Les réseaux de convolution ne sont pas forcément la fin de l’histoire : [lire ici](https://towardsdatascience.com/geometric-foundations-of-deep-learning-94cdd45b451d).
  * Un exemple de réseau de neurones non convolutionnel très investigué actuellement dans le domaine de l’image : [à lire ici](https://proceedings.neurips.cc/paper/2017/file/3f5ee243547dee91fbd053c1c4a845aa-Paper.pdf).
  * Les gros modèles issus de la vision par ordinateur ne sont pas forcément optimaux pour tous les problèmes: [plus d'infos ici](https://www.youtube.com/watch?v=UIE3PcIPShY&t=9s).
  * Deep learning dans le domaine de Fourier : pour en savoir plus, suivre ce [lien](http://ecmlpkdd2017.ijs.si/papers/paperID11.pdf).

## <a name="outilsos">Découverte et prise en main d’outils open-source, Romain Guiet/Bertrand Vernay</a>
* La présentation de l'exercice est disponible [ici](https://docs.google.com/presentation/d/1ipXyEdyGEsf8miaDRQG0EIKcetVmXXWhXpjR8vZro_M/edit?usp=sharing).
* Le tutoriel iLastik est disponible [ici](https://docs.google.com/presentation/d/1EQaLIWMtOP6Siz9ZAAk-Yh646pfUUaXiKjBtlMgWnDM/edit?usp=sharing).
* Liens vers les jeux de données:
  * [Dataset 1](https://zenodo.org/record/4248921#.YW60vRpBw2y).
  * [Dataset 2](https://drive.google.com/drive/folders/183FohDepgfrmtC0WYFn30Jmkq9odb7qF?usp=sharing).
* Ressource complémentaire sur le template matching: greffon ImageJ disponible [ici](https://imagej.net/plugins/multi-template-matching).


## <a name="deepimagej">Deep-learning avec DeepImageJ, Daniel Sage</a>
* La présentation et les données sont disponibles [ici](https://drive.google.com/drive/folders/1zZXKm3twf4gzDSdK7PGM_P08nswcVdGX?usp=sharing).


## <a name="care">Séminaire d’application: CARE/StarDist, Martin Weigert</a>
* La vidéo du séminaire d'application est disponible [ici](https://www.youtube.com/watch?v=dzOD-XDEvdI&list=PLHrpBtlAiSe1Wzbv1KeFa19dlnMVCmNvE&index=4)

## <a name="annot">Annotations: types, outils et moyens pour les évaluer, Bertrand Vernay/Romain Guiet</a>

## <a name="zerocoststardist">ZeroCostDL4Mic: bien commencer avec Stardist/Trackmate, Guillaume Jacquemet</a>
* La vidéo de cette session est disponible [ici](https://www.youtube.com/watch?v=ttyilVGUCLQ&list=PLHrpBtlAiSe1Wzbv1KeFa19dlnMVCmNvE&index=1)

## <a name="zerocostdenoising">ZeroCostDL4Mic: aller plus loin avec Denoising/Pix2pix, Guillaume Jacquemet</a>
* La vidéo de cette session est disponible [ici](https://www.youtube.com/watch?v=ttyilVGUCLQ&list=PLHrpBtlAiSe1Wzbv1KeFa19dlnMVCmNvE&index=2)

## <a name="imjoy">Séminaire d’application: ImJoy, Wei Ouyang</a>
* La présentation est disponible [ici](https://slides.imjoy.io/?slides=https://raw.githubusercontent.com/oeway/slides/master/2021/cnrs-deep-learning-for-microscopy.md).
* La vidéo du séminaire d'application est disponible [ici](https://www.youtube.com/watch?v=8mEGsvX5q80&list=PLHrpBtlAiSe1Wzbv1KeFa19dlnMVCmNvE&index=5)

## <a name="zerocostqc">ZeroCostDL4Mic: les outils de contrôle qualité, Guillaume Jacquemet</a>
* La vidéo de cette session est disponible [ici](https://www.youtube.com/watch?v=ttyilVGUCLQ&list=PLHrpBtlAiSe1Wzbv1KeFa19dlnMVCmNvE&index=3)

## <a name="tr">Table-ronde: quels outils et métriques pour le contrôle qualité ?, Romain Guiet/Bertrand Vernay/Daniel Sage</a>
## <a name="annot">Expérimentez sur vos propres images, Q&A, Tous les instructeurs</a>

![Photo de groupe](https://github.com/fabricecordelieres/Training_material/blob/master/French/2021/2021%20ANF%20DL4MIC/img/Photo_groupe.jpg)
