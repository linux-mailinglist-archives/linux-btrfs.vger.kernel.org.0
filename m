Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D831F7748
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgFLL2B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 07:28:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59144 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFLL2A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 07:28:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBR4VX113567;
        Fri, 12 Jun 2020 11:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=SqbMjTQYEg5OqrG5J46mVyPIEQm6jD/BtUDvA9xajcQ=;
 b=FwPg0kIB5yiGlVpvc0u+q+hN7oEvTh678us3CySbGES1UUKeppynZZjWum6Qtdrcmbn0
 AldGnjJLnDaY9pm1kjyhkVa6RgGDL/7vgaMC9KyGp5rGGvWwUf4DXcdK4UqVoGGs98TK
 6zO3nKWiwEP33e2EHjD+e3bN0qaLMj65TwdI+zl17Z6EGxY9XKqptJ3waNrIOU8ptR/Z
 0lD0eWD/4DFMxkGUxndpGZAr5cTd0R3S7LZ+bPjiZD03qG4qPdgSd+4aWIiENRev7uzQ
 0sYG2kWMwiusgqJmtDVeVhFQQmNeN+ls3dyWX9CGxmhxOEzKACqK9NJu72G9oQzo5eng jw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31jepp6eub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 11:27:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBOhik156099;
        Fri, 12 Jun 2020 11:25:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 31m8te0114-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 11:25:56 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CBPtPs000570;
        Fri, 12 Jun 2020 11:25:55 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 04:25:54 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 09/16] btrfs-progs: rescue chunk-recover: use global verbose option
Date:   Fri, 12 Jun 2020 19:25:45 +0800
Message-Id: <20200612112545.3793-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-10-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-10-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=1 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=1
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs rescue chunk-recover
sub-command.

For example: Both global and local verbose options are now supported.
 btrfs -v|--verbose rescue chunk-recover
 btrfs rescue chunk-recover -v

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: update help and documentation
v2: Use new helper functions and defines
     HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
     bconf_be_verbose(), bconf_be_quiet()
    Drop verbose argument in init_recover_control()

 Documentation/btrfs-rescue.asciidoc |  2 +-
 cmds/rescue-chunk-recover.c         |  9 ++++-----
 cmds/rescue.c                       | 14 ++++++++++----
 cmds/rescue.h                       |  2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/btrfs-rescue.asciidoc b/Documentation/btrfs-rescue.asciidoc
index f94a0ff2b45e..995515890e9e 100644
--- a/Documentation/btrfs-rescue.asciidoc
+++ b/Documentation/btrfs-rescue.asciidoc
@@ -24,7 +24,7 @@ Recover the chunk tree by scanning the devices
 -y::::
 assume an answer of 'yes' to all questions.
 -v::::
-verbose mode.
+verbose mode. This option is merged to the global verbose option.
 -h::::
 help.
 
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index a13acc015d11..1854e7984127 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -194,8 +194,7 @@ static struct btrfs_chunk *create_chunk_item(struct chunk_record *record)
 	return ret;
 }
 
-static void init_recover_control(struct recover_control *rc, int verbose,
-		int yes)
+static void init_recover_control(struct recover_control *rc, int yes)
 {
 	memset(rc, 0, sizeof(struct recover_control));
 	cache_tree_init(&rc->chunk);
@@ -208,7 +207,7 @@ static void init_recover_control(struct recover_control *rc, int verbose,
 	INIT_LIST_HEAD(&rc->rebuild_chunks);
 	INIT_LIST_HEAD(&rc->unrepaired_chunks);
 
-	rc->verbose = verbose;
+	rc->verbose = bconf.verbose;
 	rc->yes = yes;
 	pthread_mutex_init(&rc->rc_lock, NULL);
 }
@@ -2319,14 +2318,14 @@ static void validate_rebuild_chunks(struct recover_control *rc)
 /*
  * Return 0 when successful, < 0 on error and > 0 if aborted by user
  */
-int btrfs_recover_chunk_tree(const char *path, int verbose, int yes)
+int btrfs_recover_chunk_tree(const char *path, int yes)
 {
 	int ret = 0;
 	struct btrfs_root *root = NULL;
 	struct btrfs_trans_handle *trans;
 	struct recover_control rc;
 
-	init_recover_control(&rc, verbose, yes);
+	init_recover_control(&rc, yes);
 
 	ret = recover_prepare(&rc, path);
 	if (ret) {
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 087c33befeff..bb65a672bbf3 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -38,8 +38,11 @@ static const char * const cmd_rescue_chunk_recover_usage[] = {
 	"Recover the chunk tree by scanning the devices one by one.",
 	"",
 	"-y	Assume an answer of `yes' to all questions",
-	"-v	Verbose mode",
+	"-v	Verbose mode. This option is merged to the global verbose",
+        "       option",
 	"-h	Help",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -49,7 +52,10 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 	int ret = 0;
 	char *file;
 	int yes = 0;
-	int verbose = 0;
+
+	/* If verbose is unset, set it to 0 */
+	if (bconf.verbose == BTRFS_BCONF_UNSET)
+		bconf.verbose = BTRFS_BCONF_QUIET;
 
 	optind = 0;
 	while (1) {
@@ -61,7 +67,7 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 			yes = 1;
 			break;
 		case 'v':
-			verbose = 1;
+			bconf.verbose++;
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -83,7 +89,7 @@ static int cmd_rescue_chunk_recover(const struct cmd_struct *cmd,
 		return 1;
 	}
 
-	ret = btrfs_recover_chunk_tree(file, verbose, yes);
+	ret = btrfs_recover_chunk_tree(file, yes);
 	if (!ret) {
 		fprintf(stdout, "Chunk tree recovered successfully\n");
 	} else if (ret > 0) {
diff --git a/cmds/rescue.h b/cmds/rescue.h
index de486e2e2004..e594954f78e2 100644
--- a/cmds/rescue.h
+++ b/cmds/rescue.h
@@ -16,6 +16,6 @@
 #define __BTRFS_RESCUE_H__
 
 int btrfs_recover_superblocks(const char *path, int verbose, int yes);
-int btrfs_recover_chunk_tree(const char *path, int verbose, int yes);
+int btrfs_recover_chunk_tree(const char *path, int yes);
 
 #endif
-- 
2.25.1

