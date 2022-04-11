Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B5B4FB383
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Apr 2022 08:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244859AbiDKGPc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Apr 2022 02:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbiDKGPa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Apr 2022 02:15:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F89A38DBE
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Apr 2022 23:13:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E4FCB1F388
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 06:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649657595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ku0SYxiry9Bba7VidXalmzIjdPRgm7mxjRHQePAe434=;
        b=tsDyKprfZ8TIO/kWgohxRP0GMFylvmdkNxU2gvcvhm9HEthUj1qm5UwGDtazdReBhljbFF
        nAjsyQI8Y743VtfgHBB7n42GqdJGSKvRbS+r6NQ3CrrBgnlMZBLZUsvkZLgBkD1Ok6/fck
        h6yg5cC1YuLbXjkjTrFgo4p9ZfH8YjM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45EEC13AB5
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 06:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kKqYBPvGU2LEfwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Apr 2022 06:13:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: make submit_one_bio() to return void
Date:   Mon, 11 Apr 2022 14:12:52 +0800
Message-Id: <e4bb98b5884a77114ef0334dee6677e6e6260ea7.1649657016.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649657016.git.wqu@suse.com>
References: <cover.1649657016.git.wqu@suse.com>
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

Since commit "btrfs: avoid double clean up when submit_one_bio()
failed", submit_one_bio() will never return any error, as if we hit any
error, endio function will be responsible to cleanup the mess.

So here we're completely fine to make submit_one_bio() to return void.

NOTE: not all bio submission hooks should return void.

Hooks for async submission, like btrfs_submit_bio_start_direct_io() or
btrfs_submit_bio_start(), they should still return error, so
run_one_async_done() can detect the error properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 104 +++++++++++++------------------------------
 fs/btrfs/extent_io.h |   3 +-
 fs/btrfs/inode.c     |   9 +---
 3 files changed, 34 insertions(+), 82 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b40bb544d301..186836fad012 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -165,7 +165,7 @@ static int add_extent_changeset(struct extent_state *state, u32 bits,
 	return ret;
 }
 
-int submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_flags)
+void submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_flags)
 {
 	struct extent_io_tree *tree = bio->bi_private;
 
@@ -186,7 +186,6 @@ int submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_flags)
 	 * So here we should not return any error, or the caller of
 	 * submit_extent_page() will do cleanup again, causing problems.
 	 */
-	return 0;
 }
 
 /* Cleanup unsubmitted bios */
@@ -207,13 +206,12 @@ static void end_write_bio(struct extent_page_data *epd, int ret)
  * Return 0 if everything is OK.
  * Return <0 for error.
  */
-static int __must_check flush_write_bio(struct extent_page_data *epd)
+static void flush_write_bio(struct extent_page_data *epd)
 {
-	int ret = 0;
 	struct bio *bio = epd->bio_ctrl.bio;
 
 	if (bio) {
-		ret = submit_one_bio(bio, 0, 0);
+		submit_one_bio(bio, 0, 0);
 		/*
 		 * Clean up of epd->bio is handled by its endio function.
 		 * And endio is either triggered by successful bio execution
@@ -223,7 +221,6 @@ static int __must_check flush_write_bio(struct extent_page_data *epd)
 		 */
 		epd->bio_ctrl.bio = NULL;
 	}
-	return ret;
 }
 
 int __init extent_state_cache_init(void)
@@ -3399,10 +3396,8 @@ static int submit_extent_page(unsigned int opf,
 	ASSERT(pg_offset < PAGE_SIZE && size <= PAGE_SIZE &&
 	       pg_offset + size <= PAGE_SIZE);
 	if (force_bio_submit && bio_ctrl->bio) {
-		ret = submit_one_bio(bio_ctrl->bio, mirror_num, bio_ctrl->bio_flags);
+		submit_one_bio(bio_ctrl->bio, mirror_num, bio_ctrl->bio_flags);
 		bio_ctrl->bio = NULL;
-		if (ret < 0)
-			return ret;
 	}
 
 	while (cur < pg_offset + size) {
@@ -3443,11 +3438,9 @@ static int submit_extent_page(unsigned int opf,
 		if (added < size - offset) {
 			/* The bio should contain some page(s) */
 			ASSERT(bio_ctrl->bio->bi_iter.bi_size);
-			ret = submit_one_bio(bio_ctrl->bio, mirror_num,
-					bio_ctrl->bio_flags);
+			submit_one_bio(bio_ctrl->bio, mirror_num,
+				       bio_ctrl->bio_flags);
 			bio_ctrl->bio = NULL;
-			if (ret < 0)
-				return ret;
 		}
 		cur += added;
 	}
@@ -4209,14 +4202,12 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 			  struct extent_page_data *epd)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int i, num_pages, failed_page_nr;
+	int i, num_pages;
 	int flush = 0;
 	int ret = 0;
 
 	if (!btrfs_try_tree_write_lock(eb)) {
-		ret = flush_write_bio(epd);
-		if (ret < 0)
-			return ret;
+		flush_write_bio(epd);
 		flush = 1;
 		btrfs_tree_lock(eb);
 	}
@@ -4226,9 +4217,7 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 		if (!epd->sync_io)
 			return 0;
 		if (!flush) {
-			ret = flush_write_bio(epd);
-			if (ret < 0)
-				return ret;
+			flush_write_bio(epd);
 			flush = 1;
 		}
 		while (1) {
@@ -4275,39 +4264,13 @@ static noinline_for_stack int lock_extent_buffer_for_io(struct extent_buffer *eb
 
 		if (!trylock_page(p)) {
 			if (!flush) {
-				int err;
-
-				err = flush_write_bio(epd);
-				if (err < 0) {
-					ret = err;
-					failed_page_nr = i;
-					goto err_unlock;
-				}
+				flush_write_bio(epd);
 				flush = 1;
 			}
 			lock_page(p);
 		}
 	}
 
-	return ret;
-err_unlock:
-	/* Unlock already locked pages */
-	for (i = 0; i < failed_page_nr; i++)
-		unlock_page(eb->pages[i]);
-	/*
-	 * Clear EXTENT_BUFFER_WRITEBACK and wake up anyone waiting on it.
-	 * Also set back EXTENT_BUFFER_DIRTY so future attempts to this eb can
-	 * be made and undo everything done before.
-	 */
-	btrfs_tree_lock(eb);
-	spin_lock(&eb->refs_lock);
-	set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
-	end_extent_buffer_writeback(eb);
-	spin_unlock(&eb->refs_lock);
-	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, eb->len,
-				 fs_info->dirty_metadata_batch);
-	btrfs_clear_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
-	btrfs_tree_unlock(eb);
 	return ret;
 }
 
@@ -4929,13 +4892,21 @@ int btree_write_cache_pages(struct address_space *mapping,
 	 *   if the fs already has error.
 	 */
 	if (!BTRFS_FS_ERROR(fs_info)) {
-		ret = flush_write_bio(&epd);
+		flush_write_bio(&epd);
 	} else {
 		ret = -EROFS;
 		end_write_bio(&epd, ret);
 	}
 out:
 	btrfs_zoned_meta_io_unlock(fs_info);
+	/*
+	 * Without the return value from flush_write_bio(), we can have
+	 * ret > 0 from submit_eb_page() which indicates how many
+	 * eb we submitted from that page.
+	 * It's just an advisable value, reset it to 0 to alert callers.
+	 */
+	if (ret > 0)
+		ret = 0;
 	return ret;
 }
 
@@ -5037,8 +5008,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 * tmpfs file mapping
 			 */
 			if (!trylock_page(page)) {
-				ret = flush_write_bio(epd);
-				BUG_ON(ret < 0);
+				flush_write_bio(epd);
 				lock_page(page);
 			}
 
@@ -5048,10 +5018,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			}
 
 			if (wbc->sync_mode != WB_SYNC_NONE) {
-				if (PageWriteback(page)) {
-					ret = flush_write_bio(epd);
-					BUG_ON(ret < 0);
-				}
+				if (PageWriteback(page))
+					flush_write_bio(epd);
 				wait_on_page_writeback(page);
 			}
 
@@ -5091,9 +5059,8 @@ static int extent_write_cache_pages(struct address_space *mapping,
 		 * page in our current bio, and thus deadlock, so flush the
 		 * write bio here.
 		 */
-		ret = flush_write_bio(epd);
-		if (!ret)
-			goto retry;
+		flush_write_bio(epd);
+		goto retry;
 	}
 
 	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
@@ -5119,8 +5086,7 @@ int extent_write_full_page(struct page *page, struct writeback_control *wbc)
 		return ret;
 	}
 
-	ret = flush_write_bio(&epd);
-	ASSERT(ret <= 0);
+	flush_write_bio(&epd);
 	return ret;
 }
 
@@ -5182,7 +5148,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 	}
 
 	if (!found_error)
-		ret = flush_write_bio(&epd);
+		flush_write_bio(&epd);
 	else
 		end_write_bio(&epd, ret);
 
@@ -5215,7 +5181,7 @@ int extent_writepages(struct address_space *mapping,
 		end_write_bio(&epd, ret);
 		return ret;
 	}
-	ret = flush_write_bio(&epd);
+	flush_write_bio(&epd);
 	return ret;
 }
 
@@ -5238,10 +5204,8 @@ void extent_readahead(struct readahead_control *rac)
 	if (em_cached)
 		free_extent_map(em_cached);
 
-	if (bio_ctrl.bio) {
-		if (submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags))
-			return;
-	}
+	if (bio_ctrl.bio)
+		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
 }
 
 /*
@@ -6583,12 +6547,8 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 		atomic_dec(&eb->io_pages);
 	}
 	if (bio_ctrl.bio) {
-		int tmp;
-
-		tmp = submit_one_bio(bio_ctrl.bio, mirror_num, 0);
+		submit_one_bio(bio_ctrl.bio, mirror_num, 0);
 		bio_ctrl.bio = NULL;
-		if (tmp < 0)
-			return tmp;
 	}
 	if (ret || wait != WAIT_COMPLETE)
 		return ret;
@@ -6701,10 +6661,8 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	}
 
 	if (bio_ctrl.bio) {
-		err = submit_one_bio(bio_ctrl.bio, mirror_num, bio_ctrl.bio_flags);
+		submit_one_bio(bio_ctrl.bio, mirror_num, bio_ctrl.bio_flags);
 		bio_ctrl.bio = NULL;
-		if (err)
-			return err;
 	}
 
 	if (ret || wait != WAIT_COMPLETE)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 151e9da5da2d..2cfb49bf003e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -178,8 +178,7 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
 
-int __must_check submit_one_bio(struct bio *bio, int mirror_num,
-				unsigned long bio_flags);
+void submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_flags);
 int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
 		      struct btrfs_bio_ctrl *bio_ctrl,
 		      unsigned int read_flags, u64 *prev_em_start);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 78a5145353e1..43eebb1cf76d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8098,13 +8098,8 @@ int btrfs_readpage(struct file *file, struct page *page)
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
 
 	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
-	if (bio_ctrl.bio) {
-		int ret2;
-
-		ret2 = submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
-		if (ret == 0)
-			ret = ret2;
-	}
+	if (bio_ctrl.bio)
+		submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
 	return ret;
 }
 
-- 
2.35.1

