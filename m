Return-Path: <linux-btrfs+bounces-2382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256D8854EDC
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 17:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895A91F214C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72960ED1;
	Wed, 14 Feb 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gWyeO5M2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AF60860;
	Wed, 14 Feb 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928941; cv=none; b=SbQQ1KwLgD2QYohU8C6joPKRm+yfAxCHMK1jgdBFq9kxDEJL0NcyZYKRdp3h61ojWK6bavbT91uhp4YYKNR44Yw3Ny33NqNZffW4RBTCp2+KpfdKth/NAYwz4SXuEQyaVTOORL19t2a+JaUd/1RSeurOa5IvNpBQWiY+pYYASuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928941; c=relaxed/simple;
	bh=1xeJ1LAvHPKE2uqjKayiHpy8JrwfEHaEiYJ0ln71pjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKfIl9GqHNKCJEWHe3wvtQsyVMmfMdK40jUL/cP/XDk9m2lG87FhlMoGosxIX7uEt6T3SKQ7pSjenZM6dT5PaD0hF94LzvCdbm/bKbfADuAFylPre/wgLn5IUnQ5jrOTI1q7fyjMBJnY+niuSCwNr176uO4PLjGmEZtNTc4/Z1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=gWyeO5M2; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1707928938; x=1739464938;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1xeJ1LAvHPKE2uqjKayiHpy8JrwfEHaEiYJ0ln71pjA=;
  b=gWyeO5M2DW33/34phvrG7H17PTtXUMtYAvTUzhfHyxGicWhM2W9SE1fM
   U57l+Na17W6/vVcEGTl+WkGWG7XW9U2rNubCSpDhD3RpT6iWW7olbrZXF
   kMoWao3TzdSrlTnr/2YD2ir49FcGxCNiFGXaU1szEaNS3YFva7EZo4UeV
   ns3JlruveX9B+JK15hJ42M+kwEmNCZjhhYMxaoJE9KaT0tUw/rJsgAQV+
   cd4ks9phyaOG6Tp4+DdX9VYELIEo/VBa4XR76METyZokfC55qS80FmqWR
   9fjIbTyBx8zhMVYsc8s7MESJYSt3Jp3hvBq6/fJNbvKlplNDNu5/u5/VU
   A==;
X-CSE-ConnectionGUID: BSdo3bonT1awm+9IyK8hhQ==
X-CSE-MsgGUID: kessTWlvSrKc7mwPYVF/cA==
X-IronPort-AV: E=Sophos;i="6.06,159,1705334400"; 
   d="scan'208";a="9294734"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2024 00:42:17 +0800
IronPort-SDR: FBPImsUYqgy2slPze6245I3L7boT3T5vL9pTLSjYHJC/yqxdRAi6sbXdfa4F5lg1rUfRB8wicI
 FJ2KfAeXBD0Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2024 07:51:52 -0800
IronPort-SDR: Tq7El7VtOBEASrvLRsJaPhJ3TJtkXIAzXvaipqaQxReCEvamLj5riI1VV30aXXcK62y96V957B
 wdBi8O8E63XQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Feb 2024 08:42:15 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Wed, 14 Feb 2024 08:42:12 -0800
Subject: [PATCH 1/5] btrfs: always open the device read-only in
 btrfs_scan_one_device
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-hch-device-open-v1-1-b153428b4f72@wdc.com>
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
In-Reply-To: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707928933; l=3992;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=I14e53DoeQrG1yDNK+J7DI2KG2AGVZJx0PKdwyMYBvM=;
 b=Hc3gvACCQXK46UZERZp3NW3WwFKPPZM0OXn0ZdSDS1ytfZw068ymxH7eAvEAqSp7XR+nuiaIQ
 CNt/P+GtokWDaknu/D346I71mNYhm/cHImof6ZfmrmOCmx4eOK0LzMl
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

From: Christoph Hellwig <hch@lst.de>

btrfs_scan_one_device opens the block device only to read the super
block.  Instead of passing a blk_mode_t argument to sometimes open
it for writing, just hard code BLK_OPEN_READ as it will never write
to the device or hand the block_device out to someone else.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/super.c   | 9 ++++-----
 fs/btrfs/volumes.c | 4 ++--
 fs/btrfs/volumes.h | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 40ae264fd3ed..b6cadf4f21b8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -299,10 +299,9 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_device: {
 		struct btrfs_device *device;
-		blk_mode_t mode = btrfs_open_mode(fc);
 
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(param->string, mode, false);
+		device = btrfs_scan_one_device(param->string, false);
 		mutex_unlock(&uuid_mutex);
 		if (IS_ERR(device))
 			return PTR_ERR(device);
@@ -1808,7 +1807,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	 * With 'true' passed to btrfs_scan_one_device() (mount time) we expect
 	 * either a valid device or an error.
 	 */
-	device = btrfs_scan_one_device(fc->source, mode, true);
+	device = btrfs_scan_one_device(fc->source, true);
 	ASSERT(device != NULL);
 	if (IS_ERR(device)) {
 		mutex_unlock(&uuid_mutex);
@@ -2210,7 +2209,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		 * Scanning outside of mount can return NULL which would turn
 		 * into 0 error code.
 		 */
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		device = btrfs_scan_one_device(vol->name, false);
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
 		break;
@@ -2228,7 +2227,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		 * Scanning outside of mount can return NULL which would turn
 		 * into 0 error code.
 		 */
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		device = btrfs_scan_one_device(vol->name, false);
 		if (IS_ERR_OR_NULL(device)) {
 			mutex_unlock(&uuid_mutex);
 			ret = PTR_ERR(device);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4ad9eca9b46c..44caf1a48d33 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1308,7 +1308,7 @@ int btrfs_forget_devices(dev_t devt)
  * the device or return an error. Multi-device and seeding devices are registered
  * in both cases.
  */
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   bool mount_arg_dev)
 {
 	struct btrfs_super_block *disk_super;
@@ -1337,7 +1337,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev_handle = bdev_open_by_path(path, flags, NULL, NULL);
+	bdev_handle = bdev_open_by_path(path, BLK_OPEN_READ, NULL, NULL);
 	if (IS_ERR(bdev_handle))
 		return ERR_CAST(bdev_handle);
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 21d4de0e3f1f..97c7284e7565 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -655,7 +655,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   bool mount_arg_dev);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);

-- 
2.43.0


