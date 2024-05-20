Return-Path: <linux-btrfs+bounces-5098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739898C988A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 05:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC251C20CB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 03:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1494110A24;
	Mon, 20 May 2024 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="icw23Vs0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="icw23Vs0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23CB666
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716177385; cv=none; b=bPFIr9xHrGmqJzN287eqZcPnuQwsRjxGdfouCr2hA8Ltn3cQQcpmhBLMY9kAcO99r2ze/f7B9K6sg3sWKcROG48t80QBM3IKnQZM+uxD7/kVTo2pnOmLaNep+ZpvC5bigJSVTMLU9LBkTKKhPt/YkTew8cYG7L9qT2V1Wh/+9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716177385; c=relaxed/simple;
	bh=dUCX9PyBjnWHpQNOVvT03SYs/nzgrZMPzbk00T5l4Sk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WlDOF2vYLetLp2AbzmDMfIGtCi6WXIietIX4geOFdfwGqKYurPqX272zMi2+SDAszF1GrY98M2jgUnZOxO/HS+/9WBybu4LuNH4yPjazMxtqKdGW6rYiAkvGv2NxqoGiMkaKsD2Qhw3bkX7+hU5ap/jq3ZcLUolEA4fwk2+4RX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=icw23Vs0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=icw23Vs0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 191A220112
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 03:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716177381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tRwXgbM1EdTlj7Jum+paqgY4K0uSuPuhiPYThlG3mdI=;
	b=icw23Vs0eTFPHlbG+slFb9EBN8E4cOIpBvX6wJuQGZqCYLCwqXtNS8qnOJZDN0/+9a8WKJ
	FSLQ//7yGk0GA3OuomGDqAdupJXdRlNYJD8IPIdPLfFMwcb5f0NptmNMOAc0FwMCVXzRzV
	S2Ne1rwzcX8J6N31+ba/BT6i3ILE6+w=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=icw23Vs0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716177381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tRwXgbM1EdTlj7Jum+paqgY4K0uSuPuhiPYThlG3mdI=;
	b=icw23Vs0eTFPHlbG+slFb9EBN8E4cOIpBvX6wJuQGZqCYLCwqXtNS8qnOJZDN0/+9a8WKJ
	FSLQ//7yGk0GA3OuomGDqAdupJXdRlNYJD8IPIdPLfFMwcb5f0NptmNMOAc0FwMCVXzRzV
	S2Ne1rwzcX8J6N31+ba/BT6i3ILE6+w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2908E1378C
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 03:56:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7ebJM+PJSmbEPAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 03:56:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: enhance function extent_range_clear_dirty_for_io()
Date: Mon, 20 May 2024 13:25:57 +0930
Message-ID: <31b95191f9f1c8aa600370b70a77d69ebfd30bd3.1716177342.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 191A220112
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

Enhance that function by:

- Moving it to inode.c
  As there is only one user inside compress_file_range(), there is no
  need to export it through extent_io.h.

- Add extra error handling
  Previously we go BUG_ON() if we can not find a page inside the range.
  Now we downgrade it to ASSERT(), as this really means some logic
  error since we should have all the pages locked already.

- Make it subpage compatible
  Although currently compression only happens in a full page basis even
  for subpage routine, there is no harm to make it subpage compatible
  now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 15 ---------------
 fs/btrfs/extent_io.h |  1 -
 fs/btrfs/inode.c     | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a8fc0fcfa69f..9a6f369945c6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -164,21 +164,6 @@ void __cold extent_buffer_free_cachep(void)
 	kmem_cache_destroy(extent_buffer_cache);
 }
 
-void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
-{
-	unsigned long index = start >> PAGE_SHIFT;
-	unsigned long end_index = end >> PAGE_SHIFT;
-	struct page *page;
-
-	while (index <= end_index) {
-		page = find_get_page(inode->i_mapping, index);
-		BUG_ON(!page); /* Pages should be in the extent_io_tree */
-		clear_page_dirty_for_io(page);
-		put_page(page);
-		index++;
-	}
-}
-
 static void process_one_page(struct btrfs_fs_info *fs_info,
 			     struct page *page, struct page *locked_page,
 			     unsigned long page_ops, u64 start, u64 end)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index dca6b12769ec..7c2f1bbc6b67 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -350,7 +350,6 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 void set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
-void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct page *locked_page,
 				  struct extent_state **cached,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 000809e16aba..541a719284a9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -890,6 +890,32 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 		btrfs_add_inode_defrag(NULL, inode, small_write);
 }
 
+static int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
+{
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	const u64 len = end + 1 - start;
+	unsigned long end_index = end >> PAGE_SHIFT;
+	bool missing_folio = false;
+
+	/* We should not have such large range. */
+	ASSERT(len < U32_MAX);
+	for (unsigned long index = start >> PAGE_SHIFT;
+	     index <= end_index; index++) {
+		struct folio *folio;
+
+		folio = filemap_get_folio(inode->i_mapping, index);
+		if (IS_ERR(folio)) {
+			missing_folio = true;
+			continue;
+		}
+		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
+		folio_put(folio);
+	}
+	if (missing_folio)
+		return -ENOENT;
+	return 0;
+}
+
 /*
  * Work queue call back to started compression on a file and pages.
  *
@@ -931,7 +957,10 @@ static void compress_file_range(struct btrfs_work *work)
 	 * Otherwise applications with the file mmap'd can wander in and change
 	 * the page contents while we are compressing them.
 	 */
-	extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
+	ret = extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
+
+	/* We have locked all the involved pagse, shouldn't hit a missing page. */
+	ASSERT(ret == 0);
 
 	/*
 	 * We need to save i_size before now because it could change in between
-- 
2.45.1


