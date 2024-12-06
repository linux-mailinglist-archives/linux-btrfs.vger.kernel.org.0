Return-Path: <linux-btrfs+bounces-10086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E739E647E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 03:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A8D284BBC
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 02:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D02A16132F;
	Fri,  6 Dec 2024 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nNFsqbdK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nNFsqbdK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0BE1E522
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453784; cv=none; b=cIUWMi5+q5XIPWkhMn/lx1WUwirKFu2cD1U48qWGEo7s5qTQfLsQtRkT3FmDLHTQMqEXDOkTTTSaxL2bhK6WIKXCOdcYDskmLWrTl8i+SKp+tGR6lvj2v/vG55hwGOB8jl/g/eP1lHB9lC38vxXNYZ+gsQ1iWzIbHiOoup0lnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453784; c=relaxed/simple;
	bh=7lktaC65xowsLrjK30hzCCZylKo+1lQ/oW7h4aS4XQI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DhD1CVATW3Ld5dx2F57Wsr6hbxhy/cxvFqQGOdiUvgq9dUpD6xvu7fjwEPrjTXn/Bwl1HE8MiMnqSk49Uv7j6q8mLnRHTJmt52oZOObZM2n30UgLfeca7AXXl8wXZPdNv3O/WV4Val2Ka2sjNHWf3ppUOTiTZs8j9iAPW8PCU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nNFsqbdK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nNFsqbdK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6AF4821185
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 02:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733453780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AAsGbWT9ihE51PXHuqZw6oR1k99pNT26ImSEqLfOAYM=;
	b=nNFsqbdKGTQIYYPn4tLTUiB72qOstzradaQu4evzBF2HCxk3O6jZelNdB8WvhaOF9nsvtj
	2tsjjsGo/bxGAZ+1XS60ftwPM48gT7pFJ3PcST83HCHEudGP4a1xdBHDgDdBpmlILP+4Cc
	CEgcen+mXK8A/LcDDkiDFdwpEb1xgVA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733453780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AAsGbWT9ihE51PXHuqZw6oR1k99pNT26ImSEqLfOAYM=;
	b=nNFsqbdKGTQIYYPn4tLTUiB72qOstzradaQu4evzBF2HCxk3O6jZelNdB8WvhaOF9nsvtj
	2tsjjsGo/bxGAZ+1XS60ftwPM48gT7pFJ3PcST83HCHEudGP4a1xdBHDgDdBpmlILP+4Cc
	CEgcen+mXK8A/LcDDkiDFdwpEb1xgVA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9508213647
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 02:56:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1pslFdNnUmdULAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2024 02:56:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix the error handling of submit_uncompressed_range()
Date: Fri,  6 Dec 2024 13:26:01 +1030
Message-ID: <38ccbae160bce77530cf86ab22c38982788476e2.1733453757.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
If btrfs failed to compress the range, or can not reserve a large enough
data extent (e.g. too fragmented free space), btrfs will fall back to
submit_uncompressed_range().

But inside submit_uncompressed_range(), run_dealloc_cow() can also fail
due to -ENOSPC or whatever other errors.

In that case there are 3 bugs in the error handling:

1) Double freeing for the same delalloc range
   Which can lead to crash due to ordered extent double accounting

2) Start/end writeback without updating the subpage writeback bitmap

3) Unlock the folio without clear the subpage lock bitmap

Both bug 2) and 3) will crash the kernel if the btrfs block size is
smaller than folio size, as writeback/lock update needs to clear the
corresponding bitmap bits.
Setting the folio locked/writeback again with existing bits will trigger
the ASSERT()s inside subpage sanity checks.

[CAUSE]
Bug 1) happens in the following call chain:

  submit_uncompressed_range()
  |- run_dealloc_cow()
  |  |- cow_file_range()
  |     |- btrfs_reserve_extent()
  |        Failed with -ENOSPC or whatever error
  |
  |- btrfs_clean_up_ordered_extents()
  |  |- btrfs_mark_ordered_io_finished()
  |     Which cleans all the ordered extents in the async_extent range.
  |
  |- btrfs_mark_ordered_io_finished()
     Which cleans the folio range.

The finished ordered extents may not be immediately removed from the
ordered io tree, as they are removed inside a work queue.

So the second btrfs_mark_ordered_io_finished() may find the finished but
not-yet-removed ordered extents, and double free them.

Furthermore, the second btrfs_mark_ordered_io_finished() is not subpage
compatible, as it uses fixed folio_pos() with PAGE_SIZE, which can cover
other ordered extents.

Bug 2) and 3) are more straight forward, btrfs just calls folio_unlock(),
folio_start_writeback() and folio_end_writeback(), other than the helpers
which handle subpage cases.

[FIX]
For bug 1) since the first btrfs_clean_up_ordered_extents() call is
handling the whole range, we should not do the second
btrfs_mark_ordered_io_finished() call.

For bug 2) we should not even call
folio_start_writeback()/folio_end_writeback() anymore.
As the error handling protocol, cow_file_range() should clear
dirty flag and start/finish the writeback for the whole range passed in.

For bug 3) just change the folio_unlock() to btrfs_folio_end_lock()
helper.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9488eb9bb239..11c3ac84711f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1131,17 +1131,9 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 	if (ret < 0) {
 		btrfs_cleanup_ordered_extents(inode, locked_folio,
 					      start, end - start + 1);
-		if (locked_folio) {
-			const u64 page_start = folio_pos(locked_folio);
-
-			folio_start_writeback(locked_folio);
-			folio_end_writeback(locked_folio);
-			btrfs_mark_ordered_io_finished(inode, locked_folio,
-						       page_start, PAGE_SIZE,
-						       !ret);
-			mapping_set_error(locked_folio->mapping, ret);
-			folio_unlock(locked_folio);
-		}
+		if (locked_folio)
+			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
+					     start, async_extent->ram_size);
 	}
 }
 
-- 
2.47.1


