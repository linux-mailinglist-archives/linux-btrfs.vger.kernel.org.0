Return-Path: <linux-btrfs+bounces-11340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548E7A2BA3B
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 05:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF627A3836
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 04:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62434233D90;
	Fri,  7 Feb 2025 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dAfC28ku";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dAfC28ku"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE523314E
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902398; cv=none; b=WQ3xy47jm5jKnzJKYOgqqWQkv7zWpc2AeYN3zxqT/mHMaeWaAI/S2+W6qyXH+A3PNi83NH2Wyj/Q+yhWWt7LjG+BsAWojIy2fDk1jENQ1lnQRRwyDwrrbb/XbTLEfFCMD6jhxBJ0A8UcXDaHDCH9hAz8VPvDde/JbeCiOi8VRQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902398; c=relaxed/simple;
	bh=LLQo5Q3FSt6Be5QdVT/zuNYoQJN5zpWMou6Fm5RUdw8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPXXvDE6zMY5ATINd8bD+TVdtpg2jPkeec21tdqFqOo6q41BM2zZoqHvgE3viJV0uoLtcfuYEOzUi3N035zX/2A4RWUGTwQdVT8laffrqDKG71dQkWKRPuUQFyKzXhaGR5/Vd+NyMyzdi9olRPl9po2rJ5k96rEDD70IBuXIUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dAfC28ku; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dAfC28ku; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC64E1F397
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HmETMxeomyLOb+wCycQ+kKJthQiRmcVCRKY+k7PlmA=;
	b=dAfC28ku+CKJ+HQVibbR8yDM/MdeMlvztJ49uJaNFoBMSTl0TQOlnO5IwbSnyUeAcg1jo7
	QvG5FR5lcjzpz1cE/IE42Xv70CHeu+/8zfygYnGmi8SGr0Qvi1jSCQqw/g5E0bpjRFAfkT
	ZpWKRKs7xoKx1oAupzyfyPtvt3xFRNM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dAfC28ku
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HmETMxeomyLOb+wCycQ+kKJthQiRmcVCRKY+k7PlmA=;
	b=dAfC28ku+CKJ+HQVibbR8yDM/MdeMlvztJ49uJaNFoBMSTl0TQOlnO5IwbSnyUeAcg1jo7
	QvG5FR5lcjzpz1cE/IE42Xv70CHeu+/8zfygYnGmi8SGr0Qvi1jSCQqw/g5E0bpjRFAfkT
	ZpWKRKs7xoKx1oAupzyfyPtvt3xFRNM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0251813806
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YF8eLHmLpWezCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2025 04:26:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/8] btrfs: simplify write_one_eb()
Date: Fri,  7 Feb 2025 14:56:05 +1030
Message-ID: <a6d0412f37c4d78e1dc43e619f543531c08f1730.1738902149.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738902149.git.wqu@suse.com>
References: <cover.1738902149.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CC64E1F397
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
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
index 354dd2522531..b23d27cfdf14 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1786,6 +1786,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_bio *bbio;
+	const int num_folios = num_extent_folios(eb);
 
 	prepare_eb_write(eb);
 
@@ -1797,38 +1798,21 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
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


