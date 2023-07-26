Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E12763BCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjGZP6G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjGZP5b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11D2100
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F6BA61A21
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29CA4C433CB
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387049;
        bh=UqTyHnotFGChh78Tjzd0w6jJmADTq97xrTdADOACFkg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sbhfkdPBtKW/olzs7iefVlXU4cGOgPYExRUAx3RQpTzgF+ZYgmpBGl60hpGtYxFRN
         2rP7pJdii6N+vZoAdjRltZYR8as0XDAvKsdUiUlljSN93xBBwLPK5c1gPhxqOrZkdR
         3LskZUDOqh+2GaPUZk3nIDy9/6sOoaWqrF3SOHKF3J9i8u52g3llYPhn29l9k9zlA/
         eHoBEs72QSjSQDELZlIOyUVdEDKAOkAmMn4OKKieo4Sy6zo0X7ralrip3mbPkBXOO/
         H2gy8B/uYfXvEAl+5ysYwr18O677sg51pbJRrgZgXscxfZIWQd7mmyvwU51M7Ejjaw
         k3yhCp5euVoCg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/17] btrfs: merge find_free_dev_extent() and find_free_dev_extent_start()
Date:   Wed, 26 Jul 2023 16:57:09 +0100
Message-Id: <b3bc936325b250e7f0960cc2f4344e1acf770025.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There is no point in having find_free_dev_extent() because it's just a
simple wrapper around find_free_dev_extent_start() which always passes a
value of 0 for the search_start argument. Since there are no other callers
of find_free_dev_extent_start(), remove find_free_dev_extent() and rename
find_free_dev_extent_start() to find_free_dev_extent(), removing its
search_start argument because it's always 0.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/volumes.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e15d02f8520d..6b044d61ef13 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1438,18 +1438,18 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 	return false;
 }
 
-static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
+static u64 dev_extent_search_start(struct btrfs_device *device)
 {
 	switch (device->fs_devices->chunk_alloc_policy) {
 	case BTRFS_CHUNK_ALLOC_REGULAR:
-		return max_t(u64, start, BTRFS_DEVICE_RANGE_RESERVED);
+		return BTRFS_DEVICE_RANGE_RESERVED;
 	case BTRFS_CHUNK_ALLOC_ZONED:
 		/*
 		 * We don't care about the starting region like regular
 		 * allocator, because we anyway use/reserve the first two zones
 		 * for superblock logging.
 		 */
-		return ALIGN(start, device->zone_info->zone_size);
+		return 0;
 	default:
 		BUG();
 	}
@@ -1581,15 +1581,15 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
  * correct usable device space, as device extent freed in current transaction
  * is not reported as available.
  */
-static int find_free_dev_extent_start(struct btrfs_device *device,
-				u64 num_bytes, u64 search_start, u64 *start,
-				u64 *len)
+static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
+				u64 *start, u64 *len)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
 	struct btrfs_key key;
 	struct btrfs_dev_extent *dev_extent;
 	struct btrfs_path *path;
+	u64 search_start;
 	u64 hole_size;
 	u64 max_hole_start;
 	u64 max_hole_size;
@@ -1599,7 +1599,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	int slot;
 	struct extent_buffer *l;
 
-	search_start = dev_extent_search_start(device, search_start);
+	search_start = dev_extent_search_start(device);
 
 	WARN_ON(device->zone_info &&
 		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
@@ -1725,13 +1725,6 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	return ret;
 }
 
-static int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
-				u64 *start, u64 *len)
-{
-	/* FIXME use last free of some kind */
-	return find_free_dev_extent_start(device, num_bytes, 0, start, len);
-}
-
 static int btrfs_free_dev_extent(struct btrfs_trans_handle *trans,
 			  struct btrfs_device *device,
 			  u64 start, u64 *dev_extent_len)
-- 
2.34.1

