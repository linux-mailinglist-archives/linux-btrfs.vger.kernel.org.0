Return-Path: <linux-btrfs+bounces-12635-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FB9A740EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 23:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CFF18927BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 22:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB111EF39D;
	Thu, 27 Mar 2025 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JWC4ZiZf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fnv2c+Oh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14611E1DF0
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114703; cv=none; b=AvnF4+o+NN/3t8LCFtI/QIztvwuM/aN+4ss7KUqL8Gu5AWqT3z72VkGseOWjqTkCgxuF1T00IaOhDsyDHDD1CmcoDXz34suLvINLXHwi8QHU1kajwT/ZacGTXLJ/OcCn80gvBfyyEr9/WXPxQruTEnpReaRxSfInimJHX+w1kiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114703; c=relaxed/simple;
	bh=OOumOEtqbyDY1x5ve6jMQ2ZT2Z9us/EhxXN05B8jo1Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLsA6pLxxgzBLhQVnLws7JAB89LLw77L26WTb6I10femfVMga+M8WeQ2JegUW2fMPNB9wdrW3DZM79M2YR5eWoDyCLYccDeD3fsm5TcoisLXWKkisxS2LBcO2wpMhFZ55uSxljR8f1HvO0uu5p7k7EG4QH4lV1OwmX/ihiqukJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JWC4ZiZf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fnv2c+Oh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE215211B3
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743114692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69ig23rLRSNBK/hZgGaBbumMNHNjQuT5Fi2zW0FmmL4=;
	b=JWC4ZiZfa/fyWZnHDvDbwLDlAFRK3l69QVWQfd5uTBfP1xfQgrQNYFJ/i5Y2BNxEacFO86
	z08EClfEYOLtPklltUjGwRuEprpJrpf78bR2lTbfWCrEAwVyMrTuNgxqRZy8012QNAEgc1
	Qrza0qrEp2ogAcNA/UlD2ndDAYdGwGQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fnv2c+Oh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743114691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69ig23rLRSNBK/hZgGaBbumMNHNjQuT5Fi2zW0FmmL4=;
	b=fnv2c+OhQO5CWhKLLZMardkZdOVMQgzaogFzo0suMkqFo8cBDE5SBQBKkFvhQYUpI2Is7m
	Skbfqhd13VcPd+07bVv0qdsRLiU1hNa+8gmNywIqK6Qo4XDiVee4n392+6d8CkESdX/nD3
	rEtDnS/bVYH4DUpSuOFit1F03PDVkMU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31735139D4
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OBsUOcLR5WfMagAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: prepare btrfs_buffered_write() for large data folios
Date: Fri, 28 Mar 2025 09:01:04 +1030
Message-ID: <285fe66e1d13bd9b1aa9b316da12cbaa8cb12c95.1743113694.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743113694.git.wqu@suse.com>
References: <cover.1743113694.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE215211B3
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This involves the following modifications:

- Set the order flags for __filemap_get_folio() inside
  prepare_one_folio()

  This will allow __filemap_get_folio() to create a large folio if the
  address space supports it.

- Limit the initial @write_bytes inside copy_one_range()
  If the largest folio boundary splits the initial write range, there is
  no way we can write beyond the largest folio boundary.

  This is done by a simple helper function, calc_write_bytes().

- Release exceeding reserved space if the folio is smaller than expected
  Which is doing the same handling when short copy happened.

All these preparation should not change the behavior when the largest
folio order is 0.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 63c7a3294eb2..5d10ae321687 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -861,7 +861,8 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 {
 	unsigned long index = pos >> PAGE_SHIFT;
 	gfp_t mask = get_prepare_gfp_flags(inode, nowait);
-	fgf_t fgp_flags = (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_WRITEBEGIN);
+	fgf_t fgp_flags = (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_WRITEBEGIN) |
+			  fgf_set_order(write_bytes);
 	struct folio *folio;
 	int ret = 0;
 
@@ -1169,6 +1170,16 @@ static void shrink_reserved_space(struct btrfs_inode *inode,
 				diff, true);
 }
 
+/* Calculate the maximum amount of bytes we can write into one folio. */
+static size_t calc_write_bytes(const struct btrfs_inode *inode,
+			       const struct iov_iter *i, u64 start)
+{
+	size_t max_folio_size = mapping_max_folio_size(inode->vfs_inode.i_mapping);
+
+	return min(max_folio_size - (start & (max_folio_size - 1)),
+		   iov_iter_count(i));
+}
+
 /*
  * Do the heavy-lifting work to copy one range into one folio of the page cache.
  *
@@ -1182,7 +1193,7 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_state *cached_state = NULL;
-	size_t write_bytes = min(iov_iter_count(i), PAGE_SIZE - offset_in_page(start));
+	size_t write_bytes = calc_write_bytes(inode, i, start);
 	size_t copied;
 	const u64 reserved_start = round_down(start, fs_info->sectorsize);
 	u64 reserved_len;
@@ -1227,6 +1238,20 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
 			      only_release_metadata);
 		return ret;
 	}
+	/*
+	 * The reserved range goes beyond the current folio, shrink the reserved
+	 * space to the folio boundary.
+	 */
+	if (reserved_start + reserved_len > folio_pos(folio) + folio_size(folio)) {
+		const u64 last_block = folio_pos(folio) + folio_size(folio);
+
+		shrink_reserved_space(inode, *data_reserved, reserved_start,
+				      reserved_len, last_block - reserved_start,
+				      only_release_metadata);
+		write_bytes = folio_pos(folio) + folio_size(folio) - start;
+		reserved_len = last_block - reserved_start;
+	}
+
 	extents_locked = lock_and_cleanup_extent_if_need(inode,
 					folio, start, write_bytes, &lockstart,
 					&lockend, nowait, &cached_state);
-- 
2.49.0


