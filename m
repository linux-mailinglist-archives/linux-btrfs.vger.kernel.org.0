Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A64B48D1D4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 06:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiAMFWX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 00:22:23 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47488 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiAMFWX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 00:22:23 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0A93E212C7
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jan 2022 05:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642051342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RPuEgDL5KAYNC2xe9YAmsQ7X14PZ8/axzDcaisDNe3U=;
        b=QJiy4qcU5Si+hp2WCLGxhTnxFOxwqZ06ZZeEEuoBqks2M2SDIP7E4byZR9U1oZZGMaWtB4
        5wbSqYzYOt6c5fG2t0+ZGMnB8cBZedaD6l5eibpaZf8AiwSN1Tii2XuZQYxWkAzuVDc51C
        1sJYWyniW/LTtBE9r5cQ4OAkSRqHfRQ=
Received: from adam-pc.suse.de (unknown [10.163.34.62])
        by relay2.suse.de (Postfix) with ESMTP id EBE80A3B83
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jan 2022 05:22:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: use dummy extent buffer for super block sys chunk array read
Date:   Thu, 13 Jan 2022 13:22:08 +0800
Message-Id: <20220113052210.23614-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113052210.23614-1-wqu@suse.com>
References: <20220113052210.23614-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In function btrfs_read_sys_array(), we allocate a real extent buffer
using btrfs_find_create_tree_block().

Such extent buffer will be even cached into buffer_radix tree, and using
btree inode address space.

However we only use such extent buffer to enable the accessors, thus we
don't even need to bother using real extent buffer, a dummy one is
what we really need.

And for dummy extent buffer, we no longer need to do any special
handling for the first page, as subpage helper is already doing it
properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b07d382d53a8..5ff5bf8f42f7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7373,7 +7373,6 @@ static int read_one_dev(struct extent_buffer *leaf,
 
 int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_super_block *super_copy = fs_info->super_copy;
 	struct extent_buffer *sb;
 	struct btrfs_disk_key *disk_key;
@@ -7389,30 +7388,16 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	struct btrfs_key key;
 
 	ASSERT(BTRFS_SUPER_INFO_SIZE <= fs_info->nodesize);
+
 	/*
-	 * This will create extent buffer of nodesize, superblock size is
-	 * fixed to BTRFS_SUPER_INFO_SIZE. If nodesize > sb size, this will
-	 * overallocate but we can keep it as-is, only the first page is used.
+	 * We allocated a dummy extent, just to use extent buffer accessors.
+	 * There will be unused space after BTRFS_SUPER_INFO_SIZE, but
+	 * that's fine, we will not go beyond system chunk array anyway.
 	 */
-	sb = btrfs_find_create_tree_block(fs_info, BTRFS_SUPER_INFO_OFFSET,
-					  root->root_key.objectid, 0);
+	sb = alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 	set_extent_buffer_uptodate(sb);
-	/*
-	 * The sb extent buffer is artificial and just used to read the system array.
-	 * set_extent_buffer_uptodate() call does not properly mark all it's
-	 * pages up-to-date when the page is larger: extent does not cover the
-	 * whole page and consequently check_page_uptodate does not find all
-	 * the page's extents up-to-date (the hole beyond sb),
-	 * write_extent_buffer then triggers a WARN_ON.
-	 *
-	 * Regular short extents go through mark_extent_buffer_dirty/writeback cycle,
-	 * but sb spans only this function. Add an explicit SetPageUptodate call
-	 * to silence the warning eg. on PowerPC 64.
-	 */
-	if (PAGE_SIZE > BTRFS_SUPER_INFO_SIZE)
-		SetPageUptodate(sb->pages[0]);
 
 	write_extent_buffer(sb, super_copy, 0, BTRFS_SUPER_INFO_SIZE);
 	array_size = btrfs_super_sys_array_size(super_copy);
-- 
2.34.1

