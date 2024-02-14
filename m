Return-Path: <linux-btrfs+bounces-2383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B99854EDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 17:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF371F21EDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 16:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C7660EDA;
	Wed, 14 Feb 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OTXlyxz/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB426088E;
	Wed, 14 Feb 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928941; cv=none; b=B/cLux9nKy6JndNdhRlrB3SRb4CeO2l5+3OswYN2oASX1Kaw3buPOSx4wRjrH/RPoy1qjWXO+PqzlhkHpeSaP21VMK2ApxJQXbl38sDuaG3ITsdFIs3LISHAcs/1+izDya/wiOA1H3gBl8BuBINxA5Rqw3EAwme887U/6kzRpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928941; c=relaxed/simple;
	bh=SA54NmB9VaxafMJvx4jeBf6OXC9qGXNN/wzW6KwJc0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNXoH6iR5Uvr0urGtsryURAl0EK0ac22a/2RjHL5sELZwlzWdmIpuWRRWXNYXCFNWfEZ8g0uSxBlVHgQAUeL8vWS7rxStwqxPDhZeYyFj6H8rhNpDSDWohUMXVAP9l09D0bO6/Gpy6eY3XmKVQli5aSj2kwLJ6xrwxMYUU0+dW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OTXlyxz/; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707928939; x=1739464939;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SA54NmB9VaxafMJvx4jeBf6OXC9qGXNN/wzW6KwJc0I=;
  b=OTXlyxz/jrALoPlvgPJzl2l3j6Ad2++yq69zKJX2aTzWfccC7e3VhP3w
   xzDD4VsDppbE2IU9VFQirwqm92ebYBdMDO2DTf4cO7IYxPxWOmf/cQ2Hu
   dHEAZTJVfo9vQA1GfuCmK2lx/4zemARnrb2O+k5XJufUYW4uFpMgYLfZa
   ytaRQs80t8cEbvpBjeQph44kkPQh2n9cwAT6RXkGbJc7Ip/utogFzpXYH
   EFIVEVmu1dZLBBfOCtCfTR6qmzM9pAeSpULfyp9kJokGsLCroC7VMI3yd
   LTlAZXMhxABCVeXsQyw2VvS04HZd7ONCAYXEMXnf4ImLep3kya/YrN/BP
   w==;
X-CSE-ConnectionGUID: 7QyyfYlsS8mTXGUHHx2Y4w==
X-CSE-MsgGUID: m0Inx8HrSS6WwaLWObvFWg==
X-IronPort-AV: E=Sophos;i="6.06,159,1705334400"; 
   d="scan'208";a="9294737"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 00:42:18 +0800
IronPort-SDR: SSrVPLBH4vuMc4cfZHfQ/b+pDujGtMWHIns6NHaF9lyahd7FbJ8+K0Ph82pk76CGBQ3dPPJcyE
 LD/icZemTUzQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 07:51:54 -0800
IronPort-SDR: 8lGAdnDhx9j3WWMhmeE/nADvuABDMthU2whT2b4eR+cuepsze0JD82+A9/n3GNyZi4iPcg+MnS
 eZJ0R8+KqUwA==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Feb 2024 08:42:16 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 14 Feb 2024 08:42:13 -0800
Subject: [PATCH 2/5] btrfs: call btrfs_close_devices from ->kill_sb
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hch-device-open-v1-2-b153428b4f72@wdc.com>
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
In-Reply-To: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707928933; l=3686;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=RnNhAJkrtFJkaTBsB+8lN1Jcoq+lAOAadAngBZomtdQ=;
 b=fdg6RARFVrH5MCrjpINABNkYuCuzvEPtTY7ekxao+ARnqHZcN8sMsTmI86xex910XbA9fCcTd
 wrZYN8wJ1xrAZ+y0BCAWlDIvZLKuRm+kYV5Qmk6G3YUPq7BAjec6DTh
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

From: Christoph Hellwig <hch@lst.de>

blkdev_put must not be called under sb->s_umount to avoid a lock order
reversal with disk->open_mutex once call backs from block devices to
the file system using the holder ops are supported.  Move the call
to btrfs_close_devices into btrfs_free_fs_info so that it is closed
from ->kill_sb (which is also called from the mount failure handling
path unlike ->put_super) as well as when an fs_info is freed because
an existing superblock already exists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/super.c   | 27 ++++++++++++++-------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8ab185182c30..4aa67e2a48f6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1266,6 +1266,8 @@ static void free_global_roots(struct btrfs_fs_info *fs_info)
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
+	if (fs_info->fs_devices)
+		btrfs_close_devices(fs_info->fs_devices);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
@@ -3609,7 +3611,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	iput(fs_info->btree_inode);
 fail:
-	btrfs_close_devices(fs_info->fs_devices);
 	ASSERT(ret < 0);
 	return ret;
 }
@@ -4389,7 +4390,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	iput(fs_info->btree_inode);
 
 	btrfs_mapping_tree_free(fs_info);
-	btrfs_close_devices(fs_info->fs_devices);
 }
 
 void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b6cadf4f21b8..51b8fd272b15 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1822,10 +1822,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	if (ret)
 		return ret;
 
-	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
-		ret = -EACCES;
-		goto error;
-	}
+	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
+		return -EACCES;
 
 	bdev = fs_devices->latest_dev->bdev;
 
@@ -1839,15 +1837,12 @@ static int btrfs_get_tree_super(struct fs_context *fc)
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
@@ -1866,10 +1861,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 	fc->root = dget(sb->s_root);
 	return 0;
-
-error:
-	btrfs_close_devices(fs_devices);
-	return ret;
 }
 
 /*
@@ -1962,10 +1953,20 @@ static int btrfs_get_tree_super(struct fs_context *fc)
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
2.43.0


