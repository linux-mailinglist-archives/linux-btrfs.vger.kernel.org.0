Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 461BEDE8E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJUKBl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56096 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfJUKBk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xQPf004807
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=5ivy1U6WHl5EDSC1wBhZTPUs7XgEI022uVgIrLEDylg=;
 b=iJ6xOqWwLzT8oVn86o3kVGDwB1RI8ZJ4++DuNVBuSdE0H2IMrdug7N9jt8wrioLXHLkv
 a67t7jkijh1OQ/ypaHUtrQtnt0iCx7w96wvYuq9qJj78PlUMaQy0ptQxT4XnnwHI3g79
 pfqzbMzAUPHtKgHYow8H/ypd67qrXVX3yWbQrjZMP1mfjW8e/igmjOJfhgJDLenztf1A
 4WBrEHpbN4zPRkNQslNys3W62WeeZ+o8uYbzB7gvxZ2L4gsyiDwkmdrkpfWrMK6fgCEm
 cKKlbI1B1TdhnWC5gbot+zxIcpmA4QWWXnVaQxFlTYDJC6VcR3WuElEUpTQHYhGkCrlp 8A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vqu4qedww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9wAx4055668
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vrcmmqfgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:38 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9LA1bdd013486
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:37 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:37 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 03/14] btrfs-progs: migrate filesystem defragment to global verbose
Date:   Mon, 21 Oct 2019 18:01:11 +0800
Message-Id: <1571652082-25982-4-git-send-email-anand.jain@oracle.com>
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

btrfs filesystem deframent already supports local sub-command
verbose option, enable the same when the global verbose option is set.
And as well make sure the same remains enabled at the local level.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/filesystem.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f22089abeaa..ee4d366fbf64 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -832,13 +832,13 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 	"btrfs filesystem defragment [options] <file>|<dir> [<file>|<dir>...]",
 	"Defragment a file or a directory",
 	"",
-	"-v                  be verbose",
-	"-r                  defragment files recursively",
-	"-c[zlib,lzo,zstd]   compress the file while defragmenting",
-	"-f                  flush data to disk immediately after defragmenting",
-	"-s start            defragment only from byte onward",
-	"-l len              defragment only up to len bytes",
-	"-t size             target extent size hint (default: 32M)",
+	HELPINFO_INSERT_VERBOSE_SHORT,
+	"-r                 defragment files recursively",
+	"-c[zlib,lzo,zstd]  compress the file while defragmenting",
+	"-f                 flush data to disk immediately after defragmenting",
+	"-s start           defragment only from byte onward",
+	"-l len             defragment only up to len bytes",
+	"-t size            target extent size hint (default: 32M)",
 	"",
 	"Warning: most Linux kernels will break up the ref-links of COW data",
 	"(e.g., files copied with 'cp --reflink', snapshots) which may cause",
@@ -848,7 +848,7 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 };
 
 static struct btrfs_ioctl_defrag_range_args defrag_global_range;
-static int defrag_global_verbose;
+extern bool global_verbose;
 static int defrag_global_errors;
 static int defrag_callback(const char *fpath, const struct stat *sb,
 		int typeflag, struct FTW *ftwbuf)
@@ -857,8 +857,7 @@ static int defrag_callback(const char *fpath, const struct stat *sb,
 	int fd = 0;
 
 	if ((typeflag == FTW_F) && S_ISREG(sb->st_mode)) {
-		if (defrag_global_verbose)
-			printf("%s\n", fpath);
+		pr_verbose(global_verbose, "%s\n", fpath);
 		fd = open(fpath, defrag_open_mode);
 		if (fd < 0) {
 			goto error;
@@ -913,7 +912,6 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	thresh = SZ_32M;
 
 	defrag_global_errors = 0;
-	defrag_global_verbose = 0;
 	defrag_global_errors = 0;
 	optind = 0;
 	while(1) {
@@ -931,7 +929,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 			flush = 1;
 			break;
 		case 'v':
-			defrag_global_verbose = 1;
+			global_verbose = true;
 			break;
 		case 's':
 			start = parse_size(optarg);
@@ -1031,8 +1029,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 			/* errors are handled in the callback */
 			ret = 0;
 		} else {
-			if (defrag_global_verbose)
-				printf("%s\n", argv[i]);
+			pr_verbose(global_verbose, "%s\n", argv[i]);
 			ret = ioctl(fd, BTRFS_IOC_DEFRAG_RANGE,
 					&defrag_global_range);
 			defrag_err = errno;
-- 
1.8.3.1

