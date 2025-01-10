Return-Path: <linux-btrfs+bounces-10893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734BA08604
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 04:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 370ED7A37BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 03:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800972063FF;
	Fri, 10 Jan 2025 03:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DXj71ASZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DXj71ASZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA7C2063EC
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479940; cv=none; b=LDwCdchoDunfKMRi7RZVHYqe5Bzv91OAEYOgER6K1vgtJJYtUTgniauB+tgn9jvBISCNQnDUQHKL1LtgqNgy+UDeL4nJHWGx2LMY/xYZIXuNzWdfS2I38am87vyo2XKD/3AOpg3NZzlPULdSBJO/BxZv1DoMGFRgyvxu6sOaUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479940; c=relaxed/simple;
	bh=6h6CnFIYBH3BHYTv/zyz6BKPuKbQDk5jvHnEVlYv9iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcFc79EnddZmR07xa2wdl7k11h6p6aLdFECQb34ZGzH40fda1o8e8nzBqRsAg8JEBcj7KlRad1HZa4oAoZYcy+UQrkK3WR5P4s5WVXe7lZZUgB7XSISl6vooaTXXf3mLKpLnwRJbvJdxifYBqdZ9de2CvFwSwCb0upINAIhfGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DXj71ASZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DXj71ASZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0ABD1F394;
	Fri, 10 Jan 2025 03:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEXFAGY8iBNt5GPp/mWa9k02H9WicySpChy3cjE8GkI=;
	b=DXj71ASZfCOpHduebNt+NoTcofo0IrBS41flQixziZb2T407Cly/5obRlt1hcFcKFf1bGZ
	miNqeIkigIIY4MR3MXFhY4YmJTITmG1ECLci0qYFzduS1nOjLYhPWUggAeTIXtppYXDujv
	dDJN4EUn48c3JRtf7BFJygLsuV2YeQQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DXj71ASZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OEXFAGY8iBNt5GPp/mWa9k02H9WicySpChy3cjE8GkI=;
	b=DXj71ASZfCOpHduebNt+NoTcofo0IrBS41flQixziZb2T407Cly/5obRlt1hcFcKFf1bGZ
	miNqeIkigIIY4MR3MXFhY4YmJTITmG1ECLci0qYFzduS1nOjLYhPWUggAeTIXtppYXDujv
	dDJN4EUn48c3JRtf7BFJygLsuV2YeQQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C10C11397D;
	Fri, 10 Jan 2025 03:32:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2MaQIL+UgGe0NQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 10 Jan 2025 03:32:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v3 08/10] btrfs: add extra error messages for delalloc range related errors
Date: Fri, 10 Jan 2025 14:01:39 +1030
Message-ID: <ac9345c0d31fc1b669ccfe436e49883ed998ab07.1736479224.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: C0ABD1F394
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
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

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++++++++++
 fs/btrfs/inode.c     | 14 +++++++++++++-
 fs/btrfs/subpage.c   |  3 ++-
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 54081b1783fc..615f03fb5d97 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1263,6 +1263,15 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 						       wbc);
 			if (ret >= 0)
 				last_finished_delalloc_end = found_start + found_len;
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
@@ -1561,6 +1570,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
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
index a450fc080ca3..c8145a588f45 100644
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
 
@@ -2327,6 +2335,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
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


