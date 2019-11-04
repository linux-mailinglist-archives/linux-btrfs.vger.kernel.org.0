Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2798DED90C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfKDGel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:32968 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbfKDGek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YdKP187263
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=kylUJcZylBwookZRUzhhf5tWMxgg4CdhYPdRmR7iMJ4=;
 b=XhuURsDVs9uPkxYItiRRVtPMFthdTXsL0N66i/2Y6VdlXPFr7qgqY6mkzyoGIuxp5+KX
 sxvBZ4Qi0y0yTIPMEfH2epV5AF/j80Vy+JheQFc51rBzp66uueN3EbwB+ueO/8pryjYN
 hsUCu64nfClyzZRumRsNc7MgzWkU+lyuQzkB9YdBK7/ZImxxwSolRcUZYuGqd85MyPmC
 GZr4ij4/ZaPFnBjWjP6iZmvwXa7jKSDw3Odx9EgHzb77e4l68zdGrWVIVLGTPvjKUnLN
 1/aQ7v/VBG0C+XNmq0NvBdAueBjBmMH3O+nS9i4GKJr+0gXA1M6++4FMh23EtuW5BDSO kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w11rpn5q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YX3l187592
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2w1kxkt974-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:37 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA46Xd2l000420
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:39 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:38 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 08/18] btrfs-progs: filesystem defragment: use global verbose option
Date:   Mon,  4 Nov 2019 14:33:06 +0800
Message-Id: <1572849196-21775-9-git-send-email-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs receive sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/filesystem.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f22089abeaa..819b9fd1fcc5 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -844,11 +844,12 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 	"(e.g., files copied with 'cp --reflink', snapshots) which may cause",
 	"considerable increase of space usage. See btrfs-filesystem(8) for",
 	"more information.",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
 static struct btrfs_ioctl_defrag_range_args defrag_global_range;
-static int defrag_global_verbose;
 static int defrag_global_errors;
 static int defrag_callback(const char *fpath, const struct stat *sb,
 		int typeflag, struct FTW *ftwbuf)
@@ -857,8 +858,7 @@ static int defrag_callback(const char *fpath, const struct stat *sb,
 	int fd = 0;
 
 	if ((typeflag == FTW_F) && S_ISREG(sb->st_mode)) {
-		if (defrag_global_verbose)
-			printf("%s\n", fpath);
+		pr_verbose(1, "%s\n", fpath);
 		fd = open(fpath, defrag_open_mode);
 		if (fd < 0) {
 			goto error;
@@ -897,6 +897,10 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	int compress_type = BTRFS_COMPRESS_NONE;
 	DIR *dirstream;
 
+	/* init global verbose if unset */
+	if (bconf.verbose < 0)
+		bconf.verbose = 0;
+
 	/*
 	 * Kernel 4.19+ supports defragmention of files open read-only,
 	 * otherwise it's an ETXTBSY error
@@ -913,7 +917,6 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	thresh = SZ_32M;
 
 	defrag_global_errors = 0;
-	defrag_global_verbose = 0;
 	defrag_global_errors = 0;
 	optind = 0;
 	while(1) {
@@ -931,7 +934,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 			flush = 1;
 			break;
 		case 'v':
-			defrag_global_verbose = 1;
+			bconf.verbose++;
 			break;
 		case 's':
 			start = parse_size(optarg);
@@ -1031,8 +1034,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 			/* errors are handled in the callback */
 			ret = 0;
 		} else {
-			if (defrag_global_verbose)
-				printf("%s\n", argv[i]);
+			pr_verbose(1, "%s\n", argv[i]);
 			ret = ioctl(fd, BTRFS_IOC_DEFRAG_RANGE,
 					&defrag_global_range);
 			defrag_err = errno;
-- 
1.8.3.1

