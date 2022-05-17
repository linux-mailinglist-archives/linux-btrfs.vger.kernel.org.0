Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D5552A54C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349407AbiEQOv2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349320AbiEQOvE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:51:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C3EDF94
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GbcAKr0O3Sfg4j5/pVluR+1M/Ixl8NjazGLQjXbjf6U=; b=iwdRVVkqdqlmx+g+3w0hKBKoz/
        7ojeWs+YGri6vkAGM/Vlb7W9FXQkVacQdBSypzg9xSNmNhAL7DqM4fRckET50aFEaAsGWjFJal41V
        iHOhZWUC/+vW8HtCD9ZIobyPG9FCfV5tHz0cyU0VRn5SBfnMUC5IqLlzKbiOtX5jQvtm89mehoduc
        yG2c4GK3LlxfJKGSGCsIF/L+7uWx4gSR7GNMO6jUhvzOhGAjtf0iczMCjR+NNejJixk4lyP5RgnoG
        /7dTVGGrATQDGWusjNy//y1DTpudvdBubmJQaJDuNkWNA0r2Aj7WoM2sdChNKnokRshJGOIL2n9bK
        +7vjJ5qA==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXM-00EXC5-BT; Tue, 17 May 2022 14:51:00 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 05/15] btrfs: add a helper to iterate through a btrfs_bio with sector sized chunks
Date:   Tue, 17 May 2022 16:50:29 +0200
Message-Id: <20220517145039.3202184-6-hch@lst.de>
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

