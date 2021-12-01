Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AF3464669
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 06:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346688AbhLAFV4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 00:21:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37874 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346723AbhLAFVx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 00:21:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 452581FD58;
        Wed,  1 Dec 2021 05:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638335911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2J28J0cOd7X+UOVA+D9TobKFeLe4yoENDS7sHtQWCCI=;
        b=dyfnZeBtpwbtPhzpkjbYnzlfNXERm0ZBRZybt7qhFvLYbm5P0Sn4xlhTVgGdCdWYqFe1Ar
        tmTy8jrTmdyrHmDPmbD63nbJx/e2cLsOjJaXzRYj8PyeL0m5hMU2Zknrl/LddTN8Nr/YNr
        j6TrbcV55cPQjeg5GfcpTqTZpKnxoGE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 494C113425;
        Wed,  1 Dec 2021 05:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gBN1BqYFp2EGbwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 01 Dec 2021 05:18:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 12/17] btrfs: return proper mapped length for RAID56 profiles in __btrfs_map_block()
Date:   Wed,  1 Dec 2021 13:17:51 +0800
Message-Id: <20211201051756.53742-13-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201051756.53742-1-wqu@suse.com>
References: <20211201051756.53742-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

- Add extra ASSERT()s to make sure the passed stripe_len is correct

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c  | 12 ++++++++++--
 fs/btrfs/raid56.h  |  2 +-
 fs/btrfs/scrub.c   |  4 ++--
 fs/btrfs/volumes.c | 13 ++++++++++---
 fs/btrfs/volumes.h |  1 +
 5 files changed, 24 insertions(+), 8 deletions(-)

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
index 15a123e67108..58c7e8fcdeb1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2230,7 +2230,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	bio->bi_private = sblock;
 	bio->bi_end_io = scrub_missing_raid56_end_io;
 
-	rbio = raid56_alloc_missing_rbio(bio, bioc, length);
+	rbio = raid56_alloc_missing_rbio(bio, bioc, bioc->stripe_len);
 	if (!rbio)
 		goto rbio_out;
 
@@ -2846,7 +2846,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	bio->bi_private = sparity;
 	bio->bi_end_io = scrub_parity_bio_endio;
 
-	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, length,
+	rbio = raid56_parity_alloc_scrub_rbio(bio, bioc, bioc->stripe_len,
 					      sparity->scrub_dev,
 					      sparity->dbitmap,
 					      sparity->nsectors);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index af01d54502ab..365e43bbfd14 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6051,6 +6051,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 		ret = -ENOMEM;
 		goto out;
 	}
+	bioc->stripe_len = map->stripe_len;
 
 	for (i = 0; i < num_stripes; i++) {
 		bioc->stripes[i].physical =
@@ -6406,6 +6407,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 {
 	struct extent_map *em;
 	struct map_lookup *map;
+	const u64 orig_length = *length;
 	u64 stripe_offset;
 	u64 stripe_nr;
 	u64 stripe_len;
@@ -6427,6 +6429,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	ASSERT(bioc_ret);
 	ASSERT(op != BTRFS_MAP_DISCARD);
+	ASSERT(orig_length);
 
 	em = btrfs_get_chunk_map(fs_info, logical, *length);
 	ASSERT(!IS_ERR(em));
@@ -6522,7 +6525,10 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
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
@@ -6574,6 +6580,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		ret = -ENOMEM;
 		goto out;
 	}
+	bioc->stripe_len = map->stripe_len;
 
 	for (i = 0; i < num_stripes; i++) {
 		bioc->stripes[i].physical = map->stripes[stripe_index].physical +
@@ -6824,9 +6831,9 @@ static int submit_one_mapped_range(struct btrfs_fs_info *fs_info, struct bio *bi
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
index 8825a17d0620..b2dbf895b4e3 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -450,6 +450,7 @@ struct btrfs_io_context {
 	struct bio *orig_bio;
 	void *private;
 	atomic_t error;
+	u32 stripe_len;
 	int max_errors;
 	int num_stripes;
 	int mirror_num;
-- 
2.34.1

