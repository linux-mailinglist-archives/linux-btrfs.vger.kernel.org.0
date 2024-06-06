Return-Path: <linux-btrfs+bounces-5486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84068FDC2B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 03:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53053285604
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 01:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF4111187;
	Thu,  6 Jun 2024 01:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QCU984li";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BlzcBJ4O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973117C74
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717637536; cv=none; b=TNR98Ypj24nUx0/hk1+BjsPPLJuY+an4SFcpYMDfZupv+LUZAhwFGOAVd0ZLq1qa+itXxMNE0waSliqBHohCnEhOtiPNR6RTqm7slNL2rQoCPSy4hUhTvOD3Okx5PI9oS3bsMBk65LOrzLmdWrxGAHQbCPSiByTfC7sh+3B2LOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717637536; c=relaxed/simple;
	bh=5HKLOObFcuElnOQ0dvP1dPVmZ9A48kcRP7TSj02uHEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ttSjBwA95UZO559F9QtXFP54jhmLsooNY0IGUcyuN6w6jlNqcW/mzYzvJZVZH0hgCV8jsrayiePRiLHNUGXZUeyDSkZgYbXZCUL3UQqHetpMmPj50iB+qW0cfBcZaJvExwwWXDfBKuCvnfGzGz4Fkdy439BBGKfoyZWm4ydHYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QCU984li; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BlzcBJ4O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC44D21AAD;
	Thu,  6 Jun 2024 01:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717637532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9txZrSTUfLw/1XALvRfOJDkp93DwM+96McCyz8UnJRk=;
	b=QCU984lisRqAAhH26jutp9CmbltD1MgCeXJPXU2FJ1hix+a7+DZTk88gBD9YmLlGQaLD5X
	DaD97NnM/mF66UfTt87lIIW3nCjeD0VqKzI9fgCUzqoMV3FksKObEcIuai5w/Z9stWpWyu
	wSBgG4AzCnxgZ138Fe7bjkXLtW9Grsw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BlzcBJ4O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717637531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9txZrSTUfLw/1XALvRfOJDkp93DwM+96McCyz8UnJRk=;
	b=BlzcBJ4ObXk3APopbs1A2brBZc5RqO5XRBR7+vE6+GhTXcAfvPpb/ktpSWaN9X4iUYeDae
	EpRZyvJk5JmB/dU9PRNqp5cAWTuFNKDeORf3JZ4uoEzO5nbkDyRoVtvXMs93sTDkOtY8p+
	1AHM2epU+B6Ypcw8iwvKppaW2ypbbUE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB43913A79;
	Thu,  6 Jun 2024 01:32:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OgRrJ5kRYWa5cAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 06 Jun 2024 01:32:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Chris Mason <clm@fb.com>
Subject: [PATCH v2] btrfs: fix a possible race window when allocating new extent buffers
Date: Thu,  6 Jun 2024 11:01:51 +0930
Message-ID: <0f003d96bcb54c9c1afd5512739645bbdddb701b.1717637062.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CC44D21AAD
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,fb.com];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

[BUG]
Since v6.8 there are rare kernel crashes hitting by different reporters,
and most of them share the same bad page status error messages like
this:

 BUG: Bad page state in process kswapd0  pfn:d6e840
 page: refcount:0 mapcount:0 mapping:000000007512f4f2 index:0x2796c2c7c
 pfn:0xd6e840
 aops:btree_aops ino:1
 flags: 0x17ffffe0000008(uptodate|node=0|zone=2|lastcpupid=0x3fffff)
 page_type: 0xffffffff()
 raw: 0017ffffe0000008 dead000000000100 dead000000000122 ffff88826d0be4c0
 raw: 00000002796c2c7c 0000000000000000 00000000ffffffff 0000000000000000
 page dumped because: non-NULL mapping

[CAUSE]
Commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
allocate-then-attach method") changes the sequence when allocating a new
extent buffer.

Previously we always call grab_extent_buffer() under
mapping->i_private_lock, to ensure the safety on modification on
folio::private (which is a pointer to extent buffer for regular
sectorsize)

This can lead to the following race:

Thread A is trying to allocate an extent buffer at bytenr X, with 4
4K pages, meanwhile thread B is trying to release the page at X + 4K
(the second page of the extent buffer at X).

           Thread A                |                 Thread B
-----------------------------------+-------------------------------------
                                   | btree_release_folio()
				   | | This is for the page at X + 4K,
				   | | Not page X.
				   | |
alloc_extent_buffer()              | |- release_extent_buffer()
|- filemap_add_folio() for the     | |  |- atomic_dec_and_test(eb->refs)
|  page at bytenr X (the first     | |  |
|  page).                          | |  |
|  Which returned -EEXIST.         | |  |
|                                  | |  |
|- filemap_lock_folio()            | |  |
|  Returned the first page locked. | |  |
|                                  | |  |
|- grab_extent_buffer()            | |  |
|  |- atomic_inc_not_zero()        | |  |
|  |  Returned false               | |  |
|  |- folio_detach_private()       | |  |- folio_detach_private() for X
|     |- folio_test_private()      | |     |- folio_test_private()
      |  Returned true             | |     |  Returned true
      |- folio_put()               |       |- folio_put()

Now this double puts on the same folio at folio X, leads to the
refcount underflow of the folio X, and eventually causing the BUG_ON()
on the page->mapping.

The condition is not that easy to hit:

- The release must be triggered for the middle page of an eb
  If the release is on the same first page of an eb, page lock would kick
  in and prevent the race.

- folio_detach_private() has a very small race window
  It's only between folio_test_private() and folio_clear_private().

That's exactly what mapping->i_private_lock is used to prevent such race,
and commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
allocate-then-attach method") totally screwed this up.

At that time, I thought the page lock would kick in as
filemap_release_folio() also requires the page to be locked, but forgot
the filemap_release_folio() only locks one page, not all pages of an
extent buffer.

[FIX]
Move all the code requiring i_private_lock into
attach_eb_folio_to_filemap(), so that everything is done with proper
lock protection.

Furthermore to prevent future problems, add an extra
lockdep_assert_locked() to ensure we're holding the proper lock.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-btrfs/CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com/
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://lore.kernel.org/lkml/CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com/
Fixes: 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-attach method")
Cc: Chris Mason <clm@fb.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- With the help of Chris Mason, it's now clear where and how the race
  happened

- Fix a bug that @existing_folio is not properly cleaned up
  Which can easily crash the kernel if filemap_lock_folio() returned
  -EINVAL.

v1:
- Remove the analyze on the race window
  It turns out all that the allocation part (filemap_lock_folio() in
  alloc_extent_buffer()) and the folio release part
  (filemap_release_folio()) all require the folio to be locked.
  Thus it's impossible to race between eb allocation and release.

- Add extra lockdep_assert_hold() for grab_extent_buffer()

光是镜片就要500.。。。
-相比之下验光和筐子简直不要钱-
---
 fs/btrfs/extent_io.c | 59 ++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0c74f7df2e8b..af5b7fa7da99 100644
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
@@ -2998,12 +3001,14 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
 				GFP_NOFS | __GFP_NOFAIL);
 	if (!ret)
-		return 0;
+		goto finish;
 
 	existing_folio = filemap_lock_folio(mapping, index + i);
 	/* The page cache only exists for a very short time, just retry. */
-	if (IS_ERR(existing_folio))
+	if (IS_ERR(existing_folio)) {
+		existing_folio = NULL;
 		goto retry;
+	}
 
 	/* For now, we should only have single-page folios for btree inode. */
 	ASSERT(folio_nr_pages(existing_folio) == 1);
@@ -3014,14 +3019,16 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
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
@@ -3029,6 +3036,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		if (existing_eb) {
 			/* The extent buffer still exists, we can use it directly. */
 			*found_eb_ret = existing_eb;
+			spin_unlock(&mapping->i_private_lock);
 			folio_unlock(existing_folio);
 			folio_put(existing_folio);
 			return 1;
@@ -3037,6 +3045,22 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
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
 
@@ -3048,7 +3072,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	int attached = 0;
 	struct extent_buffer *eb;
 	struct extent_buffer *existing_eb = NULL;
-	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
 	bool page_contig = true;
@@ -3114,7 +3137,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	for (int i = 0; i < num_folios; i++) {
 		struct folio *folio;
 
-		ret = attach_eb_folio_to_filemap(eb, i, &existing_eb);
+		ret = attach_eb_folio_to_filemap(eb, i, prealloc, &existing_eb);
 		if (ret > 0) {
 			ASSERT(existing_eb);
 			goto out;
@@ -3151,24 +3174,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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


