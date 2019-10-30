Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33D95E9852
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfJ3Iln (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48930 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfJ3Iln (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cqeY027445;
        Wed, 30 Oct 2019 08:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=uc659HNcTciaJqSi3Wt6f9vJnl4fzNJYMyZ09jcLVs4=;
 b=WoG1VZtaeUC+vMOF4J30LRX6WUDIdmr8ksy56PJaTPnnZeWSVSzrQU2gP8sH6ozEUu9Z
 Lg93tXyiE+ht1QQTkvAAIUrwj01BNbiE2k77AMzKn4gHken/BU825hxF69uB8X+kmnqg
 OaHV4K0H6eMTszduLt9PlIuij49HK9mwAYrcRpmg1BLW5ZGwQR3/SFYPj7ohLIeVl8GB
 cR+WUqHwOI1FB2s/m627DWzOHJ8RyBSEx8qzaN3jTTMgV0uG8KF1Vn6rYTixxUG7DLRL
 fF3+iik/fBOUMzIILPJnidESxNfLeOBrc6QDr4mOVfj89Lvu0cmv/Yl4n54d1uK2NipX GA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vxwhfjehq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cq2N150167;
        Wed, 30 Oct 2019 08:41:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vxwhvmfx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:41 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9U8feR2008398;
        Wed, 30 Oct 2019 08:41:40 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:40 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 08/18] btrfs-progs: filesystem defragment: use global verbose option
Date:   Wed, 30 Oct 2019 16:41:12 +0800
Message-Id: <20191030084122.29745-9-anand.jain@oracle.com>
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
2.23.0

