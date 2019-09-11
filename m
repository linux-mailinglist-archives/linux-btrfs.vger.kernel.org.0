Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE44DB01D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 18:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfIKQml (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 12:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729061AbfIKQml (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 12:42:41 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6681206CD
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568220161;
        bh=Ch0YZyEE8nlezfSkGZExaAxguJ/6ZcEVWq4oLzdnTWo=;
        h=From:To:Subject:Date:From;
        b=oLyA/SNhx1rXAKALBrEihUq9Hgi+HK6AzG2Gf5/iMWl60zhvwUVH1FQLECBWWHYmu
         SG6Mji2Gcgmfyb6eR3KjmZAS8Nsok6vTcxniIyQeWchiAf9ljI2MtoCuPW6nKTovlx
         Ddo62VKrrj7qbgFspphbPC9kWWnOgIYTiwJn/nxs=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: make btrfs_wait_extents() static
Date:   Wed, 11 Sep 2019 17:42:38 +0100
Message-Id: <20190911164238.19524-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

It's not used ouside of transaction.c

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 2 +-
 fs/btrfs/transaction.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e3adb714c04b..84a42e388aa4 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -988,7 +988,7 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 	return werr;
 }
 
-int btrfs_wait_extents(struct btrfs_fs_info *fs_info,
+static int btrfs_wait_extents(struct btrfs_fs_info *fs_info,
 		       struct extent_io_tree *dirty_pages)
 {
 	bool errors = false;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 2c5a6f6e5bb0..c51135d9b448 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -218,8 +218,6 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 				struct btrfs_root *root);
 int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 				struct extent_io_tree *dirty_pages, int mark);
-int btrfs_wait_extents(struct btrfs_fs_info *fs_info,
-		       struct extent_io_tree *dirty_pages);
 int btrfs_wait_tree_log_extents(struct btrfs_root *root, int mark);
 int btrfs_transaction_blocked(struct btrfs_fs_info *info);
 int btrfs_transaction_in_commit(struct btrfs_fs_info *info);
-- 
2.11.0

