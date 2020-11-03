Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1593A2A469F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgKCNcq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:45976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729241AbgKCNcq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHLxx4iiZAaFvMQ14rBBzkaKGJZ2L1cg3aKFCPU+yW4=;
        b=Z9dPoVfpxP8SgWczgu+0jl2wON4x/Yww7ZHL8ryQfeThbQ8QLhPrA4QlEPtHiuueGxigcz
        pQ3glVktd/r9qbrKCtJE1LW5CvnUFXTJ2T7nFYy7FnDb0A8XiXplJHxbQFdd7T2G9HBLdx
        LPF3JDNueegdln9tDzdWKyq/EIrI2u8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 665A6ACC0
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 31/32] btrfs: scrub: support subpage tree block scrub
Date:   Tue,  3 Nov 2020 21:31:07 +0800
Message-Id: <20201103133108.148112-32-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To support subpage tree block scrub, scrub_checksum_tree_block() only
needs to learn 2 new tricks:
- Follow scrub_page::page_len
  Now scrub_page only represents one sector, we need to follow it
  properly.

- Run checksum on all sectors
  Since scrub_page only represents one sector, we need to run hash on
  all sectors, no longer just (nodesize >> PAGE_SIZE).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 230ba24a4fdf..deee5c9bd442 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1839,15 +1839,21 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	struct scrub_ctx *sctx = sblock->sctx;
 	struct btrfs_header *h;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	u32 sectorsize = sctx->fs_info->sectorsize;
+	u32 nodesize = sctx->fs_info->nodesize;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
-	const int num_pages = sctx->fs_info->nodesize >> PAGE_SHIFT;
+	const int num_sectors = nodesize / sectorsize;
 	int i;
 	struct scrub_page *spage;
 	char *kaddr;
 
 	BUG_ON(sblock->page_count < 1);
+
+	/* Each pagev[] is in fact just one sector, not a full page */
+	ASSERT(sblock->page_count == num_sectors);
+
 	spage = sblock->pagev[0];
 	kaddr = page_address(spage->page);
 	h = (struct btrfs_header *)kaddr;
@@ -1876,11 +1882,11 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
-			    PAGE_SIZE - BTRFS_CSUM_SIZE);
+			    spage->page_len - BTRFS_CSUM_SIZE);
 
-	for (i = 1; i < num_pages; i++) {
+	for (i = 1; i < num_sectors; i++) {
 		kaddr = page_address(sblock->pagev[i]->page);
-		crypto_shash_update(shash, kaddr, PAGE_SIZE);
+		crypto_shash_update(shash, kaddr, sblock->pagev[i]->page_len);
 	}
 
 	crypto_shash_final(shash, calculated_csum);
-- 
2.29.2

