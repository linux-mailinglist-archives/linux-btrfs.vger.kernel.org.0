Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B76375F9B8
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjGXOWv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjGXOWr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 10:22:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B856BC
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NxrOayYA2ZaGKhdQ6VW3bI8ywI3ep4NRjpzmsZzHy4g=; b=K1SIkh2r0EKdtcBk0tomo8dU35
        5WrUy7Eecky4nivGhr2knARE/yRj6VAz+IHboGKdy3Cbmak0X7RjampU6anFY0sT62FolGugv7gcf
        5LSnMi86z8awRN0YY5brNYAoTeQlAI5/cUvPyVPo3Q65MuSbiQxhiaVKKvu95e6fhVi9xQm+yvDxm
        tOdRclN2jKjwVV8naCO05BNZjc9+/5m2aNplsV3kvy/4faDrb6sHkYD6QhX57C1QYPaBR97Odr99y
        dLHoji6Hd6PNbP80ZHiUBJRPTjPmTVuRqBXNzP8JQGnBwLl3DOd2CO0j4WshSXmUXbuyFpo2VAiXN
        AVFohvNw==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNwSS-004b9h-0J;
        Mon, 24 Jul 2023 14:22:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: consolidate the error handling in run_delalloc_nocow
Date:   Mon, 24 Jul 2023 07:22:40 -0700
Message-Id: <20230724142243.5742-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724142243.5742-1-hch@lst.de>
References: <20230724142243.5742-1-hch@lst.de>
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

Share the calls to extent_clear_unlock_delalloc for btrfs_path allocation
failure handling and the normal exit path.

This relies on btrfs_free_path ignoring a NULL pointer, and the
initialization of cur_offset to start at the beginning of the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 212aca4eea442b..2d465b50c228ed 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1973,21 +1973,14 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	struct btrfs_path *path;
 	u64 cow_start = (u64)-1;
 	u64 cur_offset = start;
-	int ret;
+	int ret = -ENOMEM;
 	bool check_prev = true;
 	u64 ino = btrfs_ino(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		extent_clear_unlock_delalloc(inode, start, end, locked_page,
-					     EXTENT_LOCKED | EXTENT_DELALLOC |
-					     EXTENT_DO_ACCOUNTING |
-					     EXTENT_DEFRAG, PAGE_UNLOCK |
-					     PAGE_START_WRITEBACK |
-					     PAGE_END_WRITEBACK);
-		return -ENOMEM;
-	}
+	if (!path)
+		goto error;
 
 	nocow_args.end = end;
 	nocow_args.writeback_path = true;
-- 
2.39.2

