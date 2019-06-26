Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E5564A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2019 10:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFZIb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jun 2019 04:31:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37440 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZIb4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jun 2019 04:31:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8SekF180181
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=tIcLZYydRVsE5iENfDsOYgDjHAfV676+Mml9lH+CBSA=;
 b=wsL8obgZbWfWh8r9Vyyt2OoloG5PGMQWrKtXWyaFQNpcOw0L0IsAFxXzTN8sQvr4JtiF
 gXSKxun2wLCdu93RnFFvzoEqw36CtbmEGhuTGSvL3qmVWb9retifzfd8SrZQW6GSANAs
 BBejHLaNkCuvVAIhJg/fZs9LDj2g2SRxuTbHV5s74WXhtUF/nVNyPOMr1HLqKIb0u4nz
 qDsjIv7Ekix6ehCXFXV+4m62uePKugpJ+u4VgNgZhxCKtmztqCjSJRBEOreBz7YIZb1r
 BPbuRnif5+TpLPrrkxahlnPkxXUhvodnPpTP0wh4kUNvdgjoPw9SE/e7tXvSgpgvGr4E Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brt8v18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:31:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5Q8VsBn023232
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:31:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2t99f4bg6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:31:54 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5Q8VrKW011523
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2019 08:31:54 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Wed, 26 Jun 2019 01:30:21 -0700
MIME-Version: 1.0
Message-ID: <20190626083017.1833-1-anand.jain@oracle.com>
Date:   Wed, 26 Jun 2019 01:30:17 -0700 (PDT)
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 RESEND Rebased] btrfs-progs: dump-tree: add noscan option
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260103
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9299 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260103
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
v6->v7: rebase on latest btrfs-progs::devel
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
index 1588a0b0774b..8e13b4335a5d 100644
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
 
 static const char * const cmd_inspect_dump_tree_usage[] = {
-	"btrfs inspect-internal dump-tree [options] device",
+	"btrfs inspect-internal dump-tree [options] <device> [<device> ..]",
 	"Dump tree structures from a given device",
 	"Dump tree structures from a given device in textual form, expand keys to human",
 	"readable equivalents where possible.",
@@ -201,6 +202,7 @@ static const char * const cmd_inspect_dump_tree_usage[] = {
 	"                       can be specified multiple times",
 	"-t|--tree <tree_id>    print only tree with the given id (string or number)",
 	"--follow               use with -b, to show all children tree blocks of <block_num>",
+	"--noscan               do not scan for the partner device(s)",
 	NULL
 };
 
@@ -297,7 +299,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	struct btrfs_key found_key;
 	struct cache_tree block_root;	/* for multiple --block parameters */
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
-	int ret;
+	int ret = 0;
 	int slot;
 	int extent_only = 0;
 	int device_only = 0;
@@ -305,6 +307,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	int roots_only = 0;
 	int root_backups = 0;
 	int traverse = BTRFS_PRINT_TREE_DEFAULT;
+	int dev_optind;
 	unsigned open_ctree_flags;
 	u64 block_bytenr;
 	struct btrfs_root *tree_root_scan;
@@ -323,8 +326,8 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
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
@@ -336,6 +339,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 			{ "follow", no_argument, NULL, GETOPT_VAL_FOLLOW },
 			{ "bfs", no_argument, NULL, GETOPT_VAL_BFS },
 			{ "dfs", no_argument, NULL, GETOPT_VAL_DFS },
+			{ "noscan", no_argument, NULL, GETOPT_VAL_NOSCAN },
 			{ NULL, 0, NULL, 0 }
 		};
 
@@ -400,24 +404,49 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 		case GETOPT_VAL_BFS:
 			traverse = BTRFS_PRINT_TREE_BFS;
 			break;
+		case GETOPT_VAL_NOSCAN:
+			open_ctree_flags |= OPEN_CTREE_NO_DEVICES;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
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

