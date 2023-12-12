Return-Path: <linux-btrfs+bounces-834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E7880E1E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 03:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3441F21C48
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 02:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31405BA39;
	Tue, 12 Dec 2023 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c/zsmkDG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c/zsmkDG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20AA19B
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 18:29:02 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28BAE1FC83
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702348141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dl+DZ0Kuhb7xb0ztQEIChL47c0b+mpLk42yffcD9ygQ=;
	b=c/zsmkDGpVBLaCNKQfGlQwVn7Q8p9YRzfvdb6+QADxaBC6syUNA0cbth5BKrP1qf/alZZD
	beOXVkGBowjpvSD64YSw9IGW4HUEhpVTcOfhSU8Cu2zUshtW3W58c+3Xd6sydryyPseLSI
	H7rL4hkjIZIStCoUoqX9cLOFn3zLbIo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702348141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dl+DZ0Kuhb7xb0ztQEIChL47c0b+mpLk42yffcD9ygQ=;
	b=c/zsmkDGpVBLaCNKQfGlQwVn7Q8p9YRzfvdb6+QADxaBC6syUNA0cbth5BKrP1qf/alZZD
	beOXVkGBowjpvSD64YSw9IGW4HUEhpVTcOfhSU8Cu2zUshtW3W58c+3Xd6sydryyPseLSI
	H7rL4hkjIZIStCoUoqX9cLOFn3zLbIo=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 216DC13463
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IHz8L2vFd2WtHQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:28:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: migrate subpage code to folio interfaces
Date: Tue, 12 Dec 2023 12:58:37 +1030
Message-ID: <3814a2a49f299700e07ff9de6390788d677e337f.1702347666.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702347666.git.wqu@suse.com>
References: <cover.1702347666.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***************
X-Spam-Score: 15.00
X-Spamd-Result: default: False [-2.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_SPF_FAIL(0.00)[-all];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAM_FLAG(5.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 WHITELIST_DMARC(-7.00)[suse.com:D:+];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1
X-Spam-Level: 
X-Rspamd-Queue-Id: 28BAE1FC83
X-Spam-Score: -2.01
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="c/zsmkDG";
	spf=fail (smtp-out2.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com;
	dmarc=pass (policy=quarantine) header.from=suse.com

Although subpage itself is conflicting with higher folio folio, since
subpage (sectorsize < PAGE_SIZE and nodesize < PAGE_SIZE) means we will
never need higher order folio, there is a hidden pitfall:

- btrfs_page_*() helpers

Those helpers are an abstraction to handle both subpage and non-subpage
cases, which means we're going to pass pages pointers to those helpers.

And since those helpers are shared between data and metadata paths, it's
unavoidable to let them to handle folios, including higher order
folios).

Meanwhile for true subpage case, we should only have a single page
backed folios anyway, thus add a new ASSERT() for btrfs_subpage_assert()
to ensure that.

Also since those helpers are shared between both data and metadata, add
some extra ASSERT()s for data path to make sure we only get single page
backed folio for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c      |   7 +-
 fs/btrfs/defrag.c           |   3 +-
 fs/btrfs/disk-io.c          |   2 +-
 fs/btrfs/extent_io.c        |  97 ++++++------
 fs/btrfs/file.c             |  13 +-
 fs/btrfs/free-space-cache.c |   4 +-
 fs/btrfs/inode.c            |  34 ++--
 fs/btrfs/ordered-data.c     |   5 +-
 fs/btrfs/reflink.c          |   6 +-
 fs/btrfs/relocation.c       |   5 +-
 fs/btrfs/subpage.c          | 304 +++++++++++++++++-------------------
 fs/btrfs/subpage.h          |  74 ++++-----
 12 files changed, 279 insertions(+), 275 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f939a640db2b..ba661bc9ee99 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -306,8 +306,8 @@ static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 		for (i = 0; i < ret; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			btrfs_page_clamp_clear_writeback(fs_info, &folio->page,
-							 cb->start, cb->len);
+			btrfs_folio_clamp_clear_writeback(fs_info, folio,
+							  cb->start, cb->len);
 		}
 		folio_batch_release(&fbatch);
 	}
@@ -541,7 +541,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * subpage::readers and to unlock the page.
 		 */
 		if (fs_info->sectorsize < PAGE_SIZE)
-			btrfs_subpage_start_reader(fs_info, page, cur, add_size);
+			btrfs_subpage_start_reader(fs_info, page_folio(page),
+						   cur, add_size);
 		put_page(page);
 		cur += add_size;
 	}
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 9bcb60c68c58..afb0185b4ee2 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1189,7 +1189,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	/* Update the page status */
 	for (i = start_index - first_index; i <= last_index - first_index; i++) {
 		ClearPageChecked(pages[i]);
-		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
+		btrfs_folio_clamp_set_dirty(fs_info, page_folio(pages[i]),
+					    start, len);
 	}
 	btrfs_delalloc_release_extents(inode, len);
 	extent_changeset_free(data_reserved);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 05f797cf3b63..a482ba513a18 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -284,7 +284,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 
 	if (WARN_ON_ONCE(found_start != eb->start))
 		return BLK_STS_IOERR;
-	if (WARN_ON(!btrfs_page_test_uptodate(fs_info, folio_page(eb->folios[0], 0),
+	if (WARN_ON(!btrfs_folio_test_uptodate(fs_info, eb->folios[0],
 					      eb->start, eb->len)))
 		return BLK_STS_IOERR;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 299466602588..ec1b809a06fc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -184,22 +184,23 @@ static void process_one_page(struct btrfs_fs_info *fs_info,
 			     struct page *page, struct page *locked_page,
 			     unsigned long page_ops, u64 start, u64 end)
 {
+	struct folio *folio = page_folio(page);
 	u32 len;
 
 	ASSERT(end + 1 - start != 0 && end + 1 - start < U32_MAX);
 	len = end + 1 - start;
 
 	if (page_ops & PAGE_SET_ORDERED)
-		btrfs_page_clamp_set_ordered(fs_info, page, start, len);
+		btrfs_folio_clamp_set_ordered(fs_info, folio, start, len);
 	if (page_ops & PAGE_START_WRITEBACK) {
-		btrfs_page_clamp_clear_dirty(fs_info, page, start, len);
-		btrfs_page_clamp_set_writeback(fs_info, page, start, len);
+		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
+		btrfs_folio_clamp_set_writeback(fs_info, folio, start, len);
 	}
 	if (page_ops & PAGE_END_WRITEBACK)
-		btrfs_page_clamp_clear_writeback(fs_info, page, start, len);
+		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
 
 	if (page != locked_page && (page_ops & PAGE_UNLOCK))
-		btrfs_page_end_writer_lock(fs_info, page, start, len);
+		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
 }
 
 static void __process_pages_contig(struct address_space *mapping,
@@ -271,18 +272,19 @@ static noinline int lock_delalloc_pages(struct inode *inode,
 			goto out;
 
 		for (i = 0; i < found_folios; i++) {
-			struct page *page = &fbatch.folios[i]->page;
+			struct folio *folio = fbatch.folios[i];
+			struct page *page = folio_page(folio, 0);
 			u32 len = end + 1 - start;
 
 			if (page == locked_page)
 				continue;
 
-			if (btrfs_page_start_writer_lock(fs_info, page, start,
+			if (btrfs_folio_start_writer_lock(fs_info, folio, start,
 							 len))
 				goto out;
 
 			if (!PageDirty(page) || page->mapping != mapping) {
-				btrfs_page_end_writer_lock(fs_info, page, start,
+				btrfs_folio_end_writer_lock(fs_info, folio, start,
 							   len);
 				goto out;
 			}
@@ -432,19 +434,20 @@ static bool btrfs_verify_page(struct page *page, u64 start)
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
+	struct folio *folio = page_folio(page);
 
 	ASSERT(page_offset(page) <= start &&
 	       start + len <= page_offset(page) + PAGE_SIZE);
 
 	if (uptodate && btrfs_verify_page(page, start))
-		btrfs_page_set_uptodate(fs_info, page, start, len);
+		btrfs_folio_set_uptodate(fs_info, folio, start, len);
 	else
-		btrfs_page_clear_uptodate(fs_info, page, start, len);
+		btrfs_folio_clear_uptodate(fs_info, folio, start, len);
 
 	if (!btrfs_is_subpage(fs_info, page->mapping))
 		unlock_page(page);
 	else
-		btrfs_subpage_end_reader(fs_info, page, start, len);
+		btrfs_subpage_end_reader(fs_info, folio, start, len);
 }
 
 /*
@@ -485,7 +488,7 @@ static void end_bio_extent_writepage(struct btrfs_bio *bbio)
 		btrfs_finish_ordered_extent(bbio->ordered, page, start, len, !error);
 		if (error)
 			mapping_set_error(page->mapping, error);
-		btrfs_page_clear_writeback(fs_info, page, start, len);
+		btrfs_folio_clear_writeback(fs_info, page_folio(page), start, len);
 	}
 
 	bio_put(bio);
@@ -564,12 +567,12 @@ static void begin_page_read(struct btrfs_fs_info *fs_info, struct page *page)
 {
 	struct folio *folio = page_folio(page);
 
-	ASSERT(PageLocked(page));
-	if (!btrfs_is_subpage(fs_info, page->mapping))
+	ASSERT(folio_test_locked(folio));
+	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		return;
 
 	ASSERT(folio_test_private(folio));
-	btrfs_subpage_start_reader(fs_info, page, page_offset(page), PAGE_SIZE);
+	btrfs_subpage_start_reader(fs_info, folio, page_offset(page), PAGE_SIZE);
 }
 
 /*
@@ -921,7 +924,7 @@ static int attach_extent_buffer_folio(struct extent_buffer *eb,
 		folio_attach_private(folio, prealloc);
 	else
 		/* Do new allocation to attach subpage */
-		ret = btrfs_attach_subpage(fs_info, folio_page(folio, 0),
+		ret = btrfs_attach_subpage(fs_info, folio,
 					   BTRFS_SUBPAGE_METADATA);
 	return ret;
 }
@@ -939,7 +942,7 @@ int set_page_extent_mapped(struct page *page)
 	fs_info = btrfs_sb(page->mapping->host->i_sb);
 
 	if (btrfs_is_subpage(fs_info, page->mapping))
-		return btrfs_attach_subpage(fs_info, page, BTRFS_SUBPAGE_DATA);
+		return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 
 	folio_attach_private(folio, (void *)EXTENT_FOLIO_PRIVATE);
 	return 0;
@@ -957,7 +960,7 @@ void clear_page_extent_mapped(struct page *page)
 
 	fs_info = btrfs_sb(page->mapping->host->i_sb);
 	if (btrfs_is_subpage(fs_info, page->mapping))
-		return btrfs_detach_subpage(fs_info, page);
+		return btrfs_detach_subpage(fs_info, folio);
 
 	folio_detach_private(folio);
 }
@@ -1353,7 +1356,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			 * writeback the sectors with subpage dirty bits,
 			 * causing writeback without ordered extent.
 			 */
-			btrfs_page_clear_dirty(fs_info, page, cur, len);
+			btrfs_folio_clear_dirty(fs_info, page_folio(page), cur, len);
 			break;
 		}
 
@@ -1405,7 +1408,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		 * So clear subpage dirty bit here so next time we won't submit
 		 * page for range already written to disk.
 		 */
-		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
+		btrfs_folio_clear_dirty(fs_info, page_folio(page), cur, iosize);
 
 		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
 				   cur - page_offset(page));
@@ -1413,7 +1416,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		nr++;
 	}
 
-	btrfs_page_assert_not_dirty(fs_info, page);
+	btrfs_folio_assert_not_dirty(fs_info, page_folio(page));
 	*nr_ret = nr;
 	return 0;
 
@@ -1652,7 +1655,7 @@ static void extent_buffer_write_end_io(struct btrfs_bio *bbio)
 		struct page *page = bvec->bv_page;
 		u32 len = bvec->bv_len;
 
-		btrfs_page_clear_writeback(fs_info, page, start, len);
+		btrfs_folio_clear_writeback(fs_info, page_folio(page), start, len);
 		bio_offset += len;
 	}
 
@@ -1708,18 +1711,21 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
 	if (fs_info->nodesize < PAGE_SIZE) {
-		struct page *p = folio_page(eb->folios[0], 0);
+		struct folio *folio = eb->folios[0];
+		bool ret;
 
-		lock_page(p);
-		btrfs_subpage_set_writeback(fs_info, p, eb->start, eb->len);
-		if (btrfs_subpage_clear_and_test_dirty(fs_info, p, eb->start,
+		folio_lock(folio);
+		btrfs_subpage_set_writeback(fs_info, folio, eb->start, eb->len);
+		if (btrfs_subpage_clear_and_test_dirty(fs_info, folio, eb->start,
 						       eb->len)) {
-			clear_page_dirty_for_io(p);
+			folio_clear_dirty_for_io(folio);
 			wbc->nr_to_write--;
 		}
-		__bio_add_page(&bbio->bio, p, eb->len, eb->start - page_offset(p));
-		wbc_account_cgroup_owner(wbc, p, eb->len);
-		unlock_page(p);
+		ret = bio_add_folio(&bbio->bio, folio, eb->len,
+				    eb->start - folio_pos(folio));
+		ASSERT(ret);
+		wbc_account_cgroup_owner(wbc, folio_page(folio, 0), eb->len);
+		folio_unlock(folio);
 	} else {
 		int num_folios = num_extent_folios(eb);
 
@@ -2236,7 +2242,7 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 						       cur, cur_len, !ret);
 			mapping_set_error(page->mapping, ret);
 		}
-		btrfs_page_unlock_writer(fs_info, page, cur, cur_len);
+		btrfs_folio_unlock_writer(fs_info, page_folio(page), cur, cur_len);
 		if (ret < 0)
 			found_error = true;
 next_page:
@@ -3157,7 +3163,7 @@ static void detach_extent_buffer_folio(struct extent_buffer *eb,
 	 * attached to one dummy eb, no sharing.
 	 */
 	if (!mapped) {
-		btrfs_detach_subpage(fs_info, folio_page(folio, 0));
+		btrfs_detach_subpage(fs_info, folio);
 		return;
 	}
 
@@ -3168,7 +3174,7 @@ static void detach_extent_buffer_folio(struct extent_buffer *eb,
 	 * page range and no unfinished IO.
 	 */
 	if (!folio_range_has_eb(fs_info, folio))
-		btrfs_detach_subpage(fs_info, folio_page(folio, 0));
+		btrfs_detach_subpage(fs_info, folio);
 
 	spin_unlock(&folio->mapping->private_lock);
 }
@@ -3699,8 +3705,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		btrfs_folio_inc_eb_refs(fs_info, folio);
 		spin_unlock(&mapping->private_lock);
 
-		WARN_ON(btrfs_page_test_dirty(fs_info, folio_page(folio, 0),
-					      eb->start, eb->len));
+		WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->start, eb->len));
 
 		/*
 		 * Check if the current page is physically contiguous with previous eb
@@ -3711,8 +3716,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		if (i && folio_page(eb->folios[i - 1], 0) + 1 != folio_page(folio, 0))
 			page_contig = false;
 
-		if (!btrfs_page_test_uptodate(fs_info, folio_page(folio, 0),
-					      eb->start, eb->len))
+		if (!btrfs_folio_test_uptodate(fs_info, folio, eb->start, eb->len))
 			uptodate = 0;
 
 		/*
@@ -3887,7 +3891,7 @@ static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
 
 	/* btree_clear_folio_dirty() needs page locked */
 	folio_lock(folio);
-	last = btrfs_subpage_clear_and_test_dirty(fs_info, folio_page(folio, 0),
+	last = btrfs_subpage_clear_and_test_dirty(fs_info, folio,
 			eb->start, eb->len);
 	if (last)
 		btree_clear_folio_dirty(folio);
@@ -3974,7 +3978,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 		if (subpage)
 			lock_page(folio_page(eb->folios[0], 0));
 		for (i = 0; i < num_folios; i++)
-			btrfs_page_set_dirty(eb->fs_info, folio_page(eb->folios[i], 0),
+			btrfs_folio_set_dirty(eb->fs_info, eb->folios[i],
 					     eb->start, eb->len);
 		if (subpage)
 			unlock_page(folio_page(eb->folios[0], 0));
@@ -4009,7 +4013,7 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 		if (fs_info->nodesize >= PAGE_SIZE)
 			folio_clear_uptodate(folio);
 		else
-			btrfs_subpage_clear_uptodate(fs_info, folio_page(folio, 0),
+			btrfs_subpage_clear_uptodate(fs_info, folio,
 						     eb->start, eb->len);
 	}
 }
@@ -4032,7 +4036,7 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 		if (fs_info->nodesize >= PAGE_SIZE)
 			folio_mark_uptodate(folio);
 		else
-			btrfs_subpage_set_uptodate(fs_info, folio_page(folio, 0),
+			btrfs_subpage_set_uptodate(fs_info, folio,
 						   eb->start, eb->len);
 	}
 }
@@ -4065,9 +4069,9 @@ static void extent_buffer_read_end_io(struct btrfs_bio *bbio)
 		u32 len = bvec->bv_len;
 
 		if (uptodate)
-			btrfs_page_set_uptodate(fs_info, page, start, len);
+			btrfs_folio_set_uptodate(fs_info, page_folio(page), start, len);
 		else
-			btrfs_page_clear_uptodate(fs_info, page, start, len);
+			btrfs_folio_clear_uptodate(fs_info, page_folio(page), start, len);
 
 		bio_offset += len;
 	}
@@ -4309,11 +4313,12 @@ static void assert_eb_folio_uptodate(const struct extent_buffer *eb, int i)
 		return;
 
 	if (fs_info->nodesize < PAGE_SIZE) {
-		struct page *page = folio_page(folio, 0);
+		struct folio *folio = eb->folios[0];
 
-		if (WARN_ON(!btrfs_subpage_test_uptodate(fs_info, page,
+		ASSERT(i == 0);
+		if (WARN_ON(!btrfs_subpage_test_uptodate(fs_info, folio,
 							 eb->start, eb->len)))
-			btrfs_subpage_dump_bitmap(fs_info, page, eb->start, eb->len);
+			btrfs_subpage_dump_bitmap(fs_info, folio, eb->start, eb->len);
 	} else {
 		WARN_ON(!folio_test_uptodate(folio));
 	}
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e9c4b947a5aa..729e9139c08a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -111,8 +111,8 @@ static void btrfs_drop_pages(struct btrfs_fs_info *fs_info,
 		 * accessed as prepare_pages should have marked them accessed
 		 * in prepare_pages via find_or_create_page()
 		 */
-		btrfs_page_clamp_clear_checked(fs_info, pages[i], block_start,
-					       block_len);
+		btrfs_folio_clamp_clear_checked(fs_info, page_folio(pages[i]),
+						block_start, block_len);
 		unlock_page(pages[i]);
 		put_page(pages[i]);
 	}
@@ -168,9 +168,12 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = pages[i];
 
-		btrfs_page_clamp_set_uptodate(fs_info, p, start_pos, num_bytes);
-		btrfs_page_clamp_clear_checked(fs_info, p, start_pos, num_bytes);
-		btrfs_page_clamp_set_dirty(fs_info, p, start_pos, num_bytes);
+		btrfs_folio_clamp_set_uptodate(fs_info, page_folio(p),
+					       start_pos, num_bytes);
+		btrfs_folio_clamp_clear_checked(fs_info, page_folio(p),
+						start_pos, num_bytes);
+		btrfs_folio_clamp_set_dirty(fs_info, page_folio(p),
+					    start_pos, num_bytes);
 	}
 
 	/*
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6f93c9a2c3e3..d372c7ce0e6b 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -439,8 +439,8 @@ static void io_ctl_drop_pages(struct btrfs_io_ctl *io_ctl)
 
 	for (i = 0; i < io_ctl->num_pages; i++) {
 		if (io_ctl->pages[i]) {
-			btrfs_page_clear_checked(io_ctl->fs_info,
-					io_ctl->pages[i],
+			btrfs_folio_clear_checked(io_ctl->fs_info,
+					page_folio(io_ctl->pages[i]),
 					page_offset(io_ctl->pages[i]),
 					PAGE_SIZE);
 			unlock_page(io_ctl->pages[i]);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9ede6aa77fde..4c50b6c63fa6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -456,8 +456,8 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		 * range, then btrfs_mark_ordered_io_finished() will handle
 		 * the ordered extent accounting for the range.
 		 */
-		btrfs_page_clamp_clear_ordered(inode->root->fs_info, page,
-					       offset, bytes);
+		btrfs_folio_clamp_clear_ordered(inode->root->fs_info,
+						page_folio(page), offset, bytes);
 		put_page(page);
 	}
 
@@ -2802,7 +2802,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 					       PAGE_SIZE, !ret);
 		clear_page_dirty_for_io(page);
 	}
-	btrfs_page_clear_checked(fs_info, page, page_start, PAGE_SIZE);
+	btrfs_folio_clear_checked(fs_info, page_folio(page), page_start, PAGE_SIZE);
 	unlock_page(page);
 	put_page(page);
 	kfree(fixup);
@@ -2857,7 +2857,7 @@ int btrfs_writepage_cow_fixup(struct page *page)
 	 * page->mapping outside of the page lock.
 	 */
 	ihold(inode);
-	btrfs_page_set_checked(fs_info, page, page_offset(page), PAGE_SIZE);
+	btrfs_folio_set_checked(fs_info, page_folio(page), page_offset(page), PAGE_SIZE);
 	get_page(page);
 	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL);
 	fixup->page = page;
@@ -4776,9 +4776,10 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 			memzero_page(page, (block_start - page_offset(page)) + offset,
 				     len);
 	}
-	btrfs_page_clear_checked(fs_info, page, block_start,
-				 block_end + 1 - block_start);
-	btrfs_page_set_dirty(fs_info, page, block_start, block_end + 1 - block_start);
+	btrfs_folio_clear_checked(fs_info, page_folio(page), block_start,
+				  block_end + 1 - block_start);
+	btrfs_folio_set_dirty(fs_info, page_folio(page), block_start,
+			      block_end + 1 - block_start);
 	unlock_extent(io_tree, block_start, block_end, &cached_state);
 
 	if (only_release_metadata)
@@ -8005,7 +8006,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 				page_end);
 		ASSERT(range_end + 1 - cur < U32_MAX);
 		range_len = range_end + 1 - cur;
-		if (!btrfs_page_test_ordered(fs_info, &folio->page, cur, range_len)) {
+		if (!btrfs_folio_test_ordered(fs_info, folio, cur, range_len)) {
 			/*
 			 * If Ordered (Private2) is cleared, it means endio has
 			 * already been executed for the range.
@@ -8014,7 +8015,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 			 */
 			goto next;
 		}
-		btrfs_page_clear_ordered(fs_info, &folio->page, cur, range_len);
+		btrfs_folio_clear_ordered(fs_info, folio, cur, range_len);
 
 		/*
 		 * IO on this page will never be started, so we need to account
@@ -8084,7 +8085,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	 * did something wrong.
 	 */
 	ASSERT(!folio_test_ordered(folio));
-	btrfs_page_clear_checked(fs_info, &folio->page, folio_pos(folio), folio_size(folio));
+	btrfs_folio_clear_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
 	if (!inode_evicting)
 		__btrfs_release_folio(folio, GFP_NOFS);
 	clear_page_extent_mapped(&folio->page);
@@ -8108,6 +8109,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
+	struct folio *folio = page_folio(page);
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
@@ -8124,6 +8126,8 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	u64 page_end;
 	u64 end;
 
+	ASSERT(folio_order(folio) == 0);
+
 	reserved_space = PAGE_SIZE;
 
 	sb_start_pagefault(inode->i_sb);
@@ -8227,9 +8231,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	if (zero_start != PAGE_SIZE)
 		memzero_page(page, zero_start, PAGE_SIZE - zero_start);
 
-	btrfs_page_clear_checked(fs_info, page, page_start, PAGE_SIZE);
-	btrfs_page_set_dirty(fs_info, page, page_start, end + 1 - page_start);
-	btrfs_page_set_uptodate(fs_info, page, page_start, end + 1 - page_start);
+	btrfs_folio_clear_checked(fs_info, folio, page_start, PAGE_SIZE);
+	btrfs_folio_set_dirty(fs_info, folio, page_start, end + 1 - page_start);
+	btrfs_folio_set_uptodate(fs_info, folio, page_start, end + 1 - page_start);
 
 	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
 
@@ -9800,7 +9804,9 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
 		page = find_get_page(inode->vfs_inode.i_mapping, index);
 		ASSERT(page); /* Pages should be in the extent_io_tree */
 
-		btrfs_page_set_writeback(fs_info, page, start, len);
+		/* This is for data, which doesn't yet support larger folio. */
+		ASSERT(folio_order(page_folio(page)) == 0);
+		btrfs_folio_set_writeback(fs_info, page_folio(page), start, len);
 		put_page(page);
 		index++;
 	}
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 574e8a55e24a..ffa7ad9d7361 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -322,9 +322,10 @@ static bool can_finish_ordered_extent(struct btrfs_ordered_extent *ordered,
 		 *
 		 * If there's no such bit, we need to skip to next range.
 		 */
-		if (!btrfs_page_test_ordered(fs_info, page, file_offset, len))
+		if (!btrfs_folio_test_ordered(fs_info, page_folio(page),
+					      file_offset, len))
 			return false;
-		btrfs_page_clear_ordered(fs_info, page, file_offset, len);
+		btrfs_folio_clear_ordered(fs_info, page_folio(page), file_offset, len);
 	}
 
 	/* Now we're fine to update the accounting. */
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f88b0c2ac3fe..ae90894dc7dc 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -141,9 +141,9 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	if (datal < block_size)
 		memzero_page(page, datal, block_size - datal);
 
-	btrfs_page_set_uptodate(fs_info, page, file_offset, block_size);
-	btrfs_page_clear_checked(fs_info, page, file_offset, block_size);
-	btrfs_page_set_dirty(fs_info, page, file_offset, block_size);
+	btrfs_folio_set_uptodate(fs_info, page_folio(page), file_offset, block_size);
+	btrfs_folio_clear_checked(fs_info, page_folio(page), file_offset, block_size);
+	btrfs_folio_set_dirty(fs_info, page_folio(page), file_offset, block_size);
 out_unlock:
 	if (page) {
 		unlock_page(page);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f5d9e5f74a52..3c009d670881 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2895,7 +2895,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 		 * will re-read the whole page anyway.
 		 */
 		if (page) {
-			btrfs_subpage_clear_uptodate(fs_info, page, i_size,
+			btrfs_subpage_clear_uptodate(fs_info, page_folio(page), i_size,
 					round_up(i_size, PAGE_SIZE) - i_size);
 			unlock_page(page);
 			put_page(page);
@@ -3070,7 +3070,8 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 						       clamped_len);
 			goto release_page;
 		}
-		btrfs_page_set_dirty(fs_info, page, clamped_start, clamped_len);
+		btrfs_folio_set_dirty(fs_info, page_folio(page),
+				      clamped_start, clamped_len);
 
 		/*
 		 * Set the boundary if it's inside the page.
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 7fd7671be458..9c31ba7e88c3 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -116,20 +116,19 @@ void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sector
 }
 
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
-			 struct page *page, enum btrfs_subpage_type type)
+			 struct folio *folio, enum btrfs_subpage_type type)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage;
 
 	/*
 	 * We have cases like a dummy extent buffer page, which is not mapped
 	 * and doesn't need to be locked.
 	 */
-	if (page->mapping)
-		ASSERT(PageLocked(page));
+	if (folio->mapping)
+		ASSERT(folio_test_locked(folio));
 
 	/* Either not subpage, or the folio already has private attached. */
-	if (!btrfs_is_subpage(fs_info, page->mapping) ||
+	if (!btrfs_is_subpage(fs_info, folio->mapping) ||
 	    folio_test_private(folio))
 		return 0;
 
@@ -142,13 +141,12 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 }
 
 void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
-			  struct page *page)
+			  struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage;
 
 	/* Either not subpage, or the folio already has private attached. */
-	if (!btrfs_is_subpage(fs_info, page->mapping) ||
+	if (!btrfs_is_subpage(fs_info, folio->mapping) ||
 	    !folio_test_private(folio))
 		return;
 
@@ -227,9 +225,10 @@ void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info,
 }
 
 static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
+	/* For subpage support, the folio must be single paged. */
+	ASSERT(folio_order(folio) == 0);
 
 	/* Basic checks */
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
@@ -239,34 +238,32 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 	 * The range check only works for mapped page, we can still have
 	 * unmapped page like dummy extent buffer pages.
 	 */
-	if (page->mapping)
-		ASSERT(page_offset(page) <= start &&
-		       start + len <= page_offset(page) + PAGE_SIZE);
+	if (folio->mapping)
+		ASSERT(folio_pos(folio) <= start &&
+		       start + len <= folio_pos(folio) + PAGE_SIZE);
 }
 
 void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int nbits = len >> fs_info->sectorsize_bits;
 
-	btrfs_subpage_assert(fs_info, page, start, len);
+	btrfs_subpage_assert(fs_info, folio, start, len);
 
 	atomic_add(nbits, &subpage->readers);
 }
 
 void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int nbits = len >> fs_info->sectorsize_bits;
 	bool is_data;
 	bool last;
 
-	btrfs_subpage_assert(fs_info, page, start, len);
-	is_data = is_data_inode(page->mapping->host);
+	btrfs_subpage_assert(fs_info, folio, start, len);
+	is_data = is_data_inode(folio->mapping->host);
 	ASSERT(atomic_read(&subpage->readers) >= nbits);
 	last = atomic_sub_and_test(nbits, &subpage->readers);
 
@@ -278,36 +275,35 @@ void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
 	 * As we want the atomic_sub_and_test() to be always executed.
 	 */
 	if (is_data && last)
-		unlock_page(page);
+		folio_unlock(folio);
 }
 
-static void btrfs_subpage_clamp_range(struct page *page, u64 *start, u32 *len)
+static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 {
 	u64 orig_start = *start;
 	u32 orig_len = *len;
 
-	*start = max_t(u64, page_offset(page), orig_start);
+	*start = max_t(u64, folio_pos(folio), orig_start);
 	/*
 	 * For certain call sites like btrfs_drop_pages(), we may have pages
 	 * beyond the target range. In that case, just set @len to 0, subpage
 	 * helpers can handle @len == 0 without any problem.
 	 */
-	if (page_offset(page) >= orig_start + orig_len)
+	if (folio_pos(folio) >= orig_start + orig_len)
 		*len = 0;
 	else
-		*len = min_t(u64, page_offset(page) + PAGE_SIZE,
+		*len = min_t(u64, folio_pos(folio) + PAGE_SIZE,
 			     orig_start + orig_len) - *start;
 }
 
 void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int nbits = (len >> fs_info->sectorsize_bits);
 	int ret;
 
-	btrfs_subpage_assert(fs_info, page, start, len);
+	btrfs_subpage_assert(fs_info, folio, start, len);
 
 	ASSERT(atomic_read(&subpage->readers) == 0);
 	ret = atomic_add_return(nbits, &subpage->writers);
@@ -315,13 +311,12 @@ void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
 }
 
 bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int nbits = (len >> fs_info->sectorsize_bits);
 
-	btrfs_subpage_assert(fs_info, page, start, len);
+	btrfs_subpage_assert(fs_info, folio, start, len);
 
 	/*
 	 * We have call sites passing @lock_page into
@@ -338,7 +333,7 @@ bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
 }
 
 /*
- * Lock a page for delalloc page writeback.
+ * Lock a folio for delalloc page writeback.
  *
  * Return -EAGAIN if the page is not properly initialized.
  * Return 0 with the page locked, and writer counter updated.
@@ -347,40 +342,40 @@ bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
  * it's really the correct page, as the caller is using
  * filemap_get_folios_contig(), which can race with page invalidating.
  */
-int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
-
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page->mapping)) {
-		lock_page(page);
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) {
+		folio_lock(folio);
 		return 0;
 	}
-	lock_page(page);
+	folio_lock(folio);
 	if (!folio_test_private(folio) || !folio_get_private(folio)) {
-		unlock_page(page);
+		folio_unlock(folio);
 		return -EAGAIN;
 	}
-	btrfs_subpage_clamp_range(page, &start, &len);
-	btrfs_subpage_start_writer(fs_info, page, start, len);
+	btrfs_subpage_clamp_range(folio, &start, &len);
+	btrfs_subpage_start_writer(fs_info, folio, start, len);
 	return 0;
 }
 
-void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
+		struct folio *folio, u64 start, u32 len)
 {
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, page->mapping))
-		return unlock_page(page);
-	btrfs_subpage_clamp_range(page, &start, &len);
-	if (btrfs_subpage_end_and_test_writer(fs_info, page, start, len))
-		unlock_page(page);
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) {
+		folio_unlock(folio);
+		return;
+	}
+	btrfs_subpage_clamp_range(folio, &start, &len);
+	if (btrfs_subpage_end_and_test_writer(fs_info, folio, start, len))
+		folio_unlock(folio);
 }
 
-#define subpage_calc_start_bit(fs_info, page, name, start, len)		\
+#define subpage_calc_start_bit(fs_info, folio, name, start, len)	\
 ({									\
 	unsigned int start_bit;						\
 									\
-	btrfs_subpage_assert(fs_info, page, start, len);		\
+	btrfs_subpage_assert(fs_info, folio, start, len);		\
 	start_bit = offset_in_page(start) >> fs_info->sectorsize_bits;	\
 	start_bit += fs_info->subpage_info->name##_offset;		\
 	start_bit;							\
@@ -397,49 +392,46 @@ void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
 			fs_info->subpage_info->bitmap_nr_bits)
 
 void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							uptodate, start, len);
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_set(fs_info, subpage, uptodate))
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							uptodate, start, len);
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	ClearPageUptodate(page);
+	folio_clear_uptodate(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							dirty, start, len);
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	spin_unlock_irqrestore(&subpage->lock, flags);
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 }
 
 /*
@@ -453,11 +445,10 @@ void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
  * extra handling for tree blocks.
  */
 bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							dirty, start, len);
 	unsigned long flags;
 	bool last = false;
@@ -471,107 +462,101 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 }
 
 void btrfs_subpage_clear_dirty(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
 	bool last;
 
-	last = btrfs_subpage_clear_and_test_dirty(fs_info, page, start, len);
+	last = btrfs_subpage_clear_and_test_dirty(fs_info, folio, start, len);
 	if (last)
-		clear_page_dirty_for_io(page);
+		folio_clear_dirty_for_io(folio);
 }
 
 void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							writeback, start, len);
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							writeback, start, len);
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, subpage, writeback)) {
-		ASSERT(PageWriteback(page));
-		end_page_writeback(page);
+		ASSERT(folio_test_writeback(folio));
+		folio_end_writeback(folio);
 	}
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							ordered, start, len);
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	SetPageOrdered(page);
+	folio_set_ordered(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len)
+		struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							ordered, start, len);
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, subpage, ordered))
-		ClearPageOrdered(page);
+		folio_clear_ordered(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
-			       struct page *page, u64 start, u32 len)
+			       struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							checked, start, len);
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_set(fs_info, subpage, checked))
-		SetPageChecked(page);
+		folio_set_checked(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
-				 struct page *page, u64 start, u32 len)
+				 struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							checked, start, len);
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	ClearPageChecked(page);
+	folio_clear_checked(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
@@ -581,11 +566,10 @@ void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
  */
 #define IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(name)				\
 bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len)			\
+		struct folio *folio, u64 start, u32 len)		\
 {									\
-	struct folio *folio = page_folio(page);				\
 	struct btrfs_subpage *subpage = folio_get_private(folio);	\
-	unsigned int start_bit = subpage_calc_start_bit(fs_info, page,	\
+	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,	\
 						name, start, len);	\
 	unsigned long flags;						\
 	bool ret;							\
@@ -607,92 +591,92 @@ IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(checked);
  * in.  We only test sectorsize == PAGE_SIZE cases so far, thus we can fall
  * back to regular sectorsize branch.
  */
-#define IMPLEMENT_BTRFS_PAGE_OPS(name, set_page_func, clear_page_func,	\
-			       test_page_func)				\
-void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
-		struct page *page, u64 start, u32 len)			\
+#define IMPLEMENT_BTRFS_PAGE_OPS(name, folio_set_func,			\
+				 folio_clear_func, folio_test_func)	\
+void btrfs_folio_set_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len)		\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, page->mapping)) {		\
-		set_page_func(page);					\
+	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+		folio_set_func(folio);					\
 		return;							\
 	}								\
-	btrfs_subpage_set_##name(fs_info, page, start, len);		\
+	btrfs_subpage_set_##name(fs_info, folio, start, len);		\
 }									\
-void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len)			\
+void btrfs_folio_clear_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len)		\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, page->mapping)) {		\
-		clear_page_func(page);					\
+	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+		folio_clear_func(folio);				\
 		return;							\
 	}								\
-	btrfs_subpage_clear_##name(fs_info, page, start, len);		\
+	btrfs_subpage_clear_##name(fs_info, folio, start, len);		\
 }									\
-bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len)			\
+bool btrfs_folio_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len)		\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, page->mapping))			\
-		return test_page_func(page);				\
-	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
+	    !btrfs_is_subpage(fs_info, folio->mapping))			\
+		return folio_test_func(folio);				\
+	return btrfs_subpage_test_##name(fs_info, folio, start, len);	\
 }									\
-void btrfs_page_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len)			\
+void btrfs_folio_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len)		\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, page->mapping)) {	\
-		set_page_func(page);					\
+	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+		folio_set_func(folio);					\
 		return;							\
 	}								\
-	btrfs_subpage_clamp_range(page, &start, &len);			\
-	btrfs_subpage_set_##name(fs_info, page, start, len);		\
+	btrfs_subpage_clamp_range(folio, &start, &len);			\
+	btrfs_subpage_set_##name(fs_info, folio, start, len);		\
 }									\
-void btrfs_page_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
-		struct page *page, u64 start, u32 len)			\
+void btrfs_folio_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
+		struct folio *folio, u64 start, u32 len)		\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, page->mapping)) {		\
-		clear_page_func(page);					\
+	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+		folio_clear_func(folio);				\
 		return;							\
 	}								\
-	btrfs_subpage_clamp_range(page, &start, &len);			\
-	btrfs_subpage_clear_##name(fs_info, page, start, len);		\
+	btrfs_subpage_clamp_range(folio, &start, &len);			\
+	btrfs_subpage_clear_##name(fs_info, folio, start, len);		\
 }									\
-bool btrfs_page_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len)			\
+bool btrfs_folio_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len)		\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, page->mapping)) \
-		return test_page_func(page);				\
-	btrfs_subpage_clamp_range(page, &start, &len);			\
-	return btrfs_subpage_test_##name(fs_info, page, start, len);	\
+	    !btrfs_is_subpage(fs_info, folio->mapping))			\
+		return folio_test_func(folio);				\
+	btrfs_subpage_clamp_range(folio, &start, &len);			\
+	return btrfs_subpage_test_##name(fs_info, folio, start, len);	\
 }
-IMPLEMENT_BTRFS_PAGE_OPS(uptodate, SetPageUptodate, ClearPageUptodate,
-			 PageUptodate);
-IMPLEMENT_BTRFS_PAGE_OPS(dirty, set_page_dirty, clear_page_dirty_for_io,
-			 PageDirty);
-IMPLEMENT_BTRFS_PAGE_OPS(writeback, set_page_writeback, end_page_writeback,
-			 PageWriteback);
-IMPLEMENT_BTRFS_PAGE_OPS(ordered, SetPageOrdered, ClearPageOrdered,
-			 PageOrdered);
-IMPLEMENT_BTRFS_PAGE_OPS(checked, SetPageChecked, ClearPageChecked, PageChecked);
+IMPLEMENT_BTRFS_PAGE_OPS(uptodate, folio_mark_uptodate, folio_clear_uptodate,
+			 folio_test_uptodate);
+IMPLEMENT_BTRFS_PAGE_OPS(dirty, folio_mark_dirty, folio_clear_dirty_for_io,
+			 folio_test_dirty);
+IMPLEMENT_BTRFS_PAGE_OPS(writeback, folio_start_writeback, folio_end_writeback,
+			 folio_test_writeback);
+IMPLEMENT_BTRFS_PAGE_OPS(ordered, folio_set_ordered, folio_clear_ordered,
+			 folio_test_ordered);
+IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
+			 folio_test_checked);
 
 /*
  * Make sure not only the page dirty bit is cleared, but also subpage dirty bit
  * is cleared.
  */
-void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
-				 struct page *page)
+void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
+				  struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 
 	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
 		return;
 
-	ASSERT(!PageDirty(page));
-	if (!btrfs_is_subpage(fs_info, page->mapping))
+	ASSERT(!folio_test_dirty(folio));
+	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		return;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
@@ -714,16 +698,17 @@ void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
  *   extent_write_locked_range().
  *   In this case, we have to call subpage helper to handle the case.
  */
-void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
-			      u64 start, u32 len)
+void btrfs_folio_unlock_writer(struct btrfs_fs_info *fs_info,
+			       struct folio *folio, u64 start, u32 len)
 {
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage;
 
-	ASSERT(PageLocked(page));
+	ASSERT(folio_test_locked(folio));
 	/* For non-subpage case, we just unlock the page */
-	if (!btrfs_is_subpage(fs_info, page->mapping))
-		return unlock_page(page);
+	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
+		folio_unlock(folio);
+		return;
+	}
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
 	subpage = folio_get_private(folio);
@@ -735,12 +720,14 @@ void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
 	 * Since we own the page lock, no one else could touch subpage::writers
 	 * and we are safe to do several atomic operations without spinlock.
 	 */
-	if (atomic_read(&subpage->writers) == 0)
+	if (atomic_read(&subpage->writers) == 0) {
 		/* No writers, locked by plain lock_page() */
-		return unlock_page(page);
+		folio_unlock(folio);
+		return;
+	}
 
 	/* Have writers, use proper subpage helper to end it */
-	btrfs_page_end_writer_lock(fs_info, page, start, len);
+	btrfs_folio_end_writer_lock(fs_info, folio, start, len);
 }
 
 #define GET_SUBPAGE_BITMAP(subpage, subpage_info, name, dst)		\
@@ -748,10 +735,9 @@ void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
 		   subpage_info->name##_offset, subpage_info->bitmap_nr_bits)
 
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
-				      struct page *page, u64 start, u32 len)
+				      struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage_info *subpage_info = fs_info->subpage_info;
-	struct folio *folio = page_folio(page);
 	struct btrfs_subpage *subpage;
 	unsigned long uptodate_bitmap;
 	unsigned long error_bitmap;
@@ -773,10 +759,10 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	GET_SUBPAGE_BITMAP(subpage, subpage_info, checked, &checked_bitmap);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 
-	dump_page(page, "btrfs subpage dump");
+	dump_page(folio_page(folio, 0), "btrfs subpage dump");
 	btrfs_warn(fs_info,
 "start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl error=%*pbl dirty=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
-		    start, len, page_offset(page),
+		    start, len, folio_pos(folio),
 		    subpage_info->bitmap_nr_bits, &uptodate_bitmap,
 		    subpage_info->bitmap_nr_bits, &error_bitmap,
 		    subpage_info->bitmap_nr_bits, &dirty_bitmap,
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 93d1c5690faf..ce90aea7e457 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -78,9 +78,9 @@ bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
 
 void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sectorsize);
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
-			 struct page *page, enum btrfs_subpage_type type);
+			 struct folio *folio, enum btrfs_subpage_type type);
 void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
-			  struct page *page);
+			  struct folio *folio);
 
 /* Allocate additional data where page represents more than one sector */
 struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
@@ -93,52 +93,52 @@ void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info,
 			     struct folio *folio);
 
 void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len);
+		struct folio *folio, u64 start, u32 len);
 void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len);
+		struct folio *folio, u64 start, u32 len);
 
 void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len);
+		struct folio *folio, u64 start, u32 len);
 bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len);
-int btrfs_page_start_writer_lock(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len);
-void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len);
+		struct folio *folio, u64 start, u32 len);
+int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
+		struct folio *folio, u64 start, u32 len);
+void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
+		struct folio *folio, u64 start, u32 len);
 
 /*
  * Template for subpage related operations.
  *
- * btrfs_subpage_*() are for call sites where the page has subpage attached and
- * the range is ensured to be inside the page.
+ * btrfs_subpage_*() are for call sites where the folio has subpage attached and
+ * the range is ensured to be inside the folio's single page.
  *
- * btrfs_page_*() are for call sites where the page can either be subpage
- * specific or regular page. The function will handle both cases.
- * But the range still needs to be inside the page.
+ * btrfs_folio_*() are for call sites where the page can either be subpage
+ * specific or regular folios. The function will handle both cases.
+ * But the range still needs to be inside one single page.
  *
- * btrfs_page_clamp_*() are similar to btrfs_page_*(), except the range doesn't
+ * btrfs_folio_clamp_*() are similar to btrfs_folio_*(), except the range doesn't
  * need to be inside the page. Those functions will truncate the range
  * automatically.
  */
 #define DECLARE_BTRFS_SUBPAGE_OPS(name)					\
 void btrfs_subpage_set_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len);			\
+		struct folio *folio, u64 start, u32 len);			\
 void btrfs_subpage_clear_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len);			\
+		struct folio *folio, u64 start, u32 len);			\
 bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len);			\
-void btrfs_page_set_##name(const struct btrfs_fs_info *fs_info,		\
-		struct page *page, u64 start, u32 len);			\
-void btrfs_page_clear_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len);			\
-bool btrfs_page_test_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len);			\
-void btrfs_page_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len);			\
-void btrfs_page_clamp_clear_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len);			\
-bool btrfs_page_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
-		struct page *page, u64 start, u32 len);
+		struct folio *folio, u64 start, u32 len);			\
+void btrfs_folio_set_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len);			\
+void btrfs_folio_clear_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len);			\
+bool btrfs_folio_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len);			\
+void btrfs_folio_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len);			\
+void btrfs_folio_clamp_clear_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len);			\
+bool btrfs_folio_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
+		struct folio *folio, u64 start, u32 len);
 
 DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
 DECLARE_BTRFS_SUBPAGE_OPS(dirty);
@@ -147,13 +147,13 @@ DECLARE_BTRFS_SUBPAGE_OPS(ordered);
 DECLARE_BTRFS_SUBPAGE_OPS(checked);
 
 bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
-		struct page *page, u64 start, u32 len);
+		struct folio *folio, u64 start, u32 len);
 
-void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
-				 struct page *page);
-void btrfs_page_unlock_writer(struct btrfs_fs_info *fs_info, struct page *page,
-			      u64 start, u32 len);
+void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
+				  struct folio *folio);
+void btrfs_folio_unlock_writer(struct btrfs_fs_info *fs_info,
+			       struct folio *folio, u64 start, u32 len);
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
-				      struct page *page, u64 start, u32 len);
+				      struct folio *folio, u64 start, u32 len);
 
 #endif
-- 
2.43.0


