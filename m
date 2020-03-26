Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7D05193B0A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgCZIen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:34:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbgCZIem (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:34:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 978DAAC69
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:34:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 35/39] btrfs: qgroup: Introduce a function to iterate through backref_cache to find all parents for specified node
Date:   Thu, 26 Mar 2020 16:33:12 +0800
Message-Id: <20200326083316.48847-36-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new static function, iterate_all_roots(), to find all
roots for specified backref node.

This function will do iterative depth-first search, and queue hit root
objectid to the result ulist.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index d7d50943f482..69522aa3224b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1760,6 +1760,46 @@ static struct btrfs_backref_node *qgroup_backref_cache_build(
 	return node;
 }
 
+/* Iterate all roots in the backref_cache, and add root objectid into @roots */
+static int iterate_all_roots(struct btrfs_backref_node *node,
+			     struct ulist *roots)
+{
+	struct btrfs_backref_edge *edge;
+	struct btrfs_backref_node *upper;
+	int ret = 0;
+
+	ASSERT(node->level < BTRFS_MAX_LEVEL);
+
+	/* Useless node, exit directly */
+	if (node->detached || node->is_reloc_root || node->cowonly)
+		goto out;
+
+	/* Find a root, queue to @roots ulist */
+	if (list_empty(&node->upper)) {
+		ASSERT(is_fstree(node->owner));
+		ret = ulist_add(roots, node->owner, 0, GFP_NOFS);
+		goto out;
+	}
+
+	/* Go upper level */
+	list_for_each_entry(edge, &node->upper, list[LOWER]) {
+		upper = edge->node[UPPER];
+
+		if (upper->level != node->level + 1 ||
+		    upper->level >= BTRFS_MAX_LEVEL) {
+			ret = -EUCLEAN;
+			goto out;
+		}
+		ret = iterate_all_roots(upper, roots);
+		if (ret < 0)
+			goto out;
+	}
+out:
+	if (ret < 0)
+		ulist_release(roots);
+	return ret;
+}
+
 int btrfs_qgroup_trace_extent_post(struct btrfs_fs_info *fs_info,
 				   struct btrfs_qgroup_extent_record *qrecord)
 {
-- 
2.26.0

