Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B78EB108BE3
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfKYKjw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfKYKjv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY7wO021526
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=lFAH1D5/PXA1MW6TWclnTjPr7PQq4Wos6Fiiawmurlw=;
 b=UCU5jyjnuATv02a2pMFu0Zk/JjrxJtepKcmwkJZyDcpwJjeS7TIteuEOyOB0w2b2Bm0y
 3xd+gPAzG85OjKlxfkcCre//nEJx78T7PjKkcXRobVnIx0xB9UpyZx07FMQauO7IWyyc
 YSgOJbl5i0fXju94Tt638YtfIp/KcDXUk/RrnVmBFEsVNySKoBphNT5vP/G7aP0Pj4gA
 tA8UvDA6PcZRMrdEVqfW+pkLSWh7QJywvzoVWs6AjInJeAJcyjJrfrI2DEb24qhJL3KM
 AZ3yxuWMcbqlIj3uBGu2UuHdkQbUDvN5t7ex4yZXgeIg2uKZynHFwzBaE8xbXZ1y0PKB pQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2wevqpxrxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAXtRJ173114
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wfe9ery2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:49 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAPAdmXc001770
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:48 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:47 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 12/16] btrfs-progs: inspect-internal inode-resolve: use global verbose
Date:   Mon, 25 Nov 2019 18:39:13 +0800
Message-Id: <1574678357-22222-13-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=956
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250098
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the
btrfs inspect-internal inode-resolve sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use new helper functions and defines
     HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
     bconf_be_verbose(), bconf_be_quiet()

 cmds/inspect.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 758b6e60c591..de4d163991a5 100644
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
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -91,7 +92,6 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 				     int argc, char **argv)
 {
 	int fd;
-	int verbose = 0;
 	int ret;
 	DIR *dirstream = NULL;
 
@@ -103,7 +103,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			bconf_be_verbose();
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -117,8 +117,8 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
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

