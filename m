Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D370D1FC28B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 02:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgFQAAO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 20:00:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgFQAAN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 20:00:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89B90AD94;
        Wed, 17 Jun 2020 00:00:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: qgroup: catch reserved space leakage at unmount time
Date:   Wed, 17 Jun 2020 07:59:55 +0800
Message-Id: <20200616235955.21385-6-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616235955.21385-1-wqu@suse.com>
References: <20200616235955.21385-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before this patch, btrfs qgroup completely relies on per-inode extent io
tree to detect reserved data space leakage.

However previous bug has already shown how release page before
btrfs_finish_ordered_io() could lead to leakage, and since it's
QGROUP_RESERVED bit cleared without triggering qgroup rsv, it can't be
detected by per-inode extent io tree.

So this patch adds another (and hopefully the final) safety net to catch
qgroup data reserved space leakage.

At least the new safety net catches all the leakage during development,
so it should be pretty useful in the real world.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c |  5 +++++
 fs/btrfs/qgroup.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h  |  1 +
 3 files changed, 49 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5b9422100659..c70d47b8090a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4077,6 +4077,11 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	ASSERT(list_empty(&fs_info->delayed_iputs));
 	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
 
+	if (btrfs_check_quota_leak(fs_info)) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_err(fs_info, "qgroup reserved space leaked");
+	}
+
 	btrfs_free_qgroup_config(fs_info);
 	ASSERT(list_empty(&fs_info->delalloc_roots));
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5bd4089ad0e1..74eb98479109 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -505,6 +505,49 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	return ret < 0 ? ret : 0;
 }
 
+static u64 btrfs_qgroup_subvolid(u64 qgroupid)
+{
+	return (qgroupid & ((1ULL << BTRFS_QGROUP_LEVEL_SHIFT) - 1));
+}
+
+/*
+ * Called in close_ctree() when quota is still enabled.  This verifies we don't
+ * leak some reserved space.
+ *
+ * Return false if no reserved space is left.
+ * Return true if some reserved space is leaked.
+ */
+bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info)
+{
+	struct rb_node *node;
+	bool ret = false;
+
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+		return ret;
+	/*
+	 * Since we're unmounting, there is no race and no need to grab qgroup
+	 * lock.  And here we don't go post-order to provide a more user
+	 * friendly sorted result.
+	 */
+	for (node = rb_first(&fs_info->qgroup_tree); node; node = rb_next(node)) {
+		struct btrfs_qgroup *qgroup;
+		int i;
+
+		qgroup = rb_entry(node, struct btrfs_qgroup, node);
+		for (i = 0; i < BTRFS_QGROUP_RSV_LAST; i++) {
+			if (qgroup->rsv.values[i]) {
+				ret = true;
+				btrfs_warn(fs_info,
+		"qgroup %llu/%llu has unreleased space, type %d rsv %llu",
+				   btrfs_qgroup_level(qgroup->qgroupid),
+				   btrfs_qgroup_subvolid(qgroup->qgroupid),
+				   i, qgroup->rsv.values[i]);
+			}
+		}
+	}
+	return ret;
+}
+
 /*
  * This is called from close_ctree() or open_ctree() or btrfs_quota_disable(),
  * first two are in single-threaded paths.And for the third one, we have set
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 1bc654459469..3be5198a3719 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -415,5 +415,6 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
 void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
+bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
 
 #endif
-- 
2.27.0

