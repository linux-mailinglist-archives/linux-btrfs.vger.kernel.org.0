Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A218ED90E
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfKDGeo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41772 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfKDGem (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:42 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YXcN174081
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=K5yagEQmAdF5kyUZLLK0vH649n74BU6K4huYDu/ifY0=;
 b=YOXahIiLJjyNSXLcz71VEjiOHvXlGyXZrJVapcWG68VbKYahsTPgvl7Kj2IcODUZNzsh
 BikR3jk2NmXWQRgzcLNtX4JJq1xIi+2Zhm6Go5b75E4KgOGY90fIF4fvzI84pngG7CRh
 OT0G704UgrbT8faCqPRu2bkiHxsql/5UxDf49pdewZMgsJqf9YurR5XpPc9xNNCUYO3m
 SuWurNs1k2UluOLM0pW8544taAdKZpOHn2b9pn/KEoUUiclkMXk75SXn3rA76/qrla34
 aDMO6qN/913u940LZqocdVRnLXJHseTxVJvJTb9nPyYg7w6TSmZUQj+eqS3TpdojWaB/ Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2w12eqw0xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YeZB131342
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2w1kxcnf73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:39 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xA46XeeB004156
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:40 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:40 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 09/18] btrfs-progs: balance start: use global verbose option
Date:   Mon,  4 Nov 2019 14:33:07 +0800
Message-Id: <1572849196-21775-10-git-send-email-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs balance start
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index a98cd8d6200f..0170fcb7f386 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -495,6 +495,8 @@ static const char * const cmd_balance_start_usage[] = {
 	"--full-balance do not print warning and do not delay start",
 	"--background|--bg",
 	"               run the balance as a background process",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -505,11 +507,14 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 	struct btrfs_balance_args *ptrs[] = { &args.data, &args.sys,
 						&args.meta, NULL };
 	int force = 0;
-	int verbose = 0;
 	int background = 0;
 	unsigned start_flags = 0;
 	int i;
 
+	/* If global verbose is unset, set it to 0 */
+	if (bconf.verbose < 0)
+		bconf.verbose = 0;
+
 	memset(&args, 0, sizeof(args));
 
 	optind = 0;
@@ -560,7 +565,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 			force = 1;
 			break;
 		case 'v':
-			verbose = 1;
+			bconf.verbose++;
 			break;
 		case GETOPT_VAL_FULL_BALANCE:
 			start_flags |= BALANCE_START_NOWARN;
@@ -636,7 +641,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 
 	if (force)
 		args.flags |= BTRFS_BALANCE_FORCE;
-	if (verbose)
+	if (bconf.verbose)
 		dump_ioctl_balance_args(&args);
 	if (background) {
 		switch (fork()) {
-- 
1.8.3.1

