Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7BAE9B6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 13:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfJ3MXF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 08:23:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfJ3MXF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 08:23:05 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E22E2083E
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Oct 2019 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572438185;
        bh=kUPaKRQxY3Nx8/RABtLw9ciOtF8VEVXcoDd3JG4tzKQ=;
        h=From:To:Subject:Date:From;
        b=X1L7mWIa9gRQvpTB6dRyKjpVqH56ipXn6nZtdyczzaC4vxpTW5jTN7owwrUbWgv3R
         23bKAoG3F9YzAwt+xlsJXbYlCBQrDTdCR9eHJipZS8OpFCrogUJPOwgVQ/eE9e5ejB
         98O4Wowco2ea1YDRN0vJdfjCJOi+kWNbwkMn9UYo=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: send, skip backreference walking for extents with many references
Date:   Wed, 30 Oct 2019 12:23:01 +0000
Message-Id: <20191030122301.25270-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Backreference walking, which is used by send to figure if it can issue
clone operations instead of write operations, can be very slow and use too
much memory when extents have many references. This change simply skips
backreference walking when an extent has more than 64 references, in which
case we fallback to a write operation instead of a clone operation. This
limit is conservative and in practice I observed no signicant slowdown
with up to 100 references and still low memory usage up to that limit.

This is a temporary workaround until there are speedups in the backref
walking code, and as such it does not attempt to add extra interfaces or
knobs to tweak the threshold.

Reported-by: Atemu <atemu.main@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAE4GHgkvqVADtS4AzcQJxo0Q1jKQgKaW3JGp3SGdoinVo=C9eQ@mail.gmail.com/T/#me55dc0987f9cc2acaa54372ce0492c65782be3fa
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 123ac54af071..518ec1265a0c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -25,6 +25,14 @@
 #include "compression.h"
 
 /*
+ * Maximum number of references an extent can have in order for us to attempt to
+ * issue clone operations instead of write operations. This currently exists to
+ * avoid hitting limitations of the backreference walking code (taking a lot of
+ * time and using too much memory for extents with large number of references).
+ */
+#define SEND_MAX_EXTENT_REFS	64
+
+/*
  * A fs_path is a helper to dynamically build path names with unknown size.
  * It reallocates the internal buffer on demand.
  * It allows fast adding of path elements on the right side (normal path) and
@@ -1302,6 +1310,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	struct clone_root *cur_clone_root;
 	struct btrfs_key found_key;
 	struct btrfs_path *tmp_path;
+	struct btrfs_extent_item *ei;
 	int compressed;
 	u32 i;
 
@@ -1349,7 +1358,6 @@ static int find_extent_clone(struct send_ctx *sctx,
 	ret = extent_from_logical(fs_info, disk_byte, tmp_path,
 				  &found_key, &flags);
 	up_read(&fs_info->commit_root_sem);
-	btrfs_release_path(tmp_path);
 
 	if (ret < 0)
 		goto out;
@@ -1358,6 +1366,21 @@ static int find_extent_clone(struct send_ctx *sctx,
 		goto out;
 	}
 
+	ei = btrfs_item_ptr(tmp_path->nodes[0], tmp_path->slots[0],
+			    struct btrfs_extent_item);
+	/*
+	 * Backreference walking (iterate_extent_inodes() below) is currently
+	 * too expensive when an extent has a large number of references, both
+	 * in time spent and used memory. So for now just fallback to write
+	 * operations instead of clone operations when an extent has more than
+	 * a certain amount of references.
+	 */
+	if (btrfs_extent_refs(tmp_path->nodes[0], ei) > SEND_MAX_EXTENT_REFS) {
+		ret = -ENOENT;
+		goto out;
+	}
+	btrfs_release_path(tmp_path);
+
 	/*
 	 * Setup the clone roots.
 	 */
-- 
2.11.0

