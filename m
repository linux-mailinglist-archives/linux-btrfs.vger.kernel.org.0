Return-Path: <linux-btrfs+bounces-5218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FFB8CC9D6
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 01:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4CFB21FF1
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 23:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA4614D290;
	Wed, 22 May 2024 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ARN7Uysw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ARN7Uysw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28B7F7D3
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421696; cv=none; b=n0ApDjFsSzTusG2BQNYbeqCxZDj2CzixbdID45jpiRMzsJlr102nbPm8dXHM9AMMN4cj4XpKAXZul443WJw6YBxIMHBTtXSngVWXSDvN9WqrNRkuCzw72Kn1eEmgSemP+ZaTNhQGbPU9s/joFw7/AuMfa2L9y8dQSMIrpLjP1p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421696; c=relaxed/simple;
	bh=RURQDYux888r6aWGwcLanPKNl80+tOW41ac6zDQL+pM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slv2jnkiKr9oQQQeZB284HeAo7wSLwoQLdO3hbjruw3duAFzGLjQZCeUBy6aZmhCQTQopampa8d7ab9FNxosz/qLhxikAxPXB6welRNNar3vZH4u7m4+BhcK7q4sUKGXJrC+W3YXe6RAS7NN4VS/zUueBgGf3IUihg1r+G4xKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ARN7Uysw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ARN7Uysw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2B3121A58
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716421691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VNVUsmRx6OQhLFTAvizgW16Vujdvv8Hy8uCQ8WMo/E=;
	b=ARN7Uyswk5B8UTzlE66GExaMRvrXYtW15N/ikNFn/G6sHWCAzYjQsG4RbF1C7ReFZWabQP
	bPfQEh0hDqUuwbfUs4MoREBMKyLiKe7PaegX+vDd7V6dEO4CCTEQN3ayqt8b+aA2SsH2qg
	NtIcvuwnK8u6IHQjBa8BLeCSHzcK/4s=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716421691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VNVUsmRx6OQhLFTAvizgW16Vujdvv8Hy8uCQ8WMo/E=;
	b=ARN7Uyswk5B8UTzlE66GExaMRvrXYtW15N/ikNFn/G6sHWCAzYjQsG4RbF1C7ReFZWabQP
	bPfQEh0hDqUuwbfUs4MoREBMKyLiKe7PaegX+vDd7V6dEO4CCTEQN3ayqt8b+aA2SsH2qg
	NtIcvuwnK8u6IHQjBa8BLeCSHzcK/4s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1F0B13A1E
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MK3dJjqETmb6aQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: move extent_range_clear_dirty_for_io() into inode.c
Date: Thu, 23 May 2024 09:17:45 +0930
Message-ID: <6716c0d1d29bb197a72b59fbbc167571afb4c04d.1716421534.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716421534.git.wqu@suse.com>
References: <cover.1716421534.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

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


