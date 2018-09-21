package Interfaces;

import Models.Element;

public interface IStack {
    void push(Element e);
    Element top();
    boolean pop();
    void print();
    boolean isEmpty();
    int size();
}
