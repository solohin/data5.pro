---
layout: post
title: "How to create folder in Google Drive from Google Spreadsheets"
categories: [Google apps script]
tags: []
---
Just use this class to create folder in Google Drive. It will create one if child folder with the same name is not exists. 

Example use in function `testRun()`. You can paste it into your Google Spreadsheet scripts.

    var settings = {
        rootFolderId: '0B6nU2EHhqW32EHhqW30zZ2xtYzA',
    };
    
    function testRun() {
        Logger.log(DriveManager.createFolderIfNotExists(settings.rootFolderId, 'Temp name 1'));
        Logger.log(DriveManager.createFolderIfNotExists(settings.rootFolderId, 'Temp name 2'));
        Logger.log(DriveManager.createFolderIfNotExists(settings.rootFolderId, 'Temp name 1'));
    }
    
    /*
     * Class for working with Google Drive folder
     * (c) Solokhin Ilia
     * solohin.i@gmail.com
     * http://data5.pro
     * https://www.upwork.com/freelancers/~0110e79b44736be7ab
     */
    var DriveManager = function () {
        var module = {
            createFolderIfNotExists: function (parentIdOrFolder, newFolderName) {
                return module.createFolder(parentIdOrFolder, newFolderName, true);
            },
            createFolder: function (parentIdOrFolder, newFolderName, onlyIfNotExists) {
                if (onlyIfNotExists === undefined) {
                    onlyIfNotExists = true;
                }
    
                var parent = module.getFolder(parentIdOrFolder);
                if (onlyIfNotExists && module.isFolderExists(settings.rootFolderId, newFolderName)) {
                    Logger.log('Folder %s exists!', newFolderName);
                    return false;
                }
    
                var newFolder = DriveApp.createFolder(newFolderName);
                parent.addFolder(newFolder);
    
                return newFolder;
            },
            isFolderExists: function (parentIdOrFolder, searchFolderName) {
                var parent = module.getFolder(parentIdOrFolder);
                var children = parent.getFoldersByName(searchFolderName);
                return children.hasNext();
            },
            getFolder: function (parentIdOrFolder, throwException) {
                if (throwException === undefined) {
                    throwException = true;
                }
    
                //In case if we have ID instead of Folder object
                if (typeof parentIdOrFolder == 'string') {
                    parentIdOrFolder = DriveApp.getFolderById(parentIdOrFolder);
                }
                //Check if it is Folder
                if (!parentIdOrFolder || typeof parentIdOrFolder.getFiles != 'function' && throwException) {
                    throw ("Wrong parent folder ID or not a folder object " + parentIdOrFolder);
                }
                return parentIdOrFolder;
            }
        };
    
        return {
            createFolderIfNotExists: module.createFolderIfNotExists,
            isFolderExists: module.isFolderExists,
        };
    }();