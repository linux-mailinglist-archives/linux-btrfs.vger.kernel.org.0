Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A1D5B14A0
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 08:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIHGeL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 02:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIHGeK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 02:34:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A615C0BC4
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Sep 2022 23:34:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D08BE34471;
        Thu,  8 Sep 2022 06:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662618846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=03TJnR7Nt3gfI+Xnxp30wfv8snmeIVhstHm3vYlFIQw=;
        b=qwC8ZUDTsZe3AAaG8n9qXjr3TgefUSOxu9AmI2cFNX/FzWWtEpEh3y9QY5P9Pk/wtYch30
        jScvSplxU2h8GObSozc9kuLpG1UN3I1Qe4+hcdIBWd9q64af1LGAfzZOnE5JETRZmFRxSN
        tNWCkFB9Hb5hmclR9X1A7Fj3eLkd3xA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E11341322C;
        Thu,  8 Sep 2022 06:34:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hLhEKd2MGWOqOAAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 08 Sep 2022 06:34:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2] btrfs: don't update the block group item if used bytes are the same
Date:   Thu,  8 Sep 2022 14:33:48 +0800
Message-Id: <bf157be545a0ad97897b33be983284a4f63a5e0f.1662618779.git.wqu@suse.com>
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

To properly benchmark how many block group items we skipped the update,
I added some members into btrfs_tranaction to record how many times
update_block_group_item() is called, and how many of them are skipped.

Then with a single line fio to trigger the workload on a newly created
btrfs:

  fio --filename=$mnt/file --size=4G --rw=randrw --bs=32k --ioengine=libaio \
      --direct=1 --iodepth=64 --runtime=120 --numjobs=4 --name=random_rw \
      --fallocate=posix

Then I got 101 transaction committed during that fio command, and a
total of 2062 update_block_group_item() calls, in which 1241 can be
skipped.

This is already a good 60% got skipped.

The full analyse can be found here:
https://docs.google.com/spreadsheets/d/e/2PACX-1vTbjhqqqxoebnQM_ZJzSM1rF7EY7I1IRbAzZjv19imcDHsVDA7qeA_-MzXxltFZ0kHBjxMA15s2CSH8/pubhtml

Furthermore, since I have per-trans accounting, it shows that initially
we have a very low percentage of skipped block group item update.

This is expected since we're inserting a lot of new file extents
initially, thus the metadata usage is going to increase.

But after the initial 3 transactions, all later transactions are have a
very stable 40~80% skip rate, mostly proving the patch is working.

Although such high skip rate is not always a huge win, as for
our later block group tree feature, we will have a much higher chance to
have a block group item already COWed, thus can skip some COW work.

But still, skipping a full COW search on extent tree is always a good
thing, especially when the benefit almost comes from thin-air.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[Josef pinned down the race and provided a fix]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
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

