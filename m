Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A37929EE40
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgJ2O3g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:29:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:48978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbgJ2O3f (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603981773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8as2B4TcxswsJJtrGLWVOKRsQxJJmzwJw7FB7DZ3oyU=;
        b=jx+Xoqfcj5OzVQrXNILerVXc1QWJGa/YLKS8AYsau3ZGRgNRVfXAskIHE7DhBJActEL+8I
        EynMR1il5Up/3CIH09Km3C2Cc9d5oBr7pelCVzLkjbIY/M8He29kgdk1H3OFNExgEPW1F2
        L4YeutxcABRi5iMtCtHFIoSUL3WGC8w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BF9B4AB5C;
        Thu, 29 Oct 2020 14:29:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CEE61DA7CE; Thu, 29 Oct 2020 15:27:58 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 10/10] btrfs: scrub: remove local copy of csum_size from context
Date:   Thu, 29 Oct 2020 15:27:58 +0100
Message-Id: <7a311427bcb433f5ae9f84f4e07d3653e1518b1f.1603981453.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603981452.git.dsterba@suse.com>
References: <cover.1603981452.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The context structure unnecessarily stores copy of the checksum size,
that can be now easily obtained from fs_info.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d4f693a4ca38..d1c0bfcf368b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -161,7 +161,6 @@ struct scrub_ctx {
 	atomic_t		workers_pending;
 	spinlock_t		list_lock;
 	wait_queue_head_t	list_wait;
-	u16			csum_size;
 	struct list_head	csum_list;
 	atomic_t		cancel_req;
 	int			readonly;
@@ -610,7 +609,6 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	atomic_set(&sctx->bios_in_flight, 0);
 	atomic_set(&sctx->workers_pending, 0);
 	atomic_set(&sctx->cancel_req, 0);
-	sctx->csum_size = fs_info->csum_size;
 
 	spin_lock_init(&sctx->list_lock);
 	spin_lock_init(&sctx->stat_lock);
@@ -1349,7 +1347,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			if (have_csum)
 				memcpy(page->csum,
 				       original_sblock->pagev[0]->csum,
-				       sctx->csum_size);
+				       sctx->fs_info->csum_size);
 
 			scrub_stripe_index_and_offset(logical,
 						      bbio->map_type,
@@ -1800,7 +1798,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	crypto_shash_init(shash);
 	crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
 
-	if (memcmp(csum, spage->csum, sctx->csum_size))
+	if (memcmp(csum, spage->csum, sctx->fs_info->csum_size))
 		sblock->checksum_error = 1;
 
 	return sblock->checksum_error;
@@ -1823,7 +1821,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	spage = sblock->pagev[0];
 	kaddr = page_address(spage->page);
 	h = (struct btrfs_header *)kaddr;
-	memcpy(on_disk_csum, h->csum, sctx->csum_size);
+	memcpy(on_disk_csum, h->csum, sctx->fs_info->csum_size);
 
 	/*
 	 * we don't use the getter functions here, as we
@@ -1856,7 +1854,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	}
 
 	crypto_shash_final(shash, calculated_csum);
-	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
+	if (memcmp(calculated_csum, on_disk_csum, sctx->fs_info->csum_size))
 		sblock->checksum_error = 1;
 
 	return sblock->header_error || sblock->checksum_error;
@@ -1893,7 +1891,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	crypto_shash_digest(shash, kaddr + BTRFS_CSUM_SIZE,
 			BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, calculated_csum);
 
-	if (memcmp(calculated_csum, s->csum, sctx->csum_size))
+	if (memcmp(calculated_csum, s->csum, sctx->fs_info->csum_size))
 		++fail_cor;
 
 	if (fail_cor + fail_gen) {
@@ -2198,7 +2196,7 @@ static int scrub_pages(struct scrub_ctx *sctx, u64 logical, u64 len,
 		spage->mirror_num = mirror_num;
 		if (csum) {
 			spage->have_csum = 1;
-			memcpy(spage->csum, csum, sctx->csum_size);
+			memcpy(spage->csum, csum, sctx->fs_info->csum_size);
 		} else {
 			spage->have_csum = 0;
 		}
@@ -2390,7 +2388,8 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 	ASSERT(index < UINT_MAX);
 
 	num_sectors = sum->len >> sctx->fs_info->sectorsize_bits;
-	memcpy(csum, sum->sums + index * sctx->csum_size, sctx->csum_size);
+	memcpy(csum, sum->sums + index * sctx->fs_info->csum_size,
+		sctx->fs_info->csum_size);
 	if (index == num_sectors - 1) {
 		list_del(&sum->list);
 		kfree(sum);
@@ -2508,7 +2507,7 @@ static int scrub_pages_for_parity(struct scrub_parity *sparity,
 		spage->mirror_num = mirror_num;
 		if (csum) {
 			spage->have_csum = 1;
-			memcpy(spage->csum, csum, sctx->csum_size);
+			memcpy(spage->csum, csum, sctx->fs_info->csum_size);
 		} else {
 			spage->have_csum = 0;
 		}
-- 
2.25.0

