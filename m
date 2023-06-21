Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086FD73786B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 02:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjFUAxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 20:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjFUAxB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 20:53:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A810CE
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 17:53:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B603A2185C;
        Wed, 21 Jun 2023 00:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687308778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Tu93yiMwJ+0wdt5Ak3ztNK5Ipqks+JxFQXhHdR+t3YI=;
        b=jDgyLLuRz1GAQEPYhj3zLq29/onqfosRRDVY1oIFhgznnzh1oe3uxjcR81RBtrz0zxMNOE
        Z9XY6LL0+eJm9l8RsbBR8Q7HXQuEcIkL9s/MQPb6ExEyT2S3ZvXGVLAcvOiTDI8xdX7LkV
        t3Sf3OnoUAAx407STkwWFaq0POAV2FY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6FA21346D;
        Wed, 21 Jun 2023 00:52:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wD/4J+lJkmSgQAAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 21 Jun 2023 00:52:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v3] btrfs: fix u32 overflows when left shifting @stripe_nr
Date:   Wed, 21 Jun 2023 08:52:40 +0800
Message-ID: <f54a6df348877cb38380d842743aafdf8ab8995a.1687308686.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
David reported an ASSERT() get triggered during certain fio load.

The ASSERT() is from rbio_add_bio() of raid56.c:

	ASSERT(orig_logical >= full_stripe_start &&
	       orig_logical + orig_len <= full_stripe_start +
	       rbio->nr_data * BTRFS_STRIPE_LEN);

Which is checking if the target rbio is crossing the full stripe
boundary.

[CAUSE]
Commit a97699d1d610 ("btrfs: replace map_lookup->stripe_len by
BTRFS_STRIPE_LEN") changes how we calculate the map length, to reduce
u64 division.

Function btrfs_max_io_len() is to get the length to the stripe boundary.

It calculates the full stripe start offset (inside the chunk) by the
following command:

		*full_stripe_start =
			rounddown(*stripe_nr, nr_data_stripes(map)) <<
			BTRFS_STRIPE_LEN_SHIFT;

The calculation itself is fine, but the value returned by rounddown() is
dependent on both @stripe_nr (which is u32) and nr_data_stripes() (which
returned int).

Thus the result is also u32, then we do the left shift, which can
overflow u32.

If such overflow happens, @full_stripe_start will be a value way smaller
than @offset, causing later "full_stripe_len - (offset -
*full_stripe_start)" to underflow, thus make later length calculation to
have no stripe boundary limit, resulting a write bio to exceed stripe
boundary.

There are some other locations like this, with a u32 @stripe_nr got left
shift, which can lead to a similar overflow.

[FIX]
Introduce a dedicated helper, btrfs_stripe_nr_to_offset(), to do the
proper type cast.

Those involved @stripe_nr or similar variables are recording the stripe
number inside the chunk, which is small enough to be contained by u32,
but their offset inside the chunk can not fit into u32.

For now only the unsafe call sites are converted to the helper, as this
patch is only a hotfix.

The remaining call sites would be cleaned up later.

Reported-by: David Sterba <dsterba@suse.com>
Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix all @stripe_nr with left shift
- Apply the ASSERT() on full stripe checks for all RAID56 IOs.

v3:
- Use a dedicated helper to do the left shift.
---
 fs/btrfs/volumes.c | 15 ++++++++-------
 fs/btrfs/volumes.h | 11 +++++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b8540af6e136..7d7768ba28c0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5985,12 +5985,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
 
 	/* stripe_offset is the offset of this block in its stripe */
-	stripe_offset = offset - (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+	stripe_offset = offset - btrfs_stripe_nr_to_offset(stripe_nr);
 
 	stripe_nr_end = round_up(offset + length, BTRFS_STRIPE_LEN) >>
 			BTRFS_STRIPE_LEN_SHIFT;
 	stripe_cnt = stripe_nr_end - stripe_nr;
-	stripe_end_offset = (stripe_nr_end << BTRFS_STRIPE_LEN_SHIFT) -
+	stripe_end_offset = (btrfs_stripe_nr_to_offset(stripe_nr_end)) -
 			    (offset + length);
 	/*
 	 * after this, stripe_nr is the number of stripes on this
@@ -6033,7 +6033,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	for (i = 0; i < *num_stripes; i++) {
 		stripes[i].physical =
 			map->stripes[stripe_index].physical +
-			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+			stripe_offset + btrfs_stripe_nr_to_offset(stripe_nr);
 		stripes[i].dev = map->stripes[stripe_index].dev;
 
 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
@@ -6198,10 +6198,11 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 		 * to go rounddown(), not round_down(), as nr_data_stripes is
 		 * not ensured to be power of 2.
 		 */
-		*full_stripe_start =
-			rounddown(*stripe_nr, nr_data_stripes(map)) <<
-			BTRFS_STRIPE_LEN_SHIFT;
+		*full_stripe_start = btrfs_stripe_nr_to_offset(
+				rounddown(*stripe_nr, nr_data_stripes(map)));
 
+		ASSERT(*full_stripe_start + full_stripe_len > offset);
+		ASSERT(*full_stripe_start <= offset);
 		/*
 		 * For writes to RAID56, allow to write a full stripe set, but
 		 * no straddling of stripe sets.
@@ -6224,7 +6225,7 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
 {
 	dst->dev = map->stripes[stripe_index].dev;
 	dst->physical = map->stripes[stripe_index].physical +
-			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+			stripe_offset + btrfs_stripe_nr_to_offset(stripe_nr);
 }
 
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 3930ee01d696..ead37c0feb6c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -580,6 +580,17 @@ static inline unsigned long btrfs_chunk_item_size(int num_stripes)
 		sizeof(struct btrfs_stripe) * (num_stripes - 1);
 }
 
+/*
+ * Type safe conversion from (u32) stripe_nr to (u64) offset inside the chunk.
+ *
+ * (stripe_nr << BTRFS_STRIPE_LEN_SHIFT) is still u32, which can cause overflow
+ * for chunks larger than 4G.
+ */
+static inline u64 btrfs_stripe_nr_to_offset(u32 stripe_nr)
+{
+	return (u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT;
+}
+
 void btrfs_get_bioc(struct btrfs_io_context *bioc);
 void btrfs_put_bioc(struct btrfs_io_context *bioc);
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-- 
2.41.0

