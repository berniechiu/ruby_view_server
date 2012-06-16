# Pure Ruby HTML Generator

## What?

This project uses pure ruby and standard libraries to perform 4 basic functions. The goal is to generate useful html pages using as little code as possible.

We gradually increase the complexity of the code as we add more functionality and make development simpler.


## Git homework

There is homework associated with this demo, after each section you will need to complete the homework and then commit the results to git. Before you begin you will need a github account. Once you've got that come back to []() and click the "fork" button. That will create a fork of this code. Clone the code to your laptop by going to your fork copying in the git address and the in the command line running `git clone` like this:

    $ git clone https://github.com/.../... .git # replace the https... section with your own url (ends in .git)

Once you're done with the homework and it has been committed to your laptop, push it to your fork on Github. Then open a pull request. Your assignment will be graded from this pull request. To make commit changes go to the directory then run


    $ git add .

This will add your changes to the git repository, once you're happy with the changes commit it to the local repository with:


    $ git commit -m "homework section 1 completed"

To push your local changes to github you can run:

    $ git push origin master

Origin refers to the place where you cloned the code from (github) and master refers to the branch you're on.


## Erb

ERB stands for Embedded RuBy. It is useful to use for embedding ruby code in html. Ruby goes inside of tags that look like this `<%= %>`. Here is an example you can run through in irb

    $ irb
    require 'erb'

    name = 'richard'
    erb_string = "<h2><%= name.upcase %></h2>"

    template = ERB.new(erb_string)
    puts template.result(binding)
    # => <h2>RICHARD</h2>


The flow for generating ruby powered html generally works like this. First we generate a document that is written in a html that has erb in it. These files typically have the extension `.html.erb`. We then read in the document, parse the erb and then we have fully valid html. We can do whatever we like with that such as write it to a static file or serve it dynamically with a server.

Erb blocks without the equals will not print out `<% %>` but will still be evaluated. You can use these for doing work such as math in your erb template.


## 1) Erb Example

In the terminal you can run

    $ ruby erb_example.rb

Homework:

Modify the file, and re-run it using ruby. Add at least 3 more lines and 3 more erb blocks with different types of contents, consider using strings, arrays, hashes, or integers.

Try modifying the data in the erb blocks using concatenation or other methods.

If you get errors try re-running the generator and reading the error messages. You can add debugging `puts` statements in your view or the script to help you figure out what is going on

Commit the results to git

## 2) Simple Page Generator Example

In the terminal you can run

    $ ruby page_generator.rb

This will loop through all the files in the `views` directory, parse their erb and write the contents to the `public` directory.

Run the generator and drag a page from the `public` directory to your browser, it should render.

homework:

Add another file to the `/views` directory with your name. Add some personalized content directly to the file. Pretend this is geocities and you're making a home-page. Try using different tags such as `<div>`, `<p>`, `<span>`, or look up tags to use on w3c.

Use an array `[]` and the `each` method to output some content on your page in list items.

    <ul>
      <% ['apples', 'oranges', 'bananas'].each do |fruit|
        <li>I like to eat <%= fruit %></li>
      <% end %>
    </ul>

After each change, you can run the generator and then refresh your browser.

If you get errors try re-running the generator and reading the error messages. You can add debugging `puts` statements in your view or the script to help you figure out what is going on

Commit the results to git

## 3) Page Generator with Layout

If you want to add some content to all the pages such as a header containing a global navigation or a footer containing copyright information it would be tedious to add this to each page. Such a task would not be very DRY (don't repeat yourself) since modifying one file would mean you need to mondify many.

Instead we could have a header erb file and a footer erb file that we could join with the contents in our 'views` directory. This would make modifications simple.

Even better we can use a layout file. Here we've provided one in `layouts` with the name `application.html.erb` since it is the main layout for this application. This file provides an easy way to modify the content before or after the page content, and is very easy to edit since it is all in one place.

We are using the concept of yielding to a block with ruby to insert our page contents into the middle of the layout file. If you look in the application file you will see `<%= yield %>` this is where the content for your pages goes. Blocks will be covered later, or you can look up some examples and see the code in `block_example.rb` if you're interested.


In the terminal you can run:

    $ ruby page_generator_with_layout.rb

This should take the contents of the files you modified in section #2 and output them again to the `public` directory, only now they have a layout.


Homework:

Modify the default layout. Add links to some websites in the header & footer. A link in html looks like this

    <a href="http://google.com">This is a link to google</a>

Re-run the `page_generator_with_layout.rb` file and then refresh your page. You should now see links and be able to click on them.

Now that you've got some working links, lets define a ruby method to help us make links in the future. Open up your template and declare a function at the top of the file.


      <%
        def link_to(name, url)
            return "<a href='#{url}'>#{name}</a>"
         end
        %>

This function is named `link_to` and takes in a two parameters, the first is the name of the link and the last is the url you want to go to. You can replace the link to google above using `link_to` like this.


      <%= link_to('This is a link to google', 'http://google.com') %>

Add some links to your template using the link_to function you added to the template

If you get errors try re-running the generator and reading the error messages. You can add debugging `puts` statements in your view or the script to help you figure out what is going on.

Commit the results to git

## 4) Simple server

If we wanted to let other people see our web pages we would have to provide a way to get our html to their browser.
Since other computers will not have access to your file system we must make our content available, the easiest way to do this is to use a web server and provide content via a port. If that sounds hard don't worry, it isn't.  Ruby standard library comes with a  server called webrick. We can use this server to serve our html without providing direct access to our file system.

In the terminal you can run:

    $ ruby server_simple.rb

You should see an output that looks something like this:

    [2012-06-15 16:05:28] INFO  WEBrick 1.3.1
    [2012-06-15 16:05:28] INFO  ruby 1.9.3 (2012-04-20) [x86_64-darwin11.4.0]
    [2012-06-15 16:05:28] INFO  WEBrick::HTTPServer#start: pid=85507 port=8000

That means our server has started and is listening on port 8000. You can open up a new browser tab and go to [http://localhost:8000/index](http://localhost:8000/index) and you will see the contents of `public/html/index.html.erb` rendered in your browser. Open `server_simple.rb` in a text editor and take a look at the contents.


Homework:

1)
Try modifying a file in your `views` directory and then restart your server and see if you saw any changes? If not, ask why. Try running the generator script again

    $ ruby page_generator_with_layout.rb

 Then restarting the server and refreshing your web page. Do you see your changes? Why were some of these steps necessary, were all of them needed?

2)
Rather than reading static files you can output any content you generate in ruby. Add this to `server_simple.rb` before the `server.start` line


    server.mount_proc '/' do |req, res|
      res.body = 'Hello, world!'
    end

If you restart your server and go to [http://localhost:8000](http://localhost:8000) you should see the contents `Hello, World!`.

Commit the results to git


## 5) Advanced Server

We started off reading in erb to generate static html, then we served static html using a server. In your homework you saw how we could serve content directly from ruby without need to write to a static html file. The next logical step would be to wire up the server to read in the erb template, parse it, and render the html dynamically without having to write to disk.

In the terminal you can run:

    $ ruby server_advanced.rb

This script looks in your `views` directory and reads in all the names of files you've go, it then maps those names to urls you can reach by going to [http://localhost:8000/your_file_name_here](http://localhost:8000/your_file_name_here) such as [http://localhost:8000/index](http://localhost:8000/index). Once the server is running you can add some dynamic content such as

    <%= Time.now %>

This will display the current time. If you refresh your page your time should change.


# Done

Congrats, we've built and modified a very simple web server that delivers dynamic content. With a few simple modifications we could push this to a PaaS such as Heroku to server our dynamic site. The important take aways from this exercise are manipulating view files. Don't forget to push your changes back to your fork.