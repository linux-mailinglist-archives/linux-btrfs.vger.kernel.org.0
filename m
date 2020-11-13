Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33FD2B1B70
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKMMxL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:53:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:47816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbgKMMxL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:53:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zWF8sQgn9HNJDu5JBCgUifjpX2rVxHyopPhd8bKIgmo=;
        b=bF9qNKWoVFYgzpuWhBz6KNPJfGI/z9w/tFdNcej8Mltn1nEiBSdXmyQeh4LpJplsmCrsRW
        rlZQt5i/JIfcQs3ZZMnrtYY8aQRjrIaTeRfTLCwajK5mAHaQYUCT/rtkFkFdcn7xf1PoWt
        fPimVnO26bkgFZwe1kt8+CARCqdHzCM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9BB27ABD6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:53:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 21/24] btrfs: scrub: support subpage tree block scrub
Date:   Fri, 13 Nov 2020 20:51:46 +0800
Message-Id: <20201113125149.140836-22-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To support subpage tree block scrub, scrub_checksum_tree_block() only
needs to learn 2 new tricks:

- Follow sector size
  Now scrub_page only represents one sector, we need to follow it
  properly.

- Run checksum on all sectors
  Since scrub_page only represents one sector, we need to run hash on
  all sectors, no longer just (nodesize >> PAGE_SIZE).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c41911604919..ed63921789d4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1807,15 +1807,20 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	struct scrub_ctx *sctx = sblock->sctx;
 	struct btrfs_header *h;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	u32 sectorsize = sctx->fs_info->sectorsize;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
-	const int num_pages = sctx->fs_info->nodesize >> PAGE_SHIFT;
+	const int num_sectors = fs_info->nodesize >> fs_info->sectorsize_bits;
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
@@ -1844,11 +1849,11 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
-			    PAGE_SIZE - BTRFS_CSUM_SIZE);
+			    sectorsize - BTRFS_CSUM_SIZE);
 
-	for (i = 1; i < num_pages; i++) {
+	for (i = 1; i < num_sectors; i++) {
 		kaddr = page_address(sblock->pagev[i]->page);
-		crypto_shash_update(shash, kaddr, PAGE_SIZE);
+		crypto_shash_update(shash, kaddr, sectorsize);
 	}
 
 	crypto_shash_final(shash, calculated_csum);
-- 
2.29.2

