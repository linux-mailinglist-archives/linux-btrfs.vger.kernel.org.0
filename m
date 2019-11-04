Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9A8ED911
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfKDGen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41660 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfKDGem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YZFW003930
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=M4JkRyUtpBYTyskCMyRgwyciKvgvC8LijRprb37rIOk=;
 b=owNw0yHVJ/UiBI3JZ+j6Hi9Ysx/EpH2/jQVlH9TITXuCUef7StfLgeIy9pfB2XShrgwe
 9sulYneu9stPkOzfX71fzr+hdfJZFxOWOByyghxn2m4EalIBFt0X8RDx7Fz+tPj8DXi1
 88tsqNsIbmMmBMO+MLjLalTdsQFME1FQjiU0RRWLQhy/WKPwDZtAyq8BC8Gir7LTL/sE
 Loo4eGiAY5Nr3fWIkbOJDXgE54ZVRxOj2s6tDlFGuQJeQRPfHTlTeJGb19WUgkz08IuL
 TnqPS68xo6vKDlFb4xc8fFROsRC3pLMuoYkTVjykyFWuk8bQrg57hkoEmYOM3J/dnRK3 Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2w117tn76k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46Ydab131281
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2w1kxcnf8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:38 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA46XkR4004186
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:46 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:46 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1.1 13/18] btrfs-progs: restore: use global verbose option
Date:   Mon,  4 Nov 2019 14:33:11 +0800
Message-Id: <1572849196-21775-14-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040063
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs restore sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1.1: use pr_verbose(-1,..) instead of all conditions printf();

 cmds/restore.c | 57 +++++++++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index c104b01aef69..5afa1c7c40ff 100644
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
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -1441,6 +1434,10 @@ static int cmd_restore(const struct cmd_struct *cmd, int argc, char **argv)
 	regex_t match_reg, *mreg = NULL;
 	char reg_err[256];
 
+	/* Init global verbose if unset */
+	if (bconf.verbose < 0)
+		bconf.verbose = 0;
+
 	optind = 0;
 	while (1) {
 		int opt;
@@ -1472,7 +1469,7 @@ static int cmd_restore(const struct cmd_struct *cmd, int argc, char **argv)
 				get_snaps = 1;
 				break;
 			case 'v':
-				verbose++;
+				bconf.verbose++;
 				break;
 			case 'i':
 				ignore_errors = 1;
-- 
1.8.3.1

