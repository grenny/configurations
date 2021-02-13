#!/bin/bash
[ $# -eq 0 ] && host=dev104.athenahealth.com;
[ $# -eq 1 ] && host="dev$1.athenahealth.com";

mosh $host
