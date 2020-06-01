Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DDE1EA6D5
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgFAPXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:23:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:57052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgFAPXW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:23:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6386CB175;
        Mon,  1 Jun 2020 15:23:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7C0E9DA79B; Mon,  1 Jun 2020 17:23:19 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 8/9] btrfs: scrub: simplify tree block checksum calculation
Date:   Mon,  1 Jun 2020 17:23:19 +0200
Message-Id: <cd57270672b9328a0b2cfe79ddbea86eaa359bb1.1591024792.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1591024792.git.dsterba@suse.com>
References: <cover.1591024792.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use a simpler iteration over tree block pages, same what csum_tree_block
does: first page always exists, loop over the rest.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 19a64c72f38e..663bb2c22c50 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1814,15 +1814,10 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
+	const int num_pages = sctx->fs_info->nodesize >> PAGE_SHIFT;
+	int i;
 	struct page *page;
 	char *kaddr;
-	u64 mapped_size;
-	void *p;
-	u64 len;
-	int index;
-
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
 
 	BUG_ON(sblock->page_count < 1);
 	page = sblock->pagev[0]->page;
@@ -1850,24 +1845,14 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 		   BTRFS_UUID_SIZE))
 		sblock->header_error = 1;
 
-	len = sctx->fs_info->nodesize - BTRFS_CSUM_SIZE;
-	mapped_size = PAGE_SIZE - BTRFS_CSUM_SIZE;
-	p = kaddr + BTRFS_CSUM_SIZE;
-	index = 0;
-	for (;;) {
-		u64 l = min_t(u64, len, mapped_size);
+	shash->tfm = fs_info->csum_shash;
+	crypto_shash_init(shash);
+	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
+			    PAGE_SIZE - BTRFS_CSUM_SIZE);
 
-		crypto_shash_update(shash, p, l);
-		len -= l;
-		if (len == 0)
-			break;
-		index++;
-		BUG_ON(index >= sblock->page_count);
-		BUG_ON(!sblock->pagev[index]->page);
-		page = sblock->pagev[index]->page;
-		kaddr = page_address(page);
-		mapped_size = PAGE_SIZE;
-		p = kaddr;
+	for (i = 1; i < num_pages; i++) {
+		kaddr = page_address(sblock->pagev[i]->page);
+		crypto_shash_update(shash, kaddr, PAGE_SIZE);
 	}
 
 	crypto_shash_final(shash, calculated_csum);
-- 
2.25.0

