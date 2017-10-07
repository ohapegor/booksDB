package ru.ohapegor.javarush_internship.service;


import ru.ohapegor.javarush_internship.model.Book;

import java.util.List;


public interface BookService {

    Book getBookById(int id);

    List<Book> getAllBooks();

    void removeBookById(int id);

    void addBook(Book book);

    List<Book> findBooksByTitle(String name);

    void updateBook(Book book);

}
