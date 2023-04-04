Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B066D6635
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjDDO4d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjDDO4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 10:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E29449C
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680620113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jde43B7wLiY0X8TkodUDvektg6VGP7LMYmpHpXCm3PE=;
        b=QgSX0JKSjvLTws//leOaKjjwdhE38j3yuzTdGInS6KaknEYCgQW0tYVVEUr1XWNiEB3hOo
        /lAdBs2RnsAcmDvuUB2Pc3Tfey0qvUFLPf6KAKb2EsUD9CcKsWdreWUZXDmh9WsGE0R8bo
        UlYip4tzO21VTi4KFNKT69iVF+hOA0o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-0BK-8CyBM8eyrSHNUwNyjQ-1; Tue, 04 Apr 2023 10:55:11 -0400
X-MC-Unique: 0BK-8CyBM8eyrSHNUwNyjQ-1
Received: by mail-qt1-f200.google.com with SMTP id v10-20020a05622a130a00b003e4ee70e001so16129426qtk.6
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 07:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jde43B7wLiY0X8TkodUDvektg6VGP7LMYmpHpXCm3PE=;
        b=7u4ciZFsGoYlX7xqihSz5ZrPCMWFPzwzJjQz0ByzKA//2iKGE9h2OBOi4yL9Cea3jJ
         s6xpr7wCfMM+MEk7Ysq4cw3GMMZ4Pk4oSnBtbg3mnbtLamrIT3x7rhUP3Wq8RFZ0ANO6
         JPSz1RcK9vp4eRLlWQ+aw885yzf1GS2jzJe3swB50bzEqFsAyj8MrIHetWrOK+h+tJTu
         +McGwzsFB4AFmjg5T5t0r4bHjYCuNyIhVDIMz41t8twrPpwboBSxCZe4AjwefGdT/p9x
         o8H9F+cp9yxuoWgQ4qmW1qh5wf+lG2cQ8bolF1hqSDDbk4+PdKBTzXWOsXoLgqhzAbfZ
         CQhA==
X-Gm-Message-State: AAQBX9deojmGv8CFZxLLKt+P2G+uSFf1ruJx6jYG5tMyrwcFa8CkXvvw
        C4aY3uEhg86UR1QUbQeifi10+BAWhny6Qv2oYyAyriajajhDf9EZL00task8pzMlfgaFdI9ZX+X
        jtrO9cKn3aKMKOcz7kLpI4g==
X-Received: by 2002:ac8:58ca:0:b0:3e6:61a6:c020 with SMTP id u10-20020ac858ca000000b003e661a6c020mr4116059qta.18.1680620109204;
        Tue, 04 Apr 2023 07:55:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRukieGp/vBCe07UBrAYPMxqeAHfI+NHR3fac66ESM5ACOxN0AeboeMCKRIpd7badFWWI16A==
X-Received: by 2002:ac8:58ca:0:b0:3e6:61a6:c020 with SMTP id u10-20020ac858ca000000b003e661a6c020mr4116026qta.18.1680620108814;
        Tue, 04 Apr 2023 07:55:08 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:08 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
        hch@infradead.org, linux-xfs@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     rpeterso@redhat.com, agruenba@redhat.com, xiang@kernel.org,
        chao@kernel.org, damien.lemoal@opensource.wdc.com, jth@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v2 08/23] iomap: hoist iomap_readpage_ctx from the iomap_readahead/_folio
Date:   Tue,  4 Apr 2023 16:53:04 +0200
Message-Id: <20230404145319.2057051-9-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make filesystems create readpage context, similar as
iomap_writepage_ctx in write path. This will allow filesystem to
pass _ops to iomap for ioend configuration (->prepare_ioend) which
in turn would be used to set BIO end callout (bio->bi_end_io).

This will be utilized in further patches by fs-verity to verify
pages on BIO completion by XFS.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/erofs/data.c        | 12 +++++++--
 fs/gfs2/aops.c         | 10 ++++++--
 fs/iomap/buffered-io.c | 57 ++++++++++++++++--------------------------
 fs/xfs/xfs_aops.c      | 16 +++++++++---
 fs/zonefs/file.c       | 12 +++++++--
 include/linux/iomap.h  | 13 ++++++++--
 6 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e16545849ea7..189591249f61 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -344,12 +344,20 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	struct iomap_readpage_ctx ctx = {
+		.cur_folio = folio,
+	};
+
+	return iomap_read_folio(&ctx, &erofs_iomap_ops);
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	struct iomap_readpage_ctx ctx = {
+		.rac = rac,
+	};
+
+	return iomap_readahead(&ctx, &erofs_iomap_ops);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index a5f4be6b9213..2764e1e99e8b 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -453,10 +453,13 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	int error;
+	struct iomap_readpage_ctx ctx = {
+		.cur_folio = folio,
+	};
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
-		error = iomap_read_folio(folio, &gfs2_iomap_ops);
+		error = iomap_read_folio(&ctx, &gfs2_iomap_ops);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_readpage(ip, &folio->page);
 		folio_unlock(folio);
@@ -528,13 +531,16 @@ static void gfs2_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
+	struct iomap_readpage_ctx ctx = {
+		.rac = rac,
+	};
 
 	if (gfs2_is_stuffed(ip))
 		;
 	else if (gfs2_is_jdata(ip))
 		mpage_readahead(rac, gfs2_block_map);
 	else
-		iomap_readahead(rac, &gfs2_iomap_ops);
+		iomap_readahead(&ctx, &gfs2_iomap_ops);
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6f4c97a6d7e9..d39be64b1da9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -194,13 +194,6 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
-	struct folio		*cur_folio;
-	bool			cur_folio_in_bio;
-	struct bio		*bio;
-	struct readahead_control *rac;
-};
-
 /**
  * iomap_read_inline_data - copy inline data into the page cache
  * @iter: iteration structure
@@ -325,32 +318,29 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	return pos - orig_pos + plen;
 }
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
+int iomap_read_folio(struct iomap_readpage_ctx *ctx, const struct iomap_ops *ops)
 {
 	struct iomap_iter iter = {
-		.inode		= folio->mapping->host,
-		.pos		= folio_pos(folio),
-		.len		= folio_size(folio),
-	};
-	struct iomap_readpage_ctx ctx = {
-		.cur_folio	= folio,
+		.inode		= ctx->cur_folio->mapping->host,
+		.pos		= folio_pos(ctx->cur_folio),
+		.len		= folio_size(ctx->cur_folio),
 	};
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
+		iter.processed = iomap_readpage_iter(&iter, ctx, 0);
 
 	if (ret < 0)
-		folio_set_error(folio);
+		folio_set_error(ctx->cur_folio);
 
-	if (ctx.bio) {
-		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
+	if (ctx->bio) {
+		submit_bio(ctx->bio);
+		WARN_ON_ONCE(!ctx->cur_folio_in_bio);
 	} else {
-		WARN_ON_ONCE(ctx.cur_folio_in_bio);
-		folio_unlock(folio);
+		WARN_ON_ONCE(ctx->cur_folio_in_bio);
+		folio_unlock(ctx->cur_folio);
 	}
 
 	/*
@@ -402,27 +392,24 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
+void iomap_readahead(struct iomap_readpage_ctx *ctx, const struct iomap_ops *ops)
 {
 	struct iomap_iter iter = {
-		.inode	= rac->mapping->host,
-		.pos	= readahead_pos(rac),
-		.len	= readahead_length(rac),
-	};
-	struct iomap_readpage_ctx ctx = {
-		.rac	= rac,
+		.inode	= ctx->rac->mapping->host,
+		.pos	= readahead_pos(ctx->rac),
+		.len	= readahead_length(ctx->rac),
 	};
 
-	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
+	trace_iomap_readahead(ctx->rac->mapping->host, readahead_count(ctx->rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.processed = iomap_readahead_iter(&iter, &ctx);
+		iter.processed = iomap_readahead_iter(&iter, ctx);
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_folio) {
-		if (!ctx.cur_folio_in_bio)
-			folio_unlock(ctx.cur_folio);
+	if (ctx->bio)
+		submit_bio(ctx->bio);
+	if (ctx->cur_folio) {
+		if (!ctx->cur_folio_in_bio)
+			folio_unlock(ctx->cur_folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2ef78aa1d3f6..daa0dd4768fb 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -550,17 +550,25 @@ xfs_vm_bmap(
 
 STATIC int
 xfs_vm_read_folio(
-	struct file		*unused,
-	struct folio		*folio)
+	struct file			*unused,
+	struct folio			*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops);
+	struct iomap_readpage_ctx	ctx = {
+		.cur_folio		= folio,
+	};
+
+	return iomap_read_folio(&ctx, &xfs_read_iomap_ops);
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	struct iomap_readpage_ctx	ctx = {
+		.rac			= rac,
+	};
+
+	iomap_readahead(&ctx, &xfs_read_iomap_ops);
 }
 
 static int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 738b0e28d74b..5d01496a5ada 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -112,12 +112,20 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
+	struct iomap_readpage_ctx ctx = {
+		.cur_folio = folio,
+	};
+
+	return iomap_read_folio(&ctx, &zonefs_read_iomap_ops);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_read_iomap_ops);
+	struct iomap_readpage_ctx ctx = {
+		.rac = rac,
+	};
+
+	iomap_readahead(&ctx, &zonefs_read_iomap_ops);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0f8123504e5e..0fbce375265d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -258,8 +258,17 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
 		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
+struct iomap_readpage_ctx {
+	struct folio			*cur_folio;
+	bool				cur_folio_in_bio;
+	struct bio			*bio;
+	struct readahead_control	*rac;
+};
+
+int iomap_read_folio(struct iomap_readpage_ctx *ctx,
+		const struct iomap_ops *ops);
+void iomap_readahead(struct iomap_readpage_ctx *ctx,
+		const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
-- 
2.38.4

