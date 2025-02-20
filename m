Return-Path: <linux-btrfs+bounces-11611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFEFA3D495
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41BE4189E0FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 09:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF401F0E28;
	Thu, 20 Feb 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P8UYynKu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P8UYynKu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C451EBA03
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043386; cv=none; b=FQxlg5CimLT5r3pfc8pxgOCyNqGYcDcs55h7ltKiaxZvgO+w24bM8KKQAtsbhEBdL9axd6Dr0mXbyOe7bqFB+DrBUxUljvPpijup5zGftFahzkqSlnAJaD9d/fpiECr+ndnjMGJQqXWE7s3MvWr2i7qTQpR1Gtmeq+YoDlakbdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043386; c=relaxed/simple;
	bh=XmYo62+WeGt+weKhLkdfKuZ25VY5ATIw7AE78Pe1SHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjnYaYNo4ajbYV4ZJwtgeaBtjp2NjhomhVRKKjkgPHB2V/sL15V3PzcmZ6QBeHcZNOwIZkXLeaI+cly5Hp4rUdWf+ST6gIx4ar0Ky0/1XMl13OHOp4qAJuV5ssuLOtZe49mQCaWXdEgQ3taF7r6cF6lmhJq8OZ+E9aWxaWLgSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P8UYynKu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P8UYynKu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98B401F38A
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sYKOTwm6sETtFh/UtKWbWL6uFBAag4CKy3SnAWwOxU=;
	b=P8UYynKu+NZdckPRVUpJCXcRO07nl5IzXUGcya5KYFnn4TknYoqTCGpNFxVhhVBOvk2rx7
	qn+1mYkuAV60bK6MgFsxPi4npflPwwO5qEnspN1/xZAXFcMi/z//LJey2nNvX0dMvrXRVv
	pu0Ai64yGE2nfG6DxIIwa4r54jeQ5po=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=P8UYynKu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sYKOTwm6sETtFh/UtKWbWL6uFBAag4CKy3SnAWwOxU=;
	b=P8UYynKu+NZdckPRVUpJCXcRO07nl5IzXUGcya5KYFnn4TknYoqTCGpNFxVhhVBOvk2rx7
	qn+1mYkuAV60bK6MgFsxPi4npflPwwO5qEnspN1/xZAXFcMi/z//LJey2nNvX0dMvrXRVv
	pu0Ai64yGE2nfG6DxIIwa4r54jeQ5po=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BED813A69
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EMe7DW30tmfBcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: prepare btrfs_page_mkwrite() for larger folios
Date: Thu, 20 Feb 2025 19:52:26 +1030
Message-ID: <eaa6e7d82b2fae308072b81675d149a5598ec9e0.1740043233.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740043233.git.wqu@suse.com>
References: <cover.1740043233.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 98B401F38A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This changes the assumption that the folio is always page sized.
(Although the ASSERT() for folio order is still kept as-is).

Just replace the PAGE_SIZE with folio_size().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 05a70e50ed40..cebe5cb86a8c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1783,6 +1783,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	struct extent_changeset *data_reserved = NULL;
 	unsigned long zero_start;
 	loff_t size;
+	size_t fsize = folio_size(folio);
 	vm_fault_t ret;
 	int ret2;
 	int reserved = 0;
@@ -1793,7 +1794,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	ASSERT(folio_order(folio) == 0);
 
-	reserved_space = PAGE_SIZE;
+	reserved_space = fsize;
 
 	sb_start_pagefault(inode->i_sb);
 	page_start = folio_pos(folio);
@@ -1847,7 +1848,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * We can't set the delalloc bits if there are pending ordered
 	 * extents.  Drop our locks and wait for them to finish.
 	 */
-	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, PAGE_SIZE);
+	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, fsize);
 	if (ordered) {
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		folio_unlock(folio);
@@ -1859,11 +1860,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	if (folio->index == ((size - 1) >> PAGE_SHIFT)) {
 		reserved_space = round_up(size - page_start, fs_info->sectorsize);
-		if (reserved_space < PAGE_SIZE) {
+		if (reserved_space < fsize) {
 			end = page_start + reserved_space - 1;
 			btrfs_delalloc_release_space(BTRFS_I(inode),
 					data_reserved, page_start,
-					PAGE_SIZE - reserved_space, true);
+					fsize - reserved_space, true);
 		}
 	}
 
@@ -1890,12 +1891,12 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	if (page_start + folio_size(folio) > size)
 		zero_start = offset_in_folio(folio, size);
 	else
-		zero_start = PAGE_SIZE;
+		zero_start = fsize;
 
-	if (zero_start != PAGE_SIZE)
+	if (zero_start != fsize)
 		folio_zero_range(folio, zero_start, folio_size(folio) - zero_start);
 
-	btrfs_folio_clear_checked(fs_info, folio, page_start, PAGE_SIZE);
+	btrfs_folio_clear_checked(fs_info, folio, page_start, fsize);
 	btrfs_folio_set_dirty(fs_info, folio, page_start, end + 1 - page_start);
 	btrfs_folio_set_uptodate(fs_info, folio, page_start, end + 1 - page_start);
 
@@ -1904,7 +1905,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	unlock_extent(io_tree, page_start, page_end, &cached_state);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
-	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
 	sb_end_pagefault(inode->i_sb);
 	extent_changeset_free(data_reserved);
 	return VM_FAULT_LOCKED;
@@ -1913,7 +1914,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	folio_unlock(folio);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 out:
-	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
 	btrfs_delalloc_release_space(BTRFS_I(inode), data_reserved, page_start,
 				     reserved_space, (ret != 0));
 out_noreserve:
-- 
2.48.1


