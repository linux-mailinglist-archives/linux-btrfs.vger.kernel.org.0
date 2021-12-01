Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B343046465E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 06:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346693AbhLAFVq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 00:21:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55520 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346691AbhLAFVp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 00:21:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 851C2212BC;
        Wed,  1 Dec 2021 05:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638335904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZcP/wV7AYhhX+nSq875ds9inUWH5cEaDMVx7lYnhDk0=;
        b=ON5ChSRvXnTIzW32TV93veaH6wHwRb03dHNxi/S3BkxATrB7ikCjYz2TTOs5a3202xrjV0
        yUKryy8wMtGJ8XJNgY/tJ+DuU/1QvLmdC6L4/j20J1ss5CrI+AgewwcPvMKgdb2MKS4WAr
        V5M3GXg3K5GfLaSLcr/YaEDEUWP1gC4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8801B13425;
        Wed,  1 Dec 2021 05:18:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mLq6FZ8Fp2EGbwAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 01 Dec 2021 05:18:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH 07/17] btrfs: introduce btrfs_bio_split() helper
Date:   Wed,  1 Dec 2021 13:17:46 +0800
Message-Id: <20211201051756.53742-8-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201051756.53742-1-wqu@suse.com>
References: <20211201051756.53742-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new function will handle the split of a btrfs bio, to co-operate
with the incoming chunk mapping time bio split.

This patch will introduce the following new members and functions:

- btrfs_bio::offset_to_original
  Since btrfs_bio::csum is still storing the checksum for the original
  logical bytenr, we need to know the offset between current advanced
  bio and the original logical bytenr.

  Thus here we need such new member.
  And the new member will fit into the existing hole between
  btrfs_bio::mirror_num and btrfs_bio::device, it should not increase
  the memory usage of btrfs_bio.

- btrfs_bio::parent and btrfs_bio::orig_endio
  To record where the parent bio is and the original endio function.

- btrfs_bio::is_split_bio
  To distinguish bio created by btrfs_bio_split() and
  btrfs_bio_clone*().

  For cloned bio, they still have their csum pointed to correct memory,
  while split bio must rely on its parent bbio to grab csum pointer.

- split_bio_endio()
  Just to call the original endio function then call bio_endio() on
  the original bio.
  This will ensure the original bio is freed after all cloned bio.

- btrfs_split_bio()
  Split the original bio into two, the behavior is pretty much the same
  as bio_split(), just with extra btrfs specific setup.

Currently there is no other caller utilizing above new members/functions
yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 82 +++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/extent_io.h |  2 ++
 fs/btrfs/volumes.h   | 43 +++++++++++++++++++++--
 3 files changed, 123 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1a67f4b3986b..083700621b9f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3005,7 +3005,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 	int ret;
 	struct bvec_iter_all iter_all;
 
-	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		bool uptodate = !bio->bi_status;
 		struct page *page = bvec->bv_page;
@@ -3184,6 +3183,87 @@ struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size)
 	return bio;
 }
 
+/*
+ * A very simple wrapper to call original endio function and then
+ * call bio_endio() on the parent bio to decrease its bi_remaining count.
+ */
+static void split_bio_endio(struct bio *bio)
+{
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+	/* After endio bbio could be freed, thus grab the info before endio */
+	struct bio *parent = bbio->parent;
+
+	/*
+	 * BIO_CLONED can even be set for our parent bio (DIO use clones
+	 * the initial bio, then uses the cloned one for IO).
+	 * So here we don't check BIO_CLONED for parent.
+	 */
+	ASSERT(bio_flagged(bio, BIO_CLONED) && bbio->is_split_bio);
+	ASSERT(parent && !btrfs_bio(parent)->is_split_bio);
+
+	bio->bi_end_io = bbio->orig_endio;
+	bio_endio(bio);
+	bio_endio(parent);
+}
+
+/*
+ * Pretty much like bio_split(), caller needs to ensure @src is not freed
+ * before the newly allocated bio, as the new bio is relying on @src for
+ * its bvecs.
+ */
+struct bio *btrfs_bio_split(struct btrfs_fs_info *fs_info,
+			    struct bio *src, unsigned int bytes)
+{
+	struct bio *new;
+	struct btrfs_bio *src_bbio = btrfs_bio(src);
+	struct btrfs_bio *new_bbio;
+	const unsigned int old_offset = src_bbio->offset_to_original;
+
+	/* Src should not be split */
+	ASSERT(!src_bbio->is_split_bio);
+	ASSERT(IS_ALIGNED(bytes, fs_info->sectorsize));
+	ASSERT(bytes < src->bi_iter.bi_size);
+
+	/*
+	 * We're in fact chaining the new bio to the parent, but we still want
+	 * to have independent bi_private/bi_endio, thus we need to manually
+	 * increase the remaining for the source, just like bio_chain().
+	 */
+	bio_inc_remaining(src);
+
+	/* Bioset backed split should not fail */
+	new = bio_split(src, bytes >> SECTOR_SHIFT, GFP_NOFS, &btrfs_bioset);
+	new_bbio = btrfs_bio(new);
+	new_bbio->offset_to_original = old_offset;
+	new_bbio->iter = new->bi_iter;
+	new_bbio->orig_endio = src->bi_end_io;
+	new_bbio->parent = src;
+	new_bbio->endio_type = src_bbio->endio_type;
+	new_bbio->is_split_bio = 1;
+	new->bi_end_io = split_bio_endio;
+
+	/*
+	 * This is very tricky, as if any endio has extra refcount on
+	 * bi_private, we will be screwed up.
+	 *
+	 * We workaround this hacky behavior by reviewing all the involved
+	 * endio stacks. Making sure only split-safe endio remap are called.
+	 *
+	 * Split-unsafe endio remap like btrfs_bio_wq_end_io() will be called
+	 * after btrfs_bio_split().
+	 */
+	new->bi_private = src->bi_private;
+
+	src_bbio->offset_to_original += bytes;
+
+	/*
+	 * For direct IO, @src is a cloned bio thus bbio::iter still points to
+	 * the full bio. Need to update it too.
+	 */
+	src_bbio->iter = src->bi_iter;
+	return new;
+}
+
 /**
  * Attempt to add a page to bio
  *
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 0399cf8e3c32..cb727b77ecda 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -280,6 +280,8 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 struct bio *btrfs_bio_alloc(unsigned int nr_iovecs);
 struct bio *btrfs_bio_clone(struct bio *bio);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
+struct bio *btrfs_bio_split(struct btrfs_fs_info *fs_info,
+			    struct bio *src, unsigned int bytes);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f88f39042558..bd789544268c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -332,15 +332,52 @@ struct btrfs_bio {
 
 	/*
 	 * To tell which workqueue the bio's endio should be exeucted in.
+	 * This member is to make sure btrfs_bio_wq_end_io() is the last
+	 * endio remap in the stack.
 	 *
 	 * Only for read bios.
 	 */
-	u16 endio_type;
+	u8 endio_type;
+
+	/*
+	 * To tell if this btrfs bio is split or just cloned.
+	 * Both btrfs_bio_clone*() and btrfs_bio_split() will make bbio->bio
+	 * to have BIO_CLONED flag.
+	 * But cloned bio still has its bbio::csum pointed to correct memory,
+	 * unlike split bio relies on its parent bbio to grab csum.
+	 *
+	 * Thus we needs this extra flag to distinguish those cloned bio.
+	 */
+	u8 is_split_bio;
+
+	/*
+	 * Records the offset we're from the original bio.
+	 *
+	 * Since btrfs_bio can be split, but our csum is alwasy for the
+	 * original logical bytenr, we need a way to know the bytes offset
+	 * from the original logical bytenr to do proper csum verification.
+	 */
+	unsigned int offset_to_original;
 
 	/* @device is for stripe IO submission. */
 	struct btrfs_device *device;
-	u8 *csum;
-	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+
+	union {
+		/*
+		 * For the parent bio recording the csum for the original
+		 * logical bytenr
+		 */
+		struct {
+			u8 *csum;
+			u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
+		};
+
+		/* For child (split) bio to record where its parent is */
+		struct {
+			struct bio *parent;
+			bio_end_io_t *orig_endio;
+		};
+	};
 	/*
 	 * Saved bio::bi_iter before submission.
 	 *
-- 
2.34.1

