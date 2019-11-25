Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E57108BE2
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfKYKjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:49 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50462 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfKYKjt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:49 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY6E5026803
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=X4ap5cTGStv2m+k7aJ4LwXpBKQo0zokT3ipnfze7yZU=;
 b=c8gpubJ4R80Gf4yhJAC6UWDc622t2IQ5YgvgJU6Ulli7B1a6wpxgFbrHI/Elxzuo3uRV
 W1Ac/YpsuuUcIbjPwABUid9MedNawihCs36mxF7o00mX7MyeLqPd1/IHGfuC7kMUyktI
 EjBGq0UQefY7LNACzCzZpjgsAGjJCidV5VRIGfZOrp7ZRdy9e2jxwveQceRrL+uomisL
 FPs/6jOkKn1D02IgzhzK5+nGL2EZtQgoD+CPRPEV3bkxSUZqEJTYPF351aDl5G638WuD
 v3Zo2wAd9KA84UoeWkLx9a9rC4CR/cPChTN8ZgfCBZ2tYaQ1L/B4RuxJAljX7UHBCKUB kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2wev6txrtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY4jt090800
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wfe7yr688-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:47 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAPAdkcr017377
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:46 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:46 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/16] btrfs-progs: restore: use global verbose option
Date:   Mon, 25 Nov 2019 18:39:12 +0800
Message-Id: <1574678357-22222-12-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250098
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs restore sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use new helper functions and defines
     HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
     bconf_be_verbose(), bconf_be_quiet()

 cmds/restore.c | 53 +++++++++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index c104b01aef69..d541046c6579 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -51,7 +51,6 @@ static char fs_name[PATH_MAX];
 static char path_name[PATH_MAX];
 static char symlink_target[PATH_MAX];
 static int get_snaps = 0;
-static int verbose = 0;
 static int restore_metadata = 0;
 static int restore_symlinks = 0;
 static int ignore_errors = 0;
@@ -375,8 +374,7 @@ static int copy_one_extent(struct btrfs_root *root, int fd,
 	if (compress == BTRFS_COMPRESS_NONE)
 		bytenr += offset;
 
-	if (verbose && offset)
-		printf("offset is %Lu\n", offset);
+	pr_verbose(offset ? 1 : 0, "offset is %Lu\n", offset);
 	/* we found a hole */
 	if (disk_size == 0)
 		return 0;
@@ -832,11 +830,13 @@ static int overwrite_ok(const char * path)
 		if (overwrite)
 			return 2;
 
-		if (verbose || !warn)
-			printf("Skipping existing file"
-				   " %s\n", path);
-		if (!warn)
-			printf("If you wish to overwrite use -o\n");
+		if (!warn) {
+			pr_verbose(-1, "Skipping existing file %s\n", path);
+			pr_verbose(-1, "If you wish to overwrite use -o\n");
+		} else {
+			pr_verbose(1, "Skipping existing file %s\n", path);
+		}
+
 		warn = 1;
 		return 0;
 	}
@@ -987,9 +987,8 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 
 	leaf = path.nodes[0];
 	while (!leaf) {
-		if (verbose > 1)
-			printf("No leaf after search, looking for the next "
-			       "leaf\n");
+		pr_verbose(2,
+			   "No leaf after search, looking for the next leaf\n");
 		ret = next_leaf(root, &path);
 		if (ret < 0) {
 			fprintf(stderr, "Error getting next leaf %d\n",
@@ -997,9 +996,8 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 			goto out;
 		} else if (ret > 0) {
 			/* No more leaves to search */
-			if (verbose)
-				printf("Reached the end of the tree looking "
-				       "for the directory\n");
+			pr_verbose(1,
+		   "Reached the end of the tree looking for the directory\n");
 			ret = 0;
 			goto out;
 		}
@@ -1023,10 +1021,8 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 					goto out;
 				} else if (ret > 0) {
 					/* No more leaves to search */
-					if (verbose)
-						printf("Reached the end of "
-						       "the tree searching the"
-						       " directory\n");
+					pr_verbose(1,
+		"Reached the end of the tree searching the directory\n");
 					ret = 0;
 					goto out;
 				}
@@ -1036,14 +1032,12 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 		}
 		btrfs_item_key_to_cpu(leaf, &found_key, path.slots[0]);
 		if (found_key.objectid != key->objectid) {
-			if (verbose > 1)
-				printf("Found objectid=%Lu, key=%Lu\n",
-				       found_key.objectid, key->objectid);
+			pr_verbose(2, "Found objectid=%Lu, key=%Lu\n",
+				   found_key.objectid, key->objectid);
 			break;
 		}
 		if (found_key.type != key->type) {
-			if (verbose > 1)
-				printf("Found type=%u, want=%u\n",
+			pr_verbose(2, "Found type=%u, want=%u\n",
 				       found_key.type, key->type);
 			break;
 		}
@@ -1072,8 +1066,7 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 			if (!overwrite_ok(path_name))
 				goto next;
 
-			if (verbose)
-				printf("Restoring %s\n", path_name);
+			pr_verbose(1, "Restoring %s\n", path_name);
 			if (dry_run)
 				goto next;
 			fd = open(path_name, O_CREAT|O_WRONLY, 0644);
@@ -1145,8 +1138,7 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 				location.objectid = BTRFS_FIRST_FREE_OBJECTID;
 			}
 
-			if (verbose)
-				printf("Restoring %s\n", path_name);
+			pr_verbose(1, "Restoring %s\n", path_name);
 
 			errno = 0;
 			if (dry_run)
@@ -1209,8 +1201,7 @@ next:
 		}
 	}
 
-	if (verbose)
-		printf("Done searching %s\n", in_dir);
+	pr_verbose(1, "Done searching %s\n", in_dir);
 out:
 	btrfs_release_path(&path);
 	return ret;
@@ -1420,6 +1411,8 @@ static const char * const cmd_restore_usage[] = {
 	"                     you have to use following syntax (possibly quoted):",
 	"                     ^/(|home(|/username(|/Desktop(|/.*))))$",
 	"-c                   ignore case (--path-regex only)",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -1472,7 +1465,7 @@ static int cmd_restore(const struct cmd_struct *cmd, int argc, char **argv)
 				get_snaps = 1;
 				break;
 			case 'v':
-				verbose++;
+				bconf_be_verbose();
 				break;
 			case 'i':
 				ignore_errors = 1;
-- 
1.8.3.1

