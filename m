Return-Path: <linux-btrfs+bounces-9994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2673D9DF99B
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 04:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D7FB229F9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2024 03:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39751E378C;
	Mon,  2 Dec 2024 03:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M4EXkL/J";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M4EXkL/J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DA1E32A9;
	Mon,  2 Dec 2024 03:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733110139; cv=none; b=qc2u+A2eeP7L17KExdxk9Al1yCVBEtaOe8IXs3doIGR4vsCXUOa4qc6NvdDmzcuiuvMQ2dwhjoEQ8sridXfKDWIqX7xZugBwe4rtilM+1I/Wt1Jtq6ooDQJj1I4bIEkAOVExD6Wr+0ikbRgcbXK0BLxFatiu5jpOIVO2uXWUNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733110139; c=relaxed/simple;
	bh=9Bxbq+hWFlvJQom4Q1CUIdNFgOmOTbjcjZKUwnPaxjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtdBxe56qppsEavvZySqdzW+UreYGG+16Jg0NHceberhSPim8z87bAv2tgb1JVtOkL7MIF4EcCtsot+gjlC06vX0O3gpSph94+UlbmxW4Y22s7VF5UP7T5++z3kuS194VO8IDwdK8mwJflb8BFsZiMiSbxdvyy1hi6JXsNp3Rmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M4EXkL/J; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M4EXkL/J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0723921175;
	Mon,  2 Dec 2024 03:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733110129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=amV8OltlfnR3goQjt+ipgijZxmT0hanBOhDXSQ3kEMI=;
	b=M4EXkL/JO1yD4hodsltssdWi8AQ6AQGUdFDM+3lJ4YwwrqgcWgA0BtFTQOmW3g80cD9aaW
	+fdN0KCzaj+LDEI1QTCNGlNI3PsiTjD4ATUEiwd58KcDGeyh+uPkow3rEHzrXams09d5gc
	fx5dvuWOyxaLT65bT6RWC8oW3xWcons=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733110129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=amV8OltlfnR3goQjt+ipgijZxmT0hanBOhDXSQ3kEMI=;
	b=M4EXkL/JO1yD4hodsltssdWi8AQ6AQGUdFDM+3lJ4YwwrqgcWgA0BtFTQOmW3g80cD9aaW
	+fdN0KCzaj+LDEI1QTCNGlNI3PsiTjD4ATUEiwd58KcDGeyh+uPkow3rEHzrXams09d5gc
	fx5dvuWOyxaLT65bT6RWC8oW3xWcons=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05BF4139D0;
	Mon,  2 Dec 2024 03:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mkhDLm8pTWdgWwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 02 Dec 2024 03:28:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: do proper folio cleanup when cow_file_range() failed
Date: Mon,  2 Dec 2024 13:58:26 +1030
Message-ID: <42ee9dff1e240427f4a4d827c83e81b5598fe765.1733109950.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
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
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Just like cow_file_range(), from day 1 btrfs doesn't really clean the
dirty flags, if it has an ordered extent created successfully.

Per error handling protocol (according to the iomap, and the btrfs
handling if it failed at the beginning of the range), we should clear
all dirty flags for the involved folios.

Or the range of that folio will still be marked dirty, but has no
EXTENT_DEALLLOC set inside the io tree.

Since the folio range is still dirty, it will still be the target for
the next writeback, but since there is no EXTENT_DEALLLOC, no new
ordered extent will be created for it.

This means the writeback of that folio range will fall back to COW
fixup, which is being marked deprecated and will trigger a crash.

Unlike the fix in cow_file_range(), which holds the folio and extent
lock until error or a fully successfully run, here we have no such luxury
as we can fallback to COW, and in that case the extent/folio range will
be unlocked by cow_file_range().

So here we introduce a new helper, cleanup_dirty_folios(), to clear the
dirty flags for the involved folios.

Cc: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e8232ac7917f..19e1b78508bd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1969,6 +1969,46 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	return ret < 0 ? ret : can_nocow;
 }
 
+static void cleanup_dirty_folios(struct btrfs_inode *inode,
+				 struct folio *locked_folio,
+				 u64 start, u64 end, int error)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	pgoff_t start_index = start >> PAGE_SHIFT;
+	pgoff_t end_index = end >> PAGE_SHIFT;
+	u32 len;
+
+	ASSERT(end + 1 - start < U32_MAX);
+	len = end + 1 - start;
+
+	/*
+	 * Handle the locked folio first.
+	 * btrfs_folio_clamp_*() helpers can handle range out of the folio case.
+	 */
+	btrfs_folio_clamp_clear_dirty(fs_info, locked_folio, start, len);
+	btrfs_folio_clamp_set_writeback(fs_info, locked_folio, start, len);
+	btrfs_folio_clamp_clear_writeback(fs_info, locked_folio, start, len);
+
+	for (pgoff_t index = start_index; index <= end_index; index++) {
+		struct folio *folio;
+
+		/* Already handled at the beginning. */
+		if (index == locked_folio->index)
+			continue;
+		folio = __filemap_get_folio(mapping, index, FGP_LOCK, GFP_NOFS);
+		/* Cache already dropped, no need to do any cleanup. */
+		if (IS_ERR(folio))
+			continue;
+		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
+		btrfs_folio_clamp_set_writeback(fs_info, folio, start, len);
+		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+	mapping_set_error(mapping, error);
+}
+
 /*
  * when nowcow writeback call back.  This checks for snapshots or COW copies
  * of the extents that exist in the file, and COWs the file as required.
@@ -2228,6 +2268,22 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	return 0;
 
 error:
+	/*
+	 * We have some range with ordered extent created.
+	 *
+	 * Ordered extents and extent maps will be cleaned up by
+	 * btrfs_mark_ordered_io_finished() later, but we also need to cleanup
+	 * the dirty flags of folios.
+	 *
+	 * Or they can be written back again, but without any EXTENT_DELALLOC flag
+	 * in io tree.
+	 * This will force the writeback to go COW fixup, which is being deprecated.
+	 *
+	 * Also such left-over dirty flags do no follow the error handling protocol.
+	 */
+	if (cur_offset > start)
+		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
+
 	/*
 	 * If an error happened while a COW region is outstanding, cur_offset
 	 * needs to be reset to cow_start to ensure the COW region is unlocked
-- 
2.47.1


