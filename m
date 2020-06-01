Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8661EA6CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFAPXN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:23:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:56978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgFAPXN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:23:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3FE2DB175;
        Mon,  1 Jun 2020 15:23:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5874ADA79B; Mon,  1 Jun 2020 17:23:10 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/9] btrfs: scrub: remove temporary csum array in scrub_checksum_super
Date:   Mon,  1 Jun 2020 17:23:10 +0200
Message-Id: <7ca5ac5d2811aa8c5bbd9591cb9aa777d1c6377a.1591024792.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1591024792.git.dsterba@suse.com>
References: <cover.1591024792.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The page contents with the checksum is available during the entire
function so we don't need to make a copy.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 13ee43f29751..abb39c5255d2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1904,7 +1904,6 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
-	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	struct page *page;
 	char *kaddr;
 	int fail_gen = 0;
@@ -1914,7 +1913,6 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	page = sblock->pagev[0]->page;
 	kaddr = page_address(page);
 	s = (struct btrfs_super_block *)kaddr;
-	memcpy(on_disk_csum, s->csum, sctx->csum_size);
 
 	if (sblock->pagev[0]->logical != btrfs_super_bytenr(s))
 		++fail_cor;
@@ -1930,7 +1928,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	crypto_shash_digest(shash, kaddr + BTRFS_CSUM_SIZE,
 			BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE, calculated_csum);
 
-	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
+	if (memcmp(calculated_csum, s->csum, sctx->csum_size))
 		++fail_cor;
 
 	if (fail_cor + fail_gen) {
-- 
2.25.0

