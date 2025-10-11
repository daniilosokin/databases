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
    group_main_artist_id_index 
    ON discogs.group(MAIN_ARTIST_ID);

ALTER TABLE 
    discogs.group 
DROP INDEX 
    group_main_artist_id_index;
    
EXPLAIN SELECT 
    artist.* 
FROM 
    discogs.artist
JOIN 
    discogs.group 
    ON artist.ARTIST_ID = discogs.group.GROUP_ARTIST_ID
JOIN 
    discogs.artist AS band 
    ON discogs.group.MAIN_ARTIST_ID = band.ARTIST_ID
WHERE 
    band.NAME = 'Пикник';