Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1763A58BF
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhFMNmV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55388 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhFMNmV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:21 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 60E481FD2D;
        Sun, 13 Jun 2021 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0SwFOdjmv+BwHEcQT6xR2AV/iXoKaxQAfg5HNaGaPc=;
        b=FC1Qck7+6PgQ6kxHSOmLHuaZuI1MXYDL2np5FGslDZ+sBkAGdB9s/gzc1bLymgkKQ7BXgl
        dRmwgK9glMtl1IHTP9AM/4xt9etkuVJcLXwPPwjLSfQkRrHH89lcxZCAqHpniuDKk95zSI
        RwpUzULmBVqtfmKvHOrbgehruKlElDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591619;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0SwFOdjmv+BwHEcQT6xR2AV/iXoKaxQAfg5HNaGaPc=;
        b=lt/Rkg2eX9aGZ8Wg7y4xzPw0Tc7cvKFTsf6ywp8H2uUWTIahZnyKelxGo93Bb9yKCmuPEt
        A8wnodEy/01kDTAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0A3F6118DD;
        Sun, 13 Jun 2021 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0SwFOdjmv+BwHEcQT6xR2AV/iXoKaxQAfg5HNaGaPc=;
        b=FC1Qck7+6PgQ6kxHSOmLHuaZuI1MXYDL2np5FGslDZ+sBkAGdB9s/gzc1bLymgkKQ7BXgl
        dRmwgK9glMtl1IHTP9AM/4xt9etkuVJcLXwPPwjLSfQkRrHH89lcxZCAqHpniuDKk95zSI
        RwpUzULmBVqtfmKvHOrbgehruKlElDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591619;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0SwFOdjmv+BwHEcQT6xR2AV/iXoKaxQAfg5HNaGaPc=;
        b=lt/Rkg2eX9aGZ8Wg7y4xzPw0Tc7cvKFTsf6ywp8H2uUWTIahZnyKelxGo93Bb9yKCmuPEt
        A8wnodEy/01kDTAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ic5EMMIKxmA7JAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:18 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 04/31] iomap: Introduce iomap_readpage_ops
Date:   Sun, 13 Jun 2021 08:39:32 -0500
Message-Id: <ae9727cdb9e1a576e3e9e7e1410a0afe75422621.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

iomap_readpage_ops provide additional functions to allocate or submit
the bio.

alloc_bio() is used to allocate bio from the filesystem, in case of
btrfs: to allocate btrfs_io_bio.

submit_io() similar to the one introduced with direct I/O, submits the
bio.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/gfs2/aops.c         |  4 +--
 fs/iomap/buffered-io.c | 56 +++++++++++++++++++++++++++++++-----------
 fs/xfs/xfs_aops.c      |  4 +--
 fs/zonefs/super.c      |  4 +--
 include/linux/iomap.h  | 19 ++++++++++++--
 5 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 23b5be3db044..f5bd7d0dab90 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -474,7 +474,7 @@ static int __gfs2_readpage(void *file, struct page *page)
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !page_has_buffers(page))) {
-		error = iomap_readpage(page, &gfs2_iomap_ops);
+		error = iomap_readpage(page, &gfs2_iomap_ops, NULL);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_readpage(ip, page);
 		unlock_page(page);
@@ -563,7 +563,7 @@ static void gfs2_readahead(struct readahead_control *rac)
 	else if (gfs2_is_jdata(ip))
 		mpage_readahead(rac, gfs2_block_map);
 	else
-		iomap_readahead(rac, &gfs2_iomap_ops);
+		iomap_readahead(rac, &gfs2_iomap_ops, NULL);
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f88f058cdefb..ec2304eea51a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -201,10 +201,11 @@ iomap_read_end_io(struct bio *bio)
 }
 
 struct iomap_readpage_ctx {
-	struct page		*cur_page;
-	bool			cur_page_in_bio;
-	struct bio		*bio;
-	struct readahead_control *rac;
+	struct page			*cur_page;
+	bool				cur_page_in_bio;
+	struct bio			*bio;
+	struct readahead_control	*rac;
+	const struct iomap_readpage_ops	*ops;
 };
 
 static void
@@ -282,19 +283,31 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 		gfp_t orig_gfp = gfp;
 		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		if (ctx->bio)
-			submit_bio(ctx->bio);
+		if (ctx->bio) {
+			if (ctx->ops && ctx->ops->submit_io)
+				ctx->ops->submit_io(inode, ctx->bio);
+			else
+				submit_bio(ctx->bio);
+		}
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(gfp, bio_max_segs(nr_vecs));
+		if (ctx->ops->alloc_bio)
+			ctx->bio = ctx->ops->alloc_bio(gfp,
+					bio_max_segs(nr_vecs));
+		else
+			ctx->bio = bio_alloc(gfp, bio_max_segs(nr_vecs));
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
 		 * what do_mpage_readpage does.
 		 */
-		if (!ctx->bio)
-			ctx->bio = bio_alloc(orig_gfp, 1);
+		if (!ctx->bio) {
+			if (ctx->ops->alloc_bio)
+				ctx->bio = ctx->ops->alloc_bio(orig_gfp, 1);
+			else
+				ctx->bio = bio_alloc(orig_gfp, 1);
+		}
 		ctx->bio->bi_opf = REQ_OP_READ;
 		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
@@ -315,9 +328,13 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 }
 
 int
-iomap_readpage(struct page *page, const struct iomap_ops *ops)
+iomap_readpage(struct page *page, const struct iomap_ops *ops,
+		const struct iomap_readpage_ops *readpage_ops)
 {
-	struct iomap_readpage_ctx ctx = { .cur_page = page };
+	struct iomap_readpage_ctx ctx = {
+		.cur_page	= page,
+		.ops		= readpage_ops,
+	};
 	struct inode *inode = page->mapping->host;
 	unsigned poff;
 	loff_t ret;
@@ -336,7 +353,10 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 	}
 
 	if (ctx.bio) {
-		submit_bio(ctx.bio);
+		if (ctx.ops->submit_io)
+			ctx.ops->submit_io(inode, ctx.bio);
+		else
+			submit_bio(ctx.bio);
 		WARN_ON_ONCE(!ctx.cur_page_in_bio);
 	} else {
 		WARN_ON_ONCE(ctx.cur_page_in_bio);
@@ -392,13 +412,15 @@ iomap_readahead_actor(struct inode *inode, loff_t pos, loff_t length,
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
+void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
+		const struct iomap_readpage_ops *readpage_ops)
 {
 	struct inode *inode = rac->mapping->host;
 	loff_t pos = readahead_pos(rac);
 	size_t length = readahead_length(rac);
 	struct iomap_readpage_ctx ctx = {
 		.rac	= rac,
+		.ops	= readpage_ops,
 	};
 
 	trace_iomap_readahead(inode, readahead_count(rac));
@@ -414,8 +436,12 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 		length -= ret;
 	}
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
+	if (ctx.bio) {
+		if (ctx.ops && ctx.ops->submit_io)
+			ctx.ops->submit_io(inode, ctx.bio);
+		else
+			submit_bio(ctx.bio);
+	}
 	if (ctx.cur_page) {
 		if (!ctx.cur_page_in_bio)
 			unlock_page(ctx.cur_page);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 826caa6b4a5a..7f49bbf325a1 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -535,14 +535,14 @@ xfs_vm_readpage(
 	struct file		*unused,
 	struct page		*page)
 {
-	return iomap_readpage(page, &xfs_read_iomap_ops);
+	return iomap_readpage(page, &xfs_read_iomap_ops, NULL);
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
 }
 
 static int
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index cd145d318b17..f8157f91b8b1 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -115,12 +115,12 @@ static const struct iomap_ops zonefs_iomap_ops = {
 
 static int zonefs_readpage(struct file *unused, struct page *page)
 {
-	return iomap_readpage(page, &zonefs_iomap_ops);
+	return iomap_readpage(page, &zonefs_iomap_ops, NULL);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_iomap_ops);
+	iomap_readahead(rac, &zonefs_iomap_ops, NULL);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8944711aa92e..cc8c00026edb 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -157,8 +157,6 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
-int iomap_readpage(struct page *page, const struct iomap_ops *ops);
-void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 int iomap_set_page_dirty(struct page *page);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
@@ -188,6 +186,23 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
 sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 		const struct iomap_ops *ops);
 
+struct iomap_readpage_ops {
+
+	/* allow the filesystem to allocate custom struct bio */
+	struct bio *(*alloc_bio)(gfp_t gfp_mask, unsigned short nr_iovecs);
+
+	/*
+	 * Optional, allows the filesystem to perform a custom submission of
+	 * bio, such as csum calculations or multi-device bio split
+	 */
+	void (*submit_io)(struct inode *inode, struct bio *bio);
+};
+
+int iomap_readpage(struct page *page, const struct iomap_ops *ops,
+		const struct iomap_readpage_ops *readpage_ops);
+void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
+		const struct iomap_readpage_ops *readpage_ops);
+
 /*
  * Structure for writeback I/O completions.
  */
-- 
2.31.1

