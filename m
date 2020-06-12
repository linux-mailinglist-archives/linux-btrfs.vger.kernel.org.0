Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4561F1F7742
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 13:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgFLL0x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 07:26:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42012 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFLL0x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 07:26:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBQXhq176445;
        Fri, 12 Jun 2020 11:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=lwlZjU42kMH0F/Iqs/etoB26xP/PGAOgtdB1XZlzssA=;
 b=dd+PsrUS4MG28qsP8BM7DMcKqfUozkj3/53gJDYNfwFPPnsqcHtLa3ZLyaSzRed09aak
 9wK6wuKP3Umx8fhX1iRs3pDyV7Ylp6NryQCTVWg+4MXSfqYKYKWavygIgA++ABbsh2nH
 S0rFEozO97XAI41S7GmkztWnSxOKvS2Upu1Up5TGy+DXQi0mLrut3+2TXc/Mr9f54h3i
 oNdiA2d9I014LZ7zDLNW2riN/bNOFlROeMX5lNIhe8XhVnpS7iqYYMxWlxjH55HytH84
 P4BTAYTuxfiBaA+shjrsZ8QYRLiGkYlD7am3Ttd/YIrtdIjwQqajBrFlc5P7zAgCq5Xy xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 31g3sncfku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 11:26:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBOtgb156293;
        Fri, 12 Jun 2020 11:26:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31m8te01rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 11:26:48 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CBQl9A026214;
        Fri, 12 Jun 2020 11:26:47 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 04:26:47 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 13/16] btrfs-progs: inspect-internal logical-resolve: use global verbose option
Date:   Fri, 12 Jun 2020 19:26:38 +0800
Message-Id: <20200612112638.4018-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-14-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-14-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=1 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120086
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
v3: update help and documentation
v2: Use new helper function bconf_be_verbose()

 Documentation/btrfs-inspect-internal.asciidoc |  1 +
 cmds/inspect.c                                | 25 ++++++++-----------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/Documentation/btrfs-inspect-internal.asciidoc b/Documentation/btrfs-inspect-internal.asciidoc
index e8d4c861603d..c0009e2e5382 100644
--- a/Documentation/btrfs-inspect-internal.asciidoc
+++ b/Documentation/btrfs-inspect-internal.asciidoc
@@ -152,6 +152,7 @@ resolve paths to all files at given 'logical' address in the linear filesystem s
 skip the path resolving and print the inodes instead
 -v::::
 verbose mode, print count of returned paths and all ioctl() return values
+This option is merged to the global verbose option
 -o::::
 ignore offsets, find all references to an extent instead of a single block.
 Requires kernel support for the V2 ioctl (added in 4.15). The results might need
diff --git a/cmds/inspect.c b/cmds/inspect.c
index b0d3c8102400..bbbac4431ac7 100644
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
@@ -117,8 +117,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 	if (fd < 0)
 		return 1;
 
-	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd,
-			       bconf.verbose, argv[optind+1]);
+	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd, argv[optind+1]);
 	close_file_or_dir(fd, dirstream);
 	return !!ret;
 
@@ -137,6 +136,8 @@ static const char * const cmd_inspect_logical_resolve_usage[] = {
 	"            container's size in case it is not enough to read all the ",
 	"            resolved results. The max value one can set is 64k with the",
 	"            v1 ioctl. Sizes over 64k will use the v2 ioctl (kernel 4.15+)",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -146,7 +147,6 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 	int ret;
 	int fd;
 	int i;
-	int verbose = 0;
 	int getpath = 1;
 	int bytes_left;
 	struct btrfs_ioctl_logical_ino_args loi = { 0 };
@@ -169,7 +169,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
 			getpath = 0;
 			break;
 		case 'v':
-			verbose = 1;
+			bconf_be_verbose();
 			break;
 		case 'o':
 			flags |= BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET;
@@ -211,13 +211,11 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
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
@@ -262,8 +260,7 @@ static int cmd_inspect_logical_resolve(const struct cmd_struct *cmd,
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
2.25.1

