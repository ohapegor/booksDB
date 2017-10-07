package ru.ohapegor.javarush_internship.dao;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import ru.ohapegor.javarush_internship.model.Book;

import java.util.List;


@Repository
public class BookDAOImpl implements BookDAO {

    private static final Logger logger = LoggerFactory.getLogger(Book.class);

    private SessionFactory sessionFactory;

    public BookDAOImpl() {
    }

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public Book getBookById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        Book book = (Book) session.load(Book.class, new Integer(id));
        logger.info("Book successfully loaded : " + book);
        return book;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Book> getAllBooks() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Book> bookList = session.createQuery("from Book").list();
        for (Book book : bookList){
            logger.info("Book list : " + book);
        }
        return bookList;
    }

    @Override
    public void removeBookById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        Book book = (Book)session.load(Book.class, new Integer(id));
        if (book != null){
            session.delete(book);
        }
        logger.info("Book successfully removed. Book details : " + book);
    }

    @Override
    public void addBook(Book book) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(book);
        //session.save(book);
        logger.info("Book successfully added. Book details : " + book);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Book> findBooksByTitle(String title) {
        Session session = this.sessionFactory.getCurrentSession();
        List<Book> bookList = session.createQuery("FROM Book WHERE title LIKE '%"+title+"%'").list();
        for (Book book : bookList) {
            logger.info("Book list with title like "+title+" : " + book);
        }
        return bookList;
    }

    @Override
    public void updateBook(Book book) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(book);
        logger.info("Book successfully updated. Book details : " + book);
    }

 }
