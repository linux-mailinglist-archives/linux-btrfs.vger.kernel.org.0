Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A830A108BDF
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfKYKjq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50394 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfKYKjp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY8YW026933
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=+DbVHrN61eEJdFmQa3G3gSMqH3Tl4XDcK5WKekl+bNU=;
 b=eKUjbLVbSlO1op/ub6mGzATcAFxwu0kFFNl2OMydfqm72vKFoDugmTo16skz/eL2z/Ma
 WvGO4GnqWPm5sZbamgaIulTMs1o8LdoNxiJFOC3M6NUVU68cBwBAX0DEHCwVbRTZ0jfx
 12P332jCMchd7p2v47UEhVX1kDEMn46Iy7U7/z9ZZpgRU72Dky9L0gqlfl1ysUoW+NMb
 /zrPE6ZLoOeKmez3KbR25SmxLxXASq9l+s86d+njZxXr5syCbNW27u3A9upvPQvs5nzk
 7SX9/EVnaKazfY2H6KDogAztI3w12xvRfUOMCXQiDXVcrKKSkM24iF6mbESWuWcbnZAu sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wev6txrtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAXIWU191785
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wfex64qxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAPAdh9d017373
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:43 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:42 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/16] btrfs-progs: rescue chunk-recover: use global verbose option
Date:   Mon, 25 Nov 2019 18:39:10 +0800
Message-Id: <1574678357-22222-10-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
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

Transpire global --verbose option down to the btrfs rescue chunk-recover
sub-command.

For example: Both global and local verbose options are now supported.
 btrfs -v|--verbose rescue chunk-recover
 btrfs rescue chunk-recover -v

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use new helper functions and defines
     HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
     bconf_be_verbose(), bconf_be_quiet()
    Drop verbose argument in init_recover_control()

 cmds/rescue-chunk-recover.c |  9 ++++-----
 cmds/rescue.c               | 11 ++++++++---
 cmds/rescue.h               |  2 +-
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 171b4d07ecf9..cc7dc8c72487 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -194,8 +194,7 @@ static struct btrfs_chunk *create_chunk_item(struct chunk_record *record)
 	return ret;
 }
 
-static void init_recover_control(struct recover_control *rc, int verbose,
-		int yes)
+static void init_recover_control(struct recover_control *rc, int yes)
 {
 	memset(rc, 0, sizeof(struct recover_control));
 	cache_tree_init(&rc->chunk);
@@ -208,7 +207,7 @@ static void init_recover_control(struct recover_control *rc, int verbose,
 	INIT_LIST_HEAD(&rc->rebuild_chunks);
 	INIT_LIST_HEAD(&rc->unrepaired_chunks);
 
-	rc->verbose = verbose;
+	rc->verbose = bconf.verbose;
 	rc->yes = yes;
 	pthread_mutex_init(&rc->rc_lock, NULL);
 }
@@ -2319,14 +2318,14 @@ static void validate_rebuild_chunks(struct recover_control *rc)
 /*
  * Return 0 when successful, < 0 on error and > 0 if aborted by user
  */
-int btrfs_recover_chunk_tree(const char *path, int verbose, int yes)
+int btrfs_recover_chunk_tree(const char *path, int yes)
 {
 	int ret = 0;
 	struct btrfs_root *root = NULL;
 	struct btrfs_trans_handle *trans;
 	struct recover_control rc;
 
-	init_recover_control(&rc, verbose, yes);
+	init_recover_control(&rc, yes);
 
 	ret = recover_prepare(&rc, path);
 	if (ret) {
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 087c33befeff..19de5235a22e 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -40,6 +40,8 @@ static const char * const cmd_rescue_chunk_recover_usage[] = {
 	"-y	Assume an answer of `yes' to all questions",
 	"-v	Verbose mode",
 	"-h	Help",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -49,7 +51,10 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 	int ret = 0;
 	char *file;
 	int yes = 0;
-	int verbose = 0;
+
+	/* If verbose is unset, set it to 0 */
+	if (bconf.verbose == BTRFS_BCONF_UNSET)
+		bconf.verbose = BTRFS_BCONF_QUIET;
 
 	optind = 0;
 	while (1) {
@@ -61,7 +66,7 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 			yes = 1;
 			break;
 		case 'v':
-			verbose = 1;
+			bconf.verbose++;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -83,7 +88,7 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 		return 1;
 	}
 
-	ret = btrfs_recover_chunk_tree(file, verbose, yes);
+	ret = btrfs_recover_chunk_tree(file, yes);
 	if (!ret) {
 		fprintf(stdout, "Chunk tree recovered successfully\n");
 	} else if (ret > 0) {
diff --git a/cmds/rescue.h b/cmds/rescue.h
index de486e2e2004..e594954f78e2 100644
--- a/cmds/rescue.h
+++ b/cmds/rescue.h
@@ -16,6 +16,6 @@
 #define __BTRFS_RESCUE_H__
 
 int btrfs_recover_superblocks(const char *path, int verbose, int yes);
-int btrfs_recover_chunk_tree(const char *path, int verbose, int yes);
+int btrfs_recover_chunk_tree(const char *path, int yes);
 
 #endif
-- 
1.8.3.1

