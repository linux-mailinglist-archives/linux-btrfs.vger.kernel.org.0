Return-Path: <linux-btrfs+bounces-10917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A6CA0A2E3
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 11:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892A716A344
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5AF191F6A;
	Sat, 11 Jan 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nzfHtLMX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nzfHtLMX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56661925BF
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592257; cv=none; b=XKJPyZ2SpeJdhblAzrh6LQWi3NROYqVD0XqjYCE3onwYcKpbVB1cPhv255mSKPMYvaV+8hPSKhPiWWDZFTms8N2jN2heCr1cAQDVAGgEk6U6YPKr3m6OvvyEt7uH3itXFUWtCnZmPT/UGgNW9jg+JVdo0kvHONMzo13pVPGxUTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592257; c=relaxed/simple;
	bh=QlEIRb6CLnsjrHoKMYTZWOHh3/E3SjpqW3NeKr7Jkdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHYH/YBuQBr4x9MWK4XcfGfby1vGqPKy1kfFf4X65XvLUXaRUXOeZoo1R05L1UQlpkITQSN7vJCPRAyRZO3t0t/0j9/KyZDQeBuV701vtjr5pDBOI+ES0x01XdUSu6gFyZCUFU6iQ5hfnynqUFeoq/R98oXZuMSGjEQceyAEg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nzfHtLMX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nzfHtLMX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B2F62117E;
	Sat, 11 Jan 2025 10:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnU4d7Izn+4DeNhvW6krRvCgFdgjzxTBACxZHh+ndG4=;
	b=nzfHtLMXenOct6ksvMt43dIi+HTUPgW10O18UsnPwuvMvrbn63ZJL2iS0umG+hxMibyV1h
	fpqor2JP+w+Z83KvRocn3i/jFyuCXrILTH437w90empiFPaycvEtxOi40ELlEHo/BZfVOz
	7mGqXg9Dd2ahWW+FHkzsJOdCdbpMIR4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RnU4d7Izn+4DeNhvW6krRvCgFdgjzxTBACxZHh+ndG4=;
	b=nzfHtLMXenOct6ksvMt43dIi+HTUPgW10O18UsnPwuvMvrbn63ZJL2iS0umG+hxMibyV1h
	fpqor2JP+w+Z83KvRocn3i/jFyuCXrILTH437w90empiFPaycvEtxOi40ELlEHo/BZfVOz
	7mGqXg9Dd2ahWW+FHkzsJOdCdbpMIR4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B1F9139AB;
	Sat, 11 Jan 2025 10:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oEpeB3pLgmdCLgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 Jan 2025 10:44:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v4 03/10] btrfs: fix the error handling of submit_uncompressed_range()
Date: Sat, 11 Jan 2025 21:13:37 +1030
Message-ID: <f7c15ae69c59981cc94489faae7cae535ffa1505.1736591758.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736591758.git.wqu@suse.com>
References: <cover.1736591758.git.wqu@suse.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
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
index 85e36dbe1e1f..c23993cb7bdc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1128,19 +1128,11 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
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


