Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4073D5948
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbhGZLhf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:37:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58030 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbhGZLhf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:37:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 67FC41FE75;
        Mon, 26 Jul 2021 12:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627301883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KY0arM9U5nnr443jkTo8f7yWSbADcmG7i4Sz2AVb3TA=;
        b=sE3WKQoj4WTs4xWtIhSYH2vNsFXT1xo2kaYpJ0bbyFkLLFP5XnjYJvmM6Ue23EFP2XdqGf
        2ERCO/5st4kQNDnxQ5B24ITdmly7OxxN+jkiFEZLYn1zhyNf93XtxPkJx/QzFbGY/0ZVjR
        2oje2p8viUTyLgDywEuGAl4tA4VzdD0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6166AA3C39;
        Mon, 26 Jul 2021 12:18:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A9F03DA8D8; Mon, 26 Jul 2021 14:15:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 06/10] btrfs: uninline btrfs_bg_flags_to_raid_index
Date:   Mon, 26 Jul 2021 14:15:19 +0200
Message-Id: <6a4949f84e640c299bf7b1d0898e54895b76c0c7.1627300614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627300614.git.dsterba@suse.com>
References: <cover.1627300614.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper does a simple translation from block group flags to index to
the btrfs_raid_array table. There's no apparent reason to inline the
function, the translation happens usually once per function and is not
called in a loop.

Making it a proper function saves quite some binary code (x86_64,
release config):

   text    data     bss     dec     hex filename
1164011   19253   14912 1198176  124860 pre/btrfs.ko
1161559   19253   14912 1195724  123ecc post/btrfs.ko

DELTA: -2451

Also add the const attribute as there are no side effects, this could
help compiler to optimize a few things without the function body.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 26 ++++++++++++++++++++++++++
 fs/btrfs/volumes.h | 27 +--------------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 86846d6e58d0..19feb64586fc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -153,6 +153,32 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	},
 };
 
+/*
+ * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types, which
+ * can be used as index to access btrfs_raid_array[].
+ */
+enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags)
+{
+	if (flags & BTRFS_BLOCK_GROUP_RAID10)
+		return BTRFS_RAID_RAID10;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID1)
+		return BTRFS_RAID_RAID1;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
+		return BTRFS_RAID_RAID1C3;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
+		return BTRFS_RAID_RAID1C4;
+	else if (flags & BTRFS_BLOCK_GROUP_DUP)
+		return BTRFS_RAID_DUP;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
+		return BTRFS_RAID_RAID0;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID5)
+		return BTRFS_RAID_RAID5;
+	else if (flags & BTRFS_BLOCK_GROUP_RAID6)
+		return BTRFS_RAID_RAID6;
+
+	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
+}
+
 const char *btrfs_bg_type_to_raid_name(u64 flags)
 {
 	const int index = btrfs_bg_flags_to_raid_index(flags);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 70c749eee3ad..b082250b42e0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -566,32 +566,6 @@ static inline void btrfs_dev_stat_set(struct btrfs_device *dev,
 	atomic_inc(&dev->dev_stats_ccnt);
 }
 
-/*
- * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types, which
- * can be used as index to access btrfs_raid_array[].
- */
-static inline enum btrfs_raid_types btrfs_bg_flags_to_raid_index(u64 flags)
-{
-	if (flags & BTRFS_BLOCK_GROUP_RAID10)
-		return BTRFS_RAID_RAID10;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID1)
-		return BTRFS_RAID_RAID1;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID1C3)
-		return BTRFS_RAID_RAID1C3;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID1C4)
-		return BTRFS_RAID_RAID1C4;
-	else if (flags & BTRFS_BLOCK_GROUP_DUP)
-		return BTRFS_RAID_DUP;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID0)
-		return BTRFS_RAID_RAID0;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID5)
-		return BTRFS_RAID_RAID5;
-	else if (flags & BTRFS_BLOCK_GROUP_RAID6)
-		return BTRFS_RAID_RAID6;
-
-	return BTRFS_RAID_SINGLE; /* BTRFS_BLOCK_GROUP_SINGLE */
-}
-
 void btrfs_commit_device_sizes(struct btrfs_transaction *trans);
 
 struct list_head * __attribute_const__ btrfs_get_fs_uuids(void);
@@ -601,6 +575,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 			       struct block_device *bdev,
 			       const char *device_path);
 
+enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags);
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
-- 
2.31.1

