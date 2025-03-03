Return-Path: <linux-btrfs+bounces-11963-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A6A4B971
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 09:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4818A188AE36
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Mar 2025 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E608A1EB1BF;
	Mon,  3 Mar 2025 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YRPohDAb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YRPohDAb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565421E98FF
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Mar 2025 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990952; cv=none; b=XOR3ntUDHGWk18L1sHj6L7gFnEQAKLG9fsrZy+rIu4qo8uoI8yk47p+wVR7bzvSjCPG/zsvkRHt3PZN8VBmwrmYj3ZRVD5gp9wjF8IdaxM/f2DsMWaRsX+8DLTaaBOfzwQ3EmiBpyfvHC9vJjIUIXvRhFHj9hCkQMatrcXv4RAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990952; c=relaxed/simple;
	bh=hnJZxVQ+z/9RbxkilA3nPjiZeAvUQkXVzFiyR2Ge3E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkZ+omXh+ZhmxEG9zSTBC1rxIVtdnTq5Y0ApD1hbe7+aqYL2iDWbczIMp2BJbyfEYsaXJInB3gV3kbLxAZw6kP2Yts+N8ofOoAihNPnDmaqs5pLX6hjcEYPulanFFvxRqK0xH5YZ0dE5CKDaH2y22QEKu6KJW5UN4Fh7EUkVZp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YRPohDAb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YRPohDAb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FD061F393;
	Mon,  3 Mar 2025 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKM+GmBZboMw9eZIFFMNWU+xJrIPOAfSaDxGooy9JlU=;
	b=YRPohDAbIc1nOGstQ7JLeHkAlLdX7M0njLkXjS9LHFr4Qn7W92xo0rCvwxzK85ojuyhT1l
	UKsPwIMYqK/iKgFg459iBzd3lclrVt+umQY4VGPAv9S0b9tse+F17BWVuUvJnXX2t8gpTP
	tHBthfPTMF5zpwKIt2SQ5TuxgKdjQ3Y=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YRPohDAb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740990936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKM+GmBZboMw9eZIFFMNWU+xJrIPOAfSaDxGooy9JlU=;
	b=YRPohDAbIc1nOGstQ7JLeHkAlLdX7M0njLkXjS9LHFr4Qn7W92xo0rCvwxzK85ojuyhT1l
	UKsPwIMYqK/iKgFg459iBzd3lclrVt+umQY4VGPAv9S0b9tse+F17BWVuUvJnXX2t8gpTP
	tHBthfPTMF5zpwKIt2SQ5TuxgKdjQ3Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 332EA13939;
	Mon,  3 Mar 2025 08:35:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EI2NOdZpxWdybwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Mar 2025 08:35:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 1/8] btrfs: disable uncached writes for now
Date: Mon,  3 Mar 2025 19:05:09 +1030
Message-ID: <25f0ab13b113ff37ae66cab26be7e458321db74f.1740990125.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740990125.git.wqu@suse.com>
References: <cover.1740990125.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FD061F393
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Currently btrfs calls folio_end_writeback() inside a spinlock, to
prevent races of async extents for the same folio.

The async extent mechanism is utilized for compressed writes, which
allows a folio (or part of a folio) to be kept locked, and queue the
range into a workqueue and do the compression.
After the compression is done, then submit the compressed data and set
involved blocks writeback and unlock the range.

Such the async extent mechanism disrupts the regular writeback behavior,
where normally we submit all the involved blocks inside the same folio
in one go.
Now with async extent parts of the same folio can be randomly marked
writeback at any time, by different threads.

Thus for fs block size < page size cases, btrfs always hold a spinlock
when setting/clearing the folio writeback flag, to avoid async extents
to race on the same folio.

But now with the dropbehind folio flag, folio_end_writeback() is no longer
safe to be called inside a spinlock:

  folio_end_writeback()
  |- folio_end_dropbehind_write()
     |- if (in_task() && folio_trylock())
        |  Since all btrfs endio functions happen inside a workqueue,
	|  it will always pass in_task() check.
	|
        |- folio_unmap_invalidate()
	   |- folio_launder()
	      !! MAY SLEEP !!
	      And there is no gfp flag to let the fs to avoid sleeping.

Furthermore, for fs blocks < page size cases, we can even deadlock on
the same subpage spinlock:

 btrfs_subpage_clear_writeback()
 |- spin_lock_irqsave(&subpage->lock)
 |- folio_end_writeback()
    |- folio_end_dropbehind_write()
       |- folio_unmap_invalidate()
          |- filemap_release_folio()
	     |- __btrfs_release_folio()
	        |- wait_subpage_spinlock()
		   |- spin_lock_irq(&subpage->lock);
                   !! DEADLOCK !!

So for now let's disable uncached write for btrfs, until we solve
all problems with planned solutions:

- Use atomic to trace writeback status
  Need to remove the COW fixup (handling of out-of-band dirty folio)
  routine first and align the member to iomap_folio_status structure
  first.

- Better async extent handling
  Instead of leaving the folios locked and set writeback flag after
  compression, change it to set writeback flags then start compression.

Fixes: fcc7e3306e11 ("btrfs: add support for uncached writes (RWF_DONTCACHE)")
Cc: Jens Axboe <axboe@kernel.dk>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Thankfully the btrfs uncached writes patch is not yet pushed to
upstream, I can remove it from for-next branch if this patch got enough
reviews.

But I prefer not to, as that commit still contains some good cleanup on
the FGP flags.
---
 fs/btrfs/file.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e87d4a37c929..fe9e98f916f4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1099,8 +1099,17 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		fgp_flags |= FGP_NOWAIT;
 	}
 
+	/*
+	 * DONTCACHE will make folio reclaim happen immediately at
+	 * folio_end_writeback(), for fs block size < page size cases it will
+	 * happen inside a spinlock (due to possible async extents races),
+	 * and such folio_end_writeback() may cause sleep inside a spinlock.
+	 *
+	 * So disable DONTCACHE until we either reworked async extent, or find
+	 * a better way to handle per-block writeback tracking.
+	 */
 	if (iocb->ki_flags & IOCB_DONTCACHE)
-		fgp_flags |= FGP_DONTCACHE;
+		return -EOPNOTSUPP;
 
 	ret = btrfs_inode_lock(BTRFS_I(inode), ilock_flags);
 	if (ret < 0)
@@ -3679,7 +3688,7 @@ const struct file_operations btrfs_file_operations = {
 #endif
 	.remap_file_range = btrfs_remap_file_range,
 	.uring_cmd	= btrfs_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC | FOP_DONTCACHE,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_BUFFER_WASYNC,
 };
 
 int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, loff_t end)
-- 
2.48.1


