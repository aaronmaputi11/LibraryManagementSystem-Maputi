-- Sample Data for Library Management System
-- This script inserts 20 members and 100 books into the database with UNIQUE ISBNs

USE library_management;

-- =============================================
-- INSERT MEMBERS (20 members)
-- =============================================

INSERT INTO members (name, email, phone, address, membership_date, status) VALUES
('Rajesh Kumar', 'rajesh.kumar@email.com', '9876543210', '123 Main Street, Delhi', '2023-01-15', 'active'),
('Priya Sharma', 'priya.sharma@email.com', '9876543211', '456 Oak Avenue, Mumbai', '2023-02-20', 'active'),
('Amit Patel', 'amit.patel@email.com', '9876543212', '789 Pine Road, Bangalore', '2023-03-10', 'active'),
('Neha Singh', 'neha.singh@email.com', '9876543213', '321 Elm Street, Hyderabad', '2023-04-05', 'active'),
('Vikram Gupta', 'vikram.gupta@email.com', '9876543214', '654 Maple Drive, Pune', '2023-05-12', 'active'),
('Anjali Reddy', 'anjali.reddy@email.com', '9876543215', '987 Birch Lane, Chennai', '2023-06-18', 'active'),
('Sanjay Nair', 'sanjay.nair@email.com', '9876543216', '147 Cedar Street, Kolkata', '2023-07-22', 'active'),
('Deepika Joshi', 'deepika.joshi@email.com', '9876543217', '258 Spruce Avenue, Ahmedabad', '2023-08-30', 'active'),
('Rohit Verma', 'rohit.verma@email.com', '9876543218', '369 Willow Road, Surat', '2023-09-14', 'active'),
('Sneha Malhotra', 'sneha.malhotra@email.com', '9876543219', '741 Ash Drive, Jaipur', '2023-10-25', 'inactive'),
('Arjun Singh', 'arjun.singh@email.com', '9876543220', '852 Oak Street, Lucknow', '2023-11-08', 'active'),
('Pooja Das', 'pooja.das@email.com', '9876543221', '963 Pine Avenue, Chandigarh', '2023-12-03', 'active'),
('Nikhil Bhat', 'nikhil.bhat@email.com', '9876543222', '147 Elm Road, Indore', '2024-01-17', 'active'),
('Aisha Khan', 'aisha.khan@email.com', '9876543223', '258 Maple Street, Bhopal', '2024-02-09', 'suspended'),
('Varun Chopra', 'varun.chopra@email.com', '9876543224', '369 Birch Avenue, Visakhapatnam', '2024-03-21', 'active'),
('Zara Malik', 'zara.malik@email.com', '9876543225', '741 Cedar Road, Pimpri-Chinchwad', '2024-04-14', 'active'),
('Harsh Yadav', 'harsh.yadav@email.com', '9876543226', '852 Spruce Street, Nashik', '2024-05-28', 'active'),
('Kavya Mishra', 'kavya.mishra@email.com', '9876543227', '963 Willow Avenue, Vadodara', '2024-06-11', 'active'),
('Rohan Das', 'rohan.das@email.com', '9876543228', '147 Ash Road, Ghaziabad', '2024-07-05', 'active'),
('Isha Kapoor', 'isha.kapoor@email.com', '9876543229', '258 Oak Drive, Ludhiana', '2024-08-19', 'active');

-- =============================================
-- INSERT BOOKS (100 books with UNIQUE ISBNs)
-- =============================================

INSERT INTO books (isbn, title, author, publisher, publication_year, category, description, total_copies, available_copies, location_shelf, status) VALUES
('9780451524935', 'The Great Gatsby', 'F. Scott Fitzgerald', 'Scribner', 1925, 'Fiction', 'A classic American novel about wealth and love in the Jazz Age.', 5, 4, 'A1', 'available'),
('9781451673319', '1984', 'George Orwell', 'Secker and Warburg', 1949, 'Fiction', 'A dystopian novel depicting a totalitarian future society.', 4, 3, 'A2', 'available'),
('9780142414934', 'Moby Dick', 'Herman Melville', 'Penguin Classics', 1851, 'Fiction', 'Epic tale of a whaling ship captain obsessed with a white whale.', 3, 2, 'A3', 'available'),
('9780141194081', 'Pride and Prejudice', 'Jane Austen', 'Penguin Classics', 1813, 'Fiction', 'A romantic novel about social class and manners in Georgian England.', 6, 5, 'A4', 'available'),
('9780451530786', 'Fahrenheit 451', 'Ray Bradbury', 'Ballantine Books', 1953, 'Science Fiction', 'A novel about a fireman who burns books in a dystopian future.', 4, 3, 'B1', 'available'),
('9780142454084', 'To Kill a Mockingbird', 'Harper Lee', 'J.B. Lippincott', 1960, 'Fiction', 'A gripping tale of racial injustice and childhood innocence in the South.', 5, 4, 'A5', 'available'),
('9780553382563', 'The Catcher in the Rye', 'J.D. Salinger', 'Little, Brown', 1951, 'Fiction', 'A story of teenage alienation and depression in New York City.', 3, 2, 'A6', 'available'),
('9780007105380', 'The Hobbit', 'J.R.R. Tolkien', 'Allen & Unwin', 1937, 'Fantasy', 'A fantasy adventure about a small hobbit on an unexpected journey.', 5, 4, 'C1', 'available'),
('9780451528117', 'The Lord of the Rings', 'J.R.R. Tolkien', 'Allen & Unwin', 1954, 'Fantasy', 'An epic fantasy saga with battles, magic, and heroic quests.', 4, 3, 'C2', 'available'),
('9780140441956', 'The Odyssey', 'Homer', 'Penguin Classics', 1999, 'Classics', 'An ancient Greek epic poem about Odysseus journey home.', 3, 2, 'D1', 'available'),
('9780141439570', 'The Picture of Dorian Gray', 'Oscar Wilde', 'Penguin Classics', 1890, 'Fiction', 'A philosophical novel about vanity, morality, and corrupted youth.', 4, 3, 'A7', 'available'),
('9780451526274', 'Jane Eyre', 'Charlotte Bronte', 'Penguin Classics', 1847, 'Fiction', 'A gothic romance about a governess and her mysterious employer.', 5, 4, 'A8', 'available'),
('9780141043968', 'Wuthering Heights', 'Emily Bronte', 'Penguin Classics', 1847, 'Fiction', 'A dark romance set on the Yorkshire moors.', 3, 2, 'A9', 'available'),
('9780140401509', 'The Iliad', 'Homer', 'Penguin Classics', 1950, 'Classics', 'An ancient Greek epic poem about the Trojan War.', 2, 1, 'D2', 'available'),
('9780141044001', 'Crime and Punishment', 'Fyodor Dostoevsky', 'Penguin Classics', 1866, 'Fiction', 'A psychological novel about guilt and redemption.', 4, 3, 'A10', 'available'),
('9780141439532', 'Anna Karenina', 'Leo Tolstoy', 'Penguin Classics', 1877, 'Fiction', 'A novel exploring love, society, and moral questions in Russian society.', 3, 2, 'A11', 'available'),
('9780140450018', 'The Brothers Karamazov', 'Fyodor Dostoevsky', 'Penguin Classics', 1879, 'Fiction', 'A philosophical novel exploring faith, doubt, and morality.', 2, 1, 'A12', 'available'),
('9780141043981', 'War and Peace', 'Leo Tolstoy', 'Penguin Classics', 1869, 'Fiction', 'An epic novel set during the Napoleonic Wars.', 4, 3, 'A13', 'available'),
('9780451528377', 'Dune', 'Frank Herbert', 'Ace Books', 1965, 'Science Fiction', 'A space opera about politics, religion, and ecology on a desert planet.', 5, 4, 'B2', 'available'),
('9780553293692', 'Foundation', 'Isaac Asimov', 'Gnome Press', 1951, 'Science Fiction', 'A trilogy about the fall and rise of a galactic empire.', 4, 3, 'B3', 'available'),
('9780451526762', 'I, Robot', 'Isaac Asimov', 'Gnome Press', 1950, 'Science Fiction', 'A collection of stories about robots and artificial intelligence.', 3, 2, 'B4', 'available'),
('9780441007432', 'Neuromancer', 'William Gibson', 'Ace Books', 1984, 'Science Fiction', 'A cyberpunk novel that defined the genre.', 2, 1, 'B5', 'available'),
('9780451526267', 'The Martian', 'Andy Weir', 'Crown', 2011, 'Science Fiction', 'A gripping tale of survival on Mars.', 6, 5, 'B6', 'available'),
('9780307887443', 'Ready Player One', 'Ernest Cline', 'Crown', 2011, 'Science Fiction', 'A virtual reality adventure in a dystopian future.', 5, 4, 'B7', 'available'),
('9789390166435', 'The Hunger Games', 'Suzanne Collins', 'Scholastic Press', 2008, 'Fiction', 'A dystopian novel about teenagers forced to fight in a televised battle.', 6, 5, 'E1', 'available'),
('9780747532699', 'Harry Potter and the Philosophers Stone', 'J.K. Rowling', 'Bloomsbury', 1998, 'Fantasy', 'A young wizard discovers his magical heritage.', 7, 6, 'C3', 'available'),
('9780066380155', 'The Chronicles of Narnia', 'C.S. Lewis', 'Geoffrey Bles', 1950, 'Fantasy', 'A fantasy series about children in a magical world.', 5, 4, 'C4', 'available'),
('9780765350381', 'Mistborn', 'Brandon Sanderson', 'Tor Books', 2006, 'Fantasy', 'A fantasy epic about overthrowing a tyrant.', 4, 3, 'C5', 'available'),
('9780552159715', 'The Name of the Wind', 'Patrick Rothfuss', 'DAW Books', 2007, 'Fantasy', 'A tale of a legendary figure recounting his extraordinary life.', 3, 2, 'C6', 'available'),
('9780553573404', 'A Game of Thrones', 'George R.R. Martin', 'Bantam Books', 1996, 'Fantasy', 'An epic fantasy with political intrigue and dragons.', 4, 3, 'C7', 'available'),
('9780517570000', 'Becoming', 'Michelle Obama', 'Crown', 2018, 'Biography', 'A memoir of the former First Lady of the United States.', 5, 4, 'F1', 'available'),
('9781451648546', 'Steve Jobs', 'Walter Isaacson', 'Simon & Schuster', 2011, 'Biography', 'A biography of the Apple co-founder and entrepreneur.', 4, 3, 'F2', 'available'),
('9780670921950', 'The Lean Startup', 'Eric Ries', 'Crown Business', 2011, 'Business', 'A methodology for building successful startups.', 3, 2, 'G1', 'available'),
('9780374176456', 'Thinking, Fast and Slow', 'Daniel Kahneman', 'Farrar, Straus and Giroux', 2011, 'Psychology', 'An exploration of human judgment and decision-making.', 4, 3, 'G2', 'available'),
('9780062316097', 'Sapiens', 'Yuval Noah Harari', 'Harvill Secker', 2011, 'History', 'A history of humanity from the Stone Age to modern times.', 5, 4, 'G3', 'available'),
('9780142045373', 'The Power of Now', 'Eckhart Tolle', 'Namaste Publishing', 1997, 'Self-Help', 'A guide to spiritual enlightenment and living in the present moment.', 3, 2, 'G4', 'available'),
('9780735211292', 'Atomic Habits', 'James Clear', 'Avery', 2018, 'Self-Help', 'A practical guide to building good habits and breaking bad ones.', 6, 5, 'G5', 'available'),
('9780743269513', 'The 7 Habits of Highly Effective People', 'Stephen Covey', 'Free Press', 1989, 'Self-Help', 'A personal development guide based on proven principles.', 4, 3, 'G6', 'available'),
('9780671015657', 'Rich Dad Poor Dad', 'Robert T. Kiyosaki', 'TechPress', 1997, 'Finance', 'A guide to personal finance and wealth creation.', 5, 4, 'G7', 'available'),
('9780060085940', 'The Intelligent Investor', 'Benjamin Graham', 'Harper Business', 1949, 'Finance', 'A classic guide to value investing and financial security.', 3, 2, 'G8', 'available'),
('9780596158071', 'Python Programming', 'Mark Lutz', 'O Reilly Media', 2013, 'Technology', 'A comprehensive guide to learning Python programming.', 4, 3, 'H1', 'available'),
('9780596517748', 'JavaScript: The Good Parts', 'Douglas Crockford', 'O Reilly Media', 2008, 'Technology', 'A focused guide to the most effective features of JavaScript.', 3, 2, 'H2', 'available'),
('9780201616224', 'The Pragmatic Programmer', 'David Thomas', 'Addison-Wesley', 1999, 'Technology', 'A guide to practical programming techniques and best practices.', 2, 1, 'H3', 'available'),
('9780132350884', 'Clean Code', 'Robert C. Martin', 'Prentice Hall', 2008, 'Technology', 'A handbook on writing readable and maintainable code.', 4, 3, 'H4', 'available'),
('9780201633610', 'Design Patterns', 'Gang of Four', 'Addison-Wesley', 1994, 'Technology', 'A foundational text on reusable design solutions.', 2, 1, 'H5', 'available'),
('9780131103627', 'The C Programming Language', 'Brian W. Kernighan', 'Prentice Hall', 1988, 'Technology', 'The definitive guide to the C programming language.', 3, 2, 'H6', 'available'),
('9780553380163', 'A Brief History of Time', 'Stephen Hawking', 'Bantam', 1988, 'Science', 'An exploration of the universe from the Big Bang to black holes.', 4, 3, 'I1', 'available'),
('9780394446387', 'Cosmos', 'Carl Sagan', 'Random House', 1980, 'Science', 'A journey through space and the wonders of the universe.', 3, 2, 'I2', 'available'),
('9780192860925', 'The Selfish Gene', 'Richard Dawkins', 'Oxford University Press', 1976, 'Science', 'A revolutionary look at evolution from the gene perspective.', 2, 1, 'I3', 'available'),
('9780465026562', 'Godel, Escher, Bach', 'Douglas Hofstadter', 'Basic Books', 1979, 'Science', 'An exploration of consciousness, mathematics, and music.', 2, 1, 'I4', 'available'),
('9780393312355', 'A Clockwork Orange', 'Anthony Burgess', 'William Heinemann', 1962, 'Fiction', 'A dystopian novel about free will and morality.', 3, 2, 'A14', 'available'),
('9780385490818', 'The Handmaids Tale', 'Margaret Atwood', 'McClelland and Stewart', 1985, 'Fiction', 'A dystopian novel about women in a totalitarian society.', 4, 3, 'A15', 'available'),
('9780307275134', 'Beloved', 'Toni Morrison', 'Random House', 1987, 'Fiction', 'A powerful novel about slavery and its psychological aftermath.', 2, 1, 'A16', 'available'),
('9780061120084', 'The Kite Runner', 'Khaled Hosseini', 'Riverhead Books', 2003, 'Fiction', 'A moving story of friendship and redemption in Afghanistan.', 5, 4, 'A17', 'available'),
('9780385333313', 'The Book Thief', 'Markus Zusak', 'Picador', 2005, 'Fiction', 'A novel narrated by Death set during World War II.', 4, 3, 'A18', 'available'),
('9780571212713', 'Atonement', 'Ian McEwan', 'Jonathan Cape', 2001, 'Fiction', 'A narrative about guilt, love, and the power of storytelling.', 3, 2, 'A19', 'available'),
('9780563543558', 'The Midnight Library', 'Matt Haig', 'Viking', 2020, 'Fiction', 'A story about exploring alternate versions of ones life.', 6, 5, 'A20', 'available'),
('9780735219090', 'Where the Crawdads Sing', 'Delia Owens', 'G.P. Putnams Sons', 2018, 'Fiction', 'A mystery and coming-of-age story set in North Carolina marshes.', 5, 4, 'A21', 'available'),
('9781501139239', 'The Seven Husbands of Evelyn Hugo', 'Taylor Jenkins Reid', 'Atria Books', 2017, 'Fiction', 'A glamorous tale of Old Hollywood and complex relationships.', 4, 3, 'A22', 'available'),
('9780374127169', 'Circe', 'Madeline Miller', 'Little, Brown', 2018, 'Fantasy', 'A reimagining of Greek mythology from the perspective of a goddess.', 4, 3, 'C8', 'available'),
('9780061979286', 'The Song of Achilles', 'Madeline Miller', 'Ecco', 2011, 'Fantasy', 'A romantic retelling of the Trojan War.', 3, 2, 'C9', 'available'),
('9780380789023', 'American Gods', 'Neil Gaiman', 'William Morrow', 2001, 'Fantasy', 'A dark fantasy about old and new gods in modern America.', 2, 1, 'C10', 'available'),
('9780552143721', 'Good Omens', 'Neil Gaiman', 'Gollancz', 1990, 'Fantasy', 'A humorous tale of an angel and demon trying to prevent the Apocalypse.', 3, 2, 'C11', 'available'),
('9780385333665', 'The Name of the Rose', 'Umberto Eco', 'Secker & Warburg', 1980, 'Fiction', 'A medieval mystery involving monks and forbidden knowledge.', 2, 1, 'A23', 'available'),
('9780006486466', 'Permutation City', 'Greg Egan', 'HarperCollins', 1994, 'Science Fiction', 'A philosophical science fiction novel about digital consciousness.', 1, 0, 'B8', 'unavailable'),
('9780141005676', 'The Time Machine', 'H.G. Wells', 'William Heinemann', 1895, 'Science Fiction', 'A classic tale of time travel and a future dystopia.', 4, 3, 'B9', 'available'),
('9780142437964', 'Journey to the Center of the Earth', 'Jules Verne', 'Pierre-Jules Hetzel', 1864, 'Adventure', 'An adventure novel about a journey beneath the Earths surface.', 3, 2, 'B10', 'available'),
('9780140439457', 'Twenty Thousand Leagues Under the Sea', 'Jules Verne', 'Pierre-Jules Hetzel', 1870, 'Adventure', 'An epic adventure on a mysterious submarine.', 2, 1, 'B11', 'available'),
('9780140440027', 'Around the World in Eighty Days', 'Jules Verne', 'Pierre-Jules Hetzel', 1873, 'Adventure', 'A thrilling journey around the world against time.', 4, 3, 'B12', 'available'),
('9780553277549', 'Treasure Island', 'Robert Louis Stevenson', 'Cassell', 1882, 'Adventure', 'A classic pirate adventure story.', 5, 4, 'B13', 'available'),
('9780141441239', 'The Adventures of Sherlock Holmes', 'Arthur Conan Doyle', 'George Newnes', 1892, 'Mystery', 'A collection of detective stories featuring Sherlock Holmes.', 4, 3, 'J1', 'available'),
('9780062693556', 'Murder on the Orient Express', 'Agatha Christie', 'Collins Crime Club', 1934, 'Mystery', 'A classic mystery with an intricate solution.', 5, 4, 'J2', 'available'),
('9780394749761', 'The Maltese Falcon', 'Dashiell Hammett', 'Alfred A. Knopf', 1930, 'Mystery', 'A noir detective novel with a priceless statuette.', 3, 2, 'J3', 'available'),
('9780553384314', 'The Big Sleep', 'Raymond Chandler', 'Alfred A. Knopf', 1939, 'Mystery', 'A hardboiled detective novel set in Los Angeles.', 2, 1, 'J4', 'available'),
('9780307269935', 'The Girl with the Dragon Tattoo', 'Stieg Larsson', 'Norstedts Förlag', 2005, 'Mystery', 'A modern noir mystery involving a journalist and a hacker.', 4, 3, 'J5', 'available'),
('9780316206822', 'The Cuckoos Calling', 'Robert Galbraith', 'Mulholland Books', 2013, 'Mystery', 'A contemporary detective novel about a supermodels death.', 3, 2, 'J6', 'available'),
('9781495446269', 'Verity', 'Colleen Hoover', 'Grand Central Publishing', 2018, 'Thriller', 'A psychological thriller about a writer with dark secrets.', 6, 5, 'K1', 'available'),
('9781476755465', 'It Ends with Us', 'Colleen Hoover', 'Atria Books', 2016, 'Fiction', 'A novel about domestic violence and second chances.', 5, 4, 'A24', 'available'),
('9781250073562', 'The Silent Patient', 'Alex Michaelides', 'Celadon Books', 2019, 'Thriller', 'A psychological thriller about a woman who stops speaking.', 4, 3, 'K2', 'available'),
('9780307588371', 'Gone Girl', 'Gillian Flynn', 'Crown Publishers', 2012, 'Thriller', 'A gripping thriller about a missing wife and a suspect husband.', 5, 4, 'K3', 'available'),
('9781594631511', 'The Girl on the Train', 'Paula Hawkins', 'Riverhead Books', 2015, 'Thriller', 'A psychological thriller set on a commuter train.', 4, 3, 'K4', 'available'),
('9780399590504', 'Educated', 'Tara Westover', 'Random House', 2018, 'Memoir', 'A memoir about escaping a survivalist cult and finding education.', 5, 4, 'F3', 'available'),
('9781234567890', 'The Year of Magical Thinking', 'Joan Didion', 'Alfred A. Knopf', 2005, 'Memoir', 'A meditation on grief following a sudden death.', 2, 1, 'F4', 'available'),
('9780297609255', 'I Am Malala', 'Malala Yousafzai', 'Weidenfeld & Nicolson', 2013, 'Biography', 'A memoir of a young activist fighting for education rights.', 4, 3, 'F5', 'available'),
('9780743225037', 'The Pursuit of Happyness', 'Chris Gardner', 'Amistad Press', 2006, 'Biography', 'A true story of homelessness and success against odds.', 3, 2, 'F6', 'available'),
('9780582094376', 'To The Lighthouse', 'Virginia Woolf', 'Hogarth Press', 1927, 'Fiction', 'A modernist novel exploring consciousness and time.', 2, 1, 'A25', 'available'),
('9780141439556', 'The Great Expectations', 'Charles Dickens', 'Chapman and Hall', 1860, 'Fiction', 'A coming-of-age story set in Victorian England.', 3, 2, 'A26', 'available'),
('9780143039990', 'The Count of Monte Cristo', 'Alexandre Dumas', 'Periódico de los Debates', 1844, 'Adventure', 'A tale of adventure, revenge, and redemption.', 4, 3, 'B14', 'available'),
('9780141198973', 'Les Misérables', 'Victor Hugo', 'A. Lacroix', 1862, 'Fiction', 'An epic novel about justice, love, and redemption in 19th century France.', 3, 2, 'A27', 'available'),
('9780140436372', 'The Three Musketeers', 'Alexandre Dumas', 'Serials in Musketeer Gazette', 1844, 'Adventure', 'A swashbuckling adventure about friendship and loyalty.', 4, 3, 'B15', 'available'),
('9780141439471', 'Frankenstein', 'Mary Shelley', 'Lackington', 1818, 'Gothic', 'A gothic novel about a scientist and his creation.', 5, 4, 'A28', 'available'),
('9780141441924', 'Dracula', 'Bram Stoker', 'Archibald Constable', 1897, 'Gothic', 'A gothic novel about a vampire and his hunt across Europe.', 4, 3, 'A29', 'available'),
('9780451531445', 'The Strange Case of Dr. Jekyll and Mr. Hyde', 'Robert Louis Stevenson', 'Longmans', 1886, 'Gothic', 'A novella about a scientist and his darker alter ego.', 3, 2, 'A30', 'available');

-- =============================================
-- INSERT SAMPLE BORROW LOGS (Optional)
-- =============================================

INSERT INTO borrow_logs (member_id, book_id, borrow_date, due_date, return_date, status, fine_amount) VALUES
(1, 1, '2024-12-01', '2024-12-15', NULL, 'borrowed', 0),
(2, 2, '2024-12-02', '2024-12-16', '2024-12-14', 'returned', 0),
(3, 3, '2024-12-03', '2024-12-17', NULL, 'borrowed', 0),
(4, 5, '2024-11-20', '2024-12-04', NULL, 'overdue', 60),
(5, 7, '2024-12-05', '2024-12-19', NULL, 'borrowed', 0),
(6, 10, '2024-11-25', '2024-12-09', NULL, 'overdue', 40),
(7, 12, '2024-12-08', '2024-12-22', NULL, 'borrowed', 0),
(8, 15, '2024-12-09', '2024-12-23', NULL, 'borrowed', 0),
(9, 18, '2024-11-28', '2024-12-12', NULL, 'overdue', 20),
(10, 20, '2024-12-10', '2024-12-24', NULL, 'borrowed', 0),
(11, 25, '2024-12-11', '2024-12-25', NULL, 'borrowed', 0),
(12, 30, '2024-11-15', '2024-11-29', NULL, 'overdue', 80),
(13, 35, '2024-12-12', '2024-12-26', NULL, 'borrowed', 0),
(14, 40, '2024-12-04', '2024-12-18', '2024-12-16', 'returned', 0),
(15, 45, '2024-12-13', '2024-12-27', NULL, 'borrowed', 0),
(16, 50, '2024-11-30', '2024-12-14', NULL, 'overdue', 30),
(17, 55, '2024-12-14', '2024-12-28', NULL, 'borrowed', 0),
(18, 60, '2024-12-06', '2024-12-20', '2024-12-20', 'returned', 0),
(19, 65, '2024-12-15', '2024-12-29', NULL, 'borrowed', 0),
(20, 70, '2024-11-18', '2024-12-02', NULL, 'overdue', 50);

-- =============================================
-- Verification Query
-- =============================================

SELECT 'Members Count:' as Info, COUNT(*) as Count FROM members
UNION ALL
SELECT 'Books Count:', COUNT(*) FROM books
UNION ALL
SELECT 'Borrow Records Count:', COUNT(*) FROM borrow_logs;
