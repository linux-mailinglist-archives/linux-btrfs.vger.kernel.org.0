Return-Path: <linux-btrfs+bounces-2385-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C5854EE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 17:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741641C28E32
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5988629FD;
	Wed, 14 Feb 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="d/BdmOG0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36C61690;
	Wed, 14 Feb 2024 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928946; cv=none; b=WhOXRdtTcRfQAQFP8xUFZKnABSCbhbxLRgB45UcsAQkmy3M2Zx2u1eHzpUOGTIMoILz0I7r/C/SFJDJT/2GiVFmTC47VECrwfZSiNdMTydTrMSA3IHmwxtxO/LpYn63Kgiik9inIy1973YFNYRm18URHY9lL9VV0fljiS/MjBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928946; c=relaxed/simple;
	bh=bH6vWRw60xnuXV0jlirxZDKuiOZGmQa5D7tTxE57gpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFVsLQOekGiNBqQwrjFcDvv2hc/7Pz2EiD7F02stiqIKuAbazCdhFDTbU/3ZAGG2rr8uThjXwPIJbO0u56xICu2Lysc262i7z+LwlsMksEjHQf3eH8UcK/GU3j0oPWpICPLm5rV82cXXVlBJP24kVpezKcQN4mrVybJwIUCG/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=d/BdmOG0; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707928945; x=1739464945;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bH6vWRw60xnuXV0jlirxZDKuiOZGmQa5D7tTxE57gpM=;
  b=d/BdmOG0rUTis69cavNFSxT/qUmh+8lAB4x2Rw/OlCqlLqkAP2E2JVUf
   9HhskvMWb1tr+/NfNjZ26vo2InuOFhCZJT1KJ0FJ6hWohJzkZ98YA8F5Y
   A+ETILS0xBMaCLpFAuAD7khkrnLpq3AnRyPhXN0A2tYP3YDAB8QIkg+Lw
   Is8PwkOEXvjgLDKNy3yQ/dCpy6OfTxe8zlNufEo1Tkewj8MJKQM2xJGTV
   3O5lnggEF8NKfNvZt+6dY5rZZpRlKzFGty1izQsINT5Kskerkubq1q333
   1Gi1g3+vnOtvb29v7EK78e/9dXjbQdKEmVtc5GzI9tdeuAWlSUzuga9fV
   g==;
X-CSE-ConnectionGUID: 9drc1YFoQvaidyriv7WFXA==
X-CSE-MsgGUID: 1iiedHrNQFeM2XliwCveJw==
X-IronPort-AV: E=Sophos;i="6.06,159,1705334400"; 
   d="scan'208";a="9294745"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 00:42:23 +0800
IronPort-SDR: HDZ2Vp1/6Jl6rHnVkIgbbev376ZIPH6QAGHVdQ4BFcUDRhNY7aAjSM2HQQNk+XuE6RhaTJrLSc
 2a80kDhOYg9A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 07:51:58 -0800
IronPort-SDR: sQgZ3eP1XpqDvjkE+iOQ0S3gHN20lFei3m2a7KcuC3C15nUIrDy/vEBRQRaz8S+T2zm0rZY0YB
 iia0adWGSQxQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Feb 2024 08:42:20 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 14 Feb 2024 08:42:15 -0800
Subject: [PATCH 4/5] btrfs: open block devices after superblock creation
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hch-device-open-v1-4-b153428b4f72@wdc.com>
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
In-Reply-To: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707928933; l=4352;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=BhQPNDpB6/btBxArh/7gqFHYFe5pci1QG9ex6aK98P8=;
 b=v3u1ICI2D2ErbuWaEOekpBh2t3TtBEN3cbKtZ8iM6jF6pkBBUMzIEybn0Do9bfzM/wXANeICX
 QTKnpY1mqK3B6BtWioo70IqPyFlv4LU2/jLdo32dTbJ408sqVww6yC+
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

From: Christoph Hellwig <hch@lst.de>

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
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/super.c   | 41 +++++++++++++++++++++++++----------------
 fs/btrfs/volumes.c | 15 +++++----------
 2 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 51b8fd272b15..1fa7d83d02c1 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1794,7 +1794,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	struct btrfs_fs_info *fs_info = fc->s_fs_info;
 	struct btrfs_fs_context *ctx = fc->fs_private;
 	struct btrfs_fs_devices *fs_devices = NULL;
-	struct block_device *bdev;
 	struct btrfs_device *device;
 	struct super_block *sb;
 	blk_mode_t mode = btrfs_open_mode(fc);
@@ -1817,15 +1816,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
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
@@ -1843,24 +1835,41 @@ static int btrfs_get_tree_super(struct fs_context *fc)
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
index f27af155abf0..6e82bd7ce501 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1220,8 +1220,6 @@ static int devid_cmp(void *priv, const struct list_head *a,
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder)
 {
-	int ret;
-
 	lockdep_assert_held(&uuid_mutex);
 	/*
 	 * The device_list_mutex cannot be taken here in case opening the
@@ -1230,14 +1228,11 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
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
2.43.0


