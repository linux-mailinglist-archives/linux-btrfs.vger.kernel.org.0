Return-Path: <linux-btrfs+bounces-11131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D6BA21842
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 08:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9723A355F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 07:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D5D199239;
	Wed, 29 Jan 2025 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qMOfMUTt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZsPtgU73"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18501990A2
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136281; cv=none; b=ZUxeHC3e3+9Bw9luI8yTuycxHKU6QSyCEa/9sAbo7lS8tOiA8QkLzkf8kGdbinK3xxAByO2F61CHKiEARRTXSgro3DfDkZlJpgy0ydOVUaUDJYDNjzfeRyMj2dIrMVEgYNGrZhBSZKUljKLzPD6bKJSr57rPSz5tiQ5cbGw6zW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136281; c=relaxed/simple;
	bh=dAFP/v+POhsIAG8Hsle2fIMFvtxdQWlNEQfgEGDw2E4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lIcyy5TxJ3DvPrsNkMHhbSQ2bjiirYU9fZftQEIZnOn9bf1hd/DMcKVK5/PZz/2Rxr0Fdb3BO6tIuIwMzAT9JGUCF4hwfrdp1b/qc1hHA1XEKmDKkYK5k20vEPzsjLvbgBilDGVheTjdULr7hJvA10U77mc708Q6eoFVVButEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qMOfMUTt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZsPtgU73; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2DD81F383
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeFkc2sueviQtb4Sobox9Rjh24hPzhPPMJVIhMLpaV0=;
	b=qMOfMUTt31ib1vltqb+W6McXm4tVcdyoC2a11RKlOExAGMhLhdCP8uNqzfGq6nd2iijgKu
	FlA9d7Z0K+ZJikRrQEpnB3y5Z7HlyB45pK+lT3jmC559Uh5p+o31WwSoni2iuOsahWenfo
	ndSHBzbrPKeiVCzwKA56/B4dnOO6WUU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ZsPtgU73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeFkc2sueviQtb4Sobox9Rjh24hPzhPPMJVIhMLpaV0=;
	b=ZsPtgU732uhJChsYjeCm8CUxqzFY0oqW80chMrEtferg32EM3LUdOjfLzCDvnvPCw6/D1n
	MLMxyH0wA+qG6VQgMBpHa690RmRee/60lgLJ7ixNVzfR93gLiZlc4QYnqTjIp9SLeOHzvI
	oTuhBHRG6uspnCoEUSJyymIz57J1ehw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19F37137DB
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wIoFMtTamWdBKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: simplify write_one_eb()
Date: Wed, 29 Jan 2025 18:07:21 +1030
Message-ID: <9c27421d4eec80b4383459071d9d4ee34de7d121.1738127135.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738127135.git.wqu@suse.com>
References: <cover.1738127135.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2DD81F383
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently inside write_one_eb() we have two different handling for
subpage and regular metadata.

The differences are:

- Extra offset/length calculation when adding the folio range to bio for
  subpage cases
- Only decrease wbc->nr_to_write if the whole page is no longer dirty
  for subpage cases
- Use subpage helper for subpage cases

Merge those different handlings into a shared one by:

- Always calculate the to-be-queued range
  So that bio_add_folio() can use the same calculated resulted length
  and offset for both cases.

- Use btrfs_meta_folio_clear_dirty() and
  btrfs_meta_folio_set_writeback() helpers
  This will cover both cases.

- Only decrease wbc->nr_to_write if the folio is no longer dirty
  Since we have the folio locked, no one else can modify the folio dirty
  flags (set_extent_buffer_dirty() will also lock the folio for subpage
  cases).

  Thus after our btrfs_meta_folio_clear_dirty() call, if the whole folio
  is no longer dirty, we're submitting the last dirty eb of the folio,
  and can decrease wbc->nr_to_write properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e4261dce2e31..e68cf0542f2d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1774,6 +1774,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_bio *bbio;
+	const int num_folios = num_extent_folios(eb);
 
 	prepare_eb_write(eb);
 
@@ -1785,38 +1786,21 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	wbc_init_bio(wbc, &bbio->bio);
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
-	if (btrfs_meta_is_subpage(fs_info)) {
-		struct folio *folio = eb->folios[0];
-		bool ret;
+	for (int i = 0; i < num_folios; i++) {
+		struct folio *folio = eb->folios[i];
+		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
+		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
+				      eb->start + eb->len) - range_start;
 
 		folio_lock(folio);
-		btrfs_subpage_set_writeback(fs_info, folio, eb->start, eb->len);
-		if (btrfs_subpage_clear_and_test_dirty(fs_info, folio, eb->start,
-						       eb->len)) {
-			folio_clear_dirty_for_io(folio);
-			wbc->nr_to_write--;
-		}
-		ret = bio_add_folio(&bbio->bio, folio, eb->len,
-				    eb->start - folio_pos(folio));
-		ASSERT(ret);
-		wbc_account_cgroup_owner(wbc, folio, eb->len);
-		folio_unlock(folio);
-	} else {
-		int num_folios = num_extent_folios(eb);
-
-		for (int i = 0; i < num_folios; i++) {
-			struct folio *folio = eb->folios[i];
-			bool ret;
-
-			folio_lock(folio);
-			folio_clear_dirty_for_io(folio);
-			folio_start_writeback(folio);
-			ret = bio_add_folio(&bbio->bio, folio, eb->folio_size, 0);
-			ASSERT(ret);
-			wbc_account_cgroup_owner(wbc, folio, eb->folio_size);
+		btrfs_meta_folio_clear_dirty(fs_info, folio, eb->start, eb->len);
+		btrfs_meta_folio_set_writeback(fs_info, folio, eb->start, eb->len);
+		if (!folio_test_dirty(folio))
 			wbc->nr_to_write -= folio_nr_pages(folio);
-			folio_unlock(folio);
-		}
+		bio_add_folio_nofail(&bbio->bio, folio, range_len,
+				     offset_in_folio(folio, range_start));
+		wbc_account_cgroup_owner(wbc, folio, range_len);
+		folio_unlock(folio);
 	}
 	btrfs_submit_bbio(bbio, 0);
 }
-- 
2.48.1


