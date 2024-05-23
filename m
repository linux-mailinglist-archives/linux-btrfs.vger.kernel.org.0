Return-Path: <linux-btrfs+bounces-5223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E88F8CCA56
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 03:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FD5282869
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 01:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27AC4A2F;
	Thu, 23 May 2024 01:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T96V7cGE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T96V7cGE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730BED8
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716427204; cv=none; b=XHDwRy3iV2cI5EbQYUmsGWnBIZG2cGYtYZ/DvgkyzuEnSF0ZQdgpz6neeo1q2c5oWq6iVHdSv5M0IWFco5VUpXkKjyFjtY5JAKa6VDy+hf+RQsvwSoDRSmlOCCU7Nek7JVjyJYyH6hzLUWqiOM2HGzkAZCQZxclWwtQ+YZR26U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716427204; c=relaxed/simple;
	bh=RURQDYux888r6aWGwcLanPKNl80+tOW41ac6zDQL+pM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkIrv51mIooIe8lZZ8qCQ8ZKR8bN1zhXvY6sTMuOeNM2OZPSkDODF/pXH+3r0rc3nAKNvJvBEvhT5desRBD1m5TBL1WDhjmvaiJzk7fmLf7n0QRCAgWqMYfc7wp9FAMOmuWycTwPmhy1ZP0/bBfYEmeopJ8cQwWGKJ5THwMPsuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T96V7cGE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T96V7cGE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1266821E27
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716427199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VNVUsmRx6OQhLFTAvizgW16Vujdvv8Hy8uCQ8WMo/E=;
	b=T96V7cGEkljwh9Feh8yZWMq4+Dk807bmhGfADeoPhx8CoiCUmu/Uj2zL6uVJ7ZE8IF294h
	dN5CvaS/kgXhDpF69gKTBBajIADxgfAhOc4J2y1itVGf/8MnvDD+MbuNPIYarr+SEKvJwR
	0Bf9aPV+HR3YMH7jmpGsnTD2nsrXIqA=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=T96V7cGE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716427199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VNVUsmRx6OQhLFTAvizgW16Vujdvv8Hy8uCQ8WMo/E=;
	b=T96V7cGEkljwh9Feh8yZWMq4+Dk807bmhGfADeoPhx8CoiCUmu/Uj2zL6uVJ7ZE8IF294h
	dN5CvaS/kgXhDpF69gKTBBajIADxgfAhOc4J2y1itVGf/8MnvDD+MbuNPIYarr+SEKvJwR
	0Bf9aPV+HR3YMH7jmpGsnTD2nsrXIqA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2024E13A25
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBw6Mb2ZTmYDJwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:19:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs: move extent_range_clear_dirty_for_io() into inode.c
Date: Thu, 23 May 2024 10:49:37 +0930
Message-ID: <6716c0d1d29bb197a72b59fbbc167571afb4c04d.1716427131.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716427131.git.wqu@suse.com>
References: <cover.1716427131.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1266821E27
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

The function is only utilized inside inode.c by compress_file_range(),
so move it to inode.c and unexport it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 15 ---------------
 fs/btrfs/extent_io.h |  1 -
 fs/btrfs/inode.c     | 15 +++++++++++++++
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7275bd919a3e..4af16c09dd88 100644
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
index 000809e16aba..99be256f4f0e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -890,6 +890,21 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 		btrfs_add_inode_defrag(NULL, inode, small_write);
 }
 
+static void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
+{
+	unsigned long index = start >> PAGE_SHIFT;
+	unsigned long end_index = end >> PAGE_SHIFT;
+	struct page *page;
+
+	while (index <= end_index) {
+		page = find_get_page(inode->i_mapping, index);
+		BUG_ON(!page); /* Pages should be in the extent_io_tree */
+		clear_page_dirty_for_io(page);
+		put_page(page);
+		index++;
+	}
+}
+
 /*
  * Work queue call back to started compression on a file and pages.
  *
-- 
2.45.1


