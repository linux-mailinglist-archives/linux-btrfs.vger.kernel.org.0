Return-Path: <linux-btrfs+bounces-8574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9A991BA6
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Oct 2024 02:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2634283506
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Oct 2024 00:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E539679D1;
	Sun,  6 Oct 2024 00:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i/TcjUz9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i/TcjUz9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814819A
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Oct 2024 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728175254; cv=none; b=IZsODHaRd4hMsr/ZX/cKBlTII/MZ1+FJSFE6ipLG8e/WVmR/35Rkw1HPincCvOhTzJ9gQh/DonZFDVEefe84N+A3eoYG7rBb3+OlnZ3aKwNZwt21iQDHVpIOe7kYjjBx8NZieYkxpmhGrqZfwActRGOOMMuAn7HbrXZbT4xgiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728175254; c=relaxed/simple;
	bh=C0n7LaLp/UgbNH/yLBfmfLh7lwCgTDamyG8gjrZbIIs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Vh+m8gvkkca9PsOqKRMwQ8d4I9RfZWairGMYZEZRFzLbOn/mA/8CsPf0lPMEhu0p0zoGiJZtesjWLUEoP0hFdXcHFQPWjcu+Rnv9vpNRqQC8gnRxYK5G/snAdgesEw5Ncsg9ARQEEw+yp+VFNB6vqiWYAufFrlns29SIcze9SYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i/TcjUz9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i/TcjUz9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27FDE21DB6
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Oct 2024 00:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728175245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=odCHzSpF4b/v9u2bLqFZUBM+/Eu7bvx1gtRp8xPqx2A=;
	b=i/TcjUz9IuVSo1v58RRw6ZdZ51bNcmvOiOAR3J1pXV0PCjVuapKksc2N9+Tm8PsQ/el/PU
	EUwqTbjhEvtL9js9tJqyPWdh9EdMamfGyKfH/FN6W2zAM3CXuPT31NmIGGmaOi5lQBpCEd
	jfmveCKHd1qEIijjNfxeLxXwDEc1MYk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="i/TcjUz9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728175245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=odCHzSpF4b/v9u2bLqFZUBM+/Eu7bvx1gtRp8xPqx2A=;
	b=i/TcjUz9IuVSo1v58RRw6ZdZ51bNcmvOiOAR3J1pXV0PCjVuapKksc2N9+Tm8PsQ/el/PU
	EUwqTbjhEvtL9js9tJqyPWdh9EdMamfGyKfH/FN6W2zAM3CXuPT31NmIGGmaOi5lQBpCEd
	jfmveCKHd1qEIijjNfxeLxXwDEc1MYk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E5FE13736
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Oct 2024 00:40:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SkrPB4zcAWepEwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 06 Oct 2024 00:40:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove btrfs_set_range_writeback()
Date: Sun,  6 Oct 2024 11:10:22 +1030
Message-ID: <2c53f7555d45d6697e836fa2bb7dce137ab04c99.1728175215.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 27FDE21DB6
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
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The function btrfs_set_range_writeback() is originally a callback for
metadata and data, to mark a range with writeback flag.

Then it was converted into a common function call for both metadata and
data.

From the very beginning, the function is only called on a full page,
later converted to handle range inside a page.

But it never needs to handle multiple pages, and since commit
8189197425e7 ("btrfs: refactor __extent_writepage_io() to do
sector-by-sector submission") the function is only called on a
sector-by-sector basis.

This makes the function unnecessary, and can be converted to a simple
btrfs_folio_set_writeback() call instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h |  1 -
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/inode.c       | 22 ----------------------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index e152fde888fc..c514bab532fa 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -577,7 +577,6 @@ void btrfs_merge_delalloc_extent(struct btrfs_inode *inode, struct extent_state
 				 struct extent_state *other);
 void btrfs_split_delalloc_extent(struct btrfs_inode *inode,
 				 struct extent_state *orig, u64 split);
-void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end);
 void btrfs_evict_inode(struct inode *inode);
 struct inode *btrfs_alloc_inode(struct super_block *sb);
 void btrfs_destroy_inode(struct inode *inode);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9fbc83c76b94..d87dcafab537 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1359,7 +1359,7 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	 * a folio for a range already written to disk.
 	 */
 	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
-	btrfs_set_range_writeback(inode, filepos, filepos + sectorsize - 1);
+	btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
 	/*
 	 * Above call should set the whole folio with writeback flag, even
 	 * just for a single subpage sector.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 103ec917ca9d..21e51924742a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8939,28 +8939,6 @@ static int btrfs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	return finish_open_simple(file, ret);
 }
 
-void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	unsigned long index = start >> PAGE_SHIFT;
-	unsigned long end_index = end >> PAGE_SHIFT;
-	struct folio *folio;
-	u32 len;
-
-	ASSERT(end + 1 - start <= U32_MAX);
-	len = end + 1 - start;
-	while (index <= end_index) {
-		folio = __filemap_get_folio(inode->vfs_inode.i_mapping, index, 0, 0);
-		ASSERT(!IS_ERR(folio)); /* folios should be in the extent_io_tree */
-
-		/* This is for data, which doesn't yet support larger folio. */
-		ASSERT(folio_order(folio) == 0);
-		btrfs_folio_set_writeback(fs_info, folio, start, len);
-		folio_put(folio);
-		index++;
-	}
-}
-
 int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
 					     int compress_type)
 {
-- 
2.46.2


