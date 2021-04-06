Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D47635591C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Apr 2021 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbhDFQYX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Apr 2021 12:24:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:49922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234971AbhDFQYW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Apr 2021 12:24:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DAC1AD9F;
        Tue,  6 Apr 2021 16:24:13 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/2] btrfs: Remove unused function btrfs_reada_detach()
Date:   Tue,  6 Apr 2021 11:24:03 -0500
Message-Id: <20210406162404.11746-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_reada_detach() is not called by any function. Remove.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h | 1 -
 fs/btrfs/reada.c | 9 +--------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f2fd73e58ee6..2acbd8919611 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3700,7 +3700,6 @@ struct reada_control {
 struct reada_control *btrfs_reada_add(struct btrfs_root *root,
 			      struct btrfs_key *start, struct btrfs_key *end);
 int btrfs_reada_wait(void *handle);
-void btrfs_reada_detach(void *handle);
 int btree_readahead_hook(struct extent_buffer *eb, int err);
 void btrfs_reada_remove_dev(struct btrfs_device *dev);
 void btrfs_reada_undo_remove_dev(struct btrfs_device *dev);
diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 06713a8fe26b..0d357f8b65bc 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -24,7 +24,7 @@
  * To trigger a readahead, btrfs_reada_add must be called. It will start
  * a read ahead for the given range [start, end) on tree root. The returned
  * handle can either be used to wait on the readahead to finish
- * (btrfs_reada_wait), or to send it to the background (btrfs_reada_detach).
+ * (btrfs_reada_wait).
  *
  * The read ahead works as follows:
  * On btrfs_reada_add, the root of the tree is inserted into a radix_tree.
@@ -1036,13 +1036,6 @@ int btrfs_reada_wait(void *handle)
 }
 #endif
 
-void btrfs_reada_detach(void *handle)
-{
-	struct reada_control *rc = handle;
-
-	kref_put(&rc->refcnt, reada_control_release);
-}
-
 /*
  * Before removing a device (device replace or device remove ioctls), call this
  * function to wait for all existing readahead requests on the device and to
-- 
2.30.2

