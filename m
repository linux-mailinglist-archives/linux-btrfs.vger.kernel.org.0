Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73A1ED910
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfKDGeg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41480 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfKDGef (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YX7Z003882
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=AIhceseWmqun/NFKE0aPqUJFt4NSSgrllzGcTqzx79k=;
 b=Y4oDWarz4rASVEY53UWo3Tru6tUor7LJo3qcIQe07bwIqgt6sC6Fw8vus5XBHXjXJCTP
 a98sk1FlmUqrUAydFleSgWuI9saAqDTwUHrUc53Hme0kUMolkVzmQccRfO6C8xbr4Swb
 CE4YaQy2XgopEicSPnSKMt3SxWi9fkDcaNJU5JY0dD02I9PSqBp8zN8KAHQ9iszcCKEd
 nsNL9ieKWto6kdXt0Fpvk33wAbIfZRT88AIHJ3mjIxXRJp8gYehq2owR7hxCUZcZqTqC
 GjcHeetWYWaMZbUfGSeFaJDEuXNu/a962ZIMUxCmJCG2rFu1qnIeehjtyXUl0uHVft/y 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w117tn75g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YWdw046572
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w1ka9qsk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:32 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA46XjEI030932
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:45 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:44 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1 12/18] btrfs-progs: rescue super-recover: use global verbose option
Date:   Mon,  4 Nov 2019 14:33:10 +0800
Message-Id: <1572849196-21775-13-git-send-email-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs rescue super-recover
sub-command.

For example: Both global and local verbose options are now supported.
btrfs -v|--verbose rescue super-recover
btrfs rescue super-recover -v

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/rescue.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index 649f612aa051..195536457f7b 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -107,6 +107,8 @@ static const char * const cmd_rescue_super_recover_usage[] = {
 	"",
 	"-y	Assume an answer of `yes' to all questions",
 	"-v	Verbose mode",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -122,10 +124,13 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 				    int argc, char **argv)
 {
 	int ret;
-	int verbose = 0;
 	int yes = 0;
 	char *dname;
 
+	/* Init global verbose if unset */
+	if (bconf.verbose < 0)
+		bconf.verbose = 0;
+
 	optind = 0;
 	while (1) {
 		int c = getopt(argc, argv, "vy");
@@ -133,7 +138,7 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 			break;
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			bconf.verbose++;
 			break;
 		case 'y':
 			yes = 1;
@@ -155,7 +160,7 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 		error("the device is busy");
 		return 1;
 	}
-	ret = btrfs_recover_superblocks(dname, verbose, yes);
+	ret = btrfs_recover_superblocks(dname, bconf.verbose, yes);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(rescue_super_recover, "super-recover");
-- 
1.8.3.1

