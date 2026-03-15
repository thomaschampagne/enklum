interface Person {
  name: string;
  age: number;
  greet(): string;
}

class Developer implements Person {
  constructor(
    public name: string,
    public age: number,
  ) {}

  greet(): string {
    return `Hello, I'm ${this.name}, ${this.age} years old.`;
  }
}

let d: Person = new Developer("hello", 123);

console.log(d);
