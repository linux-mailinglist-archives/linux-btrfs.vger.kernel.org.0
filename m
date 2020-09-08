Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C47260C76
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgIHHxC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 03:53:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbgIHHxB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 03:53:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6183BAE24;
        Tue,  8 Sep 2020 07:53:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 07/17] btrfs: make csum_tree_block() handle sectorsize smaller than page size
Date:   Tue,  8 Sep 2020 15:52:20 +0800
Message-Id: <20200908075230.86856-8-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908075230.86856-1-wqu@suse.com>
References: <20200908075230.86856-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage size support, we only need to handle the first page.

To make the code work for both cases, we modify the following behaviors:

- num_pages calcuation
  Instead of "nodesize >> PAGE_SHIFT", we go
  "DIV_ROUND_UP(nodesize, PAGE_SIZE)", this ensures we get at least one
  page for subpage size support, while still get the same result for
  reguar page size.

- The length for the first run
  Instead of PAGE_SIZE - BTRFS_CSUM_SIZE, we go min(PAGE_SIZE, nodesize)
  - BTRFS_CSUM_SIZE.
  This allows us to handle both cases well.

- The start location of the first run
  Instead of always use BTRFS_CSUM_SIZE as csum start position, add
  offset_in_page(eb->start) to get proper offset for both cases.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f6bba7eb1fa1..62dbd9bbd381 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -257,16 +257,16 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
-	const int num_pages = fs_info->nodesize >> PAGE_SHIFT;
+	const int num_pages = DIV_ROUND_UP(fs_info->nodesize, PAGE_SIZE);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
 	int i;
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
-	kaddr = page_address(buf->pages[0]);
+	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
-			    PAGE_SIZE - BTRFS_CSUM_SIZE);
+		min_t(u32, PAGE_SIZE, fs_info->nodesize) - BTRFS_CSUM_SIZE);
 
 	for (i = 1; i < num_pages; i++) {
 		kaddr = page_address(buf->pages[i]);
-- 
2.28.0

