Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01351EA6CD
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgFAPXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:23:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:56944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgFAPXJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:23:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AA498AD72;
        Mon,  1 Jun 2020 15:23:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BAAF0DA79B; Mon,  1 Jun 2020 17:23:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/9] btrfs: scrub: unify naming of page address variables
Date:   Mon,  1 Jun 2020 17:23:05 +0200
Message-Id: <af376a3c9d0f2ed26aa4be3c8343dde9ccf2dadf.1591024792.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1591024792.git.dsterba@suse.com>
References: <cover.1591024792.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As the page mapping has been removed, rename the variables to 'kaddr'
that we use everywhere else. The type is changed to 'char *' so pointer
arithmetic works without casts.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 368791b17bac..7dc4a090db57 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1788,7 +1788,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	u8 csum[BTRFS_CSUM_SIZE];
 	u8 *on_disk_csum;
 	struct page *page;
-	void *buffer;
+	char *kaddr;
 	u64 len;
 	int index;
 
@@ -1801,14 +1801,14 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 
 	on_disk_csum = sblock->pagev[0]->csum;
 	page = sblock->pagev[0]->page;
-	buffer = page_address(page);
+	kaddr = page_address(page);
 
 	len = sctx->fs_info->sectorsize;
 	index = 0;
 	for (;;) {
 		u64 l = min_t(u64, len, PAGE_SIZE);
 
-		crypto_shash_update(shash, buffer, l);
+		crypto_shash_update(shash, kaddr, l);
 		len -= l;
 		if (len == 0)
 			break;
@@ -1816,7 +1816,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 		BUG_ON(index >= sblock->page_count);
 		BUG_ON(!sblock->pagev[index]->page);
 		page = sblock->pagev[index]->page;
-		buffer = page_address(page);
+		kaddr = page_address(page);
 	}
 
 	crypto_shash_final(shash, csum);
@@ -1835,7 +1835,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	struct page *page;
-	void *mapped_buffer;
+	char *kaddr;
 	u64 mapped_size;
 	void *p;
 	u64 len;
@@ -1846,8 +1846,8 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 
 	BUG_ON(sblock->page_count < 1);
 	page = sblock->pagev[0]->page;
-	mapped_buffer = page_address(page);
-	h = (struct btrfs_header *)mapped_buffer;
+	kaddr = page_address(page);
+	h = (struct btrfs_header *)kaddr;
 	memcpy(on_disk_csum, h->csum, sctx->csum_size);
 
 	/*
@@ -1872,7 +1872,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 
 	len = sctx->fs_info->nodesize - BTRFS_CSUM_SIZE;
 	mapped_size = PAGE_SIZE - BTRFS_CSUM_SIZE;
-	p = ((u8 *)mapped_buffer) + BTRFS_CSUM_SIZE;
+	p = kaddr + BTRFS_CSUM_SIZE;
 	index = 0;
 	for (;;) {
 		u64 l = min_t(u64, len, mapped_size);
@@ -1885,9 +1885,9 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 		BUG_ON(index >= sblock->page_count);
 		BUG_ON(!sblock->pagev[index]->page);
 		page = sblock->pagev[index]->page;
-		mapped_buffer = page_address(page);
+		kaddr = page_address(page);
 		mapped_size = PAGE_SIZE;
-		p = mapped_buffer;
+		p = kaddr;
 	}
 
 	crypto_shash_final(shash, calculated_csum);
@@ -1906,7 +1906,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	struct page *page;
-	void *mapped_buffer;
+	char *kaddr;
 	u64 mapped_size;
 	void *p;
 	int fail_gen = 0;
@@ -1919,8 +1919,8 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 
 	BUG_ON(sblock->page_count < 1);
 	page = sblock->pagev[0]->page;
-	mapped_buffer = page_address(page);
-	s = (struct btrfs_super_block *)mapped_buffer;
+	kaddr = page_address(page);
+	s = (struct btrfs_super_block *)kaddr;
 	memcpy(on_disk_csum, s->csum, sctx->csum_size);
 
 	if (sblock->pagev[0]->logical != btrfs_super_bytenr(s))
@@ -1934,7 +1934,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 
 	len = BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE;
 	mapped_size = PAGE_SIZE - BTRFS_CSUM_SIZE;
-	p = ((u8 *)mapped_buffer) + BTRFS_CSUM_SIZE;
+	p = kaddr + BTRFS_CSUM_SIZE;
 	index = 0;
 	for (;;) {
 		u64 l = min_t(u64, len, mapped_size);
@@ -1947,9 +1947,9 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 		BUG_ON(index >= sblock->page_count);
 		BUG_ON(!sblock->pagev[index]->page);
 		page = sblock->pagev[index]->page;
-		mapped_buffer = page_address(page);
+		kaddr = page_address(page);
 		mapped_size = PAGE_SIZE;
-		p = mapped_buffer;
+		p = kaddr;
 	}
 
 	crypto_shash_final(shash, calculated_csum);
-- 
2.25.0

