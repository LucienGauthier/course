-- On créer une configuration pour le modèle fct_reviews : on définit le type de matérialisation à 'incremental' et on spécifie que si le schéma change, l'exécution doit échouer.
{{
    config(
        materialized = 'table'
    ) 
}}

with src_reviews as (
    
    select *
    from {{ ref('src_reviews') }}

)

-- On sélectionne toutes les colonnes de la table src_reviews où review_text n'est pas nul.
-- Si le modèle est exécuté en mode incrémental, on ne sélectionne que les avis dont la date est postérieure à la date maximale des avis déjà présents dans la table cible.
select *
from src_reviews
where review_text is not null
{% if is_incremental() %}
    and review_date > (select max(review_date) from {{ this }})
{% endif %}