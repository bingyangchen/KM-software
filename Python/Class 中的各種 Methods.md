Python 的 class 可以擁有 instance method, class method 以及 static method 三種不同 method。

# Instance Method

```Python
class Dog:
	def __init__(self):
		self.age = 0
		self.weight = 10

	def eat(self):
		self.weight += 1

	def grow(self):
		self.eat()
		self.age += 1

if __name__ == "__main__":
	d = Dog()
	d.grow()
```

Instance method 是給實例化後的 object 使用的。定義 instance method 時，第一個參數必須用來代表 object 本身（通常命名為 `self`），擁有這個參數使得 instance method 可以 access 其他 instance attributes 與 instance methods，比如上例中的 `self.eat()` 與 `self.age += 1`。

但要注意，在 class 外呼叫 instance method 時，並不需要在第一個參數位置填入引數，以上例而言，object `d` call `grow` method 時，其實不用填任何參數。

>在大部分其他 OOP 程式語言（如 Java, C#）中，定義 instance method 時並沒有在第一個參數寫 `self` 的規則。在 class 內，`this.x` 即表示 instance attribute `x`。

# Class Method

```Python
class Dog:
	max_age = 10
	
	def __init__(self):
		self.age = 0
		self.weight = 10
	
	@classmethod
	def set_max_age(cls, max_age):
		cls.max_age = max_age
	
	@classmethod
	def another_set_max_age(cls, max_age):
		cls.set_max_age(max_age)

if __name__ == "__main__":
	d1 = Dog()
	d2 = Dog()
	print(d1.max_age, d2.max_age, Dog.max_age) # 10 10 10
	
	d1.set_max_age(15)
	print(d1.max_age, d2.max_age, Dog.max_age) # 15 15 15

	Dog.set_max_age(20)
	print(d1.max_age, d2.max_age, Dog.max_age) # 20 20 20

	Dog.another_set_max_age(25)
	print(d1.max_age, d2.max_age, Dog.max_age) # 25 25 25
```

Class method 是給 class 使用的 method，然而其實若你用實例化後的 object 呼叫 class method，Python Interpreter 也會給過（效果與用 class 呼叫是一樣的），你可以把這個特性視為一種防呆機制，因為在純正的 OOP 中，使用 class 呼叫 class method 才是正規的使用方式。

每一個 class method 的開頭都必須使用 decorator `@classmethod` 裝飾之。

定義 class method 時，第一個參數必須用來代表 class 本身（通常命名為 `cls`），擁有這個參數使得 class method 可以 access 其他 class attributes 與 class methods，比如上例中的 `cls.max_age = max_age` 與 `cls.set_max_age(max_age)`。

但要注意，在 class 外呼叫 class method 時，並不需要在第一個參數位置填入引數，以上例而言，class `Dog` call `set_max_age` method 時，只填入 `max_age` 引數。

class attributes 必須定義於 constructor method (`__init__`) 外面，通常是上面，也就是最開頭，注意並沒有 `cls.` 開頭。

>在大部分其他 OOP 程式語言（如 Java, C#）中，定義 class method 時並沒有在第一個參數寫 `cls` 的規則。在 class 內，`類別名稱.x` 即表示 class attribute `x`。

# Static Method

Static method 與 Class method 互為替代關係，也就是說你完全可以把一個 class method 改寫為 static method。為了保持一致性，建議一律採用 class method，或者一律採用 static mehtod，不要在一個 class 中有些是 class method 有些是 static method。

```Python
class Dog:
	max_age = 10
	
	def __init__(self):
		self.age = 0
		self.weight = 10
	
	@staticmethod
	def set_max_age(max_age):
		Dog.max_age = max_age
	
	@staticmethod
	def another_set_max_age(max_age):
		Dog.set_max_age(max_age)

if __name__ == "__main__":
	d1 = Dog()
	d2 = Dog()
	print(d1.max_age, d2.max_age, Dog.max_age) # 10 10 10
	
	d1.set_max_age(15)
	print(d1.max_age, d2.max_age, Dog.max_age) # 15 15 15

	Dog.set_max_age(20)
	print(d1.max_age, d2.max_age, Dog.max_age) # 20 20 20

	Dog.another_set_max_age(25)
	print(d1.max_age, d2.max_age, Dog.max_age) # 25 25 25
```

與 Class method 類似，若你用實例化後的 object 呼叫 class method，Python Interpreter 也會給過（效果與用 class 呼叫是一樣的），你還是可以把它視為一種防呆機制。

每一個 static method 的開頭都必須使用 decorator `@staticmethod` 裝飾之。

與 class method 不同的是，定義 static method 時，沒有所謂「第一個參數必須用來代表 class 本身」的規則。網路上有很多文章在說明 Python 的 static method 與 class method 的差別時，都會提到 static method 因為沒有這個 implicit first argument，所以不能用來 access class attributes 與其它 class/static methods。

不過，事實並非如此！

**其實使用 `類別名稱.x` 就可以 access class attributes；使用 `類別名稱.method_name()` 就是在呼叫 static methods 了。**

就像你在上方例子中看見的，我可以在 `set_max_age` 這個 static method 中使用 `Dog.max_age` 的方式 access `max_age` 這個 class attribute，也可以在 `another_set_max_age` 這個 static method 中使用 `Dog.set_max_age(max_age)` 的方式 access `set_max_age` 這個 static method。其實，這也才是正統 OOP 該有的性質（有趣的是，在正統 OOP 中，這種 method 才叫做 Class Method，只是會有一個叫做 `static` 的 syntax sugar）。

# 後記

如果你興趣做一些小實驗，可以試試看在 class 中以 `類別名稱.method_name()` 的方式 call 一個 class method，或者在一個 class method 中用 `cls.method_name()` 的方式 call 一個 static method。你會發現他們都可以運作！

我個人覺得這是一種很不好的設計，歸根結底而言，我覺得根本就不應該存在 class method 與 static method 這樣可以互相替代彼此的設計 method 的方式，這個現象是在其他主流 OOP 語言中都找不到的。如果是我，會選擇一律使用 static method 作為存取 class attributes 與單純進行運算所用。

# 參考資料

https://www.tutorialspoint.com/class-method-vs-static-method-in-python#