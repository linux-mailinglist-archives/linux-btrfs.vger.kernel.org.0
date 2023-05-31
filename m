Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D354571768F
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjEaGFb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjEaGFa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A5411C
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4YgVgiMHpTLKO3oULleg9r1hEqIoyw4HiAzL0wGtz+g=; b=bP0Qek8cx+kEkkTGXZ/tHjHS5O
        51JohUCF/ea2mYJ/KHs/X8/45XC3jLjMS6NThmHq17sDGo9PXiyhQtyR0r94n6F0aZqomJuHJf/pK
        8HziuAtBIGz1K7mOQd6JHkrnwC33O4akddEou4LmKeTAP9rqAjzXpxJlDyAzpNrOVH4hshKr9I0i8
        wQErZT8ItiCjBX5pPeLeXYzxQyARk71xeVrplGnOOJPGVY5mCyiuIZ71zyu+wG1Syi4U+ongbOyQC
        zuF4LWT/kfQm21BB2qjaK9zH63UT9QPptVencEfCNXnV1lTRfDgx+ZMNOXbaRhOhTgMZbuuhZ6Zin
        Z6m+GJ4Q==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Exb-00GF58-0u;
        Wed, 31 May 2023 06:05:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 06/16] btrfs: rename cow_file_range_async to run_delalloc_compressed
Date:   Wed, 31 May 2023 08:04:55 +0200
Message-Id: <20230531060505.468704-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
References: <20230531060505.468704-1-hch@lst.de>
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

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b4b6bd621264cf..9a7c0564fb7160 100644
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

