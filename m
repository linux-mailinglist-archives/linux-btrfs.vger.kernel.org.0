Return-Path: <linux-btrfs+bounces-10117-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883379E8337
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 03:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38162281D15
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 02:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A51A49620;
	Sun,  8 Dec 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bfvFmA+4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bfvFmA+4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED68224D6
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733626292; cv=none; b=EzIkH7ZiVPJQjNonYgpL9nMb/bjHkiMLJsAhISspTZllLnTkJKEj5Dc36QBUJU6mMAn40ycXveGj2pPBFSeX9C9RztCEZJ7u+FwZKngHINu534uh2wkKmLOhmsHdWh2Smh6U3XidglwVQ161T4NBd0zX3hoC3UrJ+aWvcE7GPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733626292; c=relaxed/simple;
	bh=c09gAvMdZQCT4/yGlwX9IyMt0IjLORAW/hOWA9tOvmE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PocFy4kks8iYQKZtdp/H107+kJL4bVUQo0LYg/B0jSom6dJfDIV5E95biFTCo1DDJp4VtfAryU7EmOnnjaYpzBQwKAFgi8AlIgtJoHEtqV6gED3OLU8ptgmkp+Gn8grHCxq9hO8WOSYSa1AQhv+/AbnILGNdKLLRQXQfvn5WeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bfvFmA+4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bfvFmA+4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C0291F45F
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733626288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+wk4KA2ZXySUcG1nFRFY9xIuzbiQNy9uEFymOts2qs=;
	b=bfvFmA+4G1C1hQT9KA3S1+V9fcn64i81ksHQ9txwcdokRT9/P5lWnuvyTFKFK6zJO9kiw+
	wxuIdPU04M6T2FNOjiaP442evwayf/VQLuvEVEpRkskc/t/QAaPanpZvX57+vnsWmpY0Ux
	B+sRlGZv86o9t4R5tPZXRtBhrq/U/20=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bfvFmA+4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733626288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+wk4KA2ZXySUcG1nFRFY9xIuzbiQNy9uEFymOts2qs=;
	b=bfvFmA+4G1C1hQT9KA3S1+V9fcn64i81ksHQ9txwcdokRT9/P5lWnuvyTFKFK6zJO9kiw+
	wxuIdPU04M6T2FNOjiaP442evwayf/VQLuvEVEpRkskc/t/QAaPanpZvX57+vnsWmpY0Ux
	B+sRlGZv86o9t4R5tPZXRtBhrq/U/20=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 893E5133D1
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sHgAE68JVWcXcQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 02:51:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: fix the error handling of submit_uncompressed_range()
Date: Sun,  8 Dec 2024 13:21:00 +1030
Message-ID: <b6aaf2efed84402d1294f8c6df119254a68fc7bf.1733624454.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733624454.git.wqu@suse.com>
References: <cover.1733624454.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4C0291F45F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
If btrfs failed to compress the range, or can not reserve a large enough
data extent (e.g. too fragmented free space), btrfs will fall back to
submit_uncompressed_range().

But inside submit_uncompressed_range(), run_dealloc_cow() can also fail
due to -ENOSPC or whatever other errors.

In that case there are 3 bugs in the error handling:

1) Double freeing for the same ordered extent
   Which can lead to crash due to ordered extent double accounting

2) Start/end writeback without updating the subpage writeback bitmap

3) Unlock the folio without clear the subpage lock bitmap

Both bug 2) and 3) will crash the kernel if the btrfs block size is
smaller than folio size, as the next time the folio get writeback/lock
updates, subpage will find the bitmap already have the range set,
triggering an ASSERT().

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
For bug 1) since the first btrfs_cleanup_ordered_extents() call is
handling the whole range, we should not do the second
btrfs_mark_ordered_io_finished() call.

And for the first btrfs_cleanup_ordered_extents(), we no longer need to
pass the @locked_page parameter, as we are already in the async extent
context, thus will never rely on the error handling inside
btrfs_run_delalloc_range().

So just let the btrfs_clean_up_ordered_extents() to handle every folio
equally.

For bug 2) we should not even call
folio_start_writeback()/folio_end_writeback() anymore.
As the error handling protocol, cow_file_range() should clear
dirty flag and start/finish the writeback for the whole range passed in.

For bug 3) just change the folio_unlock() to btrfs_folio_end_lock()
helper.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4997200dbb2..aee172abad1c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1129,19 +1129,11 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			       &wbc, false);
 	wbc_detach_inode(&wbc);
 	if (ret < 0) {
-		btrfs_cleanup_ordered_extents(inode, locked_folio,
+		btrfs_cleanup_ordered_extents(inode, NULL,
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


