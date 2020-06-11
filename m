Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C581F6C4B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgFKQl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Jun 2020 12:41:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38964 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgFKQl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Jun 2020 12:41:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BGWNAM067442;
        Thu, 11 Jun 2020 16:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=EOFz/P87SKJC2YUeFm529rjY8EeQa3U8sClynGsIvi4=;
 b=UckwNhRKE9XQDuULd1gq2o+uUzOGcEDBb081xx6Bnv3Xg73+ctli5Dq+Idp2pI8HhsyF
 4/5XJBNspl7QkkWbOEpg7EottxYwR1O9Ti81dnI0rF0A+TcB3dHxc/k7OrGZSv5GnRFz
 PWUxnjMkZ27d8rQEhzUnAB8SBv4YSahKbDPQbJpcESd9YXNaIpnG73HAGZyq00CnkAt9
 UNEldzvWncbys5VdYZ0oVABcXqnC1eiTQ/tvA0RV9jMcyJdDiMzSWFBOlq6FbZ+e1gFv
 UTxO2aXQtSRAI2L+YalxHYc8WhqgLb3jWdw40X4orLu7kNr3DsJaVURWsRkCPsqPWvk3 rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31g2jrgy53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 16:41:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05BGboKK177679;
        Thu, 11 Jun 2020 16:39:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31gn323958-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 16:39:54 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05BGdrV1023554;
        Thu, 11 Jun 2020 16:39:53 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jun 2020 09:39:47 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 11/16] btrfs-progs: restore: use global verbose option
Date:   Fri, 12 Jun 2020 00:39:00 +0800
Message-Id: <20200611163900.35815-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=3
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006110130
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs restore sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Use MUST_LOG
v2: Use new helper functions and defines
     HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
     bconf_be_verbose(), bconf_be_quiet() 

 cmds/restore.c | 58 ++++++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 32 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 08f5b7e73183..bcd542507971 100644
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
@@ -386,8 +385,7 @@ static int copy_one_extent(struct btrfs_root *root, int fd,
 		size_left -= offset;
 	}
 
-	if (verbose && offset)
-		printf("offset is %Lu\n", offset);
+	pr_verbose(offset ? 1 : 0, "offset is %Lu\n", offset);
 
 	inbuf = malloc(size_left);
 	if (!inbuf) {
@@ -820,11 +818,15 @@ static int overwrite_ok(const char * path)
 		if (overwrite)
 			return 2;
 
-		if (verbose || !warn)
-			printf("Skipping existing file"
-				   " %s\n", path);
-		if (!warn)
-			printf("If you wish to overwrite use -o\n");
+		if (!warn) {
+			pr_verbose(MUST_LOG,
+				   "Skipping existing file %s\n", path);
+			pr_verbose(MUST_LOG,
+				   "If you wish to overwrite use -o\n");
+		} else {
+			pr_verbose(1, "Skipping existing file %s\n", path);
+		}
+
 		warn = 1;
 		return 0;
 	}
@@ -899,8 +901,7 @@ static int copy_symlink(struct btrfs_root *root, struct btrfs_key *key,
 		}
 	}
 
-	if (verbose >= 2)
-		printf("SYMLINK: '%s' => '%s'\n", path_name, symlink_target);
+	pr_verbose(2, "SYMLINK: '%s' => '%s'\n", path_name, symlink_target);
 
 	ret = 0;
 	if (!restore_metadata)
@@ -977,9 +978,8 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 
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
@@ -987,9 +987,8 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
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
@@ -1013,10 +1012,8 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
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
@@ -1026,14 +1023,12 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
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
@@ -1062,8 +1057,7 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 			if (!overwrite_ok(path_name))
 				goto next;
 
-			if (verbose)
-				printf("Restoring %s\n", path_name);
+			pr_verbose(1, "Restoring %s\n", path_name);
 			if (dry_run)
 				goto next;
 			fd = open(path_name, O_CREAT|O_WRONLY, 0644);
@@ -1135,8 +1129,7 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 				location.objectid = BTRFS_FIRST_FREE_OBJECTID;
 			}
 
-			if (verbose)
-				printf("Restoring %s\n", path_name);
+			pr_verbose(1, "Restoring %s\n", path_name);
 
 			errno = 0;
 			if (dry_run)
@@ -1199,8 +1192,7 @@ next:
 		}
 	}
 
-	if (verbose)
-		printf("Done searching %s\n", in_dir);
+	pr_verbose(1, "Done searching %s\n", in_dir);
 out:
 	btrfs_release_path(&path);
 	return ret;
@@ -1410,6 +1402,8 @@ static const char * const cmd_restore_usage[] = {
 	"                     you have to use following syntax (possibly quoted):",
 	"                     ^/(|home(|/username(|/Desktop(|/.*))))$",
 	"-c                   ignore case (--path-regex only)",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -1462,7 +1456,7 @@ static int cmd_restore(const struct cmd_struct *cmd, int argc, char **argv)
 				get_snaps = 1;
 				break;
 			case 'v':
-				verbose++;
+				bconf_be_verbose();
 				break;
 			case 'i':
 				ignore_errors = 1;
-- 
2.25.1

