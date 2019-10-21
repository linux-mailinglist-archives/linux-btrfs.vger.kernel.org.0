Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63059DE8EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfJUKBv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57834 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfJUKBu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xLv6006778
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=ZHygtREUk4/GIgcZILegr9Ixro3z37cZ9aLFoHcd3cE=;
 b=KoUZoXVabuN8/uGVh4lm1DI6CvPCc37+E9NXbOjinmJXwxuwQzhbXpiuT2mekjn4/2VZ
 R0cFpD7NEMdG8iPsKGHRIoUuRv9O9vc7JJrJoNV8bp2WYu6hJZh4au7o2/nqQp0IBZ/E
 uBjgCDnIljyjaJorUNUUpUxGphTjfMWQLaUgmCt7NYOVHNzZw51QjDoetVcBxokcym/i
 2+VvLC/5DZddweDhRwXyrresKPI7/ApEfylfNE8FnXDjBrsWjjcIgF/l0cj6lgbmcAl6
 gRRlhAe+WW+W2je250RTmc4jc6pijP6w3sLjWr95OBglcW0Ud1UgeGRdN/45ajfALX/b yQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vqtepekf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9wLv7088735
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vrbyycuyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:49 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LA1mLG023929
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:48 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:48 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 10/14] btrfs-progs: migrate restore to global verbose
Date:   Mon, 21 Oct 2019 18:01:18 +0800
Message-Id: <1571652082-25982-11-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
References: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210096
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Command btrfs restore provides local verbose option, this patch makes it
enable-able by using the global --verbose option as well.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/restore.c | 69 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/cmds/restore.c b/cmds/restore.c
index 79caf6734e76..3592faeb6bca 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -51,7 +51,7 @@ static char fs_name[PATH_MAX];
 static char path_name[PATH_MAX];
 static char symlink_target[PATH_MAX];
 static int get_snaps = 0;
-static int verbose = 0;
+extern bool global_verbose;
 static int restore_metadata = 0;
 static int restore_symlinks = 0;
 static int ignore_errors = 0;
@@ -375,8 +375,7 @@ static int copy_one_extent(struct btrfs_root *root, int fd,
 	if (compress == BTRFS_COMPRESS_NONE)
 		bytenr += offset;
 
-	if (verbose && offset)
-		printf("offset is %Lu\n", offset);
+	pr_verbose(global_verbose && offset, "offset is %Lu\n", offset);
 	/* we found a hole */
 	if (disk_size == 0)
 		return 0;
@@ -832,9 +831,8 @@ static int overwrite_ok(const char * path)
 		if (overwrite)
 			return 2;
 
-		if (verbose || !warn)
-			printf("Skipping existing file"
-				   " %s\n", path);
+		pr_verbose(global_verbose || !warn,
+			   "Skipping existing file %s\n", path);
 		if (!warn)
 			printf("If you wish to overwrite use -o\n");
 		warn = 1;
@@ -994,9 +992,8 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 			goto out;
 		} else if (ret > 0) {
 			/* No more leaves to search */
-			if (verbose)
-				printf("Reached the end of the tree looking "
-				       "for the directory\n");
+			pr_verbose(global_verbose,
+		   "Reached the end of the tree looking for the directory\n");
 			ret = 0;
 			goto out;
 		}
@@ -1020,10 +1017,8 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 					goto out;
 				} else if (ret > 0) {
 					/* No more leaves to search */
-					if (verbose)
-						printf("Reached the end of "
-						       "the tree searching the"
-						       " directory\n");
+					pr_verbose(global_verbose,
+		"Reached the end of the tree searching the directory\n");
 					ret = 0;
 					goto out;
 				}
@@ -1063,8 +1058,7 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 			if (!overwrite_ok(path_name))
 				goto next;
 
-			if (verbose)
-				printf("Restoring %s\n", path_name);
+			pr_verbose(global_verbose, "Restoring %s\n", path_name);
 			if (dry_run)
 				goto next;
 			fd = open(path_name, O_CREAT|O_WRONLY, 0644);
@@ -1136,8 +1130,7 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 				location.objectid = BTRFS_FIRST_FREE_OBJECTID;
 			}
 
-			if (verbose)
-				printf("Restoring %s\n", path_name);
+			pr_verbose(global_verbose, "Restoring %s\n", path_name);
 
 			errno = 0;
 			if (dry_run)
@@ -1200,8 +1193,7 @@ next:
 		}
 	}
 
-	if (verbose)
-		printf("Done searching %s\n", in_dir);
+	pr_verbose(global_verbose, "Done searching %s\n", in_dir);
 out:
 	btrfs_release_path(&path);
 	return ret;
@@ -1392,25 +1384,26 @@ static const char * const cmd_restore_usage[] = {
 	"btrfs restore [options] <device> <path> | -l <device>",
 	"Try to restore files from a damaged filesystem (unmounted)",
 	"",
-	"-s|--snapshots       get snapshots",
-	"-x|--xattr           restore extended attributes",
-	"-m|--metadata        restore owner, mode and times",
-	"-S|--symlink         restore symbolic links",
-	"-v|--verbose         verbose",
-	"-i|--ignore-errors   ignore errors",
-	"-o|--overwrite       overwrite",
-	"-t <bytenr>          tree location",
-	"-f <bytenr>          filesystem location",
-	"-u|--super <mirror>  super mirror",
-	"-r|--root <rootid>   root objectid",
-	"-d                   find dir",
-	"-l|--list-roots      list tree roots",
-	"-D|--dry-run         dry run (only list files that would be recovered)",
+	"-s|--snapshots     get snapshots",
+	"-x|--xattr         restore extended attributes",
+	"-m|--metadata      restore owner, mode and times",
+	"-S|--symlink       restore symbolic links",
+	HELPINFO_INSERT_VERBOSE,
+	"-i|--ignore-errors ignore errors",
+	"-o|--overwrite     overwrite",
+	"-t <bytenr>        tree location",
+	"-f <bytenr>        filesystem location",
+	"-u|--super <mirror>",
+	"                   super mirror",
+	"-r|--root <rootid> root objectid",
+	"-d                 find dir",
+	"-l|--list-roots    list tree roots",
+	"-D|--dry-run       dry run (only list files that would be recovered)",
 	"--path-regex <regex>",
-	"                     restore only filenames matching regex,",
-	"                     you have to use following syntax (possibly quoted):",
-	"                     ^/(|home(|/username(|/Desktop(|/.*))))$",
-	"-c                   ignore case (--path-regex only)",
+	"                   restore only filenames matching regex,",
+	"                   you have to use following syntax (possibly quoted):",
+	"                   ^/(|home(|/username(|/Desktop(|/.*))))$",
+	"-c                 ignore case (--path-regex only)",
 	NULL
 };
 
@@ -1463,7 +1456,7 @@ static int cmd_restore(const struct cmd_struct *cmd, int argc, char **argv)
 				get_snaps = 1;
 				break;
 			case 'v':
-				verbose++;
+				global_verbose = true;
 				break;
 			case 'i':
 				ignore_errors = 1;
-- 
1.8.3.1

