Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2481E108BDB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfKYKjk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50330 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKYKjk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY6oH026802
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=w1OUk/fFRDe1qLmDouYMVkFZAgc75L5Ou2mOVElJDLQ=;
 b=e3q1jt2go4iZV0QPygN9+lYt6AX4kxIAg0MqeYszeuRya+9AmfcAgbY87RZHNXudJRvc
 s1QbzKFHQQeE45ws7jmkQTYIRn3brpasTDtTafMsE4ji7i7ORIMOcfdUIb9qti+G3hcX
 w9F35XBf/OFLw+GDoI5+9UL0j/pHvH/V/ry442PHvuIKhnZgiDwYFvxITOgXoYMjGa3n
 cOq+2cucUovMOvN4YwQkVIqn2bv9BZBGg8JDPWy6xyiLyVz1tX53Z3JaQ1ffoKseQKey
 8q0FeEfROkNM/lqyNpRSY3J185iBgh4daSZ3dz43x5hYZv432lArEdZyr6i27jywGfPZ uA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wev6txrt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAXJ6X191866
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wfex64qu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:37 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAPAdbxF010813
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:37 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:36 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/16] btrfs-progs: subvolume delete: use global verbose option
Date:   Mon, 25 Nov 2019 18:39:06 +0800
Message-Id: <1574678357-22222-6-git-send-email-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs subvolume delete
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use new helper functions and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose(), bconf_be_quiet()

    No need to init bconf.verbose in the sub command.

 cmds/subvolume.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 7a5fd79bb1f3..2174dbf29c7d 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -234,6 +234,8 @@ static const char * const cmd_subvol_delete_usage[] = {
 	"-c|--commit-after      wait for transaction commit at the end of the operation",
 	"-C|--commit-each       wait for transaction commit after deleting each subvolume",
 	"-v|--verbose           verbose output of operations",
+	HELPINFO_INSERT_GLOBALS,
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
+			bconf_be_verbose();
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
+	pr_verbose(1, "Transaction commit: %s\n",
+		   !commit_mode ? "none (default)" :
+		   commit_mode == COMMIT_AFTER ? "at the end" : "after each");
 
 	cnt = optind;
 
@@ -353,11 +352,9 @@ again:
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
@@ -398,10 +395,11 @@ keep_fd:
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

