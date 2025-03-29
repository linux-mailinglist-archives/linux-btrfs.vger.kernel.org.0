Return-Path: <linux-btrfs+bounces-12674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17326A7556D
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 10:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79744170605
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4F81A9B5D;
	Sat, 29 Mar 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RJ+f3D3r";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RJ+f3D3r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A31624C0
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743240021; cv=none; b=IlzKr9nLvGzp/jJ2UO4xiSZDO4ggeKAvgkB/v5RmWTZlg4zYZG8SAEXW0eCgZYKE5gA+6B8MFFP2QXuaVTUgO+fhDTPCPYatjzITWLclwN2g5w6LnnWIZj7TGDL5upguQ/2Vu54hvbwx+KAkeTz2ynITWZGwdXSlNYLr2iXcuzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743240021; c=relaxed/simple;
	bh=9J6vn5Fkh3AsAy1ive6p43J+ZUoO1aoq3Cv5Crjc2/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3uG7EBxTLc+mPoVtu3NJgWp9KA3OMXQSg3SU3W5tsU3KLmsHZe5xYo+VooIEf7RnrVtc7EV+LJ/HbndLgpn0yM/ZsRVWXGYL2IfqersLMOFCsO5bJ4p7SvMSp4AYMnYaqGfhTiV9ZL9KVx2iFb9CTuqqn/xJk/lf56PnO5sLWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RJ+f3D3r; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RJ+f3D3r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20BDB2120F;
	Sat, 29 Mar 2025 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8+Rlr03acQM+MQe0FjXIy8wqh/ugRH3ztNsgAuSe74=;
	b=RJ+f3D3rRQovky8jZ6v2pxbzmRvllOkdR3CcT+6HvExc1DkrxZ3XFfiyKfa+iihROFVXwp
	oALj2HG6vz0ZAissDoCznrsD/ul979aKormXzOl4B7WHuSe3YKsxM2lQr6S58E9aI16Wuw
	EJgVJdvZ5EYJl9dJrWuqlNzaX3wrGBY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8+Rlr03acQM+MQe0FjXIy8wqh/ugRH3ztNsgAuSe74=;
	b=RJ+f3D3rRQovky8jZ6v2pxbzmRvllOkdR3CcT+6HvExc1DkrxZ3XFfiyKfa+iihROFVXwp
	oALj2HG6vz0ZAissDoCznrsD/ul979aKormXzOl4B7WHuSe3YKsxM2lQr6S58E9aI16Wuw
	EJgVJdvZ5EYJl9dJrWuqlNzaX3wrGBY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EBAE13A41;
	Sat, 29 Mar 2025 09:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UNRRNEW752cCEQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 29 Mar 2025 09:20:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 3/5] btrfs: refactor how we handle reserved space inside copy_one_range()
Date: Sat, 29 Mar 2025 19:49:38 +1030
Message-ID: <d48a2e731328e41a9d041472a92564925f51d32a.1743239672.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743239672.git.wqu@suse.com>
References: <cover.1743239672.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

There are several things not ideal inside copy_one_range():

- Unnecessary temporary variables
  * block_offset
  * reserve_bytes
  * dirty_blocks
  * num_blocks
  * release_bytes
  These are utilized to handle short-copy cases.

- Inconsistent handling of btrfs_delalloc_release_extents()
  There is a hidden behavior that, after reserving metadata for X bytes
  of data write, we have to call btrfs_delalloc_release_extents() with X
  once and only once.

  Calling btrfs_delalloc_release_extents(X - 4K) and
  btrfs_delalloc_release_extents(4K) will cause outstanding extents
  accounting to go wrong.

  This is because the outstanding extents mechanism is not designed to
  handle shrink of reserved space.

Improve above situations by:

- Use a single @reserved_start and @reserved_len pair
  Now we reserved space for the initial range, and if a short copy
  happened and we need to shrink the reserved space, we can easily
  calculate the new length, and update @reserved_len.

- Introduce helpers to shrink reserved data and metadata space
  This is done by two new helper, shrink_reserved_space() and
  btrfs_delalloc_shrink_extents().

  The later will do a better calculation on if we need to modify the
  outstanding extents, and the first one will be utilized inside
  copy_one_range().

- Manually unlock, release reserved space and return if no byte is
  copied

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/delalloc-space.c |  24 +++++++++
 fs/btrfs/delalloc-space.h |   3 +-
 fs/btrfs/file.c           | 102 ++++++++++++++++++++++----------------
 3 files changed, 86 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 88e900e5a43d..82289c860476 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -439,6 +439,30 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes)
 	btrfs_inode_rsv_release(inode, true);
 }
 
+/* Shrink a previously reserved extent to a new length. */
+void btrfs_delalloc_shrink_extents(struct btrfs_inode *inode, u64 reserved_len,
+				   u64 new_len)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u32 reserved_num_extents = count_max_extents(fs_info, reserved_len);
+	const u32 new_num_extents = count_max_extents(fs_info, new_len);
+	const int diff_num_extents = new_num_extents - reserved_num_extents;
+
+	ASSERT(new_len <= reserved_len);
+	if (new_num_extents == reserved_num_extents)
+		return;
+
+	spin_lock(&inode->lock);
+	btrfs_mod_outstanding_extents(inode, diff_num_extents);
+	btrfs_calculate_inode_block_rsv_size(fs_info, inode);
+	spin_unlock(&inode->lock);
+
+	if (btrfs_is_testing(fs_info))
+		return;
+
+	btrfs_inode_rsv_release(inode, true);
+}
+
 /*
  * Reserve data and metadata space for delalloc
  *
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index 3f32953c0a80..c61580c63caf 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -27,5 +27,6 @@ int btrfs_delalloc_reserve_space(struct btrfs_inode *inode,
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				    u64 disk_num_bytes, bool noflush);
 void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes);
-
+void btrfs_delalloc_shrink_extents(struct btrfs_inode *inode, u64 reserved_len,
+				   u64 new_len);
 #endif /* BTRFS_DELALLOC_SPACE_H */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7c147ef9368d..e421b64f7038 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1151,6 +1151,23 @@ static ssize_t reserve_space(struct btrfs_inode *inode,
 	return reserve_bytes;
 }
 
+/* Shrink the reserved data and metadata space from @reserved_len to @new_len. */
+static void shrink_reserved_space(struct btrfs_inode *inode,
+				  struct extent_changeset *data_reserved,
+				  u64 reserved_start, u64 reserved_len,
+				  u64 new_len, bool only_release_metadata)
+{
+	const u64 diff = reserved_len - new_len;
+
+	ASSERT(new_len <= reserved_len);
+	btrfs_delalloc_shrink_extents(inode, reserved_len, new_len);
+	if (only_release_metadata)
+		btrfs_delalloc_release_metadata(inode, diff, true);
+	else
+		btrfs_delalloc_release_space(inode, data_reserved,
+					     reserved_start + new_len, diff, true);
+}
+
 /*
  * Do the heavy-lifting work to copy one range into one folio of the page cache.
  *
@@ -1164,14 +1181,11 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_state *cached_state = NULL;
-	const size_t block_offset = (start & (fs_info->sectorsize - 1));
 	size_t write_bytes = min(iov_iter_count(iter), PAGE_SIZE - offset_in_page(start));
-	size_t reserve_bytes;
 	size_t copied;
-	size_t dirty_blocks;
-	size_t num_blocks;
+	const u64 reserved_start = round_down(start, fs_info->sectorsize);
+	u64 reserved_len;
 	struct folio *folio = NULL;
-	u64 release_bytes;
 	int extents_locked;
 	u64 lockstart;
 	u64 lockend;
@@ -1190,23 +1204,25 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 			    &only_release_metadata);
 	if (ret < 0)
 		return ret;
-	reserve_bytes = ret;
-	release_bytes = reserve_bytes;
+	reserved_len = ret;
+	/* Write range must be inside the reserved range. */
+	ASSERT(reserved_start <= start);
+	ASSERT(start + write_bytes <= reserved_start + reserved_len);
 
 again:
 	ret = balance_dirty_pages_ratelimited_flags(inode->vfs_inode.i_mapping,
 						    bdp_flags);
 	if (ret) {
-		btrfs_delalloc_release_extents(inode, reserve_bytes);
-		release_space(inode, *data_reserved, start, release_bytes,
+		btrfs_delalloc_release_extents(inode, reserved_len);
+		release_space(inode, *data_reserved, reserved_start, reserved_len,
 			      only_release_metadata);
 		return ret;
 	}
 
 	ret = prepare_one_folio(&inode->vfs_inode, &folio, start, write_bytes, false);
 	if (ret) {
-		btrfs_delalloc_release_extents(inode, reserve_bytes);
-		release_space(inode, *data_reserved, start, release_bytes,
+		btrfs_delalloc_release_extents(inode, reserved_len);
+		release_space(inode, *data_reserved, reserved_start, reserved_len,
 			      only_release_metadata);
 		return ret;
 	}
@@ -1217,8 +1233,8 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 		if (!nowait && extents_locked == -EAGAIN)
 			goto again;
 
-		btrfs_delalloc_release_extents(inode, reserve_bytes);
-		release_space(inode, *data_reserved, start, release_bytes,
+		btrfs_delalloc_release_extents(inode, reserved_len);
+		release_space(inode, *data_reserved, reserved_start, reserved_len,
 			      only_release_metadata);
 		ret = extents_locked;
 		return ret;
@@ -1228,41 +1244,43 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 					     write_bytes, iter);
 	flush_dcache_folio(folio);
 
-	/*
-	 * If we get a partial write, we can end up with partially uptodate
-	 * page. Although if sector size < page size we can handle it, but if
-	 * it's not sector aligned it can cause a lot of complexity, so make
-	 * sure they don't happen by forcing retry this copy.
-	 */
 	if (unlikely(copied < write_bytes)) {
+		u64 last_block;
+
+		/*
+		 * The original write range doesn't need an uptodate folio as
+		 * the range is block aligned. But now a short copy happened.
+		 * We can not handle it without an uptodate folio.
+		 *
+		 * So just revert the range and we will retry.
+		 */
 		if (!folio_test_uptodate(folio)) {
 			iov_iter_revert(iter, copied);
 			copied = 0;
 		}
-	}
 
-	num_blocks = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
-	dirty_blocks = round_up(copied + block_offset, fs_info->sectorsize);
-	dirty_blocks = BTRFS_BYTES_TO_BLKS(fs_info, dirty_blocks);
-
-	if (copied == 0)
-		dirty_blocks = 0;
-
-	if (num_blocks > dirty_blocks) {
-		/* Release everything except the sectors we dirtied. */
-		release_bytes -= dirty_blocks << fs_info->sectorsize_bits;
-		if (only_release_metadata) {
-			btrfs_delalloc_release_metadata(inode, release_bytes, true);
-		} else {
-			const u64 release_start = round_up(start + copied,
-							   fs_info->sectorsize);
-
-			btrfs_delalloc_release_space(inode, *data_reserved,
-						     release_start, release_bytes,
-						     true);
+		/* No copied byte, unlock, release reserved space and exit. */
+		if (copied == 0) {
+			if (extents_locked)
+				unlock_extent(&inode->io_tree, lockstart, lockend,
+					      &cached_state);
+			else
+				free_extent_state(cached_state);
+			btrfs_delalloc_release_extents(inode, reserved_len);
+			release_space(inode, *data_reserved, reserved_start, reserved_len,
+				      only_release_metadata);
+			btrfs_drop_folio(fs_info, folio, start, copied);
+			return 0;
 		}
+
+		/* Release the reserved space beyond the last block. */
+		last_block = round_up(start + copied, fs_info->sectorsize);
+
+		shrink_reserved_space(inode, *data_reserved, reserved_start,
+				      reserved_len, last_block - reserved_start,
+				      only_release_metadata);
+		reserved_len = last_block - reserved_start;
 	}
-	release_bytes = round_up(copied + block_offset, fs_info->sectorsize);
 
 	ret = btrfs_dirty_folio(inode, folio, start, copied, &cached_state,
 				only_release_metadata);
@@ -1278,10 +1296,10 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 	else
 		free_extent_state(cached_state);
 
-	btrfs_delalloc_release_extents(inode, reserve_bytes);
+	btrfs_delalloc_release_extents(inode, reserved_len);
 	if (ret) {
 		btrfs_drop_folio(fs_info, folio, start, copied);
-		release_space(inode, *data_reserved, start, release_bytes,
+		release_space(inode, *data_reserved, reserved_start, reserved_len,
 			      only_release_metadata);
 		return ret;
 	}
-- 
2.49.0


