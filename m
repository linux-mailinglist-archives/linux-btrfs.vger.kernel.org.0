Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22051F775E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 13:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgFLLhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 07:37:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48760 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFLLhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 07:37:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBR44r176619;
        Fri, 12 Jun 2020 11:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=H1dj24sC3/x0GsqF9E3RKr1EmeyygG7ixuelSU9tBiE=;
 b=IUztN2NaPCwD6RWdftSLnYheIq5jkn9+9xTFxY+8Y1soKHB1xv1OISe8LaqoBWAmK/bR
 Q0DqOrdnsUAObvwIF+QIz0j+NO+mw3IbU8NMURq94EgLMfnAGSVqsg/5cXx2S/+yPYgk
 JoqgWLPxZViQU1CTJE4smOG1W2XbDRPceVG6uRi7jDd/xD2k2dRBeZLSmXKzQRlrRW6A
 JIii51dvGOfJ+HVJqsNP0osZJsf+GTI3RaQZvUrz2g2SufzLr5FypHV+YTS6kmnshCx9
 JtIoN6H30JIJJqOLR7Vxdz3JGbn++1F2wNKqCEdM8CWc9L2dEcBLjtmz6IV8bWkh50zY 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31g3sncgj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 11:37:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBWcwB086030;
        Fri, 12 Jun 2020 11:37:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31m8x40e2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 11:37:14 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05CBQabA028754;
        Fri, 12 Jun 2020 11:26:36 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 04:26:35 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 12/16] btrfs-progs: inspect-internal inode-resolve: use global verbose
Date:   Fri, 12 Jun 2020 19:26:27 +0800
Message-Id: <20200612112627.3962-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-13-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-13-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=1
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Transpire global --verbose option down to the
btrfs inspect-internal inode-resolve sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: update help and documentation
v2: Use new helper functions and defines
     HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
     bconf_be_verbose(), bconf_be_quiet()

 Documentation/btrfs-inspect-internal.asciidoc |  1 +
 cmds/inspect.c                                | 22 +++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/btrfs-inspect-internal.asciidoc b/Documentation/btrfs-inspect-internal.asciidoc
index 0718070d8905..e8d4c861603d 100644
--- a/Documentation/btrfs-inspect-internal.asciidoc
+++ b/Documentation/btrfs-inspect-internal.asciidoc
@@ -139,6 +139,7 @@ at 'path', ie. all hardlinks
 +
 -v::::
 verbose mode, print count of returned paths and ioctl() return value
+This option is merged to the global verbose option
 
 *logical-resolve* [-Pvo] [-s <bufsize>] <logical> <path>::
 (needs root privileges)
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 5b946da08b72..b0d3c8102400 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -56,12 +56,11 @@ static int __ino_to_path_fd(u64 inum, int fd, int verbose, const char *prepend)
 		goto out;
 	}
 
-	if (verbose)
-		printf("ioctl ret=%d, bytes_left=%lu, bytes_missing=%lu, "
-			"cnt=%d, missed=%d\n", ret,
-			(unsigned long)fspath->bytes_left,
-			(unsigned long)fspath->bytes_missing,
-			fspath->elem_cnt, fspath->elem_missed);
+	pr_verbose(1,
+	"ioctl ret=%d, bytes_left=%lu, bytes_missing=%lu cnt=%d, missed=%d\n",
+		   ret, (unsigned long)fspath->bytes_left,
+		   (unsigned long)fspath->bytes_missing, fspath->elem_cnt,
+		   fspath->elem_missed);
 
 	for (i = 0; i < fspath->elem_cnt; ++i) {
 		u64 ptr;
@@ -83,7 +82,9 @@ static const char * const cmd_inspect_inode_resolve_usage[] = {
 	"btrfs inspect-internal inode-resolve [-v] <inode> <path>",
 	"Get file system paths for the given inode",
 	"",
-	"-v   verbose mode",
+	"-v   verbose mode. This option is merged to the global verbose option",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -91,7 +92,6 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 				     int argc, char **argv)
 {
 	int fd;
-	int verbose = 0;
 	int ret;
 	DIR *dirstream = NULL;
 
@@ -103,7 +103,7 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			bconf_be_verbose();
 			break;
 		default:
 			usage_unknown_option(cmd, argv);
@@ -117,8 +117,8 @@ static int cmd_inspect_inode_resolve(const struct cmd_struct *cmd,
 	if (fd < 0)
 		return 1;
 
-	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd, verbose,
-			       argv[optind+1]);
+	ret = __ino_to_path_fd(arg_strtou64(argv[optind]), fd,
+			       bconf.verbose, argv[optind+1]);
 	close_file_or_dir(fd, dirstream);
 	return !!ret;
 
-- 
2.25.1

