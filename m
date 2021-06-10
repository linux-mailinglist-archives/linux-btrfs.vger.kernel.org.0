Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534D43A23B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 07:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhFJFLX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 01:11:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59016 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhFJFLX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 01:11:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BD9C52199E
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jun 2021 05:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623301766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NylQJnFXD/JBjo064gyrs98YfRzpynO9C0kWwjldi1M=;
        b=fduUBmnXJy8GW8NIiw1G6958EALqoPI/ZwAr7Snzmi5nq3VNI6Ir+kBWlIUkwvNLT8WvAy
        0tXbQA9VL8PizAj7MEyvY1OiC2nTa2zMhLj9K1giO52I5UWv0aCEYqKfNrVHAobMMaCXvs
        xN63xY17bNAk44GlzBh36pVxtdC1dn0=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id BF664A3B81
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jun 2021 05:09:25 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 03/10] btrfs: defrag: replace hard coded PAGE_SIZE to sectorsize for defrag_lookup_extent()
Date:   Thu, 10 Jun 2021 13:09:10 +0800
Message-Id: <20210610050917.105458-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610050917.105458-1-wqu@suse.com>
References: <20210610050917.105458-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When testing subpage defrag support, I always find some strange inode
nbytes error, after a lot of debugging, it turns out that
defrag_lookup_extent() is using PAGE_SIZE as size for
lookup_extent_mapping().

Since lookup_extent_mapping() is calling __lookup_extent_mapping() with
@strict == 1, this means any extent map smaller than one page will be
ignored, prevent subpage defrag to grab a correct extent map.

There are quite some PAGE_SIZE usage in ioctl.c, but most of them are
correct usages, and can be one of the following cases:

- ioctl structure size check
  We want ioctl structure be contained inside one page.

- real page opeartions

There is one special case left untouched, check_defrag_in_cache().
This function will later be removed completely, thus there is not much
meaning to change it now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a06ceb8fdf28..096157ee30f1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1037,23 +1037,24 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start)
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_map *em;
-	u64 len = PAGE_SIZE;
+	const u32 sectorsize = BTRFS_I(inode)->root->fs_info->sectorsize;
 
 	/*
 	 * hopefully we have this extent in the tree already, try without
 	 * the full extent lock
 	 */
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, len);
+	em = lookup_extent_mapping(em_tree, start, sectorsize);
 	read_unlock(&em_tree->lock);
 
 	if (!em) {
 		struct extent_state *cached = NULL;
-		u64 end = start + len - 1;
+		u64 end = start + sectorsize - 1;
 
 		/* get the big lock and read metadata off disk */
 		lock_extent_bits(io_tree, start, end, &cached);
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start,
+				      sectorsize);
 		unlock_extent_cached(io_tree, start, end, &cached);
 
 		if (IS_ERR(em))
-- 
2.32.0

