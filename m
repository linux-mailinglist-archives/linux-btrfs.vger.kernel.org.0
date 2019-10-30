Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2B6E9851
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfJ3Ilm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48892 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfJ3Ill (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8ccnh027328;
        Wed, 30 Oct 2019 08:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=ACrJoJATT5Rlm686YqJ+JCOoSz3lp6JGQvUS7LLcRrA=;
 b=qNwuRvY0CgH+Q6GcT4DhdaEWIcVQ8EFTbp3wn/dVJ5DovpHHqJ2r+CQDNxD5u5h108v1
 KHmK8EwxZJI//6BSkceO5TIbStbeIeugOrO1rjpoxsf71RBMZvx8VQLSagydLsWBLLaP
 kLbrqW6/kvL5N1ktzU8Vsg0xGsCkZ1G1b+QFK+3n6lO66yCYhNfxoge45BkpYPnL7lu1
 H5tLhKlaEJoVtTVksRb68kt6tl1wLx7xkPYC1OjMZthlWEZTQIHGIw6q/POmnBS5VuxD
 APSCi449d8KF7YeokEdXAZs7LRrolcaUCY9i4CiFUzGNNO7yUOmULEI+0dai2bqT4RZz DA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2vxwhfjeh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8bvdl113495;
        Wed, 30 Oct 2019 08:41:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vxwj9jaa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:39 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9U8fdB1008395;
        Wed, 30 Oct 2019 08:41:39 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:38 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 07/18] btrfs-progs: subvolume delete: use global verbose option
Date:   Wed, 30 Oct 2019 16:41:11 +0800
Message-Id: <20191030084122.29745-8-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs subvolume delete
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/subvolume.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index 7a5fd79bb1f3..a00258670c18 100644
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
+	pr_verbose(true, "Transaction commit: %s\n",
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
+					pr_verbose(true,
+						   "final sync is done for fsid: %s\n",
+						   uuidbuf);
 				}
 				seen = seen->next;
 			}
-- 
2.23.0

