Return-Path: <linux-btrfs+bounces-8575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D62799221E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 00:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0831C209C7
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Oct 2024 22:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC7418A94E;
	Sun,  6 Oct 2024 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BI5IQcaT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BI5IQcaT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB31136E3F
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Oct 2024 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728254750; cv=none; b=XarEcFTxP/wrV38rJYcGECGJtOmA43bf12O75zajkwg3cYJCdMD56Ncd4u/41LgrsVIdcmtEFPFPq8eKLkyX6I5cafQGL8yZ2LheNk++XHNgJYy8lBEesXpzcnOdseYa08olVNhpJIpYfnqliLH7RDcT3GmsuCCh4WyBoDcygB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728254750; c=relaxed/simple;
	bh=rx7g/P5JfEOOsPLCpVA8PhmeRX2wAO/YR2HVp9FIqbA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L8w7Zr6eJAVQMjo/uX2mXEaucInYfNq5o19Bz+R+mI0BMw5SglwyvFG3b8wvbqsYvPINP2YG50eHzZ4JtIPrsG5Lf6Xd68Gha2iR50EdS05dSuMcAtULITIH/8wM3s+IxB2zxgQuGcBcsoGiWHE2i2QUin9KEwI9iozWP+/k7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BI5IQcaT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BI5IQcaT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8CE21FCF7
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Oct 2024 22:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728254738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W9CfKDNdHZMkjJXgYHnj+wQtrsfyz+Edm3LILx52a9A=;
	b=BI5IQcaTckzzVTQObEMyk0NudM5Hh76e9l+V0nT3cYk07xj+W47Be4XgUbqgI2hVokasJ0
	gBr++9ZY4dNErvwDT5jZclY6Oez+fT5ROLAq1Zz/VUum9Re0w6BRNBcY1RI8GuxLYcG8I8
	GDPOvR9pVucIuhimwaaSkjViK/gqcZc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728254738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=W9CfKDNdHZMkjJXgYHnj+wQtrsfyz+Edm3LILx52a9A=;
	b=BI5IQcaTckzzVTQObEMyk0NudM5Hh76e9l+V0nT3cYk07xj+W47Be4XgUbqgI2hVokasJ0
	gBr++9ZY4dNErvwDT5jZclY6Oez+fT5ROLAq1Zz/VUum9Re0w6BRNBcY1RI8GuxLYcG8I8
	GDPOvR9pVucIuhimwaaSkjViK/gqcZc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E1E13240
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Oct 2024 22:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hb3OKRETA2c1WwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 06 Oct 2024 22:45:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix the delalloc range locking if sector size < page size
Date: Mon,  7 Oct 2024 09:15:20 +1030
Message-ID: <9abe9f2e7d0c1692fdb6ca07351e05bdf7260d4f.1728254715.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Inside lock_delalloc_folios(), there are several problems related to
sector size < page size handling:

- Set the writer locks without checking if the folio is still valid
  We call btrfs_folio_start_writer_lock() just like it's folio_lock().
  But since the folio may not even be the folio of the current mapping,
  we can easily screw up the folio->private.

- The range is not clampped inside the page
  This means we can over write other bitmaps if the start/len is not
  properly handled, and trigger the btrfs_subpage_assert().

- @processed_end is always rounded up to page end
  If the delalloc range is not page aligned, and we need to retry
  (returning -EAGAIN), then we will unlock to the page end.

  Thankfully this is not a huge problem, as now
  btrfs_folio_end_writer_lock() can handle range larger than the locked
  range, and only unlock what is already locked.

Fix all these problems by:

- Lock and check the folio first, then call
  btrfs_folio_set_writer_lock()
  So that if we got a folio not belonging to the inode, we won't
  touch folio->private.

- Properly truncate the range inside the page

- Update @processed_end to the locked range end

Fixes: 1e1de38792e0 ("btrfs: make process_one_page() to handle subpage locking")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e0b43640849e..0448cee2b983 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -262,22 +262,21 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 
 		for (i = 0; i < found_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
-			u32 len = end + 1 - start;
+			u64 range_start = max_t(u64, folio_pos(folio), start);
+			u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
+					      end + 1) - range_start;
 
 			if (folio == locked_folio)
 				continue;
 
-			if (btrfs_folio_start_writer_lock(fs_info, folio, start,
-							  len))
-				goto out;
-
+			folio_lock(folio);
 			if (!folio_test_dirty(folio) || folio->mapping != mapping) {
-				btrfs_folio_end_writer_lock(fs_info, folio, start,
-							    len);
+				folio_unlock(folio);
 				goto out;
 			}
+			btrfs_folio_set_writer_lock(fs_info, folio, range_start, range_len);
 
-			processed_end = folio_pos(folio) + folio_size(folio) - 1;
+			processed_end = range_start + range_len - 1;
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
-- 
2.46.2


