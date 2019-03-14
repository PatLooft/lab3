//
//  Bookstore.swift
//  lab3
//
//  Created by Pat Looft on 3/12/19.
//  Copyright © 2019 Pat Looft. All rights reserved.
//

import Foundation

class Bookstore{
    private var books = [Book]();
    private var totalBooks: Int;
    private var gross: Double;
    private static var MAX_BOOKS = 1000;
    
    // a failable nitializer that creates a new, empty Bookstore object.
    public init?(){
        self.totalBooks = 0;
        self.gross = 0;
    }
    // Adds a new Book b to the stock of the Bookstore object.
    public func addNewBook(b:Book){
        for bo in books{
            if(bo.getTitle() == b.getTitle()){
                bo.addQuantity(amount: b.getQuantity());
                return;
            }
        }
        books.append(b);
    }
    // Adds quantity number of books to the book already in stock in the Bookstore object with
    // the title title. If the book is not in the Bookstore object, nothing is done.
    public func addBookQuantity(title:String, quantity:Int){
        for bo in books{
            if(bo.getTitle() == title){
                bo.addQuantity(amount: quantity);
            }
        }
    }
    // Returns true if quantity or more copies of a book with the title are contained in the Bookstore object.
    public func inStock(title:String, quantity:Int)->Bool{
        for bo in books{
            if(bo.getTitle() == title){
                return true;
            }
        }
        return false;
    }
    // Executes selling quantity number of books from the Bookstore object with the title to the
    // buyer. (Note: there is no I/O done in this method, the Bookstore object is changed to reflect
    // the sale. The method returns true is the sale was executed successfully, false otherwise.
    public func sellBook(title:String, quantity:Int)->Bool{
        for bo in books{
            if(bo.getTitle() == title){
                if(bo.getQuantity() >= quantity && quantity >= 0){
                    self.gross += bo.getPrice() * Double(quantity);
                    bo.subtractQuantity(amount: quantity);
                    print("Sold \(quantity) copies of \(bo.getTitle()).");
                    return true;
                }
                else if(quantity >= 0){//if there is some books left, but not the amount to be sold
                    self.gross = bo.getPrice() * Double(bo.getQuantity());
                    var count: Int;
                    count = 0;
                    for b in books{
                        if(b.getTitle() == bo.getTitle()){
                            break;
                        }
                        count+=1;
                    }
                    print("Only sold \(bo.getQuantity()) copies of \(bo.getTitle()), as that was the remaining stock.");
                    books.remove(at: count);
                    return true;
                }
            }
        }
        print("Book not in stock")
        return false;
    }
    // Lists all of the titles of the books in the Bookstore object.
    public func listTitles(){
        for b in books{
            print(b.getTitle());
        }
    }
    // Lists all of the information about the books in the Bookstore object.
    public func listBooks(){
        for b in books{
            print(b.toString()+"\n");
        }
    }
    // Returns the total gross income of the Bookstore object.
    public func getIncome()->Double{
        return self.gross;
    }
    
    
    
    public func startStore(){
        print("[][][][][][][][][][][][][][][][][][][][][][][][][][][]\n[][]          Welcome to Temple Bookstore!        [][]\n[][][][][][][][][][][][][][][][][][][][][][][][][][][]\n\n======================================================");
    }
    
    public func displayPrompt(){
        var cont = true;
        while(cont){
            print("What would you like to do today?\n\t1. Add a book\n\t2. Sell a book\n\t3. List of all titles\n\t4. List all information\n\t5. Print out gross income\n\t6. Quit")
            var menuInput = (Int)(readLine()!);
            switch(menuInput){
            case 1:
                print("What is the title of the book?")
                var title = readLine();
                while((title ?? "").isEmpty){
                    print("Please try again with a valid title.");
                    title = readLine();
                }
                print("How many pages is it?");
                var pages = receiveValidInt();
                
                print("What is the price?");
                var price = receiveValidDouble();
                
                print("Quantity?");
                var quantity = receiveValidInt();
                
                let b = Book(theTitle: title!, pages: pages, cost: price, num: quantity);
                self.addNewBook(b: b!);
                print("Book now in stock.")
                
            case 2:
                print("Which book would you like to sell?");
                let sellInput = readLine();
                if(sellInput?.isEmpty)!{
                    print("Please try again with a valid title.");
                }
                print("How many copies will be sold?");
                let amountSelling = receiveValidInt();
                if(!self.sellBook(title: sellInput!, quantity: amountSelling)){
                    print("Unable to complete transaction, please try again");
                }
            case 3:
                self.listTitles();
                
            case 4:
                self.listBooks();
                
            case 5:
                print("Gross income: \(self.getIncome())");
                
            case 6:
                cont = false;
                print("We hope to see you again!");
            default:
                print("Invalid input, please try again");
                continue;
            }
            print("\n\n======================================================")
        }
    }

    public func receiveValidInt()-> Int{
        var cond = true;
        var ret = -1;
        while cond{
            var input = readLine()!;
            if (input.isNotInt || (Int(input)! < 0)){
                print("Please try again with a valid integer.");
            }
            else{
                ret = Int(input)!;
                cond = false;
            }
        }
        return ret;
    }
    
    public func receiveValidDouble()-> Double{
        var cond = true;
        var ret = -1.0;
        while cond{
            var input = readLine()!;
            if (input.isNotDouble || (Double(input)?.isLess(than: 0.0))!) {
                print("Please try again with a valid dollar amount.");
            }
            else{
                ret = Double(input)!;
                cond = false;
            }
        }
        return ret;
    }
}
extension String {
    var isNotInt: Bool {
        return Int(self) == nil
    }
    var isNotDouble: Bool {
        return Double(self) == nil
    }
}
