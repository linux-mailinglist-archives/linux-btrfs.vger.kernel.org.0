Return-Path: <linux-btrfs+bounces-5425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43708FA609
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 00:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E80828CC90
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 22:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF013CF8A;
	Mon,  3 Jun 2024 22:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uoSxPPmi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uoSxPPmi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B11135A46
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717455042; cv=none; b=nuhwGfJETH9lqpPWeQJc0gMZkc6fCuNvxaxyO9d0FgkiOE1dI+59KQt/jPsvombvYdlLiArjTC9hG3qTEE8GX/JJDTEEddQqLbAOA2+3j6VlTCgEmzSWuRsXET8dIHbhPG3wUTAmjyTRQyZ+B7zsc9W2cOzAp0ts/7JsU8ZeCbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717455042; c=relaxed/simple;
	bh=B13dUtWMR5LB4K+9Ay0xkcsPewkOEb+69xR9N3UWfm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZHM1hV/G3NIdOpH1624D87S+Rh0Bnb2XMtw1fBH9HoJn9hmmN5R2s5dmDuDRC+xgpyzMogmILOvIDdQvNPzyDei5IL3v29DSjbuzQJoveROX1DXRKUwsTY2GV/f8GUDVbneO/iKqt0HMpdHwbrWkNtFU4F2gM3cLFkpNqqTCrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uoSxPPmi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uoSxPPmi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 524B81F78F;
	Mon,  3 Jun 2024 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717455038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R9aT6ALuLZBZ9hTGElKPTUpu4oKBpRP36WYBosEWoG0=;
	b=uoSxPPmi5iVFQzkTKTXBsa8+ZDbQW7zUBiaP2evmTTS39shoAv9X278/JHcndiQMjoLY4d
	cjswWMV2rX4prmuexK0LacjGlZMUSHTgQEbvPnjDdmo2CXhf7vYyNI27U/q+XFvEfBLL/l
	zWuq5aPxvRa78rAwfl6jDVmvPa0LMCQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717455038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R9aT6ALuLZBZ9hTGElKPTUpu4oKBpRP36WYBosEWoG0=;
	b=uoSxPPmi5iVFQzkTKTXBsa8+ZDbQW7zUBiaP2evmTTS39shoAv9X278/JHcndiQMjoLY4d
	cjswWMV2rX4prmuexK0LacjGlZMUSHTgQEbvPnjDdmo2CXhf7vYyNI27U/q+XFvEfBLL/l
	zWuq5aPxvRa78rAwfl6jDVmvPa0LMCQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FFA213A93;
	Mon,  3 Jun 2024 22:50:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kl83NbtIXmZVdgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Jun 2024 22:50:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: fix a possible race window when allocating new extent buffers
Date: Tue,  4 Jun 2024 08:20:13 +0930
Message-ID: <a295bc71b7fc652e40d9993913a941b78dc46fde.1717454979.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,toxicpanda.com,suse.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

[POSSIBLE RACE]
Commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
allocate-then-attach method") changes the sequence when allocating a new
extent buffer.

Previously we always call grab_extent_buffer() under
mapping->i_private_lock, to ensure the safety on modification on
folio::private (which is a pointer to extent buffer for regular
sectorsize)

This may be related to the following calltrace, which indicates btrfs is
underflowing the folio refcount.

 BUG: Bad page state in process kswapd0  pfn:d6e840
 page: refcount:0 mapcount:0 mapping:000000007512f4f2 index:0x2796c2c7c
 pfn:0xd6e840
 aops:btree_aops ino:1
 flags: 0x17ffffe0000008(uptodate|node=0|zone=2|lastcpupid=0x3fffff)
 page_type: 0xffffffff()
 raw: 0017ffffe0000008 dead000000000100 dead000000000122 ffff88826d0be4c0
 raw: 00000002796c2c7c 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: non-NULL mapping

[FIX]
Move all the code requiring i_private_lock into
attach_eb_folio_to_filemap(), so that everything is done with proper
lock protection.

Furthermore to prevent future problems, add an extra lockdep_assert() to
ensure we're holding proper lock.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-btrfs/CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com/
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://lore.kernel.org/lkml/CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com/
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Fixes: 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-attach method")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v1:
- Remove the analyze on the race window
  It turns out all that the allocation part (filemap_lock_folio() in
  alloc_extent_buffer()) and the folio release part
  (filemap_release_folio()) all require the folio to be locked.
  Thus it's impossible to race between eb allocation and release.

- Add extra lockdep_assert_hold() for grab_extent_buffer()
---
 fs/btrfs/extent_io.c | 55 +++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0c74f7df2e8b..6e164ac435de 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2913,6 +2913,8 @@ static struct extent_buffer *grab_extent_buffer(
 	struct folio *folio = page_folio(page);
 	struct extent_buffer *exists;
 
+	lockdep_assert_held(&page->mapping->i_private_lock);
+
 	/*
 	 * For subpage case, we completely rely on radix tree to ensure we
 	 * don't try to insert two ebs for the same bytenr.  So here we always
@@ -2980,13 +2982,14 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
  * The caller needs to free the existing folios and retry using the same order.
  */
 static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
+				      struct btrfs_subpage *prealloc,
 				      struct extent_buffer **found_eb_ret)
 {
 
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
-	struct folio *existing_folio;
+	struct folio *existing_folio = NULL;
 	int ret;
 
 	ASSERT(found_eb_ret);
@@ -2998,7 +3001,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
 				GFP_NOFS | __GFP_NOFAIL);
 	if (!ret)
-		return 0;
+		goto finish;
 
 	existing_folio = filemap_lock_folio(mapping, index + i);
 	/* The page cache only exists for a very short time, just retry. */
@@ -3014,14 +3017,16 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		return -EAGAIN;
 	}
 
-	if (fs_info->nodesize < PAGE_SIZE) {
+finish:
+	spin_lock(&mapping->i_private_lock);
+	if (existing_folio && fs_info->nodesize < PAGE_SIZE) {
 		/*
-		 * We're going to reuse the existing page, can drop our page
-		 * and subpage structure now.
+		 * We're going to reuse the existing page, can drop our folio
+		 * now.
 		 */
 		__free_page(folio_page(eb->folios[i], 0));
 		eb->folios[i] = existing_folio;
-	} else {
+	} else if (existing_folio) {
 		struct extent_buffer *existing_eb;
 
 		existing_eb = grab_extent_buffer(fs_info,
@@ -3029,6 +3034,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		if (existing_eb) {
 			/* The extent buffer still exists, we can use it directly. */
 			*found_eb_ret = existing_eb;
+			spin_unlock(&mapping->i_private_lock);
 			folio_unlock(existing_folio);
 			folio_put(existing_folio);
 			return 1;
@@ -3037,6 +3043,22 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		__free_page(folio_page(eb->folios[i], 0));
 		eb->folios[i] = existing_folio;
 	}
+	eb->folio_size = folio_size(eb->folios[i]);
+	eb->folio_shift = folio_shift(eb->folios[i]);
+	/* Should not fail, as we have preallocated the memory */
+	ret = attach_extent_buffer_folio(eb, eb->folios[i], prealloc);
+	ASSERT(!ret);
+	/*
+	 * To inform we have extra eb under allocation, so that
+	 * detach_extent_buffer_page() won't release the folio private
+	 * when the eb hasn't yet been inserted into radix tree.
+	 *
+	 * The ref will be decreased when the eb released the page, in
+	 * detach_extent_buffer_page().
+	 * Thus needs no special handling in error path.
+	 */
+	btrfs_folio_inc_eb_refs(fs_info, eb->folios[i]);
+	spin_unlock(&mapping->i_private_lock);
 	return 0;
 }
 
@@ -3048,7 +3070,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	int attached = 0;
 	struct extent_buffer *eb;
 	struct extent_buffer *existing_eb = NULL;
-	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
 	bool page_contig = true;
@@ -3114,7 +3135,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	for (int i = 0; i < num_folios; i++) {
 		struct folio *folio;
 
-		ret = attach_eb_folio_to_filemap(eb, i, &existing_eb);
+		ret = attach_eb_folio_to_filemap(eb, i, prealloc, &existing_eb);
 		if (ret > 0) {
 			ASSERT(existing_eb);
 			goto out;
@@ -3151,24 +3172,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * and free the allocated page.
 		 */
 		folio = eb->folios[i];
-		eb->folio_size = folio_size(folio);
-		eb->folio_shift = folio_shift(folio);
-		spin_lock(&mapping->i_private_lock);
-		/* Should not fail, as we have preallocated the memory */
-		ret = attach_extent_buffer_folio(eb, folio, prealloc);
-		ASSERT(!ret);
-		/*
-		 * To inform we have extra eb under allocation, so that
-		 * detach_extent_buffer_page() won't release the folio private
-		 * when the eb hasn't yet been inserted into radix tree.
-		 *
-		 * The ref will be decreased when the eb released the page, in
-		 * detach_extent_buffer_page().
-		 * Thus needs no special handling in error path.
-		 */
-		btrfs_folio_inc_eb_refs(fs_info, folio);
-		spin_unlock(&mapping->i_private_lock);
-
 		WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->start, eb->len));
 
 		/*
-- 
2.45.2


