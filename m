Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7452A542
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349298AbiEQOv0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349303AbiEQOu7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:50:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5209FDD
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1l3lpKPkLNk10ZZ6IJyX9ESH2c9XV7eG7G9+whxn6+k=; b=KLbHHbzWGTQmE0Zx3FAFAlnQHo
        IWAvxblpnncE+x1CGjkB/MgnEl8TIq+/iCLSRUpCkbapYLfcjGBDmSAW7LqbZqBza63ZQpfg08FW4
        cgQzmy0kHzSm2Xfa6Mp8SPOBcqL0xH+7DvQ38YPTLaTkpvZNBWcbajPx2NjfpkBae2/JmugxUeYhH
        G/E3glMe7TVHd8BYdxLBbi0Y7R8qVjYAuFLD3U2Vm56wY0N0Y961PWDiNQuAxsO/l0w4wGdMEvJuf
        sQHKEaOeIjlQK7FVc7FdfYrraduLTzqiptxUlE/Whh1kn616/YD2oHHT7/ZwXejsl0eYuMgKnen0O
        u5M9ybYA==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyXG-00EXAf-1G; Tue, 17 May 2022 14:50:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 03/15] btrfs: save the original bi_iter into btrfs_bio for buffered read
Date:   Tue, 17 May 2022 16:50:27 +0200
Message-Id: <20220517145039.3202184-4-hch@lst.de>
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

Although we have btrfs_bio::iter, it currently have very limited usage:

- RAID56
  Which is not needed at all

- btrfs_bio_clone()
  This is used mostly for direct IO.

For the incoming read repair patches, we want to grab the original
logical bytenr, and be able to iterate the range of the bio (no matter
if it's cloned).

So this patch will also save btrfs_bio::iter for buffered read bios at
submit_one_bio().
And for the sake of consistency, also save the btrfs_bio::iter for
direct IO at btrfs_submit_dio_bio().

The reason that we didn't save the iter in btrfs_map_bio() is,
btrfs_map_bio() is going to handle various bios, with or without
btrfs_bio bioset.
And we  want to keep btrfs_map_bio() to handle and only handle plain bios
without bother the bioset.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 12 ++++++++++++
 fs/btrfs/inode.c     |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 588c7c606a2c6..8fe5f505d6e92 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -188,6 +188,18 @@ static void submit_one_bio(struct bio *bio, int mirror_num,
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
+	/*
+	 * Save the original bi_iter for read bios, as read repair wants the
+	 * orignial logical bytenr.
+	 *
+	 * We don't do this in btrfs_map_bio() because that function is
+	 * bioset independent.
+	 * We can later pass bios without btrfs_bio or with other bioset into
+	 * btrfs_map_bio().
+	 */
+	if (bio_op(bio) == REQ_OP_READ)
+		btrfs_bio(bio)->iter = bio->bi_iter;
+
 	if (is_data_inode(tree->private_data))
 		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
 					    compress_type);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 76169e4e3ec36..cb0ad1971be30 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7987,6 +7987,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 		if (ret)
 			goto err;
+		/* Check submit_one_bio() for the reason. */
+		btrfs_bio(bio)->iter = bio->bi_iter;
 	}
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
-- 
2.30.2

