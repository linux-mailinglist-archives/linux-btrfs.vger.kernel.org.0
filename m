Return-Path: <linux-btrfs+bounces-10287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749999EDF4B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7868D282808
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 06:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462F18C03A;
	Thu, 12 Dec 2024 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mRbsU+VL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i7PJemYJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E1185B4C
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984077; cv=none; b=s2XT0K4DtIIK9VgCmtepkIpFoUGah/P9FmqA5JIAWxHtOkMeZZ0eednLK6mOi5jfJTr3FelHlSfuAv0Gmyf9g1FWGMxvbdP+1AtapGrFKh8cKgGrspFBTaF95ULxe5VEetrgWtdpERwl03ccOVLheB02LMCdIYKqryYibbrVwBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984077; c=relaxed/simple;
	bh=+krZCVnlflCOD+ahlDdyYs0m7EGfNmqvSZgEa1c0jiE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPJtiqu5FwBbVVSTuGbtWJMC+5ovJLuX014oI2oC3Os/LMLdkiN9AezGs9geR2NbKthbjfQh7Ckl65ps8ZZNsiDMVLrtId1RFi/NYxj+yCOCwBZ4/wGguf5z/Y5miFI4fMIqXp58/8x7Ku7VOU3qWiUigLt4/ePTUET+YlKokD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mRbsU+VL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i7PJemYJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1C812116C
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733984074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eicjo4yVcPBeI76b7V1j3U1p/7BC9w91Rypfup3bLfk=;
	b=mRbsU+VLPW46p6twPGTuLObJnjf0psDfEMlWlSuxviwK1HzGARgTwm6dlcpO2jVRVR/aNj
	XtCCWrlQ4MhAExIusH4nxlL4+56LcDc5ME5pqoiYImtsdZi/YJkYG7YdFHn6m8VtCvnjnl
	UQrX8qGFQaMbUxnsAAcZN0RqQ+NjSCM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733984073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eicjo4yVcPBeI76b7V1j3U1p/7BC9w91Rypfup3bLfk=;
	b=i7PJemYJ8m1RxhVRkxgBW9tv9czJXAMI0bngDtHb2NAtIMagDAOhfBZ5EsVzKzOCVPJg7m
	QhdM81ZyyMLfj66qTtyTzA8CdLXofZZiFL4U68r2VC4LbvFtFXZa9KVs/vT4ryTLwW/xzT
	ymT5mMX+3UghTZhXELpoSd4bXbDdkWw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BB7E13508
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EPOmMkh/Wme5VQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 06:14:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 8/9] btrfs: add extra error messages for delalloc range related errors
Date: Thu, 12 Dec 2024 16:44:02 +1030
Message-ID: <68c6ef2938e3c55d4b3610744dd378d9441bf91a.1733983488.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
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

All the error handling bugs I hit so far are all -ENOSPC from either:

- cow_file_range()
- run_delalloc_nocow()
- submit_uncompressed_range()

Previously when those functions failed, there is no error message at
all, making the debugging much harder.

So here we introduce extra error messages for:

- cow_file_range()
- run_delalloc_nocow()
- submit_uncompressed_range()
- writepage_delalloc() when btrfs_run_delalloc_range() failed
- extent_writepage() when extent_writepage_io() failed

One example of the new debug error messages is the following one:

 run fstests generic/750 at 2024-12-08 12:41:41
 BTRFS: device fsid 461b25f5-e240-4543-8deb-e7c2bd01a6d3 devid 1 transid 8 /dev/mapper/test-scratch1 (253:4) scanned by mount (2436600)
 BTRFS info (device dm-4): first mount of filesystem 461b25f5-e240-4543-8deb-e7c2bd01a6d3
 BTRFS info (device dm-4): using crc32c (crc32c-arm64) checksum algorithm
 BTRFS info (device dm-4): forcing free space tree for sector size 4096 with page size 65536
 BTRFS info (device dm-4): using free-space-tree
 BTRFS warning (device dm-4): read-write for sector size 4096 with page size 65536 is experimental
 BTRFS info (device dm-4): checking UUID tree
 BTRFS error (device dm-4): cow_file_range failed, root=363 inode=412 start=503808 len=98304: -28
 BTRFS error (device dm-4): run_delalloc_nocow failed, root=363 inode=412 start=503808 len=98304: -28
 BTRFS error (device dm-4): failed to run delalloc range, root=363 ino=412 folio=458752 submit_bitmap=11-15 start=503808 len=98304: -28

Which shows an error from cow_file_range() which is called inside a
nocow write attempt, along with the extra bitmap from
writepage_delalloc().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++++++++++
 fs/btrfs/inode.c     | 14 +++++++++++++-
 fs/btrfs/subpage.c   |  3 ++-
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b6a4f1765b4c..f4fb1fb3454a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1254,6 +1254,15 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 						       wbc);
 			if (ret >= 0)
 				last_finished = found_start + found_len;
+			if (unlikely(ret < 0))
+				btrfs_err_rl(fs_info,
+"failed to run delalloc range, root=%lld ino=%llu folio=%llu submit_bitmap=%*pbl start=%llu len=%u: %d",
+					     inode->root->root_key.objectid,
+					     btrfs_ino(inode),
+					     folio_pos(folio),
+					     fs_info->sectors_per_page,
+					     &bio_ctrl->submit_bitmap,
+					     found_start, found_len, ret);
 		} else {
 			/*
 			 * We've hit an error during previous delalloc range,
@@ -1546,6 +1555,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 				  PAGE_SIZE, bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
+	if (ret < 0)
+		btrfs_err_rl(fs_info,
+"failed to submit blocks, root=%lld inode=%llu folio=%llu submit_bitmap=%*pbl: %d",
+			     BTRFS_I(inode)->root->root_key.objectid,
+			     btrfs_ino(BTRFS_I(inode)),
+			     folio_pos(folio), fs_info->sectors_per_page,
+			     &bio_ctrl->submit_bitmap, ret);
 
 	bio_ctrl->wbc->nr_to_write--;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bae8aceb3eae..a88cba85bf40 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1134,6 +1134,10 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 		if (locked_folio)
 			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
 					     start, async_extent->ram_size);
+		btrfs_err_rl(inode->root->fs_info,
+		"%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
+			     __func__, btrfs_root_id(inode->root),
+			     btrfs_ino(inode), start, async_extent->ram_size, ret);
 	}
 }
 
@@ -1246,7 +1250,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	free_async_extent_pages(async_extent);
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
-	btrfs_debug(fs_info,
+	btrfs_debug_rl(fs_info,
 "async extent submission failed root=%lld inode=%llu start=%llu len=%llu ret=%d",
 		    btrfs_root_id(root), btrfs_ino(inode), start,
 		    async_extent->ram_size, ret);
@@ -1580,6 +1584,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
 				       end - start - cur_alloc_size + 1, NULL);
 	}
+	btrfs_err_rl(fs_info,
+		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
+		     __func__, btrfs_root_id(inode->root),
+		     btrfs_ino(inode), orig_start, end + 1 - orig_start, ret);
 	return ret;
 }
 
@@ -2325,6 +2333,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
 	}
 	btrfs_free_path(path);
+	btrfs_err_rl(fs_info,
+		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
+		     __func__, btrfs_root_id(inode->root),
+		     btrfs_ino(inode), start, end + 1 - start, ret);
 	return ret;
 }
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index d692bc34a3af..7f47bc61389c 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -652,7 +652,7 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
 									\
 	GET_SUBPAGE_BITMAP(subpage, fs_info, name, &bitmap);		\
 	btrfs_warn(fs_info,						\
-	"dumpping bitmap start=%llu len=%u folio=%llu" #name "_bitmap=%*pbl", \
+	"dumpping bitmap start=%llu len=%u folio=%llu " #name "_bitmap=%*pbl", \
 		   start, len, folio_pos(folio),			\
 		   fs_info->sectors_per_page, &bitmap);			\
 }
@@ -717,6 +717,7 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 	/* Target range should not yet be locked. */
 	if (unlikely(!bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits))) {
 		subpage_dump_bitmap(fs_info, folio, locked, start, len);
+		btrfs_warn(fs_info, "nr_locked=%u\n", atomic_read(&subpage->nr_locked));
 		ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
 	}
 	bitmap_set(subpage->bitmaps, start_bit, nbits);
-- 
2.47.1


