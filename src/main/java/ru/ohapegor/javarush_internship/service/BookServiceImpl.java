package ru.ohapegor.javarush_internship.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.ohapegor.javarush_internship.dao.BookDAO;
import ru.ohapegor.javarush_internship.model.Book;


import java.util.List;

@Service
@Transactional(readOnly = true)
public class BookServiceImpl implements BookService {

    private BookDAO bookDAO;

    public BookServiceImpl() {
    }

    @Override
    public Book getBookById(int id) {
        return this.bookDAO.getBookById(id);
    }

    @Override
    public List<Book> getAllBooks() {
        return this.bookDAO.getAllBooks();
    }

    @Override
    @Transactional
    public void removeBookById(int id) {
        this.bookDAO.removeBookById(id);
    }

    @Override
    @Transactional
    public void addBook(Book book) {
        this.bookDAO.addBook(book);
    }

    @Override
    public List<Book> findBooksByTitle(String title) {
        return this.bookDAO.findBooksByTitle(title);
    }

    @Override
    @Transactional
    public void updateBook(Book book) {
        this.bookDAO.updateBook(book);
    }

    public void setBookDAO(BookDAO bookDAO) {
        this.bookDAO = bookDAO;
    }
}
