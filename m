Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE71804BD
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Aug 2019 08:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfHCGqF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Aug 2019 02:46:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:55228 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726797AbfHCGqF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 3 Aug 2019 02:46:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90A45AEAC;
        Sat,  3 Aug 2019 06:46:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>
Subject: [PATCH] btrfs: qgroup: Try our best to delete qgroup relations
Date:   Sat,  3 Aug 2019 14:45:59 +0800
Message-Id: <20190803064559.9031-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we try to delete qgroups, we're pretty cautious, we make sure both
qgroups exist and there is a relationship between them, then try to
delete the relation.

This behavior is OK, but the problem is we need to two relation items,
and if we failed the first item deletion, we error out, leaving the
other relation item in qgroup tree.

Sometimes the error from del_qgroup_relation_item() could just be
-ENOENT, thus we can ignore that error and continue without any problem.

Further more, such cautious behavior makes qgroup relation deletion
impossible for orphan relation items.

This patch will enhance __del_qgroup_relation():
- If both qgroups and their relation items exist
  Go the regular deletion routine and update their accounting if needed.

- If any qgroup or relation item doesn't exist
  Then we still try to delete the orphan items anyway, but don't trigger
  the accounting update.

By this, we try our best to remove relation items, and can handle orphan
relation items properly, while still keep the existing behavior for good
qgroup tree.

Reported-by: Andrei Borzenkov <arvidjaar@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3e6ffbbd8b0a..2b24d4a4430e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1312,8 +1312,9 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
 	struct ulist *tmp;
+	bool found = false;
 	int ret = 0;
-	int err;
+	int ret2;
 
 	tmp = ulist_alloc(GFP_KERNEL);
 	if (!tmp)
@@ -1327,28 +1328,39 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 
 	member = find_qgroup_rb(fs_info, src);
 	parent = find_qgroup_rb(fs_info, dst);
-	if (!member || !parent) {
-		ret = -EINVAL;
-		goto out;
-	}
+	/*
+	 * The parent/member pair doesn't exist, then try to delete the dead
+	 * relation items only.
+	 */
+	if (!member && !parent)
+		goto delete_item;
 
 	/* check if such qgroup relation exist firstly */
 	list_for_each_entry(list, &member->groups, next_group) {
-		if (list->group == parent)
-			goto exist;
+		if (list->group == parent) {
+			found = true;
+			break;
+		}
 	}
-	ret = -ENOENT;
-	goto out;
-exist:
+
+delete_item:
 	ret = del_qgroup_relation_item(trans, src, dst);
-	err = del_qgroup_relation_item(trans, dst, src);
-	if (err && !ret)
-		ret = err;
+	if (ret < 0 && ret != -ENOENT)
+		goto out;
+	ret2 = del_qgroup_relation_item(trans, dst, src);
+	if (ret2 < 0 && ret2 != -ENOENT)
+		goto out;
 
-	spin_lock(&fs_info->qgroup_lock);
-	del_relation_rb(fs_info, src, dst);
-	ret = quick_update_accounting(fs_info, tmp, src, dst, -1);
-	spin_unlock(&fs_info->qgroup_lock);
+	/* At least one deletion succeeded, return 0 */
+	if (!ret || !ret2)
+		ret = 0;
+
+	if (found) {
+		spin_lock(&fs_info->qgroup_lock);
+		del_relation_rb(fs_info, src, dst);
+		ret = quick_update_accounting(fs_info, tmp, src, dst, -1);
+		spin_unlock(&fs_info->qgroup_lock);
+	}
 out:
 	ulist_free(tmp);
 	return ret;
-- 
2.22.0

