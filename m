Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8A1F775C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jun 2020 13:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFLLfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Jun 2020 07:35:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46340 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgFLLfA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Jun 2020 07:35:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBQZ3J176461;
        Fri, 12 Jun 2020 11:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=TxhHsVS7JiRPV5GZo9g0D9Xuktfu5EtKcDZqxWyb9ww=;
 b=GeWaKB9V9giXl0FKymy/bcFGb0iA4ELgQCUccZLSKbdIDSOKRybQhkwaEv+BIVjT0zcG
 nMtJP5MY9y7dVOy242iFTQMQO+l2rEB6afuxhIzkIXXW3ioqoy21nq8OENUaSqMTbJbN
 3kogjNADz18vxDGMxeRF9bRNuzygMMnckQ6RoDqiqiw2h928TduLQEtBO5Nw6cERkC/I
 pIMNHf25XblI4IHBgV8T/xl4xj+8a0PFRt/T2GncZ/attmpWPXAxGQb0yjk9h47DuHdG
 BoER7Rj7aJQkpreYOmF/aXfBpibTcwPmvgelr/sscNkLviaVTG95GXwNRviWKXcQIxh8 kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3sncg4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 11:34:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CBWWWV067336;
        Fri, 12 Jun 2020 11:34:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31m8x3r57h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 11:34:54 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CBOqN9025067;
        Fri, 12 Jun 2020 11:24:52 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 04:24:51 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v3 04/16] btrfs-progs: receive: use global verbose and quiet options
Date:   Fri, 12 Jun 2020 19:24:44 +0800
Message-Id: <20200612112444.3511-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1574678357-22222-5-git-send-email-anand.jain@oracle.com>
References: <1574678357-22222-5-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=1 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120086
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

Transpire global --verbose and --quiet options down to the btrfs receive
sub-command.

Suggested-by: David Sterba <dsterba@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Updae the help and documentation
v2: Use new helper functions and defines
    HELPINFO_INSERT_GLOBALS, BTRFS_BCONF_UNSET, BTRFS_BCONF_QUIET
    bconf_be_verbose(), bconf_be_quiet()

 Documentation/btrfs-receive.asciidoc |  6 +-
 cmds/receive.c                       | 86 ++++++++++++++++------------
 2 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/Documentation/btrfs-receive.asciidoc b/Documentation/btrfs-receive.asciidoc
index a271d89b9d7d..aed08ba5e705 100644
--- a/Documentation/btrfs-receive.asciidoc
+++ b/Documentation/btrfs-receive.asciidoc
@@ -36,10 +36,12 @@ A subvolume is made read-only after the receiving process finishes successfully
 `Options`
 
 -v::
-increase verbosity about performed actions, print details about each operation
+increase verbosity about performed actions, print details about each operation.
+This option is merged to the global verbose option.
 
 -q|--quiet::
-suppress all messages except errors
+suppress all messages except errors. This option is merged to the global quiet option.
+
 
 -f <FILE>::
 read the stream from <FILE> instead of stdin,
diff --git a/cmds/receive.c b/cmds/receive.c
index 74b73f488a0d..95fc09b8ce9f 100644
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
@@ -393,7 +386,7 @@ static int process_mkfile(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "mkfile %s\n", path);
 
 	ret = creat(full_path, 0600);
@@ -421,7 +414,7 @@ static int process_mkdir(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "mkdir %s\n", path);
 
 	ret = mkdir(full_path, 0700);
@@ -446,7 +439,7 @@ static int process_mknod(const char *path, u64 mode, u64 dev, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "mknod %s mode=%llu, dev=%llu\n",
 				path, mode, dev);
 
@@ -472,7 +465,7 @@ static int process_mkfifo(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "mkfifo %s\n", path);
 
 	ret = mkfifo(full_path, 0600);
@@ -497,7 +490,7 @@ static int process_mksock(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "mksock %s\n", path);
 
 	ret = mknod(full_path, 0600 | S_IFSOCK, 0);
@@ -522,7 +515,7 @@ static int process_symlink(const char *path, const char *lnk, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "symlink %s -> %s\n", path, lnk);
 
 	ret = symlink(lnk, full_path);
@@ -554,7 +547,7 @@ static int process_rename(const char *from, const char *to, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "rename %s -> %s\n", from, to);
 
 	ret = rename(full_from, full_to);
@@ -586,7 +579,7 @@ static int process_link(const char *path, const char *lnk, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "link %s -> %s\n", path, lnk);
 
 	ret = link(full_link_path, full_path);
@@ -612,7 +605,7 @@ static int process_unlink(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "unlink %s\n", path);
 
 	ret = unlink(full_path);
@@ -637,7 +630,7 @@ static int process_rmdir(const char *path, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "rmdir %s\n", path);
 
 	ret = rmdir(full_path);
@@ -702,7 +695,7 @@ static int process_write(const char *path, const void *data, u64 offset,
 	if (ret < 0)
 		goto out;
 
-	if (g_verbose >= 2)
+	if (bconf.verbose >= 2)
 		fprintf(stderr, "write %s - offset=%llu length=%llu\n",
 			path, offset, len);
 
@@ -792,7 +785,7 @@ static int process_clone(const char *path, u64 offset, u64 len,
 		goto out;
 	}
 
-	if (g_verbose >= 2)
+	if (bconf.verbose >= 2)
 		fprintf(stderr,
 			"clone %s - source=%s source offset=%llu offset=%llu length=%llu\n",
 			path, clone_path, clone_offset, offset, len);
@@ -833,7 +826,7 @@ static int process_set_xattr(const char *path, const char *name,
 	}
 
 	if (strcmp("security.capability", name) == 0) {
-		if (g_verbose >= 4)
+		if (bconf.verbose >= 4)
 			fprintf(stderr, "set_xattr: cache capabilities\n");
 		if (rctx->cached_capabilities_len)
 			warning("capabilities set multiple times per file: %s",
@@ -848,7 +841,7 @@ static int process_set_xattr(const char *path, const char *name,
 		memcpy(rctx->cached_capabilities, data, len);
 	}
 
-	if (g_verbose >= 3) {
+	if (bconf.verbose >= 3) {
 		fprintf(stderr, "set_xattr %s - name=%s data_len=%d "
 				"data=%.*s\n", path, name, len,
 				len, (char*)data);
@@ -878,7 +871,7 @@ static int process_remove_xattr(const char *path, const char *name, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3) {
+	if (bconf.verbose >= 3) {
 		fprintf(stderr, "remove_xattr %s - name=%s\n",
 				path, name);
 	}
@@ -906,7 +899,7 @@ static int process_truncate(const char *path, u64 size, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "truncate %s size=%llu\n", path, size);
 
 	ret = truncate(full_path, size);
@@ -932,7 +925,7 @@ static int process_chmod(const char *path, u64 mode, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "chmod %s - mode=0%o\n", path, (int)mode);
 
 	ret = chmod(full_path, mode);
@@ -958,7 +951,7 @@ static int process_chown(const char *path, u64 uid, u64 gid, void *user)
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "chown %s - uid=%llu, gid=%llu\n", path,
 				uid, gid);
 
@@ -970,7 +963,7 @@ static int process_chown(const char *path, u64 uid, u64 gid, void *user)
 	}
 
 	if (rctx->cached_capabilities_len) {
-		if (g_verbose >= 3)
+		if (bconf.verbose >= 3)
 			fprintf(stderr, "chown: restore capabilities\n");
 		ret = lsetxattr(full_path, "security.capability",
 				rctx->cached_capabilities,
@@ -1004,7 +997,7 @@ static int process_utimes(const char *path, struct timespec *at,
 		goto out;
 	}
 
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "utimes %s\n", path);
 
 	tv[0] = *at;
@@ -1023,7 +1016,7 @@ out:
 static int process_update_extent(const char *path, u64 offset, u64 len,
 		void *user)
 {
-	if (g_verbose >= 3)
+	if (bconf.verbose >= 3)
 		fprintf(stderr, "update_extent %s: offset=%llu, len=%llu\n",
 				path, (unsigned long long)offset,
 				(unsigned long long)len);
@@ -1163,7 +1156,7 @@ static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
 
 	while (!end) {
 		if (rctx->cached_capabilities_len) {
-			if (g_verbose >= 4)
+			if (bconf.verbose >= 4)
 				fprintf(stderr, "clear cached capabilities\n");
 			memset(rctx->cached_capabilities, 0,
 					sizeof(rctx->cached_capabilities));
@@ -1236,8 +1229,10 @@ static const char * const cmd_receive_usage[] = {
 	"After receiving a subvolume, it is immediately set to",
 	"read-only.",
 	"",
-	"-v               increase verbosity about performed actions",
-	"-q|--quiet       suppress all messages, except errors",
+	"-v               increase verbosity about performed actions. This",
+	"                 option is merged to the global verbose option.",
+	"-q|--quiet       suppress all messages, except errors. This option",
+	"                 is merged with the global quiet option.",
 	"-f FILE          read the stream from FILE instead of stdin",
 	"-e               terminate after receiving an <end cmd> marker in the stream.",
 	"                 Without this option the receiver side terminates only in case",
@@ -1252,6 +1247,9 @@ static const char * const cmd_receive_usage[] = {
 	"                 this file system is mounted.",
 	"--dump           dump stream metadata, one line per operation,",
 	"                 does not require the MOUNT parameter",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_VERBOSE,
+	HELPINFO_INSERT_QUIET,
 	NULL
 };
 
@@ -1274,6 +1272,18 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
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
@@ -1292,10 +1302,10 @@ static int cmd_receive(const struct cmd_struct *cmd, int argc, char **argv)
 
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
2.25.1

