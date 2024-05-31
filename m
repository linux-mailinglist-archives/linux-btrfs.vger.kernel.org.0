Return-Path: <linux-btrfs+bounces-5373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F588D5991
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 06:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CB12874B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2024 04:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A935952F7A;
	Fri, 31 May 2024 04:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fIOeNAlL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fIOeNAlL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62318E2A
	for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2024 04:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717130675; cv=none; b=rFQ7HW0GuLFNg5lWP87HC97oBN6/gfVNObd4yLsWsYbrEot3+p0g5LVlRpx4Sz/PO61afYbZzPkRpud4dDj3daMQy6NIf+Dm+9ya4yb7kjxWCw4Z4KYCKBkAbX6JWP1BjrhrNMnHM8LQRTYYBQvo28UsRsZqYJMjz7dMraEJD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717130675; c=relaxed/simple;
	bh=oIYmpGSYLvKkwirpXhb9f2trQI71zWIVzR0KOAYtXTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyvrmNVgMGcdmvFxcm8sh3w50EpnXyF70eBaxR38++AYWEBLI2gvZQxKLbau+gvKeb0588kVmZNZq3OggbVgRNUoR9ZKbAidKdtAt60dRFtejg4w/w84jmjTLeFgIFOgvzefqnPVtNU8xCed0yiM46jacNL4kvZy9hwW1wnYb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fIOeNAlL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fIOeNAlL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 766BE21AA8;
	Fri, 31 May 2024 04:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717130671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LFZHVylwaJVBDa349UG9W2n4sfRt866qywnZfoLFidU=;
	b=fIOeNAlLulI0wKW/vDD+YR6+4MyqBrDCgdMKc6+/1sgLu1mgI1XirwgVu4CFX0nhKM1sFV
	vvEpSVujGUoL8mLkMyuDURx52RHaroD/mq4cXw+q+GtUxk5Huo13PI3L/FLkN5cr4H6QOm
	ApjKNZLGUeyBnBcUiyB/Pk5EueWJA8s=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fIOeNAlL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717130671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LFZHVylwaJVBDa349UG9W2n4sfRt866qywnZfoLFidU=;
	b=fIOeNAlLulI0wKW/vDD+YR6+4MyqBrDCgdMKc6+/1sgLu1mgI1XirwgVu4CFX0nhKM1sFV
	vvEpSVujGUoL8mLkMyuDURx52RHaroD/mq4cXw+q+GtUxk5Huo13PI3L/FLkN5cr4H6QOm
	ApjKNZLGUeyBnBcUiyB/Pk5EueWJA8s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D55C81372E;
	Fri, 31 May 2024 04:44:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tIeFH61VWWalSgAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 31 May 2024 04:44:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH RFC] btrfs: fix a possible race window when allocating new extent buffers
Date: Fri, 31 May 2024 14:14:11 +0930
Message-ID: <b2192936067ea7e82e7d5958c0aa6baf8c29b5d9.1717130599.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 766BE21AA8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

[POSSIBLE RACE]
Commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
allocate-then-attach method") changes the sequence when allocating a new
extent buffer.

Previously we always call grab_extent_buffer() under
mapping->i_private_lock, thus there is no chance for race to happen
between extent buffer releasing and allocating.

However that commit changed the behavior to call grab_extent_buffer()
without holding that lock, making the following race possible:

            Thread A            |          Thread B
 -------------------------------+----------------------------------
                                | btree_release_folio()
 			        | |- btrfs_release_extent_buffer_pages()
 attach_eb_folio_to_filemap()   | |  |- detach_extent_buffer_folio()
 |                              | \- return 1 so that this folio would be
 |                              |    released from page cache
 |-grab_extent_buffer()         |
 | Now it returns no eb, we can |
 | reuse the folio              |

This would make the newly allocated extent buffer to point to a soon to
be freed folio.
The problem is not immediately triggered, as the we still hold one extra
folio refcount from thread A.

But later mostly at extent buffer release, if we put the last refcount
of the folio (only hold by ourselves), then we can hit various problems.

The most common one is the bad folio status:

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

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-btrfs/CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com/
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://lore.kernel.org/lkml/CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com/
Fixes: 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-attach method")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

I do not have a reliable enough way to reproduce the bug, nor enough
confidence on the btree_release_folio() race.

But so far this is the most sounding possibility, any extra testing
would be appreciated.
---
 fs/btrfs/extent_io.c | 53 ++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0c74f7df2e8b..86d2714018a4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2980,13 +2980,14 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
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
@@ -2998,7 +2999,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
 				GFP_NOFS | __GFP_NOFAIL);
 	if (!ret)
-		return 0;
+		goto finish;
 
 	existing_folio = filemap_lock_folio(mapping, index + i);
 	/* The page cache only exists for a very short time, just retry. */
@@ -3014,14 +3015,16 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
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
@@ -3029,6 +3032,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 		if (existing_eb) {
 			/* The extent buffer still exists, we can use it directly. */
 			*found_eb_ret = existing_eb;
+			spin_unlock(&mapping->i_private_lock);
 			folio_unlock(existing_folio);
 			folio_put(existing_folio);
 			return 1;
@@ -3037,6 +3041,22 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
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
 
@@ -3048,7 +3068,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	int attached = 0;
 	struct extent_buffer *eb;
 	struct extent_buffer *existing_eb = NULL;
-	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
 	bool page_contig = true;
@@ -3114,7 +3133,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	for (int i = 0; i < num_folios; i++) {
 		struct folio *folio;
 
-		ret = attach_eb_folio_to_filemap(eb, i, &existing_eb);
+		ret = attach_eb_folio_to_filemap(eb, i, prealloc, &existing_eb);
 		if (ret > 0) {
 			ASSERT(existing_eb);
 			goto out;
@@ -3151,24 +3170,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
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
2.45.1


