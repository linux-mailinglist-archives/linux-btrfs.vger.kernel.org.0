Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04425302C4
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 May 2022 13:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbiEVLs0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 May 2022 07:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245734AbiEVLsT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 May 2022 07:48:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221E215FF2
        for <linux-btrfs@vger.kernel.org>; Sun, 22 May 2022 04:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GbcAKr0O3Sfg4j5/pVluR+1M/Ixl8NjazGLQjXbjf6U=; b=auCeEEmTqTaNW4bVIHbJvBBBy2
        L+DuWk69Zg8vfOYLXIgaUnu3GZxYvUtFgursBzlAZ2CYRntoxjmRY8AzW4F6DERsxlNhl9Ahclyns
        CMEW7iqZxl5l0CjhajapR9DaLVWqPDzdWq8wqynBzH0Kd4LJtj7ktD491MC+aoVZWC1tjbLw2Kmug
        V/7LSskNpa9FwIG08fA9tw8WOQZqlNj10Xu0XPW787GhxZK+vq4FAAlTQZbpfT7nJ0XcBAAkIjP0r
        nicjz0A6S027uKJRCUmc0c5fOD4dcLnzyGN4Lr4t/CemYfQrm5RQGFDOelg4pobRSaCgUovg4HOKK
        LRGvklmQ==;
Received: from [2001:4bb8:19a:6dab:76a3:f7ab:4f04:784a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsk4E-001E5W-Md; Sun, 22 May 2022 11:48:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: add a helper to iterate through a btrfs_bio with sector sized chunks
Date:   Sun, 22 May 2022 13:47:53 +0200
Message-Id: <20220522114754.173685-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220522114754.173685-1-hch@lst.de>
References: <20220522114754.173685-1-hch@lst.de>
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

From: Qu Wenruo <wqu@suse.com>

Add a helper that works similar to __bio_for_each_segment, but instead of
iterating over PAGE_SIZE chunks it iterates over each sector.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[hch: split from a larger patch, and iterate over the offset instead of
      the offset bits]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/volumes.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 12b2af9260e92..6f784d4f54664 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -391,6 +391,18 @@ static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 	}
 }
 
+/*
+ * Iterate through a btrfs_bio (@bbio) on a per-sector basis.
+ */
+#define btrfs_bio_for_each_sector(fs_info, bvl, bbio, iter, bio_offset)	\
+	for ((iter) = (bbio)->iter, (bio_offset) = 0;			\
+	     (iter).bi_size &&					\
+	     (((bvl) = bio_iter_iovec((&(bbio)->bio), (iter))), 1);	\
+	     (bio_offset) += fs_info->sectorsize,			\
+	     bio_advance_iter_single(&(bbio)->bio, &(iter),		\
+	     (fs_info)->sectorsize))
+
+
 struct btrfs_io_stripe {
 	struct btrfs_device *dev;
 	u64 physical;
-- 
2.30.2

