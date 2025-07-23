Return-Path: <linux-btrfs+bounces-15643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E22B0F10D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 13:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383651C25B56
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEFA2E3B0F;
	Wed, 23 Jul 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RON4fpKj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RON4fpKj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA71277CBC
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269700; cv=none; b=WwVdAtTbPnCXFIyPSJBkn73rw64nREozaBWoK2OJiRU028Ck0ws24h2SNIRUd6weO9DyWfsHBDh3vAFAnf00umyByCBAB6+R5oCqnVROzRR3+xUfV3xYF1uFyFkY3s8ktqhW500oTTvmGhnTV+yJ9SGY+1sDt1fzX1nZz+Ruw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269700; c=relaxed/simple;
	bh=NSuM14ZFdozyx5Tlh0UkcytP2KWrnrN5AzOWPPwejG0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7ZtADZdRUA6Z6vrILgiexZlc25Fj1Oct5TwFx/xtTXq8xKi4VwapyZZ6NGSPrcHNVfcn/S1htLds0fq+xQsMwhwSIbNfZ1/HkxuASvJWrrFZA9ZE0VtBW/dF8UjPtO55kFEkCLqZu7MZENdjmMCmmuOns7Smp8xVWcJxH3rG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RON4fpKj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RON4fpKj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D36821F76C
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753269690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBWDQpjzkJo83/1uOH2Nvhqjbw+BkKy5PGcpc6hgJgw=;
	b=RON4fpKjvu32K8ic8zB9KtKwJsws9kKefiPElyJJ9lgGUDCd0eNXYZ57OSZqVm8OlEtEzG
	OP473M6in0uMpXOnDIcTuHT4H9P8dkBQBfm1ApIObxSsK9tS3EO9kIRChVm9+bFgFjX3F+
	1S6eSKTZGjhR4mkKSqNEzgSWY3bEpUg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753269690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rBWDQpjzkJo83/1uOH2Nvhqjbw+BkKy5PGcpc6hgJgw=;
	b=RON4fpKjvu32K8ic8zB9KtKwJsws9kKefiPElyJJ9lgGUDCd0eNXYZ57OSZqVm8OlEtEzG
	OP473M6in0uMpXOnDIcTuHT4H9P8dkBQBfm1ApIObxSsK9tS3EO9kIRChVm9+bFgFjX3F+
	1S6eSKTZGjhR4mkKSqNEzgSWY3bEpUg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A0FB13302
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SMh1M7nFgGhaeAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: make nocow_one_range() to do cleanup on error
Date: Wed, 23 Jul 2025 20:51:23 +0930
Message-ID: <b851a5b50ae3f291fdb40818b3342b58f199f82d.1753269601.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753269601.git.wqu@suse.com>
References: <cover.1753269601.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Currently if we hit an error inside nocow_one_range(), we do not clear
the page dirty, and let the caller to handle it.

This is very different compared to fallback_to_cow(), when that function
failed, everything will be cleaned up by cow_file_range().

Enhance the situation by:

- Use a common error handling for nocow_one_range()
  If we failed anything, use the same btrfs_cleanup_ordered_extents()
  and extent_clear_unlock_delalloc().

  btrfs_cleanup_ordered_extents() is safe even if we haven't created new
  ordered extent, in that case there should be no OE and that function
  will do nothing.

  The same applies to extent_clear_unlock_delalloc(), and since we're
  passing PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK, it
  will also clear folio dirty flag during error handling.

- Avoid touching the failed range of nocow_one_range()
  As the failed range will be cleaned up and unlocked by that function.

  Here we introduce a new variable @nocow_end to record the failed range,
  so that we can skip it during the error handling of run_delalloc_nocow().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 55d42f2b4a86..3f2f3c6024ba 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1982,8 +1982,8 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 		em = btrfs_create_io_em(inode, file_pos, &nocow_args->file_extent,
 					BTRFS_ORDERED_PREALLOC);
 		if (IS_ERR(em)) {
-			btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
-			return PTR_ERR(em);
+			ret = PTR_ERR(em);
+			goto error;
 		}
 		btrfs_free_extent_map(em);
 	}
@@ -1995,8 +1995,8 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 	if (IS_ERR(ordered)) {
 		if (is_prealloc)
 			btrfs_drop_extent_map_range(inode, file_pos, end, false);
-		btrfs_unlock_extent(&inode->io_tree, file_pos, end, cached);
-		return PTR_ERR(ordered);
+		ret = PTR_ERR(ordered);
+		goto error;
 	}
 
 	if (btrfs_is_data_reloc_root(inode->root))
@@ -2008,23 +2008,24 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 		ret = btrfs_reloc_clone_csums(ordered);
 	btrfs_put_ordered_extent(ordered);
 
+	if (ret < 0)
+		goto error;
 	extent_clear_unlock_delalloc(inode, file_pos, end, locked_folio, cached,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_CLEAR_DATA_RESV,
 				     PAGE_UNLOCK | PAGE_SET_ORDERED);
-	/*
-	 * On error, we need to cleanup the ordered extents we created.
-	 *
-	 * We do not clear the folio Dirty flags because they are set and
-	 * cleaered by the caller.
-	 */
-	if (ret < 0) {
-		btrfs_cleanup_ordered_extents(inode, file_pos, len);
-		btrfs_err(inode->root->fs_info,
-			  "%s failed, root=%lld inode=%llu start=%llu len=%llu: %d",
-			  __func__, btrfs_root_id(inode->root), btrfs_ino(inode),
-			  file_pos, len, ret);
-	}
+	return ret;
+error:
+	btrfs_cleanup_ordered_extents(inode, file_pos, len);
+	extent_clear_unlock_delalloc(inode, file_pos, end, locked_folio, cached,
+				     EXTENT_LOCKED | EXTENT_DELALLOC |
+				     EXTENT_CLEAR_DATA_RESV,
+				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+				     PAGE_END_WRITEBACK);
+	btrfs_err(inode->root->fs_info,
+		  "%s failed, root=%lld inode=%llu start=%llu len=%llu: %d",
+		  __func__, btrfs_root_id(inode->root), btrfs_ino(inode),
+		  file_pos, len, ret);
 	return ret;
 }
 
@@ -2046,8 +2047,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	/*
 	 * If not 0, represents the inclusive end of the last fallback_to_cow()
 	 * range. Only for error handling.
+	 *
+	 * The same for nocow_end, it's to avoid double cleaning up the range
+	 * already cleaned by nocow_one_range().
 	 */
 	u64 cow_end = 0;
+	u64 nocow_end = 0;
 	u64 cur_offset = start;
 	int ret;
 	bool check_prev = true;
@@ -2216,8 +2221,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				      &nocow_args, cur_offset,
 				      extent_type == BTRFS_FILE_EXTENT_PREALLOC);
 		btrfs_dec_nocow_writers(nocow_bg);
-		if (ret < 0)
+		if (ret < 0) {
+			nocow_end = cur_offset + nocow_args.file_extent.num_bytes - 1;
 			goto error;
+		}
 		cur_offset = extent_end;
 	}
 	btrfs_release_path(path);
@@ -2291,6 +2298,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 */
 	if (cow_end)
 		cur_offset = cow_end + 1;
+	else if (nocow_end)
+		cur_offset = nocow_end + 1;
 
 	/*
 	 * We need to lock the extent here because we're clearing DELALLOC and
-- 
2.50.0


