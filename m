Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE2CDE8EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfJUKBy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56256 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfJUKBx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9LA0UC2005737
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=3wpvwRPqAdEDKKlxYjB+saIlLe96z+m6zHj4A6PVXiw=;
 b=PF9HsOdUSE9dtJ/+NdX3UcvjWotqh0mRTm7mWCoaUiPOoAeyMqVQxvpCJbIizV46uzXg
 Dhj+p+ZM35caZvwwbZ/op5hD69mDPSQnjqGqD+Rvq/WeQZlCm3JtrIoYSqav3M6+iHsO
 JLj6razOPB3yTtL/7fs2Eb2cYnbws+6MSUrPbfmTpPwZ30KXJcRVCCn0y8iUucYDTarl
 swrawUsLtjwkD3M/jbs1ynj0E0KCyp48DENBGIgnYck+84LEo91NTsF0NEMlmj9AV9zQ
 Q9wqcFxWp9ZsjzoiNwP2wJ7zqQaGvlZlIiKpOoxBN14KOWLWtpUe9d1MfT6X/SjsmKm8 2g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4qedy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9wBDM055711
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vrcmmqg22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:51 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9LA1pnU023958
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:51 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:50 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 12/14] btrfs-progs: migrate inspect-internal logical-resolve to global verbose
Date:   Mon, 21 Oct 2019 18:01:20 +0800
Message-Id: <1571652082-25982-13-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
References: <1571652082-25982-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9416 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=981
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

Command btrfs inspect-internal logical-resolve provides local verbose
option this patch makes it enable-able by using the global --verbose
option.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index f872b471b420..3f35cdea56b5 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -40,7 +40,7 @@ static const char * const inspect_cmd_group_usage[] = {
 	NULL
 };
 
-static int __ino_to_path_fd(u64 inum, int fd, int verbose, const char *prepend)
+static int __ino_to_path_fd(u64 inum, int fd, const char *prepend)
 {
 	int ret;
 	int i;
@@ -118,8 +118,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 	if (fd < 0)
 		return 1;
 
-	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd,
-			       global_verbose ? 1 : 0, argv[optind+1]);
+	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd, argv[optind+1]);
 	close_file_or_dir(fd, dirstream);
 	return !!ret;
 
@@ -130,11 +129,11 @@ static const char * const cmd_inspect_logical_resolve_usage[] = {
 	"btrfs inspect-internal logical-resolve [-Pv] [-s bufsize] <logical> <path>",
 	"Get file system paths for the given logical address",
 	"",
-	"-P          skip the path resolving and print the inodes instead",
-	"-v          verbose mode",
-	"-s bufsize  set inode container's size. This is used to increase inode",
-	"            container's size in case it is not enough to read all the ",
-	"            resolved results. The max value one can set is 64k",
+	"-P                 skip the path resolving and print the inodes instead",
+	HELPINFO_INSERT_VERBOSE_SHORT,
+	"-s bufsize         set inode container's size. This is used to increase inode",
+	"                   container's size in case it is not enough to read all the ",
+	"                   resolved results. The max value one can set is 64k",
 	NULL
 };
 
@@ -144,7 +143,6 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	int ret;
 	int fd;
 	int i;
-	int verbose = 0;
 	int getpath = 1;
 	int bytes_left;
 	struct btrfs_ioctl_logical_ino_args loi;
@@ -165,7 +163,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 			getpath = 0;
 			break;
 		case 'v':
-			verbose = 1;
+			global_verbose = true;
 			break;
 		case 's':
 			size = arg_strtou64(optarg);
@@ -200,8 +198,8 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 		goto out;
 	}
 
-	if (verbose)
-		printf("ioctl ret=%d, total_size=%llu, bytes_left=%lu, "
+	pr_verbose(global_verbose,
+			"ioctl ret=%d, total_size=%llu, bytes_left=%lu, "
 			"bytes_missing=%lu, cnt=%d, missed=%d\n",
 			ret, size,
 			(unsigned long)inodes->bytes_left,
@@ -251,8 +249,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
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

