import * as functions from "firebase-functions";
import * as admin from "firebase-admin";


// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();


// snaptions means basically just created value
export const onVideoCreated = functions.firestore
    .document("videos/{videoId}")
    .onCreate(async (snapshot, context) => {
        const spawn = require('child-process-promise').spawn;
        const video = snapshot.data();
        await spawn("ffmpeg", [
            "-i",
            video.fileUrl,
            "-ss",
            "00:00:01",
            "-vframes",
            "1",
            "-vf",
            //150:width
            //-1:video aspect ratio
            "scale=150:-1",
            // store at temporarily folder in google cloud server
            `/tmp/${snapshot.id}.jpg`,

        ]);
        const storage = admin.storage();
        // pathString should be same with spawn
        // store at storage - thumbnails
        // the file at the [tmp] directory store at the [thumbnails] directory
        const [file, _] = await storage.bucket().upload(`/tmp/${snapshot.id}.jpg`, {
            destination: `thumbnails/${snapshot.id}.jpg`,
        });

        // make the file public
        await file.makePublic();
        // update firestore - videos/:videoId
        await snapshot.ref.update({
            thumbnailUrl: file.publicUrl()
        });
        const db = admin.firestore();
        // bottom query take a long time
        // db.collection("videos").where("creatorUid", "==", 123);
        // create firestore - users/:userId/videos/:videoId
        db.collection("users")
            .doc(video.creatorUid)
            .collection("videos")
            .doc(snapshot.id)
            .set({
                thumbnailUrl: file.publicUrl(),
                videoId: snapshot.id,
            });
    });


export const onLikedCreated = functions.firestore
    .document("likes/{likeId}")
    .onCreate(async (snapshot, context) => {
        const db = admin.firestore();
        const [videoId, userId] = snapshot.id.split("000");
        await db
            .collection("videos")
            .doc(videoId)
            .update({
                likes: admin.firestore.FieldValue.increment(1),
            });


        const videoRef = await db
            .collection("videos")
            .doc(videoId)
            .get();

        const videoData = videoRef.data();
        if (videoData) {
            await db.
                collection("users")
                .doc(userId)
                .collection('likes')
                .doc(videoId)
                .set({
                    videoId: videoId,
                    thumbnailUrl: videoData.thumbnailUrl,
                })
        }

    });


export const onLikedRemoved = functions.firestore
    .document("likes/{likeId}")
    .onDelete(async (snapshot, context) => {
        const db = admin.firestore();
        const [videoId, userId] = snapshot.id.split("000");
        await db
            .collection("videos")
            .doc(videoId)
            .update({
                likes: admin.firestore.FieldValue.increment(-1),
            });


        const videoRef = await db
            .collection("videos")
            .doc(videoId)
            .get();

        const videoData = videoRef.data();
        if (videoData) {
            await db.
                collection("users")
                .doc(userId)
                .collection('likes')
                .doc(videoId)
                .delete();
        }
    });