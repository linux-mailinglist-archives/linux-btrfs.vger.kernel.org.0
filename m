Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3086B9C24
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 17:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjCNQvc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCNQvb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:51:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F8FA9DF0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=duf1o6j/5Yjop91GPy7VW+xYm9dq1AF2NqBtqz4hQ5g=; b=D8G57t0R8XgsGX5su40fXhW3VB
        +njSPcBEVZsEOkJdE1sRUsfPx362gRagEE0LLcWv2G4en62AFXXvRZXyXX8jR8H4+uR3kPCRJPMjL
        TZXyRaolv/XwSUWf2iS+g9/ZnnYVHNwhaff4E+7Rx8hSPfmK4hvN+SJsPbuJYVOOkhozL4xte5ZpL
        AzJaP3X9iKgpyUmyG022HluueA30/9if/s23kRXJR7TnCqdgV8OEIDPcI6J3To73iiJvIyEymM25C
        qEJo8p7/a6w+VrcI5hRABoWelBL+Ih8NeG1mdDvixLoV/fmloNElBIGmtH01lFETVbCuCWrfxGTE8
        fYq1JVEA==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc7rz-00Aunw-0K;
        Tue, 14 Mar 2023 16:51:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: btrfs_add_compressed_bio_pages
Date:   Tue, 14 Mar 2023 17:51:10 +0100
Message-Id: <20230314165110.372858-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314165110.372858-1-hch@lst.de>
References: <20230314165110.372858-1-hch@lst.de>
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

btrfs_add_compressed_bio_pages is neededlyless complicated.  Instead
of iterating over the logic disk offset just to add pages to the bio
use a simple offset starting at 0, which also removes most of the
claiming.  Additionally __bio_add_pages already takes care of the
assert that the bio is always properly sized, and btrfs_submit_bio
called right after asserts that the bio size is non-zero.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1487c9413e6942..44c4276741ceda 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -258,37 +258,17 @@ static void end_compressed_bio_write(struct btrfs_bio *bbio)
 
 static void btrfs_add_compressed_bio_pages(struct compressed_bio *cb)
 {
-	struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
 	struct bio *bio = &cb->bbio.bio;
-	u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-	u64 cur_disk_byte = disk_bytenr;
+	u32 offset = 0;
 
-	while (cur_disk_byte < disk_bytenr + cb->compressed_len) {
-		u64 offset = cur_disk_byte - disk_bytenr;
-		unsigned int index = offset >> PAGE_SHIFT;
-		unsigned int real_size;
-		unsigned int added;
-		struct page *page = cb->compressed_pages[index];
+	while (offset < cb->compressed_len) {
+		u32 len = min_t(u32, cb->compressed_len - offset, PAGE_SIZE);
 
-		/*
-		 * We have various limit on the real read size:
-		 * - page boundary
-		 * - compressed length boundary
-		 */
-		real_size = min_t(u64, U32_MAX, PAGE_SIZE - offset_in_page(offset));
-		real_size = min_t(u64, real_size, cb->compressed_len - offset);
-		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
-
-		added = bio_add_page(bio, page, real_size, offset_in_page(offset));
-		/*
-		 * Maximum compressed extent is smaller than bio size limit,
-		 * thus bio_add_page() should always success.
-		 */
-		ASSERT(added == real_size);
-		cur_disk_byte += added;
+		/* Maximum compressed extent is smaller than bio size limit. */
+		__bio_add_page(bio, cb->compressed_pages[offset >> PAGE_SHIFT],
+			       len, 0);
+		offset += len;
 	}
-
-	ASSERT(bio->bi_iter.bi_size);
 }
 
 /*
-- 
2.39.2

