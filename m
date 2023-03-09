Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E07A6B1F58
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 10:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjCIJHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 04:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCIJGx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 04:06:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7AF23DBE
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 01:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=00NOiIMPD5EywiogmDtMwzmStEcNkoR3CJoXTVnCJqs=; b=ziWB5U+89pFIL9micen6/F2GiI
        FMCbXCHoo0exVelvmM3LB03TZ0vbsV/ojcBISpn4+jEIyudIEYEOm/dBKVmPHMEyieDwhaA/N0+nx
        VZ0zbhJu91OXSaPVffkKxGGBd7kDfuzc+VavvnI7nWGu1jPVm9P1EJOXP9AzC3bEOd7vrnL1i5NMz
        QBHnff/Q7WiNpIut2gCfRzLTXkTmI7NcrS/TsJ0slgA/gGwW2M4/bZqbL3uVXv0BRncKnxcVSoNzT
        vGddeVIDiocWnSKmVu+sn44UBLBWMWNbfyPaKPfq93H7pDrYpDUd/Kld///4fi1LYYR+RMH9Sboq3
        iJYsf8Tg==;
Received: from [2001:4bb8:190:782d:bc9d:fa49:9fec:5662] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1paCDx-008hfe-5b; Thu, 09 Mar 2023 09:06:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/20] btrfs: remove the mirror_num argument to btrfs_submit_compressed_read
Date:   Thu,  9 Mar 2023 10:05:12 +0100
Message-Id: <20230309090526.332550-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309090526.332550-1-hch@lst.de>
References: <20230309090526.332550-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
index 5169e73ffea647..d60a80572b8ba2 100644
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

