Return-Path: <linux-btrfs+bounces-19170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D371C717EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 01:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 681914E2ABB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 00:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1AA322A;
	Thu, 20 Nov 2025 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NYO0vbTy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NYO0vbTy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091FA92E
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597104; cv=none; b=JYsH8D7IZ6C1mC+GOWtQIkFzk2DyVUJb3niF98mWXoQJ3PWlUQUh4fH1YP3y9LyS6mLPfOLwwh3MkFm6M+Qdx/KX4m7a0lAq9sRR1ygWSrumKUZDzZ1875ZnkYI2C6st8KMRvcIyt9Koo2xOKU9wN8BM3fftaxHAURxDCz17VZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597104; c=relaxed/simple;
	bh=5AkhfWadNSo9y2VkvtFMVhA4+DtdEPQA8K3QC8wbUHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f55kR2n9z5gnh+nim5NYzJVvGJsJXv9XdzrkHcmmMkZNf5QOHhmPxMcd9sRC1kJ5ywbkWVVoOiDcHhYd88cJ0+V7vLpz/1u8fo7yiE1ZUdRYDuHklcVUPopZE26boztuWn2S4RIUSOybZFSuPHHYE3OcGUhvOsI/0joUtXtpnMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NYO0vbTy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NYO0vbTy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79F6120735
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763597095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aap0GEMtqFuwisHfauy3Hnl++CQSrgRdNLWNhm6rCBQ=;
	b=NYO0vbTyOwh1Ln73PuXvDU3CoshLJBiS6k28bh+9NJ2/E01Be1/qbpsi/TOOF1y3H5Vxr1
	YPJr9cF2Ln19HUJrGrfqhvkadillYJlJARAPiUTSwxanh5LXmU8qZACQ0KrR/4shQA4HT7
	Gr4FjN3gohC9YOD3NGOlfHUDShrZmW4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NYO0vbTy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763597095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aap0GEMtqFuwisHfauy3Hnl++CQSrgRdNLWNhm6rCBQ=;
	b=NYO0vbTyOwh1Ln73PuXvDU3CoshLJBiS6k28bh+9NJ2/E01Be1/qbpsi/TOOF1y3H5Vxr1
	YPJr9cF2Ln19HUJrGrfqhvkadillYJlJARAPiUTSwxanh5LXmU8qZACQ0KrR/4shQA4HT7
	Gr4FjN3gohC9YOD3NGOlfHUDShrZmW4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B24503EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0ESwHCZbHmkwFgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: extract the io finishing code into a helper
Date: Thu, 20 Nov 2025 10:34:32 +1030
Message-ID: <bd044ad0afecc8d8f65700800cf45939f7bb2d88.1763596717.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763596717.git.wqu@suse.com>
References: <cover.1763596717.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 79F6120735
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.19)[-0.939];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.00

Currently we have a code block, which finishes IO for a range beyond
i_size, deep inside the loop of extent_writepage_io().

Extract it into a helper, finish_io_beyond_eof(), to reduce the level
of indents.

Furthermore slightly change the parameter passed into the helper,
currently we fully finish the IO for the range beyond EOF, but that
range may be beyond the range [start, start + len), that means we may
finish the IO for ranges which we should not touch.

So call the finish_io_beyond_eof() only for the range we should touch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 62 +++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4fc3b3d776ee..cbee93a929f3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1684,6 +1684,40 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	return 0;
 }
 
+static void finish_io_beyond_eof(struct btrfs_inode *inode, struct folio *folio,
+				 u64 start, u32 len, loff_t i_size)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_ordered_extent *ordered;
+
+	ASSERT(start >= i_size);
+
+	ordered = btrfs_lookup_first_ordered_range(inode, start, len);
+
+	/*
+	 * We have just run delalloc before getting here, so
+	 * there must be an ordered extent.
+	 */
+	ASSERT(ordered != NULL);
+	spin_lock(&inode->ordered_tree_lock);
+	set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
+	ordered->truncated_len = min(ordered->truncated_len,
+				     start - ordered->file_offset);
+	spin_unlock(&inode->ordered_tree_lock);
+	btrfs_put_ordered_extent(ordered);
+
+	btrfs_mark_ordered_io_finished(inode, folio, start, len, true);
+	/*
+	 * This range is beyond i_size, thus we don't need to
+	 * bother writing back.
+	 * But we still need to clear the dirty subpage bit, or
+	 * the next time the folio gets dirtied, we will try to
+	 * writeback the sectors with subpage dirty bits,
+	 * causing writeback without ordered extent.
+	 */
+	btrfs_folio_clear_dirty(fs_info, folio, start, len);
+}
+
 /*
  * Helper for extent_writepage().  This calls the writepage start hooks,
  * and does the loop to map the page into extents and bios.
@@ -1739,33 +1773,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
 
 		if (cur >= i_size) {
-			struct btrfs_ordered_extent *ordered;
-
-			ordered = btrfs_lookup_first_ordered_range(inode, cur,
-								   folio_end - cur);
-			/*
-			 * We have just run delalloc before getting here, so
-			 * there must be an ordered extent.
-			 */
-			ASSERT(ordered != NULL);
-			spin_lock(&inode->ordered_tree_lock);
-			set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags);
-			ordered->truncated_len = min(ordered->truncated_len,
-						     cur - ordered->file_offset);
-			spin_unlock(&inode->ordered_tree_lock);
-			btrfs_put_ordered_extent(ordered);
-
-			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       end - cur, true);
-			/*
-			 * This range is beyond i_size, thus we don't need to
-			 * bother writing back.
-			 * But we still need to clear the dirty subpage bit, or
-			 * the next time the folio gets dirtied, we will try to
-			 * writeback the sectors with subpage dirty bits,
-			 * causing writeback without ordered extent.
-			 */
-			btrfs_folio_clear_dirty(fs_info, folio, cur, end - cur);
+			finish_io_beyond_eof(inode, folio, cur, start + len - cur, i_size);
 			break;
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
-- 
2.52.0


