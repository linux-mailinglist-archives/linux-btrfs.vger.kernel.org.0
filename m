Return-Path: <linux-btrfs+bounces-4827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0AE8BFBD8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 13:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF751C21DCB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D583A07;
	Wed,  8 May 2024 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6tayK/q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1383A18
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167244; cv=none; b=MxCALQYQEM3db4wcRB0TAVbGoCXQy8uYABD76O8R4iQKopPWdG3JBexi/YX/+hA9Z0+SfRkwM5RMqCheAPtZdFledfQ8GOplDB8flqUbILT7ggtb4URmFWkpglDW0OzYstH+fkLIG7dOqzraEL6LtmOiwlXBmWAQ9zkoHX8RF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167244; c=relaxed/simple;
	bh=GUTs7K2WDJTG+eTefm7pzTtWbn2odWBiwEL2z9edGcw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=obUFcIrQPuX09CbvspG7MHOlUdzu+kZiChdQXI0FjVNdf1xhpiGPjD41Ma3G+JQzhRsjdudNV4ZCZov02zLJ+WyJA5hmjX9nDEP7cyzQFN/QrWL9Q5iE1X/UKTKoU0Ez+EeCVpqhmetgSwW0WHmllqpmMKuz/FxXnUUiQ1rN6EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6tayK/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C50C113CC
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 11:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715167244;
	bh=GUTs7K2WDJTG+eTefm7pzTtWbn2odWBiwEL2z9edGcw=;
	h=From:To:Subject:Date:From;
	b=Q6tayK/qPpRIEwQKEro9eudQ1A2PCqwJr3BH+ExQoXu1oXnF5WXF61+VuxhEGtUz5
	 T/1UbgCLAoZSStPwG1yZyDoghlF/v7v0UHsVUX9gkgCOw2QtXVj5XDQJXoEdvfTbu3
	 aq+4ED2qZlbGPzH9mBuZFt9WuClWvOb7Fkq4U8obqoOUj/vAMkl4B2nTzUOoGP3o0u
	 18pv4OgiA9KovhPIPb9HMSPSO9roSA1MH552ukMl1ZUtg4MO4ghWonTXCHmlQ5SJ61
	 RsO2fP6d+b816J2oOrzfrM0Osr5R1LbU2OCfeoDDMdsgGILc20l2NwwrNVyPs44k5g
	 DAe6v62eCeu8Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: fix use-after-free due to race with dev replace
Date: Wed,  8 May 2024 12:20:40 +0100
Message-Id: <ccab86c78fc2a1fd6dd320efa289863df7158ca9.1715167144.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

While loading a zone's info during creation of a block group, we can race
with a device replace operation and then trigger a use-after-free on the
device that was just replaced (source device of the replace operation).

This happens because at btrfs_load_zone_info() we extract a device from
the chunk map into a local variable and then use the device while not
under the protection of the device replace rwsem. So if there's a device
replace operation happening when we extract the device and that device
is the source of the replace operation, we will trigger a use-after-free
if before we finish using the device the replace operaton finishes and
frees the device.

Fix this by enlarging the critical section under the protection of the
device replace rwsem so that all uses of the device are done inside the
critical section.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/zoned.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index aeab33708702..eb70fd80dbc5 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1290,7 +1290,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 				struct btrfs_chunk_map *map)
 {
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
-	struct btrfs_device *device = map->stripes[zone_idx].dev;
+	struct btrfs_device *device;
 	int dev_replace_is_ongoing = 0;
 	unsigned int nofs_flag;
 	struct blk_zone zone;
@@ -1298,7 +1298,11 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 
 	info->physical = map->stripes[zone_idx].physical;
 
+	down_read(&dev_replace->rwsem);
+	device = map->stripes[zone_idx].dev;
+
 	if (!device->bdev) {
+		up_read(&dev_replace->rwsem);
 		info->alloc_offset = WP_MISSING_DEV;
 		return 0;
 	}
@@ -1308,6 +1312,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 		__set_bit(zone_idx, active);
 
 	if (!btrfs_dev_is_sequential(device, info->physical)) {
+		up_read(&dev_replace->rwsem);
 		info->alloc_offset = WP_CONVENTIONAL;
 		return 0;
 	}
@@ -1315,11 +1320,9 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	/* This zone will be used for allocation, so mark this zone non-empty. */
 	btrfs_dev_clear_zone_empty(device, info->physical);
 
-	down_read(&dev_replace->rwsem);
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
 		btrfs_dev_clear_zone_empty(dev_replace->tgtdev, info->physical);
-	up_read(&dev_replace->rwsem);
 
 	/*
 	 * The group is mapped to a sequential zone. Get the zone write pointer
@@ -1330,6 +1333,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	ret = btrfs_get_dev_zone(device, info->physical, &zone);
 	memalloc_nofs_restore(nofs_flag);
 	if (ret) {
+		up_read(&dev_replace->rwsem);
 		if (ret != -EIO && ret != -EOPNOTSUPP)
 			return ret;
 		info->alloc_offset = WP_MISSING_DEV;
@@ -1341,6 +1345,7 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 		"zoned: unexpected conventional zone %llu on device %s (devid %llu)",
 			zone.start << SECTOR_SHIFT, rcu_str_deref(device->name),
 			device->devid);
+		up_read(&dev_replace->rwsem);
 		return -EIO;
 	}
 
@@ -1368,6 +1373,8 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 		break;
 	}
 
+	up_read(&dev_replace->rwsem);
+
 	return 0;
 }
 
-- 
2.43.0


