Return-Path: <linux-btrfs+bounces-7918-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715E974671
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 01:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF91C2596F
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 23:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A618C1AC43B;
	Tue, 10 Sep 2024 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B831yW/4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B831yW/4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D01A76C7
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 23:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011576; cv=none; b=N2nZ2+zHpMq6xE8CeSPHEVUE1d/WXeYVT5B/yeOF753mkt8uvgVn7DjcLQIg7JziA8c/BcGctGz0ugGoV56Uu7Kz7Sj+Gw463otSS/BKs727AxVYNY+KxHOm8fhFH+lADUmC3y6hv93efm/SF4O+J9ow1gPWj+7GypU/gMdgZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011576; c=relaxed/simple;
	bh=cfAUN2OJwJAcfLS3d4dcX0yTFggi9WNBTfV1Jbm/59A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S+n6M9JwRjexFnKfrC8j2BC3RCsaWEf6d+yWMIHg1F0bs0kftRF6MKsdiDyRmvAgKxRAWJO/5bHu6akx7yGGJC33apU4uurhxg2CdZUEcaOehnBJr0VcnTP7V846X5mMevowhkwXTaC843HoewIvXCS4veQbRd3T2XStgD4yRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B831yW/4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B831yW/4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6713321A56
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 23:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726011572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3rIE1XWoupHoJa20fhxea5ygi+MMPRyJktLi1qmIZxc=;
	b=B831yW/4tfEnjSqa727ADKgQjzMQzvTFv7Cld+C/nMhJrUY+l21LqEE11ks5C0uS/Rr5aQ
	H3F9z770SI+qSXCGoP9LnH01/1TDnyAKo8TlpZc4WAp0Nd0sUHxCDtkSgCcD/PdDqxIjjZ
	LvwYBxZxwegBvPhB+WOvBVy0UGE6dcY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="B831yW/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726011572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3rIE1XWoupHoJa20fhxea5ygi+MMPRyJktLi1qmIZxc=;
	b=B831yW/4tfEnjSqa727ADKgQjzMQzvTFv7Cld+C/nMhJrUY+l21LqEE11ks5C0uS/Rr5aQ
	H3F9z770SI+qSXCGoP9LnH01/1TDnyAKo8TlpZc4WAp0Nd0sUHxCDtkSgCcD/PdDqxIjjZ
	LvwYBxZxwegBvPhB+WOvBVy0UGE6dcY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BCAE13A3A
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 23:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0lrRF7PY4GYlTQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 23:39:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: wait for writeback if sector size is smaller than page size
Date: Wed, 11 Sep 2024 09:09:05 +0930
Message-ID: <39b20c5e65df079ad99aa06ec7f70f164a541c09.1726011483.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6713321A56
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

[PROBLEM]
If sector perfect compression is enabled for sector size < page size
case, the following case can lead dirty ranges not being written back:

     0     32K     64K     96K     128K
     |     |///////||//////|     |/|
                                 124K

In above example, the page size is 64K, and we need to write back above
two pages.

- Submit for page 0 (main thread)
  We found delalloc range [32K, 96K), which can be compressed.
  So we queue an async range for [32K, 96K).
  This means, the page unlock/clearing dirty/setting writeback will
  all happen in a workqueue context.

- The compression is done, and compressed range is submitted (workqueue)
  Since the compression is done in asynchronously, the compression can
  be done before the main thread to submit for page 64K.

  Now the whole range [32K, 96K), involving two pages, will be marked
  writeback.

- Submit for page 64K (main thread)
  extent_write_cache_pages() got its wbc->sync_mode is WB_SYNC_NONE,
  so it skips the writeback wait.

  And unlock the page and exit. This means the dirty range [124K, 128K)
  will never be submitted, until next writeback happens for page 64K.

This will never happen for previous kernels because:

- For sector size == page size case
  Since one page is one sector, if a page is marked writeback it will
  not have dirty flags.
  So this corner case will never hit.

- For sector size < page size case
  We never do subpage compression, a range can only be submitted for
  compression if the range is fully page aligned.
  This change makes the subpage behavior mostly the same as non-subpage
  cases.

[ENHANCEMENT]
Instead of relying WB_SYNC_NONE check only, if it's a subpage case, then
always wait for writeback flags.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 385e88b7fcf5..644e00d5b0f8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2116,7 +2116,27 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 
-			if (wbc->sync_mode != WB_SYNC_NONE) {
+			/*
+			 * For subpage case, compression can lead to mixed
+			 * writeback and dirty flags, e.g:
+			 * 0     32K    64K    96K    128K
+			 * |     |//////||/////|   |//|
+			 *
+			 * In above case, [32K, 96K) is asynchronously submitted
+			 * for compression, and [124K, 128K) needs to be written back.
+			 *
+			 * If we didn't wait wrtiteback for page 64K, [128K, 128K)
+			 * won't be submitted as the page still has writeback flag
+			 * and will be skipped in the next check.
+			 *
+			 * This mixed writeback and dirty case is only possible for
+			 * subpage case.
+			 *
+			 * TODO: Remove this check after migrating compression to
+			 * regular submission.
+			 */
+			if (wbc->sync_mode != WB_SYNC_NONE ||
+			    btrfs_is_subpage(inode_to_fs_info(inode), mapping)) {
 				if (folio_test_writeback(folio))
 					submit_write_bio(bio_ctrl, 0);
 				folio_wait_writeback(folio);
-- 
2.46.0


