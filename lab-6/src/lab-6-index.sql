/* =========================== ИНДЕКСЫ 1 ============================ */
CREATE INDEX 
    artist_name_index 
    ON discogs.artist(NAME);

ALTER TABLE 
    discogs.artist 
DROP INDEX 
    artist_name_index;

EXPLAIN SELECT 
    * 
FROM 
    discogs.artist
WHERE 
    NAME = 'Пикник';
    
/* =========================== ИНДЕКСЫ 2 ============================ */
CREATE INDEX 
    group_artist_id_index 
    ON discogs.group(GROUP_ARTIST_ID, MAIN_ARTIST_ID);
    
ALTER TABLE 
    discogs.group 
DROP INDEX 
    group_artist_id_index;
    
EXPLAIN SELECT 
    * 
FROM 
    discogs.artist
WHERE 
    ARTIST_ID IN (
        SELECT 
            GROUP_ARTIST_ID 
        FROM 
            discogs.group
        WHERE 
            MAIN_ARTIST_ID = (
                SELECT
                    ARTIST_ID 
                FROM 
                    discogs.artist 
                WHERE
                    NAME = 'Пикник'
            )
    );