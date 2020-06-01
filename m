Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426941EA6D6
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgFAPX0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:23:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:57082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgFAPXZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:23:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BBFBBB1F5;
        Mon,  1 Jun 2020 15:23:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C30C4DA79B; Mon,  1 Jun 2020 17:23:21 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 9/9] btrfs: scrub: clean up temporary page variables in scrub_checksum_tree_block
Date:   Mon,  1 Jun 2020 17:23:21 +0200
Message-Id: <cb51d704417c68e0100ddd2aabf11eb880821933.1591024792.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1591024792.git.dsterba@suse.com>
References: <cover.1591024792.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add proper variable for the scrub page and use it instead of repeatedly
dereferencing the other structures.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 663bb2c22c50..d935ac06323f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1816,12 +1816,12 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	const int num_pages = sctx->fs_info->nodesize >> PAGE_SHIFT;
 	int i;
-	struct page *page;
+	struct scrub_page *spage;
 	char *kaddr;
 
 	BUG_ON(sblock->page_count < 1);
-	page = sblock->pagev[0]->page;
-	kaddr = page_address(page);
+	spage = sblock->pagev[0];
+	kaddr = page_address(spage->page);
 	h = (struct btrfs_header *)kaddr;
 	memcpy(on_disk_csum, h->csum, sctx->csum_size);
 
@@ -1830,15 +1830,15 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	 * a) don't have an extent buffer and
 	 * b) the page is already kmapped
 	 */
-	if (sblock->pagev[0]->logical != btrfs_stack_header_bytenr(h))
+	if (spage->logical != btrfs_stack_header_bytenr(h))
 		sblock->header_error = 1;
 
-	if (sblock->pagev[0]->generation != btrfs_stack_header_generation(h)) {
+	if (spage->generation != btrfs_stack_header_generation(h)) {
 		sblock->header_error = 1;
 		sblock->generation_error = 1;
 	}
 
-	if (!scrub_check_fsid(h->fsid, sblock->pagev[0]))
+	if (!scrub_check_fsid(h->fsid, spage))
 		sblock->header_error = 1;
 
 	if (memcmp(h->chunk_tree_uuid, fs_info->chunk_tree_uuid,
-- 
2.25.0

