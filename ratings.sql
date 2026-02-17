USE movies;
DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings
(
    content_rating VARCHAR(512),
    details VARCHAR(512),
    r_code VARCHAR(512),
    meaning VARCHAR(512)
);

INSERT INTO ratings (content_rating, details, r_code, meaning) VALUES
	('R', 'Restricted', 'CR101', 'This rating is for films specifically designed to be viewed by adults and therefore may be unsuitable for children under 17.'),
	('TV-MA', 'Mature Audience Only', 'CR102', '"Intended for adults and may be unsuitable for children under 17. Possibly contains crude indecent language, explicit sexual activity or graphic violence."'),
	('PG-13', '�Parents Strongly Cautioned', 'CR103', '"Some material may not be suited for children under age 13. May contain violence, nudity, sensuality, language, adult activities or other elements beyond a PG rating, but doesn�t reach the restricted R category."'),
	('Approved', '', 'CR104', ''),
	('PG', 'Parental Guidance Suggested', 'CR105', 'Parents are urged to give parental guidance. This film may contain some material parents might not like for their young children.'),
	('Unrated', 'No rating given', 'CR106', 'An unrated movie is a movie that has not been given a rating by the Motion Picture Association of America'),
	('G', 'General Audiences', 'CR107', 'This program is designed to be appropriate for all ages. This rating indicates a film contains nothing that would offend parents for viewing by children.'),
	('Not Rated', '', 'CR108', ''),
	('M', 'Mature', 'CR109', 'M-rated films and computer games are not recommended for children under the age of 15.'),
	('Passed', '', 'CR110', ''),
	('X', 'Persons under 16 not admitted', 'CR111', 'indicates that the film contains content that is considered to be suitable only for adults'),
	('NC-17', 'Clearly Adult', 'CR112', 'This rating is applied to films the MPAA believes most parents will consider inappropriate for children 17 and under. It indicates only that adult content is more intense than in an R rated movie.'),
	('GP', 'All ages admitted', 'CR113', 'All ages admitted � Parental guidance suggested');