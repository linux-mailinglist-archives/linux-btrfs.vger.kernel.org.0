Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5611752A557
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349362AbiEQOvl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349380AbiEQOvS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4EE15737
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ncoOIJVrELkZ1Yt/b6Y6PJSMmtx9R49eKAR+NeSiITY=; b=nsp5RTurbgkg2U3Jta1G7dADpr
        V3OmZq34ARtNTQFLPQvICRhTjGUbCkc5QV7Ee51jrLCTtBIUxO57Np0NkMvDNrUXw/x0/6SGv/eXk
        tl708u3Tr/+nr+Ndigb0A3rsHVWY/DEFp4yKSt/+uoYTR7koj+u0RjcL6azt+gbIHxBAc+2y4udbT
        4sZ/YUIVVVsJlSIj9wJ2U1jOOMcWqN8ptwrYyxuItkceSQUog93OI95zyP7oWa9AxrkvTTMjw0ZcV
        tsGJCKEm7nPzPDPx9TP1wmNO0eKLm/H9AMoeHFdxvBCzDhkhuVg5j5F3HfkfjCrWH5e+pukOp8zWO
        F/RjKGjg==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXY-00EXEV-Oj; Tue, 17 May 2022 14:51:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 09/15] btrfs: factor out a btrfs_csum_ptr helper
Date:   Tue, 17 May 2022 16:50:33 +0200
Message-Id: <20220517145039.3202184-10-hch@lst.de>
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

Add a helper to find the csum for a byte offset into the csum buffer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h |  7 +++++++
 fs/btrfs/inode.c | 13 +++----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4713d59ed1105..4ab41cb57f216 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2733,6 +2733,13 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				     enum btrfs_inline_ref_type is_data);
 u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset);
 
+static inline u8 *btrfs_csum_ptr(struct btrfs_fs_info *fs_info, u8 *csums,
+		u64 offset)
+{
+	return csums +
+		((offset >> fs_info->sectorsize_bits) * fs_info->csum_size);
+}
+
 /*
  * Take the number of bytes to be checksummmed and figure out how many leaves
  * it would require to store the csums for that many bytes.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cb0ad1971be30..c771136116151 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3369,15 +3369,12 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u32 len = fs_info->sectorsize;
-	const u32 csum_size = fs_info->csum_size;
-	unsigned int offset_sectors;
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
 	ASSERT(pgoff + len <= PAGE_SIZE);
 
-	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
-	csum_expected = ((u8 *)bbio->csum) + offset_sectors * csum_size;
+	csum_expected = btrfs_csum_ptr(fs_info, bbio->csum, bio_offset);
 
 	if (!btrfs_check_data_sector(fs_info, page, pgoff, csum, csum_expected))
 		return 0;
@@ -8007,12 +8004,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		if (ret)
 			goto err;
 	} else {
-		u64 csum_offset;
-
-		csum_offset = file_offset - dip->file_offset;
-		csum_offset >>= fs_info->sectorsize_bits;
-		csum_offset *= fs_info->csum_size;
-		btrfs_bio(bio)->csum = dip->csums + csum_offset;
+		btrfs_bio(bio)->csum = btrfs_csum_ptr(fs_info, dip->csums,
+				file_offset - dip->file_offset);
 	}
 map:
 	ret = btrfs_map_bio(fs_info, bio, 0);
-- 
2.30.2

