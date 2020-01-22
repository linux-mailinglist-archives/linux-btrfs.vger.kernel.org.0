Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB044144DCD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 09:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgAVIhC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 03:37:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:34892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgAVIhC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 03:37:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 987DAAE0D;
        Wed, 22 Jan 2020 08:36:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH RFC] btrfs: scrub: Mandatory RO block group for device replace
Date:   Wed, 22 Jan 2020 16:36:28 +0800
Message-Id: <20200122083628.16331-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
btrfs/06[45] btrfs/071 could fail by finding csum error.
The reproducibility is not high, around 1/20~1/100, needs to run them in
loops.

And the profile doesn't make much difference, SINGLE/SINGLE can also
reproduce the problem.

The bug is observable after commit b12de52896c0 ("btrfs: scrub: Don't
check free space before marking a block group RO")

[CAUSE]
Device replace reuses scrub code to iterate existing extents.

It adds scrub_write_block_to_dev_replace() to scrub_block_complete(), so
that scrub read can write the verified data to target device.

Device replace also utilizes "write duplication" to write new data to
both source and target device.

However those two write can conflict and may lead to data corruption:
- Scrub writes old data from commit root
  Both extent location and csum are fetched from commit root, which
  is not always the up-to-date data.

- Write duplication is always duplicating latest data

This means there could be a race, that "write duplication" writes the
latest data to disk, then scrub write back the old data, causing data
corruption.

In theory, this should only affects data, not metadata.
Metadata write back only happens when committing transaction, thus it's
always after scrub writes.

[FIX]
Make dev-replace to require mandatory RO for target block group.

And to be extra safe, for dev-replace, wait for all exiting writes to
finish before scrubbing the chunk.

This patch will mostly revert commit 76a8efa171bf ("btrfs: Continue replace
when set_block_ro failed").
ENOSPC for dev-replace is still much better than data corruption.

Reported-by: Filipe Manana <fdmanana@suse.com>
Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed")
Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before marking a block group RO")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Not concretely confirmed, mostly through guess, thus it has RFC tag.

My first guess is race at the dev-replace starting point, but related
code is in fact very safe.
---
 fs/btrfs/scrub.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 21de630b0730..69e76a4d1258 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3472,6 +3472,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	struct btrfs_path *path;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
+	bool is_dev_replace = sctx->is_dev_replace;
 	u64 length;
 	u64 chunk_offset;
 	int ret = 0;
@@ -3577,17 +3578,35 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * This can easily boost the amount of SYSTEM chunks if cleaner
 		 * thread can't be triggered fast enough, and use up all space
 		 * of btrfs_super_block::sys_chunk_array
+		 *
+		 *
+		 * On the other hand, try our best to mark block group RO for
+		 * dev-replace case.
+		 *
+		 * Dev-replace has two types of write:
+		 * - Write duplication
+		 *   New write will be written to both target and source device
+		 *   The content is always the *newest* data.
+		 * - Scrub write for dev-replace
+		 *   Scrub will write the verified data for dev-replace.
+		 *   The data and its csum are all from *commit* root, which
+		 *   is not the newest version.
+		 *
+		 * If scrub write happens after write duplication, we would
+		 * cause data corruption.
+		 * So we need to try our best to mark block group RO, and exit
+		 * out if we don't have enough space.
 		 */
-		ret = btrfs_inc_block_group_ro(cache, false);
+		ret = btrfs_inc_block_group_ro(cache, is_dev_replace);
 		scrub_pause_off(fs_info);
 
 		if (ret == 0) {
 			ro_set = 1;
-		} else if (ret == -ENOSPC) {
+		} else if (ret == -ENOSPC && !is_dev_replace) {
 			/*
 			 * btrfs_inc_block_group_ro return -ENOSPC when it
 			 * failed in creating new chunk for metadata.
-			 * It is not a problem for scrub/replace, because
+			 * It is not a problem for scrub, because
 			 * metadata are always cowed, and our scrub paused
 			 * commit_transactions.
 			 */
@@ -3605,6 +3624,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		dev_replace->item_needs_writeback = 1;
 		up_write(&dev_replace->rwsem);
 
+		/*
+		 * Also wait for any exitings writes to prevent race between
+		 * write duplication and scrub writes.
+		 */
+		if (is_dev_replace) {
+			btrfs_wait_block_group_reservations(cache);
+			btrfs_wait_nocow_writers(cache);
+			btrfs_wait_ordered_roots(fs_info, U64_MAX,
+					cache->start, cache->length);
+		}
 		ret = scrub_chunk(sctx, scrub_dev, chunk_offset, length,
 				  found_key.offset, cache);
 
-- 
2.25.0

