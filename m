Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3BC74B88
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 12:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfGYK1V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 06:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbfGYK1V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 06:27:21 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2698921901
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564050440;
        bh=8uDfLTXY2dw/TBPQWOcFM+T7bp4H+KaSIIAzWWgTCFA=;
        h=From:To:Subject:Date:From;
        b=u02jui/PCaXqHv1m2g8VNwH6pqOfLMrKeRikme9c7FfYma83V3/CKe7sIGnZt42qA
         4p+aHJmQ3rfR3Cw98+2dcvxI8vMlHUhAA5Fn7iCdGChhhDAtBAf1yhj6xoHhm7jMcS
         M5haHs3pVZgUNi8BJ4KACMV1IXquzIy0iclXhgLA=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs-progs: mkfs, fix metadata corruption when using mixed mode
Date:   Thu, 25 Jul 2019 11:27:17 +0100
Message-Id: <20190725102717.11688-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When creating a filesystem with mixed block groups, we are creating two
space info objects to track used/reserved/pinned space, one only for data
and another one only for metadata.

This is making fstests test case generic/416 fail, with btrfs' check
reporting over an hundred errors about bad extents:

  (...)
  bad extent [17186816, 17190912), type mismatch with chunk
  bad extent [17195008, 17199104), type mismatch with chunk
  bad extent [17203200, 17207296), type mismatch with chunk
  (...)

Because, surprisingly, this results in block groups that do not have the
BTRFS_BLOCK_GROUP_DATA flag set but have data extents allocated in them.
This is a regression introduced in btrfs-progs v5.2.

So fix this by making sure we only create one space info object, for both
metadata and data, when mixed block groups are enabled.

Fixes: c31edf610cbe1e ("btrfs-progs: Fix false ENOSPC alert by tracking used space correctly")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 mkfs/main.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 8dbec071..971cb395 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -64,18 +64,17 @@ static int create_metadata_block_groups(struct btrfs_root *root, int mixed,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_space_info *sinfo;
+	u64 flags = BTRFS_BLOCK_GROUP_METADATA;
 	u64 bytes_used;
 	u64 chunk_start = 0;
 	u64 chunk_size = 0;
 	int ret;
 
+	if (mixed)
+		flags |= BTRFS_BLOCK_GROUP_DATA;
+
 	/* Create needed space info to trace extents reservation */
-	ret = update_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA,
-				0, 0, &sinfo);
-	if (ret < 0)
-		return ret;
-	ret = update_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA,
-				0, 0, &sinfo);
+	ret = update_space_info(fs_info, flags, 0, 0, &sinfo);
 	if (ret < 0)
 		return ret;
 
@@ -149,6 +148,13 @@ static int create_data_block_groups(struct btrfs_trans_handle *trans,
 	int ret = 0;
 
 	if (!mixed) {
+		struct btrfs_space_info *sinfo;
+
+		ret = update_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA,
+					0, 0, &sinfo);
+		if (ret < 0)
+			return ret;
+
 		ret = btrfs_alloc_chunk(trans, fs_info,
 					&chunk_start, &chunk_size,
 					BTRFS_BLOCK_GROUP_DATA);
-- 
2.11.0

