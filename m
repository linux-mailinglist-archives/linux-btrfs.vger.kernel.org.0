Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0050ED90D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfKDGeg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:36 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:32822 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfKDGeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:36 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YY8o187195
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=eQ5D49kxW0WTWhWtU7+Say7+zTJmJzixCso9Q86w/gk=;
 b=JmCgOZXkP9iZlqZVtjuJ/01iTY80CjMkxXj/FoOJ4tYM8MX1ozP1EEq+A/JNHJRr4NxX
 Oc1DXnhwPxrRgZDg0eIaxdHObtyODR54Awjp6A75ipiI7IM4VBQZpb2Dp30qARabUW9r
 1HsRlgjyq7sDhXmQcHdmepsmHcHECzJoi2ZE6FxjJx3he+uhFTAiyxPUt6V/O+lbQEMi
 vcZYiIkdGsPuu5Bk6g+Lr2yiY+2GGyaGvvvRepWZwQ/sqPsLzBhYKwLDadBojwzW/m4A
 myurtdyh8SMBswl5TU5vhbCRPPl4bSxFABDHp52GY7AD6knJzKkZPPHC+TKaCovk+aPc qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w11rpn5p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YXiP187574
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2w1kxkt9b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:33 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA46XnlE023641
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:49 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:49 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 15/18] btrfs-progs: inspect-internal logical-resolve: use global verbose option
Date:   Mon,  4 Nov 2019 14:33:13 +0800
Message-Id: <1572849196-21775-16-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040063
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
1.8.3.1

