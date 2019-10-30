Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F90E9854
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 09:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfJ3Ilr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 04:41:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60772 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfJ3Ilr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cfj8054198;
        Wed, 30 Oct 2019 08:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=NrnMcpBY2Ak9q15KEdmJeaBLMX83vQbi2Qvni9xZP/4=;
 b=Lm+jKMQwV5nXosj4bpQK+W9Cn50Gphr3PUTtJesjcLDf1Wkxl8Um3Y4CrxjSV2Ef3U9/
 sE9IhG3+R61SzgtYrhAFGA4dISjcAypKu2mg+LXZUZaEcq5yW6NarI8XYPgoDAZoUdZl
 Ood6zEzDDUpgJbv6bDK2/YxNM7TudvwtTTWJgB3XoEQCyXnLTFBYEzTDEqVdr70s6Gc9
 tNN2/xhHN+MhY1JLSoAsplOOH/dW5Y1+GgHZ6UeU09F1a5Md5RC13f5gV2vcrOuNHCGL
 r0tNwJqfEhR+USSeWbs5zIe+4P77Ub6kM64eUwwerQhusThIEXEfhsWFdhU90fM6BpxT Aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vxwhfje31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9U8cYTM073787;
        Wed, 30 Oct 2019 08:41:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vxwj63ncm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Oct 2019 08:41:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9U8fiC8008407;
        Wed, 30 Oct 2019 08:41:44 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Oct 2019 01:41:43 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v1 10/18] btrfs-progs: balance status: use global verbose option
Date:   Wed, 30 Oct 2019 16:41:14 +0800
Message-Id: <20191030084122.29745-11-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs balance status
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/balance.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/cmds/balance.c b/cmds/balance.c
index 0170fcb7f386..54784c76c1de 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -828,6 +828,8 @@ static const char * const cmd_balance_status_usage[] = {
 	"Show status of running or paused balance",
 	"",
 	"-v|--verbose     be verbose",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -844,9 +846,12 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 	const char *path;
 	DIR *dirstream = NULL;
 	int fd;
-	int verbose = 0;
 	int ret;
 
+	/* init global verbose if unset */
+	if (bconf.verbose < 0)
+		bconf.verbose = 0;
+
 	optind = 0;
 	while (1) {
 		int opt;
@@ -861,7 +866,7 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 
 		switch (opt) {
 		case 'v':
-			verbose = 1;
+			bconf.verbose++;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -907,7 +912,7 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 	       (unsigned long long)args.stat.considered,
 	       100 * (1 - (float)args.stat.completed/args.stat.expected));
 
-	if (verbose)
+	if (bconf.verbose)
 		dump_ioctl_balance_args(&args);
 
 	ret = 1;
-- 
2.23.0

