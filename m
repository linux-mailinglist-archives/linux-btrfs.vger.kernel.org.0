Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C149D1F7741
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 13:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgFLL0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 07:26:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41610 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFLL0O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 07:26:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBMiXT173737;
        Fri, 12 Jun 2020 11:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=4aKXhjMIQI7o+RbqWUwTbGlo4I1Q38IzxaVbH2dSZkU=;
 b=oxWqfhco3PM8yRGKWUlmWm1N0VMUQKEfzrC05N0zxc52Oz9cIyWIt0qZxvxo6o+dCSyu
 XFBj3/B7xAMyjpqx38Z3WBBNMfXepEEHh0+Ne/hl2UakXYfTy05cDbEgoZPVqlQbuFoe
 x812XRMAK7jxYSaOYo13lEzYZMD6zBFNBpXsRILm+TwYnskyUvT0DiBCUkDo8a3TYb7j
 E98Rbv99yMrPuGRQ1XlNQxQBXwXUPXhYwRERqvdWx/JJx/uYLtaMBAgjo+c+RQFQ5o1P
 mD9bUeuW9e456lA9Dc/5+33O2HxL7YZnEq+SqMjQqMLHhv9L/0KM6H1oB3/KItTR/Otf 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31g3sncfjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 11:26:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBO3Eu019733;
        Fri, 12 Jun 2020 11:26:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31m8rg867q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 11:26:10 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05CBQ9Yg003401;
        Fri, 12 Jun 2020 11:26:09 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 04:26:08 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 10/16] btrfs-progs: rescue super-recover: use global verbose option
Date:   Fri, 12 Jun 2020 19:25:59 +0800
Message-Id: <20200612112559.3849-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-11-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-11-git-send-email-anand.jain@oracle.com>
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

Transpire global --verbose option down to the btrfs rescue super-recover
sub-command.

For example: Both global and local verbose options are now supported.
btrfs -v|--verbose rescue super-recover
btrfs rescue super-recover -v

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: update help and documentation
v2: Use new helper functions and defines
     HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
     bconf_be_verbose(), bconf_be_quiet()
    Drop verbose argument in btrfs_recover_superblocks()

 Documentation/btrfs-rescue.asciidoc |  2 +-
 cmds/rescue-super-recover.c         |  7 +++----
 cmds/rescue.c                       | 10 ++++++----
 cmds/rescue.h                       |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/btrfs-rescue.asciidoc b/Documentation/btrfs-rescue.asciidoc
index 995515890e9e..b48c55189844 100644
--- a/Documentation/btrfs-rescue.asciidoc
+++ b/Documentation/btrfs-rescue.asciidoc
@@ -58,7 +58,7 @@ Recover bad superblocks from good copies.
 -y::::
 assume an answer of 'yes' to all questions.
 -v::::
-verbose mode.
+verbose mode. This option is merged to the global verbose option.
 
 *zero-log* <device>::
 clear the filesystem log tree
diff --git a/cmds/rescue-super-recover.c b/cmds/rescue-super-recover.c
index 5d6bea836c8b..3a60eb40c8bb 100644
--- a/cmds/rescue-super-recover.c
+++ b/cmds/rescue-super-recover.c
@@ -226,8 +226,7 @@ static void recover_err_str(int ret)
 	}
 }
 
-int btrfs_recover_superblocks(const char *dname,
-			int verbose, int yes)
+int btrfs_recover_superblocks(const char *dname, int yes)
 {
 	int fd, ret;
 	struct btrfs_recover_superblock recover;
@@ -249,7 +248,7 @@ int btrfs_recover_superblocks(const char *dname,
 		goto no_recover;
 	}
 
-	if (verbose)
+	if (bconf.verbose > BTRFS_BCONF_QUIET)
 		print_all_devices(&recover.fs_devices->devices);
 
 	ret = read_fs_supers(&recover);
@@ -257,7 +256,7 @@ int btrfs_recover_superblocks(const char *dname,
 		ret = 1;
 		goto no_recover;
 	}
-	if (verbose) {
+	if (bconf.verbose > BTRFS_BCONF_QUIET) {
 		printf("Before Recovering:\n");
 		print_all_supers(&recover);
 	}
diff --git a/cmds/rescue.c b/cmds/rescue.c
index bb65a672bbf3..1d53cf446a96 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -107,7 +107,10 @@ static const char * const cmd_rescue_super_recover_usage[] = {
 	"Recover bad superblocks from good copies",
 	"",
 	"-y	Assume an answer of `yes' to all questions",
-	"-v	Verbose mode",
+	"-v	Verbose mode. This option is merged to the global verbose",
+	"	option",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -123,7 +126,6 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 				    int argc, char **argv)
 {
 	int ret;
-	int verbose = 0;
 	int yes = 0;
 	char *dname;
 
@@ -134,7 +136,7 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 			break;
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			bconf_be_verbose();
 			break;
 		case 'y':
 			yes = 1;
@@ -156,7 +158,7 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 		error("the device is busy");
 		return 1;
 	}
-	ret = btrfs_recover_superblocks(dname, verbose, yes);
+	ret = btrfs_recover_superblocks(dname, yes);
 	return ret;
 }
 static DEFINE_SIMPLE_COMMAND(rescue_super_recover, "super-recover");
diff --git a/cmds/rescue.h b/cmds/rescue.h
index e594954f78e2..3b99ec6b0daa 100644
--- a/cmds/rescue.h
+++ b/cmds/rescue.h
@@ -15,7 +15,7 @@
 #ifndef __BTRFS_RESCUE_H__
 #define __BTRFS_RESCUE_H__
 
-int btrfs_recover_superblocks(const char *path, int verbose, int yes);
+int btrfs_recover_superblocks(const char *path, int yes);
 int btrfs_recover_chunk_tree(const char *path, int yes);
 
 #endif
-- 
2.25.1

