Return-Path: <linux-btrfs+bounces-10888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3AA085FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 04:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2765188A4BB
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 03:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C961205E36;
	Fri, 10 Jan 2025 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GTpnsnrZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QoCuOz9t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C41FF602
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479932; cv=none; b=mRF74wdXMF7ohmtRVZsHUw5uttTZbrYdU+Z5QtFV6AN+7xWNMN/QldTRs+bz2qF8JJ7+l5ob1GMrlZZrnAQHHwvn/9zEBh1PScDtDK8dgGykcDdOYpIyf6lNtncMDUdH1xA2ZZ9RNFogrE9Y9HwC/sOyqbesf9AMytZ2mo6nBJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479932; c=relaxed/simple;
	bh=PqnzWp8FKV3xS9hZ1BZ3CKUtxSbV6pG0OqgPb+Oy/fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chpxQlwHDc0g2y6thGFsLbcXZ5l2KyYWXWNKFi5nGDq3sUpL+GTmaE0/0nM+FY9KIsA+sSpf8ods3i4AarSCs+O60n4R4oSRbbvUSGA6zz+tmlCKsUL+THevx43msvaiMW+HwGj9ga/Eew9YJWEicVVA3OCLPDx7PDNlSwmLVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GTpnsnrZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QoCuOz9t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E428221169;
	Fri, 10 Jan 2025 03:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmTsjYIvImtin1qfTPJhH4AaNLEdSRkXA0Qh2+e9hoc=;
	b=GTpnsnrZdu6IWkLh3JUmWV4kg87CW94cFPzFixNSpB1hDeGH25flxS30pwI0pdN/3RmvaG
	8UtKNL/d6wtggbdeD/NXDavIEVE9Gg1m37073eop9s0DjEiv2K4h89dl87mqDGx+qTSnAU
	TjuOI5bZz2ZfY75eLLF6gA1RdsZlQmw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QoCuOz9t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmTsjYIvImtin1qfTPJhH4AaNLEdSRkXA0Qh2+e9hoc=;
	b=QoCuOz9tU+MHJysi8pIfeB8f2uvBxtA6ftJ1hQqPHE6Q25Z/KLzKE5zsBBFp4wg2HjsvBm
	W0ArzKi0Fo9udQjneGpCcNl9UveSSYzyoCOZ32sxk0mgl78XgNMpC/R+vMhDcSka/RCl42
	loPP8FIqk20K3BSB6lEWvKaN94uzabg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E397A1397D;
	Fri, 10 Jan 2025 03:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iE/6KLeUgGe0NQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 10 Jan 2025 03:32:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v3 03/10] btrfs: fix the error handling of submit_uncompressed_range()
Date: Fri, 10 Jan 2025 14:01:34 +1030
Message-ID: <d8614cf05b14514e0cd9c0fe283fa82a3998f2f2.1736479224.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736479224.git.wqu@suse.com>
References: <cover.1736479224.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E428221169
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
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
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

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0a15473655ed..e1c9bd673118 100644
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


