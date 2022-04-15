Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE10E502BF9
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Apr 2022 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354547AbiDOOgI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Apr 2022 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiDOOgG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Apr 2022 10:36:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C769F3A8
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Apr 2022 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bKHs3vYb5sE9NobNtCxIwSvP1Oke5+lq4dmaK2zWECY=; b=ReWDLIcI/aSdVZ+WvjXKqKP6D7
        EbzNzgqOjbFDaOKl/NnlUiU4sV0shZXBkh9G9657t6zodDJkuvyVjCkjuYf2bLo44LUAOsyhuMHXy
        416DuxE3sW8+YR0LHCRBUO9QSg0dpmOP4dfEvsBcOV6kmJhYc8COAItIqzycnbUuKZMpMgMYoSKRI
        McgZrjnAN1/pD1XRNlGOEbbF4P8/VsGzo/smUu/J9IBJJDkEypVPpJBymIzW0f8bnkmOyuM+Uvb+d
        dejXM3B11mK9UIFwsMHZyRWJO/R1v7pGFZEle+h5UeTkGGUB1dvHEN5DPpgGLVkQv5uCa+5BJHRyq
        6MMFVhIA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfN0x-00AMsn-Va; Fri, 15 Apr 2022 14:33:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: remove the unused bio_flags argument to btrfs_submit_metadata_bio
Date:   Fri, 15 Apr 2022 16:33:25 +0200
Message-Id: <20220415143328.349010-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415143328.349010-1-hch@lst.de>
References: <20220415143328.349010-1-hch@lst.de>
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

This argument is unused since commit 953651eb308f ("btrfs: factor out
helper adding a page to bio") and commit 1b36294a6cd5 ("btrfs: call
submit_bio_hook directly for metadata pages") reworked the way metadata
bio submission is handled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c   | 2 +-
 fs/btrfs/disk-io.h   | 2 +-
 fs/btrfs/extent_io.c | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2689e85896272..28b9cf020b8df 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -921,7 +921,7 @@ static bool should_async_write(struct btrfs_fs_info *fs_info,
 }
 
 blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
-				       int mirror_num, unsigned long bio_flags)
+				       int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	blk_status_t ret;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 2a401592124d3..56607abe75aa4 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -88,7 +88,7 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
 blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
-				       int mirror_num, unsigned long bio_flags);
+				       int mirror_num);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fe146ba21415e..ef3f77e0b0fed 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -191,8 +191,7 @@ static void submit_one_bio(struct bio *bio, int mirror_num,
 		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
 					    bio_flags);
 	else
-		btrfs_submit_metadata_bio(tree->private_data, bio,
-						mirror_num, bio_flags);
+		btrfs_submit_metadata_bio(tree->private_data, bio, mirror_num);
 	/*
 	 * Above submission hooks will handle the error by ending the bio,
 	 * which will do the cleanup properly.  So here we should not return
-- 
2.30.2

