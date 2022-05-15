Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3542A52772B
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 12:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbiEOK4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 06:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiEOK4Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 06:56:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48127167DC
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 03:56:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0442C1F892
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652612173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Se0MQvqevemfyF3+lqLHGJ+dBK3YrpFxpobBmEv4fGQ=;
        b=Yvp+f7RmVNZUHba0qz9f0SFGffE2Jb49Qr+0ib5T9oDRHLDfwIVxZqG83JzLl1/nFZnvXB
        PTTEG6bypJV11y4S8SiJ2MHmPB2BA82c6MfGa9nH0QOGOvGIbzTpakTTS0gtd348RR37o7
        nzKqVhsmULPVEFkqjOkkJ5XFYswlE9U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5298713491
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YgdBCEzcgGIkfgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 10:56:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: place holder for RAID56J profiles
Date:   Sun, 15 May 2022 18:55:55 +0800
Message-Id: <beae638a06ad08d16a4eaf799b0aaf01fc1d5573.1652612110.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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
Btrfs RAID56 has a long existing bug for write-hole, we have some ideas
to fix it, from extent allocator behavior changes (completely avoid
partial writes) to write-ahead journal.

This patch will introduce two new chunk profiles:
- BTRFS_BLOCK_GROUP_RAID5J
- BTRFS_BLOCK_GROUP_RAID6J

The suffix "J" means journal, and is what I'm purposing to solve the
write-hole problem.

The journaled solution is the tried-and-true solution, mostly to emulate
the behavior of dm/md-raid56.

[ALTERNATIVE]
There is a more advanced and more flex (can support zoned device)
purpose from Johannes, called stripe tree.

Although that solution will introduced a inter-chunk mapping, and no
longer fully respect the strict rotation requirement, I still believe
that solution can be the ultimate solution for the write hole.

But on the other hand, I think there is still some value for such
journal based tried-and-true solution.

[DETAILS]
For write-ahead journal to work, we need extra space to do the work.
We can go free-space-tree way, but that can be a new rabbit hole if our
metadata is also RAID56J based.

So here we introduce a new member, btrfs_chunk::per_dev_reserved, which
shares the same space of io_aligned, to indicate how many bytes are
reserved for each device extents inside the chunk.

One example for a RAID5J chunk would be like:

	btrfs_chunk:	start (key.offset) = L length = 1GiB
			type = RAID5J 	num_stripes = 3
			pre_dev_reserved = 1MiB
	stripe[0]:	devid = 1	physical = P1
	stripe[1]:	devid = 2	physical = P2
	stripe[2]:	devid = 3	physical = P3

	dev extent:	devid = 1	physical = P1 - 1MiB
			length = 512MiB + 1MiB

	dev extent:	devid = 2	physical = P2 - 1MiB
			length = 513MiB

	dev extent:	devid = 3	physical = P3 - 1MiB
			length = 513 MiB

Then on devid 1, physical offset [P1, P1 + 1M) will be reserved for
journal, the same for devid 2 and devid 3.

Now btrfs_stripe::offset will be where the real data starts, excluding
the per-device reservation.

By this, we can bring the changes to minimal for chunk mapping code, at
the cost of more complex dev extents handling.

[CODE CHANGES]
This new feature touches the following code sites:

- Call sites checking RAID5/RAID6 flag manually
  Mostly to make the check to also check the journaled variant, including:
  * scrub_nr_raid_mirrors()
  * btrfs_reduce_alloc_profile()
  * clear_incompat_bg_bits()
  * btrfs_check_chunk_valid()

  The other call sites should be already using btrfs_raid_array[], thus
  no need to bother.

- New feature/profiles related code
  From new chunk types, sysfs interface, and updated member comments.

- Chunk and dev extent handling
  Involved code handles dev extents with its reservation part,
  including:
  * Dev extents verification against chunk items
  * Chunk allocation
  * Chunk removal
  * Chunk read
  * Chunk scrubbing
    As currently chunk scrubbing is done by iterating the dev extents,
    thus it also needs the extra handling.

[RFC]
Although this patch can pass fstests (with new RAID56J added to involved
test cases, so far the test case which exposed the most bugs is
btrfs/011, unsurprisingly), the journal part is just no-op.

Thus the patch is still just a mass simulator for RAID56J, to make sure
the per-dev reservation code is working correctly.

Furthermore, currently the per-dev reservation is still hardcoded
(1MiB), it can handle different per-dev reservation without problem,
thus we can determine the size in the real journaled code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c          |  23 ++++++-
 fs/btrfs/ctree.h                |   7 +-
 fs/btrfs/scrub.c                |  15 ++--
 fs/btrfs/sysfs.c                |   2 +
 fs/btrfs/tree-checker.c         |   4 ++
 fs/btrfs/volumes.c              | 118 +++++++++++++++++++++++++++++---
 fs/btrfs/volumes.h              |   7 +-
 fs/btrfs/zoned.c                |   2 +
 include/uapi/linux/btrfs.h      |   1 +
 include/uapi/linux/btrfs_tree.h |  30 +++++++-
 10 files changed, 187 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ede389f2602d..b80dbd2e5ac1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -79,8 +79,12 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	}
 	allowed &= flags;
 
-	if (allowed & BTRFS_BLOCK_GROUP_RAID6)
+	if (allowed & BTRFS_BLOCK_GROUP_RAID6J)
+		allowed = BTRFS_BLOCK_GROUP_RAID6J;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID6)
 		allowed = BTRFS_BLOCK_GROUP_RAID6;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID5J)
+		allowed = BTRFS_BLOCK_GROUP_RAID5J;
 	else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
 		allowed = BTRFS_BLOCK_GROUP_RAID5;
 	else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
@@ -836,6 +840,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
 {
 	bool found_raid56 = false;
 	bool found_raid1c34 = false;
+	bool found_journal = false;
 
 	if ((flags & BTRFS_BLOCK_GROUP_RAID56_MASK) ||
 	    (flags & BTRFS_BLOCK_GROUP_RAID1C3) ||
@@ -849,6 +854,14 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
 				found_raid56 = true;
 			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID6]))
 				found_raid56 = true;
+			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5J])) {
+				found_raid56 = true;
+				found_journal = true;
+			}
+			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID6J])) {
+				found_raid56 = true;
+				found_journal = true;
+			}
 			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID1C3]))
 				found_raid1c34 = true;
 			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID1C4]))
@@ -859,6 +872,8 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
 			btrfs_clear_fs_incompat(fs_info, RAID56);
 		if (!found_raid1c34)
 			btrfs_clear_fs_incompat(fs_info, RAID1C34);
+		if (!found_journal)
+			btrfs_clear_fs_incompat(fs_info, RAID56_JOURNAL);
 	}
 }
 
@@ -2397,8 +2412,10 @@ static int insert_dev_extents(struct btrfs_trans_handle *trans,
 		device = map->stripes[i].dev;
 		dev_offset = map->stripes[i].physical;
 
-		ret = insert_dev_extent(trans, device, chunk_offset, dev_offset,
-				       stripe_size);
+		ASSERT(dev_offset > map->per_dev_reserved);
+		ret = insert_dev_extent(trans, device, chunk_offset,
+					dev_offset - map->per_dev_reserved,
+					stripe_size + map->per_dev_reserved);
 		if (ret)
 			break;
 	}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0e49b1a0c071..7025105b4023 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -327,7 +327,8 @@ static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
 	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
 	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
-	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2)
+	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2  |	\
+	 BTRFS_FEATURE_INCOMPAT_RAID56_JOURNAL)
 #else
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
 	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
@@ -1710,6 +1711,8 @@ static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 BTRFS_SETGET_FUNCS(device_type, struct btrfs_dev_item, type, 64);
 BTRFS_SETGET_FUNCS(device_bytes_used, struct btrfs_dev_item, bytes_used, 64);
 BTRFS_SETGET_FUNCS(device_io_align, struct btrfs_dev_item, io_align, 32);
+BTRFS_SETGET_FUNCS(chunk_per_dev_reserved, struct btrfs_chunk, per_dev_reserved,
+		   32);
 BTRFS_SETGET_FUNCS(device_io_width, struct btrfs_dev_item, io_width, 32);
 BTRFS_SETGET_FUNCS(device_start_offset, struct btrfs_dev_item,
 		   start_offset, 64);
@@ -1727,6 +1730,8 @@ BTRFS_SETGET_STACK_FUNCS(stack_device_bytes_used, struct btrfs_dev_item,
 			 bytes_used, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_device_io_align, struct btrfs_dev_item,
 			 io_align, 32);
+BTRFS_SETGET_STACK_FUNCS(stack_chunk_per_dev_reserved, struct btrfs_chunk,
+			 per_dev_reserved, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_device_io_width, struct btrfs_dev_item,
 			 io_width, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_device_sector_size, struct btrfs_dev_item,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 84346faa4ff1..a8f2f3d854a9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1208,12 +1208,13 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 
 static inline int scrub_nr_raid_mirrors(struct btrfs_io_context *bioc)
 {
-	if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID5)
+	if (bioc->map_type & (BTRFS_BLOCK_GROUP_RAID5 |
+			      BTRFS_BLOCK_GROUP_RAID5J))
 		return 2;
-	else if (bioc->map_type & BTRFS_BLOCK_GROUP_RAID6)
+	if (bioc->map_type & (BTRFS_BLOCK_GROUP_RAID6 |
+			      BTRFS_BLOCK_GROUP_RAID6J))
 		return 3;
-	else
-		return (int)bioc->num_stripes;
+	return (int)bioc->num_stripes;
 }
 
 static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
@@ -3632,12 +3633,16 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 
 		return ret;
 	}
+	map = em->map_lookup;
+	/* Exclude per dev reservation from @dev_offset and @dev_extent_len. */
+	dev_offset += map->per_dev_reserved;
+	dev_extent_len -= map->per_dev_reserved;
+
 	if (em->start != bg->start)
 		goto out;
 	if (em->len < dev_extent_len)
 		goto out;
 
-	map = em->map_lookup;
 	for (i = 0; i < map->num_stripes; ++i) {
 		if (map->stripes[i].dev->bdev == scrub_dev->bdev &&
 		    map->stripes[i].physical == dev_offset) {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 92a1fa8e3da6..082afc93c763 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -283,6 +283,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(raid56_journal, RAID56_JOURNAL);
 #ifdef CONFIG_BTRFS_DEBUG
 /* Remove once support for zoned allocation is feature complete */
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
@@ -317,6 +318,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #ifdef CONFIG_BTRFS_DEBUG
 	BTRFS_FEAT_ATTR_PTR(zoned),
 	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
+	BTRFS_FEAT_ATTR_PTR(raid56_journal),
 #endif
 #ifdef CONFIG_FS_VERITY
 	BTRFS_FEAT_ATTR_PTR(verity),
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 9e0e0ae2288c..e8aadf0570d2 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -903,6 +903,10 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID5].devs_min) ||
 		     (type & BTRFS_BLOCK_GROUP_RAID6 &&
 		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID6].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID5J &&
+		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID5J].devs_min) ||
+		     (type & BTRFS_BLOCK_GROUP_RAID6J &&
+		      num_stripes < btrfs_raid_array[BTRFS_RAID_RAID6J].devs_min) ||
 		     (type & BTRFS_BLOCK_GROUP_DUP &&
 		      num_stripes != btrfs_raid_array[BTRFS_RAID_DUP].dev_stripes) ||
 		     ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cddbbd8eb310..f8ac402ef5c9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -34,6 +34,14 @@
 #include "discard.h"
 #include "zoned.h"
 
+/*
+ * The extra space for journal based profiles (raid56j).
+ *
+ * Each device will have this amount of bytes reserved before the real
+ * stripe begins.
+ */
+#define JOURNAL_RESERVED		(SZ_1M)
+
 #define BTRFS_BLOCK_GROUP_STRIPE_MASK	(BTRFS_BLOCK_GROUP_RAID0 | \
 					 BTRFS_BLOCK_GROUP_RAID10 | \
 					 BTRFS_BLOCK_GROUP_RAID56_MASK)
@@ -156,6 +164,32 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 		.bg_flag	= BTRFS_BLOCK_GROUP_RAID6,
 		.mindev_error	= BTRFS_ERROR_DEV_RAID6_MIN_NOT_MET,
 	},
+	[BTRFS_RAID_RAID5J] = {
+		.sub_stripes	= 1,
+		.dev_stripes	= 1,
+		.devs_max	= 0,
+		.devs_min	= 2,
+		.tolerated_failures = 1,
+		.devs_increment	= 1,
+		.ncopies	= 1,
+		.nparity        = 1,
+		.raid_name	= "raid5j",
+		.bg_flag	= BTRFS_BLOCK_GROUP_RAID5J,
+		.mindev_error	= BTRFS_ERROR_DEV_RAID5_MIN_NOT_MET,
+	},
+	[BTRFS_RAID_RAID6J] = {
+		.sub_stripes	= 1,
+		.dev_stripes	= 1,
+		.devs_max	= 0,
+		.devs_min	= 3,
+		.tolerated_failures = 2,
+		.devs_increment	= 1,
+		.ncopies	= 1,
+		.nparity        = 2,
+		.raid_name	= "raid6j",
+		.bg_flag	= BTRFS_BLOCK_GROUP_RAID6J,
+		.mindev_error	= BTRFS_ERROR_DEV_RAID6_MIN_NOT_MET,
+	},
 };
 
 /*
@@ -182,6 +216,11 @@ const char *btrfs_bg_type_to_raid_name(u64 flags)
 	return btrfs_raid_array[index].raid_name;
 }
 
+static bool bg_type_is_journal(u64 type)
+{
+	return !!(type & BTRFS_BLOCK_GROUP_JOURNAL_MASK);
+}
+
 /*
  * Fill @buf with textual description of @bg_flags, no more than @size_buf
  * bytes including terminating null byte.
@@ -5029,6 +5068,15 @@ static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 	btrfs_set_fs_incompat(info, RAID56);
 }
 
+static void check_journal_incompat_flag(struct btrfs_fs_info *fs_info,
+					u64 type)
+{
+	if (!(type & BTRFS_BLOCK_GROUP_JOURNAL_MASK))
+		return;
+
+	btrfs_set_fs_incompat(fs_info, RAID56_JOURNAL);
+}
+
 static void check_raid1c34_incompat_flag(struct btrfs_fs_info *info, u64 type)
 {
 	if (!(type & (BTRFS_BLOCK_GROUP_RAID1C3 | BTRFS_BLOCK_GROUP_RAID1C4)))
@@ -5063,9 +5111,14 @@ struct alloc_chunk_ctl {
 	u64 max_stripe_size;
 	u64 max_chunk_size;
 	u64 dev_extent_min;
+
+	/* The real stripe size, excluding the per-device reservation. */
 	u64 stripe_size;
 	u64 chunk_size;
 	int ndevs;
+
+	/* How many bytes needs to be reserved before the real stripe starts. */
+	u32 per_dev_reserved;
 };
 
 static void init_alloc_chunk_ctl_policy_regular(
@@ -5136,6 +5189,7 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 				 struct alloc_chunk_ctl *ctl)
 {
 	int index = btrfs_bg_flags_to_raid_index(ctl->type);
+	bool is_journal = bg_type_is_journal(ctl->type);
 
 	ctl->sub_stripes = btrfs_raid_array[index].sub_stripes;
 	ctl->dev_stripes = btrfs_raid_array[index].dev_stripes;
@@ -5148,6 +5202,11 @@ static void init_alloc_chunk_ctl(struct btrfs_fs_devices *fs_devices,
 	ctl->nparity = btrfs_raid_array[index].nparity;
 	ctl->ndevs = 0;
 
+	if (is_journal)
+		ctl->per_dev_reserved = JOURNAL_RESERVED;
+	else
+		ctl->per_dev_reserved = 0;
+
 	switch (fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
 		init_alloc_chunk_ctl_policy_regular(fs_devices, ctl);
@@ -5276,6 +5335,11 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
 
 	/* Align to BTRFS_STRIPE_LEN */
 	ctl->stripe_size = round_down(ctl->stripe_size, BTRFS_STRIPE_LEN);
+
+	/* Not enough space for per-dev reservation. */
+	if (ctl->stripe_size <= ctl->per_dev_reserved)
+		return -ENOSPC;
+	ctl->stripe_size -= ctl->per_dev_reserved;
 	ctl->chunk_size = ctl->stripe_size * data_stripes;
 
 	return 0;
@@ -5294,6 +5358,9 @@ static int decide_stripe_size_zoned(struct alloc_chunk_ctl *ctl,
 	 */
 	ASSERT(devices_info[ctl->ndevs - 1].max_avail == ctl->dev_extent_min);
 
+	/* No support for RAID56J at all. */
+	ASSERT(!bg_type_is_journal(ctl->type));
+
 	ctl->stripe_size = zone_size;
 	ctl->num_stripes = ctl->ndevs * ctl->dev_stripes;
 	data_stripes = (ctl->num_stripes - ctl->nparity) / ctl->ncopies;
@@ -5371,8 +5438,15 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 		for (j = 0; j < ctl->dev_stripes; ++j) {
 			int s = i * ctl->dev_stripes + j;
 			map->stripes[s].dev = devices_info[i].dev;
+
+			/*
+			 * devices_info[] contains the stripes for the physical
+			 * stripe, our real data only starts after the reserved
+			 * space.
+			 */
 			map->stripes[s].physical = devices_info[i].dev_offset +
-						   j * ctl->stripe_size;
+						   j * ctl->stripe_size +
+						   ctl->per_dev_reserved;
 		}
 	}
 	map->stripe_len = BTRFS_STRIPE_LEN;
@@ -5380,6 +5454,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	map->io_width = BTRFS_STRIPE_LEN;
 	map->type = type;
 	map->sub_stripes = ctl->sub_stripes;
+	map->per_dev_reserved = ctl->per_dev_reserved;
 
 	trace_btrfs_chunk_alloc(info, map, start, ctl->chunk_size);
 
@@ -5414,7 +5489,8 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 		struct btrfs_device *dev = map->stripes[i].dev;
 
 		btrfs_device_set_bytes_used(dev,
-					    dev->bytes_used + ctl->stripe_size);
+					    dev->bytes_used + ctl->stripe_size +
+					    ctl->per_dev_reserved);
 		if (list_empty(&dev->post_commit_list))
 			list_add_tail(&dev->post_commit_list,
 				      &trans->transaction->dev_update_list);
@@ -5425,6 +5501,7 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 
 	free_extent_map(em);
 	check_raid56_incompat_flag(info, type);
+	check_journal_incompat_flag(info, type);
 	check_raid1c34_incompat_flag(info, type);
 
 	return block_group;
@@ -5517,6 +5594,7 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 	struct btrfs_stripe *stripe;
 	struct extent_map *em;
 	struct map_lookup *map;
+	bool is_journal = bg_type_is_journal(bg->flags);
 	size_t item_size;
 	int i;
 	int ret;
@@ -5555,6 +5633,11 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 	map = em->map_lookup;
 	item_size = btrfs_chunk_item_size(map->num_stripes);
 
+	if (is_journal)
+		ASSERT(map->per_dev_reserved);
+	else
+		ASSERT(map->per_dev_reserved == 0);
+
 	chunk = kzalloc(item_size, GFP_NOFS);
 	if (!chunk) {
 		ret = -ENOMEM;
@@ -5586,7 +5669,11 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_chunk_stripe_len(chunk, map->stripe_len);
 	btrfs_set_stack_chunk_type(chunk, map->type);
 	btrfs_set_stack_chunk_num_stripes(chunk, map->num_stripes);
-	btrfs_set_stack_chunk_io_align(chunk, map->stripe_len);
+	if (!is_journal)
+		btrfs_set_stack_chunk_io_align(chunk, map->stripe_len);
+	else
+		btrfs_set_stack_chunk_per_dev_reserved(chunk,
+						       map->per_dev_reserved);
 	btrfs_set_stack_chunk_io_width(chunk, map->stripe_len);
 	btrfs_set_stack_chunk_sector_size(chunk, fs_info->sectorsize);
 	btrfs_set_stack_chunk_sub_stripes(chunk, map->sub_stripes);
@@ -5740,9 +5827,11 @@ int btrfs_num_copies(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
 		/* Non-raid56, use their ncopies from btrfs_raid_array[]. */
 		ret = btrfs_raid_array[index].ncopies;
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
+	else if (map->type & (BTRFS_BLOCK_GROUP_RAID5 |
+			      BTRFS_BLOCK_GROUP_RAID5J))
 		ret = 2;
-	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
+	else if (map->type & (BTRFS_BLOCK_GROUP_RAID6 |
+			      BTRFS_BLOCK_GROUP_RAID6J))
 		/*
 		 * There could be two corrupted data stripes, we need
 		 * to loop retry in order to rebuild the correct data.
@@ -6558,7 +6647,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 				em->start + (tmp + i) * map->stripe_len;
 
 		bioc->raid_map[(i + rot) % map->num_stripes] = RAID5_P_STRIPE;
-		if (map->type & BTRFS_BLOCK_GROUP_RAID6)
+		if (map->type & (BTRFS_BLOCK_GROUP_RAID6 |
+				 BTRFS_BLOCK_GROUP_RAID6J))
 			bioc->raid_map[(i + rot + 1) % num_stripes] =
 				RAID6_Q_STRIPE;
 
@@ -7061,6 +7151,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
 	struct map_lookup *map;
 	struct extent_map *em;
+	bool is_journal;
 	u64 logical;
 	u64 length;
 	u64 devid;
@@ -7092,6 +7183,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 			return ret;
 	}
 
+	is_journal = bg_type_is_journal(type);
 	read_lock(&map_tree->lock);
 	em = lookup_extent_mapping(map_tree, logical, 1);
 	read_unlock(&map_tree->lock);
@@ -7123,7 +7215,14 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 
 	map->num_stripes = num_stripes;
 	map->io_width = btrfs_chunk_io_width(leaf, chunk);
-	map->io_align = btrfs_chunk_io_align(leaf, chunk);
+	if (!is_journal) {
+		map->io_align = btrfs_chunk_io_align(leaf, chunk);
+		map->per_dev_reserved = 0;
+	} else {
+		map->io_align = map->io_width;
+		map->per_dev_reserved = btrfs_chunk_per_dev_reserved(leaf,
+								     chunk);
+	}
 	map->stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
 	map->type = type;
 	map->sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
@@ -8030,7 +8129,7 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 
 	map = em->map_lookup;
 	stripe_len = btrfs_calc_stripe_length(em);
-	if (physical_len != stripe_len) {
+	if (physical_len != stripe_len + map->per_dev_reserved) {
 		btrfs_err(fs_info,
 "dev extent physical offset %llu on devid %llu length doesn't match chunk %llu, have %llu expect %llu",
 			  physical_offset, devid, em->start, physical_len,
@@ -8041,7 +8140,8 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 
 	for (i = 0; i < map->num_stripes; i++) {
 		if (map->stripes[i].dev->devid == devid &&
-		    map->stripes[i].physical == physical_offset) {
+		    map->stripes[i].physical == physical_offset +
+						map->per_dev_reserved) {
 			found = true;
 			if (map->verified_stripes >= map->num_stripes) {
 				btrfs_err(fs_info,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 2bfe14d75a15..b1902a1e2e55 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -47,6 +47,8 @@ enum btrfs_raid_types {
 	BTRFS_RAID_RAID6   = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID6),
 	BTRFS_RAID_RAID1C3 = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID1C3),
 	BTRFS_RAID_RAID1C4 = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID1C4),
+	BTRFS_RAID_RAID5J  = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID5J),
+	BTRFS_RAID_RAID6J  = BTRFS_BG_FLAG_TO_INDEX(BTRFS_BLOCK_GROUP_RAID6J),
 
 	BTRFS_NR_RAID_TYPES
 };
@@ -462,8 +464,11 @@ extern const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES];
 
 struct map_lookup {
 	u64 type;
-	int io_align;
+	u32 io_align;
+	u32 per_dev_reserved;
 	int io_width;
+
+	/* This is the real stripe length, excluding above per_dev_reserved. */
 	u32 stripe_len;
 	int num_stripes;
 	int sub_stripes;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index b60767492b3c..85dd49aa41fd 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1459,6 +1459,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	case BTRFS_BLOCK_GROUP_RAID10:
 	case BTRFS_BLOCK_GROUP_RAID5:
 	case BTRFS_BLOCK_GROUP_RAID6:
+	case BTRFS_BLOCK_GROUP_RAID5J:
+	case BTRFS_BLOCK_GROUP_RAID6J:
 		/* non-single profiles are not supported yet */
 	default:
 		btrfs_err(fs_info, "zoned: profile %s not yet supported",
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index d956b2993970..cb66aff71508 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -310,6 +310,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_RAID56_JOURNAL	(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index d4117152d907..46991a27013b 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -438,6 +438,10 @@ struct btrfs_dev_item {
 
 struct btrfs_stripe {
 	__le64 devid;
+	/*
+	 * Where the real stripe starts on the device, excluding the per-dev
+	 * reserved bytes.
+	 */
 	__le64 offset;
 	__u8 dev_uuid[BTRFS_UUID_SIZE];
 } __attribute__ ((__packed__));
@@ -452,8 +456,19 @@ struct btrfs_chunk {
 	__le64 stripe_len;
 	__le64 type;
 
-	/* optimal io alignment for this chunk */
-	__le32 io_align;
+	union {
+		/*
+		 * For non-journaled profiles, optimal io alignment for this
+		 * chunk, not really utilized though.
+		 */
+		__le32 io_align;
+
+		/*
+		 * For journaled profiles, per-device-extent reserved bytes
+		 * before the real data starts.
+		 */
+		__le32 per_dev_reserved;
+	};
 
 	/* optimal io width for this chunk */
 	__le32 io_width;
@@ -877,6 +892,8 @@ struct btrfs_dev_replace_item {
 #define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
 #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
 #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
+#define BTRFS_BLOCK_GROUP_RAID5J	(1ULL << 11)
+#define BTRFS_BLOCK_GROUP_RAID6J	(1ULL << 12)
 #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
 					 BTRFS_SPACE_INFO_GLOBAL_RSV)
 
@@ -890,10 +907,17 @@ struct btrfs_dev_replace_item {
 					 BTRFS_BLOCK_GROUP_RAID1C4 | \
 					 BTRFS_BLOCK_GROUP_RAID5 |   \
 					 BTRFS_BLOCK_GROUP_RAID6 |   \
+					 BTRFS_BLOCK_GROUP_RAID5J |   \
+					 BTRFS_BLOCK_GROUP_RAID6J |   \
 					 BTRFS_BLOCK_GROUP_DUP |     \
 					 BTRFS_BLOCK_GROUP_RAID10)
 #define BTRFS_BLOCK_GROUP_RAID56_MASK	(BTRFS_BLOCK_GROUP_RAID5 |   \
-					 BTRFS_BLOCK_GROUP_RAID6)
+					 BTRFS_BLOCK_GROUP_RAID6 |   \
+					 BTRFS_BLOCK_GROUP_RAID5J |  \
+					 BTRFS_BLOCK_GROUP_RAID6J)
+
+#define BTRFS_BLOCK_GROUP_JOURNAL_MASK	(BTRFS_BLOCK_GROUP_RAID5J | \
+					 BTRFS_BLOCK_GROUP_RAID6J)
 
 #define BTRFS_BLOCK_GROUP_RAID1_MASK	(BTRFS_BLOCK_GROUP_RAID1 |   \
 					 BTRFS_BLOCK_GROUP_RAID1C3 | \
-- 
2.36.1

