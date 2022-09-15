Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6555A5B99C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 13:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIOLjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 07:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiIOLjO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 07:39:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EDE97ED8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 04:39:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF8A51F88D;
        Thu, 15 Sep 2022 11:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663241951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PoNeRt4wS/Vkgu/LrOf1ZQoWG0LcAriNdYNmBdfu5wE=;
        b=SII5DdF2+gWMYSC9Xm7LOCxkJdrME8w1CKiqKcquaqF6MjzIaeTTqMtzwyTvlkstU6OsLs
        NcAH08dJwNdKlrNeQlZ/PJ9gdldF0n4G1vp1cr9achJTZkl133DxnX4kzjoyJ5+8/HNcm+
        Ey4f3lvA1xc5aHeJYgVaacIEy1YPDAg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F20F13A49;
        Thu, 15 Sep 2022 11:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kNjrGN4OI2PLLQAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 15 Sep 2022 11:39:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH v4] btrfs: skip update of block group item if used bytes are the same
Date:   Thu, 15 Sep 2022 19:38:52 +0800
Message-Id: <f68664759229da440226ebc28114108470b761b6.1663241717.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]

When committing a transaction, we will update block group items for all
dirty block groups.

But in fact, dirty block groups don't always need to update their block
group items.
It's pretty common to have a metadata block group which experienced
several COW operations, but still have the same amount of used bytes.

In that case, we may unnecessarily COW a tree block doing nothing.

[ENHANCEMENT]

This patch will introduce btrfs_block_group::commit_used member to
remember the last used bytes, and use that new member to skip
unnecessary block group item update.

This would be more common for large filesystems, where metadata block
group can be as large as 1GiB, containing at most 64K metadata items.

In that case, if COW added and then deleted one metadata item near the
end of the block group, then it's completely possible we don't need to
touch the block group item at all.

[BENCHMARK]

The change itself can have quite a high chance (20~80%) to skip block
group item updates in lot of workloads.

As a result, it would result shorter time spent on
btrfs_write_dirty_block_groups(), and overall reduce the execution time
of the critical section of btrfs_commit_transaction().

Here comes a fio command, which will do random writes in 4K block size,
causing a very heavy metadata updates.

fio --filename=$mnt/file --size=512M --rw=randwrite --direct=1 --bs=4k \
    --ioengine=libaio --iodepth=64 --runtime=300 --numjobs=4 \
    --name=random_write --fallocate=none --time_based --fsync_on_close=1

The file size (512M) and number of threads (4) means 2GiB file size in
total, but during the full 300s run time, my dedicated SATA SSD is able
to write around 20~25GiB, which is over 10 times the file size.

Thus after we fill the initial 2G, we should not cause much block group
item updates.

Please note, the fio numbers by themselves don't have much change, but
if we look deeper, there is some reduced execution time, especially for
the critical section of btrfs_commit_transaction().

I added extra trace_printk() to measure the following per-transaction
execution time:

- Critical section of btrfs_commit_transaction()
  By re-using the existing update_commit_stats() function, which
  has already calculated the interval correctly.

- The while() loop for btrfs_write_dirty_block_groups()
  Although this includes the execution time of btrfs_run_delayed_refs(),
  it should still be representative overall.

Both result involves transid 7~30, the same amount of transaction
committed.

The result looks like this:

                      |      Before       |     After      |  Diff
----------------------+-------------------+----------------+--------
Transaction interval  | 229247198.5       | 215016933.6    | -6.2%
Block group interval  | 23133.33333       | 18970.83333    | -18.0%

The change in block group item updates is more obvious, as skipped block
group item updates also mean less delayed refs.

And the overall execution time for that block group update loop is
pretty small, thus we can assume the extent tree is already mostly
cached.  If we can skip an uncached tree block, it would cause more
obvious change.

Unfortunately the overall reduction in commit transaction critical
section is much smaller, as the block group item updates loop is not
really the major part, at least not for the above fio script.

But still we have a observable reduction in the critical section.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
Changelog:
v4:
- Race fix again
  Even with v3 fix, there seems to be a race window, but I'm not 100% sure.

  `cache->commit_used` is not updated with spinlock protection, thus
  no proper multi-core barrier to sync the new value to other cores.

  Thus it's possible that, on core A we have cache->commit_used updated,
  but on another core, cache->commit_used may still be the old value.
  And incorrectly skip the update for the block group.

  Anyway we should handle btrfs_block_group members with spinlock,
  especially there are two members involved now.

  This time I hope to get more testing, thus please don't include this
  patch for late -rc. Better only targeting v6.2.

- Add proper rollback support
  Since we have to update commit_used inside spinlock, if we hit error
  we have to roll it back at error path.

v3:
- Further improve the benchmark
  No code change.

 * Make it time based, so we can overwrite the file several times
 * Make it much longer
 * Reduce the total file size to avoid ENOSPC pressure
 * Measure both commit transaction interval and block group item
   updates interval to get a more representative result.

v2:
- Add a new benchmark
  I added btrfs_transaction::total_bg_updates and skipped_bg_updates
  atomics, the total one will get increased every time
  update_block_group_item() get called, and the skipped one will
  get increased when we skip one update.

  Then I go trace_printk() at btrfs_commit_transaction() to
  print the two atomics.

  The full benchmark is way better than I initially though, after
  the initial increase in metadata usage, later transactions all
  got a high percentage of skipped bg updates, between 40~80%.

- Thanks Josef for pinning down and fixing a race
  Previously, update_block_group_item() only access cache->used
  once, thus it doesn't really need extra protection.

  But now we need to access it at least 3 times (one to check if
  we can skip, one to update the block group item, one to update
  commit_used).

  This requires a lock to prevent the cache->used changed halfway,
  and lead to incorrect used bytes in block group item.
---
---
 fs/btrfs/block-group.c | 31 ++++++++++++++++++++++++++++++-
 fs/btrfs/block-group.h |  6 ++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e7b5a54c8258..097c8ee21551 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2002,6 +2002,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 
 	cache->length = key->offset;
 	cache->used = btrfs_stack_block_group_used(bgi);
+	cache->commit_used = cache->used;
 	cache->flags = btrfs_stack_block_group_flags(bgi);
 	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
 
@@ -2693,6 +2694,25 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
+	u64 old_commit_used;
+	u64 used;
+
+	/*
+	 * Block group items update can be triggered out of commit transaction
+	 * critical section, thus we need a consistent view of used bytes.
+	 * We cannot use cache->used directly outside of the spin lock, as it
+	 * may be changed.
+	 */
+	spin_lock(&cache->lock);
+	old_commit_used = cache->commit_used;
+	used = cache->used;
+	/* No change in used bytes, can safely skip it. */
+	if (cache->commit_used == used) {
+		spin_unlock(&cache->lock);
+		return 0;
+	}
+	cache->commit_used = used;
+	spin_unlock(&cache->lock);
 
 	key.objectid = cache->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
@@ -2707,7 +2727,7 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	btrfs_set_stack_block_group_used(&bgi, cache->used);
+	btrfs_set_stack_block_group_used(&bgi, used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 						   cache->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
@@ -2715,6 +2735,15 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 fail:
 	btrfs_release_path(path);
+	/*
+	 * We didn't update the block group item, need to revert @commit_used
+	 * value.
+	 */
+	if (ret < 0) {
+		spin_lock(&cache->lock);
+		cache->commit_used = old_commit_used;
+		spin_unlock(&cache->lock);
+	}
 	return ret;
 
 }
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index f48db81d1d56..4d4d2e1f137b 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -84,6 +84,12 @@ struct btrfs_block_group {
 	u64 cache_generation;
 	u64 global_root_id;
 
+	/*
+	 * The last committed used bytes of this block group, if the above @used
+	 * is still the same as @commit_used, we don't need to update block
+	 * group item of this block group.
+	 */
+	u64 commit_used;
 	/*
 	 * If the free space extent count exceeds this number, convert the block
 	 * group to bitmaps.
-- 
2.37.3

