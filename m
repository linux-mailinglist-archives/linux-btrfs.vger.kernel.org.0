Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C88027F933
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgJAF5z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:57:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:40050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbgJAF5z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:57:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r55sHVqQj+jXdCTel7rkLS/jMKiSBEsFR+BROdHTMzs=;
        b=nqnxdwo1ByM5OxksCLqmKfor/SAj3yzUt+JMO/jhjk+5xLuTPPHxZSg818hi0NqoNtsUrV
        n+6RmFnsnM+DcPOFaBheDSONuOymR6FtSXiZiHAXvHpwpBQBnld3fP0mVqMOTVCC3/tWri
        0kf1R6kohbzi2d7JjWOC3QrsHpNDrOQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C562B31D
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 05:57:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9 01/12] btrfs: block-group: cleanup btrfs_add_block_group_cache()
Date:   Thu,  1 Oct 2020 13:57:33 +0800
Message-Id: <20201001055744.103261-2-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001055744.103261-1-wqu@suse.com>
References: <20201001055744.103261-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can cleanup btrfs_add_block_group_cache() by:
- Remove the "btrfs_" prefix
  Since it's not exported, and only used inside block-group.c

- Remove the "_cache" suffix
  We have renamed struct btrfs_block_group_cache to btrfs_block_group,
  thus no need to keep the "_cache" suffix.

- Sink the btrfs_fs_info parameter
  Since commit aac0023c2106 ("btrfs: move basic block_group definitions to
  their own header") we can grab btrfs_fs_info from struct
  btrfs_block_group directly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ea8aaf36647e..585843d39e06 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -150,9 +150,9 @@ void btrfs_put_block_group(struct btrfs_block_group *cache)
 /*
  * This adds the block group to the fs_info rb tree for the block group cache
  */
-static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
-				       struct btrfs_block_group *block_group)
+static int add_block_group(struct btrfs_block_group *block_group)
 {
+	struct btrfs_fs_info *info = block_group->fs_info;
 	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct btrfs_block_group *cache;
@@ -1966,7 +1966,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		btrfs_free_excluded_extents(cache);
 	}
 
-	ret = btrfs_add_block_group_cache(info, cache);
+	ret = add_block_group(cache);
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
 		goto error;
@@ -2167,7 +2167,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	cache->space_info = btrfs_find_space_info(fs_info, cache->flags);
 	ASSERT(cache->space_info);
 
-	ret = btrfs_add_block_group_cache(fs_info, cache);
+	ret = add_block_group(cache);
 	if (ret) {
 		btrfs_remove_free_space_cache(cache);
 		btrfs_put_block_group(cache);
-- 
2.28.0

