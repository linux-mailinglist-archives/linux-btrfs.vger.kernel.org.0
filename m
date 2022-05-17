Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64C152A552
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349428AbiEQOvf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349352AbiEQOvN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EC813F98
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dWM4kInP/wu1TXgDzSytANtXvOXHSNqFlF/66aIJ+zA=; b=dJoqblWEhdEdahzDbh9yTJzOwz
        95HT2AI3sYCBrccjo1PQVNBtEtEL6GvxVV11/X7jo0AslOLHA9XgGIGMfEKrciKII1l/HQD/1z7sL
        IF8nB5+qs2x0qCp00k3v1WXo3cAN85LH1GMGSxKnrPAujyAsEXD16rgvOYasADXFLlqWrWvDh/FQh
        zqZvIIhkGJXWfmBSDkm3GkVJAvvLizZSubEeT6RIm8thjliRTrhX2VSNhUbT4XLyePcrVQmTo0Oma
        E9HbH5/4qEpiWu6LXngpng0auJ1WHkl0yHYB9V+Dlr/6eLiqoRVgCYZZ8BCpCul+1YYwVI9UJuazf
        AKkRf5jA==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXV-00EXDp-FA; Tue, 17 May 2022 14:51:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 08/15] btrfs: refactor end_bio_extent_readpage
Date:   Tue, 17 May 2022 16:50:32 +0200
Message-Id: <20220517145039.3202184-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517145039.3202184-1-hch@lst.de>
References: <20220517145039.3202184-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Untangle the goto mess and remove the pointless 'ret' local variable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 87 +++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f96d5b7071813..1ba2d4b194f2e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3028,7 +3028,6 @@ static void end_bio_extent_readpage(struct bio *bio)
 	 */
 	u32 bio_offset = 0;
 	int mirror;
-	int ret;
 	struct bvec_iter_all iter_all;
 
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
@@ -3039,6 +3038,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 		const u32 sectorsize = fs_info->sectorsize;
 		unsigned int error_bitmap = (unsigned int)-1;
+		bool repair = false;
 		u64 start;
 		u64 end;
 		u32 len;
@@ -3076,55 +3076,23 @@ static void end_bio_extent_readpage(struct bio *bio)
 			if (is_data_inode(inode)) {
 				error_bitmap = btrfs_verify_data_csum(bbio,
 						bio_offset, page, start, end);
-				ret = error_bitmap;
+				if (error_bitmap)
+					uptodate = false;
 			} else {
-				ret = btrfs_validate_metadata_buffer(bbio,
-					page, start, end, mirror);
+				if (btrfs_validate_metadata_buffer(bbio,
+						page, start, end, mirror))
+					uptodate = false;
 			}
-			if (ret)
-				uptodate = false;
-			else
-				clean_io_failure(BTRFS_I(inode)->root->fs_info,
-						 failure_tree, tree, start,
-						 page,
-						 btrfs_ino(BTRFS_I(inode)), 0);
 		}
 
-		if (likely(uptodate))
-			goto readpage_ok;
-
-		if (is_data_inode(inode)) {
-			/*
-			 * If we failed to submit the IO at all we'll have a
-			 * mirror_num == 0, in which case we need to just mark
-			 * the page with an error and unlock it and carry on.
-			 */
-			if (mirror == 0)
-				goto readpage_ok;
-
-			/*
-			 * submit_data_read_repair() will handle all the good
-			 * and bad sectors, we just continue to the next bvec.
-			 */
-			submit_data_read_repair(inode, bio, bio_offset, bvec,
-						mirror, error_bitmap);
-
-			ASSERT(bio_offset + len > bio_offset);
-			bio_offset += len;
-			continue;
-		} else {
-			struct extent_buffer *eb;
-
-			eb = find_extent_buffer_readpage(fs_info, page, start);
-			set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
-			eb->read_mirror = mirror;
-			atomic_dec(&eb->io_pages);
-		}
-readpage_ok:
 		if (likely(uptodate)) {
 			loff_t i_size = i_size_read(inode);
 			pgoff_t end_index = i_size >> PAGE_SHIFT;
 
+			clean_io_failure(BTRFS_I(inode)->root->fs_info,
+					 failure_tree, tree, start, page,
+					 btrfs_ino(BTRFS_I(inode)), 0);
+
 			/*
 			 * Zero out the remaining part if this range straddles
 			 * i_size.
@@ -3141,14 +3109,41 @@ static void end_bio_extent_readpage(struct bio *bio)
 				zero_user_segment(page, zero_start,
 						  offset_in_page(end) + 1);
 			}
+		} else if (is_data_inode(inode)) {
+			/*
+			 * Only try to repair bios that actually made it to a
+			 * device.  If the bio failed to be submitted mirror
+			 * is 0 and we need to fail it without retrying.
+			 */
+			if (mirror > 0)
+				repair = true;
+		} else {
+			struct extent_buffer *eb;
+
+			eb = find_extent_buffer_readpage(fs_info, page, start);
+			set_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
+			eb->read_mirror = mirror;
+			atomic_dec(&eb->io_pages);
 		}
+
+		if (repair) {
+			/*
+			 * submit_data_read_repair() will handle all the good
+			 * and bad sectors, we just continue to the next bvec.
+			 */
+			submit_data_read_repair(inode, bio, bio_offset, bvec,
+						mirror, error_bitmap);
+		} else {
+			/* Update page status and unlock */
+			end_page_read(page, uptodate, start, len);
+			endio_readpage_release_extent(&processed,
+					BTRFS_I(inode), start, end,
+					PageUptodate(page));
+		}
+
 		ASSERT(bio_offset + len > bio_offset);
 		bio_offset += len;
 
-		/* Update page status and unlock */
-		end_page_read(page, uptodate, start, len);
-		endio_readpage_release_extent(&processed, BTRFS_I(inode),
-					      start, end, PageUptodate(page));
 	}
 	/* Release the last extent */
 	endio_readpage_release_extent(&processed, NULL, 0, 0, false);
-- 
2.30.2

