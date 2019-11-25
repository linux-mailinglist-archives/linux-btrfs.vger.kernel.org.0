Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2961108BEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKYKlg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:41:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52238 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfKYKlg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:41:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY7wh026908
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=tzWmPNlDmX3yE+7XD6i+yhj6qHWcn+UJe4i2Qp6KaoE=;
 b=gEtmc7fS7R3ipYeLoyQV/laDrAMEVNICvURJEswfJLczv3CY1PmOFlYoo7rxofXSCxK1
 nPb6Sz1/TrHH2SbX9t9wMigoJFo8Tp1Ro1ji2/yuuXL8ybA7xmDTRG/HUSh+E8aCdaGS
 VllM4S9BJfDRGIAguJp1b2AxNjD78xoi8vURK90KN+xpw5/FSk4R6UJw6aUqukrBA8FZ
 GI/WBAZFNiEDLu7YNX1duu/JYmXjGhe61f4dAv/jw3OcWsozhoLBoT4sU6nKksZPUMID
 hDKew0dHPBW2KcMDscAyDhHBWZblKxvOueXkSfP5601oup8Hr37iwc19uSTvyo4HGf2O dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wev6txs3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:41:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAX2QQ169550
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wfewa7a24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:34 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAPAdYWq001574
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:34 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:33 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/16] btrfs-progs: send: use global verbose and quiet options
Date:   Mon, 25 Nov 2019 18:39:04 +0800
Message-Id: <1574678357-22222-4-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=988
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250098
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose and --quiet options down to the btrfs send
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use new helper function and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose(), bconf_be_quiet()

 cmds/send.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/cmds/send.c b/cmds/send.c
index 7ce6c3273857..93e731d56f54 100644
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
+	HELPINFO_INSERT_GLOBALS,
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
+	if (bconf.verbose == BTRFS_BCONF_UNSET)
+		bconf.verbose = 1;
+	else if (bconf.verbose > BTRFS_BCONF_QUIET)
+		bconf.verbose++;
+
 	optind = 0;
 	while (1) {
 		enum { GETOPT_VAL_SEND_NO_DATA = 256 };
@@ -497,10 +506,10 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
 		switch (c) {
 		case 'v':
-			g_verbose++;
+			bconf_be_verbose();
 			break;
 		case 'q':
-			g_verbose = 0;
+			bconf_be_quiet();
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
+		if (bconf.verbose > BTRFS_BCONF_QUIET)
 			fprintf(stderr, "At subvol %s\n", subvol);
 
 		subvol = realpath(subvol, NULL);
-- 
1.8.3.1

