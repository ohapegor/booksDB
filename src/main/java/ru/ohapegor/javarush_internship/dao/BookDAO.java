package ru.ohapegor.javarush_internship.dao;


import ru.ohapegor.javarush_internship.model.Book;

import java.util.List;

public interface BookDAO {

    Book getBookById(int id);

    List<Book> getAllBooks();

    void removeBookById(int id);

    void addBook(Book book);

    List<Book> findBooksByTitle(String title);

    void updateBook(Book book);

}
