Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2358A7363AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 08:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjFTGhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 02:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjFTGh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 02:37:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49593CE
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Jun 2023 23:37:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B1181F37C;
        Tue, 20 Jun 2023 06:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687243046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=KWs4zZIeVKP74+ZpoLBWBCWs4fr94CZSdzqVQ6GVXHE=;
        b=lik3xhyByt3bYCZvhWek7rYliA6FmlSjDw5zy8NctlXt7i9rj6am9rMkEHvkWk547M4rgU
        +6kS/4NjIkFHVG9o+m01953UfQE81KL4yIQvHcOpxLvFoOQi31oDWvMMgIVJKKIEtx7duQ
        uEu0LDvpyZyJx0O5NgUTK9mizzQuza4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 633B51346D;
        Tue, 20 Jun 2023 06:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IulVDSVJkWRhZAAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 20 Jun 2023 06:37:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH] btrfs: fix a u32 overflow when writing into RAID56 chunks
Date:   Tue, 20 Jun 2023 14:37:07 +0800
Message-ID: <ca680432cb92db7b57345fbd919e47032a78edf5.1687242592.git.wqu@suse.com>
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

[FIX]
Convert the result of rounddown() to u64 before the left shift.

Reported-by: David Sterba <dsterba@suse.com>
Fixes: a97699d1d610 ("btrfs: replace map_lookup->stripe_len by BTRFS_STRIPE_LEN")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b8540af6e136..b9cd41ac9d5e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6199,15 +6199,17 @@ static u64 btrfs_max_io_len(struct map_lookup *map, enum btrfs_map_op op,
 		 * not ensured to be power of 2.
 		 */
 		*full_stripe_start =
-			rounddown(*stripe_nr, nr_data_stripes(map)) <<
+			(u64)rounddown(*stripe_nr, nr_data_stripes(map)) <<
 			BTRFS_STRIPE_LEN_SHIFT;
 
 		/*
 		 * For writes to RAID56, allow to write a full stripe set, but
 		 * no straddling of stripe sets.
 		 */
-		if (op == BTRFS_MAP_WRITE)
+		if (op == BTRFS_MAP_WRITE) {
+			ASSERT(*full_stripe_start + full_stripe_len > offset);
 			return full_stripe_len - (offset - *full_stripe_start);
+		}
 	}
 
 	/*
-- 
2.41.0

