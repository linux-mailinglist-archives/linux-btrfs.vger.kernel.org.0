Return-Path: <linux-btrfs+bounces-10920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E8AA0A2E9
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 11:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A2BB7A1343
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071421925BA;
	Sat, 11 Jan 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gALn+pZc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gALn+pZc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5E193094
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592263; cv=none; b=PpVO8PhXZA67jx8VlDs92bAb3ij5+88uraL6Uhl9eHDFR74ASL+BpK/g9l4CKvUqLmCZdRGaqgSKn7xRwrcaYUHnfyHFXH9Nom39u722Y/eBWD5qBOl6uXmEEneJchqktwi+AQ+hbivyNcGOJ3FB5QaRKt2p+0SNMe+xuk1yiPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592263; c=relaxed/simple;
	bh=Z40q/ufzz1Dc2twWhLasewlzHMBoMkZGgSqS6QZhvCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2KKq1PzSqJHDIQw4uJVP6RBQbnT5JvBpj+eWqyehuBW8pbnIHVktSBYzQnU6o3/rGu7LFFHo6SMr+WrEzVHbWIqUwcO18um3iZW5E51FyO/V+I/GKUmCepAR8H0qD7Utdtc9leOS1GWrkwMhawHS1PCcLtDArKPS9Xh4VQXfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gALn+pZc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gALn+pZc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E42F1F37C;
	Sat, 11 Jan 2025 10:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDwiBHbJlrF9MUDpN90rAy9b8cJ2h9WuOFML8hjrxlY=;
	b=gALn+pZcx5Da+pJbF5JWxzAQPvB+SI2GqbUxkqh621Es2UB3v9eIlrng0ydRvU+rBMsZ6c
	lVr1Z3tC2bYtdPR6xQNtgjyphPdzWp2L2Gxv2z1Fx/esNyVUEOCF2vdEFbUDPC3Ns7qmMA
	RyEWowtyYMVwC9xVEW92m9l0VsmOCVs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDwiBHbJlrF9MUDpN90rAy9b8cJ2h9WuOFML8hjrxlY=;
	b=gALn+pZcx5Da+pJbF5JWxzAQPvB+SI2GqbUxkqh621Es2UB3v9eIlrng0ydRvU+rBMsZ6c
	lVr1Z3tC2bYtdPR6xQNtgjyphPdzWp2L2Gxv2z1Fx/esNyVUEOCF2vdEFbUDPC3Ns7qmMA
	RyEWowtyYMVwC9xVEW92m9l0VsmOCVs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DF9413A8B;
	Sat, 11 Jan 2025 10:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WBV+AIJLgmdCLgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 Jan 2025 10:44:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v4 08/10] btrfs: add extra error messages for delalloc range related errors
Date: Sat, 11 Jan 2025 21:13:42 +1030
Message-ID: <0e74b8be42025c25f2425d3eda0cda4bf7cebde6.1736591758.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736591758.git.wqu@suse.com>
References: <cover.1736591758.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
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

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 16 ++++++++++++++++
 fs/btrfs/inode.c     | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f50e4fccd909..72342663341c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1255,6 +1255,15 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 						       wbc);
 			if (ret >= 0)
 				last_finished_delalloc_end = found_start + found_len;
+			if (unlikely(ret < 0))
+				btrfs_err_rl(fs_info,
+"failed to run delalloc range, root=%lld ino=%llu folio=%llu submit_bitmap=%*pbl start=%llu len=%u: %d",
+					     btrfs_root_id(inode->root),
+					     btrfs_ino(inode),
+					     folio_pos(folio),
+					     fs_info->sectors_per_page,
+					     &bio_ctrl->submit_bitmap,
+					     found_start, found_len, ret);
 		} else {
 			/*
 			 * We've hit an error during previous delalloc range,
@@ -1553,6 +1562,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 				  PAGE_SIZE, bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
+	if (ret < 0)
+		btrfs_err_rl(fs_info,
+"failed to submit blocks, root=%lld inode=%llu folio=%llu submit_bitmap=%*pbl: %d",
+			     btrfs_root_id(inode->root),
+			     btrfs_ino(inode),
+			     folio_pos(folio), fs_info->sectors_per_page,
+			     &bio_ctrl->submit_bitmap, ret);
 
 	bio_ctrl->wbc->nr_to_write--;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 73a6b88c6511..3409f1e02de0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1133,6 +1133,10 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
 		if (locked_folio)
 			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
 					     start, async_extent->ram_size);
+		btrfs_err_rl(inode->root->fs_info,
+		"%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
+			     __func__, btrfs_root_id(inode->root),
+			     btrfs_ino(inode), start, async_extent->ram_size, ret);
 	}
 }
 
@@ -1579,6 +1583,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
 				       end - start - cur_alloc_size + 1, NULL);
 	}
+	btrfs_err_rl(fs_info,
+		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
+		     __func__, btrfs_root_id(inode->root),
+		     btrfs_ino(inode), orig_start, end + 1 - orig_start, ret);
 	return ret;
 }
 
@@ -2326,6 +2334,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		btrfs_qgroup_free_data(inode, NULL, cur_offset, end - cur_offset + 1, NULL);
 	}
 	btrfs_free_path(path);
+	btrfs_err_rl(fs_info,
+		     "%s failed, root=%llu inode=%llu start=%llu len=%llu: %d",
+		     __func__, btrfs_root_id(inode->root),
+		     btrfs_ino(inode), start, end + 1 - start, ret);
 	return ret;
 }
 
-- 
2.47.1


