Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25B26AE6F8
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 17:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCGQnh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 11:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCGQnN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 11:43:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E05984CD
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 08:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dlpBKC7fXUNlqHGA/uEu90lxyroe94n8JhlDpu1ufbM=; b=zNZfgqUANpiRoc0e/j1pLIdbfS
        ecB3lFTQP4C6WyoYUz23yHiKztSh9Tt8zuWAOkAj0uSLe5RsYaHk2zPpfLDhrGhwHsQXDK4K6ChFO
        sJZBGp2ViepQ1O4DKMkWjWTrxZSKJbr1f0Y2zMJVAHgRekJ/glJF+L2TzkBDRtt7R2E77QrB2A7+r
        l40iPXiHXTNKOOZp8EzLKvzceUJd2w74c/a2WnH6b9CyY09wTN+n6z3BDI/g9NKQJE6IuXFqb8bZv
        zZPMyDztYZWRFKdvw7HwHv8GdCd0QHZa7Q9X3XLR0FuwpP3xZVF2jKDxW62LQP3aZjARTkVO9GrKs
        1Nom0+Ow==;
Received: from [213.208.157.31] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZaMU-001bW4-Kw; Tue, 07 Mar 2023 16:40:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 03/10] btrfs: move zero filling of compressed read bios into common code
Date:   Tue,  7 Mar 2023 17:39:38 +0100
Message-Id: <20230307163945.31770-4-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307163945.31770-1-hch@lst.de>
References: <20230307163945.31770-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All algorithms have to fill the remainder of the orig_bio with zeroes,
so do it in common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  2 ++
 fs/btrfs/lzo.c         | 14 +++++---------
 fs/btrfs/zlib.c        |  2 --
 fs/btrfs/zstd.c        |  1 -
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 5b1de1c19991e9..64c804dc3962f6 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -965,6 +965,8 @@ static int btrfs_decompress_bio(struct compressed_bio *cb)
 	ret = compression_decompress_bio(workspace, cb);
 	put_workspace(type, workspace);
 
+	if (!ret)
+		zero_fill_bio(cb->orig_bio);
 	return ret;
 }
 
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index dc66ee98989e90..3a095b9c6373ea 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -389,8 +389,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 			 */
 			btrfs_err(fs_info, "unexpectedly large lzo segment len %u",
 					seg_len);
-			ret = -EIO;
-			goto out;
+			return -EIO;
 		}
 
 		/* Copy the compressed segment payload into workspace */
@@ -401,8 +400,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 					    workspace->buf, &out_len);
 		if (ret != LZO_E_OK) {
 			btrfs_err(fs_info, "failed to decompress");
-			ret = -EIO;
-			goto out;
+			return -EIO;
 		}
 
 		/* Copy the data into inode pages */
@@ -411,7 +409,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 
 		/* All data read, exit */
 		if (ret == 0)
-			goto out;
+			return 0;
 		ret = 0;
 
 		/* Check if the sector has enough space for a segment header */
@@ -422,10 +420,8 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		/* Skip the padding zeros */
 		cur_in += sector_bytes_left;
 	}
-out:
-	if (!ret)
-		zero_fill_bio(cb->orig_bio);
-	return ret;
+
+	return 0;
 }
 
 int lzo_decompress(struct list_head *ws, const u8 *data_in,
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index da7bb9187b68a3..8acb05e176c540 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -350,8 +350,6 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	zlib_inflateEnd(&workspace->strm);
 	if (data_in)
 		kunmap_local(data_in);
-	if (!ret)
-		zero_fill_bio(cb->orig_bio);
 	return ret;
 }
 
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index e34f1ab99d56fe..f798da267590d4 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -609,7 +609,6 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		}
 	}
 	ret = 0;
-	zero_fill_bio(cb->orig_bio);
 done:
 	if (workspace->in_buf.src)
 		kunmap_local(workspace->in_buf.src);
-- 
2.39.1

