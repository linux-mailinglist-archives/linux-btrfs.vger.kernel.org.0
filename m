Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 737AE104CEE
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 08:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfKUHzB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 02:55:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:44374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbfKUHzB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 02:55:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0C87ADBF
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 07:54:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [RFC PATCH] btrfs: Commit transaction to workaround ENOSPC during relocation
Date:   Thu, 21 Nov 2019 15:54:55 +0800
Message-Id: <20191121075455.31383-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When doing full balance for certain fs, it can cause unexpected ENOSPC:
  BTRFS info (device loop0p3): balance: start -d -m -s
  BTRFS info (device loop0p3): relocating block group 1104150528 flags data
  BTRFS info (device loop0p3): found 14659 extents
  BTRFS info (device loop0p3): found 14659 extents
  BTRFS info (device loop0p3): unable to make block group 30408704 ro
  BTRFS info (device loop0p3): sinfo_used=2298347520 bg_num_bytes=1046872064 min_allocable=1048576
  BTRFS info (device loop0p3): space_info 4 has 18446744072492285952 free, is not full
  BTRFS info (device loop0p3): space_info total=1073741824, used=24281088, pinned=1277952, reserved=1245184, may_use=2264137728, readonly=65536
  BTRFS info (device loop0p3): global_block_rsv: size 3407872 reserved 3407872
  BTRFS info (device loop0p3): trans_block_rsv: size 0 reserved 0
  BTRFS info (device loop0p3): chunk_block_rsv: size 0 reserved 0
  BTRFS info (device loop0p3): delayed_block_rsv: size 0 reserved 0
  BTRFS info (device loop0p3): delayed_refs_rsv: size 2260205568 reserved 2260205568
  BTRFS info (device loop0p3): unable to make block group 30408704 ro
  BTRFS info (device loop0p3): sinfo_used=2289958912 bg_num_bytes=1046872064 min_allocable=1048576
  BTRFS info (device loop0p3): space_info 4 has 18446744072792424448 free, is not full
  BTRFS info (device loop0p3): space_info total=1342177280, used=24281088, pinned=1277952, reserved=1261568, may_use=2232418304, readonly=65536
  BTRFS info (device loop0p3): global_block_rsv: size 3407872 reserved 3407872
  BTRFS info (device loop0p3): trans_block_rsv: size 0 reserved 0
  BTRFS info (device loop0p3): chunk_block_rsv: size 393216 reserved 393216
  BTRFS info (device loop0p3): delayed_block_rsv: size 0 reserved 0
  BTRFS info (device loop0p3): delayed_refs_rsv: size 2228486144 reserved 2228486144
  BTRFS info (device loop0p3): unable to make block group 22020096 ro
  BTRFS info (device loop0p3): sinfo_used=32768 bg_num_bytes=8355840 min_allocable=1048576
  BTRFS info (device loop0p3): space_info 2 has 8355840 free, is not full
  BTRFS info (device loop0p3): space_info total=8388608, used=16384, pinned=0, reserved=16384, may_use=0, readonly=0
  BTRFS info (device loop0p3): global_block_rsv: size 3407872 reserved 3407872
  BTRFS info (device loop0p3): trans_block_rsv: size 0 reserved 0
  BTRFS info (device loop0p3): chunk_block_rsv: size 0 reserved 0
  BTRFS info (device loop0p3): delayed_block_rsv: size 0 reserved 0
  BTRFS info (device loop0p3): delayed_refs_rsv: size 2093481984 reserved 2093481984

[CAUSE]
For data block group 1104150528, it has 14659 extents got relocated,
thus its data inode (inode for relocation, records all newerly relocated
data) can be pretty big, with exactly 14659 non-hole data extents.

That would cause a lot of space being reserved for delayed_refs, that's
more or less acceptable for regular inodes.

And unfortunately, currently we are already over-esitmating to ensure we
will have enough space for delayed refs updates, so we reserved around
2.2G space just to delete that data inode.

Then we are going to relocate the next block group, our metadata block
group is only 1G, but has already reserved 2.2G, there is no wonder we
will fail with ENOSPC.

[WORKAROUND]
The real fix needs to rework how we calculate reserved space for
delayed_refs_rsv.

But at least, we can work around this false ENOSPC, by commit
transaction immediately after putting that data inode.

There will be still a window where our metadata space is exhausted, but
that would still be better than returning ENOSPC.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:
Obviously, this is a pretty bad workaround, just trying to make it work
for balance.

In fact, if we're just deleting a super fragemented file, it could cause
the problem, and this patch can't address it.

I'm still looking into the delayed_refs_rsv part for
btrfs_evict_inode(), so this patch is definitely not a good solution.

But this RFC itself may inspire us to get better solution.
---
 fs/btrfs/volumes.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e04409f85063..f23590f71135 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3091,7 +3091,22 @@ static int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
 	 * chunk tree entries
 	 */
 	ret = btrfs_remove_chunk(trans, chunk_offset);
-	btrfs_end_transaction(trans);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
+
+	/*
+	 * If the block group has a lot of extents (common for data block
+	 * groups) we may have too many block rsv for delayed_refs, which
+	 * may cause ENOSPC for the next balance.
+	 *
+	 * The root fix is to make delayed_refs estimation more accurate,
+	 * but here we can commit transaction to run delayed refs so that
+	 * delayed_refs_rsv will be reset to regular level.
+	 */
+	ret = btrfs_commit_transaction(trans);
 	return ret;
 }
 
-- 
2.24.0

