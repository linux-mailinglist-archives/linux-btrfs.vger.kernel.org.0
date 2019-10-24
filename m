Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A38CE2A6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 08:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437750AbfJXG2f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Oct 2019 02:28:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55660 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437738AbfJXG2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Oct 2019 02:28:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O6O06b178711
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=twyTl369/4m0t/hvykeBAX2VSxgO30UXQ0R/QJDZq6Y=;
 b=ILm83+BV2PwxE9uZzZOXeE2wHa0tZ8pIrLaxiixs2HDfypQG3Sc31cJCjND79vY1Ibl5
 a02DwqYP5cFqCavJ/SdqoHEHCPlvqpDM5zQ4vA1LCdaZ5IWlRN1runoXCAXz2FWRRzuz
 +W/7DIy1SuCxDZYmXVW41+iIRPUCUG/RVR1umEf/zu2gpOgJznDAHBgELEsw+HOojuwc
 tV5gFhOld4RYZjZWgw3lkWll0UfBy9DWmHd5CNrrstsXYXeG3V0lMy2468zUdcHv/MKJ
 vZnS2jeUt+dlksraOoI4KTImUjJPJJVqLADV0eTZdSf3Jn7DzLeOI0Mg6W/j6S1aqdyC xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2vqswtsktr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O6MuR4080216
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vtm23unnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O6SWI7013526
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2019 06:28:32 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Oct 2019 23:28:32 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 2/3] btrfs-progs: receive: let option quiet overrule verbose
Date:   Thu, 24 Oct 2019 14:28:24 +0800
Message-Id: <20191024062825.13097-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024062825.13097-1-anand.jain@oracle.com>
References: <20191024062825.13097-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240060
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs receive has both -q|--quiet and -v|--verbose options, if when both
the options are specified, the order of the options makes difference in
the output, which is at times causes confusion.

Fix this by letting option --quite to overrule --verbose option.

Without fix:
---- btrfs receive -q -vv -f /tmp/t /btrfs1 -----
At snapshot ss3
receiving snapshot ss3 uuid=9d0001ec-29e4-194a-a13e-42d9f428d745, ctransid=11 parent_uuid=a6b75134-8865-f045-89d2-c2afcf794475, parent_ctransid=11
BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=9d0001ec-29e4-194a-a13e-42d9f428d745, stransid=11
---- btrfs receive -v -q -f /tmp/t /btrfs1 -----
At snapshot ss3
---- btrfs receive -vv -q -f /tmp/t /btrfs1 -----
At snapshot ss3

with fix:
---- btrfs receive -q -vv -f /tmp/t /btrfs1 -----
At snapshot ss3
---- btrfs receive -v -q -f /tmp/t /btrfs1 -----
At snapshot ss3
---- btrfs receive -vv -q -f /tmp/t /btrfs1 -----
At snapshot ss3

The output with either of them (-q or -v) remains unaffected
by this patch, as shown below:
---- btrfs receive -q -f /tmp/t /btrfs1 -----
At snapshot ss3
---- btrfs receive -v -f /tmp/t /btrfs1 -----
At snapshot ss3
receiving snapshot ss3 uuid=9d0001ec-29e4-194a-a13e-42d9f428d745, ctransid=11 parent_uuid=a6b75134-8865-f045-89d2-c2afcf794475, parent_ctransid=11
BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=9d0001ec-29e4-194a-a13e-42d9f428d745, stransid=11
---- btrfs receive -vv -f /tmp/t /btrfs1 -----
At snapshot ss3
receiving snapshot ss3 uuid=9d0001ec-29e4-194a-a13e-42d9f428d745, ctransid=11 parent_uuid=a6b75134-8865-f045-89d2-c2afcf794475, parent_ctransid=11
BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=9d0001ec-29e4-194a-a13e-42d9f428d745, stransid=11

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/receive.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 4b03938ea3eb..d8c934a7c57c 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1291,6 +1291,7 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 	u64 max_errors = 1;
 	int dump = 0;
 	int ret = 0;
+	bool quiet = false;
 
 	memset(&rctx, 0, sizeof(rctx));
 	rctx.mnt_fd = -1;
@@ -1321,7 +1322,7 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 			g_verbose++;
 			break;
 		case 'q':
-			g_verbose = 0;
+			quiet = true;
 			break;
 		case 'f':
 			if (arg_copy_path(fromfile, optarg, sizeof(fromfile))) {
@@ -1356,6 +1357,9 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 		}
 	}
 
+	if (quiet)
+		g_verbose = 0;
+
 	if (dump && check_argc_exact(argc - optind, 0))
 		usage(cmd);
 	if (!dump && check_argc_exact(argc - optind, 1))
-- 
2.23.0

