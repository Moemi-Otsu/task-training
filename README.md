# README

##  Table Users
* id　:integer
* user_name　:string
* email　:string
* password　:string

##  Table Tasks
* id　:integer
* user_id(FK)　:integer
* task_title :string
* task_content　:text
* deadline　:datetime
* priority　:string

##  Table Labels
* id　:integer
* task_id(FK)　:integer
* label_name :string

## Table Admin ???