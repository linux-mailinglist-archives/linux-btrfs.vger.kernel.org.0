Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091381F775D
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 13:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFLLfm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 07:35:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50372 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLLfl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 07:35:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBQPn0125026;
        Fri, 12 Jun 2020 11:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=jVH6nh6bvG7HQXl6XWRMGhTz/QqQwYrOQe7mMjDkHmo=;
 b=fXQSYA+eaGu53fqk+CrIacvbdSreEORIzzxbbIszalTOxhysRLDIUJjrBdbkjkyiDNfg
 uEHeJfgaJhObhqDhcY37YFPgpeajfBUSeGqmeq/tihpRt2oN7e2q/YSzkZ5uOQaFXwCM
 fZWhnYC3ArhMmfKWGWUnHitSULKBQdSLjav/3yYLuslPHyNCTmhMOSBGjjZErcZvxj2g
 p1AupRXlQtZxW5InPKmfWdJ9lBvZpWvHSiY0A0CX5D/d84fHiS6G+tAFS+YEsHfzx90O
 rGzsp8geI+07A4YBNizDBi3PS+SNCB9QFU4HhmXtTC8gexZaBVLoo82u8615AXY4lE0U fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31g2jrmn10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 11:35:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBWWta067324;
        Fri, 12 Jun 2020 11:35:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31m8x3r7u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 11:35:37 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CBPVbl032758;
        Fri, 12 Jun 2020 11:25:32 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 04:25:31 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 07/16] btrfs-progs: balance start: use global verbose option
Date:   Fri, 12 Jun 2020 19:25:23 +0800
Message-Id: <20200612112523.3681-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-8-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-8-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=1 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 cotscore=-2147483648 priorityscore=1501 spamscore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs balance start
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: update help and documentation
v2: Use new helper functions and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose(), bconf_be_quiet()

    No need to init bconf.verbose in the sub command.

 Documentation/btrfs-balance.asciidoc |  3 ++-
 cmds/balance.c                       | 10 ++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/btrfs-balance.asciidoc b/Documentation/btrfs-balance.asciidoc
index 8afd76da2177..4d81692a60d8 100644
--- a/Documentation/btrfs-balance.asciidoc
+++ b/Documentation/btrfs-balance.asciidoc
@@ -99,7 +99,8 @@ act on metadata chunks, see `FILTERS` section for details about 'filters'
 -s[<filters>]::::
 act on system chunks (requires '-f'), see `FILTERS` section for details about 'filters'.
 -v::::
-be verbose and print balance filter arguments
+be verbose and print balance filter arguments. This option is merged to the
+global verbose option.
 -f::::
 force a reduction of metadata integrity, eg. when going from 'raid1' to 'single'
 --background|--bg::::
diff --git a/cmds/balance.c b/cmds/balance.c
index 8b611185bd7d..73bfedba1405 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -494,11 +494,14 @@ static const char * const cmd_balance_start_usage[] = {
 	"-d[filters]    act on data chunks",
 	"-m[filters]    act on metadata chunks",
 	"-s[filters]    act on system chunks (only under -f)",
-	"-v|--verbose   be verbose",
+	"-v|--verbose   be verbose. This option is merged to the global",
+	"               verbose option.",
 	"-f             force a reduction of metadata integrity",
 	"--full-balance do not print warning and do not delay start",
 	"--background|--bg",
 	"               run the balance as a background process",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -509,7 +512,6 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 	struct btrfs_balance_args *ptrs[] = { &args.data, &args.sys,
 						&args.meta, NULL };
 	int force = 0;
-	int verbose = 0;
 	int background = 0;
 	unsigned start_flags = 0;
 	int i;
@@ -564,7 +566,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 			force = 1;
 			break;
 		case 'v':
-			verbose = 1;
+			bconf_be_verbose();
 			break;
 		case GETOPT_VAL_FULL_BALANCE:
 			start_flags |= BALANCE_START_NOWARN;
@@ -640,7 +642,7 @@ static int cmd_balance_start(const struct cmd_struct *cmd,
 
 	if (force)
 		args.flags |= BTRFS_BALANCE_FORCE;
-	if (verbose)
+	if (bconf.verbose > BTRFS_BCONF_QUIET)
 		dump_ioctl_balance_args(&args);
 	if (background) {
 		switch (fork()) {
-- 
2.25.1

