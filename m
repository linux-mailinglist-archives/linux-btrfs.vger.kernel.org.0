Return-Path: <linux-btrfs+bounces-7581-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D1E96198C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF70A1F24713
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D23B1D365F;
	Tue, 27 Aug 2024 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GdqobX3u";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GdqobX3u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AA1D4143
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795728; cv=none; b=ner3fpvPvhmrxdNHpdTx77T3L3NF93l3uCoPKmatiqQbH58NXp5c9LPyCDhwBIRDADbetqb9OsP0IECRRIqUdF9RqNIXmEzAhDhXAe+Eapf5pyVBPRFC08xsN8TAHjzivp/thrTeAL7/uZecZ5QT/1onfI051oSHq3x/Jj306B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795728; c=relaxed/simple;
	bh=Gj8Gh9/U8nnHTENtQKlF5acPip6j+MuTXs5ci9NW9Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vANtj0yet2K2jKMrUMmgI4m4nHX2emuEnzZaoJ6m7BzD7DdIpVhDDmFNSX63984sYoRH5QEVAyTW70BMa1zLNuzC672Uf0S3Uj7nr2Mjx6cuyASelmTZR4k3do3VWkP5klWQHRbw6bvLvXoOglw4q9zFQ1rlb7Lr+0XamHkfvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GdqobX3u; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GdqobX3u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B818521B2E;
	Tue, 27 Aug 2024 21:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7I4ifNJqBFLag5IALgFc9HvTIgkAWz8f1uMHCLiPtn4=;
	b=GdqobX3ua3vjX8ctFjt6M9h6mpZPAb04WOeGwr0N6JbnbCmAqZeq78tiilKBaYtbiyvOYC
	tv+lWwM8NzyRk1AUWYNNF83W8zNLHOmvfktmfkcsk/dJ24Tn7u220CSwPDXr5C00YBcV3b
	UniVuebr8b0iAPsjYpnTKRfB1NlxVmk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GdqobX3u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7I4ifNJqBFLag5IALgFc9HvTIgkAWz8f1uMHCLiPtn4=;
	b=GdqobX3ua3vjX8ctFjt6M9h6mpZPAb04WOeGwr0N6JbnbCmAqZeq78tiilKBaYtbiyvOYC
	tv+lWwM8NzyRk1AUWYNNF83W8zNLHOmvfktmfkcsk/dJ24Tn7u220CSwPDXr5C00YBcV3b
	UniVuebr8b0iAPsjYpnTKRfB1NlxVmk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0D3713A20;
	Tue, 27 Aug 2024 21:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ChcoK0xLzmZjGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/12] btrfs: rename __extent_writepage() and drop double underscores
Date: Tue, 27 Aug 2024 23:55:24 +0200
Message-ID: <b25cd754513ac17c7e8906e6722b4b16926e20e2.1724795624.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724795623.git.dsterba@suse.com>
References: <cover.1724795623.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B818521B2E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The function does not follow the pattern where the underscores would be
justified, so rename it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c         | 28 ++++++++++++++--------------
 fs/btrfs/inode.c             |  2 +-
 fs/btrfs/subpage.c           |  4 ++--
 include/trace/events/btrfs.h |  2 +-
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8de6d226475d..f7a388529c17 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1177,7 +1177,7 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 }
 
 /*
- * helper for __extent_writepage, doing all of the delayed allocation setup.
+ * helper for extent_writepage(), doing all of the delayed allocation setup.
  *
  * This returns 1 if btrfs_run_delalloc_range function did all the work required
  * to write the page (copy into inline extent).  In this case the IO has
@@ -1398,18 +1398,18 @@ static int submit_one_sector(struct btrfs_inode *inode,
 }
 
 /*
- * helper for __extent_writepage.  This calls the writepage start hooks,
+ * Helper for extent_writepage().  This calls the writepage start hooks,
  * and does the loop to map the page into extents and bios.
  *
  * We return 1 if the IO is started and the page is unlocked,
  * 0 if all went well (page still locked)
  * < 0 if there were errors (page still locked)
  */
-static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
-						    struct folio *folio,
-						    u64 start, u32 len,
-						    struct btrfs_bio_ctrl *bio_ctrl,
-						    loff_t i_size)
+static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
+						  struct folio *folio,
+						  u64 start, u32 len,
+						  struct btrfs_bio_ctrl *bio_ctrl,
+						  loff_t i_size)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long range_bitmap = 0;
@@ -1500,7 +1500,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
  * Return 0 if everything goes well.
  * Return <0 for error.
  */
-static int __extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl)
+static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct inode *inode = folio->mapping->host;
 	const u64 page_start = folio_pos(folio);
@@ -1509,7 +1509,7 @@ static int __extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ct
 	loff_t i_size = i_size_read(inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
 
-	trace___extent_writepage(folio, inode, bio_ctrl->wbc);
+	trace_extent_writepage(folio, inode, bio_ctrl->wbc);
 
 	WARN_ON(!folio_test_locked(folio));
 
@@ -1534,8 +1534,8 @@ static int __extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ct
 	if (ret)
 		goto done;
 
-	ret = __extent_writepage_io(BTRFS_I(inode), folio, folio_pos(folio),
-				    PAGE_SIZE, bio_ctrl, i_size);
+	ret = extent_writepage_io(BTRFS_I(inode), folio, folio_pos(folio),
+				  PAGE_SIZE, bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
 
@@ -2202,7 +2202,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 
-			ret = __extent_writepage(folio, bio_ctrl);
+			ret = extent_writepage(folio, bio_ctrl);
 			if (ret < 0) {
 				done = 1;
 				break;
@@ -2293,8 +2293,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		if (pages_dirty && folio != locked_folio)
 			ASSERT(folio_test_dirty(folio));
 
-		ret = __extent_writepage_io(BTRFS_I(inode), folio, cur, cur_len,
-					    &bio_ctrl, i_size);
+		ret = extent_writepage_io(BTRFS_I(inode), folio, cur, cur_len,
+					  &bio_ctrl, i_size);
 		if (ret == 1)
 			goto next_page;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7dffe241dd15..9a81516e074a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -747,7 +747,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode,
 	/*
 	 * In the successful case (ret == 0 here), cow_file_range will return 1.
 	 *
-	 * Quite a bit further up the callstack in __extent_writepage, ret == 1
+	 * Quite a bit further up the callstack in extent_writepage(), ret == 1
 	 * is treated as a short circuited success and does not unlock the folio,
 	 * so we must do it here.
 	 *
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 272cece50dd0..663f2f953a65 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -705,7 +705,7 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
  * - Page locked by plain lock_page()
  *   It should not have any subpage::writers count.
  *   Can be unlocked by unlock_page().
- *   This is the most common locked page for __extent_writepage() called
+ *   This is the most common locked page for extent_writepage() called
  *   inside extent_write_cache_pages().
  *   Rarer cases include the @locked_page from extent_write_locked_range().
  *
@@ -829,7 +829,7 @@ bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
  * Unlike btrfs_folio_end_writer_lock() which unlocks a specified subpage range,
  * this ends all writer locked ranges of a page.
  *
- * This is for the locked page of __extent_writepage(), as the locked page
+ * This is for the locked page of extent_writepage(), as the locked page
  * can contain several locked subpage ranges.
  */
 void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info, struct folio *folio)
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0eddbb8b6728..e4add61e00f1 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -721,7 +721,7 @@ DECLARE_EVENT_CLASS(btrfs__writepage,
 		  __entry->writeback_index)
 );
 
-DEFINE_EVENT(btrfs__writepage, __extent_writepage,
+DEFINE_EVENT(btrfs__writepage, extent_writepage,
 
 	TP_PROTO(const struct folio *folio, const struct inode *inode,
 		 const struct writeback_control *wbc),
-- 
2.45.0


