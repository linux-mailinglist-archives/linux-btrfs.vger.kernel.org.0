Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9A970D6F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjEWIQE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjEWIPe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:15:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7EB10C4
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eq4REbHcjfiOaFXeZNJFO0BJjq1kagqwnhr8TtjmZN0=; b=dPXekr+ti1RLOgOpk+7y/NKTGl
        3UmT8tBsk5J+ko0uNL4281Pus5ikTqLA2yz75RI2l6+niSMlgib/CyJpfrn8ficqIO1Dtrn6D5NKO
        tCw6EvkpRXoBnhDqGY8SR5oujkzEyJAf+NUxEq5XykXcyIVaKzzoD6uEpvce7wah0Q6IZ6u9gL4vq
        7hneAlXw5VyVM76uIPHRIBf7FcasYQDFYOrEdYMeoIJizgAy4JBdPSk5vYv0DLpK6TSXuPTICqAcR
        nqhYTk22jUPoQmuNQ2bkTM1ifeIeN+83GqKRw2BCBnmONpK/DfDAMkHSOYcajQ2Bv1T8L7NRPhOXO
        0po9PuMg==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1N9J-009OUo-2C;
        Tue, 23 May 2023 08:13:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/16] btrfs: rename cow_file_range_async to run_delalloc_compressed
Date:   Tue, 23 May 2023 10:13:12 +0200
Message-Id: <20230523081322.331337-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523081322.331337-1-hch@lst.de>
References: <20230523081322.331337-1-hch@lst.de>
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

cow_file_range_async is only used for compressed writeback.  Rename it
to run_delalloc_compressed, which also fits in with run_delalloc_nocow
and run_delalloc_zoned.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0741294ce3234b..c4d4ac0428ee74 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1693,7 +1693,7 @@ static noinline void async_cow_submit(struct btrfs_work *work)
 	 * ->inode could be NULL if async_chunk_start has failed to compress,
 	 * in which case we don't have anything to submit, yet we need to
 	 * always adjust ->async_delalloc_pages as its paired with the init
-	 * happening in cow_file_range_async
+	 * happening in run_delalloc_compressed
 	 */
 	if (async_chunk->inode)
 		submit_compressed_extents(async_chunk);
@@ -1720,11 +1720,11 @@ static noinline void async_cow_free(struct btrfs_work *work)
 		kvfree(async_cow);
 }
 
-static bool cow_file_range_async(struct btrfs_inode *inode,
-				 struct writeback_control *wbc,
-				 struct page *locked_page,
-				 u64 start, u64 end, int *page_started,
-				 unsigned long *nr_written)
+static bool run_delalloc_compressed(struct btrfs_inode *inode,
+				    struct writeback_control *wbc,
+				    struct page *locked_page,
+				    u64 start, u64 end, int *page_started,
+				    unsigned long *nr_written)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct cgroup_subsys_state *blkcg_css = wbc_blkcg_css(wbc);
@@ -2417,8 +2417,8 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 
 	if (btrfs_inode_can_compress(inode) &&
 	    inode_need_compress(inode, start, end) &&
-	    cow_file_range_async(inode, wbc, locked_page, start,
-				 end, page_started, nr_written))
+	    run_delalloc_compressed(inode, wbc, locked_page, start,
+				    end, page_started, nr_written))
 		goto out;
 
 	if (zoned)
-- 
2.39.2

