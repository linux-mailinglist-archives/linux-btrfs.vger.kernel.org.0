Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7A636CF2F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239465AbhD0XFq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239462AbhD0XFq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrUjlpidH9wEM0WCrL79YYuS1RwARpn9CRENOux2L6o=;
        b=GHzVXvuY3eNVIsR9CR60tYjcGPNr2WtBqSfsGe0oHLUD0pH4rT9fL0yuJqg+3sylpH1zfo
        /YmH4GMyRvpQEPw9yWjPa+SGee0zSfjAUlW01w8fvkdPKt7fnI5gSeznvnn9FLVEGgWVNL
        Af+GcdQEYnDsyEQPgvnDtUnm8vf1kCk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE7C7AC6A
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:05:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 30/42] btrfs: reflink: make copy_inline_to_page() to be subpage compatible
Date:   Wed, 28 Apr 2021 07:03:37 +0800
Message-Id: <20210427230349.369603-31-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
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
index f4ec06b53aa0..e5680c03ead4 100644
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
@@ -137,9 +141,9 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 		kunmap(page);
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

