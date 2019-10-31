Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42D64EB3AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Oct 2019 16:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfJaPNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Oct 2019 11:13:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:50816 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728322AbfJaPNo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Oct 2019 11:13:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55194B70B;
        Thu, 31 Oct 2019 15:13:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7032BDA783; Thu, 31 Oct 2019 16:13:52 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 4/4] btrfs: drop incompat bit for raid1c34 after last block group is gone
Date:   Thu, 31 Oct 2019 16:13:52 +0100
Message-Id: <2a2499584174577af5d939302d7e2abdd68f5c12.1572534591.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572534591.git.dsterba@suse.com>
References: <cover.1572534591.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When there are no raid1c3 or raid1c4 block groups left after balance
(either convert or with other filters applied), remove the incompat bit.
This is already done for RAID56, do the same for RAID1C34.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1e521db3ef56..9ce9c2e318cf 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -828,27 +828,36 @@ static void clear_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
  *
  * - RAID56 - in case there's neither RAID5 nor RAID6 profile block group
  *            in the whole filesystem
+ *
+ * - RAID1C34 - same as above for RAID1C3 and RAID1C4 block groups
  */
 static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
 {
-	if (flags & BTRFS_BLOCK_GROUP_RAID56_MASK) {
+	bool found_raid56 = false;
+	bool found_raid1c34 = false;
+
+	if ((flags & BTRFS_BLOCK_GROUP_RAID56_MASK) ||
+	    (flags & BTRFS_BLOCK_GROUP_RAID1C3) ||
+	    (flags & BTRFS_BLOCK_GROUP_RAID1C4)) {
 		struct list_head *head = &fs_info->space_info;
 		struct btrfs_space_info *sinfo;
 
 		list_for_each_entry_rcu(sinfo, head, list) {
-			bool found = false;
-
 			down_read(&sinfo->groups_sem);
 			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5]))
-				found = true;
+				found_raid56 = true;
 			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID6]))
-				found = true;
+				found_raid56 = true;
+			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID1C3]))
+				found_raid1c34 = true;
+			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID1C4]))
+				found_raid1c34 = true;
 			up_read(&sinfo->groups_sem);
-
-			if (found)
-				return;
 		}
-		btrfs_clear_fs_incompat(fs_info, RAID56);
+		if (found_raid56)
+			btrfs_clear_fs_incompat(fs_info, RAID56);
+		if (found_raid1c34)
+			btrfs_clear_fs_incompat(fs_info, RAID1C34);
 	}
 }
 
-- 
2.23.0

