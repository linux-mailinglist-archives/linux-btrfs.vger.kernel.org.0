Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBAE1EB809
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 11:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgFBJJT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 05:09:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:43008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgFBJJS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jun 2020 05:09:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A5924AC2C;
        Tue,  2 Jun 2020 09:09:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Marc Lehmann <schmorp@schmorp.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v9 2/5] btrfs: space-info: Use per-profile available space in can_overcommit()
Date:   Tue,  2 Jun 2020 17:09:02 +0800
Message-Id: <20200602090905.63899-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602090905.63899-1-wqu@suse.com>
References: <20200602090905.63899-1-wqu@suse.com>
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
 fs/btrfs/space-info.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 41ee88633769..f3b4e14f3727 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -310,25 +310,21 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 			  struct btrfs_space_info *space_info,
 			  enum btrfs_reserve_flush_enum flush)
 {
+	enum btrfs_raid_types index;
 	u64 profile;
 	u64 avail;
-	int factor;
 
 	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		profile = btrfs_system_alloc_profile(fs_info);
 	else
 		profile = btrfs_metadata_alloc_profile(fs_info);
 
-	avail = atomic64_read(&fs_info->free_chunk_space);
-
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
+	avail = atomic64_read(&fs_info->fs_devices->per_profile_avail[index]);
 
 	/*
 	 * If we aren't flushing all things, let us overcommit up to
-- 
2.26.2

