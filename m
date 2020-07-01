Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD416210DF6
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 16:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbgGAOoo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 10:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgGAOon (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 10:44:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC48C08C5C1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jul 2020 07:44:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id x62so18583665qtd.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jul 2020 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OgWTKIJdMbC4UiRzDz0GYngts9c0b3fCmMqwTIVXMX4=;
        b=EVHw91Yw4+PCI915E19kzJEu2jIez2TBzmEoqSremgzbfANLuBkIvyQeIFa/o6tQsJ
         2g/gNogx8Od8k6C/43PFzBQOWyyFnVhlDyaM6QJcq3fudVpap0soZmtA7GsYREC0S/hD
         fhoDyvpYTukuhv3NUbOPMc/OqJjFkbqKCLPuMMbuX94rg3Wsav4cCX4Bib/Tlcx1v4U8
         jujFtP5cWN58Tk3GVSx75A9PlKmAED1NiCtzrQLlzusjmoVjbFRfVLrFUtze6qcWalpi
         s4Pm1nMPqy7lcge+K0WJi1toaS84wgBaDPezIHYAhlsiaHFoFDcF8t7n7B/7v2p1n2Sb
         gmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OgWTKIJdMbC4UiRzDz0GYngts9c0b3fCmMqwTIVXMX4=;
        b=IRW2AYXvMM3GAd7L8dpu/0bm41qzvXzBh+bXa/iVR73uMrP9UktvGLGNGrSlk9Csde
         k2rgEcWetMRMcDKfhTig5/7KliucijUZpISSGSEMd1si7fIZaNz9cohGY9he2QqKIRhU
         BkRX5C6NSGvcQB1z8AVNXFUmGOXbATZlPC6fbkPTcKabVvLs2XkDOQFrvMmnUcvW4K6h
         GYvoEcWndlRMyy9zx9nAA1vVAKbCrc9snpStPvDVsmoSxoUyw35C7a7ixEyhiUXu3WKh
         LdDLcgT5S5PrdA/3wlOClcIpHWuorF3DnY3C4wFWZPtmLJstfQF93GTRdDGMuQLyQ0Tb
         /Xpg==
X-Gm-Message-State: AOAM532Xq8Ks3/XSPdfqDhw7h85ANBTbnt5+fmaQZHPSTewJ6ckh/V3j
        InH18bAIRTdBotRTaFML2APWBC3W+WKyKA==
X-Google-Smtp-Source: ABdhPJy2I1pGFXvTv48QQkWIgv2m8UqMidKCU785kjfnsQrM0kcMrGPNMf/V2K/YZTzzZPDE7mvzfw==
X-Received: by 2002:ac8:1206:: with SMTP id x6mr27076313qti.145.1593614680953;
        Wed, 01 Jul 2020 07:44:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z17sm6714858qth.24.2020.07.01.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 07:44:40 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][RFC] btrfs: introduce rescue=onlyfs
Date:   Wed,  1 Jul 2020 10:44:38 -0400
Message-Id: <20200701144438.7613-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One of the things that came up consistently in talking with Fedora about
switching to btrfs as default is that btrfs is particularly vulnerable
to metadata corruption.  If any of the core global roots are corrupted,
the fs is unmountable and fsck can't usually do anything for you without
some special options.

Qu addressed this sort of with rescue=skipbg, but that's poorly named as
what it really does is just allow you to operate without an extent root.
However there are a lot of other roots, and I'd rather not have to do

mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah

Instead take his original idea and modify it so it just works for
everything.  Turn it into rescue=onlyfs, and then any major root we fail
to read just gets left empty and we carry on.

Obviously if the fs roots are screwed then the user is in trouble, but
otherwise this makes it much easier to pull stuff off the disk without
needing our special rescue tools.  I tested this with my TEST_DEV that
had a bunch of data on it by corrupting the csum tree and then reading
files off the disk.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---

I'm not married to the rescue=onlyfs name, if we can think of something better
I'm good.

Also rescue=skipbg is currently only sitting in misc-next, which is why I'm
killing it with this patch, we haven't sent it upstream so we're good to change
it now before it lands.

 fs/btrfs/block-group.c |  2 +-
 fs/btrfs/ctree.h       |  2 +-
 fs/btrfs/disk-io.c     | 76 ++++++++++++++++++++++--------------------
 fs/btrfs/inode.c       |  6 +++-
 fs/btrfs/super.c       | 27 +++++++--------
 fs/btrfs/volumes.c     |  4 +--
 6 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 09b796a081dd..cb5608b2deec 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2052,7 +2052,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	int need_clear = 0;
 	u64 cache_gen;
 
-	if (btrfs_test_opt(info, SKIPBG))
+	if (btrfs_test_opt(info, ONLYFS))
 		return fill_dummy_bgs(info);
 
 	key.objectid = 0;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e40eb210670d..d888d08f7e0d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1265,7 +1265,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
-#define BTRFS_MOUNT_SKIPBG		(1 << 30)
+#define BTRFS_MOUNT_ONLYFS		(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c27022f13150..9cba0a66b3d5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2262,11 +2262,10 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		if (!btrfs_test_opt(fs_info, SKIPBG)) {
+		if (!btrfs_test_opt(fs_info, ONLYFS)) {
 			ret = PTR_ERR(root);
 			goto out;
 		}
-		fs_info->extent_root = NULL;
 	} else {
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 		fs_info->extent_root = root;
@@ -2275,21 +2274,27 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	location.objectid = BTRFS_DEV_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, ONLYFS)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+	} else {
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->dev_root = root;
+		btrfs_init_devices_late(fs_info);
 	}
-	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-	fs_info->dev_root = root;
-	btrfs_init_devices_late(fs_info);
 
 	location.objectid = BTRFS_CSUM_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, ONLYFS)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+	} else {
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->csum_root = root;
 	}
-	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-	fs_info->csum_root = root;
 
 	/*
 	 * This tree can share blocks with some other fs tree during relocation
@@ -2298,11 +2303,14 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	root = btrfs_get_fs_root(tree_root->fs_info,
 				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		goto out;
+		if (!btrfs_test_opt(fs_info, ONLYFS)) {
+			ret = PTR_ERR(root);
+			goto out;
+		}
+	} else {
+		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+		fs_info->data_reloc_root = root;
 	}
-	set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-	fs_info->data_reloc_root = root;
 
 	location.objectid = BTRFS_QUOTA_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
@@ -2315,9 +2323,11 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 	location.objectid = BTRFS_UUID_TREE_OBJECTID;
 	root = btrfs_read_tree_root(tree_root, &location);
 	if (IS_ERR(root)) {
-		ret = PTR_ERR(root);
-		if (ret != -ENOENT)
-			goto out;
+		if (!btrfs_test_opt(fs_info, ONLYFS)) {
+			ret = PTR_ERR(root);
+			if (ret != -ENOENT)
+				goto out;
+		}
 	} else {
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
 		fs_info->uuid_root = root;
@@ -2327,11 +2337,14 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		location.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID;
 		root = btrfs_read_tree_root(tree_root, &location);
 		if (IS_ERR(root)) {
-			ret = PTR_ERR(root);
-			goto out;
+			if (!btrfs_test_opt(fs_info, ONLYFS)) {
+				ret = PTR_ERR(root);
+				goto out;
+			}
+		}  else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+			fs_info->free_space_root = root;
 		}
-		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-		fs_info->free_space_root = root;
 	}
 
 	return 0;
@@ -3047,20 +3060,11 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	/* Skip bg needs RO and no tree-log to replay */
-	if (btrfs_test_opt(fs_info, SKIPBG)) {
-		if (!sb_rdonly(sb)) {
-			btrfs_err(fs_info,
-			"rescue=skipbg can only be used on read-only mount");
-			err = -EINVAL;
-			goto fail_alloc;
-		}
-		if (btrfs_super_log_root(disk_super) &&
-		    !btrfs_test_opt(fs_info, NOLOGREPLAY)) {
-			btrfs_err(fs_info,
-"rescue=skipbg must be used with rescue=nologreplay when tree-log needs to replayed");
-			err = -EINVAL;
-			goto fail_alloc;
-		}
+	if (btrfs_test_opt(fs_info, ONLYFS) && !sb_rdonly(sb)) {
+		btrfs_err(fs_info,
+			  "rescue=onlyfs can only be used on read-only mount");
+		err = -EINVAL;
+		goto fail_alloc;
 	}
 
 	ret = btrfs_init_workqueues(fs_info, fs_devices);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d301550b9c70..9f8ef22ac65e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2209,7 +2209,8 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 	int skip_sum;
 	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
 
-	skip_sum = BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM;
+	skip_sum = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
+		btrfs_test_opt(fs_info, ONLYFS);
 
 	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
@@ -2866,6 +2867,9 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
+	if (btrfs_test_opt(root->fs_info, ONLYFS))
+		return 0;
+
 	if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID &&
 	    test_range_bit(io_tree, start, end, EXTENT_NODATASUM, 1, NULL)) {
 		clear_extent_bits(io_tree, start, end, EXTENT_NODATASUM);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3c9ebd4f2b61..7ea9f8f53156 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -345,7 +345,7 @@ enum {
 	Opt_rescue,
 	Opt_usebackuproot,
 	Opt_nologreplay,
-	Opt_rescue_skipbg,
+	Opt_rescue_onlyfs,
 
 	/* Deprecated options */
 	Opt_alloc_start,
@@ -445,7 +445,7 @@ static const match_table_t tokens = {
 static const match_table_t rescue_tokens = {
 	{Opt_usebackuproot, "usebackuproot"},
 	{Opt_nologreplay, "nologreplay"},
-	{Opt_rescue_skipbg, "skipbg"},
+	{Opt_rescue_onlyfs, "onlyfs"},
 	{Opt_err, NULL},
 };
 
@@ -478,9 +478,10 @@ static int parse_rescue_options(struct btrfs_fs_info *info, const char *options)
 			btrfs_set_and_info(info, NOLOGREPLAY,
 					   "disabling log replay at mount time");
 			break;
-		case Opt_rescue_skipbg:
-			btrfs_set_and_info(info, SKIPBG,
-				"skip mount time block group searching");
+		case Opt_rescue_onlyfs:
+			btrfs_set_and_info(info, ONLYFS,
+					   "only reading fs roots, also setting  nologreplay");
+			btrfs_set_opt(info->mount_opt, NOLOGREPLAY);
 			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized rescue option '%s'", p);
@@ -1418,8 +1419,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",notreelog");
 	if (btrfs_test_opt(info, NOLOGREPLAY))
 		seq_puts(seq, ",rescue=nologreplay");
-	if (btrfs_test_opt(info, SKIPBG))
-		seq_puts(seq, ",rescue=skipbg");
+	if (btrfs_test_opt(info, ONLYFS))
+		seq_puts(seq, ",rescue=onlyfs");
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
@@ -1859,10 +1860,10 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 	if (ret)
 		goto restore;
 
-	if (btrfs_test_opt(fs_info, SKIPBG) !=
-	    (old_opts & BTRFS_MOUNT_SKIPBG)) {
+	if (btrfs_test_opt(fs_info, ONLYFS) !=
+	    (old_opts & BTRFS_MOUNT_ONLYFS)) {
 		btrfs_err(fs_info,
-		"rescue=skipbg mount option can't be changed during remount");
+		"rescue=onlyfs mount option can't be changed during remount");
 		ret = -EINVAL;
 		goto restore;
 	}
@@ -1932,9 +1933,9 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			goto restore;
 		}
 
-		if (btrfs_test_opt(fs_info, SKIPBG)) {
+		if (btrfs_test_opt(fs_info, ONLYFS)) {
 			btrfs_err(fs_info,
-		"remounting read-write with rescue=skipbg is not allowed");
+		"remounting read-write with rescue=onlyfs is not allowed");
 			ret = -EINVAL;
 			goto restore;
 		}
@@ -2245,7 +2246,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 *
 	 * Or if we're rescuing, set available to 0 anyway.
 	 */
-	if (btrfs_test_opt(fs_info, SKIPBG) ||
+	if (btrfs_test_opt(fs_info, ONLYFS) ||
 	    (!mixed && block_rsv->space_info->full &&
 	     total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index aabc6c922e04..a5d124f95ce2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7595,10 +7595,10 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
 	int ret = 0;
 
 	/*
-	 * For rescue=skipbg mount option, we're already RO and are salvaging
+	 * For rescue=onlyfs mount option, we're already RO and are salvaging
 	 * data, no need for such strict check.
 	 */
-	if (btrfs_test_opt(fs_info, SKIPBG))
+	if (btrfs_test_opt(fs_info, ONLYFS))
 		return 0;
 
 	key.objectid = 1;
-- 
2.24.1

