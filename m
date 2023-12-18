Return-Path: <linux-btrfs+bounces-1006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7FA8165BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 05:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B52B2823A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 04:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4981563D3;
	Mon, 18 Dec 2023 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4kM8A5Ru"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF85163AE
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 04:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6+/tPB8H2ZpOMp6KNaaRjHjXsRE9V5S6wwFc2IkV/vo=; b=4kM8A5Rufr/JJ7L9t+FrWAYFZF
	zdUdRkWLKfvysbVPVpJj0OWXRiv9aAX3+BEdaTA/aBIEI1XDT42Zl95wqoBIQwv1cpELMQU0COPMQ
	bszehWU7FoJF8flOR3y+SnKNIzYrktGepGfXtd7WFg8rDSda80vEp22ErxXCz6OqF2Y8HNMDQAGl8
	KuFfbLGR5nRqLRVo9MS4Zv8G5JcoGErJbYKEYXWt7sgy7mmg94KAm0fwOPorcCEeUJk+NKS2orqi5
	qES3hKb1YWtF5QWQ9zTxsAzQCfrQ1FP3+BeqKuqTohXEZQNpCJU2Y78im+xLKZnTePExg3Ke+IX7X
	oicn2olg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rF5ZV-0094ES-0M;
	Mon, 18 Dec 2023 04:49:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 2/5] btrfs: call btrfs_close_devices from ->kill_sb
Date: Mon, 18 Dec 2023 05:49:30 +0100
Message-Id: <20231218044933.706042-3-hch@lst.de>
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

blkdev_put must not be called under sb->s_umount to avoid a lock order
reversal with disk->open_mutex once call backs from block devices to
the file system using the holder ops are supported.  Move the call
to btrfs_close_devices into btrfs_free_fs_info so that it is closed
from ->kill_sb (which is also called from the mount failure handling
path unlike ->put_super) as well as when an fs_info is freed because
an existing superblock already exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/super.c   | 27 ++++++++++++++-------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c6907d533fe839..c2f57c986069b7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1265,6 +1265,8 @@ static void free_global_roots(struct btrfs_fs_info *fs_info)
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
+	if (fs_info->fs_devices)
+		btrfs_close_devices(fs_info->fs_devices);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
@@ -3597,7 +3599,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	iput(fs_info->btree_inode);
 fail:
-	btrfs_close_devices(fs_info->fs_devices);
 	ASSERT(ret < 0);
 	return ret;
 }
@@ -4377,7 +4378,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	iput(fs_info->btree_inode);
 
 	btrfs_mapping_tree_free(fs_info);
-	btrfs_close_devices(fs_info->fs_devices);
 }
 
 void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ba16ade1d79aea..7d38f973e991f6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1810,10 +1810,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	if (ret)
 		return ret;
 
-	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
-		ret = -EACCES;
-		goto error;
-	}
+	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
+		return -EACCES;
 
 	bdev = fs_devices->latest_dev->bdev;
 
@@ -1827,15 +1825,12 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	 * otherwise it's tied to the lifetime of the super_block.
 	 */
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
-	if (IS_ERR(sb)) {
-		ret = PTR_ERR(sb);
-		goto error;
-	}
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
 
 	set_device_specific_options(fs_info);
 
 	if (sb->s_root) {
-		btrfs_close_devices(fs_devices);
 		if ((fc->sb_flags ^ sb->s_flags) & SB_RDONLY)
 			ret = -EBUSY;
 	} else {
@@ -1854,10 +1849,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 	fc->root = dget(sb->s_root);
 	return 0;
-
-error:
-	btrfs_close_devices(fs_devices);
-	return ret;
 }
 
 /*
@@ -1950,10 +1941,20 @@ static int btrfs_get_tree_super(struct fs_context *fc)
  */
 static struct vfsmount *btrfs_reconfigure_for_mount(struct fs_context *fc)
 {
+	struct btrfs_fs_info *fs_info = fc->s_fs_info;
 	struct vfsmount *mnt;
 	int ret;
 	const bool ro2rw = !(fc->sb_flags & SB_RDONLY);
 
+	/*
+	 * We got a reference to our fs_devices, so we need to close it here to
+	 * make sure we don't leak our reference on the fs_devices.
+	 */
+	if (fs_info->fs_devices) {
+		btrfs_close_devices(fs_info->fs_devices);
+		fs_info->fs_devices = NULL;
+	}
+
 	/*
 	 * We got an EBUSY because our SB_RDONLY flag didn't match the existing
 	 * super block, so invert our setting here and retry the mount so we
-- 
2.39.2


