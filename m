Return-Path: <linux-btrfs+bounces-10923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846FAA0A2EB
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 11:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EED67A4119
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 10:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFBD194A59;
	Sat, 11 Jan 2025 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ttf5FV/F";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ttf5FV/F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A3B192B77
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592265; cv=none; b=pGPPA4i2oql2/nVd9Xo6w1d/RDwuDb8t/L08IoAThDh8xvPN3nnwIhr9s17G0OJEc3ieDfu/WIB1iYejrybK6n7rjXQJoU+AYr6NJ5nFV3EgEif+UAKSnPRepzwiuMgidGcjMrYWG94Igk/nhzc2w6h4e0ogcu8Qj9zqpfSO3fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592265; c=relaxed/simple;
	bh=A9DfuzjkOfaGZkonaVxyGFrsKz61eIALfh/j3ekIjnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uekELoU8CT6xGS38Sn9lCqJ8+kQHjLC36wUDNSQXUjCUUI5EIqvExphXP/v+AyvpwabqGW1kR1tnYtc/M2FObFaqDs7fh5GfIYumLaOJBL0PfzPyhIYRtCxqJcsUlr+S8awaprdcyOQo80RNVkKqzCc9Vn7IJ8TTUEpdMbj2A5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ttf5FV/F; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ttf5FV/F; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B24AC2117E;
	Sat, 11 Jan 2025 10:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ufj0K5wP3oBSW0O1kLa1dVVrcbydwZ4YHvGpMNMGgxI=;
	b=ttf5FV/FfhTTSr690XDaj4SFAvK/xlYNQc68IlO4e83I8doVu+Ii8UH8juoR/UDUM12aTg
	n6yJfx/FFaHv9VC9UzsR0ro7f22SaP3C0/gLip4DuRGOEmPBiGsYC5U3AMZLwWp/Rs9cLN
	GhT0WS+bUIFV31Dd0kXu48P6ECT0sWk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ufj0K5wP3oBSW0O1kLa1dVVrcbydwZ4YHvGpMNMGgxI=;
	b=ttf5FV/FfhTTSr690XDaj4SFAvK/xlYNQc68IlO4e83I8doVu+Ii8UH8juoR/UDUM12aTg
	n6yJfx/FFaHv9VC9UzsR0ro7f22SaP3C0/gLip4DuRGOEmPBiGsYC5U3AMZLwWp/Rs9cLN
	GhT0WS+bUIFV31Dd0kXu48P6ECT0sWk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1CD5139AB;
	Sat, 11 Jan 2025 10:44:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ANDWHINLgmdCLgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 Jan 2025 10:44:19 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v4 09/10] btrfs: remove the unused @locked_folio parameter from btrfs_cleanup_ordered_extents()
Date: Sat, 11 Jan 2025 21:13:43 +1030
Message-ID: <e6a77e22aa3760314b67b96c8f3d79658a5746e3.1736591758.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736591758.git.wqu@suse.com>
References: <cover.1736591758.git.wqu@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The function btrfs_cleanup_ordered_extents() is only called in error
handling path, and the last caller with a @locked_folio parameter is
removed to fix a bug in the btrfs_run_delalloc_range() error handling.

There is no need to pass @locked_folio parameter anymore.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 44 ++------------------------------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3409f1e02de0..130f0490b14f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -393,34 +393,13 @@ void btrfs_inode_unlock(struct btrfs_inode *inode, unsigned int ilock_flags)
  * extent (btrfs_finish_ordered_io()).
  */
 static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
-						 struct folio *locked_folio,
 						 u64 offset, u64 bytes)
 {
 	unsigned long index = offset >> PAGE_SHIFT;
 	unsigned long end_index = (offset + bytes - 1) >> PAGE_SHIFT;
-	u64 page_start = 0, page_end = 0;
 	struct folio *folio;
 
-	if (locked_folio) {
-		page_start = folio_pos(locked_folio);
-		page_end = page_start + folio_size(locked_folio) - 1;
-	}
-
 	while (index <= end_index) {
-		/*
-		 * For locked page, we will call btrfs_mark_ordered_io_finished
-		 * through btrfs_mark_ordered_io_finished() on it
-		 * in run_delalloc_range() for the error handling, which will
-		 * clear page Ordered and run the ordered extent accounting.
-		 *
-		 * Here we can't just clear the Ordered bit, or
-		 * btrfs_mark_ordered_io_finished() would skip the accounting
-		 * for the page range, and the ordered extent will never finish.
-		 */
-		if (locked_folio && index == (page_start >> PAGE_SHIFT)) {
-			index++;
-			continue;
-		}
 		folio = filemap_get_folio(inode->vfs_inode.i_mapping, index);
 		index++;
 		if (IS_ERR(folio))
@@ -436,23 +415,6 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
 		folio_put(folio);
 	}
 
-	if (locked_folio) {
-		/* The locked page covers the full range, nothing needs to be done */
-		if (bytes + offset <= page_start + folio_size(locked_folio))
-			return;
-		/*
-		 * In case this page belongs to the delalloc range being
-		 * instantiated then skip it, since the first page of a range is
-		 * going to be properly cleaned up by the caller of
-		 * run_delalloc_range
-		 */
-		if (page_start >= offset && page_end <= (offset + bytes - 1)) {
-			bytes = offset + bytes - folio_pos(locked_folio) -
-				folio_size(locked_folio);
-			offset = folio_pos(locked_folio) + folio_size(locked_folio);
-		}
-	}
-
 	return btrfs_mark_ordered_io_finished(inode, NULL, offset, bytes, false);
 }
 
@@ -1128,8 +1090,7 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			       &wbc, false);
 	wbc_detach_inode(&wbc);
 	if (ret < 0) {
-		btrfs_cleanup_ordered_extents(inode, NULL,
-					      start, end - start + 1);
+		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
 		if (locked_folio)
 			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
 					     start, async_extent->ram_size);
@@ -2388,8 +2349,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 
 out:
 	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, NULL, start,
-					      end - start + 1);
+		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
 	return ret;
 }
 
-- 
2.47.1


