Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947BE38BFD2
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 08:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhEUGog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 02:44:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:59008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhEUGoT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 02:44:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621579285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ClZNYoBOMXtCrWCRQM9mHsvGsls0DNr+VpZ8ptGHrgY=;
        b=Pi0MVhpwtNmF4+4KEK31AH72Y8Hj8FX3iglde3vRvyoSjselzldq2//UFVWNGmcPg1lARL
        9nUUPiDw2PZtTgyejf9hFUd71QPnE0A5KvmUDRBh+3c0eN/MciTiQ+m3CYujSDo1SVyqgo
        JaaO7Os+qdQ6/DyK+KChElou97Mq/q4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57E12AD80
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:41:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 17/31] btrfs: reflink: make copy_inline_to_page() to be subpage compatible
Date:   Fri, 21 May 2021 14:40:36 +0800
Message-Id: <20210521064050.191164-18-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521064050.191164-1-wqu@suse.com>
References: <20210521064050.191164-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The modifications are:
- Page copy destination
  For subpage case, one page can contain multiple sectors, thus we can
  no longer expect the memcpy_to_page()/btrfs_decompress() to copy
  data into page offset 0.
  The correct offset is offset_in_page(file_offset) now, which should
  handle both regular sectorsize and subpage cases well.

- Page status update
  Now we need to use subpage helper to handle the page status update.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/reflink.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index d434dc78dadf..a6e8b8e67c80 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -7,6 +7,7 @@
 #include "delalloc-space.h"
 #include "reflink.h"
 #include "transaction.h"
+#include "subpage.h"
 
 #define BTRFS_MAX_DEDUPE_LEN	SZ_16M
 
@@ -52,7 +53,8 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 			       const u64 datal,
 			       const u8 comp_type)
 {
-	const u64 block_size = btrfs_inode_sectorsize(inode);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u32 block_size = fs_info->sectorsize;
 	const u64 range_end = file_offset + block_size - 1;
 	const size_t inline_size = size - btrfs_file_extent_calc_inline_size(0);
 	char *data_start = inline_data + btrfs_file_extent_calc_inline_size(0);
@@ -106,10 +108,12 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 	set_bit(BTRFS_INODE_NO_DELALLOC_FLUSH, &inode->runtime_flags);
 
 	if (comp_type == BTRFS_COMPRESS_NONE) {
-		memcpy_to_page(page, 0, data_start, datal);
+		memcpy_to_page(page, offset_in_page(file_offset), data_start,
+			       datal);
 		flush_dcache_page(page);
 	} else {
-		ret = btrfs_decompress(comp_type, data_start, page, 0,
+		ret = btrfs_decompress(comp_type, data_start, page,
+				       offset_in_page(file_offset),
 				       inline_size, datal);
 		if (ret)
 			goto out_unlock;
@@ -133,9 +137,9 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 		flush_dcache_page(page);
 	}
 
-	SetPageUptodate(page);
+	btrfs_page_set_uptodate(fs_info, page, file_offset, block_size);
 	ClearPageChecked(page);
-	set_page_dirty(page);
+	btrfs_page_set_dirty(fs_info, page, file_offset, block_size);
 out_unlock:
 	if (page) {
 		unlock_page(page);
-- 
2.31.1

