Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF93DE8E8
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfJUKBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 06:01:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56186 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfJUKBs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 06:01:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9xLgw004771
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=LbIB2xm22qCd7BEPKjpxqw2Pb3d5MNbvjqpcJQ5q35I=;
 b=giVPKcbnbo68Tt3eg+/LjFmksNGDMjE/gt4zKldRjqdbClXEh4E/iffeJM5/I4bipqVG
 JMfO034q3W9RhN3iWCmjVprgj8dZgeQpgxg0S/SDoNQSoXYjlZGZLyPgyuhBvDFaNwtT
 QTOTsDMKwTtnRrOgKKcSvfXE7UzJSRbB+K2llLbYRKAdVcWZeXuCXEsVgdhIfKme3Ea7
 X1A6FD557vNmRhNmrsN2m6Wf5ZhPntoH3z3AgGJmvaUt1kph/0IXtiLdpnUJskREEHfZ
 sFuuPzlKWMjfpYamSEhQ8inzR/jdXhhaywmZugn+BCLYP56WmBxm11H4HizHGh19YTXG xQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vqu4qedxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9L9w76p006272
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vrbxsvmme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:46 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9LA1jm7013515
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2019 10:01:45 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Oct 2019 03:01:45 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 08/14] btrfs-progs: migrate rescue super-recover to global verbose
Date:   Mon, 21 Oct 2019 18:01:16 +0800
Message-Id: <1571652082-25982-9-git-send-email-anand.jain@oracle.com>
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

Now with this patch 'btrfs rescue super-recover' can show verbose output
either by the top level --verbose option or by the sub-command -v
option.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/rescue.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index 1785bc164264..bd11241478a8 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -101,8 +101,8 @@ static const char * const cmd_rescue_super_recover_usage[] = {
 	"btrfs rescue super-recover [options] <device>",
 	"Recover bad superblocks from good copies",
 	"",
-	"-y	Assume an answer of `yes' to all questions",
-	"-v	Verbose mode",
+	"-y                 Assume an answer of `yes' to all questions",
+	HELPINFO_INSERT_VERBOSE_SHORT,
 	NULL
 };
 
@@ -118,7 +118,6 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 				    int argc, char **argv)
 {
 	int ret;
-	int verbose = 0;
 	int yes = 0;
 	char *dname;
 
@@ -129,7 +128,7 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 			break;
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			global_verbose = true;
 			break;
 		case 'y':
 			yes = 1;
@@ -151,7 +150,7 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 		error("the device is busy");
 		return 1;
 	}
-	ret = btrfs_recover_superblocks(dname, verbose, yes);
+	ret = btrfs_recover_superblocks(dname, global_verbose, yes);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(rescue_super_recover, "super-recover");
-- 
1.8.3.1

