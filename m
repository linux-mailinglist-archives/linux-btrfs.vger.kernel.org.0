Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005AF790470
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345728AbjIBAOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 20:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIBAOf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 20:14:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385361A8
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 17:14:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C9BE61F74A
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Sep 2023 00:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693613668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1T34N2Mm/gqf+OeFeVLUaxTj7EFGVmJzGp6XVvlVJQQ=;
        b=PTSh5pCFLXKrD3JNHWkNOWDJZdU6NpoypJNrTcz9WNjHTStzHzF0ME+dooEB+J4EjPbLwS
        yhTWTZuEIE5dANQD4w0Jp0T/y2POKNPYHCVrbkVjig1UjSIt6Z4wrwKnJRaFubAy/8nPl7
        INuw5z8/Y/zCFproMmKlO8QH2VY2mLM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A36A13587
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Sep 2023 00:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UKM6E2N+8mSzUgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Sep 2023 00:14:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 6/6] btrfs: qgroup: use qgroup_iterator_nested facility to replace qgroups ulist of qgroup_update_refcnt()
Date:   Sat,  2 Sep 2023 08:13:57 +0800
Message-ID: <58875594701830da72b93a5475efa9412ca5191a.1693613265.git.wqu@suse.com>
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

The ulist @qgroups is utilized to record all involved qgroups from both
old and new roots inside btrfs_qgroup_account_extent().

Due to the fact that qgroup_update_refcnt() itself is already utilizing
qgroup_iterator, here we have to introduce another list_head,
btrfs_qgroup::nested_iterator, allowing nested iteartion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 84 ++++++++++++++++++++++-------------------------
 fs/btrfs/qgroup.h | 18 ++++++++++
 2 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index f24feb8f2065..f8881ea0f444 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -217,6 +217,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&qgroup->members);
 	INIT_LIST_HEAD(&qgroup->dirty);
 	INIT_LIST_HEAD(&qgroup->iterator);
+	INIT_LIST_HEAD(&qgroup->nested_iterator);
 
 	rb_link_node(&qgroup->node, parent, p);
 	rb_insert_color(&qgroup->node, &fs_info->qgroup_tree);
@@ -2448,22 +2449,42 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static void qgroup_iterator_nested_add(struct list_head *head,
+				       struct btrfs_qgroup *qgroup)
+{
+	if (!list_empty(&qgroup->nested_iterator))
+		return;
+
+	list_add_tail(&qgroup->nested_iterator, head);
+}
+
+static void qgroup_iterator_nested_clean(struct list_head *head)
+{
+
+	while (!list_empty(head)) {
+		struct btrfs_qgroup *qgroup;
+
+		qgroup = list_first_entry(head, struct btrfs_qgroup,
+					  nested_iterator);
+		list_del_init(&qgroup->nested_iterator);
+	}
+}
+
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
@@ -2472,10 +2493,7 @@ static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
 		if (!qg)
 			continue;
 
-		ret = ulist_add(qgroups, qg->qgroupid, qgroup_to_aux(qg),
-				GFP_ATOMIC);
-		if (ret < 0)
-			return ret;
+		qgroup_iterator_nested_add(qgroups, qg);
 		qgroup_iterator_add(&tmp, qg);
 		list_for_each_entry(qg, &tmp, iterator) {
 			struct btrfs_qgroup_list *glist;
@@ -2486,17 +2504,12 @@ static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
 				btrfs_qgroup_update_new_refcnt(qg, seq, 1);
 
 			list_for_each_entry(glist, &qg->groups, next_group) {
-				ret = ulist_add(qgroups, glist->group->qgroupid,
-						qgroup_to_aux(glist->group),
-						GFP_ATOMIC);
-				if (ret < 0)
-					return ret;
+				qgroup_iterator_nested_add(qgroups, glist->group);
 				qgroup_iterator_add(&tmp, glist->group);
 			}
 		}
 		qgroup_iterator_clean(&tmp);
 	}
-	return 0;
 }
 
 /*
@@ -2535,22 +2548,18 @@ static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
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
+	list_for_each_entry(qg, qgroups, nested_iterator) {
+		u64 cur_new_count, cur_old_count;
 		bool dirty = false;
 
-		qg = unode_aux_to_qgroup(unode);
 		cur_old_count = btrfs_qgroup_get_old_refcnt(qg, seq);
 		cur_new_count = btrfs_qgroup_get_new_refcnt(qg, seq);
 
@@ -2621,7 +2630,6 @@ static int qgroup_update_counters(struct btrfs_fs_info *fs_info,
 		if (dirty)
 			qgroup_dirty(fs_info, qg);
 	}
-	return 0;
 }
 
 /*
@@ -2658,7 +2666,7 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 				struct ulist *new_roots)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct ulist *qgroups = NULL;
+	LIST_HEAD(qgroups);
 	u64 seq;
 	u64 nr_new_roots = 0;
 	u64 nr_old_roots = 0;
@@ -2692,11 +2700,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
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
@@ -2711,28 +2714,21 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
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
+	qgroup_iterator_nested_clean(&qgroups);
 	ulist_free(old_roots);
 	ulist_free(new_roots);
 	return ret;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 5dc0583622c3..fb0afc6b0de8 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -229,6 +229,24 @@ struct btrfs_qgroup {
 	 * And should be reset to empty after the iteration is finished.
 	 */
 	struct list_head iterator;
+
+	/*
+	 * For nested iterator usage.
+	 *
+	 * Here we support at most one level of nested iterator call like:
+	 *
+	 *	LIST_HEAD(all_qgroups);
+	 *	{
+	 *		LIST_HEAD(local_qgroups);
+	 *		qgroup_iterator_add(local_qgroups, qg);
+	 *		qgroup_iterator_nested_add(all_qgroups, qg);
+	 *		do_some_work(local_qgroups);
+	 *		qgroup_iterator_clean(local_qgroups);
+	 *	}
+	 *	do_some_work(all_qgroups);
+	 *	qgroup_iterator_nested_clean(all_qgroups);
+	 */
+	struct list_head nested_iterator;
 	struct rb_node node;	  /* tree of qgroups */
 
 	/*
-- 
2.41.0

