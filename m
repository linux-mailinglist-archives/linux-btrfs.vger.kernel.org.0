Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7C0ED904
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfKDGef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:32790 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfKDGef (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YXUd187178
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=JQIReaKp9e6eoi7r6LLrz6DY/1J7adoj9GBx7dLWOVo=;
 b=DqP4a/nlbkNLrfZtDF5WEtkvCtE1ZIZjzFmfnzpAc6rlMieRgEaGcIe8ZRGKUuld/ULh
 YeqAuMyXI+Brtwc0ObqpaV4XMf6a/KZnTrD6z5BXe95j5QZTLXvq2BjCJIGOan30/XYw
 5UmIfPYH2RnU2jPqg5Zly/iYZg84vqTXH/gqqxL8D0tzAMQmXnBZjM0YSpldnrU3ZN5O
 b+PgRmzjzHlg7MXDEIGxLNl+MxTGynV+cV1d7HY1BRxJzsnApNgiXoF/MoIsi2VK0qCN
 Tsua6UyMHAOoxkW671wsi6orF+c6eB7I/+Vyc4Q1KsADZSo7aG1wOGC7rm3Z4bwmTPcv TQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w11rpn5nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YUnh187427
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w1kxkt9ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:33 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA46XlL3031009
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:47 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:47 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 14/18] btrfs-progs: inspect-internal inode-resolve: use global verbose
Date:   Mon,  4 Nov 2019 14:33:12 +0800
Message-Id: <1572849196-21775-15-git-send-email-anand.jain@oracle.com>
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
btrfs inspect-internal inode-resolve sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 758b6e60c591..f36fee395159 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -56,12 +56,11 @@ static int __ino_to_path_fd(u64 inum, int fd, int verbose, const char *prepend)
 		goto out;
 	}
 
-	if (verbose)
-		printf("ioctl ret=%d, bytes_left=%lu, bytes_missing=%lu, "
-			"cnt=%d, missed=%d\n", ret,
-			(unsigned long)fspath->bytes_left,
-			(unsigned long)fspath->bytes_missing,
-			fspath->elem_cnt, fspath->elem_missed);
+	pr_verbose(1,
+	"ioctl ret=%d, bytes_left=%lu, bytes_missing=%lu cnt=%d, missed=%d\n",
+		   ret, (unsigned long)fspath->bytes_left,
+		   (unsigned long)fspath->bytes_missing, fspath->elem_cnt,
+		   fspath->elem_missed);
 
 	for (i = 0; i < fspath->elem_cnt; ++i) {
 		u64 ptr;
@@ -84,6 +83,8 @@ static const char * const cmd_inspect_inode_resolve_usage[] = {
 	"Get file system paths for the given inode",
 	"",
 	"-v   verbose mode",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -91,10 +92,13 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 				     int argc, char **argv)
 {
 	int fd;
-	int verbose = 0;
 	int ret;
 	DIR *dirstream = NULL;
 
+	/* set global verbose if unset */
+	if (bconf.verbose < 0)
+		bconf.verbose = 0;
+
 	optind = 0;
 	while (1) {
 		int c = getopt(argc, argv, "v");
@@ -103,7 +107,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			bconf.verbose++;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -117,8 +121,8 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 	if (fd < 0)
 		return 1;
 
-	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd, verbose,
-			       argv[optind+1]);
+	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd,
+			       bconf.verbose, argv[optind+1]);
 	close_file_or_dir(fd, dirstream);
 	return !!ret;
 
-- 
1.8.3.1

