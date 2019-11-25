Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAE2108BDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfKYKjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:43 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37662 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfKYKjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY6b2021407
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=s9T4tsWbCzq3wueo/6QaQoWWTLLCxiHukl3t6dzAvWQ=;
 b=bmIuP1GHaNB/wGSi8IouZ7slGcNmw1wjWmBwNWmG/8CW8X7eBZWPzSGJTbz+MCYw3EFw
 6lYA0DfPbIr1OKt3xvxehtI0Ayz8Il2u5NFlQA5UaK3lm7UBKyofHRzaJv2+1XPJHkE+
 7mPIqWslCJk/snUlOfh066YqXvOsX2PF/iTtrURJR7McqSt0xoMrWJa9Ur0p4iCIdtWn
 tqtqDfVJC9zZmQ6bIPQjQ6/yIvhz09/zepScsd174kolg8RPKzvIkVI00aupos43mehf
 M5Z9WYWN9QllG/yF2t6pOPxDGaLKZxSya8bu90UDR+RF7oBrkWRdmmRDKfXYgAXn4zev VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wevqpxrx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAXIB0191751
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wfex64qvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:40 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAPAdejw017356
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:40 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:39 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/16] btrfs-progs: balance start: use global verbose option
Date:   Mon, 25 Nov 2019 18:39:08 +0800
Message-Id: <1574678357-22222-8-git-send-email-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs balance start
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use new helper functions and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose(), bconf_be_quiet()

    No need to init bconf.verbose in the sub command.

 cmds/balance.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 5392a6040a02..9c2cdacdb288 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -499,6 +499,8 @@ static const char * const cmd_balance_start_usage[] = {
 	"--full-balance do not print warning and do not delay start",
 	"--background|--bg",
 	"               run the balance as a background process",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -509,7 +511,6 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 	struct btrfs_balance_args *ptrs[] = { &args.data, &args.sys,
 						&args.meta, NULL };
 	int force = 0;
-	int verbose = 0;
 	int background = 0;
 	unsigned start_flags = 0;
 	int i;
@@ -564,7 +565,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 			force = 1;
 			break;
 		case 'v':
-			verbose = 1;
+			bconf_be_verbose();
 			break;
 		case GETOPT_VAL_FULL_BALANCE:
 			start_flags |= BALANCE_START_NOWARN;
@@ -640,7 +641,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 
 	if (force)
 		args.flags |= BTRFS_BALANCE_FORCE;
-	if (verbose)
+	if (bconf.verbose > BTRFS_BCONF_QUIET)
 		dump_ioctl_balance_args(&args);
 	if (background) {
 		switch (fork()) {
-- 
1.8.3.1

