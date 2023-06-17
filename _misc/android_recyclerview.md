---
title: Android - RecyclerView
layout: default
icon: android.png
---
# RecyclerView
Une RecyclerView est une liste déroulante de plusieurs éléments.

Pour optimiser la mémoire, Android ne gère que les éléments affichés. Dès qu'un nouvel élément apparait à l'écran, on doit charger les donner à afficher. Pour cela, le RecyclerView est associé à une classe spéciale: l'Adapter. C'est elle qui est en charge de lier les éléments de la liste avec l'item affiché à l'écran. Cette classe Adapter contient une sous-classe: la ViewHolder. Un objet de cette classe est créé pr chaque élément de la liste à afficher.


Comment gérer une RecyclerView:
1. Créer une activité qui contient un RecyclerView
2. Créer un layout qui représente 1 élément de la liste (peut être composé d'un seul TextView ou de plusieurs TextView avec des icônes, des boutons, des images, etc.). Dans la suite, on appellera ce layout ''list_item''
3. Créer une classe Adapter
4. Créer une classe ViewHolder au sein de la classe Adapter
5. Associer l'Adapter à la RecyclerView

## Créer une classe Adapter
* Classe héritée de `RecyclerView.Adapter` (classe abstraite de type template)
* Comme la classe mère est abstraite, il faut obligatoirement définir les méthodes: `getItemCount`, `onCreateViewHolder` et `onBindViewHolder`
* Le code suivant n'est pas complet: il manque la sous-classe ViewHolder. C'est décrit après

```java
// Classe héritée de RecycleView.Adapter. Comme il s'agit d'un template, on lui passe le type du ViewHolder: ici la classe créée spécifiquement (on va la créer après)
class MyAdapter extends RecyclerView.Adapter<MyAdapter.MyViewHolder> {

    
    private Context m_context;     // Attribut pour mémoriser le contexte. Utile si on veut démarrer une nouvelle activité lorsqu'on clique sur un item de la liste
    private List<type> m_liste;    // Liste des éléments à afficher (n'importe quel type, dans l'exemple on ne parle pas de l’initialisation de la liste. Fais le où tu veux)


    // Constructeur. On mémorise le contexte (contexte = pointeur sur l'instance de la classe activité appelante). On peut initialiser la liste des données ici par exemple.
    public RssAdapter(Context context) {
        this.m_context = context;
    }


    // Renvoie le nombre d'éléments de la liste
    @Override
    public int getItemCount() {
        return m_liste.getLength();
    }


    // Méthode appelée lorsque l'item est créé. C'est à ce moment qu'on créer le ViewHolder correspondant à l'item à afficher
    @Override
    public RssViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(parent.getContext());
        View view = inflater.inflate(R.layout.list_item, parent, false);    // le layout list_item qui correspond à l’affichage d'un élément de la liste
        return new MyViewHolder(view);     // On crée un nouvel objet ViewHolder en lui donnant la View avec laquelle il est associé
    }
 
 
    // Méthode appelée lorsque le ViewHolder est associé à la View qui affiche le contenu du ViewHolder.
    // myViewHolder: le ViewHolder qu'on veut lier
    // i: le rang de l'élément de la liste qu'on veut afficher
    // on appelle la méthode setData (ou équivalent) pour traiter et afficher les données du i-ème élément de la liste
    @Override
    public void onBindViewHolder(final MyViewHolder myViewHolder, int i) {
        myViewHolder.setData(m_liste.item(i));
    }
}
```

## Créer une sous-classe ViewHolder
* Sous-classe de l'Adapter
* Classe héritée de `RecycleView.ViewHolder`


```java
// Classe héritée de RecyclerView.ViewHolder. Cette classe sert à contenir les données correspondant à 1 élément de la liste
class MyViewHolder extends RecyclerView.ViewHolder {

    // On mémorise toutes les View qui devront être mises à jour avec les données
    private final TextView m_title; ///< View used to display title
    public View m_parentLayout;     ///< Layout of the view

  
    // Constructeur
    // Le constructeur reçoit la View associée qui affichera les données
    RssViewHolder(final View item) {
        super(item);

        // On mémorise les View qui nous intéressent
        m_title = item.findViewById(R.id.article_title);
        m_parentLayout = item;
    }


    public void setData(data) {
        m_title.setText(data);
    }
}
```

## Associer l'Adapter à la RecyclerView
* Dans la classe de l'activité qui contient le RecyclerView
* Associer un LinearLayoutManager au RecyclerView
* Créer un Adapter
* Associer l'adapter à la RecyclerView

```java
// Create Recycler view
final RecyclerView rv = findViewById(R.id.list);
rv.setLayoutManager(new LinearLayoutManager(this));
RssAdapter adapter = new RssAdapter(this);
rv.setAdapter(adapter);
```