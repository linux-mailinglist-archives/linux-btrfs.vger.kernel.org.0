Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566D04D7E22
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiCNJJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiCNJJD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0DD13F27
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:07:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D20F1F397
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmsxilV/vUK7o/U5LTpJUvZVUZQOm+0Lbk6gqHDTwS0=;
        b=BptaoTvy0I8kZ/D9BcSYRqXPMIeZpkQHsBR0398eVOKlDEaI9pwxWniltfvDYKM2f2qKsD
        R57j8fYtsZu7S4mwUv+kaT1EecpAC0Bgsadat24+07SYEXEDTHCKB5dBbTFMiW7et1huou
        QFwgVjgAEWUO0CefJmfFrNmSAp3pQ+s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0B9F13ADA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AOCMGucFL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 02/18] btrfs: save bio::bi_iter into btrfs_bio::iter before any endio
Date:   Mon, 14 Mar 2022 17:07:15 +0800
Message-Id: <2e2b4bc515efc62f21796bed77af1a2e8ef24d66.1647248613.git.wqu@suse.com>
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

Currently btrfs_bio::iter is only utilized by direct IO.

But later we will utilize btrfs_bio::iter to record the original
bi_iter, for all endio functions to iterate the original range.

Thus this patch will introduce a new helper, btrfs_bio_save_iter(), to
save bi_iter into btrfs_bio::iter.

All path that can lead to an bio_endio() call needs such
btrfs_bio_save_iter() call.

Under most common case, there will be a btrfs_map_bio() call to handle
submitted bios.

While for other error out paths, we need to call btrfs_bio_save_iter()
manually, or later endio functions will ASSERT() on empty
btrfs_bio::iter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  3 +++
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/extent_io.c   |  7 +++++++
 fs/btrfs/raid56.c      |  2 ++
 fs/btrfs/volumes.c     |  1 +
 fs/btrfs/volumes.h     | 17 +++++++++++++++++
 6 files changed, 32 insertions(+)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index be476f094300..1515c3c507a6 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -879,6 +879,9 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
+	/* Save bi_iter so that end_bio_extent_readpage() won't freak out. */
+	btrfs_bio_save_iter(btrfs_bio(bio));
+
 	while (cur_disk_byte < disk_bytenr + compressed_len) {
 		u64 offset = cur_disk_byte - disk_bytenr;
 		unsigned int index = offset >> PAGE_SHIFT;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 09693ab4fde0..258ff67631e3 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -824,6 +824,7 @@ static void run_one_async_done(struct btrfs_work *work)
 	/* If an error occurred we just want to clean up the bio and move on */
 	if (async->status) {
 		async->bio->bi_status = async->status;
+		btrfs_bio_save_iter(btrfs_bio(async->bio));
 		bio_endio(async->bio);
 		return;
 	}
@@ -956,6 +957,7 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
 
 out_w_error:
 	bio->bi_status = ret;
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	bio_endio(bio);
 	return ret;
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 78486bbd1ac9..cd23ea793838 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -174,6 +174,11 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
+	/*
+	 * This for later endio on errors, as later endio functions will rely
+	 * on btrfs_bio::iter.
+	 */
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	if (is_data_inode(tree->private_data))
 		ret = btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
 					    bio_flags);
@@ -191,6 +196,7 @@ static void end_write_bio(struct extent_page_data *epd, int ret)
 
 	if (bio) {
 		bio->bi_status = errno_to_blk_status(ret);
+		btrfs_bio_save_iter(btrfs_bio(bio));
 		bio_endio(bio);
 		epd->bio_ctrl.bio = NULL;
 	}
@@ -3357,6 +3363,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 error:
 	bio_ctrl->bio = NULL;
 	bio->bi_status = errno_to_blk_status(ret);
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	bio_endio(bio);
 	return ret;
 }
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0e239a4c3b26..13e726c88a81 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1731,6 +1731,7 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
 		return PTR_ERR(rbio);
 	}
 	bio_list_add(&rbio->bio_list, bio);
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	rbio->bio_list_bytes = bio->bi_iter.bi_size;
 	rbio->operation = BTRFS_RBIO_WRITE;
 
@@ -2135,6 +2136,7 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 
 	rbio->operation = BTRFS_RBIO_READ_REBUILD;
 	bio_list_add(&rbio->bio_list, bio);
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	rbio->bio_list_bytes = bio->bi_iter.bi_size;
 
 	rbio->faila = find_logical_bio_stripe(rbio, bio);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1be7cb2f955f..9bc48a8368e8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6786,6 +6786,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	map_length = length;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
+	btrfs_bio_save_iter(btrfs_bio(bio));
 	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
 				&map_length, &bioc, mirror_num, 1);
 	if (ret) {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bd297f23d19e..d600419fe6a5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -332,6 +332,12 @@ struct btrfs_bio {
 	struct btrfs_device *device;
 	u8 *csum;
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+	/*
+	 * Saved bio::bi_iter before submission.
+	 *
+	 * This allows us to interate the cloned/split bio properly, as at
+	 * endio time bio::bi_iter is no longer reliable.
+	 */
 	struct bvec_iter iter;
 
 	/*
@@ -354,6 +360,17 @@ static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 	}
 }
 
+/*
+ * To save bbio::bio->bi_iter into bbio::iter so for callers who need the
+ * original bi_iter can access the original part of the bio.
+ * This is especially important for the incoming split btrfs_bio, which needs
+ * to call its endio for and only for the split range.
+ */
+static inline void btrfs_bio_save_iter(struct btrfs_bio *bbio)
+{
+	bbio->iter = bbio->bio.bi_iter;
+}
+
 struct btrfs_io_stripe {
 	struct btrfs_device *dev;
 	u64 physical;
-- 
2.35.1

