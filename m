Return-Path: <linux-btrfs+bounces-16346-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA432B33F18
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 14:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE1B16353D
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54C31FDA94;
	Mon, 25 Aug 2025 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBajd0R8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964327780C;
	Mon, 25 Aug 2025 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756124116; cv=none; b=FKzUi69nIre67QVH1e/5NkEKa4mdgsFLwvMttjY1hqQwGKm5MHMqLeaZnMgzl18QmD0mKTgtnlwClp1siRsNXSMCkardxgAA8Zp/JTGKPgjTOFk7kKDtirTwxUnCzimygPgtlMvU/rxNZG5lcQm0Fun9QdZ2829fMPk+MEh827A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756124116; c=relaxed/simple;
	bh=U4QdAVzcoPl3yGc12zC0FvoLJYOhc0k6UX3CH+eLHNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXpLxx3nUx58GSZUs+nalTcBe6ULBLg/9vi5trfYSOtdThQnMAUPqnn349alj5nQDgqyZMPkQPbDdwktlwrz4S6zFpfNnlfhoD4xhn6M11Bd/hHiO6fMuhjoeXs97dRG7OizTgky5te+XTBHg1yYq4H2WtwPbouTeHtrd/X0Mh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBajd0R8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCCAC4CEED;
	Mon, 25 Aug 2025 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756124116;
	bh=U4QdAVzcoPl3yGc12zC0FvoLJYOhc0k6UX3CH+eLHNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBajd0R8KkE3ylCqbZpPpjoqqP/748NCTfsLHuKYZZoHPwuh1bBqeqUypUijoE9Y1
	 6iv2WLJFCA+Rfb3oMoOS7DCvE6l7Eo4SYG/xFi4zZb7nRoD8PHgurdKleTNFHJFxeW
	 pLQT0R48p9tXSv7y42RCyHh8JD8a7dASazLameCuTssPxL1O08YNMc0uxJQ8RbSE6R
	 Wa4RHcq4OgWR4lJADkH78j3uql1XDG2oQJBT6OkWUUdgN/pRO1jHTJC7gY6A2ukhYw
	 BCBDJtAsfIpAS1H0vUjiPBkzmDmV0XC1hHRy5NJH8ZAfUzYn6EzyvnP1QK3pQ84KTL
	 qhwjE36g7zAvA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	clm@fb.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-6.12] btrfs: zoned: skip ZONE FINISH of conventional zones
Date: Mon, 25 Aug 2025 08:14:56 -0400
Message-ID: <20250825121505.2983941-7-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825121505.2983941-1-sashal@kernel.org>
References: <20250825121505.2983941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16.3
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit f0ba0e7172a222ea6043b61ecd86723c46d7bcf2 ]

Don't call ZONE FINISH for conventional zones as this will result in I/O
errors. Instead check if the zone that needs finishing is a conventional
zone and if yes skip it.

Also factor out the actual handling of finishing a single zone into a
helper function, as do_zone_finish() is growing ever bigger and the
indentations levels are getting higher.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

## Bug Fix Analysis

1. **Critical Bug Fix**: The commit fixes a concrete bug where calling
   `REQ_OP_ZONE_FINISH` on conventional zones results in I/O errors.
   This is a real runtime error that affects users of btrfs on zoned
   storage devices that have conventional zones mixed with sequential
   zones.

2. **Small and Contained Change**: The fix is relatively small and well-
   contained:
   - Adds a new helper function `call_zone_finish()` that encapsulates
     the zone finishing logic
   - Most importantly, adds the critical check: `if
     (btrfs_dev_is_sequential(device, physical))` before issuing the
     `REQ_OP_ZONE_FINISH` operation
   - The refactoring merely moves existing code into the helper function
     without changing the logic

3. **Clear Root Cause**: The bug occurs because the original code
   unconditionally calls `blkdev_zone_mgmt()` with `REQ_OP_ZONE_FINISH`
   on all zones, but this operation is invalid for conventional zones
   (non-sequential zones). The fix properly checks if a zone is
   sequential before attempting to finish it.

4. **No New Features**: This commit doesn't introduce any new
   functionality - it's purely a bug fix that prevents I/O errors.

5. **Minimal Risk**: The change has minimal risk of regression:
   - The check for sequential zones is straightforward
   - The refactoring doesn't change the existing logic flow
   - The fix has been reviewed by multiple developers familiar with the
     zoned code

6. **Affects Real Users**: This bug affects users running btrfs on SMR
   (Shingled Magnetic Recording) drives or ZNS (Zoned Namespace) SSDs
   that have a mix of conventional and sequential zones, which is a
   common configuration.

## Code Analysis

The key fix in `call_zone_finish()` at line 2262:
```c
if (btrfs_dev_is_sequential(device, physical)) {
    // Only call zone finish for sequential zones
    ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH, ...);
}
```

This prevents the invalid operation on conventional zones while
maintaining the correct behavior for sequential zones. The subsequent
operations (updating reserved_active_zones and clearing active zone) are
still performed regardless of zone type, which is the correct behavior.

The commit follows stable kernel rules perfectly: it's a clear bug fix,
has minimal changes, doesn't introduce new features, and addresses a
real user-facing issue that causes I/O errors.

 fs/btrfs/zoned.c | 55 ++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5439d8374716..950e72dc537c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2246,6 +2246,40 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
 	rcu_read_unlock();
 }
 
+static int call_zone_finish(struct btrfs_block_group *block_group,
+			    struct btrfs_io_stripe *stripe)
+{
+	struct btrfs_device *device = stripe->dev;
+	const u64 physical = stripe->physical;
+	struct btrfs_zoned_device_info *zinfo = device->zone_info;
+	int ret;
+
+	if (!device->bdev)
+		return 0;
+
+	if (zinfo->max_active_zones == 0)
+		return 0;
+
+	if (btrfs_dev_is_sequential(device, physical)) {
+		unsigned int nofs_flags;
+
+		nofs_flags = memalloc_nofs_save();
+		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
+				       physical >> SECTOR_SHIFT,
+				       zinfo->zone_size >> SECTOR_SHIFT);
+		memalloc_nofs_restore(nofs_flags);
+
+		if (ret)
+			return ret;
+	}
+
+	if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
+		zinfo->reserved_active_zones++;
+	btrfs_dev_clear_active_zone(device, physical);
+
+	return 0;
+}
+
 static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
@@ -2330,31 +2364,12 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	down_read(&dev_replace->rwsem);
 	map = block_group->physical_map;
 	for (i = 0; i < map->num_stripes; i++) {
-		struct btrfs_device *device = map->stripes[i].dev;
-		const u64 physical = map->stripes[i].physical;
-		struct btrfs_zoned_device_info *zinfo = device->zone_info;
-		unsigned int nofs_flags;
-
-		if (!device->bdev)
-			continue;
-
-		if (zinfo->max_active_zones == 0)
-			continue;
-
-		nofs_flags = memalloc_nofs_save();
-		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
-				       physical >> SECTOR_SHIFT,
-				       zinfo->zone_size >> SECTOR_SHIFT);
-		memalloc_nofs_restore(nofs_flags);
 
+		ret = call_zone_finish(block_group, &map->stripes[i]);
 		if (ret) {
 			up_read(&dev_replace->rwsem);
 			return ret;
 		}
-
-		if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
-			zinfo->reserved_active_zones++;
-		btrfs_dev_clear_active_zone(device, physical);
 	}
 	up_read(&dev_replace->rwsem);
 
-- 
2.50.1


