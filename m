Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ADB1F7765
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 13:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFLLjx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 07:39:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55548 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLLjw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 07:39:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBWcQ3128832;
        Fri, 12 Jun 2020 11:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=YyHaOgSpamErUNUNNZStwrq8AG0s3P3axPSrNPPIGqc=;
 b=q58uYuMy/WAVDp/RzqzjLTD3l6XTmyeD5Wss6nXhf64gsXyxyH1axr0WpoCLgy/pDbdm
 Ku3xq+MNTAPjXqh7YfPNWQe3PY0ahrOQbTlqwZazNLqMqWpGL0ix16mCVJhy2t1SXVCT
 CzzowTWEMJ0zEa5ELfsC502lb3CAD1kv8e7NkHpWv1nWHJmOEYcuBtHX6IBZpX782kI2
 A/k2H2wAUeSddH4lMw/dGYAxMcayBhtgqazaC0nQfd7ETzcbinAUIbjCVBgHYPWC1C6C
 H/1m4/uWcuiZ3Bhbcg9105C2Ii03/NlxJWtbkd1RfOamsafTDH5BSOyMdMz7C1xKqkc7 Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 31g2jrmnvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 11:39:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBWbrn084803;
        Fri, 12 Jun 2020 11:37:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 31m8x40dd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 11:37:47 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05CBQPk1003424;
        Fri, 12 Jun 2020 11:26:25 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 04:26:25 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 11/16] btrfs-progs: restore: use global verbose option
Date:   Fri, 12 Jun 2020 19:26:17 +0800
Message-Id: <20200612112617.3906-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-12-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-12-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=3 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=3
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs restore sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: update help and documentation
v2: Use new helper functions and defines
     HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
     bconf_be_verbose(), bconf_be_quiet()

 Documentation/btrfs-restore.asciidoc |  3 +-
 cmds/restore.c                       | 60 +++++++++++++---------------
 2 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/Documentation/btrfs-restore.asciidoc b/Documentation/btrfs-restore.asciidoc
index 090dcc555bc2..9174c2951db3 100644
--- a/Documentation/btrfs-restore.asciidoc
+++ b/Documentation/btrfs-restore.asciidoc
@@ -48,7 +48,8 @@ restore owner, mode and times for files and directories
 restore symbolic links as well as normal files
 
 -v|--verbose::
-be verbose and print what is being restored
+be verbose and print what is being restored. This option is merged to the
+global verbose option
 
 -i|--ignore-errors::
 ignore errors during restoration and continue
diff --git a/cmds/restore.c b/cmds/restore.c
index 08f5b7e73183..e587ee33beab 100644
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
@@ -1395,7 +1387,7 @@ static const char * const cmd_restore_usage[] = {
 	"-x|--xattr           restore extended attributes",
 	"-m|--metadata        restore owner, mode and times",
 	"-S|--symlink         restore symbolic links",
-	"-v|--verbose         verbose",
+	"-v|--verbose         verbose. This option is merged to the global verbose option",
 	"-i|--ignore-errors   ignore errors",
 	"-o|--overwrite       overwrite",
 	"-t <bytenr>          tree location",
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

