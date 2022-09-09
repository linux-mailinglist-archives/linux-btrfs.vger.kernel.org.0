Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBE05B2F3E
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIIGpu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 02:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIIGpt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 02:45:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F6E110AAA
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 23:45:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 59D441F8C7;
        Fri,  9 Sep 2022 06:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662705943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AnOyHZbqck+A80uOuVgBvh26n26m6s1gfX/UjlS3z6o=;
        b=KjzvHPlq5WoAZQD1ZNhVxohTdcJJ/eiJcDt1QST/wruQWH7fzIiC+9sJzrWtF9pLokRbQh
        grX/Jr56xgvzeXiYtubnZMtJkA1aCmxtr4JVAa9gI9uPwXPTdPMEPxrggC2HOlx0w1bW4P
        vhoohQ8D9Wvey7zMEuSK7HeElTQ0qmQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBA57139D5;
        Fri,  9 Sep 2022 06:45:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JsLGKxXhGmPWIAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 09 Sep 2022 06:45:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] btrfs: don't update the block group item if used bytes are the same
Date:   Fri,  9 Sep 2022 14:45:22 +0800
Message-Id: <2a76b8005eb7208eda97e62a944ae456cbe8386f.1662705863.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
several CoW operations, but still have the same amount of used bytes.

In that case, we may unnecessarily CoW a tree block doing nothing.

[ENHANCEMENT]

This patch will introduce btrfs_block_group::commit_used member to
remember the last used bytes, and use that new member to skip
unnecessary block group item update.

This would be more common for large fs, which metadata block group can
be as large as 1GiB, containing at most 64K metadata items.

In that case, if CoW added and the deleted one metadata item near the end
of the block group, then it's completely possible we don't need to touch
the block group item at all.

[BENCHMARK]

The patchset itself can have quite a high chance (20~80%) to skip block
group item updates in a lot of workload.

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

Thus after we fill the initial 2G, we should not cause much block group items
updates.

Please note, the fio numbers by itself doesn't have much change, but if
we look deeper, there is some reduced execution time, especially
for the critical section of btrfs_commit_transaction().

I added extra trace_printk() to measure the following per-transaction
execution time

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

The change in block group item updates is more obvious, as skipped bg
item updates also means less delayed refs, thus the change is more
obvious.

And the overall execution time for that bg update loop is pretty small,
thus we can assume the extent tree is already mostly cached.
If we can skip a uncached tree block, it would cause more obvious
change.

Unfortunately the overall reduce in commit transaction critical section
is much smaller, as the block group item updates loop is not really the
major part, at least for the above fio script.

But still we have a observable reduction in the critical section.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
[Josef pinned down the race and provided a fix]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Changelog:
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
 fs/btrfs/block-group.c | 20 +++++++++++++++++++-
 fs/btrfs/block-group.h |  6 ++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e7b5a54c8258..0df4d98df278 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2002,6 +2002,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 
 	cache->length = key->offset;
 	cache->used = btrfs_stack_block_group_used(bgi);
+	cache->commit_used = cache->used;
 	cache->flags = btrfs_stack_block_group_flags(bgi);
 	cache->global_root_id = btrfs_stack_block_group_chunk_objectid(bgi);
 
@@ -2693,6 +2694,22 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_block_group_item bgi;
 	struct btrfs_key key;
+	u64 used;
+
+	/*
+	 * Block group items update can be triggered out of commit transaction
+	 * critical section, thus we need a consistent view of used bytes.
+	 * We can not direct use cache->used out of the spin lock, as it
+	 * may be changed.
+	 */
+	spin_lock(&cache->lock);
+	used = cache->used;
+	/* No change in used bytes, can safely skip it. */
+	if (cache->commit_used == used) {
+		spin_unlock(&cache->lock);
+		return 0;
+	}
+	spin_unlock(&cache->lock);
 
 	key.objectid = cache->start;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
@@ -2707,12 +2724,13 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	btrfs_set_stack_block_group_used(&bgi, cache->used);
+	btrfs_set_stack_block_group_used(&bgi, used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 						   cache->global_root_id);
 	btrfs_set_stack_block_group_flags(&bgi, cache->flags);
 	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
+	cache->commit_used = used;
 fail:
 	btrfs_release_path(path);
 	return ret;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index f48db81d1d56..b57718020104 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -84,6 +84,12 @@ struct btrfs_block_group {
 	u64 cache_generation;
 	u64 global_root_id;
 
+	/*
+	 * The last committed used bytes of this block group, if above @used
+	 * is still the same as @commit_used, we don't need to update block
+	 * group item of this block group.
+	 */
+	u64 commit_used;
 	/*
 	 * If the free space extent count exceeds this number, convert the block
 	 * group to bitmaps.
-- 
2.37.3

