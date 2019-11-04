Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D19ED909
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfKDGeh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbfKDGeh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:37 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YavW174142
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=Jn0dSfvEiPDY1I18oC/JuS7YlIdGff7DzNfYaLOkSJM=;
 b=WBjIogiOYa74WVB2jszWazQObVpMeqoSMc+eEm59QFBnmsdfL7m80b+qhPCWXX74dqEd
 0ylqrhKL7CwqyTsw+tW2lfvr3si9ctIdUTSj07CrWhLsSMgdLe3brimGCPjR5WMwHWsA
 4RdmIsS6/pL0ELJYr/9rXEVmjn5dgTJBNnlDYJ7BcA+A8VL1+E4FPoHNn4Hra1UDDpkW
 t9XSZHbJ2472egbt+2dEWnzeZBwYnDTFUiGG5zaWtUIic0EM1psl7lP8ePVZSvT/AG2X
 bToRoBUgC70dISBgIbyrUwhpMF7a3MPyG9XPKijnNbWhYt8RkAb5PtqoydHMlYu9yGAS hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w12eqw0ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YWQb187496
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w1kxkt96j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:33 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA46Xbi9030916
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:37 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1.1 07/18] btrfs-progs: subvolume delete: use global verbose option
Date:   Mon,  4 Nov 2019 14:33:05 +0800
Message-Id: <1572849196-21775-8-git-send-email-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs subvolume delete
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1.1: fix stale error use pr_verbose(1,..) instead of pr_verbose(true,..)

 cmds/subvolume.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 7a5fd79bb1f3..7cc215e1b0d5 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -234,6 +234,8 @@ static const char * const cmd_subvol_delete_usage[] = {
 	"-c|--commit-after      wait for transaction commit at the end of the operation",
 	"-C|--commit-each       wait for transaction commit after deleting each subvolume",
 	"-v|--verbose           verbose output of operations",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -248,7 +250,6 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	char	*dupvname = NULL;
 	char	*path;
 	DIR	*dirstream = NULL;
-	int verbose = 0;
 	int commit_mode = 0;
 	u8 fsid[BTRFS_FSID_SIZE];
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
@@ -256,6 +257,10 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	enum { COMMIT_AFTER = 1, COMMIT_EACH = 2 };
 	enum btrfs_util_error err;
 
+	/* init global verbose if unset */
+	if (bconf.verbose < 0)
+		bconf.verbose = 0;
+
 	optind = 0;
 	while (1) {
 		int c;
@@ -278,7 +283,7 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 			commit_mode = COMMIT_EACH;
 			break;
 		case 'v':
-			verbose++;
+			bconf.verbose++;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -288,11 +293,9 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	if (check_argc_min(argc - optind, 1))
 		return 1;
 
-	if (verbose > 0) {
-		printf("Transaction commit: %s\n",
-			!commit_mode ? "none (default)" :
-			commit_mode == COMMIT_AFTER ? "at the end" : "after each");
-	}
+	pr_verbose(1, "Transaction commit: %s\n",
+		   !commit_mode ? "none (default)" :
+		   commit_mode == COMMIT_AFTER ? "at the end" : "after each");
 
 	cnt = optind;
 
@@ -353,11 +356,9 @@ again:
 		}
 
 		if (add_seen_fsid(fsid, seen_fsid_hash, fd, dirstream) == 0) {
-			if (verbose > 0) {
-				uuid_unparse(fsid, uuidbuf);
-				printf("  new fs is found for '%s', fsid: %s\n",
-						path, uuidbuf);
-			}
+			uuid_unparse(fsid, uuidbuf);
+			pr_verbose(1, "  new fs is found for '%s', fsid: %s\n",
+				   path, uuidbuf);
 			/*
 			 * This is the first time a subvolume on this
 			 * filesystem is deleted, keep fd in order to issue
@@ -398,10 +399,11 @@ keep_fd:
 			"unable to do final sync after deletion: %m, fsid: %s",
 						uuidbuf);
 					ret = 1;
-				} else if (verbose > 0) {
+				} else {
 					uuid_unparse(seen->fsid, uuidbuf);
-					printf("final sync is done for fsid: %s\n",
-						uuidbuf);
+					pr_verbose(1,
+					   "final sync is done for fsid: %s\n",
+						   uuidbuf);
 				}
 				seen = seen->next;
 			}
-- 
1.8.3.1

