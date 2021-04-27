Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65FE36CF13
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbhD0XEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:04:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:36674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235395AbhD0XEm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:04:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0WT5+qxWMZiazZFJHadAwE1JX1x4zQ7csv6bKK7fbDc=;
        b=QpG/3/nWG7uaAe57t7sGASTZjjgprPIz9jPoyLvx1j9KKx8CXGhhubRrSUCBfVifnbSLcH
        LtHq/11J0q9A5RBh2JdFwVvyivdfvoSHPnO4MRgGpRhkB3Rprr1xaWz6ssAHuznuyKbfFg
        E8/hMAqEs7ktLhkIjGrDu8L3OJ9sZ+4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CBCEBABED
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:03:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 02/42] btrfs: make free space cache size consistent across different PAGE_SIZE
Date:   Wed, 28 Apr 2021 07:03:09 +0800
Message-Id: <20210427230349.369603-3-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently free space cache inode size is determined by two factors:
- block group size
- PAGE_SIZE

This means, for the same sized block group, with different PAGE_SIZE, it
will result different inode size.

This will not be a good thing for subpage support, so change the
requirement for PAGE_SIZE to sectorsize.

Now for the same 4K sectorsize btrfs, it should result the same inode
size no matter whatever the PAGE_SIZE is.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index aa57bdc8fc89..38885b29e6e5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2505,7 +2505,7 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	struct extent_changeset *data_reserved = NULL;
 	u64 alloc_hint = 0;
 	int dcs = BTRFS_DC_ERROR;
-	u64 num_pages = 0;
+	u64 cache_size = 0;
 	int retries = 0;
 	int ret = 0;
 
@@ -2617,20 +2617,20 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	 * taking up quite a bit since it's not folded into the other space
 	 * cache.
 	 */
-	num_pages = div_u64(block_group->length, SZ_256M);
-	if (!num_pages)
-		num_pages = 1;
+	cache_size = div_u64(block_group->length, SZ_256M);
+	if (!cache_size)
+		cache_size = 1;
 
-	num_pages *= 16;
-	num_pages *= PAGE_SIZE;
+	cache_size *= 16;
+	cache_size *= fs_info->sectorsize;
 
 	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved, 0,
-					  num_pages);
+					  cache_size);
 	if (ret)
 		goto out_put;
 
-	ret = btrfs_prealloc_file_range_trans(inode, trans, 0, 0, num_pages,
-					      num_pages, num_pages,
+	ret = btrfs_prealloc_file_range_trans(inode, trans, 0, 0, cache_size,
+					      cache_size, cache_size,
 					      &alloc_hint);
 	/*
 	 * Our cache requires contiguous chunks so that we don't modify a bunch
-- 
2.31.1

