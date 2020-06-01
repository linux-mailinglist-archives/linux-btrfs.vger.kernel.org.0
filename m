Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347B81EA6CC
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgFAPXH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:23:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56934 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgFAPXH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:23:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 63A4AB175;
        Mon,  1 Jun 2020 15:23:07 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 73E76DA79B; Mon,  1 Jun 2020 17:23:03 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/9] btrfs: scrub: remove kmap/kunmap of pages
Date:   Mon,  1 Jun 2020 17:23:03 +0200
Message-Id: <d2f0d8e604efa1908b86cac6dd6670e63a0a9a62.1591024792.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1591024792.git.dsterba@suse.com>
References: <cover.1591024792.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All pages that scrub uses in the scrub_block::pagev array are allocated
with GFP_KERNEL and never part of any mapping, so kmap is not necessary,
we only need to know the page address.

In scrub_write_page_to_dev_replace we don't even need to call
flush_dcache_page because of the same reason as above.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 016a025e36c7..368791b17bac 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1616,13 +1616,9 @@ static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
 	struct scrub_page *spage = sblock->pagev[page_num];
 
 	BUG_ON(spage->page == NULL);
-	if (spage->io_error) {
-		void *mapped_buffer = kmap_atomic(spage->page);
+	if (spage->io_error)
+		clear_page(page_address(spage->page));
 
-		clear_page(mapped_buffer);
-		flush_dcache_page(spage->page);
-		kunmap_atomic(mapped_buffer);
-	}
 	return scrub_add_page_to_wr_bio(sblock->sctx, spage);
 }
 
@@ -1805,7 +1801,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 
 	on_disk_csum = sblock->pagev[0]->csum;
 	page = sblock->pagev[0]->page;
-	buffer = kmap_atomic(page);
+	buffer = page_address(page);
 
 	len = sctx->fs_info->sectorsize;
 	index = 0;
@@ -1813,7 +1809,6 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 		u64 l = min_t(u64, len, PAGE_SIZE);
 
 		crypto_shash_update(shash, buffer, l);
-		kunmap_atomic(buffer);
 		len -= l;
 		if (len == 0)
 			break;
@@ -1821,7 +1816,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 		BUG_ON(index >= sblock->page_count);
 		BUG_ON(!sblock->pagev[index]->page);
 		page = sblock->pagev[index]->page;
-		buffer = kmap_atomic(page);
+		buffer = page_address(page);
 	}
 
 	crypto_shash_final(shash, csum);
@@ -1851,7 +1846,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 
 	BUG_ON(sblock->page_count < 1);
 	page = sblock->pagev[0]->page;
-	mapped_buffer = kmap_atomic(page);
+	mapped_buffer = page_address(page);
 	h = (struct btrfs_header *)mapped_buffer;
 	memcpy(on_disk_csum, h->csum, sctx->csum_size);
 
@@ -1883,7 +1878,6 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 		u64 l = min_t(u64, len, mapped_size);
 
 		crypto_shash_update(shash, p, l);
-		kunmap_atomic(mapped_buffer);
 		len -= l;
 		if (len == 0)
 			break;
@@ -1891,7 +1885,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 		BUG_ON(index >= sblock->page_count);
 		BUG_ON(!sblock->pagev[index]->page);
 		page = sblock->pagev[index]->page;
-		mapped_buffer = kmap_atomic(page);
+		mapped_buffer = page_address(page);
 		mapped_size = PAGE_SIZE;
 		p = mapped_buffer;
 	}
@@ -1925,7 +1919,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 
 	BUG_ON(sblock->page_count < 1);
 	page = sblock->pagev[0]->page;
-	mapped_buffer = kmap_atomic(page);
+	mapped_buffer = page_address(page);
 	s = (struct btrfs_super_block *)mapped_buffer;
 	memcpy(on_disk_csum, s->csum, sctx->csum_size);
 
@@ -1946,7 +1940,6 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 		u64 l = min_t(u64, len, mapped_size);
 
 		crypto_shash_update(shash, p, l);
-		kunmap_atomic(mapped_buffer);
 		len -= l;
 		if (len == 0)
 			break;
@@ -1954,7 +1947,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 		BUG_ON(index >= sblock->page_count);
 		BUG_ON(!sblock->pagev[index]->page);
 		page = sblock->pagev[index]->page;
-		mapped_buffer = kmap_atomic(page);
+		mapped_buffer = page_address(page);
 		mapped_size = PAGE_SIZE;
 		p = mapped_buffer;
 	}
-- 
2.25.0

