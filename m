Return-Path: <linux-btrfs+bounces-10288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462999EDF4C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF9D283F3D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 06:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5310E18E047;
	Thu, 12 Dec 2024 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gagp5u6D";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gagp5u6D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6418186607
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984078; cv=none; b=kLpB06wO43hk8M4G+4kl7c+oUGadUHglHYcHagyiiW1V87cQhtPgw0eOlPQQjCZWSwK8qna/jXzeYKQgGxFlxXNpQZoymKfWLwa5QRgCz3aI6NPVRwKZqZxRzDzzj9X2E+V0S65iSwYD3O6UPJ1o9skrF3VCByuyR4wKXXWe8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984078; c=relaxed/simple;
	bh=tUNmdwY80pPvJ3G5S+3YBFi5fpbsLvxgqK8xEOX+Fq8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXyYgRZbBjdXYXeP0kJeVLDDIZtxxySMC1rhYoDLO1U62h8OjE91ycage/OE57DSL1/nYycFY2NJygqAwbg84+4atQQikManufsQ4AJz7F/YlF2vQW2qHL9EwuH+tP2d0AViDsvyWGdkzWUwYzhkaTw4UT9o+hlItKcfMkewe1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gagp5u6D; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gagp5u6D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C73B2117B
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733984075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iS3OUe2cK5SWloq2dj3svmgV5hEzfOvI57p4DSu1bGg=;
	b=gagp5u6DmH/v/vRShmUZUmb4oW/MxYfH3srWngMSZj7ywIQt3+ETY0Rg24sBUHA5fRXDUB
	dYyYKKTJMJabn25MIAEIsneeFlz44z+hYD/YZA5Gp97PEf9uKypSBLqejQVOZ7t5CNFmgO
	OdEXnjgxx/CoKTtwhLO3nbtD8xFlz9A=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733984075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iS3OUe2cK5SWloq2dj3svmgV5hEzfOvI57p4DSu1bGg=;
	b=gagp5u6DmH/v/vRShmUZUmb4oW/MxYfH3srWngMSZj7ywIQt3+ETY0Rg24sBUHA5fRXDUB
	dYyYKKTJMJabn25MIAEIsneeFlz44z+hYD/YZA5Gp97PEf9uKypSBLqejQVOZ7t5CNFmgO
	OdEXnjgxx/CoKTtwhLO3nbtD8xFlz9A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A78D13508
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YGIuCkp/Wme5VQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 9/9] btrfs: remove the unused @locked_folio parameter from btrfs_cleanup_ordered_extents()
Date: Thu, 12 Dec 2024 16:44:03 +1030
Message-ID: <ccbea215c530461830f0b4beca807f2bcba42ec1.1733983488.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733983488.git.wqu@suse.com>
References: <cover.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The function btrfs_cleanup_ordered_extents() is only called in error
handling path, and the last caller with a @locked_folio parameter is
removed to fix a bug in the btrfs_run_delalloc_range() error handling.

There is no need to pass @locked_folio parameter anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 44 ++------------------------------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a88cba85bf40..a5d33ebf90d4 100644
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
 
@@ -1129,8 +1091,7 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 			       &wbc, false);
 	wbc_detach_inode(&wbc);
 	if (ret < 0) {
-		btrfs_cleanup_ordered_extents(inode, NULL,
-					      start, end - start + 1);
+		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
 		if (locked_folio)
 			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
 					     start, async_extent->ram_size);
@@ -2387,8 +2348,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 
 out:
 	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, NULL, start,
-					      end - start + 1);
+		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
 	return ret;
 }
 
-- 
2.47.1


