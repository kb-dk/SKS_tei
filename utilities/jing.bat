@echo off
java -Xss1048576 -jar "C:\Ox\Oxygen XML Editor 18"\lib\jing.jar -c http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_allPlus.rnc %*
