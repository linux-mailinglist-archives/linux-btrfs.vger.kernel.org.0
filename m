Return-Path: <linux-btrfs+bounces-12127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ACDA58D01
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 08:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CA63AAE6D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862F221565;
	Mon, 10 Mar 2025 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mhij3Eqs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Mhij3Eqs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718412206B7
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592195; cv=none; b=Wqq5H12Hs8l7SSfyegKvbfmLxsDhUkIH5zBWHVf+NLAPqn3a7xf+AyGbwoqiW7wxIz4RWJ9xlFDGU064Gwq+u75Dkec++y1HNux761IOuo8YDUbQm0k7SwAWkoHR23n8a7MypQwIpnF8fK6opOoE29+fIf7vT8KIhU00m+70iKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592195; c=relaxed/simple;
	bh=2EOOXr81jlx3g18HL6BjfuUfvds5ziHQMDEdPA/scwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKpOYLvDDcYaEZQdCa6gt7Cjg1tO+Ihhef7uns0+53S3k1RStXHqrKztgzJIKhHbX1vdEixBngwJA6bb125etGeMnzsFMlndseoJzSING+atZvP6WG+N6QW0gKrfuxdiRZTeFsmLLyxtPB+00zAu3B39DQLPTpJUEWsz2YOVcYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mhij3Eqs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Mhij3Eqs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E1A221187;
	Mon, 10 Mar 2025 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wQ2MR2XFZEeXcbjYWq1pg9rwYtFjCok70oL1xI0rUU=;
	b=Mhij3EqsOPZDhibjzkJe2ze+1/iH5TjLigjPkdJ0x4iEC7sjrkIfGlD9KZtPHOhVcAgh2T
	iDiO729gbsar1TNwKrmSlHzArcCDasYQ5Ylz7hqBsRfqJkczBpq2acCiOyajnDaW2+WHdk
	AVIKQ+onFmApBDokY8J+eN2X+WePUDA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2wQ2MR2XFZEeXcbjYWq1pg9rwYtFjCok70oL1xI0rUU=;
	b=Mhij3EqsOPZDhibjzkJe2ze+1/iH5TjLigjPkdJ0x4iEC7sjrkIfGlD9KZtPHOhVcAgh2T
	iDiO729gbsar1TNwKrmSlHzArcCDasYQ5Ylz7hqBsRfqJkczBpq2acCiOyajnDaW2+WHdk
	AVIKQ+onFmApBDokY8J+eN2X+WePUDA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66E5A13A70;
	Mon, 10 Mar 2025 07:36:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CA/kCXyWzmfpMAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 10 Mar 2025 07:36:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 6/6] btrfs: prepare btrfs_page_mkwrite() for larger folios
Date: Mon, 10 Mar 2025 18:06:02 +1030
Message-ID: <f702ac5550697246fb7a3828c51c1d2b3a95a0b0.1741591823.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741591823.git.wqu@suse.com>
References: <cover.1741591823.git.wqu@suse.com>
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

This changes the assumption that the folio is always page sized.
(Although the ASSERT() for folio order is still kept as-is).

Just replace the PAGE_SIZE with folio_size().

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 643f101c7340..262a707d8990 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1782,6 +1782,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	struct extent_changeset *data_reserved = NULL;
 	unsigned long zero_start;
 	loff_t size;
+	size_t fsize = folio_size(folio);
 	vm_fault_t ret;
 	int ret2;
 	int reserved = 0;
@@ -1792,7 +1793,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	ASSERT(folio_order(folio) == 0);
 
-	reserved_space = PAGE_SIZE;
+	reserved_space = fsize;
 
 	sb_start_pagefault(inode->i_sb);
 	page_start = folio_pos(folio);
@@ -1846,7 +1847,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	 * We can't set the delalloc bits if there are pending ordered
 	 * extents.  Drop our locks and wait for them to finish.
 	 */
-	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, PAGE_SIZE);
+	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start, fsize);
 	if (ordered) {
 		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		folio_unlock(folio);
@@ -1858,11 +1859,11 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
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
 
@@ -1889,12 +1890,12 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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
 
@@ -1903,7 +1904,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	unlock_extent(io_tree, page_start, page_end, &cached_state);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
-	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
+	btrfs_delalloc_release_extents(BTRFS_I(inode), fsize);
 	sb_end_pagefault(inode->i_sb);
 	extent_changeset_free(data_reserved);
 	return VM_FAULT_LOCKED;
@@ -1912,7 +1913,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
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


