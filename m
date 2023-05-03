Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2503A6F5AFE
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjECPZJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjECPZI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:25:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4FE59D1
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=w1PTfWNkK8fi2WaIQZ5S0Fs6GEWyHLhdYh3YAVo2EBI=; b=0L0CWHroPjY7oQJrGoTkg5tEXh
        cqeAbvupJISmqOFVKeX9Y6n7Tx5h94fQWPSmglQbanAVbkEJOMF3rT4bawBjxL7IuWimBiJY7q13F
        J9JZtqRFh80ekXg35IS1pQv0TShJ5L8QR0O3k3O7VDom+terDfWo4tljdVGiRSczOaPly7i/u889v
        v4MI1qNL0i4cuntmLzqkIUhh91r+H5AsrusoQc0iZWtMY7ju0HAwxfCMf/QuJdeMpqjtKZxEoL3Jm
        R12vPIEs6HLn2Ya68p2KHF9Ony5B+fDlzLAls0nLiZzJJsp9orek3+iaPMYPCLnk7XGZq++i1bqAa
        DhdM0pBw==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puELn-004xfi-19;
        Wed, 03 May 2023 15:25:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 07/21] btrfs: remove the mirror_num argument to btrfs_submit_compressed_read
Date:   Wed,  3 May 2023 17:24:27 +0200
Message-Id: <20230503152441.1141019-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
References: <20230503152441.1141019-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 4 ++--
 fs/btrfs/compression.h | 2 +-
 fs/btrfs/extent_io.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 14f5f25049a0d7..04cd5de4f00f60 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -472,7 +472,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
  * After the compressed pages are read, we copy the bytes into the
  * bio we were passed and then call the bio end_io calls
  */
-void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
+void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -538,7 +538,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
 	if (memstall)
 		psi_memstall_leave(&pflags);
 
-	btrfs_submit_bio(&cb->bbio, mirror_num);
+	btrfs_submit_bio(&cb->bbio, 0);
 	return;
 
 out_free_compressed_pages:
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 19ab2abeddc088..b462ab106f4308 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -93,7 +93,7 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  unsigned int nr_pages,
 				  blk_opf_t write_flags,
 				  bool writeback);
-void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num);
+void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bc08e4f88e08f2..95b7e5d54abc13 100644
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

