Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420826CCE68
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Mar 2023 01:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjC1X60 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 19:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjC1X6Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 19:58:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45DB2689
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 16:57:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 861BF21A47;
        Tue, 28 Mar 2023 23:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680047808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ak9tQiIZGkcBcxRkh/K+7U87ndmQxXNK+09nm9hZWwc=;
        b=bSFjOP7HG/Wc3gCSt5Kliu02ymblqatxvH03rdKlPjEnCHc6P+xfaoK0UnskP22SgLjY/z
        0vgTFhV4CQFksvVN6TJgy/VJ8Gvvbk28XD04e5Bn6rnhxeWyZlB26Y7dQVT+WsWIBbYMRS
        S02U1bgh3noNSznrzBh0Zl0DP/7mdn4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5B0813488;
        Tue, 28 Mar 2023 23:56:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IIV7Jb9+I2T4eQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 28 Mar 2023 23:56:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v7 10/13] btrfs: scrub: introduce a writeback helper for scrub_stripe
Date:   Wed, 29 Mar 2023 07:56:17 +0800
Message-Id: <65e6477ee75396ca7f73780174321ee85b7bfd67.1680047473.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680047473.git.wqu@suse.com>
References: <cover.1680047473.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a new helper, scrub_write_sectors(), to submit write bios for
specified sectors to the target disk

There are several differences compared to read path:

- Utilize btrfs_submit_scrub_write()
  Now we still rely on the @mirror_num based writeback, but the
  requirement is also a little different than regular writeback
  or read, thus we have to call btrfs_submit_scrub_write().

- We can not write the full stripe back
  We can only write the sectors we have.
  There will be two call sites later, one for repaired sectors,
  one for all utilized sectors of dev-replace.

  Thus the callers should specify their own write_bitmap.

This function only submit the bios, will not wait for them unless for
zoned case.

Caller must explicitly wait for the IO to finish.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/scrub.h |  3 ++
 2 files changed, 98 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d65286a6de5a..b6d2361a6ddb 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -152,6 +152,12 @@ struct scrub_stripe {
 	unsigned long csum_error_bitmap;
 	unsigned long meta_error_bitmap;
 
+	/* For writeback (repair or replace) error report. */
+	unsigned long write_error_bitmap;
+
+	/* Writeback can be concurrent, thus we need to protect the bitmap. */
+	spinlock_t write_error_lock;
+
 	/*
 	 * Checksum for the whole stripe if this stripe is inside a data block
 	 * group.
@@ -386,6 +392,7 @@ int init_scrub_stripe(struct btrfs_fs_info *fs_info, struct scrub_stripe *stripe
 	init_waitqueue_head(&stripe->io_wait);
 	init_waitqueue_head(&stripe->repair_wait);
 	atomic_set(&stripe->pending_io, 0);
+	spin_lock_init(&stripe->write_error_lock);
 
 	ret = btrfs_alloc_page_array(SCRUB_STRIPE_PAGES, stripe->pages);
 	if (ret < 0)
@@ -2559,6 +2566,94 @@ void scrub_read_endio(struct btrfs_bio *bbio)
 	}
 }
 
+static void scrub_write_endio(struct btrfs_bio *bbio)
+{
+	struct scrub_stripe *stripe = bbio->private;
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct bio_vec *bvec;
+	unsigned long flags;
+	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
+	unsigned int bio_size = 0;
+	int i;
+
+	bio_for_each_bvec_all(bvec, &bbio->bio, i)
+		bio_size += bvec->bv_len;
+
+	if (bbio->bio.bi_status) {
+		spin_lock_irqsave(&stripe->write_error_lock, flags);
+		bitmap_set(&stripe->write_error_bitmap, sector_nr,
+				bio_size >> fs_info->sectorsize_bits);
+		spin_unlock_irqrestore(&stripe->write_error_lock, flags);
+	}
+	bio_put(&bbio->bio);
+
+	if (atomic_dec_and_test(&stripe->pending_io))
+		wake_up(&stripe->io_wait);
+}
+
+/*
+ * Submit the write bio(s) for the sectors specified by @write_bitmap.
+ *
+ * Here we utilize btrfs_submit_scrub_write(), which has some extra benefits:
+ *
+ * - Only needs logical bytenr and mirror_num
+ *   Just like the scrub read path
+ *
+ * - Would only result writes to the specified mirror
+ *   Unlike the regular writeback path, which would write back to all stripes
+ *
+ * - Handle dev-replace and read-repair writeback differently
+ */
+void scrub_write_sectors(struct scrub_ctx *sctx,
+			struct scrub_stripe *stripe,
+			unsigned long write_bitmap, bool dev_replace)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct btrfs_bio *bbio = NULL;
+	bool zoned = btrfs_is_zoned(fs_info);
+	int sector_nr;
+
+	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
+		struct page *page = scrub_stripe_get_page(stripe, sector_nr);
+		unsigned int pgoff = scrub_stripe_get_page_offset(stripe,
+								  sector_nr);
+		int ret;
+
+		/* We should only writeback sectors covered by an extent. */
+		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
+
+		/* Can not merge with previous sector, submit the current one. */
+		if (bbio && sector_nr && !test_bit(sector_nr - 1, &write_bitmap)) {
+			fill_writer_pointer_gap(sctx, stripe->physical +
+					(sector_nr << fs_info->sectorsize_bits));
+			atomic_inc(&stripe->pending_io);
+			btrfs_submit_scrub_write(bbio, stripe->mirror_num,
+						 dev_replace);
+			/* For zoned writeback, queue depth must be 1. */
+			if (zoned)
+				wait_scrub_stripe_io(stripe);
+			bbio = NULL;
+		}
+		if (!bbio) {
+			bbio = btrfs_scrub_bio_alloc(REQ_OP_WRITE, fs_info,
+						     scrub_write_endio, stripe);
+			bbio->bio.bi_iter.bi_sector = (stripe->logical +
+				(sector_nr << fs_info->sectorsize_bits)) >>
+				SECTOR_SHIFT;
+		}
+		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
+		ASSERT(ret == fs_info->sectorsize);
+	}
+	if (bbio) {
+		fill_writer_pointer_gap(sctx, bbio->bio.bi_iter.bi_sector <<
+					SECTOR_SHIFT);
+		atomic_inc(&stripe->pending_io);
+		btrfs_submit_scrub_write(bbio, stripe->mirror_num, dev_replace);
+		if (zoned)
+			wait_scrub_stripe_io(stripe);
+	}
+}
+
 static int scrub_checksum_tree_block(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index bcc9d398fe07..3027d4c23ee8 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -24,5 +24,8 @@ int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 				 int mirror_num, u64 logical_start,
 				 u32 logical_len, struct scrub_stripe *stripe);
 void scrub_read_endio(struct btrfs_bio *bbio);
+void scrub_write_sectors(struct scrub_ctx *sctx,
+			struct scrub_stripe *stripe,
+			unsigned long write_bitmap, bool dev_replace);
 
 #endif
-- 
2.39.2

