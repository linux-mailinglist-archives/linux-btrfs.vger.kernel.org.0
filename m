Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9613539F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 08:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgAIHRJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 02:17:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:60864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728229AbgAIHRI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 02:17:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1C4F3B183;
        Thu,  9 Jan 2020 07:17:07 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marc Lehmann <schmorp@schmorp.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v5 3/4] btrfs: space-info: Use per-profile available space in can_overcommit()
Date:   Thu,  9 Jan 2020 15:16:33 +0800
Message-Id: <20200109071634.32384-4-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109071634.32384-1-wqu@suse.com>
References: <20200109071634.32384-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the following disk layout, can_overcommit() can cause false
confidence in available space:

  devid 1 unallocated:	1T
  devid 2 unallocated:	10T
  metadata type:	RAID1

As can_overcommit() simply uses unallocated space with factor to
calculate the allocatable metadata chunk size.

can_overcommit() believes we still have 5.5T for metadata chunks, while
the truth is, we only have 1T available for metadata chunks.
This can lead to ENOSPC at run_delalloc_range() and cause transaction
abort.

Since factor based calculation can't distinguish RAID1/RAID10 and DUP at
all, we need proper chunk-allocator level awareness to do such estimation.

Thankfully, we have per-profile available space already calculated, just
use that facility to avoid such false confidence.

Reported-by: Marc Lehmann <schmorp@schmorp.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f09aa6ee9113..c26aba9e7124 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -164,10 +164,10 @@ static int can_overcommit(struct btrfs_fs_info *fs_info,
 			  enum btrfs_reserve_flush_enum flush,
 			  bool system_chunk)
 {
+	enum btrfs_raid_types index;
 	u64 profile;
 	u64 avail;
 	u64 used;
-	int factor;
 
 	/* Don't overcommit when in mixed mode. */
 	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA)
@@ -179,16 +179,15 @@ static int can_overcommit(struct btrfs_fs_info *fs_info,
 		profile = btrfs_metadata_alloc_profile(fs_info);
 
 	used = btrfs_space_info_used(space_info, true);
-	avail = atomic64_read(&fs_info->free_chunk_space);
 
 	/*
-	 * If we have dup, raid1 or raid10 then only half of the free
-	 * space is actually usable.  For raid56, the space info used
-	 * doesn't include the parity drive, so we don't have to
-	 * change the math
+	 * Grab avail space from per-profile array which should be as accurate
+	 * as chunk allocator.
 	 */
-	factor = btrfs_bg_type_to_factor(profile);
-	avail = div_u64(avail, factor);
+	index = btrfs_bg_flags_to_raid_index(profile);
+	spin_lock(&fs_info->fs_devices->per_profile_lock);
+	avail = fs_info->fs_devices->per_profile_avail[index];
+	spin_unlock(&fs_info->fs_devices->per_profile_lock);
 
 	/*
 	 * If we aren't flushing all things, let us overcommit up to
-- 
2.24.1

