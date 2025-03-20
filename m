Return-Path: <linux-btrfs+bounces-12450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D96A69F64
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 06:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E608A4B5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 05:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AF61E0DEB;
	Thu, 20 Mar 2025 05:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IHbCwAVo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IHbCwAVo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DC8155753
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742448896; cv=none; b=E81v6XKKVoSzcptGluKydbB/roAD3H8tXaJW+B97cZZMEGR181ltekFH1IzIV0qn4rDx4eEXWplFYLKXuYgm8rRmmyWH1l7t3LkGz/RFI5DEdaDPhNJHrxaH6e4+yntlgpkWvI+hiAkcmkIYi+1kI/bB56Zu81Qi0Uk6CJBb3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742448896; c=relaxed/simple;
	bh=jDx3cfBlfTyhTvibHPP2rZNK9cIT66Na8XuGCrZNZeM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbdXGvDR9++Cta+O/x8U0yKa76KFBDszsQE6925HbFwrQvZKqfJLoMBW2HoI3lLo1LKQpAEG+Dm/SbEwtSmKzHBZfRSzHekVlDbHWV6iF4WHU4frgLYFx+7JlMFD8jUQGds11/4SiBAaKCLkZifnQ6JjveFHjE5sz8tLMe9gWMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IHbCwAVo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IHbCwAVo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4051721A70
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742448878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSWImleFoAF76OBvDIww0eoC58in+yC/VVps7GpdGcI=;
	b=IHbCwAVo+KfW6I8ILDpCjMCUMsWSv8cNJ7I7hehL84SveU+TtD7Fgk0fFuU7puxyuaQnwx
	HzyJIXNV1SV7VTPLVg9zcciUgKKISeX1jDl9JFM5JZ9J0pyBSjm2CpaYtXMinHG2Mpd69b
	j8mFth/ML/nF2zd1jyBJCH5s2SF6tF8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742448878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSWImleFoAF76OBvDIww0eoC58in+yC/VVps7GpdGcI=;
	b=IHbCwAVo+KfW6I8ILDpCjMCUMsWSv8cNJ7I7hehL84SveU+TtD7Fgk0fFuU7puxyuaQnwx
	HzyJIXNV1SV7VTPLVg9zcciUgKKISeX1jDl9JFM5JZ9J0pyBSjm2CpaYtXMinHG2Mpd69b
	j8mFth/ML/nF2zd1jyBJCH5s2SF6tF8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D10E138A5
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yAbhNuyo22fcMQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Mar 2025 05:34:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: extract the main loop of btrfs_buffered_write() into a helper
Date: Thu, 20 Mar 2025 16:04:11 +1030
Message-ID: <4710798bb9d917697384db6abbae75ac8a5ab6cf.1742443383.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742443383.git.wqu@suse.com>
References: <cover.1742443383.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Inside the main loop of btrfs_buffered_write() we are doing a lot of
heavy lift work inside a while () loop.

This makes it pretty hard to read, extract the content into a helper,
copy_one_range() to do the heavy lift work.

This has no functional change, but with some minor variable renames,
e.g. rename all "sector" into "block".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 292 ++++++++++++++++++++++++------------------------
 1 file changed, 147 insertions(+), 145 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 99580ef906a6..21b90ed3e0e4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1153,21 +1153,161 @@ static ssize_t reserve_space(struct btrfs_inode *inode,
 	return reserve_bytes;
 }
 
+/*
+ * Do the heavy lift work to copy one range into one folio of the page cache.
+ *
+ * Return >=0 for the number of bytes copied. (Return 0 means no byte is copied,
+ * caller should retry the same range again).
+ * Return <0 for error.
+ */
+static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *i,
+			  struct extent_changeset **data_reserved,
+			  u64 start, bool nowait)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_state *cached_state = NULL;
+	const size_t block_offset = start & (fs_info->sectorsize - 1);
+	size_t write_bytes = min(iov_iter_count(i), PAGE_SIZE - offset_in_page(start));
+	size_t reserve_bytes;
+	size_t copied;
+	size_t dirty_blocks;
+	size_t num_blocks;
+	struct folio *folio = NULL;
+	u64 release_bytes = 0;
+	int extents_locked;
+	u64 lockstart;
+	u64 lockend;
+	bool only_release_metadata = false;
+	const unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
+	int ret;
+
+	/*
+	 * Fault pages before locking them in prepare_one_folio()
+	 * to avoid recursive lock
+	 */
+	if (unlikely(fault_in_iov_iter_readable(i, write_bytes)))
+		return -EFAULT;
+	extent_changeset_release(*data_reserved);
+	ret = reserve_space(inode, data_reserved, start, &write_bytes, nowait,
+			    &only_release_metadata);
+	if (ret < 0)
+		return ret;
+	reserve_bytes = ret;
+	release_bytes = reserve_bytes;
+
+again:
+	ret = balance_dirty_pages_ratelimited_flags(inode->vfs_inode.i_mapping,
+						    bdp_flags);
+	if (ret) {
+		btrfs_delalloc_release_extents(inode, reserve_bytes);
+		release_space(inode, *data_reserved, start, release_bytes,
+			      only_release_metadata);
+		return ret;
+	}
+
+	ret = prepare_one_folio(&inode->vfs_inode, &folio, start, write_bytes, false);
+	if (ret) {
+		btrfs_delalloc_release_extents(inode, reserve_bytes);
+		release_space(inode, *data_reserved, start, release_bytes,
+			      only_release_metadata);
+		return ret;
+	}
+	extents_locked = lock_and_cleanup_extent_if_need(inode,
+					folio, start, write_bytes, &lockstart,
+					&lockend, nowait, &cached_state);
+	if (extents_locked < 0) {
+		if (!nowait && extents_locked == -EAGAIN)
+			goto again;
+
+		btrfs_delalloc_release_extents(inode, reserve_bytes);
+		release_space(inode, *data_reserved, start, release_bytes,
+			      only_release_metadata);
+		ret = extents_locked;
+		return ret;
+	}
+
+	copied = copy_folio_from_iter_atomic(folio,
+			offset_in_folio(folio, start), write_bytes, i);
+	flush_dcache_folio(folio);
+
+	/*
+	 * If we get a partial write, we can end up with partially
+	 * uptodate page. Although if sector size < page size we can
+	 * handle it, but if it's not sector aligned it can cause
+	 * a lot of complexity, so make sure they don't happen by
+	 * forcing retry this copy.
+	 */
+	if (unlikely(copied < write_bytes)) {
+		if (!folio_test_uptodate(folio)) {
+			iov_iter_revert(i, copied);
+			copied = 0;
+		}
+	}
+
+	num_blocks = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
+	dirty_blocks = round_up(copied + block_offset, fs_info->sectorsize);
+	dirty_blocks = BTRFS_BYTES_TO_BLKS(fs_info, dirty_blocks);
+
+	if (copied == 0)
+		dirty_blocks = 0;
+
+	if (num_blocks > dirty_blocks) {
+		/* release everything except the sectors we dirtied */
+		release_bytes -= dirty_blocks << fs_info->sectorsize_bits;
+		if (only_release_metadata) {
+			btrfs_delalloc_release_metadata(inode,
+						release_bytes, true);
+		} else {
+			u64 release_start = round_up(start + copied,
+						     fs_info->sectorsize);
+			btrfs_delalloc_release_space(inode,
+					*data_reserved, release_start,
+					release_bytes, true);
+		}
+	}
+	release_bytes = round_up(copied + block_offset, fs_info->sectorsize);
+
+	ret = btrfs_dirty_folio(inode, folio, start, copied,
+				&cached_state, only_release_metadata);
+	/*
+	 * If we have not locked the extent range, because the range's
+	 * start offset is >= i_size, we might still have a non-NULL
+	 * cached extent state, acquired while marking the extent range
+	 * as delalloc through btrfs_dirty_page(). Therefore free any
+	 * possible cached extent state to avoid a memory leak.
+	 */
+	if (extents_locked)
+		unlock_extent(&inode->io_tree, lockstart, lockend,
+			      &cached_state);
+	else
+		free_extent_state(cached_state);
+
+	btrfs_delalloc_release_extents(inode, reserve_bytes);
+	if (ret) {
+		btrfs_drop_folio(fs_info, folio, start, copied);
+		release_space(inode, *data_reserved, start, release_bytes,
+			      only_release_metadata);
+		return ret;
+	}
+	if (only_release_metadata)
+		btrfs_check_nocow_unlock(inode);
+
+	btrfs_drop_folio(fs_info, folio, start, copied);
+	cond_resched();
+	return copied;
+}
+
 ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
 	loff_t pos;
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct extent_changeset *data_reserved = NULL;
-	u64 lockstart;
-	u64 lockend;
 	size_t num_written = 0;
 	ssize_t ret;
 	loff_t old_isize;
 	unsigned int ilock_flags = 0;
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
-	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
 
 	if (nowait)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1193,149 +1333,11 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 
 	pos = iocb->ki_pos;
 	while (iov_iter_count(i) > 0) {
-		struct extent_state *cached_state = NULL;
-		size_t offset = offset_in_page(pos);
-		size_t sector_offset;
-		size_t write_bytes = min(iov_iter_count(i), PAGE_SIZE - offset);
-		size_t reserve_bytes;
-		size_t copied;
-		size_t dirty_sectors;
-		size_t num_sectors;
-		struct folio *folio = NULL;
-		u64 release_bytes = 0;
-		int extents_locked;
-		bool only_release_metadata = false;
-
-		/*
-		 * Fault pages before locking them in prepare_one_folio()
-		 * to avoid recursive lock
-		 */
-		if (unlikely(fault_in_iov_iter_readable(i, write_bytes))) {
-			ret = -EFAULT;
-			break;
-		}
-
-		sector_offset = pos & (fs_info->sectorsize - 1);
-
-		extent_changeset_release(data_reserved);
-		ret = reserve_space(BTRFS_I(inode), &data_reserved, pos,
-				    &write_bytes, nowait,
-				    &only_release_metadata);
+		ret = copy_one_range(BTRFS_I(inode), i, &data_reserved, pos, nowait);
 		if (ret < 0)
 			break;
-		reserve_bytes = ret;
-		release_bytes = reserve_bytes;
-again:
-		ret = balance_dirty_pages_ratelimited_flags(inode->i_mapping, bdp_flags);
-		if (ret) {
-			btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
-			release_space(BTRFS_I(inode), data_reserved,
-				      pos, release_bytes, only_release_metadata);
-			break;
-		}
-
-		ret = prepare_one_folio(inode, &folio, pos, write_bytes, false);
-		if (ret) {
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-						       reserve_bytes);
-			release_space(BTRFS_I(inode), data_reserved,
-				      pos, release_bytes, only_release_metadata);
-			break;
-		}
-
-		extents_locked = lock_and_cleanup_extent_if_need(BTRFS_I(inode),
-						folio, pos, write_bytes, &lockstart,
-						&lockend, nowait, &cached_state);
-		if (extents_locked < 0) {
-			if (!nowait && extents_locked == -EAGAIN)
-				goto again;
-
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-						       reserve_bytes);
-			release_space(BTRFS_I(inode), data_reserved,
-				      pos, release_bytes, only_release_metadata);
-			ret = extents_locked;
-			break;
-		}
-
-		copied = copy_folio_from_iter_atomic(folio,
-				offset_in_folio(folio, pos), write_bytes, i);
-		flush_dcache_folio(folio);
-
-		/*
-		 * If we get a partial write, we can end up with partially
-		 * uptodate page. Although if sector size < page size we can
-		 * handle it, but if it's not sector aligned it can cause
-		 * a lot of complexity, so make sure they don't happen by
-		 * forcing retry this copy.
-		 */
-		if (unlikely(copied < write_bytes)) {
-			if (!folio_test_uptodate(folio)) {
-				iov_iter_revert(i, copied);
-				copied = 0;
-			}
-		}
-
-		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
-		dirty_sectors = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
-
-		if (copied == 0)
-			dirty_sectors = 0;
-
-		if (num_sectors > dirty_sectors) {
-			/* release everything except the sectors we dirtied */
-			release_bytes -= dirty_sectors << fs_info->sectorsize_bits;
-			if (only_release_metadata) {
-				btrfs_delalloc_release_metadata(BTRFS_I(inode),
-							release_bytes, true);
-			} else {
-				u64 release_start = round_up(pos + copied,
-							     fs_info->sectorsize);
-				btrfs_delalloc_release_space(BTRFS_I(inode),
-						data_reserved, release_start,
-						release_bytes, true);
-			}
-		}
-
-		release_bytes = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-
-		ret = btrfs_dirty_folio(BTRFS_I(inode), folio, pos, copied,
-					&cached_state, only_release_metadata);
-
-		/*
-		 * If we have not locked the extent range, because the range's
-		 * start offset is >= i_size, we might still have a non-NULL
-		 * cached extent state, acquired while marking the extent range
-		 * as delalloc through btrfs_dirty_page(). Therefore free any
-		 * possible cached extent state to avoid a memory leak.
-		 */
-		if (extents_locked)
-			unlock_extent(&BTRFS_I(inode)->io_tree, lockstart,
-				      lockend, &cached_state);
-		else
-			free_extent_state(cached_state);
-
-		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
-		if (ret) {
-			btrfs_drop_folio(fs_info, folio, pos, copied);
-			release_space(BTRFS_I(inode), data_reserved,
-				      pos, release_bytes, only_release_metadata);
-			break;
-		}
-
-		release_bytes = 0;
-		if (only_release_metadata)
-			btrfs_check_nocow_unlock(BTRFS_I(inode));
-
-		btrfs_drop_folio(fs_info, folio, pos, copied);
-
-		cond_resched();
-
-		pos += copied;
-		num_written += copied;
+		pos += ret;
+		num_written += ret;
 	}
 
 	extent_changeset_free(data_reserved);
-- 
2.49.0


