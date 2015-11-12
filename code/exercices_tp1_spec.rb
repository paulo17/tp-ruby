Dir["./code/implem/*.rb"].each {|file| require file }

describe "Exercice 1: Strings" do
  it "StringProcessor can count the number of letters in a string" do
    expect(StringProcessor.count("Hello")).to eq(5)
    expect(StringProcessor.count("Hello to all")).to eq(12)
    expect(StringProcessor.count("So many letters")).to eq(15)
    expect(StringProcessor.count("")).to eq(0)
  end

  it "StringProcessor can join two strings" do
    expect(StringProcessor.concat("Hello", "World")).to eq("Hello World")
    expect(StringProcessor.concat("Hello to", "all")).to eq("Hello to all")
  end

  it "StringProcessor can count the number of occurences of a given letter" do
    expect(StringProcessor.count("Hello", "h")).to eq(1)
    expect(StringProcessor.count("Hello", "H")).to eq(1)
    expect(StringProcessor.count("Hello", "l")).to eq(2)
    expect(StringProcessor.count("Hello", "z")).to eq(0)
    expect(StringProcessor.count("Hello all", "l")).to eq(4)
  end
end

describe "Exercice 2: Arrays" do
  it "ArrayProcessor can sort a given array" do
    a = ["A", "C", "B", "E", "F", "D"]
    expect(ArrayProcessor.sort(a)).to eq(["A", "B", "C", "D", "E", "F"])

    a = ["E", "F", "D", "A", "A", "A"]
    expect(ArrayProcessor.sort(a)).to eq(["A", "A", "A", "D", "E", "F"])
  end

  it "ArrayProcessor can be initialized with a given array and then access it" do
    array_processor = ArrayProcessor.new(["A", "C", "B"])
    expect(array_processor.my_array).to eq(["A", "C", "B"])
  end

  it "ArrayProcessor can be initialized with a given array and then access it, sorted or not" do
    array_processor = ArrayProcessor.new(["A", "C", "B", "D"])
    expect(array_processor.my_array_sorted).to eq(["A", "B", "C", "D"])
    expect(array_processor.my_array).to eq(["A", "C", "B", "D"])
  end

  it "ArrayProcessor can tell if an element is in the given array" do
    array_processor = ArrayProcessor.new(["A", "C", "B"])
    expect(array_processor.contains?("A")).to eq(true)
    expect(array_processor.contains?("C")).to eq(true)
    expect(array_processor.contains?("D")).to eq(false)
    expect(array_processor.contains?(nil)).to eq(false)
  end

  it "ArrayProcessor can double all entries in an array" do
    expect(ArrayProcessor.double(["a", "b", "c", "d"])).to eq(["aa", "bb", "cc", "dd"])
    expect(ArrayProcessor.double(["1", "b", "3", "EE"])).to eq(["11", "bb", "33", "EEEE"])
  end
end

describe "Exercice 3: Symbols" do
  it "Exists a symbol processor that can compare strings and symbols" do
    expect(SymbolProcessor.equal?(:hello, "hello")).to eq(true)
    expect(SymbolProcessor.equal?(:hello, "bonjour")).to eq(false)
    expect(SymbolProcessor.equal?("bonjour", "hello")).to eq(false)
    expect(SymbolProcessor.equal?("bonjour", :bonjour)).to eq(true)
  end
end

describe "Exerice 4: Hashes" do
  it "There is a hash processor that can be initialized" do
    hash_processor = HashProcessor.new({ name: "Zach Klein", age: 32 })
    expect(hash_processor.h).to eq({ name: "Zach Klein", age: 32 })
  end

  it "HashProcessor can give simple information about the given hash" do
    hash_processor = HashProcessor.new({ name: "Zach Klein", age: 32 })
    expect(hash_processor.size).to eq(2)
  end

  it "HashProcessor can merge a hash into the one it's initialized with" do
    hash_processor = HashProcessor.new({ name: "Zach Klein", age: 32 })

    expect(
      hash_processor.merge({ companies: ["Vimeo", "DIY", "CollegeHumor"] })
    ).to eq({ name: "Zach Klein", age: 32, companies: ["Vimeo", "DIY", "CollegeHumor"] })
  end

  it "HashProcessor can find anything in the hash and fail gracefully when there is nothing there" do
    hash_processor = HashProcessor.new({ last_name: "Klein", first_name: "Zach", age: 32 })

    expect(hash_processor.find(:first_name)).to eq("Zach")
    expect(hash_processor.find(:last_name)).to eq("Klein")
    expect(hash_processor.find(:name)).to eq("Unknown key, sorry")
  end

  it "HashProcessor can remove the value of a given key and restore it" do
    hash_processor = HashProcessor.new({ last_name: "Klein", first_name: "Zach", age: 32 })

    hash_processor.delete(:last_name)
    expect(hash_processor.h).to eq({ last_name: nil, first_name: "Zach", age: 32 })

    hash_processor.restore(:last_name)
    expect(hash_processor.h).to eq({ last_name: "Klein", first_name: "Zach", age: 32 })
  end
end

describe "Exercice 5: Classes" do
  it "It exists a way to describe a dog and a cat using the concept of Animal" do
    dog = Dog.new
    dog.name = "Fido"
    expect(dog.name).to eq("Fido")

    cat = Cat.new
    cat.name = "Mr Cat"
    expect(cat.name).to eq("Mr Cat")

    cat.name = "Mr Cat Junior"
    expect(cat.name).to eq("Mr Cat Junior")

    other_dog = Dog.new(name: "Fido")
    expect(other_dog.name).to eq("Fido")

    expect(dog.class.superclass).to eq(Animal)
  end

  it "Animals have a way to speak" do
    animals = [
      Cat.new, Dog.new, Cat.new, Cat.new
    ]
    res = []
    animals.each do |animal|
      res << animal.speak
    end
    expect(res).to eq(["meow", "woof", "meow", "meow"])
  end

  it "We can define predators for a given animal instance" do
    mouse = Mouse.new
    cat = Cat.new
    dog = Dog.new

    mouse.predators = [Dog, Cat]
    cat.predators = [Dog]

    expect(mouse.predator?(cat)).to eq(true)
    expect(mouse.predator?(dog)).to eq(true)
    expect(mouse.predator?(mouse)).to eq(false)

    expect(cat.predator?(dog)).to eq(true)
    expect(cat.predator?(mouse)).to eq(false)

    expect(dog.predator?(dog)).to eq(false)
    expect(dog.predator?(mouse)).to eq(false)
    expect(dog.predator?(cat)).to eq(false)
  end

  it "An animal can enter into a rage. Then it has no more predators" do
    mouse = Mouse.new
    cat = Cat.new
    dog = Dog.new

    mouse.predators = [Dog, Cat]

    expect(mouse.predator?(cat)).to eq(true)
    expect(mouse.predator?(dog)).to eq(true)

    mouse.enter_rage!

    expect(mouse.predator?(cat)).to eq(false)
    expect(mouse.predator?(dog)).to eq(false)

    mouse.exit_rage!

    expect(mouse.predator?(cat)).to eq(true)
    expect(mouse.predator?(dog)).to eq(true)
  end

end

describe "Exercice 6: Interview Question" do
  # There are cars parked in a long street and we need to know the maximum number
  # of cars with the same color next to one another. We want this for each different
  # color in order to compare the data and determine some _very important KPIs_.
  #
  # The cars are represented by an array of colors.
  #
  # e.g.: ["blue", "blue" "red"] means that there are 1 blue car, next to it there is another
  # blue car, next to it there is a red car.
  #
  # Here we want to return "2" for blue and "1" for red.

  it "returns the maximum number of adjacent cars with the same color for each available color" do
    cars = [
      "blue", "red", "red", "blue", "yellow", "yellow", "blue", "green", "blue", "blue",
      "blue", "blue", "red", "yellow", "purple", "purple", "purple", "purple", "blue"
    ]
    expect(CarSort.perform(cars)).to eq({ blue: 4, green: 1, purple: 4, red: 2, yellow: 2 })

    other_cars = [
      "blue", "yellow", "red", "red", "red", "blue", "blue"
    ]
    expect(CarSort.perform(other_cars)).to eq({ blue: 2, red: 3, yellow: 1 })

    more_cars = [
      "black", "white", "black", "white", "black", "white"
    ]
    expect(CarSort.perform(more_cars)).to eq({ black: 1, white: 1 })
  end
end

describe "Exercice 7: Simple data store in memory" do
  # This exercice uses more advanced concepts.
  #
  # Keywords arguments: https://robots.thoughtbot.com/ruby-2-keyword-arguments
  # Metaprogramming:
  #  - http://ruby-doc.org/core-2.1.0/BasicObject.html#method-i-method_missing
  #  - http://www.leighhalliday.com/ruby-metaprogramming-method-missing

  it "stores data" do
    # We have a data store
    store = DataStore.new

    # We define a new model called "user"
    store.register_model(name: "user", attributes: [:first_name, :last_name])
    expect(store.models).to eq(["user"])

    # We use the newly defined model to store an entry
    store.save(
      model: "user",
      attributes:{
        first_name: "John", last_name: "Collison"
      }
    )

    # And then we get the item and check if the data is correctly saved
    user = store.last("user")
    expect(user.first_name).to eq("John")
    expect(user.last_name).to eq("Collison")
    expect(user.other_attribute).to eq("INVALID")

    # One more time
    store.save(
      model: "user",
      attributes:{
        first_name: "Mark", last_name: "Zuckerberg"
      }
    )
    user = store.last("user")
    expect(user.first_name).to eq("Mark")
    expect(user.last_name).to eq("Zuckerberg")

    # Now for another model
    store.register_model(name: "article", attributes: [:title, :body])
    expect(store.models).to eq(["user", "article"])
    store.save(
      model: "article",
      attributes:{
        title: "How to Ruby", body: "Write the code, get the fame"
      }
    )
    article = store.last("article")
    expect(article.title).to eq("How to Ruby")

    # Of course adding an article doesn't change anything to the user model
    expect(store.last("user").first_name).to eq("Mark")

    # Convenience methods
    expect(store.count("user")).to eq(2)
    expect(store.count("article")).to eq(1)

    # Impossible to setup an object with invalid attributes
    expect(store.last_error).to eq(nil)
    store.save(
      model: "user",
      attributes:{
        full_name: "Mario Mario"
      }
    )
    expect(store.count("user")).to eq(2)
    expect(store.last_error).to eq("Invalid attribute: full_name")

    # One last time
    store.save(
      model: "user",
      attributes:{
        age: 42
      }
    )
    expect(store.count("user")).to eq(2)
    expect(store.last_error).to eq("Invalid attribute: age")
  end
end
