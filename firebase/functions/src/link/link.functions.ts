

import * as functions from "firebase-functions";
import * as express from "express";
import { initializeApp } from "firebase/app";
import { getFirestore, doc, getDoc, DocumentSnapshot } from "firebase/firestore";
import { AndroidCredential, AppleCredential, HtmlDeepLink } from "./link.interface";

// Initialize Express app
const app = express();
// Set up Firebase Cloud Function
export const link = functions.https.onRequest(app);


/**
 * Returns the Document Snapshot
 * @param docId
 */
async function getDeeplinkDoc( docId: string ): Promise<DocumentSnapshot> {
    const firebaseApp = initializeApp(firebaseConfig);
    const db = getFirestore(firebaseApp);
    // const db = getFirestore();
    const docRef = doc(db, "_deeplink_", docId);
    const docSnap = await getDoc(docRef);
    return docSnap;
}

app.get("/.well-known/apple-app-site-association", async (req, res) => {
    const docSnaphot = await getDeeplinkDoc("apple");
    res.writeHead(200, { "Content-Type": "application/json" });
    if (docSnaphot.exists()) {
        const snapshotData: AppleCredential = docSnaphot.data() as AppleCredential;
        const applinkDetails = snapshotData.apps.map((teamIDAndAppIBundled) => ({
            appID: teamIDAndAppIBundled,
            paths: ["*"],
        }));
        const webCredentials = snapshotData.apps.map((teamIDAndAppIBundled) => (
            teamIDAndAppIBundled
        ));
        const appsSiteAssociation = {
            applinks: {
                details: applinkDetails,
            },
            webCredentials: {
                apps: webCredentials,
            },
        };
        res.write(JSON.stringify(appsSiteAssociation));
    } else {
        // docSnap.data() will be undefined in this case
        res.write("Page not found!");
    }
    res.end();
});

app.get("/.well-known/assetlinks.json", async (req, res) => {
    const docSnaphot = await getDeeplinkDoc("android");
    res.writeHead(200, { "Content-Type": "application/json" });
    if (docSnaphot.exists()) {
        const snapshotData: AndroidCredential = docSnaphot.data();
        const jsonCredentials = Object.entries(snapshotData).map(([appName, sha256s]) => ({
            relation: ["delegate_permission/common.handle_all_urls"],
            target: {
                namespace: "android_app",
                package_name: appName,
                sha256_cert_fingerprints: sha256s,
            },
        }));
        res.write(JSON.stringify(jsonCredentials));
    } else {
        // docSnap.data() will be undefined in this case
        res.write("Page not found!");
    }
    res.end();
});

const defaultHtml = `<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta
      name="apple-itunes-app"
      content="app-id=myAppID, affiliate-data=myAffiliateData, app-argument=myURL"
    />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="white" />
    <meta name="apple-mobile-web-app-title" content="Silvers" />

    <link rel="icon" type="image/png" href="..." />
    <link rel="mask-icon" href="" color="#ffffff" />
    <meta name="application-name" content="Silvers" />

    <title>Silvers</title>
    <meta name="description" content="Find out more about my app..." />

    <meta property="og:title" content="“Silvers”" />
    <meta property="og:description" content="Find out more about my app..." />
    <meta property="og:image" content="https://.../your-app-banner.jpg" />
    <meta property="og:type" content="website" />
    <meta property="og:locale" content="en_US" />

    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:title" content="Silvers" />
    <meta name="twitter:site" content="myawesomeapp.com" />
    <meta name="twitter:description" content="Find out more about my app..." />
    <meta name="twitter:image" content="https://.../your-app-banner.jpg" />
    <link rel="apple-touch-icon" href="..." />
  </head>
  <body>
    Redirecting...
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/Detect.js/2.2.2/detect.min.js"
      rossorigin="anonymous"
      referrerpolicy="no-referrer"
    ></script>
    <script>
      var result = detect.parse(navigator.userAgent);
      const stateTimer = setTimeout(function () {
        if (result.os.family === "iOS") {
          window.location.replace("#{{appStoreUrl}}");
        } else if (result.os.family.includes("Android")) {
          window.location.replace(
            "#{{playStoreUrl}}"
          );
        } else {
        }
      }, 2000);
      window.addEventListener("visibiltychange", function () {
        clearTimeout(stateTimer);
        stateTimer = null;
        window.open("", "_self").close();
      });
      location.href = "#{{deepLinkUrl}}";
    </script>
  </body>
</html>`;

app.get("*", async (req, res) => {
    const docSnaphot = await getDeeplinkDoc("html");
    if (docSnaphot.exists()) {
        const htmlSnapshot = docSnaphot.data() as HtmlDeepLink;

       let htmlSource = defaultHtml;

        // Return the webpage
        return res.send(source);
    }
    // Return the webpage
    return res.send("Page not found!");
});
