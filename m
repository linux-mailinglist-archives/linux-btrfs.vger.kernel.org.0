Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE5E4FDCBA
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353395AbiDLKic (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354234AbiDLKdi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E8C5B3E0
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5625D210EC
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WrXXpqDr4JlWHviYSnMPVtPDf1ooz09D4AaPd8hs6xg=;
        b=At7BJmTZcml3fNYDXaa1XcmiXg6VxmaebzilpK+ChGcK7thScSs9zb8Qx1GVgYlz+XKxp1
        o8L4Zg+j0AjV4tv3ycaM0KwhvrUBVRJknm0VsYFln43HsRGeSG0uUZngYq4XXKEtTBNbLn
        5CPRssiYq7MwRuyNgmm05Th4FWGnKXA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FD3013A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IAuEGWZHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:26 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/17] btrfs: reduce width for stripe_len from u64 to u32
Date:   Tue, 12 Apr 2022 17:32:51 +0800
Message-Id: <bbb4daa6c6e5579aa240e5865d0907f2bf997a7e.1649753690.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649753690.git.wqu@suse.com>
References: <cover.1649753690.git.wqu@suse.com>
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

Currently btrfs uses fixed stripe length (64K), thus u32 is wide enough
for the usage.

Furthermore, even in the future we choose to enlarge stripe length to
larger values, I don't believe we would want stripe as large as 4G or
larger.

So this patch will reduce the width for all in-memory structures and
parameters, this involves:

- RAID56 related function argument lists
  This allows us to do direct division related to stripe_len.
  Although we will use bits shift to replace the division anyway.

- btrfs_io_geometry structure
  This involves one change to simplify the calculation of both @stripe_nr
  and @stripe_offset, using div64_u64_rem().
  And add extra sanity check to make sure @stripe_offset is always small
  enough for u32.

  This saves 8 bytes for the structure.

- map_lookup structure
  This convert @stripe_len to u32, which saves 8 bytes. (saved 4 bytes,
  and removed a 4-bytes hole)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c  | 15 ++++++++-------
 fs/btrfs/raid56.h  |  6 +++---
 fs/btrfs/volumes.c | 20 +++++++-------------
 fs/btrfs/volumes.h |  8 ++++----
 4 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 79438cdd604e..daffa3076325 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -949,9 +949,10 @@ static struct page *page_in_rbio(struct btrfs_raid_bio *rbio,
  * number of pages we need for the entire stripe across all the
  * drives
  */
-static unsigned long rbio_nr_pages(unsigned long stripe_len, int nr_stripes)
+static unsigned long rbio_nr_pages(u32 stripe_len, int nr_stripes)
 {
-	return DIV_ROUND_UP(stripe_len, PAGE_SIZE) * nr_stripes;
+	ASSERT(IS_ALIGNED(stripe_len, PAGE_SIZE));
+	return (stripe_len >> PAGE_SHIFT) * nr_stripes;
 }
 
 /*
@@ -960,13 +961,13 @@ static unsigned long rbio_nr_pages(unsigned long stripe_len, int nr_stripes)
  */
 static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_io_context *bioc,
-					 u64 stripe_len)
+					 u32 stripe_len)
 {
 	struct btrfs_raid_bio *rbio;
 	int nr_data = 0;
 	int real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
 	int num_pages = rbio_nr_pages(stripe_len, real_stripes);
-	int stripe_npages = DIV_ROUND_UP(stripe_len, PAGE_SIZE);
+	int stripe_npages = stripe_len >> PAGE_SHIFT;
 	void *p;
 
 	rbio = kzalloc(sizeof(*rbio) +
@@ -1692,7 +1693,7 @@ static void btrfs_raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
  * our main entry point for writes from the rest of the FS.
  */
 int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
-			u64 stripe_len)
+			u32 stripe_len)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
@@ -2089,7 +2090,7 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
  * of the drive.
  */
 int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
-			  u64 stripe_len, int mirror_num, int generic_io)
+			  u32 stripe_len, int mirror_num, int generic_io)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
@@ -2195,7 +2196,7 @@ static void read_rebuild_work(struct btrfs_work *work)
 
 struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				struct btrfs_io_context *bioc,
-				u64 stripe_len, struct btrfs_device *scrub_dev,
+				u32 stripe_len, struct btrfs_device *scrub_dev,
 				unsigned long *dbitmap, int stripe_nsectors)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 72c00fc284b5..fb35ae157b02 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -31,15 +31,15 @@ struct btrfs_raid_bio;
 struct btrfs_device;
 
 int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
-			  u64 stripe_len, int mirror_num, int generic_io);
+			  u32 stripe_len, int mirror_num, int generic_io);
 int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
-			u64 stripe_len);
+			u32 stripe_len);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 			    u64 logical);
 
 struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
-				struct btrfs_io_context *bioc, u64 stripe_len,
+				struct btrfs_io_context *bioc, u32 stripe_len,
 				struct btrfs_device *scrub_dev,
 				unsigned long *dbitmap, int stripe_nsectors);
 void raid56_parity_submit_scrub_rbio(struct btrfs_raid_bio *rbio);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2368a2ffbee7..93072a090fdd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6313,7 +6313,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	u64 offset;
 	u64 stripe_offset;
 	u64 stripe_nr;
-	u64 stripe_len;
+	u32 stripe_len;
 	u64 raid56_full_stripe_start = (u64)-1;
 	int data_stripes;
 
@@ -6324,19 +6324,13 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
 	offset = logical - em->start;
 	/* Len of a stripe in a chunk */
 	stripe_len = map->stripe_len;
-	/* Stripe where this block falls in */
-	stripe_nr = div64_u64(offset, stripe_len);
-	/* Offset of stripe in the chunk */
-	stripe_offset = stripe_nr * stripe_len;
-	if (offset < stripe_offset) {
-		btrfs_crit(fs_info,
-"stripe math has gone wrong, stripe_offset=%llu offset=%llu start=%llu logical=%llu stripe_len=%llu",
-			stripe_offset, offset, em->start, logical, stripe_len);
-		return -EINVAL;
-	}
+	/*
+	 * Stripe_nr is where this block falls in
+	 * stripe_offset is the offset of this block in its stripe.
+	 */
+	stripe_nr = div64_u64_rem(offset, stripe_len, &stripe_offset);
+	ASSERT(stripe_offset < U32_MAX);
 
-	/* stripe_offset is the offset of this block in its stripe */
-	stripe_offset = offset - stripe_offset;
 	data_stripes = nr_data_stripes(map);
 
 	/* Only stripe based profiles needs to check against stripe length. */
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bd297f23d19e..0332a0a25483 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -23,11 +23,11 @@ struct btrfs_io_geometry {
 	/* offset of logical address in chunk */
 	u64 offset;
 	/* length of single IO stripe */
-	u64 stripe_len;
+	u32 stripe_len;
+	/* offset of address in stripe */
+	u32 stripe_offset;
 	/* number of stripe where address falls */
 	u64 stripe_nr;
-	/* offset of address in stripe */
-	u64 stripe_offset;
 	/* offset of raid56 stripe into the chunk */
 	u64 raid56_stripe_offset;
 };
@@ -427,7 +427,7 @@ struct map_lookup {
 	u64 type;
 	int io_align;
 	int io_width;
-	u64 stripe_len;
+	u32 stripe_len;
 	int num_stripes;
 	int sub_stripes;
 	int verified_stripes; /* For mount time dev extent verification */
-- 
2.35.1

