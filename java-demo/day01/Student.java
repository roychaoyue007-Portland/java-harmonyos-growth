public class Student {
    private String name;
    private int age;

    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public void study(String subject) {
        System.out.println(name + " is studying " + subject + ".");
    }

    public void introduce() {
        System.out.println("My name is " + name + ", and I am " + age + " years old.");
    }

    public static void main(String[] args) {
        Student student = new Student("Roy", 25);
        student.introduce();
        student.study("Java");
    }
}

