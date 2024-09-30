Return-Path: <linux-btrfs+bounces-8319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9137F989908
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 03:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241771F21C18
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 01:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B7F9DF;
	Mon, 30 Sep 2024 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MDMsC69S";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MDMsC69S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC75684
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727661054; cv=none; b=KTEHgGa9DzH94senkjT1NXcpFlRe/l6P7r1oH2gLtWwzmvf4HLxp5fTM69e7yJ8NXpXzgKyM4McHGMAqx7lhoo2NLhhWnibSQd7BYQL3MyMKASXRO6yv3GuI31MlSFWX4U9hvswUdAN2ekvs1gQGmxiGkT2SsDrzPPkTYxSZRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727661054; c=relaxed/simple;
	bh=rqx2hkp4gNmYNknjyWQ0y8+fzR/PYw4AafepE/57t1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxnFtZf19rhdigzNA/SXdvkllsxSSuzAKskahLGmk01xe9oiYWayT7Ir6hYOybmdeGDFKkwXNR7a4gOPHWtjigys8u9FnnAkVV93BSPjpVssX+1EXadrAhXaBKnMoNcdPSnxyP3k330/JFvYYsBuhWOFmK/JTdvlmWOlpdbMTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MDMsC69S; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MDMsC69S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A7A92121F
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727661050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQ+CnvCDGFzlEuVPzuaOdocnQPWlZjXJDNWkbfs49aM=;
	b=MDMsC69SrN+C3Ftr9Mp4Kd8uf4U/h2wChRnc2/kKPaGvo9lgAZNjRkHrMGMeuBZGRWjCmY
	lNTPgXEltU1oQ+xGuo9gGQFn9oSs9XUXlPhjLoCnm8u4ybbK9j5XRbJhw/2JRPQz0tTxtt
	FmdvM4vx6SFkhbyciJhicas6DyCx2mA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727661050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQ+CnvCDGFzlEuVPzuaOdocnQPWlZjXJDNWkbfs49aM=;
	b=MDMsC69SrN+C3Ftr9Mp4Kd8uf4U/h2wChRnc2/kKPaGvo9lgAZNjRkHrMGMeuBZGRWjCmY
	lNTPgXEltU1oQ+xGuo9gGQFn9oSs9XUXlPhjLoCnm8u4ybbK9j5XRbJhw/2JRPQz0tTxtt
	FmdvM4vx6SFkhbyciJhicas6DyCx2mA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB23713318
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sD+VG/kD+mZvLgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 01:50:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: remove the dirty_page local variable
Date: Mon, 30 Sep 2024 11:20:29 +0930
Message-ID: <274af9fcd34264fd6e74b707ac33f1544e73c655.1727660754.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727660754.git.wqu@suse.com>
References: <cover.1727660754.git.wqu@suse.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Inside btrfs_buffered_write(), we have a local variable @dirty_pages,
recording the number of pages we dirtied in the current iteration.

However we do not really need that variable, since it can be calculated
from @pos and @copied.

In fact there is already a problem inside the short copy path, where we
use @dirty_pages to calculate the range we need to release.
But that usage assumes sectorsize == PAGE_SIZE, which is no longer true.

Instead of keeping @dirty_pages and cause incorrect usage, just
calculate the number of dirtied pages inside btrfs_dirty_pages().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c             | 19 +++++++------------
 fs/btrfs/file.h             |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4fb521d91b06..9555a3485670 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -124,12 +124,14 @@ static void btrfs_drop_pages(struct btrfs_fs_info *fs_info,
  * - Update inode size for past EOF write
  */
 int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
-		      size_t num_pages, loff_t pos, size_t write_bytes,
+		      loff_t pos, size_t write_bytes,
 		      struct extent_state **cached, bool noreserve)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret = 0;
 	int i;
+	const int num_pages = (round_up(pos + write_bytes, PAGE_SIZE) -
+			       round_down(pos, PAGE_SIZE)) >> PAGE_SHIFT;
 	u64 num_bytes;
 	u64 start_pos;
 	u64 end_of_last_block;
@@ -1242,7 +1244,6 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 					 offset);
 		size_t num_pages;
 		size_t reserve_bytes;
-		size_t dirty_pages;
 		size_t copied;
 		size_t dirty_sectors;
 		size_t num_sectors;
@@ -1361,11 +1362,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		if (copied == 0) {
 			force_page_uptodate = true;
 			dirty_sectors = 0;
-			dirty_pages = 0;
 		} else {
 			force_page_uptodate = false;
-			dirty_pages = DIV_ROUND_UP(copied + offset,
-						   PAGE_SIZE);
 		}
 
 		if (num_sectors > dirty_sectors) {
@@ -1375,13 +1373,10 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 				btrfs_delalloc_release_metadata(BTRFS_I(inode),
 							release_bytes, true);
 			} else {
-				u64 __pos;
-
-				__pos = round_down(pos,
-						   fs_info->sectorsize) +
-					(dirty_pages << PAGE_SHIFT);
+				u64 release_start = round_up(pos + copied,
+							     fs_info->sectorsize);
 				btrfs_delalloc_release_space(BTRFS_I(inode),
-						data_reserved, __pos,
+						data_reserved, release_start,
 						release_bytes, true);
 			}
 		}
@@ -1390,7 +1385,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 					fs_info->sectorsize);
 
 		ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
-					dirty_pages, pos, copied,
+					pos, copied,
 					&cached_state, only_release_metadata);
 
 		/*
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index 912254e653cf..c23d0bf42598 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -35,7 +35,7 @@ ssize_t btrfs_do_write_iter(struct kiocb *iocb, struct iov_iter *from,
 			    const struct btrfs_ioctl_encoded_io_args *encoded);
 int btrfs_release_file(struct inode *inode, struct file *file);
 int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
-		      size_t num_pages, loff_t pos, size_t write_bytes,
+		      loff_t pos, size_t write_bytes,
 		      struct extent_state **cached, bool noreserve);
 int btrfs_fdatawrite_range(struct btrfs_inode *inode, loff_t start, loff_t end);
 int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f4bcb2530660..4a3a6db91878 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1458,7 +1458,7 @@ static int __btrfs_write_out_cache(struct inode *inode,
 
 	/* Everything is written out, now we dirty the pages in the file. */
 	ret = btrfs_dirty_pages(BTRFS_I(inode), io_ctl->pages,
-				io_ctl->num_pages, 0, i_size_read(inode),
+				0, i_size_read(inode),
 				&cached_state, false);
 	if (ret)
 		goto out_nospc;
-- 
2.46.1


