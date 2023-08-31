Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACE878E3F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Aug 2023 02:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344972AbjHaAbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 20:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344921AbjHaAbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 20:31:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4CCBE
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 17:31:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68A582185C
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Aug 2023 00:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693441862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p//Ur0FfKS4/KgwMSj0vWfoqd9BQZNSNEwwvMTjRNAg=;
        b=k6QpjQgmqWxqOY7xHjen5fp6SndozSIaOrMu4RH+nIxou1+52Tc/eFbS/2lZmkfssn1Chu
        iSzbDlFZKQwKC0WK2ZV/whkdJNd5bj1OxEoWyn2fe7AoMO4g5AUN8+stIbehcVBQVrNwcD
        jjbnhJs9JKDv6ydvARCPx/jpguQxO7w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C821113441
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Aug 2023 00:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KNNSJUXf72RcKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Aug 2023 00:31:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/6] btrfs: qgroup: use qgroup_iterator2 facility to replace @qgroups ulist of qgroup_update_refcnt()
Date:   Thu, 31 Aug 2023 08:30:37 +0800
Message-ID: <3bde6a9352638ac30cb727ff8b5a304d14d240ce.1693441298.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693441298.git.wqu@suse.com>
References: <cover.1693441298.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The ulist @qgroups is utilized to record all involved qgroups from both
old and new roots inside btrfs_qgroup_account_extent().

Due to the fact that qgroup_update_refcnt() itself is already utilizing
qgroup_iterator, here we have to introduce another list_head,
btrfs_qgroup::iterator2, allowing nested iteartion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 81 ++++++++++++++++++++++-------------------------
 fs/btrfs/qgroup.h |  3 ++
 2 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 6fcf302744e2..27debc645f97 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -217,6 +217,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&qgroup->members);
 	INIT_LIST_HEAD(&qgroup->dirty);
 	INIT_LIST_HEAD(&qgroup->iterator);
+	INIT_LIST_HEAD(&qgroup->iterator2);
 
 	rb_link_node(&qgroup->node, parent, p);
 	rb_insert_color(&qgroup->node, &fs_info->qgroup_tree);
@@ -2457,22 +2458,39 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static void qgroup_iterator2_add(struct list_head *head, struct btrfs_qgroup *qgroup)
+{
+	if (!list_empty(&qgroup->iterator2))
+		return;
+
+	list_add_tail(&qgroup->iterator2, head);
+}
+
+static void qgroup_iterator2_clean(struct list_head *head)
+{
+
+	while (!list_empty(head)) {
+		struct btrfs_qgroup *qgroup;
+
+		qgroup = list_first_entry(head, struct btrfs_qgroup, iterator2);
+		list_del_init(&qgroup->iterator2);
+	}
+}
 #define UPDATE_NEW	0
 #define UPDATE_OLD	1
 /*
  * Walk all of the roots that points to the bytenr and adjust their refcnts.
  */
-static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
-				struct ulist *roots, struct ulist *qgroups,
-				u64 seq, int update_old)
+static void qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
+				 struct ulist *roots, struct list_head *qgroups,
+				 u64 seq, int update_old)
 {
 	struct ulist_node *unode;
 	struct ulist_iterator uiter;
 	struct btrfs_qgroup *qg;
-	int ret = 0;
 
 	if (!roots)
-		return 0;
+		return;
 	ULIST_ITER_INIT(&uiter);
 	while ((unode = ulist_next(roots, &uiter))) {
 		LIST_HEAD(tmp);
@@ -2481,10 +2499,7 @@ static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
 		if (!qg)
 			continue;
 
-		ret = ulist_add(qgroups, qg->qgroupid, qgroup_to_aux(qg),
-				GFP_ATOMIC);
-		if (ret < 0)
-			return ret;
+		qgroup_iterator2_add(qgroups, qg);
 		qgroup_iterator_add(&tmp, qg);
 		list_for_each_entry(qg, &tmp, iterator) {
 			struct btrfs_qgroup_list *glist;
@@ -2495,17 +2510,12 @@ static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
 				btrfs_qgroup_update_new_refcnt(qg, seq, 1);
 
 			list_for_each_entry(glist, &qg->groups, next_group) {
-				ret = ulist_add(qgroups, glist->group->qgroupid,
-						qgroup_to_aux(glist->group),
-						GFP_ATOMIC);
-				if (ret < 0)
-					return ret;
+				qgroup_iterator2_add(qgroups, glist->group);
 				qgroup_iterator_add(&tmp, glist->group);
 			}
 		}
 		qgroup_iterator_clean(&tmp);
 	}
-	return 0;
 }
 
 /*
@@ -2544,22 +2554,18 @@ static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
  * But this time we don't need to consider other things, the codes and logic
  * is easy to understand now.
  */
-static int qgroup_update_counters(struct btrfs_fs_info *fs_info,
-				  struct ulist *qgroups,
-				  u64 nr_old_roots,
-				  u64 nr_new_roots,
-				  u64 num_bytes, u64 seq)
+static void qgroup_update_counters(struct btrfs_fs_info *fs_info,
+				   struct list_head *qgroups,
+				   u64 nr_old_roots,
+				   u64 nr_new_roots,
+				   u64 num_bytes, u64 seq)
 {
-	struct ulist_node *unode;
-	struct ulist_iterator uiter;
 	struct btrfs_qgroup *qg;
-	u64 cur_new_count, cur_old_count;
 
-	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(qgroups, &uiter))) {
+	list_for_each_entry(qg, qgroups, iterator2) {
+		u64 cur_new_count, cur_old_count;
 		bool dirty = false;
 
-		qg = unode_aux_to_qgroup(unode);
 		cur_old_count = btrfs_qgroup_get_old_refcnt(qg, seq);
 		cur_new_count = btrfs_qgroup_get_new_refcnt(qg, seq);
 
@@ -2630,7 +2636,6 @@ static int qgroup_update_counters(struct btrfs_fs_info *fs_info,
 		if (dirty)
 			qgroup_dirty(fs_info, qg);
 	}
-	return 0;
 }
 
 /*
@@ -2667,7 +2672,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 				struct ulist *new_roots)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct ulist *qgroups = NULL;
+	LIST_HEAD(qgroups);
 	u64 seq;
 	u64 nr_new_roots = 0;
 	u64 nr_old_roots = 0;
@@ -2701,11 +2706,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	trace_btrfs_qgroup_account_extent(fs_info, trans->transid, bytenr,
 					num_bytes, nr_old_roots, nr_new_roots);
 
-	qgroups = ulist_alloc(GFP_NOFS);
-	if (!qgroups) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
 		if (fs_info->qgroup_rescan_progress.objectid <= bytenr) {
@@ -2720,28 +2720,21 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	seq = fs_info->qgroup_seq;
 
 	/* Update old refcnts using old_roots */
-	ret = qgroup_update_refcnt(fs_info, old_roots, qgroups, seq,
-				   UPDATE_OLD);
-	if (ret < 0)
-		goto out;
+	qgroup_update_refcnt(fs_info, old_roots, &qgroups, seq, UPDATE_OLD);
 
 	/* Update new refcnts using new_roots */
-	ret = qgroup_update_refcnt(fs_info, new_roots, qgroups, seq,
-				   UPDATE_NEW);
-	if (ret < 0)
-		goto out;
+	qgroup_update_refcnt(fs_info, new_roots, &qgroups, seq, UPDATE_NEW);
 
-	qgroup_update_counters(fs_info, qgroups, nr_old_roots, nr_new_roots,
+	qgroup_update_counters(fs_info, &qgroups, nr_old_roots, nr_new_roots,
 			       num_bytes, seq);
 
 	/*
 	 * Bump qgroup_seq to avoid seq overlap
 	 */
 	fs_info->qgroup_seq += max(nr_old_roots, nr_new_roots) + 1;
-out:
 	spin_unlock(&fs_info->qgroup_lock);
 out_free:
-	ulist_free(qgroups);
+	qgroup_iterator2_clean(&qgroups);
 	ulist_free(old_roots);
 	ulist_free(new_roots);
 	return ret;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 5dc0583622c3..1cce93585ff9 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -229,6 +229,9 @@ struct btrfs_qgroup {
 	 * And should be reset to empty after the iteration is finished.
 	 */
 	struct list_head iterator;
+
+	/* For nested iterator usage. */
+	struct list_head iterator2;
 	struct rb_node node;	  /* tree of qgroups */
 
 	/*
-- 
2.41.0

