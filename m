Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67ED21462B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 08:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgAWHiG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 02:38:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:55876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgAWHiG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 02:38:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E66E5B1EC;
        Thu, 23 Jan 2020 07:38:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: scrub: Require mandatory block group RO for dev-replace
Date:   Thu, 23 Jan 2020 15:37:59 +0800
Message-Id: <20200123073759.23535-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For dev-replace test cases with fsstress, like btrfs/06[45] btrfs/071,
looped runs can lead to random failure, where scrub finds csum error.

The possibility is not high, around 1/20 to 1/100, but it's causing data
corruption.

The bug is observable after commit b12de52896c0 ("btrfs: scrub: Don't
check free space before marking a block group RO")

[CAUSE]
Dev-replace has two source of writes:
- Write duplication
  All writes to source device will also be duplicated to target device.

  Content:	Latest data/meta

- Scrub copy
  Dev-replace reused scrub code to iterate through existing extents, and
  copy the verified data to target device.

  Content:	Data/meta in commit root

The difference in contents makes the following race possible:
	Regular Writer		|	Dev-replace
-----------------------------------------------------------------
  ^                             |
  | Preallocate one data extent |
  | at bytenr X, len 1M		|
  v				|
  ^ Commit transaction		|
  | Now extent [X, X+1M) is in  |
  v commit root			|
 ================== Dev replace starts =========================
  				| ^
				| | Scrub extent [X, X+1M)
				| | Read [X, X+1M)
				| | (The content are mostly garbage
				| |  since it's preallocated)
  ^				| v
  | Write back happens for	|
  | extent [X, X+512K)		|
  | New data writes to both	|
  | source and target dev.	|
  v				|
				| ^
				| | Scrub writes back extent [X, X+1M)
				| | to target device.
				| | This will over write the new data in
				| | [X, X+512K)
				| v

This race can only happen for nocow writes. Thus metadata and data cow
writes are safe, as COW will never overwrite extents of previous trans
(in commit root).

This behavior can be confirmed by disabling all fallocate related calls
in fsstress (*), then all related tests can pass a 2000 run loop.

*: FSSTRESS_AVOID="-f fallocate=0 -f allocsp=0 -f zero=0 -f insert=0 \
		   -f collapse=0 -f punch=0 -f resvsp=0"
   I didn't expect resvsp ioctl will fallback to fallocate in VFS...

[FIX]
Make dev-replace to require mandatory block group RO, and wait for current
nocow writes before calling scrub_chunk().

This patch will mostly revert commit 76a8efa171bf ("btrfs: Continue replace
when set_block_ro failed") for dev-replace path.

ENOSPC for dev-replace is still much better than data corruption.

Reported-by: Filipe Manana <fdmanana@suse.com>
Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed")
Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before marking a block group RO")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
RFC->v1:
- Remove the RFC tag
  Since the cause is pinned and verified, no need for RFC.

- Only wait for nocow writes for dev-replace
  CoW writes are safe as they will never overwrite extents in commit
  root.

- Put the wait call into proper lock context
  Previous wait happens after scrub_pause_off(), which can cause
  deadlock where we may need to commit transaction in one of the
  wait calls. But since we are in scrub_pause_off() environment,
  transaction commit will wait us to continue, causing a wait-on-self
  deadlock.
---
 fs/btrfs/scrub.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 21de630b0730..5aa486cad298 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3577,17 +3577,27 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * This can easily boost the amount of SYSTEM chunks if cleaner
 		 * thread can't be triggered fast enough, and use up all space
 		 * of btrfs_super_block::sys_chunk_array
+		 *
+		 * While for dev replace, we need to try our best to mark block
+		 * group RO, to prevent race between:
+		 * - Write duplication
+		 *   Contains latest data
+		 * - Scrub copy
+		 *   Contains data from commit tree
+		 *
+		 * If target block group is not marked RO, nocow writes can
+		 * be overwritten by scrub copy, causing data corruption.
+		 * So for dev-replace, it's not allowed to continue if a block
+		 * group is not RO.
 		 */
-		ret = btrfs_inc_block_group_ro(cache, false);
-		scrub_pause_off(fs_info);
-
+		ret = btrfs_inc_block_group_ro(cache, sctx->is_dev_replace);
 		if (ret == 0) {
 			ro_set = 1;
-		} else if (ret == -ENOSPC) {
+		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
 			/*
 			 * btrfs_inc_block_group_ro return -ENOSPC when it
 			 * failed in creating new chunk for metadata.
-			 * It is not a problem for scrub/replace, because
+			 * It is not a problem for scrub, because
 			 * metadata are always cowed, and our scrub paused
 			 * commit_transactions.
 			 */
@@ -3596,9 +3606,19 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			btrfs_warn(fs_info,
 				   "failed setting block group ro: %d", ret);
 			btrfs_put_block_group(cache);
+			scrub_pause_off(fs_info);
 			break;
 		}
 
+		/*
+		 * Now the target block is marked RO, wait for nocow writes to
+		 * finish before dev-replace.
+		 * COW is fine, as COW never overwrites extents in commit tree.
+		 */
+		if (sctx->is_dev_replace)
+			btrfs_wait_nocow_writers(cache);
+
+		scrub_pause_off(fs_info);
 		down_write(&dev_replace->rwsem);
 		dev_replace->cursor_right = found_key.offset + length;
 		dev_replace->cursor_left = found_key.offset;
-- 
2.25.0

