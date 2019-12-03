Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446D810F7F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Dec 2019 07:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLCGnB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Dec 2019 01:43:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:44622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727111AbfLCGnB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Dec 2019 01:43:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7C32B321
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Dec 2019 06:42:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: relocation: Introduce error injection points for cancelling balance
Date:   Tue,  3 Dec 2019 14:42:51 +0800
Message-Id: <20191203064254.22683-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203064254.22683-1-wqu@suse.com>
References: <20191203064254.22683-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new error injection point, should_cancel_balance().

It's just a wrapper of atomic_read(&fs_info->balance_cancel_req), but
allows us to override the return value.

Currently there are only one locations using this function:
- btrfs_balance()
  It checks cancel before each block group.

There are other locations checking fs_info->balance_cancel_req, but they
are not used as an indicator to exit, so there is no need to use the
wrapper.

But there will be more locations coming, and some locations can cause
kernel panic if not handled properly.

So introduce this error injection to provide better test interface.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h      |  1 +
 fs/btrfs/relocation.c | 11 +++++++++++
 fs/btrfs/volumes.c    |  2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b2e8fd8a8e59..a712c18d2da2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3352,6 +3352,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
 			      u64 *bytes_to_reserve);
 int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 			      struct btrfs_pending_snapshot *pending);
+int should_cancel_balance(struct btrfs_fs_info *fs_info);
 
 /* scrub.c */
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d897a8e5e430..9edd65b1bf82 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/rbtree.h>
 #include <linux/slab.h>
+#include <linux/error-injection.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -3223,6 +3224,16 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
 	return ret;
 }
 
+/*
+ * This wrapper is to allow error injection to fully test all cancel
+ * call sites.
+ */
+int should_cancel_balance(struct btrfs_fs_info *fs_info)
+{
+	return atomic_read(&fs_info->balance_cancel_req);
+}
+ALLOW_ERROR_INJECTION(should_cancel_balance, TRUE);
+
 static int relocate_file_extent_cluster(struct inode *inode,
 					struct file_extent_cluster *cluster)
 {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..45a91a95557c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3856,7 +3856,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 
 	if (btrfs_fs_closing(fs_info) ||
 	    atomic_read(&fs_info->balance_pause_req) ||
-	    atomic_read(&fs_info->balance_cancel_req)) {
+	    should_cancel_balance(fs_info)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.24.0

