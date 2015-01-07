% General Architecture of this "Blogging" System

The main idea behind this system is that my site is supposed to consist of
*posts* which are organized into *lists of posts*. This mapping is not assumed
to be injective, i.e. a post may be a member of many lists. In fact, this is how
the list [All Posts](/lists/zz_all.html) is made: every post is supposed to be
linked into it.

To keep order in this mess of data, I have decided to map it into the file
system. I have a folder `posts` which contains all posts and a folder `lists`
with all the lists. Every list is a folder with symbolic links to posts:

    blog
    ├── lists
    │   ├── all
    │   │   ├── 001 -> ../../posts/hello-world.md
    │   │   └── title
    │   ├── blog
    │   │   └── title
    └── posts
        └── hello-world.md

As you can see, I have added a special file to each list folder named `title`
which contains the title of the list (as you might have guessed).

Posts are written as [Markdown](http://en.wikipedia.org/wiki/Markdown) files and
converted to HTML with [Pandoc](http://en.wikipedia.org/wiki/Pandoc). Pandoc
handles this conversion almost perfectly, but I had one small issue with
it. Namely, I want to be able to write mathematics and hence translate
TeX--snippets into something that your browser can display.

Pandoc has several builtin methods to do this, but most of them either rely on a
specialised TeX--parser or JavaScript. Both were deemed too ugly to use. So I
wrote a filter around Pandoc to extract TeX-snippets and compile them with my
regular LaTeX distribution into SVG. This seems to work quite nicely.

The next issue was keeping this mess of posts and lists and Markdown files under
control. Traditionally, I would have used a Makefile for that but I wanted
something a little nicer this time. I turned to an old idea of
[Dan Bernstein's](http://cr.yp.to/djb.html):
[Redo](http://cr.yp.to/redo.html). There are several implementations of Redo out
there; eventually I plan to write my own, just as practice. For now, I use a
very minimal implementation in shell script from
<https://github.com/apenwarr/redo>.

More on how exactly the conversion from Markdown to HTML and all the associated
ecosystem works will appear in a later post.
