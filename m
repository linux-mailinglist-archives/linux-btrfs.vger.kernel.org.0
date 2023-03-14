Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852B06B8B12
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCNGRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCNGRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D376F62
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NZKOSYXDW5Qcrae2SNvInDrz0w0aeNHBcPaK+q570zY=; b=RcA20wmoBHXG59y5gGNSbGRmsO
        ZEDoiqhUKasyQemNdCsOlP/4YfckbeiunkHbBUYVWx4D/eoK7rDBQgIkjwdQ9OUK4eCW/GIFYN7EO
        shOJNMA9xeRuc7dvcY9Oh4n+/oyMkWqeKWQ6lhkTCYHhAkeeBG3X10gcaRv9IwHxsGqaevolOZUw5
        0swJO/3GsRT7lc3V8Uyl/8QPa/AAPvw9GCfcvTnMU/B6ZKUkse6e/UNFYYTdBb6ADC01PK2BRjyca
        Ez47AYflteojoL5i8IQdN2DHZMa1RF44jUNCtqFRGB96jkPYi2BifnbA2qSe5UETmnX1kAQna2ECy
        PIgLjssA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxyI-009AjH-7D; Tue, 14 Mar 2023 06:17:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/21] btrfs: remove the mirror_num argument to btrfs_submit_compressed_read
Date:   Tue, 14 Mar 2023 07:16:41 +0100
Message-Id: <20230314061655.245340-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
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

Given that read recovery for data I/O is handled in the storage layer,
the mirror_num argument to btrfs_submit_compressed_read is always 0,
so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/compression.c | 4 ++--
 fs/btrfs/compression.h | 2 +-
 fs/btrfs/extent_io.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c5839d04690d67..cc6bc0c13bbe12 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -499,7 +499,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
  * After the compressed pages are read, we copy the bytes into the
  * bio we were passed and then call the bio end_io calls
  */
-void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
+void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -566,7 +566,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
 	if (memstall)
 		psi_memstall_leave(&pflags);
 
-	btrfs_submit_bio(&cb->bbio, mirror_num);
+	btrfs_submit_bio(&cb->bbio, 0);
 	return;
 
 out_free_compressed_pages:
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 5d5146e72a860b..8ba8e62b096061 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -94,7 +94,7 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  blk_opf_t write_flags,
 				  struct cgroup_subsys_state *blkcg_css,
 				  bool writeback);
-void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num);
+void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8e709b44fa57ec..4d412efe32c6b2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -126,7 +126,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
-		btrfs_submit_compressed_read(bbio, 0);
+		btrfs_submit_compressed_read(bbio);
 	else
 		btrfs_submit_bio(bbio, 0);
 
-- 
2.39.2

