Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 746D5D7634
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 14:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfJOMOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 08:14:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:34690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfJOMOK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 08:14:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91DDDACA4
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 12:14:07 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 1/2] btrfs: add authentication support
Date:   Tue, 15 Oct 2019 14:14:04 +0200
Message-Id: <20191015121405.19066-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add authentication support for a BTRFS file-system.

This works, because in BTRFS every meta-data block as well as every
data-block has a own checksum. For meta-data the checksum is in the
meta-data node itself. For data blocks, the checksums are stored in the
checksum tree.

When replacing the checksum algorithm with a keyed hash, like HMAC(SHA256),
a key is needed to mount a verified file-system. This key also needs to be
used at file-system creation time.

We have to used a keyed hash scheme, in contrast to doing a normal
cryptographic hash, to guarantee integrity of the file system, as a
potential attacker could just replay file-system operations and the
changes would go unnoticed.

Having a keyed hash only on the topmost Node of a tree or even just in the
super-block and using cryptographic hashes on the normal meta-data nodes
and checksum tree entries doesn't work either, as the BTRFS B-Tree's Nodes
do not include the checksums of their respective child nodes, but only the
block pointers and offsets where to find them on disk.

Also note, we do not need a incompat R/O flag for this, because if an old
kernel tries to mount an authenticated file-system it will fail the
initial checksum type verification and thus refuses to mount.

The key has to be supplied by the kernel's keyring and the method of
getting the key securely into the kernel is not subject of this patch.

Example usage:
keyctl add logon btrfs:foo 0123456 @u
mkfs.btrfs --csum hmac-sha256 --auth-key 0123456 /dev/disk
mount -t btrfs -o auth_key=btrfs:foo /dev/disk /mnt/point

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/ctree.c                |  1 +
 fs/btrfs/ctree.h                |  2 ++
 fs/btrfs/disk-io.c              | 53 ++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/super.c                | 24 ++++++++++++++++---
 include/uapi/linux/btrfs_tree.h |  1 +
 5 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3a4d8e27e565..b6fbf68930ea 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -34,6 +34,7 @@ static const struct btrfs_csums {
 	const char	*name;
 } btrfs_csums[] = {
 	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
+	[BTRFS_CSUM_TYPE_HMAC_SHA256] = { .size = 32, .name = "hmac(sha256)" }
 };
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d17e79a40930..16a67bfa540c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -892,6 +892,7 @@ struct btrfs_fs_info {
 	struct rb_root swapfile_pins;
 
 	struct crypto_shash *csum_shash;
+	char *auth_key_name;
 
 	/*
 	 * Number of send operations in progress.
@@ -1190,6 +1191,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_FREE_SPACE_TREE	(1 << 26)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
+#define BTRFS_MOUNT_AUTH_KEY		(1 << 29)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 074fc310c7b5..8accf12e4541 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -18,6 +18,7 @@
 #include <linux/error-injection.h>
 #include <linux/crc32c.h>
 #include <linux/sched/mm.h>
+#include <keys/user-type.h>
 #include <asm/unaligned.h>
 #include <crypto/hash.h>
 #include "ctree.h"
@@ -352,6 +353,7 @@ static bool btrfs_supported_super_csum(u16 csum_type)
 {
 	switch (csum_type) {
 	case BTRFS_CSUM_TYPE_CRC32:
+	case BTRFS_CSUM_TYPE_HMAC_SHA256:
 		return true;
 	default:
 		return false;
@@ -2224,6 +2226,9 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 {
 	struct crypto_shash *csum_shash;
 	const char *csum_name = btrfs_super_csum_name(csum_type);
+	struct key *key;
+	const struct user_key_payload *ukp;
+	int err = 0;
 
 	csum_shash = crypto_alloc_shash(csum_name, 0, 0);
 
@@ -2235,7 +2240,53 @@ static int btrfs_init_csum_hash(struct btrfs_fs_info *fs_info, u16 csum_type)
 
 	fs_info->csum_shash = csum_shash;
 
-	return 0;
+	/*
+	 * if we're not doing authentication, we're done by now. Still we have
+	 * to validate the possible combinations of BTRFS_MOUNT_AUTH_KEY and
+	 * keyed hashes.
+	 */
+	if (csum_type == BTRFS_CSUM_TYPE_HMAC_SHA256 &&
+	    !btrfs_test_opt(fs_info, AUTH_KEY)) {
+		crypto_free_shash(fs_info->csum_shash);
+		return -EINVAL;
+	} else if (btrfs_test_opt(fs_info, AUTH_KEY)
+		   && csum_type != BTRFS_CSUM_TYPE_HMAC_SHA256) {
+		crypto_free_shash(fs_info->csum_shash);
+		return -EINVAL;
+	} else if (!btrfs_test_opt(fs_info, AUTH_KEY)) {
+		/*
+		 * This is the normal case, if noone want's authentication and
+		 * doesn't have a keyed hash, we're done.
+		 */
+		return 0;
+	}
+
+	key = request_key(&key_type_logon, fs_info->auth_key_name, NULL);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	down_read(&key->sem);
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp) {
+		btrfs_err(fs_info, "");
+		err = -EKEYREVOKED;
+		goto out;
+	}
+
+	err = crypto_shash_setkey(fs_info->csum_shash, ukp->data, ukp->datalen);
+	if (err)
+		btrfs_err(fs_info, "error setting key %s for verification",
+			  fs_info->auth_key_name);
+
+out:
+	if (err)
+		crypto_free_shash(fs_info->csum_shash);
+
+	up_read(&key->sem);
+	key_put(key);
+
+	return err;
 }
 
 static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d5d15a19f51d..313ef7fc2bdf 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -329,6 +329,7 @@ enum {
 	Opt_treelog, Opt_notreelog,
 	Opt_usebackuproot,
 	Opt_user_subvol_rm_allowed,
+	Opt_auth_key,
 
 	/* Deprecated options */
 	Opt_alloc_start,
@@ -396,6 +397,7 @@ static const match_table_t tokens = {
 	{Opt_notreelog, "notreelog"},
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
+	{Opt_auth_key, "auth_key=%s"},
 
 	/* Deprecated options */
 	{Opt_alloc_start, "alloc_start=%s"},
@@ -891,7 +893,8 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
  * All other options will be parsed on much later in the mount process and
  * only when we need to allocate a new super block.
  */
-static int btrfs_parse_device_options(const char *options, fmode_t flags,
+static int btrfs_parse_device_options(struct btrfs_fs_info *info,
+				      const char *options, fmode_t flags,
 				      void *holder)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -920,7 +923,8 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
 			continue;
 
 		token = match_token(p, tokens, args);
-		if (token == Opt_device) {
+		switch (token) {
+		case Opt_device:
 			device_name = match_strdup(&args[0]);
 			if (!device_name) {
 				error = -ENOMEM;
@@ -933,6 +937,18 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
 				error = PTR_ERR(device);
 				goto out;
 			}
+			break;
+		case Opt_auth_key:
+			info->auth_key_name = match_strdup(&args[0]);
+			if (!info->auth_key_name) {
+				error = -ENOMEM;
+				goto out;
+			}
+			btrfs_info(info, "doing authentication");
+			btrfs_set_opt(info->mount_opt, AUTH_KEY);
+			break;
+		default:
+			break;
 		}
 	}
 
@@ -1369,6 +1385,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	if (btrfs_test_opt(info, AUTH_KEY))
+		seq_printf(seq, ",auth_key=%s", info->auth_key_name);
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	seq_puts(seq, ",subvol=");
@@ -1514,7 +1532,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 
 	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_device_options(data, mode, fs_type);
+	error = btrfs_parse_device_options(fs_info, data, mode, fs_type);
 	if (error) {
 		mutex_unlock(&uuid_mutex);
 		goto error_fs_info;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index b65c7ee75bc7..91512d053ede 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -302,6 +302,7 @@
 /* csum types */
 enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_CRC32	= 0,
+	BTRFS_CSUM_TYPE_HMAC_SHA256 = 32, // DUMMY!
 };
 
 /*
-- 
2.16.4

