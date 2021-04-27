Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A4336CF23
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbhD0XFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:37022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239185AbhD0XFT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWjTf70J6IBpwk4DXLBy8+tqlwvKkChQGbZeLg/9GIQ=;
        b=rLs61Ueu59tHYphdU4YuEf7A1PJybOfnsGDg+nePUR1ewwQSYDuaaZ+zjY/k+5kjT/G17A
        tdth1PCdbCTLXYDsHIyLOQpXOAGpgSNZ3QXWYc0VpPdAsE2XTKad0YJulnvgaRbhEpJU4W
        2znuiLc736+oQ8splkxGjqg3t4DnawU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B92DABED;
        Tue, 27 Apr 2021 23:04:35 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [Patch v2 18/42] btrfs: make btrfs_dirty_pages() to be subpage compatible
Date:   Wed, 28 Apr 2021 07:03:25 +0800
Message-Id: <20210427230349.369603-19-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since the extent io tree operations in btrfs_dirty_pages() are already
subpage compatible, we only need to make the page status update to use
subpage helpers.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 864c08d08a35..8f71699fdd18 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -28,6 +28,7 @@
 #include "compression.h"
 #include "delalloc-space.h"
 #include "reflink.h"
+#include "subpage.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
@@ -482,6 +483,7 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	start_pos = round_down(pos, fs_info->sectorsize);
 	num_bytes = round_up(write_bytes + pos - start_pos,
 			     fs_info->sectorsize);
+	ASSERT(num_bytes <= U32_MAX);
 
 	end_of_last_block = start_pos + num_bytes - 1;
 
@@ -500,9 +502,10 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = pages[i];
-		SetPageUptodate(p);
+
+		btrfs_page_clamp_set_uptodate(fs_info, p, start_pos, num_bytes);
 		ClearPageChecked(p);
-		set_page_dirty(p);
+		btrfs_page_clamp_set_dirty(fs_info, p, start_pos, num_bytes);
 	}
 
 	/*
-- 
2.31.1

