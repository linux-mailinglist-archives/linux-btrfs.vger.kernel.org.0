Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD258ED90B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2019 07:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfKDGel (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 01:34:41 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:32948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfKDGek (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Nov 2019 01:34:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46Ycrw187248
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=HBX34Q5JsQ31rA+x9uFnSUdcSyPsp7PHU21JZ3Jwygs=;
 b=NC7aEahwSqiVugKEgYoeEfbgAmonpAS4WwmBGsVZNu2mTmK5AKROGzcgNutRUoTobzNl
 56e0iSdTkflf0kR1BAZIgjLvvPabIbbhFEH0V9orUnnEtihw+K20TnxPhT+K+Md8MqEG
 4TgfOYA1zCBUAbtTm7WPGJUx6o33BjZyiHf3mrOgAKea2FIk0r5G/IYR9En0hJa5q3xd
 OzbdLM+xYvhWBbFMnXDx5Z+qEWefRcj1ehaawLEJwDv915dUQsgpyeTldgU0uPvQdVY1
 F/8WNySV6rU69/7A2btoqbrjfy2BG83Xta6OazalgSGdOI8HTwC7zJkRl2naHUypTE0p 6w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2w11rpn5px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:39 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA46YX3j187592
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:34:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2w1kxkt95n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 Nov 2019 06:34:35 +0000
Received: from abhmp0023.oracle.com (abhmp0023.oracle.com [141.146.116.29])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA46XZn7000411
        for <linux-btrfs@vger.kernel.org>; Mon, 4 Nov 2019 06:33:35 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 06:33:34 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v1.1 05/18] btrfs-progs: send: use global verbose and quiet options
Date:   Mon,  4 Nov 2019 14:33:03 +0800
Message-Id: <1572849196-21775-6-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
References: <1572849196-21775-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040063
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9430 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040063
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose and --quiet options down to the btrfs send
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1.1: Fix typo in HELPINFO_INSERT_QUIET

Global verbose-and-quiet option sequences behave differently from the
same sequence used in the local command, as show below.

Before:
btrfs.old send -q -v -f /tmp/f -p /btrfs/ss2 /btrfs/ss3
At subvol /btrfs/ss3

btrfs.old send -v -f /tmp/f -p /btrfs/ss2 /btrfs/ss3
At subvol /btrfs/ss3
BTRFS_IOC_SEND returned 0
joining genl thread

After:
btrfs.new send -q -v -f /tmp/f -p /btrfs/ss2 /btrfs/ss3
At subvol /btrfs/ss3

btrfs.new -q -v send -f /tmp/f -p /btrfs/ss2 /btrfs/ss3
At subvol /btrfs/ss3
BTRFS_IOC_SEND returned 0
joining genl thread

The (btrfs.new -q -v send) output is same as (btrfs.old send -v) which IMO
is acceptable and not a regression.

 cmds/send.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/cmds/send.c b/cmds/send.c
index 7ce6c3273857..a5b9c7698dba 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -48,11 +48,6 @@
 
 #define SEND_BUFFER_SIZE	SZ_64K
 
-/*
- * Default is 1 for historical reasons, changing may break scripts that expect
- * the 'At subvol' message.
- */
-static int g_verbose = 1;
 
 struct btrfs_send {
 	int send_fd;
@@ -292,10 +287,10 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 				"Try upgrading your kernel or don't use -e.\n");
 		goto out;
 	}
-	if (g_verbose > 1)
+	if (bconf.verbose > 1)
 		fprintf(stderr, "BTRFS_IOC_SEND returned %d\n", ret);
 
-	if (g_verbose > 1)
+	if (bconf.verbose > 1)
 		fprintf(stderr, "joining genl thread\n");
 
 	close(pipefd[1]);
@@ -460,6 +455,9 @@ static const char * const cmd_send_usage[] = {
 	"-v|--verbose     enable verbose output to stderr, each occurrence of",
 	"                 this option increases verbosity",
 	"-q|--quiet       suppress all messages, except errors",
+	HELPINFO_GLOBAL_OPTIONS_HEADER,
+	HELPINFO_INSERT_VERBOSE,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -482,6 +480,17 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 	send.dump_fd = fileno(stdout);
 	outname[0] = 0;
 
+	/*
+	 * For send, verbose default is 1 (insteasd of 0) for historical reasons,
+	 * changing may break scripts that expect the 'At subvol' message. But do
+	 * it only when bconf.verbose is unset (-1) and also adjust the value,
+	 * if global verbose is already set.
+	 */
+	if (bconf.verbose < 0)
+		bconf.verbose = 1;
+	else if (bconf.verbose > 0)
+		bconf.verbose++;
+
 	optind = 0;
 	while (1) {
 		enum { GETOPT_VAL_SEND_NO_DATA = 256 };
@@ -497,10 +506,10 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
 		switch (c) {
 		case 'v':
-			g_verbose++;
+			bconf.verbose++;
 			break;
 		case 'q':
-			g_verbose = 0;
+			bconf.verbose = 0;
 			break;
 		case 'e':
 			new_end_cmd_semantic = 1;
@@ -680,8 +689,8 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		}
 	}
 
-	if ((send_flags & BTRFS_SEND_FLAG_NO_FILE_DATA) && g_verbose > 1)
-		if (g_verbose > 1)
+	if ((send_flags & BTRFS_SEND_FLAG_NO_FILE_DATA) && bconf.verbose > 1)
+		if (bconf.verbose > 1)
 			fprintf(stderr, "Mode NO_FILE_DATA enabled\n");
 
 	for (i = optind; i < argc; i++) {
@@ -691,7 +700,7 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		free(subvol);
 		subvol = argv[i];
 
-		if (g_verbose > 0)
+		if (bconf.verbose > 0)
 			fprintf(stderr, "At subvol %s\n", subvol);
 
 		subvol = realpath(subvol, NULL);
-- 
1.8.3.1

