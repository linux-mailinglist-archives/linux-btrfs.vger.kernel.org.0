Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C6C1F7740
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 13:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgFLLZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 07:25:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41328 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLLZs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 07:25:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBN6QF173862;
        Fri, 12 Jun 2020 11:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=t/P82KxbeBt4vTaDYq4WKVr975L12zJYHrPMVCPMOAA=;
 b=fNJ7GrEAufw2wBwVNXRnqCD49J/xlUpU3hoU8pwWNL9xNsN/O2NhPehmt0e+EjSHSFKF
 1y872ylJkNt34QUNN1S9rMiNJ/I7igeuF9HHIzAhdyq8pb7cga6gGfIhqtvY+z/9Ub2l
 mUIAvbg3unuK5MM5K5XFyGVML0Wxb/m3tudGKReWtCVjH01jCLXAf5ahkoSnPz4bWvWk
 GfFHQsfagZ84EjPOERuh16U+27jtr1DYr1WZ02FnfiwPs2DJs3sDh7mqaBoPMT9X4ruc
 h3Hqfdb5mZ9b1uTiEZ0VBs+DfrDw3767V5HgSf28HwRA2LYT5E5efSeow4yDHQ77qB4t Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31g3sncfhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 11:25:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBO1gb019337;
        Fri, 12 Jun 2020 11:25:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31m8rg85m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 11:25:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CBPhnV000329;
        Fri, 12 Jun 2020 11:25:43 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 04:25:42 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 08/16] btrfs-progs: balance status: use global verbose option
Date:   Fri, 12 Jun 2020 19:25:35 +0800
Message-Id: <20200612112535.3737-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-9-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-9-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120085
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the btrfs balance status
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
index 4d81692a60d8..2dccb1cc523e 100644
--- a/Documentation/btrfs-balance.asciidoc
+++ b/Documentation/btrfs-balance.asciidoc
@@ -110,7 +110,8 @@ start the process that calls the kernel ioctl
 *status* [-v] <path>::
 Show status of running or paused balance.
 +
-If '-v' option is given, output will be verbose.
+If '-v' option is given, output will be verbose. This option is merged to the
+global verbose option.
 
 FILTERS
 -------
diff --git a/cmds/balance.c b/cmds/balance.c
index 73bfedba1405..4b4adc2ceae6 100644
--- a/cmds/balance.c
+++ b/cmds/balance.c
@@ -830,7 +830,10 @@ static const char * const cmd_balance_status_usage[] = {
 	"btrfs balance status [-v] <path>",
 	"Show status of running or paused balance",
 	"",
-	"-v|--verbose     be verbose",
+	"-v|--verbose     be verbose. This option is merged to the global",
+	"                 verbose option.",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -847,7 +850,6 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 	const char *path;
 	DIR *dirstream = NULL;
 	int fd;
-	int verbose = 0;
 	int ret;
 
 	optind = 0;
@@ -864,7 +866,7 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 
 		switch (opt) {
 		case 'v':
-			verbose = 1;
+			bconf_be_verbose();
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -910,7 +912,7 @@ static int cmd_balance_status(const struct cmd_struct *cmd,
 	       (unsigned long long)args.stat.considered,
 	       100 * (1 - (float)args.stat.completed/args.stat.expected));
 
-	if (verbose)
+	if (bconf.verbose > BTRFS_BCONF_QUIET)
 		dump_ioctl_balance_args(&args);
 
 	ret = 1;
-- 
2.25.1

