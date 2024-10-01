Return-Path: <linux-btrfs+bounces-8407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3742298C966
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 01:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3B328474B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 23:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8381A08B2;
	Tue,  1 Oct 2024 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LlhPIZKc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LlhPIZKc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9B1BE870
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Oct 2024 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727824698; cv=none; b=aLUv6pxNKL1GV+gZbqIyeDyNSPl/jjCJ0ejRWzgulIMpe6Iq9X1yLwcQ6LpRR9YyBccGK05EfoLbLXIxaFkT1Lcj6Nxi+dxUBwYprR7WMhtoPcaCNE0ylalC5GZg3Bt3YrHVQM36Z1lP80IWHjjiveHiPaoJGkIDMLRo/idKp5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727824698; c=relaxed/simple;
	bh=Nd8ikwhKYwlxZaJLnfQbyYAy9LUwL4Me7/yOlHvdyrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTGsRWHytgIuBP+5uShMBtX0gdK4sDgBgyFGgWRe1eyZBKA4nKF5P0b9JlRX65k5Niorz3c3y7Oe6y9t87fmE3e8xQl0Je52/WNnDqlozC2Mpdst2vhxSo0Vpd41KxcCSF96g5f3BsIN+H3VPUX1KbxKfdJabK1bVgPXlwLkFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LlhPIZKc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LlhPIZKc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C33111FCFE;
	Tue,  1 Oct 2024 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727824693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ7x84THotUQV7FbVZ5eNFARlRACfXego3ycIspehEQ=;
	b=LlhPIZKcSo0aJ86iRgQZU36aIYCFEps53X2Xo5ktBX8eiT0wMAibDGJJ5iJLdhZLmO8sk7
	JHeDQpN5qRX2JirpCPXXfU3FTJ4eaAF94qT4h7MPW1fE0kJQGlHQZFzJpeyB6nnxcOI/4k
	Jf7A7S6kuT3w+yC19XvZyILIfFOaedw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LlhPIZKc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727824693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJ7x84THotUQV7FbVZ5eNFARlRACfXego3ycIspehEQ=;
	b=LlhPIZKcSo0aJ86iRgQZU36aIYCFEps53X2Xo5ktBX8eiT0wMAibDGJJ5iJLdhZLmO8sk7
	JHeDQpN5qRX2JirpCPXXfU3FTJ4eaAF94qT4h7MPW1fE0kJQGlHQZFzJpeyB6nnxcOI/4k
	Jf7A7S6kuT3w+yC19XvZyILIfFOaedw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C93D013A6E;
	Tue,  1 Oct 2024 23:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yP/xIjSD/GbILgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 01 Oct 2024 23:18:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 1/2] btrfs: remove the dirty_page local variable
Date: Wed,  2 Oct 2024 08:47:48 +0930
Message-ID: <55a2ed90b22663ce33dbe7dc9a6932ec6abc0f98.1727824586.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727824586.git.wqu@suse.com>
References: <cover.1727824586.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C33111FCFE
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Inside btrfs_buffered_write(), we have a local variable @dirty_pages,
recording the number of pages we dirtied in the current iteration.

However we do not really need that variable, since it can be calculated
from @pos and @copied.

In fact there is already a problem inside the short copy path, where we
use @dirty_pages to calculate the range we need to release.
But that usage assumes sectorsize == PAGE_SIZE, which is no longer true.

Instead of keeping @dirty_pages and cause incorrect usage, just
calculate the number of dirtied pages inside btrfs_dirty_pages().

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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
2.46.2


