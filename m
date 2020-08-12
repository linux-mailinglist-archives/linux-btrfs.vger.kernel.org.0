Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BC9242DBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 19:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLQ7x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 12:59:53 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.140]:39410 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgHLQ7s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 12:59:48 -0400
X-Greylist: delayed 1339 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Aug 2020 12:59:46 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 2F6AC400C558C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Aug 2020 11:37:23 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id 5tkhkxhD8LFNk5tkhkaVkN; Wed, 12 Aug 2020 11:37:23 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6FGHWWXb/MGjXq8U4VgD2UjQWH5uFdWjIYENLmVnFlw=; b=Mgjo1jqk4WdufPjC3IMfszB7+W
        or5u5k3u8vTakAXrXwGe4QKfTHdv4KpWIV/LVGda4pnLIzD2F/cRL+Yam2s1u7utRnr9QOA1ttMPb
        aZy/XVhxYAXjTX6sIdlZN+iV765dRNu2qY0ntpdhYKIXf+zdh0eXOFM6kGG7Ucico04wnDeUz/DIR
        BFDB58zE05hcK1Y/PSUS9WnT5Bkn0Lmoqg7AlS96eri7xC+1NWm50mlvWfF7bLFoZtmn0eU6TgPe1
        jzMCyACpfrD+xRqKGEUHYemwH1qAiOniEaULZthNA6cmEGmNR5Npydm4s5DNA9TNMbuOKGcMgvo10
        u17rdNpw==;
Received: from [179.185.221.211] (port=55300 helo=hephaestus.suse.de)
        by br540.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <marcos@mpdesouza.com>)
        id 1k5tkg-004J9r-Ge; Wed, 12 Aug 2020 13:37:22 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [RFC PATCH 7/8] btrfs: Convert to fs_context
Date:   Wed, 12 Aug 2020 13:36:53 -0300
Message-Id: <20200812163654.17080-8-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812163654.17080-1-marcos@mpdesouza.com>
References: <20200812163654.17080-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 179.185.221.211
X-Source-L: No
X-Exim-ID: 1k5tkg-004J9r-Ge
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.suse.de) [179.185.221.211]:55300
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 23
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

This commit makes btrfs full use of the fs_context API. It's heavily
based in David Howells POC when fs_context was introduced[1]. As
fs_context divides the mount procedure into different steps, the btrfs
code needed to be rearranged in order to store the mount points and
other properties without having a fs_info already allocated.

The btrfs_fs_context struct is the responsible struct for storing the
options used to mount the fs, and these options are set to
fs_info->mount_opts in btrfs_apply_configuration.

Some notable changes:
* There is no need for a second file_system_type anymore. Now we use a
  special flag in btrfs_fs_context to identify the mount of the root
  subvol before mounting the specified subvol.
* With the introduction of fs_context all mount options are parsed
  _before_ doing the mount procedure. In our case, btrfs_fc_parse_param
  is the function being called to parse all options, making
  btrfs_parse_device_options, btrfs_parse_subvol_options
  btrfs_parse_options obsolete.
* Function btrfs_mount_root was renamed to btrfs_root_get_tree to
  reflect that fs_context is being used.
* Function btrfs_remount was renamed to btrfs_reconfigure by the same
  reason from above.
* Function btrfs_mount was renamed to btrfs_get_tree, and this function
  is called by vfs after all the mount options are parsed.
* There is no need for btrfs_root_fs_type anymore, and so fs_info->bdev_holder
  can also be removed.

Functions like open_ctree and btrfs_fill_super are now using a
fs_context argument instead of other btrfs related structs, since
the fs_context->fs_private contains a btrfs_fs_context that holds
the necessary data.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=Q46&id=554cb2019cda83e1aba10bd9eea485afd2ddb983

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ctree.h       |   1 +
 fs/btrfs/dev-replace.c |   2 +-
 fs/btrfs/disk-io.c     |  10 +-
 fs/btrfs/disk-io.h     |   4 +-
 fs/btrfs/super.c       | 347 ++++++++++++++++++++---------------------
 fs/btrfs/volumes.c     |   6 +-
 6 files changed, 178 insertions(+), 192 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d96bce2ea5bb..9060be6a6c6e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3100,6 +3100,7 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root);
 
 /* super.c */
+extern struct file_system_type btrfs_fs_type;
 int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			unsigned long new_flags);
 int btrfs_apply_configuration(struct fs_context *fc, struct super_block *sb);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index db93909b25e0..9a3275845b13 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -236,7 +236,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	}
 
 	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
-				  fs_info->bdev_holder);
+				  &btrfs_fs_type);
 	if (IS_ERR(bdev)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
 		return PTR_ERR(bdev);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c850d7f44fbe..f2e7543e9913 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2894,8 +2894,7 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices,
-		      char *options)
+int __cold open_ctree(struct fs_context *fc, struct super_block *sb)
 {
 	u32 sectorsize;
 	u32 nodesize;
@@ -2905,6 +2904,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	u16 csum_type;
 	struct btrfs_super_block *disk_super;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_root *tree_root;
 	struct btrfs_root *chunk_root;
 	int ret;
@@ -3030,11 +3030,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	fs_info->compress_type = BTRFS_COMPRESS_ZLIB;
 
-	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
-	if (ret) {
-		err = ret;
+	err = btrfs_apply_configuration(fc, sb);
+	if (err)
 		goto fail_alloc;
-	}
 
 	features = btrfs_super_incompat_flags(disk_super) &
 		~BTRFS_FEATURE_INCOMPAT_SUPP;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 00dc39d47ed3..712ea61ffdfe 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -50,9 +50,7 @@ struct extent_buffer *btrfs_find_create_tree_block(
 						struct btrfs_fs_info *fs_info,
 						u64 bytenr);
 void btrfs_clean_tree_block(struct extent_buffer *buf);
-int __cold open_ctree(struct super_block *sb,
-	       struct btrfs_fs_devices *fs_devices,
-	       char *options);
+int __cold open_ctree(struct fs_context *fc, struct super_block *sb);
 void __cold close_ctree(struct btrfs_fs_info *fs_info);
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
 struct btrfs_super_block *btrfs_read_dev_super(struct block_device *bdev);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5bbf4b947125..d9a0faea8c88 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -63,10 +63,9 @@ static const struct super_operations btrfs_super_ops;
  *
  * The new btrfs_root_fs_type also servers as a tag for the bdev_holder.
  */
-static struct file_system_type btrfs_fs_type;
 static struct file_system_type btrfs_root_fs_type;
 
-static int btrfs_remount(struct super_block *sb, int *flags, char *data);
+static int btrfs_reconfigure(struct fs_context *fc);
 
 /*
  * Generally the error codes correspond to their respective errors, but there
@@ -1542,7 +1541,7 @@ static int btrfs_parse_device_options(const char *options, fmode_t flags,
 				goto out;
 			}
 			device = btrfs_scan_one_device(device_name, flags,
-					holder);
+							&btrfs_fs_type);
 			kfree(device_name);
 			if (IS_ERR(device)) {
 				error = PTR_ERR(device);
@@ -1795,13 +1794,13 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	return 0;
 }
 
-static int btrfs_fill_super(struct super_block *sb,
-			    struct btrfs_fs_devices *fs_devices,
-			    void *data)
+static int btrfs_fill_super(struct fs_context *fc,
+			struct super_block *sb,
+			struct btrfs_fs_devices *fs_devices)
 {
+	int err;
 	struct inode *inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	int err;
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_magic = BTRFS_SUPER_MAGIC;
@@ -1810,9 +1809,6 @@ static int btrfs_fill_super(struct super_block *sb,
 	sb->s_export_op = &btrfs_export_ops;
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-#ifdef CONFIG_BTRFS_FS_POSIX_ACL
-	sb->s_flags |= SB_POSIXACL;
-#endif
 	sb->s_flags |= SB_I_VERSION;
 	sb->s_iflags |= SB_I_CGROUPWB;
 
@@ -1822,7 +1818,7 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
-	err = open_ctree(sb, fs_devices, (char *)data);
+	err = open_ctree(fc, sb);
 	if (err) {
 		btrfs_err(fs_info, "open_ctree failed");
 		return err;
@@ -1951,19 +1947,20 @@ int btrfs_apply_configuration(struct fs_context *fc,
 #endif
 
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
-       if (btrfs_test_exp_opt(ctx, REF_VERIFY))
-               btrfs_info(info, "doing ref verification");
+	if (btrfs_test_exp_opt(ctx, REF_VERIFY))
+		btrfs_info(info, "doing ref verification");
 #endif
 
+	info->pending_changes = ctx->pending_changes;
 	if (btrfs_test_exp_opt(ctx, INODE_MAP_CACHE)) {
-		if (btrfs_opt_map[Opt_inode_cache].enabled) {
-		       btrfs_clear_pending_and_info(info, INODE_MAP_CACHE,
-				       "disabling inode map caching");
+		if (!btrfs_opt_map[Opt_inode_cache].enabled) {
+			btrfs_clear_pending_and_info(info, INODE_MAP_CACHE,
+						"disabling inode map caching");
 		} else {
 			btrfs_info(info,
 				"the 'inode_cache' option is deprecated and will have no effect from 5.11");
 			btrfs_set_pending_and_info(info, INODE_MAP_CACHE,
-				       "enabling inode map caching");
+						"enabling inode map caching");
 		}
 	}
 
@@ -2015,10 +2012,9 @@ int btrfs_apply_configuration(struct fs_context *fc,
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE)) {
 		bool opt_clear = btrfs_test_opt(ctx, CLEAR_CACHE);
 		bool opt_cache_v1 = btrfs_test_opt(ctx, SPACE_CACHE);
-		bool no_space_cache = ctx->nospace_cache;
 
-		if ((no_space_cache && !opt_clear) || (opt_cache_v1 && !opt_clear)) {
-			btrfs_err(info, "cannot disable free space tree XX");
+		if ((ctx->nospace_cache && !opt_clear) || (opt_cache_v1 && !opt_clear)) {
+			btrfs_err(info, "cannot disable free space tree");
 			return -EINVAL;
 		}
 	}
@@ -2063,7 +2059,6 @@ int btrfs_apply_configuration(struct fs_context *fc,
 
 	info->compress_type = ctx->compress_type;
 	info->compress_level = ctx->compress_level;
-	info->pending_changes = ctx->pending_changes;
 	info->mount_opt = ctx->mount_opt;
 
 	return 0;
@@ -2213,9 +2208,9 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 	return 0;
 }
 
-static int btrfs_test_super(struct super_block *s, void *data)
+static int btrfs_test_super(struct super_block *s, struct fs_context *fc)
 {
-	struct btrfs_fs_info *p = data;
+	struct btrfs_fs_info *p = fc->s_fs_info;
 	struct btrfs_fs_info *fs_info = btrfs_sb(s);
 
 	return fs_info->fs_devices == p->fs_devices;
@@ -2239,34 +2234,34 @@ static inline int is_subvolume_inode(struct inode *inode)
 	return 0;
 }
 
-static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
-				   struct vfsmount *mnt)
+static int mount_subvol(struct fs_context *fc)
 {
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct vfsmount *mnt = ctx->root_mnt;
 	struct dentry *root;
 	int ret;
 
-	if (!subvol_name) {
-		if (!subvol_objectid) {
+	if (!ctx->subvol_name) {
+		char *subvol_name;
+
+		if (!ctx->subvolid) {
 			ret = get_default_subvol_objectid(btrfs_sb(mnt->mnt_sb),
-							  &subvol_objectid);
-			if (ret) {
-				root = ERR_PTR(ret);
-				goto out;
-			}
+							  &ctx->subvolid);
+			if (ret)
+				return ret;
 		}
 		subvol_name = btrfs_get_subvol_name_from_objectid(
-					btrfs_sb(mnt->mnt_sb), subvol_objectid);
-		if (IS_ERR(subvol_name)) {
-			root = ERR_CAST(subvol_name);
-			subvol_name = NULL;
-			goto out;
-		}
+							btrfs_sb(mnt->mnt_sb),
+							ctx->subvolid);
+		if (IS_ERR(subvol_name))
+			return PTR_ERR(subvol_name);
 
+		ctx->subvol_name = subvol_name;
 	}
 
-	root = mount_subtree(mnt, subvol_name);
-	/* mount_subtree() drops our reference on the vfsmount. */
-	mnt = NULL;
+	root = mount_subtree(mnt, ctx->subvol_name);
+	/* mount_subtree() dropped our reference on the vfsmount. */
+	ctx->root_mnt = NULL;
 
 	if (!IS_ERR(root)) {
 		struct super_block *s = root->d_sb;
@@ -2277,10 +2272,10 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 		ret = 0;
 		if (!is_subvolume_inode(root_inode)) {
 			btrfs_err(fs_info, "'%s' is not a valid subvolume",
-			       subvol_name);
+			       ctx->subvol_name);
 			ret = -EINVAL;
 		}
-		if (subvol_objectid && root_objectid != subvol_objectid) {
+		if (ctx->subvolid && root_objectid != ctx->subvolid) {
 			/*
 			 * This will also catch a race condition where a
 			 * subvolume which was passed by ID is renamed and
@@ -2288,20 +2283,23 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
 			 */
 			btrfs_err(fs_info,
 				  "subvol '%s' does not match subvolid %llu",
-				  subvol_name, subvol_objectid);
+				  ctx->subvol_name, ctx->subvolid);
 			ret = -EINVAL;
 		}
 		if (ret) {
 			dput(root);
-			root = ERR_PTR(ret);
 			deactivate_locked_super(s);
+			goto out;
 		}
+	} else {
+		return PTR_ERR(root);
 	}
 
+	fc->root = root;
+	ret = 0;
+
 out:
-	mntput(mnt);
-	kfree(subvol_name);
-	return root;
+	return ret;
 }
 
 /*
@@ -2310,27 +2308,20 @@ static struct dentry *mount_subvol(const char *subvol_name, u64 subvol_objectid,
  * Note: This is based on mount_bdev from fs/super.c with a few additions
  *       for multiple device setup.  Make sure to keep it in sync.
  */
-static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
-		int flags, const char *device_name, void *data)
+static int btrfs_root_get_tree(struct fs_context *fc)
 {
-	struct block_device *bdev = NULL;
+	struct block_device *bdev;
 	struct super_block *s;
+	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct btrfs_device *device = NULL;
 	struct btrfs_fs_devices *fs_devices = NULL;
 	struct btrfs_fs_info *fs_info = NULL;
-	void *new_sec_opts = NULL;
 	fmode_t mode = FMODE_READ;
-	int error = 0;
+	int error = 0, i;
 
-	if (!(flags & SB_RDONLY))
+	if (!(fc->sb_flags & SB_RDONLY))
 		mode |= FMODE_WRITE;
 
-	if (data) {
-		error = security_sb_eat_lsm_opts(data, &new_sec_opts);
-		if (error)
-			return ERR_PTR(error);
-	}
-
 	/*
 	 * Setup a dummy root and fs_info for test/set super.  This is because
 	 * we don't actually fill this stuff out until open_ctree, but we need
@@ -2340,10 +2331,9 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	 * superblock with our given fs_devices later on at sget() time.
 	 */
 	fs_info = kvzalloc(sizeof(struct btrfs_fs_info), GFP_KERNEL);
-	if (!fs_info) {
-		error = -ENOMEM;
-		goto error_sec_opts;
-	}
+	if (!fs_info)
+		return -ENOMEM;
+
 	btrfs_init_fs_info(fs_info);
 
 	fs_info->super_copy = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
@@ -2354,13 +2344,20 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 
 	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_device_options(data, mode, fs_type);
-	if (error) {
-		mutex_unlock(&uuid_mutex);
-		goto error_fs_info;
+
+	if (ctx->devices) {
+		for (i = 0; i < ctx->nr_devices; i++) {
+			device = btrfs_scan_one_device(ctx->devices[i], mode,
+							&btrfs_fs_type);
+			if (IS_ERR(device)) {
+				mutex_unlock(&uuid_mutex);
+				error = PTR_ERR(device);
+				goto error_fs_info;
+			}
+		}
 	}
 
-	device = btrfs_scan_one_device(device_name, mode, fs_type);
+	device = btrfs_scan_one_device(fc->source, mode, &btrfs_fs_type);
 	if (IS_ERR(device)) {
 		mutex_unlock(&uuid_mutex);
 		error = PTR_ERR(device);
@@ -2370,53 +2367,49 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	fs_devices = device->fs_devices;
 	fs_info->fs_devices = fs_devices;
 
-	error = btrfs_open_devices(fs_devices, mode, fs_type);
+	error = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
 	mutex_unlock(&uuid_mutex);
 	if (error)
 		goto error_fs_info;
 
-	if (!(flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
+
+	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
 		error = -EACCES;
 		goto error_close_devices;
 	}
 
 	bdev = fs_devices->latest_bdev;
-	s = sget(fs_type, btrfs_test_super, btrfs_set_super, flags | SB_NOSEC,
-		 fs_info);
+
+	fc->s_fs_info = fs_info;
+	s = sget_fc(fc, btrfs_test_super, set_anon_super_fc);
 	if (IS_ERR(s)) {
 		error = PTR_ERR(s);
 		goto error_close_devices;
 	}
 
+	 /* sget_fc returned a previously allocated superblocl. */
 	if (s->s_root) {
-		btrfs_close_devices(fs_devices);
-		btrfs_free_fs_info(fs_info);
-		if ((flags ^ s->s_flags) & SB_RDONLY)
+		btrfs_close_devices(fs_info->fs_devices);
+		if ((fc->sb_flags ^ s->s_flags) & SB_RDONLY)
 			error = -EBUSY;
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
-		btrfs_sb(s)->bdev_holder = fs_type;
-		if (!strstr(crc32c_impl(), "generic"))
-			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
-		error = btrfs_fill_super(s, fs_devices, data);
-	}
-	if (!error)
-		error = security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);
-	security_free_mnt_opts(&new_sec_opts);
-	if (error) {
-		deactivate_locked_super(s);
-		return ERR_PTR(error);
+		error = btrfs_fill_super(fc, s, fs_devices);
 	}
 
-	return dget(s->s_root);
+	if (error)
+		goto error_super;
+
+	fc->root = dget(s->s_root);
+	return 0;
 
+error_super:
+	deactivate_locked_super(s);
 error_close_devices:
 	btrfs_close_devices(fs_devices);
 error_fs_info:
-	btrfs_free_fs_info(fs_info);
-error_sec_opts:
-	security_free_mnt_opts(&new_sec_opts);
-	return ERR_PTR(error);
+	/*btrfs_free_fs_info(fs_info);*/
+	return error;
 }
 
 /*
@@ -2424,7 +2417,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
  * btrfs_get_tree will be called recursively, but then will check for the
  * ctx->root being set and call btrfs_root_get_tree.
  */
-static int btrfs_mount_root_fc(struct fs_context *fc, unsigned int rdonly)
+int btrfs_mount_root_fc(struct fs_context *fc, unsigned int rdonly)
 {
 	struct btrfs_fs_context *ctx, *root_ctx;
 	struct fs_context *root_fc;
@@ -2460,81 +2453,76 @@ static int btrfs_mount_root_fc(struct fs_context *fc, unsigned int rdonly)
 	return ret;
 }
 
+static int btrfs_reconfigure_root_to_rw(struct fs_context *fc,
+					struct super_block *sb)
+{
+	int error;
+	struct fs_context root_fc = {
+		.purpose	= FS_CONTEXT_FOR_RECONFIGURE,
+		.fs_type	= sb->s_type,
+		.root		= sb->s_root,
+		.log		= fc->log,
+		.sb_flags	= 0,
+		.sb_flags_mask	= SB_RDONLY,
+	};
+
+	down_write(&sb->s_umount);
+	error = btrfs_reconfigure(&root_fc);
+	up_write(&sb->s_umount);
+	return error;
+}
+
 /*
- * Mount function which is called by VFS layer.
+ * Mount function which is called by VFS layer after the argument parsing.
  *
  * In order to allow mounting a subvolume directly, btrfs uses mount_subtree()
  * which needs vfsmount* of device's root (/).  This means device's root has to
  * be mounted internally in any case.
  *
  * Operation flow:
- *   1. Parse subvol id related options for later use in mount_subvol().
- *
- *   2. Mount device's root (/) by calling vfs_kern_mount().
+ *   1. Mount device's root (/) by calling btrfs_mount_root_fc.
  *
- *      NOTE: vfs_kern_mount() is used by VFS to call btrfs_mount() in the
- *      first place. In order to avoid calling btrfs_mount() again, we use
- *      different file_system_type which is not registered to VFS by
- *      register_filesystem() (btrfs_root_fs_type). As a result,
- *      btrfs_mount_root() is called. The return value will be used by
- *      mount_subtree() in mount_subvol().
+ *   2. btrfs_get_tree is called recursively by btrfs_mount_fc -> fc_mount ->
+ *      btrfs_get_tree, because we use the same file_system_type for both root and
+ *      subvol mounts. We avoid the infinite recursive calls by checking the
+ *      ctx->root member being set, which shows that we are trying to mount the
+ *      root fs.
  *
  *   3. Call mount_subvol() to get the dentry of subvolume. Since there is
  *      "btrfs subvolume set-default", mount_subvol() is called always.
  */
-static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
-		const char *device_name, void *data)
+static int btrfs_get_tree(struct fs_context *fc)
 {
-	struct vfsmount *mnt_root;
-	struct dentry *root;
-	char *subvol_name = NULL;
-	u64 subvol_objectid = 0;
-	int error = 0;
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	int error = btrfs_fc_validate(fc);
 
-	error = btrfs_parse_subvol_options(data, &subvol_name,
-					&subvol_objectid);
-	if (error) {
-		kfree(subvol_name);
-		return ERR_PTR(error);
-	}
+	if (error)
+		return error;
 
-	/* mount device's root (/) */
-	mnt_root = vfs_kern_mount(&btrfs_root_fs_type, flags, device_name, data);
-	if (PTR_ERR_OR_ZERO(mnt_root) == -EBUSY) {
-		if (flags & SB_RDONLY) {
-			mnt_root = vfs_kern_mount(&btrfs_root_fs_type,
-				flags & ~SB_RDONLY, device_name, data);
-		} else {
-			mnt_root = vfs_kern_mount(&btrfs_root_fs_type,
-				flags | SB_RDONLY, device_name, data);
-			if (IS_ERR(mnt_root)) {
-				root = ERR_CAST(mnt_root);
-				kfree(subvol_name);
-				goto out;
-			}
+	if (!fc->source)
+		return invalf(fc, "No source specified");
 
-			down_write(&mnt_root->mnt_sb->s_umount);
-			error = btrfs_remount(mnt_root->mnt_sb, &flags, NULL);
-			up_write(&mnt_root->mnt_sb->s_umount);
-			if (error < 0) {
-				root = ERR_PTR(error);
-				mntput(mnt_root);
-				kfree(subvol_name);
-				goto out;
-			}
+	if (ctx->root)
+		return btrfs_root_get_tree(fc);
+
+	/* mount device's root (/) */
+	error = btrfs_mount_root_fc(fc, fc->sb_flags & SB_RDONLY);
+	if (error == -EBUSY) {
+		/*
+		 * If returned EBUSY, try again the mount inverting the rdonly
+		 * argument of btrfs_mount_root.
+		 */
+		error = btrfs_mount_root_fc(fc, (fc->sb_flags & SB_RDONLY) ^ SB_RDONLY);
+		if (!error && !(fc->sb_flags & SB_RDONLY)) {
+			error = btrfs_reconfigure_root_to_rw(fc,
+						ctx->root_mnt->mnt_sb);
 		}
 	}
-	if (IS_ERR(mnt_root)) {
-		root = ERR_CAST(mnt_root);
-		kfree(subvol_name);
-		goto out;
-	}
 
-	/* mount_subvol() will free subvol_name and mnt_root */
-	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
+	if (error < 0)
+		return error;
 
-out:
-	return root;
+	return mount_subvol(fc);
 }
 
 static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
@@ -2598,8 +2586,16 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 		btrfs_discard_cleanup(fs_info);
 }
 
-static int btrfs_remount(struct super_block *sb, int *flags, char *data)
+/*
+ * Change the configuration of an active superblock according to the supplied
+ * parameters.  Note that the parameter pointer (fc->fs_private) may be NULL in
+ * the case of umount detach, emergency remount R/O and get_tree remounting as
+ * R/W.
+ */
+int btrfs_reconfigure(struct fs_context *fc)
 {
+	struct btrfs_fs_context *ctx = fc->fs_private;
+	struct super_block *sb = fc->root->d_sb;
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 	struct btrfs_root *root = fs_info->tree_root;
 	unsigned old_flags = sb->s_flags;
@@ -2608,34 +2604,28 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	u64 old_max_inline = fs_info->max_inline;
 	u32 old_thread_pool_size = fs_info->thread_pool_size;
 	u32 old_metadata_ratio = fs_info->metadata_ratio;
-	int ret;
+	int ret = btrfs_fc_validate(fc);
+
+	if (ret)
+		return ret;
 
 	sync_filesystem(sb);
 	set_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
-
-	if (data) {
-		void *new_sec_opts = NULL;
-
-		ret = security_sb_eat_lsm_opts(data, &new_sec_opts);
-		if (!ret)
-			ret = security_sb_remount(sb, new_sec_opts);
-		security_free_mnt_opts(&new_sec_opts);
+	if (ctx) {
+		ret = btrfs_apply_configuration(fc, sb);
 		if (ret)
 			goto restore;
 	}
 
-	ret = btrfs_parse_options(fs_info, data, *flags);
-	if (ret)
-		goto restore;
+	btrfs_remount_begin(fs_info, old_opts, fc->sb_flags);
+	if (ctx && ctx->thread_pool_size)
+		btrfs_resize_thread_pool(fs_info, ctx->thread_pool_size,
+					old_thread_pool_size);
 
-	btrfs_remount_begin(fs_info, old_opts, *flags);
-	btrfs_resize_thread_pool(fs_info,
-		fs_info->thread_pool_size, old_thread_pool_size);
-
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
+	if ((bool)(fc->sb_flags & SB_RDONLY) == sb_rdonly(sb))
 		goto out;
 
-	if (*flags & SB_RDONLY) {
+	if (fc->sb_flags & SB_RDONLY) {
 		/*
 		 * this also happens on 'umount -rf' or on shutdown, when
 		 * the filesystem is busy.
@@ -2735,7 +2725,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	 * We need to set SB_I_VERSION here otherwise it'll get cleared by VFS,
 	 * since the absence of the flag means it can be toggled off by remount.
 	 */
-	*flags |= SB_I_VERSION;
+	fc->sb_flags |= SB_I_VERSION;
 
 	wake_up_process(fs_info->transaction_kthread);
 	btrfs_remount_cleanup(fs_info, old_opts);
@@ -3058,9 +3048,11 @@ static void btrfs_fc_free(struct fs_context *fc)
 }
 
 static const struct fs_context_operations btrfs_context_ops = {
-	.dup = btrfs_dup_fc,
-	.free = btrfs_fc_free,
-	.parse_param = btrfs_fc_parse_param,
+	.dup		= btrfs_dup_fc,
+	.free		= btrfs_fc_free,
+	.get_tree	= btrfs_get_tree,
+	.parse_param	= btrfs_fc_parse_param,
+	.reconfigure	= btrfs_reconfigure,
 };
 
 static int btrfs_init_fs_context(struct fs_context *fc)
@@ -3072,7 +3064,6 @@ static int btrfs_init_fs_context(struct fs_context *fc)
 		return -ENOMEM;
 
 	/* currently default options */
-	btrfs_set_opt(ctx->mount_opt, SPACE_CACHE);
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 	fc->sb_flags |= SB_POSIXACL;
 #endif
@@ -3083,19 +3074,18 @@ static int btrfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static struct file_system_type btrfs_fs_type = {
+struct file_system_type btrfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "btrfs",
-	.mount		= btrfs_mount,
 	.parameters	= btrfs_fs_parameters,
+	.init_fs_context = btrfs_init_fs_context,
 	.kill_sb	= btrfs_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
-};
+	};
 
 static struct file_system_type btrfs_root_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "btrfs",
-	.mount		= btrfs_mount_root,
 	.parameters	= btrfs_fs_parameters,
 	.kill_sb	= btrfs_kill_super,
 	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
@@ -3136,7 +3126,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	case BTRFS_IOC_SCAN_DEV:
 		mutex_lock(&uuid_mutex);
 		device = btrfs_scan_one_device(vol->name, FMODE_READ,
-					       &btrfs_root_fs_type);
+							&btrfs_fs_type);
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
 		break;
@@ -3146,7 +3136,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	case BTRFS_IOC_DEVICES_READY:
 		mutex_lock(&uuid_mutex);
 		device = btrfs_scan_one_device(vol->name, FMODE_READ,
-					       &btrfs_root_fs_type);
+							&btrfs_fs_type);
 		if (IS_ERR(device)) {
 			mutex_unlock(&uuid_mutex);
 			ret = PTR_ERR(device);
@@ -3237,7 +3227,6 @@ static const struct super_operations btrfs_super_ops = {
 	.destroy_inode	= btrfs_destroy_inode,
 	.free_inode	= btrfs_free_inode,
 	.statfs		= btrfs_statfs,
-	.remount_fs	= btrfs_remount,
 	.freeze_fs	= btrfs_freeze,
 	.unfreeze_fs	= btrfs_unfreeze,
 };
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d7670e2a9f39..59ba27e82615 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2304,7 +2304,7 @@ static struct btrfs_device *btrfs_find_device_by_path(
 	struct btrfs_device *device;
 
 	ret = btrfs_get_bdev_and_sb(device_path, FMODE_READ,
-				    fs_info->bdev_holder, 0, &bdev, &disk_super);
+				    &btrfs_fs_type, 0, &bdev, &disk_super);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -2516,7 +2516,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		return -EROFS;
 
 	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
-				  fs_info->bdev_holder);
+				  &btrfs_fs_type);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
@@ -6739,7 +6739,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
-	ret = open_fs_devices(fs_devices, FMODE_READ, fs_info->bdev_holder);
+	ret = open_fs_devices(fs_devices, FMODE_READ, &btrfs_fs_type);
 	if (ret) {
 		free_fs_devices(fs_devices);
 		fs_devices = ERR_PTR(ret);
-- 
2.28.0

