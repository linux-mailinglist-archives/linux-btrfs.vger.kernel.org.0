Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557136CFB8F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjC3GbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjC3GbT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2729C6A58
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=af6CFNcx1Ql/QhkvTdRDFplAwzo/K8tHiN7hqfiYfCI=; b=aLOzuOVQCuBeTCvhkXxulfeptY
        JAY8DPsdYQ7NHOpGY7M2f7juoplGR3RiNYVUttC4s0Dhua/wJLW+XslONJFuUzNoaGIrjrHYn3MW0
        gzX1wbdQd0NCO89CCdOsR9w9iC4FY7RGk37cvHmZ7FTfu6YDzcxA5oTpB2f9fEmZBPtXOfqUVHKTV
        EQRCueQAZrhVnhysro7AGt56UZa/Jg17S2W/ALWLAmFxEZcsUxG76ax+PNWdIJZpy90JfhzspDKPu
        pkK8K1xCyTE3G9x2+giYKAnjd7nuAuq80+/uxv3fOA5ZJB5qKkTnarnydYVMjcn3T6NWasOwA3IE5
        Fv1DRrew==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phlob-002lcv-2N;
        Thu, 30 Mar 2023 06:31:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/21] btrfs: remove the mirror_num argument to btrfs_submit_compressed_read
Date:   Thu, 30 Mar 2023 15:30:45 +0900
Message-Id: <20230330063059.1574380-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330063059.1574380-1-hch@lst.de>
References: <20230330063059.1574380-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 44c4276741ceda..8ca152164c11bf 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -479,7 +479,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
  * After the compressed pages are read, we copy the bytes into the
  * bio we were passed and then call the bio end_io calls
  */
-void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
+void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -545,7 +545,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
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

