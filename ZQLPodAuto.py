#coding:utf-8
import os, sys
import fileinput


# ======================  edit by yourself  ======================
#sources = [
#           'https://github.com/YinTokey/Egen.git',
#          ]

project_name = 'ZQLTest'
podspec_file_name = 'ZQLTest.podspec'


# ==================================================================

new_tag = ""
spec_file_path = "./" + podspec_file_name
find_version_flag = False

def gitOperation():

    #pod lib lint --allow-warnings --use-libraries
    os.system('pod lib lint --allow-warnings')
    
    os.system('git add .')
    
    commit_desc = "版本:" + new_tag
    commit_command = 'git commit -m "' + commit_desc + '"'
   
    os.system(commit_command)
    
    os.system('git push')

    tag_command = 'git tag "' + new_tag + '"'
    os.system(tag_command)
    
    os.system('git push --tags')

    os.system('pod trunk push *.podspec --allow-warnings')

def updateVersion():
    f = open(spec_file_path, 'r+')
    infos = f.readlines()
    f.seek(0, 0)
    file_data = ""
    new_line = ""
    global find_version_flag

    for line in infos:
        if line.find(".version") != -1:
            if find_version_flag == False:
                # find s.version = "xxxx"

                spArr = line.split('.')
                last = spArr[-1]
                last = last.replace('"', '')
                last = last.replace("'", "")
                newNum = int(last) + 1

                arr2 = line.split('"')
                arr3 = line.split("'")

                versionStr = ""
                if len(arr2) > 2:
                    versionStr = arr2[1]

                if len(arr3) > 2:
                    versionStr = arr3[1]
                numArr = versionStr.split(".")

                numArr[-1] = str(newNum)
                # rejoint string
                global new_tag
                for index,subNumStr in enumerate(numArr):
                    new_tag += subNumStr
                    if index < len(numArr)-1:
                        new_tag += "."

                # complete new_tag

                if len(arr2) > 2:
                    line = arr2[0] + '"' + new_tag + '"' + '\n'

                if len(arr3) > 2:
                    line = arr3[0] + "'" + new_tag + "'" + "\n"

                # complete new_line

                print "this is new tag  " + new_tag
                find_version_flag = True

        file_data += line


    with open(spec_file_path, 'w', ) as f1:
        f1.write(file_data)

    f.close()
	
    print "--------- auto update version:" + new_tag + "-------- "


updateVersion()    
gitOperation()
