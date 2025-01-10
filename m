Return-Path: <linux-btrfs+bounces-10894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5366CA08605
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 04:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5351716A0D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 03:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF71B2066C6;
	Fri, 10 Jan 2025 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IPLySNB6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IPLySNB6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDBE2063F9
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479942; cv=none; b=uJZSsgFTWZ0NpM47iZEuDZ+HL/59GVcyc63FrCSR4VVoJNBJJfHvdMcoocUhu3zo9Dg7PL4vLP1p3xRg8e+Qx92cIjeK1Uvnhd3Dseig39655M3UT4dySbuFbMXHxhDT2947XauUNuXYg3VyQeEQmqvBfYNL3gXlXFW5nIZAVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479942; c=relaxed/simple;
	bh=VuebES+ggmd38qPn1MONuiOPiKLBOQzWbYVxG3KiPYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0dEHvB3C0q5l0MSDCe1KLA3p009JYHk364YrjVCECt2TiCywBcG30Ty0FJ+OQfkineJH2CBEVtDhvvKNK5WZ0heVWue28ERLM6z8Jp9YeRvtnSOHHWEkYx6EKs3H+uZBnUaFxzDaG6KhwIoXRrklo2+x8fHXTJXN8c33HVPtDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IPLySNB6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IPLySNB6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4AD731F397;
	Fri, 10 Jan 2025 03:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAZfhk1wgLU6ObOoyxkFQmeFpRZHo/P66gNBe/Gk344=;
	b=IPLySNB6cg+gwHIGAnHfS4UVyMELWmR2Z2uGPeIlPVFYFeGI6TIH/4RUGI4Ie+4NDmj/ck
	vUEJghY8BfGTgjHIdv2DJvuPe/6X7tWCpW9QylZ9/N0rNONTzXM5Gk9ZpRQhnz3JnuzajD
	wRLckS8fcZDLt2puY2jRDQmin6GkxaU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAZfhk1wgLU6ObOoyxkFQmeFpRZHo/P66gNBe/Gk344=;
	b=IPLySNB6cg+gwHIGAnHfS4UVyMELWmR2Z2uGPeIlPVFYFeGI6TIH/4RUGI4Ie+4NDmj/ck
	vUEJghY8BfGTgjHIdv2DJvuPe/6X7tWCpW9QylZ9/N0rNONTzXM5Gk9ZpRQhnz3JnuzajD
	wRLckS8fcZDLt2puY2jRDQmin6GkxaU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F1961397D;
	Fri, 10 Jan 2025 03:32:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wOfjAMGUgGe0NQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 10 Jan 2025 03:32:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v3 09/10] btrfs: remove the unused @locked_folio parameter from btrfs_cleanup_ordered_extents()
Date: Fri, 10 Jan 2025 14:01:40 +1030
Message-ID: <25fa2fa50c2e9bbc0718698b23c7c4b955df60fa.1736479224.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736479224.git.wqu@suse.com>
References: <cover.1736479224.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

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
index c8145a588f45..03d76579878c 100644
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
@@ -2389,8 +2350,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 
 out:
 	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, NULL, start,
-					      end - start + 1);
+		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
 	return ret;
 }
 
-- 
2.47.1


