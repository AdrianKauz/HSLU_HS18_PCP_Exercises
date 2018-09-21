package Interfaces;

import Models.Element;

public interface IElement {
    int getValue();
    Element getNext();
    void setNext(Element next);
}
