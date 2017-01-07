#!/bin/sh

git add files/*
git commit -m "$(date)"
git push origin master

