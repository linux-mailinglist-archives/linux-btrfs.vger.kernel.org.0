Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90ECB108BE1
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfKYKjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:37730 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbfKYKjr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY6KZ021421
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=V6WayFPm4TW4qAUPvPra1ipLsS39NYdUI8cVB+f4nSE=;
 b=qILaWI1G9rrCJHfFBDeRA+OkjNJehATtZk7Po8FdDfOoAI08Sd5DVZPyqO2/lPzHK/L3
 d6sUep0BJyjouFaApOr22NrKKwa1LWptE7jYeMLMHid5I+Vm7necfJp4mYV1AiPXi2gb
 z777ZrgYu+yNl+DOA2qYsJOsQ3i5r9LxHqJ2vhUDZig4T3mFj/TxooeAuDEZrEKuJ/+A
 NVeZwXhgHNLqhYm1kL8OWHiLCrpm1b/9JqAKoMosZ/GbUS75Omw2W4UZavTeLI5Nt3vI
 enM4Q7qG5qAO/8tDS+++Qlz3Ld3bhKRO5k6QJmzQGaYr/NIu6oiZpmsfuE+eqw668aGZ 1Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wevqpxrxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAXIKa191737
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wfex64r0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:45 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAPAdj2n010838
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:45 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:44 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/16] btrfs-progs: rescue super-recover: use global verbose option
Date:   Mon, 25 Nov 2019 18:39:11 +0800
Message-Id: <1574678357-22222-11-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911250098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9451 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911250098
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
v2: Use new helper functions and defines
     HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
     bconf_be_verbose(), bconf_be_quiet()
    Drop verbose argument in btrfs_recover_superblocks()

 cmds/rescue-super-recover.c | 7 +++----
 cmds/rescue.c               | 7 ++++---
 cmds/rescue.h               | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

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
index 19de5235a22e..2e14c98ba911 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -107,6 +107,8 @@ static const char * const cmd_rescue_super_recover_usage[] = {
 	"",
 	"-y	Assume an answer of `yes' to all questions",
 	"-v	Verbose mode",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
 	NULL
 };
 
@@ -122,7 +124,6 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 				    int argc, char **argv)
 {
 	int ret;
-	int verbose = 0;
 	int yes = 0;
 	char *dname;
 
@@ -133,7 +134,7 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
 			break;
 		switch (c) {
 		case 'v':
-			verbose = 1;
+			bconf_be_verbose();
 			break;
 		case 'y':
 			yes = 1;
@@ -155,7 +156,7 @@ static int cmd_rescue_super_recover(const struct cmd_struct *cmd,
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
1.8.3.1

