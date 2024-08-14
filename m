Return-Path: <linux-btrfs+bounces-7183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A744E95118B
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 03:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371FD1F24452
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2024 01:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9548171A5;
	Wed, 14 Aug 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LepakF68";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LepakF68"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21B849C
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723598450; cv=none; b=ehe4KHwtFTPgRMUpyHtrk2z3uiZyTLZr0G0I4ofPCat66Rzmou5YiNoib0PaG6l295o2rfB5Xa3o1h1OoSUSDj8R1lepzW5q3i0mETu+nnQBDAIPSTHI5RvjoQXMZbUMdoyLVT9aoS+w592Yfs6yk8dQBGxookiYtOgiJ2zR/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723598450; c=relaxed/simple;
	bh=AURcII/57YnSguf26DyXwvDpV2D0cAjcqS4Xm7gWnLk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sfqTvDddTHgxVDr2EFKYU6U2bm2rnk/fkUy4Fwin4k/n1wqlPEUNmk2j2tqBLAYVfW848NuyghIIOKHWDsINgkvaQ8QpVM5EQToYS+nH+0mNEsof1Zzz/APPGPo2a3Pb45/5gR1KjHdLtvMtTNWD7Z/ucR8sZ6MRqmZ2fQmb27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LepakF68; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LepakF68; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7A8B22606
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 01:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723598444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o6qGPQPsx5iu2xmrUAp+8e1avgmw0ccq4cid07UwJ3I=;
	b=LepakF68A7lftgKwwwRdVC5tmfvD7c70FurGB3OLtUEIVMjtM6RSNzfleIBKc94XkPEhMm
	EYfNXqvuldrkU2YNKuT2xumpVd/saddDpZj9QmUevToT0HLMOgF75tat5lEgtFLSl9ckB3
	Qk4vpqvR0PJ4cCUlC/7cSvRzYBngZfo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723598444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=o6qGPQPsx5iu2xmrUAp+8e1avgmw0ccq4cid07UwJ3I=;
	b=LepakF68A7lftgKwwwRdVC5tmfvD7c70FurGB3OLtUEIVMjtM6RSNzfleIBKc94XkPEhMm
	EYfNXqvuldrkU2YNKuT2xumpVd/saddDpZj9QmUevToT0HLMOgF75tat5lEgtFLSl9ckB3
	Qk4vpqvR0PJ4cCUlC/7cSvRzYBngZfo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA23C139B9
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 01:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l8FgKGsGvGYWUgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2024 01:20:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove the nr_ret parameter from __extent_writepage_io()
Date: Wed, 14 Aug 2024 10:50:21 +0930
Message-ID: <248988e6643ee3c3d07e884385f503e9d8ebbcc7.1723598419.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

The parameter @nr_ret is used to tell the caller how many sectors have
been submitted for IO.

Then callers check @nr_ret value to determine if we need to manually
clear the PAGECACHE_TAG_DIRTY, as if we submitted no sector (e.g. all
sectors are beyond i_size) there is no folio_clear_writeback() called thus
PAGECACHE_TAG_DIRTY tag will not be cleared.

Remove this parameter by:

- Moving the btrfs_folio_clear_writeback() call into
  __extent_writepage_io()
  So that if we didn't submit any IO, then manually call
  btrfs_folio_set_writeback() to clear PAGECACHE_TAG_DIRTY when
  the page is no longer dirty.

- Use a bool to record if we have submitted any sector
  Instead of an int.

- Use subpage compatible helpers to end folio writeback.
  This brings no change to the behavior, just for the sake of consistency.

  As for the call site inside __extent_writepage(), we're always called
  for the whole page, so the existing full page helper
  folio_(start|end)_writeback() is totally fine.

  For the call site inside extent_write_locked_range(), although we can
  have subpage range, folio_start_writeback() will only clear
  PAGECACHE_TAG_DIRTY if the page is no longer dirty, and the full folio
  will still be dirty if there is any subpage dirty range.
  Only when the last dirty subpage sector is cleared, the
  folio_start_writeback() will clear PAGECACHE_TAG_DIRTY.

  So no matter if we call the full page or subpage helper, the result
  is still the same, then just use the subpage helpers for consistency.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 41 +++++++++++++++++------------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 822e2bf8bc99..b04e0aa97ebd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1409,7 +1409,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 						    struct folio *folio,
 						    u64 start, u32 len,
 						    struct btrfs_bio_ctrl *bio_ctrl,
-						    loff_t i_size, int *nr_ret)
+						    loff_t i_size)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long range_bitmap = 0;
@@ -1422,11 +1422,11 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	 */
 	unsigned long dirty_bitmap = 1;
 	unsigned int bitmap_size = 1;
+	bool submitted_io = false;
 	const u64 folio_start = folio_pos(folio);
 	u64 cur;
 	int bit;
 	int ret = 0;
-	int nr = 0;
 
 	ASSERT(start >= folio_start &&
 	       start + len <= folio_start + folio_size(folio));
@@ -1470,20 +1470,24 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
 		if (ret < 0)
-			goto out_error;
-		nr++;
+			goto out;
+		submitted_io = true;
 	}
 
 	btrfs_folio_assert_not_dirty(fs_info, folio, start, len);
-	*nr_ret = nr;
-	return 0;
-
-out_error:
+out:
 	/*
-	 * If we finish without problem, we should not only clear folio dirty,
-	 * but also empty subpage dirty bits
+	 * If we didn't submitted any sector (>= i_size), folio dirty get
+	 * cleared but PAGECACHE_TAG_DIRTY is not cleared (only cleared
+	 * by folio_start_writeback() if the folio is not dirty).
+	 *
+	 * Here we set writeback and clear for the range. If the full folio
+	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
 	 */
-	*nr_ret = nr;
+	if (!submitted_io) {
+		btrfs_folio_set_writeback(fs_info, folio, start, len);
+		btrfs_folio_clear_writeback(fs_info, folio, start, len);
+	}
 	return ret;
 }
 
@@ -1501,7 +1505,6 @@ static int __extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ct
 	struct inode *inode = folio->mapping->host;
 	const u64 page_start = folio_pos(folio);
 	int ret;
-	int nr = 0;
 	size_t pg_offset;
 	loff_t i_size = i_size_read(inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
@@ -1532,18 +1535,13 @@ static int __extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ct
 		goto done;
 
 	ret = __extent_writepage_io(BTRFS_I(inode), folio, folio_pos(folio),
-				    PAGE_SIZE, bio_ctrl, i_size, &nr);
+				    PAGE_SIZE, bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
 
 	bio_ctrl->wbc->nr_to_write--;
 
 done:
-	if (nr == 0) {
-		/* make sure the mapping tag for page dirty gets cleared */
-		folio_start_writeback(folio);
-		folio_end_writeback(folio);
-	}
 	if (ret) {
 		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
 					       page_start, PAGE_SIZE, !ret);
@@ -2297,15 +2295,10 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 			ASSERT(folio_test_dirty(folio));
 
 		ret = __extent_writepage_io(BTRFS_I(inode), folio, cur, cur_len,
-					    &bio_ctrl, i_size, &nr);
+					    &bio_ctrl, i_size);
 		if (ret == 1)
 			goto next_page;
 
-		/* Make sure the mapping tag for page dirty gets cleared. */
-		if (nr == 0) {
-			btrfs_folio_set_writeback(fs_info, folio, cur, cur_len);
-			btrfs_folio_clear_writeback(fs_info, folio, cur, cur_len);
-		}
 		if (ret) {
 			btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
 						       cur, cur_len, !ret);
-- 
2.45.2


