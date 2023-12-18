Return-Path: <linux-btrfs+bounces-1008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5758165BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 05:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D231B2119D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 04:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120C613A;
	Mon, 18 Dec 2023 04:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HWXfn1Kr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C86AA8
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y1ClTYqVSi47swoAkDvhns1CIwMW3vg5a53Yp5NWlUA=; b=HWXfn1KrTbgenx4BfCMN58sx75
	nSLb9qRGjqdPRVyhzJcv6/0QA+AtC1dbncK1Jyrgr0yoafhkJfprDeTnCb54s9kMJofd/LZ93EpQB
	EPlNiKn3/QCrncwaM8xFYbMnSo6Slu3yLYwrFz4cccw8ABf7+Pr/MUW+6j9AA+LKYaNYizUFQLFFW
	Xp0PBpIfVULVZsFlPetoahnM9tUz/88GCfFFM9SIyfHU8i1Nd1jO3do7KHaByJDQzf4me5W/GXnr4
	PZpjUY/P/YeqgHZLrcQJ4nu348MgFnqZXf7MUL3d6SEVZWTO1OlBmOtJnMvRMP8/1h79FfvR8/sCR
	lB94jX8w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rF5ZZ-0094F1-38;
	Mon, 18 Dec 2023 04:49:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 4/5] btrfs: open block devices after superblock creation
Date: Mon, 18 Dec 2023 05:49:32 +0100
Message-Id: <20231218044933.706042-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231218044933.706042-1-hch@lst.de>
References: <20231218044933.706042-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Currently btrfs_mount_root opens the block devices before committing to
allocating a super block. That creates problems for restricting the
number of writers to a device, and also leads to a unusual and not very
helpful holder (the fs_type).

Reorganize the code to first check whether the superblock for a
particular fsid does already exist and open the block devices only if it
doesn't, mirroring the recent changes to the VFS mount helpers.  To do
this the increment of the in_use counter moves out of btrfs_open_devices
and into the only caller in btrfs_mount_root so that it happens before
dropping uuid_mutex around the call to sget.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c   | 41 +++++++++++++++++++++++++----------------
 fs/btrfs/volumes.c | 15 +++++----------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7d38f973e991f6..62a933b47e03c3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1782,7 +1782,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	struct btrfs_fs_info *fs_info = fc->s_fs_info;
 	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct btrfs_fs_devices *fs_devices = NULL;
-	struct block_device *bdev;
 	struct btrfs_device *device;
 	struct super_block *sb;
 	blk_mode_t mode = sb_open_mode(fc->sb_flags);
@@ -1805,15 +1804,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	fs_devices = device->fs_devices;
 	fs_info->fs_devices = fs_devices;
 
-	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+	fs_devices->in_use++;
 	mutex_unlock(&uuid_mutex);
-	if (ret)
-		return ret;
-
-	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
-		return -EACCES;
-
-	bdev = fs_devices->latest_dev->bdev;
 
 	/*
 	 * From now on the error handling is not straightforward.
@@ -1831,24 +1823,41 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	set_device_specific_options(fs_info);
 
 	if (sb->s_root) {
-		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY)
+		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY) {
 			ret = -EBUSY;
+			goto error_deactivate;
+		}
 	} else {
-		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
+		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+
+		mutex_lock(&uuid_mutex);
+		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+		mutex_unlock(&uuid_mutex);
+		if (ret)
+			goto error_deactivate;
+
+		if (!(fc->sb_flags & SB_RDONLY) && !fs_devices->rw_devices) {
+			ret = -EACCES;
+			goto error_deactivate;
+		}
+
+		snprintf(sb->s_id, sizeof(sb->s_id), "%pg",
+			 fs_devices->latest_dev->bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
 		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
 		ret = btrfs_fill_super(sb, fs_devices, NULL);
-	}
-
-	if (ret) {
-		deactivate_locked_super(sb);
-		return ret;
+		if (ret)
+			goto error_deactivate;
 	}
 
 	btrfs_clear_oneshot_options(fs_info);
 
 	fc->root = dget(sb->s_root);
 	return 0;
+
+error_deactivate:
+	deactivate_locked_super(sb);
+	return ret;
 }
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 65d28c79402091..5ab1b7c2fa3967 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1222,8 +1222,6 @@ static int devid_cmp(void *priv, const struct list_head *a,
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder)
 {
-	int ret;
-
 	lockdep_assert_held(&uuid_mutex);
 	/*
 	 * The device_list_mutex cannot be taken here in case opening the
@@ -1232,14 +1230,11 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	 * We also don't need the lock here as this is called during mount and
 	 * exclusion is provided by uuid_mutex
 	 */
-	if (!fs_devices->is_open) {
-		list_sort(NULL, &fs_devices->devices, devid_cmp);
-		ret = open_fs_devices(fs_devices, flags, holder);
-		if (ret)
-			return ret;
-	}
-	fs_devices->in_use++;
-	return 0;
+	ASSERT(fs_devices->in_use);
+	if (fs_devices->is_open)
+		return 0;
+	list_sort(NULL, &fs_devices->devices, devid_cmp);
+	return open_fs_devices(fs_devices, flags, holder);
 }
 
 void btrfs_release_disk_super(struct btrfs_super_block *super)
-- 
2.39.2


