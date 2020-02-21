Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCAA168372
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2020 17:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgBUQba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 11:31:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:43738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgBUQb3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33F35AF5C;
        Fri, 21 Feb 2020 16:31:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE26DDA70E; Fri, 21 Feb 2020 17:31:10 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 05/11] btrfs: simplify parameters of btrfs_set_disk_extent_flags
Date:   Fri, 21 Feb 2020 17:31:10 +0100
Message-Id: <e9483711e6f093259df9488c1d4d9753426fdf0a.1582302545.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582302545.git.dsterba@suse.com>
References: <cover.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All callers pass extent buffer start and length so the extent buffer
itself should work fine.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c       | 4 +---
 fs/btrfs/ctree.h       | 2 +-
 fs/btrfs/extent-tree.c | 7 +++----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index b62721ac5ee8..f948435e87df 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -925,9 +925,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 		if (new_flags != 0) {
 			int level = btrfs_header_level(buf);
 
-			ret = btrfs_set_disk_extent_flags(trans,
-							  buf->start,
-							  buf->len,
+			ret = btrfs_set_disk_extent_flags(trans, buf,
 							  new_flags, level, 0);
 			if (ret)
 				return ret;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d7e54cbc8dce..2910ac257a5d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2485,7 +2485,7 @@ int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct extent_buffer *buf, int full_backref);
 int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
-				u64 bytenr, u64 num_bytes, u64 flags,
+				struct extent_buffer *eb, u64 flags,
 				int level, int is_data);
 int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7eef91d6c2b6..7affa6342688 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2231,7 +2231,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
-				u64 bytenr, u64 num_bytes, u64 flags,
+				struct extent_buffer *eb, u64 flags,
 				int level, int is_data)
 {
 	struct btrfs_delayed_extent_op *extent_op;
@@ -2247,7 +2247,7 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 	extent_op->is_data = is_data ? true : false;
 	extent_op->level = level;
 
-	ret = btrfs_add_delayed_extent_op(trans, bytenr, num_bytes, extent_op);
+	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->len, extent_op);
 	if (ret)
 		btrfs_free_delayed_extent_op(extent_op);
 	return ret;
@@ -4741,8 +4741,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 		BUG_ON(ret); /* -ENOMEM */
 		ret = btrfs_dec_ref(trans, root, eb, 0);
 		BUG_ON(ret); /* -ENOMEM */
-		ret = btrfs_set_disk_extent_flags(trans, eb->start,
-						  eb->len, flag,
+		ret = btrfs_set_disk_extent_flags(trans, eb, flag,
 						  btrfs_header_level(eb), 0);
 		BUG_ON(ret); /* -ENOMEM */
 		wc->flags[level] |= flag;
-- 
2.25.0

