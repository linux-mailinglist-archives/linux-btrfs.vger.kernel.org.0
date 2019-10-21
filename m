Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE653DE8E4
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfJUKBn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56120 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfJUKBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xIHZ004741
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=T56ZoFaiV3xBPKnapISS7jtMPY67YCjtahyHGhLIgdY=;
 b=lhJpz8ZM9xWfyXPzhx3R2zkXmq1FugzSCsMZjomom1H7pE9GSARJBN8hN6NF8w3cdCw2
 H493fU+qro6Z/2ON+oIZSA2X4JlU1tOTHtRv1TWhmfkFBnm4oDs3/i3AQ1D+5QdlpSz1
 59HohNCS5BFEDQrRKmS0ewXsxzRWuIrJIxchBIeMvK9HOe+/j12LLkLzybXa49titjqE
 vCFOgIgr8VlMEX4TBIET2aQsmuYg9rAAOGDXRj7DLJhIRc3DWmSdbxnWJgAWzCd15CHE
 yNos3Nj1jj77K//daR2fUpubEAKoTzY22uMs6j51GMOZAxCQ5mLCHZFsVTYowVJlbq5g +g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4qedx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9w8pN006299
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vrbxsvmeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:40 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9LA1dgN013496
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:39 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:38 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 04/14] btrfs-progs: migrate btrfs balance start to global verbose
Date:   Mon, 21 Oct 2019 18:01:12 +0800
Message-Id: <1571652082-25982-5-git-send-email-anand.jain@oracle.com>
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

Make sure the sub command balance start calls verbose when the global
verbose is set and vise versa.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 32830002f3a0..7e84efd6a80d 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -34,6 +34,8 @@
 #include "common/utils.h"
 #include "common/help.h"
 
+extern bool global_verbose;
+
 static const char * const balance_cmd_group_usage[] = {
 	"btrfs balance <command> [options] <path>",
 	"btrfs balance <path>",
@@ -487,14 +489,13 @@ static const char * const cmd_balance_start_usage[] = {
 	"long operation and the user is warned before this start, with",
 	"a delay to stop it.",
 	"",
-	"-d[filters]    act on data chunks",
-	"-m[filters]    act on metadata chunks",
-	"-s[filters]    act on system chunks (only under -f)",
-	"-v             be verbose",
-	"-f             force a reduction of metadata integrity",
-	"--full-balance do not print warning and do not delay start",
-	"--background|--bg",
-	"               run the balance as a background process",
+	"-d[filters]        act on data chunks",
+	"-m[filters]        act on metadata chunks",
+	"-s[filters]        act on system chunks (only under -f)",
+	HELPINFO_INSERT_VERBOSE_SHORT,
+	"-f                 force a reduction of metadata integrity",
+	"--full-balance     do not print warning and do not delay start",
+	"--background|--bg  run the balance as a background process",
 	NULL
 };
 
@@ -505,7 +506,6 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 	struct btrfs_balance_args *ptrs[] = { &args.data, &args.sys,
 						&args.meta, NULL };
 	int force = 0;
-	int verbose = 0;
 	int background = 0;
 	unsigned start_flags = 0;
 	int i;
@@ -560,7 +560,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 			force = 1;
 			break;
 		case 'v':
-			verbose = 1;
+			global_verbose = true;
 			break;
 		case GETOPT_VAL_FULL_BALANCE:
 			start_flags |= BALANCE_START_NOWARN;
@@ -636,7 +636,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 
 	if (force)
 		args.flags |= BTRFS_BALANCE_FORCE;
-	if (verbose)
+	if (global_verbose)
 		dump_ioctl_balance_args(&args);
 	if (background) {
 		switch (fork()) {
-- 
1.8.3.1

