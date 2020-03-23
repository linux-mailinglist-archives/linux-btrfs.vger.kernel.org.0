Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6237A18F2C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Mar 2020 11:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgCWK0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Mar 2020 06:26:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbgCWK0K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Mar 2020 06:26:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 279F8AEB9
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Mar 2020 10:26:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 38/40] btrfs: qgroup: Introduce verification for function to ensure old roots ulist matches btrfs_find_all_roots() result
Date:   Mon, 23 Mar 2020 18:24:14 +0800
Message-Id: <20200323102416.112862-39-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200323102416.112862-1-wqu@suse.com>
References: <20200323102416.112862-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will introduce a new function, verify_old_roots(), for qgroup
to verify the backref cache based result and old btrfs_find_all_roots()
result.

Since it will impact performance heavily as we are doing two different
backref walk, this verification will only be enabled for
CONFIG_BTRFS_FS_CHECK_INTEGRITY.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3c25e17f0979..19d68e8397d0 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1831,6 +1831,78 @@ static int get_tree_info(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
+/*
+ * Compare the result with old btrfs_find_all_roots() to ensure the new backref
+ * cache based result is correct.
+ */
+static int verify_old_roots(struct btrfs_fs_info *fs_info,
+			    struct ulist *result, u64 bytenr)
+{
+	struct ulist *old;
+	struct ulist_iterator uiter;
+	struct ulist_node *unode;
+	bool not_fstree = false;
+	int ret = 0;
+
+	ret = btrfs_find_all_roots(NULL, fs_info, bytenr, 0, &old, true);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Check the first node, as find_all_roots() will also return
+	 * non-subvolume tree owner.
+	 * Since subvolume tree block won't be shared with non-subvolume
+	 * trees, if we find a non-subolume tree root, we don't need
+	 * to verify at all.
+	 */
+	ULIST_ITER_INIT(&uiter);
+	while ((unode = ulist_next(old, &uiter))) {
+		if (!is_fstree(unode->val))
+			not_fstree = true;
+		break;
+	}
+
+	if (not_fstree && result->nnodes != 0) {
+		btrfs_err(fs_info,
+"qgroup backref cached error, bytenr=%llu found cached node for non-fs tree",
+			  bytenr);
+		ret = -EUCLEAN;
+		goto out;
+	}
+	if (not_fstree)
+		goto out;
+
+	if (result->nnodes != old->nnodes) {
+		btrfs_err(fs_info,
+"qgroup backref cache error, bytenr=%llu nr nodes mismatch, old method=%lu cache method=%lu",
+			  bytenr, old->nnodes, result->nnodes);
+		ret = -EUCLEAN;
+		goto out;
+	}
+	ULIST_ITER_INIT(&uiter);
+	while ((unode = ulist_next(result, &uiter))) {
+		/*
+		 * @result and @old have the same amount of nodes, so if we
+		 * delete each @result node from @old, we either delete all
+		 * nodes from @old (verification pass), or we will hit
+		 * a missing node (verification failure).
+		 */
+		ret = ulist_del(old, unode->val, 0);
+		if (ret) {
+			btrfs_err(fs_info,
+	"qgroup backref cache error, bytenr=%llu root %llu not found in cached result",
+				  bytenr, unode->val);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+out:
+	ulist_free(old);
+	return ret;
+}
+#endif
+
 /* Iterate all roots in the backref_cache, and add root objectid into @roots */
 static int iterate_all_roots(struct btrfs_backref_node *node,
 			     struct ulist *roots)
-- 
2.25.2

