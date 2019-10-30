Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A823AE9853
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfJ3Ilq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:46 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60746 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfJ3Ilq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cdBo054043;
        Wed, 30 Oct 2019 08:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=ubzmooubjp6NPU4Ldv2Z0yvLu4zRVsmp2c4YJA4pyRM=;
 b=apOUtje1hzTMfbpDEhTaxARisyCK8XiuafA5onI+0nWI8gEhMfIu38hnQQzNG9UsfVs3
 Y/UiKSUNR+fF7845s4KZj/QZArT5Bb4323yynuQ0a2t6/n1j8ZfgKhh/kwCmzc4KKfTL
 NLADw3blcQRczo9da1iKomJBrIoZv4HE8D2bclibk3y+ayg64d5XZhSsV+kWSGW2FOlf
 mQLOYukSNIHUDljnlrAgcbodif95fEcqepg7oO9rt05v8vl9jPRzFJLCDpb7mS+yJCya
 nMdHJphaDYfaKN5Zrc5CLuMheNCZjYsOaYJxuC0uLg4UumgLvZGJdaGa4fJZlDWsmemy hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vxwhfje2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8bv76113466;
        Wed, 30 Oct 2019 08:41:43 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vxwj9jad5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:43 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9U8fgT4008044;
        Wed, 30 Oct 2019 08:41:42 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:42 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 09/18] btrfs-progs: balance start: use global verbose option
Date:   Wed, 30 Oct 2019 16:41:13 +0800
Message-Id: <20191030084122.29745-10-anand.jain@oracle.com>
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
2.23.0

