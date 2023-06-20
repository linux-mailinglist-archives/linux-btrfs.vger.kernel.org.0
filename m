Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8887736892
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjFTKAc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 06:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjFTKAA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 06:00:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA641FD5
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 02:57:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E19051F37E;
        Tue, 20 Jun 2023 09:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687255069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VR/mokhnbBg8XHLBQnJo9x3oshZeyW9eo8ir+QYWW2E=;
        b=BcFCYUL5ojq9E+VFM0JEwkpjEx9s6q9dq3H8h2fT+tANsMF6IqW1c/lL8NZ3WoHPn2EICj
        gE9guKQu4S8W3D1o+pSIQalQ1xyDqP3WfE9dYDiCxgboncQ74Vc6ran2qLgkI+5UnMgQ+D
        d0qVfp3JRPYK/7w0SHphpzPAA+gd2ic=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24CC7133A9;
        Tue, 20 Jun 2023 09:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id N/NZORx4kWQ6SwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 20 Jun 2023 09:57:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH v2] btrfs: fix u32 overflows when left shifting @stripe_nr
Date:   Tue, 20 Jun 2023 17:57:31 +0800
Message-ID: <1974782b207e7011a859a45115cf4875475204dc.1687254779.git.wqu@suse.com>
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
Fix all @stripe_nr with left shift with a type cast to u64 before the
left shift.

Those involved @stripe_nr or similar variables are recording the stripe
number inside the chunk, which is small enough to be contained by u32,
but their offset inside the chunk can not fit into u32.

Thus for those specific left shifts, a type cast to u64 is necessary.

Reported-by: David Sterba <dsterba@suse.com>
Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix all @stripe_nr with left shift
- Apply the ASSERT() on full stripe checks for all RAID56 IOs.
---
 fs/btrfs/volumes.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b8540af6e136..ed3765d21cb0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5985,12 +5985,12 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	stripe_nr = offset >> BTRFS_STRIPE_LEN_SHIFT;
 
 	/* stripe_offset is the offset of this block in its stripe */
-	stripe_offset = offset - (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+	stripe_offset = offset - ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
 
 	stripe_nr_end = round_up(offset + length, BTRFS_STRIPE_LEN) >>
 			BTRFS_STRIPE_LEN_SHIFT;
 	stripe_cnt = stripe_nr_end - stripe_nr;
-	stripe_end_offset = (stripe_nr_end << BTRFS_STRIPE_LEN_SHIFT) -
+	stripe_end_offset = ((u64)stripe_nr_end << BTRFS_STRIPE_LEN_SHIFT) -
 			    (offset + length);
 	/*
 	 * after this, stripe_nr is the number of stripes on this
@@ -6033,7 +6033,7 @@ struct btrfs_discard_stripe *btrfs_map_discard(struct btrfs_fs_info *fs_info,
 	for (i = 0; i < *num_stripes; i++) {
 		stripes[i].physical =
 			map->stripes[stripe_index].physical +
-			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+			stripe_offset + ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
 		stripes[i].dev = map->stripes[stripe_index].dev;
 
 		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
@@ -6199,15 +6199,18 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 		 * not ensured to be power of 2.
 		 */
 		*full_stripe_start =
-			rounddown(*stripe_nr, nr_data_stripes(map)) <<
+			(u64)rounddown(*stripe_nr, nr_data_stripes(map)) <<
 			BTRFS_STRIPE_LEN_SHIFT;
 
+		ASSERT(*full_stripe_start + full_stripe_len > offset);
+		ASSERT(*full_stripe_start <= offset);
 		/*
 		 * For writes to RAID56, allow to write a full stripe set, but
 		 * no straddling of stripe sets.
 		 */
-		if (op == BTRFS_MAP_WRITE)
+		if (op == BTRFS_MAP_WRITE) {
 			return full_stripe_len - (offset - *full_stripe_start);
+		}
 	}
 
 	/*
@@ -6224,7 +6227,7 @@ static void set_io_stripe(struct btrfs_io_stripe *dst, const struct map_lookup *
 {
 	dst->dev = map->stripes[stripe_index].dev;
 	dst->physical = map->stripes[stripe_index].physical +
-			stripe_offset + (stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
+			stripe_offset + ((u64)stripe_nr << BTRFS_STRIPE_LEN_SHIFT);
 }
 
 int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
-- 
2.41.0

