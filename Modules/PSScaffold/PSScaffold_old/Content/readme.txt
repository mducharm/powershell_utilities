# README



## Directory Map

Public
- Used for any functions that you want your end user to access.  

Private
- Used for any functions within your project that you don't want to be exported. 

Tests
- Used for testing any functions in the Public and Private directories.

.psm1
- Main module file, imports all functions from Public and Private and only exports Public functions.

.psd1
- Configuration file, contains project details and allows you to specify which functions to export. 
