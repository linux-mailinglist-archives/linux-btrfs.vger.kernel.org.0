Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF7E9859
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJ3Il4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33458 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfJ3Il4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cn95036479;
        Wed, 30 Oct 2019 08:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=ByUmxmdkv1tLafJpr9zp9bxKm5xqzIw4K1BHC2/M36s=;
 b=NOv+5f0iyxCN4mYv9ezk3UOU1PJLnyKZOLiPaunA6Br0SfD4OGRmI3zTrVkrsc2wR54U
 ZO5H/j0ADsQ0kiDrbBY9IwyDVio3uuDQx/VutWOI9cNDRPz5WI+alU5OO8gwX4JuB9gz
 7gOd8FcmVWRw197Ea2pckiV9rEM4gBCQbMkwjulZ1aFdejVqWun7G+ZFDNlD+REtM6d9
 422SK2Me4ehIFJ9aALGHtWWdqp8/lq502pr3O3Hp7/FuuAPCXGufZQ/r1mjdbwg+OE2N
 Yrj0q4STY5UETPOIZIW7KmdzFTYrWLnqQdGicJM0RMAPuaqLDt8e+o4Yjl+R8zgDX+xX qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vxwhfafhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8bxah113724;
        Wed, 30 Oct 2019 08:41:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vxwj9jamp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:54 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9U8fr3L008979;
        Wed, 30 Oct 2019 08:41:53 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:52 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 15/18] btrfs-progs: inspect-internal logical-resolve: use global verbose option
Date:   Wed, 30 Oct 2019 16:41:19 +0800
Message-Id: <20191030084122.29745-16-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030084122.29745-1-anand.jain@oracle.com>
References: <20191030084122.29745-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910300086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910300086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the
btrfs inspect-internal logical-resolve sub-command.

Command btrfs inspect-internal logical-resolve provides local verbose
option this patch makes it enable-able by using the global --verbose
option.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index f36fee395159..443a287fd540 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -38,7 +38,7 @@ static const char * const inspect_cmd_group_usage[] = {
 	NULL
 };
 
-static int __ino_to_path_fd(u64 inum, int fd, int verbose, const char *prepend)
+static int __ino_to_path_fd(u64 inum, int fd, const char *prepend)
 {
 	int ret;
 	int i;
@@ -121,8 +121,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 	if (fd < 0)
 		return 1;
 
-	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd,
-			       bconf.verbose, argv[optind+1]);
+	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd, argv[optind+1]);
 	close_file_or_dir(fd, dirstream);
 	return !!ret;
 
@@ -138,6 +137,8 @@ static const char * const cmd_inspect_logical_resolve_usage[] = {
 	"-s bufsize  set inode container's size. This is used to increase inode",
 	"            container's size in case it is not enough to read all the ",
 	"            resolved results. The max value one can set is 64k",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -147,7 +148,6 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	int ret;
 	int fd;
 	int i;
-	int verbose = 0;
 	int getpath = 1;
 	int bytes_left;
 	struct btrfs_ioctl_logical_ino_args loi;
@@ -168,7 +168,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 			getpath = 0;
 			break;
 		case 'v':
-			verbose = 1;
+			bconf.verbose++;
 			break;
 		case 's':
 			size = arg_strtou64(optarg);
@@ -203,13 +203,11 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 		goto out;
 	}
 
-	if (verbose)
-		printf("ioctl ret=%d, total_size=%llu, bytes_left=%lu, "
-			"bytes_missing=%lu, cnt=%d, missed=%d\n",
-			ret, size,
-			(unsigned long)inodes->bytes_left,
-			(unsigned long)inodes->bytes_missing,
-			inodes->elem_cnt, inodes->elem_missed);
+	pr_verbose(1,
+"ioctl ret=%d, total_size=%llu, bytes_left=%lu, bytes_missing=%lu, cnt=%d, missed=%d\n",
+		   ret, size, (unsigned long)inodes->bytes_left,
+		   (unsigned long)inodes->bytes_missing, inodes->elem_cnt,
+		   inodes->elem_missed);
 
 	bytes_left = sizeof(full_path);
 	ret = snprintf(full_path, bytes_left, "%s/", argv[optind+1]);
@@ -254,8 +252,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 					goto out;
 				}
 			}
-			ret = __ino_to_path_fd(inum, path_fd, verbose,
-						full_path);
+			ret = __ino_to_path_fd(inum, path_fd, full_path);
 			if (path_fd != fd)
 				close_file_or_dir(path_fd, dirs);
 		} else {
-- 
2.23.0

