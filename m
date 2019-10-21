Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D200BDE8E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfJUKBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41842 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJUKBj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xKCX023798
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=NrU1f2DA8wLKCpbzrOfxL6Tk5vXCq6b2W0AzP98TMSU=;
 b=ZvpaRVnjIT4r8iSzTENRi0OVziHvKKsFP3O8nwPZVLtEoVvcN4r0AT3PkpVhUzACT5fJ
 W3/HAZ6XfP0OY2rgLEP+oeEf+8F8nzX6YOB4aN6f6lUO/IwA9cf8x+U8RJOpp8WbNdpa
 R8Lkd44+XqYMJoPuTKDa7FW5kI/LNOVMmHgGF0oM0hqGiDBpyeNYzQ7zbblu9VbKou+5
 JIlXxRISXgJjuOUEl3f9fEq0N5JBNXaRSOO/C0W/akk+mkUuuq203Y2SdyeGz+f0RVRM
 TQVqrCb1PJUGJrCyuSzt+TkmxBeVs/mpXB230TC1BZ+JYCVEQeWvDJ0IDI3YhA/Sw9ch oQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vqswt6pk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9w7G1081506
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vrcn9wc1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:37 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9LA1ZqY018735
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:36 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:35 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 02/14] btrfs-progs: migrate subvolume delete to global verbose
Date:   Mon, 21 Oct 2019 18:01:10 +0800
Message-Id: <1571652082-25982-3-git-send-email-anand.jain@oracle.com>
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

btrfs subvolume delete already supports verbose at the sub-command
level, this patch restores same verbose which can be either enabled
by the sub-command or from the top level command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/subvolume.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 7a5fd79bb1f3..18efd0cf6e4a 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -43,6 +43,8 @@
 #include "common/path-utils.h"
 #include "common/device-scan.h"
 
+extern bool global_verbose;
+
 static int wait_for_subvolume_cleaning(int fd, size_t count, uint64_t *ids,
 				       int sleep_interval)
 {
@@ -231,9 +233,9 @@ static const char * const cmd_subvol_delete_usage[] = {
 	"after a crash). Use one of the --commit options to wait until the",
 	"operation is safely stored on the media.",
 	"",
-	"-c|--commit-after      wait for transaction commit at the end of the operation",
-	"-C|--commit-each       wait for transaction commit after deleting each subvolume",
-	"-v|--verbose           verbose output of operations",
+	"-c|--commit-after  wait for transaction commit at the end of the operation",
+	"-C|--commit-each   wait for transaction commit after deleting each subvolume",
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
@@ -278,7 +279,7 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 			commit_mode = COMMIT_EACH;
 			break;
 		case 'v':
-			verbose++;
+			global_verbose = true;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -288,11 +289,9 @@ static int cmd_subvol_delete(const struct cmd_struct *cmd,
 	if (check_argc_min(argc - optind, 1))
 		return 1;
 
-	if (verbose > 0) {
-		printf("Transaction commit: %s\n",
-			!commit_mode ? "none (default)" :
-			commit_mode == COMMIT_AFTER ? "at the end" : "after each");
-	}
+	pr_verbose(global_verbose, "Transaction commit: %s\n",
+		   !commit_mode ? "none (default)" :
+		   commit_mode == COMMIT_AFTER ? "at the end" : "after each");
 
 	cnt = optind;
 
@@ -353,11 +352,10 @@ again:
 		}
 
 		if (add_seen_fsid(fsid, seen_fsid_hash, fd, dirstream) == 0) {
-			if (verbose > 0) {
-				uuid_unparse(fsid, uuidbuf);
-				printf("  new fs is found for '%s', fsid: %s\n",
-						path, uuidbuf);
-			}
+			uuid_unparse(fsid, uuidbuf);
+			pr_verbose(global_verbose,
+				   "  new fs is found for '%s', fsid: %s\n",
+				   path, uuidbuf);
 			/*
 			 * This is the first time a subvolume on this
 			 * filesystem is deleted, keep fd in order to issue
@@ -398,10 +396,11 @@ keep_fd:
 			"unable to do final sync after deletion: %m, fsid: %s",
 						uuidbuf);
 					ret = 1;
-				} else if (verbose > 0) {
+				} else {
 					uuid_unparse(seen->fsid, uuidbuf);
-					printf("final sync is done for fsid: %s\n",
-						uuidbuf);
+					pr_verbose(global_verbose,
+						   "final sync is done for fsid: %s\n",
+						   uuidbuf);
 				}
 				seen = seen->next;
 			}
-- 
1.8.3.1

