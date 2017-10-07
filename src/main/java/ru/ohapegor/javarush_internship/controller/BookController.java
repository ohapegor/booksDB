package ru.ohapegor.javarush_internship.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import ru.ohapegor.javarush_internship.model.Book;
import ru.ohapegor.javarush_internship.service.BookService;

import java.util.List;

@Controller
public class BookController {

    private BookService bookService;

    private static final int MAX_ROWS_PER_PAGE = 10;

    @Autowired(required = true)
    @Qualifier(value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping("/")
    public ModelAndView getAllBooks(@RequestParam(required = false) Integer page,
                                    @RequestParam(required = false) Integer id,
                                    @RequestParam(required = false) String searchTitle) {
        ModelAndView modelAndView = new ModelAndView("bookList");
        //Setting book by id for edit area
        Book book;
        if (id == null || id == 0) book = new Book();
        else book = this.bookService.getBookById(id);
        if (book == null) book = new Book();
        modelAndView.addObject("book", book);

        //Setting book list matching searchTitle if given.
        List<Book> books;
        if (searchTitle == null || searchTitle.equals("")) books = this.bookService.getAllBooks();
        else books = this.bookService.findBooksByTitle(searchTitle);
        modelAndView.addObject("searchTitle", searchTitle);

        //Preparing paging
        PagedListHolder<Book> pagedListHolder = new PagedListHolder<>(books);
        pagedListHolder.setPageSize(MAX_ROWS_PER_PAGE);
        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());

        if (page == null || page < 1 || page > pagedListHolder.getPageCount()) {
            page = 1;
        }
        modelAndView.addObject("page", page);
        if (page <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(page - 1);
            modelAndView.addObject("bookList", pagedListHolder.getPageList());
        }
        return modelAndView;
    }

    @RequestMapping("deleteBook")
    public String deleteBook(@RequestParam int id,
                             @RequestParam(required = false) Integer page,
                             @RequestParam(required = false) String searchTitle) {
        this.bookService.removeBookById(id);
        return "redirect:/" + "?page=" + page+ "&searchTitle=" + searchTitle;
    }

    @RequestMapping("readBook")
    public String readBook(@RequestParam int id,
                           @RequestParam(required = false) Integer page,
                           @RequestParam(required = false) String searchTitle) {
        Book book = this.bookService.getBookById(id);
        book.setReadAlready(true);
        this.bookService.updateBook(book);
        return "redirect:/" + "?page=" + page+ "&searchTitle=" + searchTitle;
    }

    @RequestMapping("addBook")
    public String addBook(@ModelAttribute("book") Book book,
                          @RequestParam(required = false) Integer page,
                          @RequestParam(required = false) String searchTitle) {
        if (book.getId() == 0) {
            this.bookService.addBook(book);
        } else {
            Book storedBook = this.bookService.getBookById(book.getId());
            if (!storedBook.equals(book)) {
                book.setReadAlready(false);
                this.bookService.updateBook(book);
            }
        }
        return "redirect:/?page=" + page + "&searchTitle=" + searchTitle;
    }


    @RequestMapping("editBook")
    public String editBook(@RequestParam Integer id,
                           @RequestParam(required = false) Integer page,
                           @RequestParam(required = false) String searchTitle) {
        return "redirect:/?page=" + page + "&id=" + id + "&searchTitle=" + searchTitle;
    }


    @RequestMapping("searchBook")
    public String searchById(@RequestParam(required = false) Integer page,
                             @RequestParam(required = false) Integer id,
                             @RequestParam(required = false) String searchTitle) {
        return "redirect:/?page=" + page + "&id=" + id + "&searchTitle=" + searchTitle;
    }
}

