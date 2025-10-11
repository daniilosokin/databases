/* =========================== ИНДЕКСЫ 1 ============================ */
CREATE INDEX 
    artist_name_index 
ON 
    discogs.artist(NAME);

ALTER TABLE 
    discogs.artist 
DROP INDEX 
    artist_name_index;

EXPLAIN SELECT 
    * 
FROM 
    discogs.artist
WHERE 
    NAME = "Пикник";
    
/* =========================== ИНДЕКСЫ 2 ============================ */
CREATE INDEX 
    group_main_artist_id_index 
ON 
    discogs.group(MAIN_ARTIST_ID);
    
CREATE INDEX 
    group_group_artist_id_index 
ON 
    discogs.group(GROUP_ARTIST_ID);
    
ALTER TABLE 
    discogs.group 
DROP INDEX 
    group_main_artist_id_index,
DROP INDEX 
    group_group_artist_id_index;

SELECT 
    * 
FROM 
    discogs.artist
WHERE 
    discogs.artist.ARTIST_ID IN (
        SELECT 
            GROUP_ARTIST_ID 
        FROM 
            discogs.group
        JOIN 
            discogs.artist 
            ON discogs.artist.ARTIST_ID = discogs.group.MAIN_ARTIST_ID
        WHERE 
            discogs.artist.NAME = "Пикник"
    );