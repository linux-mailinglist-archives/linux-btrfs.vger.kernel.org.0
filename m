Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE401FDAB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2019 04:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfEPCKw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 May 2019 22:10:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53896 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEPCKw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 May 2019 22:10:52 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4G29JMH121154
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 02:10:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=fiGXz3rQfkmPDLS3jmYkMJYcuOq64XPKTmZhHrMr0z0=;
 b=uQLzqukHTH/WTDF7LyfsvEQ81ozk/y0EvnCaF6Ja+9ieFpOWSpK9lRMy0adn3Kp3EMDP
 SLv32KFzlpEBuue2nBRcF1NvEnkyXfDDPqZgRhKC2Hhnja0SZqwWy643YLy8vIDXDK6e
 rttWBLfVM4iuV/LdS6Gmbhogn3eCHJO7mJAuOEc8jUvLHVkzz16vYLL8CPYQ5Jhrm5KT
 W+fKCPUm0fJHfWKiH6Jjbv5fu4ru9FeWXXSfH+0IKwfixTIZNqw2XCL/euzeumvpllUh
 lZocTqWPJubE4LFJfBh4kIL3WJEiFzelELvZA2Dk9RdoiNkZapRyLCqdewmTs/RF0t9J Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2sdntu0cqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 02:10:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4G29R13072286
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 02:10:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2sggetdefy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 02:10:49 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4G2AmZ8006888
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 02:10:48 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 May 2019 19:10:47 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6] btrfs-progs: dump-tree: add noscan option
Date:   Thu, 16 May 2019 10:10:44 +0800
Message-Id: <20190516021044.1177-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9258 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905160013
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9258 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905160014
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Anand Jain <Anand.Jain@oracle.com>

The cli 'btrfs inspect dump-tree <dev>' will scan for the partner devices
if any by default.

So as of now you can not inspect each mirrored device independently.

This patch adds noscan option, which when used won't scan the system for
the partner devices, instead it just uses the devices provided in the
argument.

For example:
  btrfs inspect dump-tree --noscan <dev> [<dev>..]

This helps to debug degraded raid1 and raid10.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v5->v6: rebase on latest btrfs-progs::devel
v4->v5: nit: use %m to print error string.
	changelog update.
v3->v4: change the patch title.
	collapse scan_args() to its only parent cmd_inspect_dump_tree()
	(it was bit confusing).
	update the change log.
	update usage.
	update man page.
v2->v3: make it scalable for more than two disks in noscan mode
v1->v2: rename --degraded to --noscan

 Documentation/btrfs-inspect-internal.asciidoc |  5 +-
 cmds-inspect-dump-tree.c                      | 53 ++++++++++++++-----
 2 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/Documentation/btrfs-inspect-internal.asciidoc b/Documentation/btrfs-inspect-internal.asciidoc
index 210f18c30a40..c9962ab3b548 100644
--- a/Documentation/btrfs-inspect-internal.asciidoc
+++ b/Documentation/btrfs-inspect-internal.asciidoc
@@ -61,7 +61,7 @@ specify which mirror to print, valid values are 0, 1 and 2 and the superblock
 must be present on the device with a valid signature, can be used together with
 '--force'
 
-*dump-tree* [options] <device>::
+*dump-tree* [options] <device> [device...]::
 (replaces the standalone tool *btrfs-debug-tree*)
 +
 Dump tree structures from a given device in textual form, expand keys to human
@@ -95,6 +95,9 @@ intermixed in the output
 --bfs::::
 use breadth-first search to print trees. the nodes are printed before all
 leaves
+--device::::
+do not scan the system for other partner device(s), only use the device(s)
+provided in the argument
 -t <tree_id>::::
 print only the tree with the specified ID, where the ID can be numerical or
 common name in a flexible human readable form
diff --git a/cmds-inspect-dump-tree.c b/cmds-inspect-dump-tree.c
index b41d2e111955..af5a6611285d 100644
--- a/cmds-inspect-dump-tree.c
+++ b/cmds-inspect-dump-tree.c
@@ -21,6 +21,7 @@
 #include <unistd.h>
 #include <uuid/uuid.h>
 #include <getopt.h>
+#include <fcntl.h>
 
 #include "kerncompat.h"
 #include "radix-tree.h"
@@ -185,7 +186,7 @@ static u64 treeid_from_string(const char *str, const char **end)
 }
 
 const char * const cmd_inspect_dump_tree_usage[] = {
-	"btrfs inspect-internal dump-tree [options] device",
+	"btrfs inspect-internal dump-tree [options] <device> [<device> ..]",
 	"Dump tree structures from a given device",
 	"Dump tree structures from a given device in textual form, expand keys to human",
 	"readable equivalents where possible.",
@@ -201,6 +202,7 @@ const char * const cmd_inspect_dump_tree_usage[] = {
 	"                       can be specified multiple times",
 	"-t|--tree <tree_id>    print only tree with the given id (string or number)",
 	"--follow               use with -b, to show all children tree blocks of <block_num>",
+	"--noscan               do not scan for the partner device(s)",
 	NULL
 };
 
@@ -296,7 +298,7 @@ int cmd_inspect_dump_tree(int argc, char **argv)
 	struct btrfs_key found_key;
 	struct cache_tree block_root;	/* for multiple --block parameters */
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
-	int ret;
+	int ret = 0;
 	int slot;
 	int extent_only = 0;
 	int device_only = 0;
@@ -304,6 +306,7 @@ int cmd_inspect_dump_tree(int argc, char **argv)
 	int roots_only = 0;
 	int root_backups = 0;
 	int traverse = BTRFS_PRINT_TREE_DEFAULT;
+	int dev_optind;
 	unsigned open_ctree_flags;
 	u64 block_bytenr;
 	struct btrfs_root *tree_root_scan;
@@ -322,8 +325,8 @@ int cmd_inspect_dump_tree(int argc, char **argv)
 	optind = 0;
 	while (1) {
 		int c;
-		enum { GETOPT_VAL_FOLLOW = 256, GETOPT_VAL_DFS,
-		       GETOPT_VAL_BFS };
+		enum { GETOPT_VAL_FOLLOW = 256, GETOPT_VAL_DFS, GETOPT_VAL_BFS,
+		       GETOPT_VAL_NOSCAN};
 		static const struct option long_options[] = {
 			{ "extents", no_argument, NULL, 'e'},
 			{ "device", no_argument, NULL, 'd'},
@@ -335,6 +338,7 @@ int cmd_inspect_dump_tree(int argc, char **argv)
 			{ "follow", no_argument, NULL, GETOPT_VAL_FOLLOW },
 			{ "bfs", no_argument, NULL, GETOPT_VAL_BFS },
 			{ "dfs", no_argument, NULL, GETOPT_VAL_DFS },
+			{ "noscan", no_argument, NULL, GETOPT_VAL_NOSCAN },
 			{ NULL, 0, NULL, 0 }
 		};
 
@@ -399,24 +403,49 @@ int cmd_inspect_dump_tree(int argc, char **argv)
 		case GETOPT_VAL_BFS:
 			traverse = BTRFS_PRINT_TREE_BFS;
 			break;
+		case GETOPT_VAL_NOSCAN:
+			open_ctree_flags |= OPEN_CTREE_NO_DEVICES;
+			break;
 		default:
 			usage_unknown_option(cmd_inspect_dump_tree_usage, argv);
 		}
 	}
 
-	if (check_argc_exact(argc - optind, 1))
+	if (check_argc_min(argc - optind, 1))
 		return 1;
 
-	ret = check_arg_type(argv[optind]);
-	if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
+	dev_optind = optind;
+	while (dev_optind < argc) {
+		int fd;
+		struct btrfs_fs_devices *fs_devices;
+		u64 num_devices;
+
+		ret = check_arg_type(argv[optind]);
+		if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
+			if (ret < 0) {
+				errno = -ret;
+				error("invalid argument %s: %m", argv[dev_optind]);
+			} else {
+				error("not a block device or regular file: %s",
+				       argv[dev_optind]);
+			}
+		}
+		fd = open(argv[dev_optind], O_RDONLY);
+		if (fd < 0) {
+			error("cannot open %s: %m", argv[dev_optind]);
+			return -EINVAL;
+		}
+		ret = btrfs_scan_one_device(fd, argv[dev_optind], &fs_devices,
+					    &num_devices,
+					    BTRFS_SUPER_INFO_OFFSET,
+					    SBREAD_DEFAULT);
+		close(fd);
 		if (ret < 0) {
 			errno = -ret;
-			error("invalid argument %s: %m", argv[optind]);
-		} else {
-			error("not a block device or regular file: %s",
-			      argv[optind]);
+			error("device scan %s: %m", argv[dev_optind]);
+			return ret;
 		}
-		goto out;
+		dev_optind++;
 	}
 
 	printf("%s\n", PACKAGE_STRING);
-- 
2.20.1 (Apple Git-117)

