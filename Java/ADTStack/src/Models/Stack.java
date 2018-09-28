package Models;

import Interfaces.IStack;

public class Stack implements IStack
{
    private static final int STACK_EMPTY_INDEX = -1;
    private int index = -1;
    private Element topElement;

    public void push(Element e) {
        if (this.topElement == null) {
            this.topElement = e;
        } else {
            e.setNext(this.topElement);
            this.topElement = e;
        }

        this.index++;
    }

    public Element top() {
        return (this.index > Stack.STACK_EMPTY_INDEX) ? this.topElement : null;
    }

    public boolean pop() {
        if (this.index > Stack.STACK_EMPTY_INDEX) {
            this.topElement = this.topElement.getNext();
            this.index--;

            return true;
        }

        return false;
    }

    public void print() {
        if (this.index > Stack.STACK_EMPTY_INDEX) {
            int topElement = this.topElement.getValue();

            StringBuilder builder = new StringBuilder();
            builder.append("print - Stack contains:");

            Element currElement = this.topElement;
            do {
                builder.append(" ");
                builder.append(Integer.toString(currElement.getValue()));
                builder.append(",");

                currElement = currElement.getNext();
            } while (currElement != null);

            builder.append(" top Element = ");
            builder.append(Integer.toString(topElement));

            System.out.println(builder.toString());
        } else {
            System.out.println("print - Stack is empty");
        }
    }

    public boolean isEmpty() {
        return (this.index <= Stack.STACK_EMPTY_INDEX);
    }

    public int size() {
        return this.index + 1;
    }
}
