**Spotify Advanced SQL Project**<br />

**Overview**<br />

This project involves analyzing a Spotify dataset with various attributes about tracks, albums, and artists using SQL. It covers an end-to-end process of normalizing a denormalized dataset, performing SQL queries of varying complexity (easy, medium, and advanced), and optimizing query performance. The primary goals of the project are to practice advanced SQL skills and generate valuable insights from the dataset.<br />

-- create table<br />
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);<br />

**Project Steps**<br />

1. **Data Exploration**<br />

Before diving into SQL, it’s important to understand the dataset thoroughly. The dataset contains attributes such as:<br />

Artist: The performer of the track.<br />
Track: The name of the song.<br />
Album: The album to which the track belongs.<br />
Album_type: The type of album (e.g., single or album).<br />
Various metrics such as danceability, energy, loudness, tempo, and more.<br />

2. **Querying the Data**<br />

After the data is inserted, various SQL queries can be written to explore and analyze the data. Queries are categorized into easy, medium, and advanced levels to help progressively develop SQL proficiency.<br />

**Easy Queries**<br />

Simple data retrieval, filtering, and basic aggregations.<br />
Medium Queries<br />
More complex queries involving grouping, aggregation functions, and joins.<br />
Advanced Queries<br />
Nested subqueries, window functions, and CTEs<br />

**15 Practice Questions**<br />

**Easy Level**<br />

1.Retrieve the names of all tracks that have more than 1 billion streams.<br />
2.List all albums along with their respective artists.<br />
3.Get the total number of comments for tracks where licensed = TRUE.<br />
4.Find all tracks that belong to the album type single.<br />
5.Count the total number of tracks by each artist.<br />

**Medium Level**<br />

1.Calculate the average danceability of tracks in each album.<br />
2.Find the top 5 tracks with the highest energy values.<br />
3.List all tracks along with their views and likes where official_video = TRUE.<br />
4.For each album, calculate the total views of all associated tracks.<br />
5.Retrieve the track names that have been streamed on Spotify more than YouTube.<br />

**Advanced Level**<br />

1.Find the top 3 most-viewed tracks for each artist using window functions.<br />
2.Write a query to find tracks where the liveness score is above the average.<br />
3.Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.<br />
WITH cte
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY 2 DESC<br />
4.Find tracks where the energy-to-liveness ratio is greater than 1.2.<br />
5.Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.<br />

Here’s an updated section for your Spotify Advanced SQL Project and Query Optimization README, focusing on the query optimization task you performed. You can include the specific screenshots and graphs as described.



