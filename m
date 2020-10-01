Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073BB27F934
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgJAF55 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:57:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:40070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730498AbgJAF55 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:57:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VnFZbVw8sNN840vtB6i++jsztgAWLo+nfEWHXTrf8wc=;
        b=a4G3eVf3gzVuG3ifvvFempkjNxCOcqmqAsBKKjvVr0BHADs6uvoKMGe4h58KYiF8tpvS9H
        iANHfw0DjOSqv0sc1pAzLnT2nYxpnyvnN4cmAkZiN/pI/SyMZyRS4m1ABXxKgYDHpmvf11
        MXn33xBiWPYJyh0AyJ0smnlWPtH1j5k=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61BB5B328
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 05:57:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9 02/12] btrfs: block-group: extra the code to delete block group from fs_info rb tree
Date:   Thu,  1 Oct 2020 13:57:34 +0800
Message-Id: <20201001055744.103261-3-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001055744.103261-1-wqu@suse.com>
References: <20201001055744.103261-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Extra the common code into a function, del_block_group(), to delete
block group from fs_info rb tree.

The function will remove it from rb tree, and update the logical bytenr
hint for fs_info.

There is only one caller for now, btrfs_remove_block_group().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 585843d39e06..831855c85419 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -187,6 +187,21 @@ static int add_block_group(struct btrfs_block_group *block_group)
 	return 0;
 }
 
+/* This removes block group from fs_info rb tree */
+static void del_block_group(struct btrfs_block_group *block_group)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+
+	spin_lock(&fs_info->block_group_cache_lock);
+	rb_erase(&block_group->cache_node,
+		 &fs_info->block_group_cache_tree);
+	RB_CLEAR_NODE(&block_group->cache_node);
+
+	if (fs_info->first_logical_byte == block_group->start)
+		fs_info->first_logical_byte = (u64)-1;
+	spin_unlock(&fs_info->block_group_cache_lock);
+}
+
 /*
  * This will return the block group at or after bytenr if contains is 0, else
  * it will return the block group that contains the bytenr
@@ -1008,18 +1023,10 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		btrfs_release_path(path);
 	}
 
-	spin_lock(&fs_info->block_group_cache_lock);
-	rb_erase(&block_group->cache_node,
-		 &fs_info->block_group_cache_tree);
-	RB_CLEAR_NODE(&block_group->cache_node);
-
+	del_block_group(block_group);
 	/* Once for the block groups rbtree */
 	btrfs_put_block_group(block_group);
 
-	if (fs_info->first_logical_byte == block_group->start)
-		fs_info->first_logical_byte = (u64)-1;
-	spin_unlock(&fs_info->block_group_cache_lock);
-
 	down_write(&block_group->space_info->groups_sem);
 	/*
 	 * we must use list_del_init so people can check to see if they
-- 
2.28.0

