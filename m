Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E1F160A4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2020 07:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgBQGRD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Feb 2020 01:17:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:41752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgBQGRC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Feb 2020 01:17:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5CFDADE0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2020 06:17:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/3] btrfs: relocation: Introduce error injection points for cancelling balance
Date:   Mon, 17 Feb 2020 14:16:52 +0800
Message-Id: <20200217061654.65567-2-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200217061654.65567-1-wqu@suse.com>
References: <20200217061654.65567-1-wqu@suse.com>
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
index 36df977b64d9..d8e12ca15bb6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3401,6 +3401,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
 			      u64 *bytes_to_reserve);
 int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 			      struct btrfs_pending_snapshot *pending);
+int should_cancel_balance(struct btrfs_fs_info *fs_info);
 
 /* scrub.c */
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 995d4b8b1cfd..475479d50cc3 100644
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
@@ -3264,6 +3265,16 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
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
index 9cfc668f91f4..cd61f4e29d9e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3904,7 +3904,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 
 	if (btrfs_fs_closing(fs_info) ||
 	    atomic_read(&fs_info->balance_pause_req) ||
-	    atomic_read(&fs_info->balance_cancel_req)) {
+	    should_cancel_balance(fs_info)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.25.0

