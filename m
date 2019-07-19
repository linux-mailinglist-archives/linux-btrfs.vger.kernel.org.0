Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22DEA6E131
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 08:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfGSGvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 02:51:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfGSGvu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 02:51:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C0EBAEF7
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2019 06:51:49 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs: volumes: Unexport find_free_dev_extent_start()
Date:   Fri, 19 Jul 2019 14:51:41 +0800
Message-Id: <20190719065144.15263-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190719065144.15263-1-wqu@suse.com>
References: <20190719065144.15263-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is only used locally in find_free_dev_extent(), no
external callers.

So unexport it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 5 +++--
 fs/btrfs/volumes.h | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1c2a6e4b39da..b3fae492912d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1547,8 +1547,9 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
  * But if we don't find suitable free space, it is used to store the size of
  * the max free space.
  */
-int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
-			       u64 search_start, u64 *start, u64 *len)
+static int find_free_dev_extent_start(struct btrfs_device *device,
+				u64 num_bytes, u64 search_start, u64 *start,
+				u64 *len)
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 136a3eb64604..371cd05d7fe4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -454,8 +454,6 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info);
 int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
 int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info);
 int btrfs_chunk_readonly(struct btrfs_fs_info *fs_info, u64 chunk_offset);
-int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
-			       u64 search_start, u64 *start, u64 *max_avail);
 int find_free_dev_extent(struct btrfs_device *device, u64 num_bytes,
 			 u64 *start, u64 *max_avail);
 void btrfs_dev_stat_inc_and_print(struct btrfs_device *dev, int index);
-- 
2.22.0

