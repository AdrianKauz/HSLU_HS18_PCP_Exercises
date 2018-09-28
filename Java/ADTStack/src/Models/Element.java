package Models;

import Interfaces.IElement;

public class Element implements IElement
{
    private int value;
    private Element nextElement;

    public Element(int value) {
        this.value = value;
    }

    public int getValue() {
        return this.value;
    }

    public Element getNext() {
        return this.nextElement;
    }

    public void setNext(Element next) {
        this.nextElement = next;
    }
}
