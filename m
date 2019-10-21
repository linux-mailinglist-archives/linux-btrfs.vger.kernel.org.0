Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5ADE8E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfJUKBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57766 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfJUKBq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xHhh006729
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=ZR3QA3Xq84K9xxT+J8DNDy3NbCPzsCsHqLyG/K6z/+U=;
 b=nNrbQP1Odkr347XQSr0RLp0ketvPi4KO/ATxqCwBm6ow2w26mRVyqm7cL9PnXGZ5SBpH
 quomLPkxdDpo1UmbPfNqeDALjgcz3magB2un4SYNLMGeMxbsw5nbUyKWEc4pKLEzLIGg
 OM4RRie3U1CKUtHioUoZ2CIfbosaqNo5BlXfmYxOcBoJnN1/gDQ4I8k+ylz0ZaacWpiN
 xRliyJzjLbFEAB5SEIf3maCbYFxmCrAtaURLHTtlRQeXY+LdVegF0sM5lwK7WWgYgTIP
 RvdPvMKA9YAk840yB68Zsr+qo/5xFtXp4wixuhF2BkmCufaGbB04CTRoPUfzQ9lBJ2XE jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vqtepekek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9wLsA088782
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vrbyycuu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:44 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9LA1h7a018757
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:43 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:43 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 07/14] btrfs-progs: migrate rescue chunk-recover to global verbose
Date:   Mon, 21 Oct 2019 18:01:15 +0800
Message-Id: <1571652082-25982-8-git-send-email-anand.jain@oracle.com>
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

Now with this patch the btrfs rescue chunk-recover can display verbose
output either at the sub-command level or at the top level. For example
'btrfs --verbose rescue chunk-recover <>' or 'btrfs rescue chunk-recover
-v <>'.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/rescue.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index e8eab6808bc3..1785bc164264 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -28,6 +28,8 @@
 #include "common/help.h"
 #include "cmds/rescue.h"
 
+extern bool global_verbose;
+
 static const char * const rescue_cmd_group_usage[] = {
 	"btrfs rescue <command> [options] <path>",
 	NULL
@@ -37,9 +39,9 @@ static const char * const cmd_rescue_chunk_recover_usage[] = {
 	"btrfs rescue chunk-recover [options] <device>",
 	"Recover the chunk tree by scanning the devices one by one.",
 	"",
-	"-y	Assume an answer of `yes' to all questions",
-	"-v	Verbose mode",
-	"-h	Help",
+	"-y	               Assume an answer of `yes' to all questions",
+	HELPINFO_INSERT_VERBOSE_SHORT,
+	"-h	               Help",
 	NULL
 };
 
@@ -49,7 +51,6 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 	int ret = 0;
 	char *file;
 	int yes = 0;
-	int verbose = 0;
 
 	optind = 0;
 	while (1) {
@@ -61,7 +62,7 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 			yes = 1;
 			break;
 		case 'v':
-			verbose = 1;
+			global_verbose = true;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -83,7 +84,7 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 		return 1;
 	}
 
-	ret = btrfs_recover_chunk_tree(file, verbose, yes);
+	ret = btrfs_recover_chunk_tree(file, global_verbose, yes);
 	if (!ret) {
 		fprintf(stdout, "Chunk tree recovered successfully\n");
 	} else if (ret > 0) {
-- 
1.8.3.1

