Return-Path: <linux-btrfs+bounces-11130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F12A21841
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 08:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05995164F4F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 07:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317FB19D072;
	Wed, 29 Jan 2025 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oF5f67em";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oF5f67em"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60B198A19
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136280; cv=none; b=XdXbTNfWFEq3ZBT5tWSvNmIsCEK3WpU4lF1J7RnY3UzbjB8CQWjbsXO0Uz3vOjJN1FmUv2XqlL6QajS7gqtz4XQ6oNtODD1MnCJP3wTuLQr9PBrzCrj1bpI/JEYrFG21c0XyUaq8ihQRGC+dMbNn58upfJjI2bRBNxFh0X6ZjQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136280; c=relaxed/simple;
	bh=TUfMmudAjvpWFSx7ShC+4whB75QOE9WlYAp1XAwY/n8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hh+MzbVLJPwST7NBP/+7y5dRol5jcazZSrzvECVR+16I0xl5Pjn6TATKZOuEYgIzeN4iYh6iFud0Cy7zTGHjn5lx1UZluErqWk6Yqnw5zkD+auUideoekeOcLoebgnLlEtFQmqRPtjgbdwnIv7+YWcnlICSrIbXF9Dg/enoFHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oF5f67em; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oF5f67em; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9065A1F365
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+o03TWCKFCVZbDNy5FOhBrMMpFQfCtU9ARAhDmXLAQc=;
	b=oF5f67empmR1zzWGmSK7BgNdg+WhTU0gYNI1C/Ki7irnuQrz+lQQoUC47ZuUT08JhbeMmo
	HPP7gW9qoq/Bui2EEaKXh9j+91DUSA/rOHWFmQW3mF472H06joPyP+SZAcgOVOt48LoS4y
	SmTE6EJR6D8iMGw3N0HKlr6daVTzJBQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oF5f67em
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+o03TWCKFCVZbDNy5FOhBrMMpFQfCtU9ARAhDmXLAQc=;
	b=oF5f67empmR1zzWGmSK7BgNdg+WhTU0gYNI1C/Ki7irnuQrz+lQQoUC47ZuUT08JhbeMmo
	HPP7gW9qoq/Bui2EEaKXh9j+91DUSA/rOHWFmQW3mF472H06joPyP+SZAcgOVOt48LoS4y
	SmTE6EJR6D8iMGw3N0HKlr6daVTzJBQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC1A5137DB
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qDblHdPamWdBKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: simplify btrfs_clear_buffer_dirty()
Date: Wed, 29 Jan 2025 18:07:20 +1030
Message-ID: <9d46f48d978dd85977e3e67bcfc74574ac448333.1738127135.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 9065A1F365
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The function btrfs_clear_buffer_dirty() is called on dirty extent buffer
that will not be written back.

In that case, we call btrfs_clear_buffer_dirty() to manually clear the
PAGECACHE_TAG_DIRTY flag.

But PAGECACHE_TAG_DIRTY is normally cleared by folio_start_writeback()
if the page is no longer dirty.
And for data folios if we need to clear dirty flag for similar folios,
we just call folio_start_writeback() then followed by
folio_end_writeback() immediately.

So here we can simplify the function by:

- Use the newly introduced btrfs_meta_folio_clear_dirty() helper
  So we do not need to handle subpage metadata separately.

- Call btrfs_meta_folio_set/clear_writeback() to clear PAGECACHE_TAG_DIRTY
  Instead of manually clear the tag for the folio.

- Update the comment inside set_extent_buffer_dirty()
  As there is no separate clear_subpage_extent_buffer_dirty() anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 45 ++++++++++----------------------------------
 1 file changed, 10 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8da1da43aa74..e4261dce2e31 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3319,38 +3319,11 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
 	release_extent_buffer(eb);
 }
 
-static void btree_clear_folio_dirty(struct folio *folio)
-{
-	ASSERT(folio_test_dirty(folio));
-	ASSERT(folio_test_locked(folio));
-	folio_clear_dirty_for_io(folio);
-	xa_lock_irq(&folio->mapping->i_pages);
-	if (!folio_test_dirty(folio))
-		__xa_clear_mark(&folio->mapping->i_pages,
-				folio_index(folio), PAGECACHE_TAG_DIRTY);
-	xa_unlock_irq(&folio->mapping->i_pages);
-}
-
-static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
-{
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct folio *folio = eb->folios[0];
-	bool last;
-
-	/* btree_clear_folio_dirty() needs page locked. */
-	folio_lock(folio);
-	last = btrfs_subpage_clear_and_test_dirty(fs_info, folio, eb->start, eb->len);
-	if (last)
-		btree_clear_folio_dirty(folio);
-	folio_unlock(folio);
-	WARN_ON(atomic_read(&eb->refs) == 0);
-}
-
 void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 			      struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int num_folios;
+	const int num_folios = num_extent_folios(eb);
 
 	btrfs_assert_tree_write_locked(eb);
 
@@ -3377,17 +3350,19 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
 				 fs_info->dirty_metadata_batch);
 
-	if (btrfs_meta_is_subpage(fs_info))
-		return clear_subpage_extent_buffer_dirty(eb);
-
-	num_folios = num_extent_folios(eb);
 	for (int i = 0; i < num_folios; i++) {
 		struct folio *folio = eb->folios[i];
 
 		if (!folio_test_dirty(folio))
 			continue;
 		folio_lock(folio);
-		btree_clear_folio_dirty(folio);
+		btrfs_meta_folio_clear_dirty(fs_info, folio, eb->start, eb->len);
+		/*
+		 * The set and clear writeback is to properly clear
+		 * PAGECACHE_TAG_DIRTY.
+		 */
+		btrfs_meta_folio_set_writeback(fs_info, folio, eb->start, eb->len);
+		btrfs_meta_folio_clear_writeback(fs_info, folio, eb->start, eb->len);
 		folio_unlock(folio);
 	}
 	WARN_ON(atomic_read(&eb->refs) == 0);
@@ -3412,12 +3387,12 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 
 		/*
 		 * For subpage case, we can have other extent buffers in the
-		 * same page, and in clear_subpage_extent_buffer_dirty() we
+		 * same page, and in clear_extent_buffer_dirty() we
 		 * have to clear page dirty without subpage lock held.
 		 * This can cause race where our page gets dirty cleared after
 		 * we just set it.
 		 *
-		 * Thankfully, clear_subpage_extent_buffer_dirty() has locked
+		 * Thankfully, clear_extent_buffer_dirty() has locked
 		 * its page for other reasons, we can use page lock to prevent
 		 * the above race.
 		 */
-- 
2.48.1


