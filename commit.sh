#!/bin/sh

git add files/*
git add *

git commit -m "$(date)"
git push origin master

