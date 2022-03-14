Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9024D7E2E
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiCNJJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbiCNJJO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39083245A6
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:08:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ED7601F397
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blm7UyQTlFbkDGLEfg1fwx7tVg4jtPAqm/YR6fVfi6w=;
        b=YyK8MK0KTrLuMjhMwKpUqCrwY4jWL39S+AyNYt9+gBnvW6zMfmILVKJI0q74F3INjcv/Bk
        rmRTikO/7AlYeD3SQTx7OlORLlOpFZbsOlZ1TFvejUvPhYRgKEkvuN/cprWheiTOnQgVun
        HdsGdOlYiIgWspsINeEHMW4iIO0Th7w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BCEA13ADA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2JXSBfIFL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 12/18] btrfs: return proper mapped length for RAID56 profiles in __btrfs_map_block()
Date:   Mon, 14 Mar 2022 17:07:25 +0800
Message-Id: <69d536f7cfe77d919107f992146d1fb734f09f73.1647248613.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647248613.git.wqu@suse.com>
References: <cover.1647248613.git.wqu@suse.com>
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

For profiles other than RAID56, __btrfs_map_block() returns @map_length
as min(stripe_end, logical + *length), which is also the same result
from btrfs_get_io_geometry().

But for RAID56, __btrfs_map_block() returns @map_length as stripe_len.

This strange behavior is going to hurt incoming bio split at
btrfs_map_bio() time, as we will use @map_length as bio split size.

Fix this behavior by:

- Return @map_length by the same calculatioin as other profiles

- Save stripe_len into btrfs_io_context

- Pass btrfs_io_context::stripe_len to raid56_*() functions

- Update raid56_*() functions to make its stripe_len parameter more
  explicit

- Update scrub_stripe_index_and_offset() to properly name its
  parameters

- Add extra ASSERT()s to make sure the passed stripe_len is correct

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c  | 12 ++++++++++--
 fs/btrfs/raid56.h  |  2 +-
 fs/btrfs/scrub.c   | 14 ++++++++------
 fs/btrfs/volumes.c | 13 ++++++++++---
 fs/btrfs/volumes.h |  1 +
 5 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 13e726c88a81..d35cfd750b76 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -969,6 +969,8 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	int stripe_npages = DIV_ROUND_UP(stripe_len, PAGE_SIZE);
 	void *p;
 
+	ASSERT(stripe_len == BTRFS_STRIPE_LEN);
+
 	rbio = kzalloc(sizeof(*rbio) +
 		       sizeof(*rbio->stripe_pages) * num_pages +
 		       sizeof(*rbio->bio_pages) * num_pages +
@@ -1725,6 +1727,9 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
 	struct blk_plug_cb *cb;
 	int ret;
 
+	/* Currently we only support fixed stripe len */
+	ASSERT(stripe_len == BTRFS_STRIPE_LEN);
+
 	rbio = alloc_rbio(fs_info, bioc, stripe_len);
 	if (IS_ERR(rbio)) {
 		btrfs_put_bioc(bioc);
@@ -2122,6 +2127,9 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	struct btrfs_raid_bio *rbio;
 	int ret;
 
+	/* Currently we only support fixed stripe len */
+	ASSERT(stripe_len == BTRFS_STRIPE_LEN);
+
 	if (generic_io) {
 		ASSERT(bioc->mirror_num == mirror_num);
 		btrfs_bio(bio)->mirror_num = mirror_num;
@@ -2671,12 +2679,12 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio)
 
 struct btrfs_raid_bio *
 raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc,
-			  u64 length)
+			  u64 stripe_len)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
 
-	rbio = alloc_rbio(fs_info, bioc, length);
+	rbio = alloc_rbio(fs_info, bioc, stripe_len);
 	if (IS_ERR(rbio))
 		return NULL;
 
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 72c00fc284b5..7322dcae4498 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -46,7 +46,7 @@ void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
 
 struct btrfs_raid_bio *
 raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc,
-			  u64 length);
+			  u64 stripe_len);
 void raid56_submit_missing_rbio(struct btrfs_raid_bio *rbio);
 
 int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 11089568b287..6b3f4149883f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1222,13 +1222,15 @@ static inline int scrub_nr_raid_mirrors(struct btrfs_io_context *bioc)
 
 static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
 						 u64 *raid_map,
-						 u64 mapped_length,
+						 u64 stripe_len,
 						 int nstripes, int mirror,
 						 int *stripe_index,
 						 u64 *stripe_offset)
 {
 	int i;
 
+	ASSERT(stripe_len == BTRFS_STRIPE_LEN);
+
 	if (map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
 		/* RAID5/6 */
 		for (i = 0; i < nstripes; i++) {
@@ -1237,7 +1239,7 @@ static inline void scrub_stripe_index_and_offset(u64 logical, u64 map_type,
 				continue;
 
 			if (logical >= raid_map[i] &&
-			    logical < raid_map[i] + mapped_length)
+			    logical < raid_map[i] + stripe_len)
 				break;
 		}
 
@@ -1342,7 +1344,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			scrub_stripe_index_and_offset(logical,
 						      bioc->map_type,
 						      bioc->raid_map,
-						      mapped_length,
+						      bioc->stripe_len,
 						      bioc->num_stripes -
 						      bioc->num_tgtdevs,
 						      mirror_index,
@@ -1394,7 +1396,7 @@ static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 
 	mirror_num = spage->sblock->pagev[0]->mirror_num;
 	ret = raid56_parity_recover(bio, spage->recover->bioc,
-				    spage->recover->map_length,
+				    spage->recover->bioc->stripe_len,
 				    mirror_num, 0);
 	if (ret)
 		return ret;
@@ -2223,7 +2225,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
 
-	rbio = raid56_alloc_missing_rbio(bio, bioc, length);
+	rbio = raid56_alloc_missing_rbio(bio, bioc, bioc->stripe_len);
 	if (!rbio)
 		goto rbio_out;
 
@@ -2839,7 +2841,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
 
-	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, length,
+	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, bioc->stripe_len,
 					      sparity->scrub_dev,
 					      sparity->dbitmap,
 					      sparity->nsectors);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d2b9cba1e5fd..e4e688b31c90 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6043,6 +6043,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 		ret = -ENOMEM;
 		goto out;
 	}
+	bioc->stripe_len = map->stripe_len;
 
 	for (i = 0; i < num_stripes; i++) {
 		bioc->stripes[i].physical =
@@ -6398,6 +6399,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 {
 	struct extent_map *em;
 	struct map_lookup *map;
+	const u64 orig_length = *length;
 	u64 stripe_offset;
 	u64 stripe_nr;
 	u64 stripe_len;
@@ -6419,6 +6421,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	ASSERT(bioc_ret);
 	ASSERT(op != BTRFS_MAP_DISCARD);
+	ASSERT(orig_length);
 
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
 	ASSERT(!IS_ERR(em));
@@ -6514,7 +6517,10 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 			num_stripes = map->num_stripes;
 			max_errors = nr_parity_stripes(map);
 
-			*length = map->stripe_len;
+			/* Return the length to the full stripe end */
+			*length = min(raid56_full_stripe_start + em->start +
+				      data_stripes * stripe_len,
+				      logical + orig_length) - logical;
 			stripe_index = 0;
 			stripe_offset = 0;
 		} else {
@@ -6566,6 +6572,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		ret = -ENOMEM;
 		goto out;
 	}
+	bioc->stripe_len = map->stripe_len;
 
 	for (i = 0; i < num_stripes; i++) {
 		bioc->stripes[i].physical = map->stripes[stripe_index].physical +
@@ -6816,9 +6823,9 @@ static int submit_one_mapped_range(struct btrfs_fs_info *fs_info, struct bio *bi
 		/* In this case, map_length has been set to the length of
 		   a single stripe; not the whole write */
 		if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
-			ret = raid56_parity_write(bio, bioc, map_length);
+			ret = raid56_parity_write(bio, bioc, bioc->stripe_len);
 		} else {
-			ret = raid56_parity_recover(bio, bioc, map_length,
+			ret = raid56_parity_recover(bio, bioc, bioc->stripe_len,
 						    mirror_num, 1);
 		}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 5496b8750e28..410617cb7533 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -447,6 +447,7 @@ struct btrfs_io_context {
 	struct bio *orig_bio;
 	void *private;
 	atomic_t error;
+	u32 stripe_len;
 	int max_errors;
 	int num_stripes;
 	int mirror_num;
-- 
2.35.1

