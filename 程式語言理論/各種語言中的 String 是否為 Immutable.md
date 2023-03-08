-   In Java, C#, JavaScript, Python and Go, strings are immutable. Furthermore, Java, C#, JavaScript and Go have the notion of a constant: a “variable” that cannot be reassigned. (I am unsure how well constants are implemented and supported in JavaScript, however.)

-   In Ruby and PHP, strings are mutable.

-   The C language does not really have string objects per se. However, we commonly represent strings as a pointer `char *`. In general, C strings are mutable. The C++ language has its own string class. It is mutable.

    In both C and C++, string constants (declared with the const qualifier) are immutable, but you can easily “cast away” the const qualifier, so the immutability is weakly enforced.
