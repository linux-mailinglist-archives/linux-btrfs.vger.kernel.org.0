Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BFC79046A
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 02:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbjIBAOY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 20:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIBAOY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 20:14:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D91A8
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 17:14:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BD6D72186C;
        Sat,  2 Sep 2023 00:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693613659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b+85mFFfRbCwyKJHUwGoVyPSkYB+2UMzbVzSAKcsH44=;
        b=JyDFySfqy/zGg5OhpaK0R8hSOR5sKekYs3/eaRdFFe/H4ETV53y0i8IslEamcKM+9e2IAA
        d9Yhg3z8w7j2siVZO5F3BoxG95h5mbPJf3Eer0xDssbJSJITZhm1v2o54gc/VxmFIjt5qS
        ZvJIhd0m7dRxIFd7mP87ZHhIW1rZlo4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74B4F13587;
        Sat,  2 Sep 2023 00:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2KCvDlp+8mSzUgAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 02 Sep 2023 00:14:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v3 1/6] btrfs: qgroup: iterate qgroups without memory allocation for qgroup_reserve()
Date:   Sat,  2 Sep 2023 08:13:52 +0800
Message-ID: <a64836ee1564570ef9caeea7019aeed328e2052c.1693613265.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693613265.git.wqu@suse.com>
References: <cover.1693613265.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qgroup heavily relies on ulist to go through all the involved
qgroups, but since we're using ulist inside fs_info->qgroup_lock
spinlock, this means we're doing a lot of GFP_ATOMIC allocation.

This patch would reduce the GFP_ATOMIC usage for qgroup_reserve() by
eliminating the memory allocation completely.

This is done by moving the needed memory to btrfs_qgroup::iterator
list_head, so that we can put all the involved qgroup into a on-stack list, thus
eliminate the need to allocate memory holding spinlock.

The only cost is the slightly higher memory usage, but considering the
reduce GFP_ATOMIC during a hot path, it should still be acceptable.

Function qgroup_reserve() is the perfect start point for this
conversion.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 68 +++++++++++++++++++++++------------------------
 fs/btrfs/qgroup.h |  9 +++++++
 2 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 74244b4bb0e9..de34e2aef710 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -216,6 +216,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&qgroup->groups);
 	INIT_LIST_HEAD(&qgroup->members);
 	INIT_LIST_HEAD(&qgroup->dirty);
+	INIT_LIST_HEAD(&qgroup->iterator);
 
 	rb_link_node(&qgroup->node, parent, p);
 	rb_insert_color(&qgroup->node, &fs_info->qgroup_tree);
@@ -1367,6 +1368,25 @@ static void qgroup_dirty(struct btrfs_fs_info *fs_info,
 		list_add(&qgroup->dirty, &fs_info->dirty_qgroups);
 }
 
+static void qgroup_iterator_add(struct list_head *head, struct btrfs_qgroup *qgroup)
+{
+	if (!list_empty(&qgroup->iterator))
+		return;
+
+	list_add_tail(&qgroup->iterator, head);
+}
+
+static void qgroup_iterator_clean(struct list_head *head)
+{
+
+	while (!list_empty(head)) {
+		struct btrfs_qgroup *qgroup;
+
+		qgroup = list_first_entry(head, struct btrfs_qgroup, iterator);
+		list_del_init(&qgroup->iterator);
+	}
+}
+
 /*
  * The easy accounting, we're updating qgroup relationship whose child qgroup
  * only has exclusive extents.
@@ -3154,12 +3174,11 @@ static bool qgroup_check_limits(const struct btrfs_qgroup *qg, u64 num_bytes)
 static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 			  enum btrfs_qgroup_rsv_type type)
 {
-	struct btrfs_qgroup *qgroup;
+	struct btrfs_qgroup *cur;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 ref_root = root->root_key.objectid;
 	int ret = 0;
-	struct ulist_node *unode;
-	struct ulist_iterator uiter;
+	LIST_HEAD(qgroup_list);
 
 	if (!is_fstree(ref_root))
 		return 0;
@@ -3175,53 +3194,32 @@ static int qgroup_reserve(struct btrfs_root *root, u64 num_bytes, bool enforce,
 	if (!fs_info->quota_root)
 		goto out;
 
-	qgroup = find_qgroup_rb(fs_info, ref_root);
-	if (!qgroup)
+	cur = find_qgroup_rb(fs_info, ref_root);
+	if (!cur)
 		goto out;
 
-	/*
-	 * in a first step, we check all affected qgroups if any limits would
-	 * be exceeded
-	 */
-	ulist_reinit(fs_info->qgroup_ulist);
-	ret = ulist_add(fs_info->qgroup_ulist, qgroup->qgroupid,
-			qgroup_to_aux(qgroup), GFP_ATOMIC);
-	if (ret < 0)
-		goto out;
-	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(fs_info->qgroup_ulist, &uiter))) {
-		struct btrfs_qgroup *qg;
+	qgroup_iterator_add(&qgroup_list, cur);
+	list_for_each_entry(cur, &qgroup_list, iterator) {
 		struct btrfs_qgroup_list *glist;
 
-		qg = unode_aux_to_qgroup(unode);
-
-		if (enforce && !qgroup_check_limits(qg, num_bytes)) {
+		if (enforce && !qgroup_check_limits(cur, num_bytes)) {
 			ret = -EDQUOT;
 			goto out;
 		}
 
-		list_for_each_entry(glist, &qg->groups, next_group) {
-			ret = ulist_add(fs_info->qgroup_ulist,
-					glist->group->qgroupid,
-					qgroup_to_aux(glist->group), GFP_ATOMIC);
-			if (ret < 0)
-				goto out;
-		}
+		list_for_each_entry(glist, &cur->groups, next_group)
+			qgroup_iterator_add(&qgroup_list, glist->group);
 	}
+
 	ret = 0;
 	/*
 	 * no limits exceeded, now record the reservation into all qgroups
 	 */
-	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(fs_info->qgroup_ulist, &uiter))) {
-		struct btrfs_qgroup *qg;
-
-		qg = unode_aux_to_qgroup(unode);
-
-		qgroup_rsv_add(fs_info, qg, num_bytes, type);
-	}
+	list_for_each_entry(cur, &qgroup_list, iterator)
+		qgroup_rsv_add(fs_info, cur, num_bytes, type);
 
 out:
+	qgroup_iterator_clean(&qgroup_list);
 	spin_unlock(&fs_info->qgroup_lock);
 	return ret;
 }
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 7bffa10589d6..5dc0583622c3 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -220,6 +220,15 @@ struct btrfs_qgroup {
 	struct list_head groups;  /* groups this group is member of */
 	struct list_head members; /* groups that are members of this group */
 	struct list_head dirty;   /* dirty groups */
+
+	/*
+	 * For qgroup iteration usage.
+	 *
+	 * The iteration list should always be empty until
+	 * qgroup_iterator_add() is called.
+	 * And should be reset to empty after the iteration is finished.
+	 */
+	struct list_head iterator;
 	struct rb_node node;	  /* tree of qgroups */
 
 	/*
-- 
2.41.0

