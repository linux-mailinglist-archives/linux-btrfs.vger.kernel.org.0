Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174D31EA6CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgFAPXL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:23:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:56954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgFAPXL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:23:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 02084ADF7;
        Mon,  1 Jun 2020 15:23:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0F7A1DA79B; Mon,  1 Jun 2020 17:23:08 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/9] btrfs: scrub: simplify superblock checksum calculation
Date:   Mon,  1 Jun 2020 17:23:07 +0200
Message-Id: <213f966ae25ce6503542b1db2fd3f29f9a2a0949.1591024792.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1591024792.git.dsterba@suse.com>
References: <cover.1591024792.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS_SUPER_INFO_SIZE is 4096, and fits to a page on all supported
architectures, so we can calculate the checksum in one go.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 7dc4a090db57..13ee43f29751 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1907,15 +1907,8 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	struct page *page;
 	char *kaddr;
-	u64 mapped_size;
-	void *p;
 	int fail_gen = 0;
 	int fail_cor = 0;
-	u64 len;
-	int index;
-
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
 
 	BUG_ON(sblock->page_count < 1);
 	page = sblock->pagev[0]->page;
@@ -1932,27 +1925,11 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	if (!scrub_check_fsid(s->fsid, sblock->pagev[0]))
 		++fail_cor;
 
-	len = BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE;
-	mapped_size = PAGE_SIZE - BTRFS_CSUM_SIZE;
-	p = kaddr + BTRFS_CSUM_SIZE;
-	index = 0;
-	for (;;) {
-		u64 l = min_t(u64, len, mapped_size);
-
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
-	}
+	shash->tfm = fs_info->csum_shash;
+	crypto_shash_init(shash);
+	crypto_shash_digest(shash, kaddr + BTRFS_CSUM_SIZE,
+			BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, calculated_csum);
 
-	crypto_shash_final(shash, calculated_csum);
 	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
 		++fail_cor;
 
-- 
2.25.0

