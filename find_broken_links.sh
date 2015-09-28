#!/bin/bash

# http://unix.stackexchange.com/questions/34248/how-can-i-find-broken-symlinks

find . -xtype l
