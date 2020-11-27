Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251642C6C58
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Nov 2020 21:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgK0T6B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Nov 2020 14:58:01 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.251]:16047 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730832AbgK0Typ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Nov 2020 14:54:45 -0500
X-Greylist: delayed 723 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Nov 2020 14:54:33 EST
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 472194BB98
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Nov 2020 13:31:28 -0600 (CST)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id ijSqkEXceuDoAijSqkpWgn; Fri, 27 Nov 2020 13:31:28 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cxPF9r7TJ1ZNPalvmCjEm1iNV3uku0zoey/QWFeQ+Sg=; b=uAHYqKP671wjPXfOnFslbJgUhG
        FS7cxBdpAF+s44bo2cQTD410ZVs64zDXF4nuYqW1AT7JPf8VdD5obt4EX9WUsmTutQNlcSCe1HxIX
        7Dv0ld6HeGctyqqq96Qaevj5gQfrJHQxSRaOCNwYtwUeDqTgDxY19omWZeBRydIjDbZ4/9bqpYPcA
        tAoWcAKSE3Ov8NyYdhxpiWjZNP9dh/sUh4nvqh1YeVSnFczyjjDvH8MLuOedMQRsfmDUE8pX9+SNS
        VJZ2c5bdwLt/Sj0mF3VeyX+ndAeEjC3JibLrWjyGHcAC9/QatfjH3i68XWfCE6MC1ThY7TQOuiNu8
        DzbNqHXQ==;
Received: from 200.146.52.186.dynamic.dialup.gvt.net.br ([200.146.52.186]:60574 helo=localhost.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1kijSp-003Dm3-Lx; Fri, 27 Nov 2020 16:31:28 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>, wqu@suse.com,
        dsterba@suse.com
Subject: [PATCH v4 1/3] btrfs-progs: Adapt find_mount_root to verify other fields of mntent struct
Date:   Fri, 27 Nov 2020 16:30:33 -0300
Message-Id: <20201127193035.19171-2-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201127193035.19171-1-marcos@mpdesouza.com>
References: <20201127193035.19171-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 200.146.52.186
X-Source-L: No
X-Exim-ID: 1kijSp-003Dm3-Lx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 200.146.52.186.dynamic.dialup.gvt.net.br (localhost.suse.de) [200.146.52.186]:60574
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 8
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

Currently find_mount_root searches for all btrfs filesystems
mounted and comparing <path> with mnt_dir of each mountpoint.

But there are cases when we need to find the mountpoint for a determined
subvolid or subvol path, and these informations are present in mnt_opts
of mntent struct.

This patch adds two arguments to find_mount_root (data and flag). The
data argument hold the information that we want to compare, and the flag
argument specifies which field of mntent struct that we want to compare.
Currently there is only one flag, BTRFS_FIND_ROOT_PATH, implementing the
current behavior. The next patch will add a new flag to expand the functionality.

Users of find_mount_root were changed, having the data argument the same
as path, since they are only trying to find the mountpoint based on path alone.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 cmds/receive.c |  3 ++-
 cmds/send.c    |  6 ++++--
 common/utils.c | 15 ++++++++++++---
 common/utils.h |  8 +++++++-
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/cmds/receive.c b/cmds/receive.c
index 2aaba3ff..dc64480e 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1079,7 +1079,8 @@ static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
 	if (realmnt[0]) {
 		rctx->root_path = realmnt;
 	} else {
-		ret = find_mount_root(dest_dir_full_path, &rctx->root_path);
+		ret = find_mount_root(dest_dir_full_path, dest_dir_full_path,
+				BTRFS_FIND_ROOT_PATH, &rctx->root_path);
 		if (ret < 0) {
 			errno = -ret;
 			error("failed to determine mount point for %s: %m",
diff --git a/cmds/send.c b/cmds/send.c
index b8e3ba12..7757f0da 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -329,7 +329,8 @@ static int init_root_path(struct btrfs_send *sctx, const char *subvol)
 	if (sctx->root_path)
 		goto out;
 
-	ret = find_mount_root(subvol, &sctx->root_path);
+	ret = find_mount_root(subvol, subvol, BTRFS_FIND_ROOT_PATH,
+				&sctx->root_path);
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to determine mount point for %s: %m", subvol);
@@ -659,7 +660,8 @@ static int cmd_send(const struct cmd_struct *cmd, int argc, char **argv)
 			goto out;
 		}
 
-		ret = find_mount_root(subvol, &mount_root);
+		ret = find_mount_root(subvol, subvol, BTRFS_FIND_ROOT_PATH,
+					&mount_root);
 		if (ret < 0) {
 			errno = -ret;
 			error("find_mount_root failed on %s: %m", subvol);
diff --git a/common/utils.c b/common/utils.c
index 1253e87d..1c264455 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1248,7 +1248,7 @@ int ask_user(const char *question)
  * return 1 if a mount point is found but not btrfs
  * return <0 if something goes wrong
  */
-int find_mount_root(const char *path, char **mount_root)
+int find_mount_root(const char *path, const char *data, u8 flag, char **mount_root)
 {
 	FILE *mnttab;
 	int fd;
@@ -1258,6 +1258,10 @@ int find_mount_root(const char *path, char **mount_root)
 	int not_btrfs = 1;
 	int longest_matchlen = 0;
 	char *longest_match = NULL;
+	char *cmp_field = NULL;
+	bool found;
+
+	BUG_ON(flag != BTRFS_FIND_ROOT_PATH);
 
 	fd = open(path, O_RDONLY | O_NOATIME);
 	if (fd < 0)
@@ -1269,8 +1273,13 @@ int find_mount_root(const char *path, char **mount_root)
 		return -errno;
 
 	while ((ent = getmntent(mnttab))) {
-		len = strlen(ent->mnt_dir);
-		if (strncmp(ent->mnt_dir, path, len) == 0) {
+		cmp_field = ent->mnt_dir;
+
+		len = strlen(cmp_field);
+
+		found = strncmp(cmp_field, data, len) == 0;
+
+		if (found) {
 			/* match found and use the latest match */
 			if (longest_matchlen <= len) {
 				free(longest_match);
diff --git a/common/utils.h b/common/utils.h
index 119c3881..449e1d3e 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -52,6 +52,11 @@
 #define UNITS_HUMAN			(UNITS_HUMAN_BINARY)
 #define UNITS_DEFAULT			(UNITS_HUMAN)
 
+enum btrfs_find_root_flags {
+	/* check mnt_dir of mntent */
+	BTRFS_FIND_ROOT_PATH = 0
+};
+
 void units_set_mode(unsigned *units, unsigned mode);
 void units_set_base(unsigned *units, unsigned base);
 
@@ -93,7 +98,8 @@ int csum_tree_block(struct btrfs_fs_info *root, struct extent_buffer *buf,
 int ask_user(const char *question);
 int lookup_path_rootid(int fd, u64 *rootid);
 int get_btrfs_mount(const char *dev, char *mp, size_t mp_size);
-int find_mount_root(const char *path, char **mount_root);
+int find_mount_root(const char *path, const char *data, u8 flag,
+		char **mount_root);
 int get_device_info(int fd, u64 devid,
 		struct btrfs_ioctl_dev_info_args *di_args);
 int get_df(int fd, struct btrfs_ioctl_space_args **sargs_ret);
-- 
2.26.2

