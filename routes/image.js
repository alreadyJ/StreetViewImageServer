var express = require('express');
var router = express.Router();
var fs = require('fs');
var request = require('sync-request');
var progress = require('request-progress');
var async = require('async');
var imagemagick = require('imagemagick-native');
var exec = require('child_process').exec;

router.get('/panoid/:position', function(req, res) {
    var t = function (uri, path, onProgress, onResponse, onError, onEnd) {
        progress(request(uri))
            .on('progress', onProgress)
            .on('response', onResponse)
            .on('error', onError)
            .on('end', onEnd)
            .pipe(fs.createWriteStream(path))
    };
    var currentPosition = req.params.position;
    var currentPath = process.cwd();
    var resizedImage = [];
    console.log(currentPosition);
    var tasks = [
        function(callback) {
            var resData;
            for (var i = 0; i < 7; i++) {
                for (var j = 0; j < 4; j++) {//9tUQTW_5wmsK6e5Z4DewPw
                    var url = 'http://cbk0.google.com/cbk?output=tile&panoid=' + currentPosition + '&zoom=3&x='+ i +'&y=' + j;
                    if (!fs.existsSync(currentPath + "/public/images/rawImages/" + currentPosition + i + j +".jpg")) {
                        resData = request('GET', url);
                        fs.writeFileSync(currentPath + "/public/images/rawImages/" + currentPosition + i + j + ".jpg", imagemagick.convert({
                            srcData: resData.body,
                            width: 256,
                            height: 256,
                            resizeStyle: 'fill',
                            gravity: 'Center'
                        }));
                    }else {
                        if (!fs.statSync(currentPath + "/public/images/rawImages/" + currentPosition + i + j + ".jpg")["size"]){
                            resData = request('GET', url);
                            fs.writeFileSync(currentPath + "/public/images/rawImages/" + currentPosition + i + j + ".jpg", imagemagick.convert({
                                srcData: resData.body,
                                width: 256,
                                height: 256,
                                resizeStyle: 'fill',
                                gravity: 'Center'
                            }));
                        }
                    }
                }
            }
            callback(null);
        },
        function(callback) {
            exec(currentPath + '/public/images/rawImages/imageAppend.sh ' + currentPosition, function(err, stdout, stderr) {
                if (err) console.log(err);
                callback(null);
            });
        },
        function(callback) {
            console.log("size: ", fs.statSync(currentPath + "/public/images/completeImage/" + currentPosition + ".jpg")["size"]);
            while(!fs.statSync(currentPath + "/public/images/completeImage/" + currentPosition + ".jpg")["size"]){
                console.log(fs.statSync(currentPath + "/public/images/completeImage/" + currentPosition + ".jpg")["size"]);
            }
            callback(null);
        }
    ];
    if (fs.existsSync(currentPath + "/public/images/completeImage/" + currentPosition + ".jpg")) {
        var img;
        img = (fs.existsSync(currentPath + "/public/images/completeImage/" + currentPosition + ".jpg")) ?
            fs.readFileSync(currentPath + "/public/images/completeImage/" + currentPosition + ".jpg") : null;
        res.writeHead(200, {'Content-Type': 'image/jpeg'});
        res.end(img,'binary');
    }else {
        async.series(tasks, function (err, results){
            var img;
            img = (fs.existsSync(currentPath + "/public/images/completeImage/" + currentPosition + ".jpg")) ?
                fs.readFileSync(currentPath + "/public/images/completeImage/" + currentPosition + ".jpg") : null;
            res.writeHead(200, {'Content-Type': 'image/jpeg'});
            res.end(img,'binary');
        });
    }

});


module.exports = router;
