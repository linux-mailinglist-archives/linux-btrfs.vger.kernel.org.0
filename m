Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F3E108BDA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 11:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfKYKji (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 05:39:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48084 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKYKji (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 05:39:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY71w006453
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=wOeQXj6sUizRIe+0KV1hHWNmepxdvWgK2U/mW75Qf0U=;
 b=LJaA7YI/VR0977Sz8kJiXgTbrGpq5o1jSY0BRDtS0c5sMwI2pn36H7n+896jTbcVJvkm
 BgKUb49/DVIsrTV1ZTIzW+MolvZe8Y5XzdnEaunSxm31X9Mztvjx4YnnCNX0anF5B1yd
 J9X4qa/3s1y8yDf88Cm1NUEktq4s3fZiMujsky4mapeWsQS5BFeVo/r8s0nNelX/fSQL
 aVmIp1rzOLx+EL7c30LK4Y+/YiXHtUkAvAhyVE71LXeR7qXL0eSyNeS357tANspv1t6F
 8aSbWFEW3ZwCEo9fsLhNhbF18r/ML8d7ojAkou0eGvDVIQOUIM9ZFQZENSAP7ox3/+Dz zA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wewdqxnnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAPAY1bq090650
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2wfe7yr60f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:36 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAPAdZT0017336
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 10:39:35 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Nov 2019 02:39:35 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/16] btrfs-progs: receive: use global verbose and quiet options
Date:   Mon, 25 Nov 2019 18:39:05 +0800
Message-Id: <1574678357-22222-5-git-send-email-anand.jain@oracle.com>
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

Transpire global --verbose and --quiet options down to the btrfs receive
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use new helper functions and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose(), bconf_be_quiet()

 cmds/receive.c | 80 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index c4827c1dd999..0e6f0e25fa51 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -53,12 +53,6 @@
 #include "common/help.h"
 #include "common/path-utils.h"
 
-/*
- * Default is 1 for historical reasons, changing may break scripts that expect
- * the 'At subvol' message.
- */
-static int g_verbose = 1;
-
 struct btrfs_receive
 {
 	int mnt_fd;
@@ -116,7 +110,7 @@ static int finish_subvol(struct btrfs_receive *rctx)
 	memcpy(rs_args.uuid, rctx->cur_subvol.received_uuid, BTRFS_UUID_SIZE);
 	rs_args.stransid = rctx->cur_subvol.stransid;
 
-	if (g_verbose >= 2) {
+	if (bconf.verbose >= 2) {
 		uuid_unparse((u8*)rs_args.uuid, uuid_str);
 		fprintf(stderr, "BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=%s, "
 				"stransid=%llu\n", uuid_str, rs_args.stransid);
@@ -199,13 +193,13 @@ static int process_subvol(const char *path, const u8 *uuid, u64 ctransid,
 		goto out;
 	}
 
-	if (g_verbose)
+	if (bconf.verbose > BTRFS_BCONF_QUIET)
 		fprintf(stderr, "At subvol %s\n", path);
 
 	memcpy(rctx->cur_subvol.received_uuid, uuid, BTRFS_UUID_SIZE);
 	rctx->cur_subvol.stransid = ctransid;
 
-	if (g_verbose >= 2) {
+	if (bconf.verbose >= 2) {
 		uuid_unparse((u8*)rctx->cur_subvol.received_uuid, uuid_str);
 		fprintf(stderr, "receiving subvol %s uuid=%s, stransid=%llu\n",
 				path, uuid_str,
@@ -269,13 +263,12 @@ static int process_snapshot(const char *path, const u8 *uuid, u64 ctransid,
 		goto out;
 	}
 
-	if (g_verbose)
-		fprintf(stdout, "At snapshot %s\n", path);
+	pr_verbose(1, "At snapshot %s\n", path);
 
 	memcpy(rctx->cur_subvol.received_uuid, uuid, BTRFS_UUID_SIZE);
 	rctx->cur_subvol.stransid = ctransid;
 
-	if (g_verbose >= 2) {
+	if (bconf.verbose >= 2) {
 		uuid_unparse((u8*)rctx->cur_subvol.received_uuid, uuid_str);
 		fprintf(stderr, "receiving snapshot %s uuid=%s, "
 				"ctransid=%llu ", path, uuid_str,
@@ -402,7 +395,7 @@ static int process_mkfile(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "mkfile %s\n", path);
 
 	ret = creat(full_path, 0600);
@@ -430,7 +423,7 @@ static int process_mkdir(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "mkdir %s\n", path);
 
 	ret = mkdir(full_path, 0700);
@@ -455,7 +448,7 @@ static int process_mknod(const char *path, u64 mode, u64 dev, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "mknod %s mode=%llu, dev=%llu\n",
 				path, mode, dev);
 
@@ -481,7 +474,7 @@ static int process_mkfifo(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "mkfifo %s\n", path);
 
 	ret = mkfifo(full_path, 0600);
@@ -506,7 +499,7 @@ static int process_mksock(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "mksock %s\n", path);
 
 	ret = mknod(full_path, 0600 | S_IFSOCK, 0);
@@ -531,7 +524,7 @@ static int process_symlink(const char *path, const char *lnk, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "symlink %s -> %s\n", path, lnk);
 
 	ret = symlink(lnk, full_path);
@@ -563,7 +556,7 @@ static int process_rename(const char *from, const char *to, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "rename %s -> %s\n", from, to);
 
 	ret = rename(full_from, full_to);
@@ -595,7 +588,7 @@ static int process_link(const char *path, const char *lnk, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "link %s -> %s\n", path, lnk);
 
 	ret = link(full_link_path, full_path);
@@ -621,7 +614,7 @@ static int process_unlink(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "unlink %s\n", path);
 
 	ret = unlink(full_path);
@@ -646,7 +639,7 @@ static int process_rmdir(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "rmdir %s\n", path);
 
 	ret = rmdir(full_path);
@@ -711,7 +704,7 @@ static int process_write(const char *path, const void *data, u64 offset,
 	if (ret < 0)
 		goto out;
 
-	if (g_verbose >= 2)
+	if (bconf.verbose >= 2)
 		fprintf(stderr, "write %s - offset=%llu length=%llu\n",
 			path, offset, len);
 
@@ -819,7 +812,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 		goto out;
 	}
 
-	if (g_verbose >= 2)
+	if (bconf.verbose >= 2)
 		fprintf(stderr,
 			"clone %s - source=%s source offset=%llu offset=%llu length=%llu\n",
 			path, clone_path, clone_offset, offset, len);
@@ -860,7 +853,7 @@ static int process_set_xattr(const char *path, const char *name,
 	}
 
 	if (strcmp("security.capability", name) == 0) {
-		if (g_verbose >= 4)
+		if (bconf.verbose >= 4)
 			fprintf(stderr, "set_xattr: cache capabilities\n");
 		if (rctx->cached_capabilities_len)
 			warning("capabilities set multiple times per file: %s",
@@ -875,7 +868,7 @@ static int process_set_xattr(const char *path, const char *name,
 		memcpy(rctx->cached_capabilities, data, len);
 	}
 
-	if (g_verbose >= 3) {
+	if (bconf.verbose >= 3) {
 		fprintf(stderr, "set_xattr %s - name=%s data_len=%d "
 				"data=%.*s\n", path, name, len,
 				len, (char*)data);
@@ -905,7 +898,7 @@ static int process_remove_xattr(const char *path, const char *name, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3) {
+	if (bconf.verbose >= 3) {
 		fprintf(stderr, "remove_xattr %s - name=%s\n",
 				path, name);
 	}
@@ -933,7 +926,7 @@ static int process_truncate(const char *path, u64 size, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "truncate %s size=%llu\n", path, size);
 
 	ret = truncate(full_path, size);
@@ -959,7 +952,7 @@ static int process_chmod(const char *path, u64 mode, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "chmod %s - mode=0%o\n", path, (int)mode);
 
 	ret = chmod(full_path, mode);
@@ -985,7 +978,7 @@ static int process_chown(const char *path, u64 uid, u64 gid, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "chown %s - uid=%llu, gid=%llu\n", path,
 				uid, gid);
 
@@ -997,7 +990,7 @@ static int process_chown(const char *path, u64 uid, u64 gid, void *user)
 	}
 
 	if (rctx->cached_capabilities_len) {
-		if (g_verbose >= 3)
+		if (bconf.verbose >= 3)
 			fprintf(stderr, "chown: restore capabilities\n");
 		ret = lsetxattr(full_path, "security.capability",
 				rctx->cached_capabilities,
@@ -1031,7 +1024,7 @@ static int process_utimes(const char *path, struct timespec *at,
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "utimes %s\n", path);
 
 	tv[0] = *at;
@@ -1050,7 +1043,7 @@ out:
 static int process_update_extent(const char *path, u64 offset, u64 len,
 		void *user)
 {
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "update_extent %s: offset=%llu, len=%llu\n",
 				path, (unsigned long long)offset,
 				(unsigned long long)len);
@@ -1190,7 +1183,7 @@ static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
 
 	while (!end) {
 		if (rctx->cached_capabilities_len) {
-			if (g_verbose >= 4)
+			if (bconf.verbose >= 4)
 				fprintf(stderr, "clear cached capabilities\n");
 			memset(rctx->cached_capabilities, 0,
 					sizeof(rctx->cached_capabilities));
@@ -1279,6 +1272,9 @@ static const char * const cmd_receive_usage[] = {
 	"                 this file system is mounted.",
 	"--dump           dump stream metadata, one line per operation,",
 	"                 does not require the MOUNT parameter",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -1301,6 +1297,18 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 	realmnt[0] = 0;
 	fromfile[0] = 0;
 
+	/*
+	 * Init global verbose to default, if it is unset.
+	 * Default is 1 for historical reasons, changing may break scripts that
+	 * expect the 'At subvol' message.
+	 * As default is 1, which means the effective verbose for receive is 2
+	 * which global verbose is unaware. So adjust global verbose value here.
+	 */
+	if (bconf.verbose == BTRFS_BCONF_UNSET)
+		bconf.verbose = 1;
+	else if (bconf.verbose > BTRFS_BCONF_QUIET)
+		bconf.verbose++;
+
 	optind = 0;
 	while (1) {
 		int c;
@@ -1319,10 +1327,10 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 
 		switch (c) {
 		case 'v':
-			g_verbose++;
+			bconf_be_verbose();
 			break;
 		case 'q':
-			g_verbose = 0;
+			bconf_be_quiet();
 			break;
 		case 'f':
 			if (arg_copy_path(fromfile, optarg, sizeof(fromfile))) {
-- 
1.8.3.1

