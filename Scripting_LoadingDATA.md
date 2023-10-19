# Scripting in R
#### Running scripts
 ```
  source("filename.r")
```
#### Save Command
```
  sink("output.Rout")
  sink() restores output to console
  # can be used with or outside of a script
```
#### R Commands 
```
  ls(): List all stored variables 
  rm(): Delete one or more variables
  class(): Describe what type of data a varibale stores
  save(x, file="filename"): Store variable(s) to a binary file
  load("filename"): Load all variables from a binary file.
```

#### Loading data
  ```
  #Load data from a file or website 
    df = read.table("file_name")
  #Load data from R database
    df = data()
  #Load data from ggplot2
    library(ggplot2)
  #Use table() to obtain frequency of values in col
    table(mpg$'column_name')
    table(mpg['column_name'])
  ```
