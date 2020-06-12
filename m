Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B131F76FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 12:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgFLK7g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 06:59:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56188 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFLK7g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 06:59:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CAmxqI069842;
        Fri, 12 Jun 2020 10:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=wcKFITtEUpAUU6Ch5rKCG09tzJ90qzDlRJ/uMwWd6E0=;
 b=eTzee7bJ+tNzqeWEEJkBBdP1cefRP9CdxZb3WACmMQgggs7E3W/tmAd0RQKMaBkGi5dg
 jN8aoMDwA2DYqMYG74Q03S3vBJfSGKjBTncQzi4ZU0GdaEMzU5N5dHy7gPW1DcI1Gsjg
 NyxEhWHtJJk1c0spw8VnK10iNME7AL8SdrHAw6B06j9jtz8Wz250GcHMVWkVOUWy33RS
 BjSDkWyEtkGrbytk4ZYcTf6WLP/YjXLfmn8dovVW3gZen9f6y5bepTl7CjbJsL5LJpC7
 qPYOIVUVWF76y8Nu7rZRUUU1MMSzLunuoWKAuJN+7Pu/YbO43JhkMghZmnyVOVYjPkVL jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31g2jrmhx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 10:59:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CAsGGb146476;
        Fri, 12 Jun 2020 10:59:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 31m8c4g73h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 10:59:32 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05CAxU8Q023473;
        Fri, 12 Jun 2020 10:59:30 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 03:59:21 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 03/16] btrfs-progs: send: use global verbose and quiet options
Date:   Fri, 12 Jun 2020 18:58:56 +0800
Message-Id: <20200612105856.18329-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-4-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-4-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=3
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=3
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120081
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose and --quiet options down to the btrfs send
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: update help and documentation
v2: Use new helper function and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose(), bconf_be_quiet()

 Documentation/btrfs-send.asciidoc |  6 +++--
 cmds/send.c                       | 39 ++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/Documentation/btrfs-send.asciidoc b/Documentation/btrfs-send.asciidoc
index cd7ada76d14a..f76e808eed9e 100644
--- a/Documentation/btrfs-send.asciidoc
+++ b/Documentation/btrfs-send.asciidoc
@@ -58,9 +58,11 @@ is useful to show the differences in metadata.
 
 -v|--verbose::
 enable verbose output, print generated commands in a readable form, (each
-occurrence of this option increases the verbosity level)
+occurrence of this option increases the verbosity level). This option is
+merged to the global verbose option.
 -q|--quiet::
-suppress all messages except errors
+suppress all messages except errors. This option is merged to the global quiet
+option.
 
 EXIT STATUS
 -----------
diff --git a/cmds/send.c b/cmds/send.c
index 7ce6c3273857..b2afc6668f95 100644
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
@@ -458,8 +453,13 @@ static const char * const cmd_send_usage[] = {
 	"                 to transfer changes. This mode is faster and useful to",
 	"                 show the differences in metadata.",
 	"-v|--verbose     enable verbose output to stderr, each occurrence of",
-	"                 this option increases verbosity",
-	"-q|--quiet       suppress all messages, except errors",
+	"                 this option increases verbosity. This option is",
+	"                 merged to the global verbose option.",
+	"-q|--quiet       suppress all messages, except errors. This option is",
+	"                 merged to the global quiet option.",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -482,6 +482,17 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
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
@@ -497,10 +508,10 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 
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
@@ -680,8 +691,8 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		}
 	}
 
-	if ((send_flags & BTRFS_SEND_FLAG_NO_FILE_DATA) && g_verbose > 1)
-		if (g_verbose > 1)
+	if ((send_flags & BTRFS_SEND_FLAG_NO_FILE_DATA) && bconf.verbose > 1)
+		if (bconf.verbose > 1)
 			fprintf(stderr, "Mode NO_FILE_DATA enabled\n");
 
 	for (i = optind; i < argc; i++) {
@@ -691,7 +702,7 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 		free(subvol);
 		subvol = argv[i];
 
-		if (g_verbose > 0)
+		if (bconf.verbose > BTRFS_BCONF_QUIET)
 			fprintf(stderr, "At subvol %s\n", subvol);
 
 		subvol = realpath(subvol, NULL);
-- 
2.25.1

