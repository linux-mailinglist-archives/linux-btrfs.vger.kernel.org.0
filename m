Return-Path: <linux-btrfs+bounces-10046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D59E3172
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 03:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A41686F0
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 02:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE1843166;
	Wed,  4 Dec 2024 02:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YCT8poIT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YCT8poIT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E344A1A;
	Wed,  4 Dec 2024 02:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733279741; cv=none; b=Y6U5KnenA18FTZUjZWDxbvWPS8GqNOE6gvNjMaFtsUwO3wzf+J/xTUVjpxUjR8cHbNTF7zUEnhPJaUikDWUi7orq+D089MSoYFLGrpX2ufBDLlQ63PtFpcJ4IoQ9FbiXGiXCTrZ+1lWrqNOC1lrm8GBkWgslD7VjdzTrEoWm1yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733279741; c=relaxed/simple;
	bh=54gpq9lbdu4XXYEXEX/C/VGD7366w35BbGQtWk/u1fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5JuH0toAVDpKugDPCVa+7CCaDD9H91CWEYmogVWjhQnN3IYLuha78ziAANMEWaa+0okAVrEPs5WWrgDQxjJ0MmG5evN+QcLCzJP+CjitEbnq4sW+4sYCPtXRzj8k9ljw9X0CqodHISpi0qzGrT64HX2qO5nCi2C/Ok5EGnheik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YCT8poIT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YCT8poIT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 713C921161;
	Wed,  4 Dec 2024 02:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733279737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tyVJw/sbB7y7vYxyIg6DZMsBJtY3WN4eDJHe1hdWIL8=;
	b=YCT8poIT32yYtu0F+R9ogauY+3+GXZxxr5QlDTF1kFMd1MStZh7Q/XM2t5CiHnGEs58bzd
	8hEhjlQ8ZuQxgQsMmyy9Bp+UsWa6mBzosj2vj54fXXUJdTyaoaXQC7GduR0mbJAYyBei3d
	vw7p9ibhpjn3/nyP6HnNBAsJ1nKbrus=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733279737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tyVJw/sbB7y7vYxyIg6DZMsBJtY3WN4eDJHe1hdWIL8=;
	b=YCT8poIT32yYtu0F+R9ogauY+3+GXZxxr5QlDTF1kFMd1MStZh7Q/XM2t5CiHnGEs58bzd
	8hEhjlQ8ZuQxgQsMmyy9Bp+UsWa6mBzosj2vj54fXXUJdTyaoaXQC7GduR0mbJAYyBei3d
	vw7p9ibhpjn3/nyP6HnNBAsJ1nKbrus=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EB6513418;
	Wed,  4 Dec 2024 02:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5fEuDPi/T2fnAQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 04 Dec 2024 02:35:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] btrfs: do proper folio cleanup when run_delalloc_nocow() failed
Date: Wed,  4 Dec 2024 13:05:14 +1030
Message-ID: <3e5d5665ef36ee43e310be321073210785b89adc.1733273653.git.wqu@suse.com>
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
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
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
fixup path. However the COW fixup path itself is being re-evaluated as
the newly introduced pin_user_pages_*() should prevent us hitting an
out-of-band dirty folios, and we're moving to deprecate such COW fixup
path.

We already have an experimental patch that will make fixup COW path to
crash, to verify there is no such out-of-band dirty folios anymore.
So here we need to avoid going COW fixup path, by doing proper folio
dirty flags cleanup.

Unlike the fix in cow_file_range(), which holds the folio and extent
lock until error or a fully successfully run, here we have no such luxury
as we can fallback to COW, and in that case the extent/folio range will
be unlocked by cow_file_range().

So here we introduce a new helper, cleanup_dirty_folios(), to clear the
dirty flags for the involved folios.

And since the final fallback_to_cow() call can also fail, and we rely on
@cur_offset to do the proper cleanup, here we remove the unnecessary and
incorrect @cur_offset assignment.

Cc: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix the incorrect @cur_offset assignment to @end
  The @end is not aligned to sector size, nor @cur_offset should be
  updated before fallback_to_cow() succeeded.

- Add one extra ASSERT() to make sure the range is properly aligned
---
 fs/btrfs/inode.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e8232ac7917f..92df6dfff2e4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1969,6 +1969,48 @@ static int can_nocow_file_extent(struct btrfs_path *path,
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
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
+	       IS_ALIGNED(end + 1, fs_info->sectorsize));
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
@@ -2217,7 +2259,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		cow_start = cur_offset;
 
 	if (cow_start != (u64)-1) {
-		cur_offset = end;
 		ret = fallback_to_cow(inode, locked_folio, cow_start, end);
 		cow_start = (u64)-1;
 		if (ret)
@@ -2228,6 +2269,22 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
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


