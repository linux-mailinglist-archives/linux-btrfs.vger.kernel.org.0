Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB89ADE8EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfJUKBx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56248 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfJUKBx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xIPg004742
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=M/x/GGAcmQ1tOyy1TUrepVgHplaLCDuC3Rw7Od2kB54=;
 b=qY8E+EF2L9uzOfy9YtqvN9Asxd5ma3Mz0lTD12otYb5Qfnx76boiN/9lnUEsopXk2EV8
 lmxjaRT9z/uyp6uGy0dHpD28zRXLkiwvTaKk0w+uXbe8AX2NWK2Doky6ztTEyduj4idj
 o9pTiWyfk18HfvpRu1wTtXkr7hPTZDQnGOOox2O3GgZD1c3pv/BzU64xLzcBFnI+jgpE
 kvNguCnO2HksqE32z8C2Td1Ml3LK0IpM4RLvtyY2v4oZuuYu1okB1pQ0mv4qz1oLIU8z
 HtTIula4tDhOX68/Hyr2SF1DfYj2tnUA+odShkGAWgJJISWPf7BD6fm0wQ2IOz9Wa+z+ bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vqu4qedy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9w7Ls081453
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vrcn9wceq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:50 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LA1nEL023952
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:49 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:49 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 11/14] btrfs-progs: migrate inspect-internal inode-resolve to global verbose
Date:   Mon, 21 Oct 2019 18:01:19 +0800
Message-Id: <1571652082-25982-12-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
References: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910210096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910210096
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Command btrfs inspect-internal inode-resolve provides verbose option at
the sub-command level, this patch makes it enable-able by using the
global --verbose option.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 758b6e60c591..f872b471b420 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -33,6 +33,8 @@
 #include "btrfs-list.h"
 #include "common/help.h"
 
+extern bool global_verbose;
+
 static const char * const inspect_cmd_group_usage[] = {
 	"btrfs inspect-internal <command> <args>",
 	NULL
@@ -56,8 +58,8 @@ static int __ino_to_path_fd(u64 inum, int fd, int verbose, const char *prepend)
 		goto out;
 	}
 
-	if (verbose)
-		printf("ioctl ret=%d, bytes_left=%lu, bytes_missing=%lu, "
+	pr_verbose(global_verbose,
+			"ioctl ret=%d, bytes_left=%lu, bytes_missing=%lu, "
 			"cnt=%d, missed=%d\n", ret,
 			(unsigned long)fspath->bytes_left,
 			(unsigned long)fspath->bytes_missing,
@@ -83,7 +85,7 @@ static const char * const cmd_inspect_inode_resolve_usage[] = {
 	"btrfs inspect-internal inode-resolve [-v] <inode> <path>",
 	"Get file system paths for the given inode",
 	"",
-	"-v   verbose mode",
+	HELPINFO_INSERT_VERBOSE_SHORT,
 	NULL
 };
 
@@ -91,7 +93,6 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 				     int argc, char **argv)
 {
 	int fd;
-	int verbose = 0;
 	int ret;
 	DIR *dirstream = NULL;
 
@@ -103,7 +104,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			global_verbose = true;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -117,8 +118,8 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 	if (fd < 0)
 		return 1;
 
-	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd, verbose,
-			       argv[optind+1]);
+	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd,
+			       global_verbose ? 1 : 0, argv[optind+1]);
 	close_file_or_dir(fd, dirstream);
 	return !!ret;
 
-- 
1.8.3.1

