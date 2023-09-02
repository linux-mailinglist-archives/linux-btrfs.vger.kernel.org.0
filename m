Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD979046F
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343575AbjIBAOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 20:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIBAOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 20:14:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C441A8
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 17:14:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 19EA51F45F;
        Sat,  2 Sep 2023 00:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693613667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YjQ6ooXtX4OkPNh3Wjo1jjf6Mya2d/PcgI3ap/dzKkk=;
        b=jpGlvzAXwqeqjVduWI3/EQFaBXyUKfoIH0Rp28c37lXbFhk9rekwy8Mr4buQ2Ndg49E9PG
        LCsnXJX0dXjUe3ACKcC8B9etG2frcNEJlbKaNVCUi3hjz8gUYsd6haGPmRBRp8Vtina2nU
        kgOQtJKSaEfqNAL8VsSLl0Ge3XVzPVE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C12313587;
        Sat,  2 Sep 2023 00:14:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +HKwNGF+8mSzUgAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 02 Sep 2023 00:14:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v3 5/6] btrfs: qgroup: use qgroup_iterator facility to replace tmp ulist of qgroup_update_refcnt()
Date:   Sat,  2 Sep 2023 08:13:56 +0800
Message-ID: <230888afd7d2b683536c59a01da9a6d173a26b87.1693613265.git.wqu@suse.com>
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

For function qgroup_update_refcnt(), we use @tmp list to iterate all the
involved qgroups of a subvolume.

It's a perfect match for qgroup_iterator facility, as that @tmp ulist
has a very limited lifespan (just inside the while() loop).

By migrating to qgroup_iterator, we can get rid of the GFP_ATOMIC memory
allocation and no more error handling needed.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3d768045aa5c..f24feb8f2065 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2454,13 +2454,11 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
  * Walk all of the roots that points to the bytenr and adjust their refcnts.
  */
 static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
-				struct ulist *roots, struct ulist *tmp,
-				struct ulist *qgroups, u64 seq, int update_old)
+				struct ulist *roots, struct ulist *qgroups,
+				u64 seq, int update_old)
 {
 	struct ulist_node *unode;
 	struct ulist_iterator uiter;
-	struct ulist_node *tmp_unode;
-	struct ulist_iterator tmp_uiter;
 	struct btrfs_qgroup *qg;
 	int ret = 0;
 
@@ -2468,40 +2466,35 @@ static int qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
 		return 0;
 	ULIST_ITER_INIT(&uiter);
 	while ((unode = ulist_next(roots, &uiter))) {
+		LIST_HEAD(tmp);
+
 		qg = find_qgroup_rb(fs_info, unode->val);
 		if (!qg)
 			continue;
 
-		ulist_reinit(tmp);
 		ret = ulist_add(qgroups, qg->qgroupid, qgroup_to_aux(qg),
 				GFP_ATOMIC);
 		if (ret < 0)
 			return ret;
-		ret = ulist_add(tmp, qg->qgroupid, qgroup_to_aux(qg), GFP_ATOMIC);
-		if (ret < 0)
-			return ret;
-		ULIST_ITER_INIT(&tmp_uiter);
-		while ((tmp_unode = ulist_next(tmp, &tmp_uiter))) {
+		qgroup_iterator_add(&tmp, qg);
+		list_for_each_entry(qg, &tmp, iterator) {
 			struct btrfs_qgroup_list *glist;
 
-			qg = unode_aux_to_qgroup(tmp_unode);
 			if (update_old)
 				btrfs_qgroup_update_old_refcnt(qg, seq, 1);
 			else
 				btrfs_qgroup_update_new_refcnt(qg, seq, 1);
+
 			list_for_each_entry(glist, &qg->groups, next_group) {
 				ret = ulist_add(qgroups, glist->group->qgroupid,
 						qgroup_to_aux(glist->group),
 						GFP_ATOMIC);
 				if (ret < 0)
 					return ret;
-				ret = ulist_add(tmp, glist->group->qgroupid,
-						qgroup_to_aux(glist->group),
-						GFP_ATOMIC);
-				if (ret < 0)
-					return ret;
+				qgroup_iterator_add(&tmp, glist->group);
 			}
 		}
+		qgroup_iterator_clean(&tmp);
 	}
 	return 0;
 }
@@ -2666,7 +2659,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct ulist *qgroups = NULL;
-	struct ulist *tmp = NULL;
 	u64 seq;
 	u64 nr_new_roots = 0;
 	u64 nr_old_roots = 0;
@@ -2705,12 +2697,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 		ret = -ENOMEM;
 		goto out_free;
 	}
-	tmp = ulist_alloc(GFP_NOFS);
-	if (!tmp) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-
 	mutex_lock(&fs_info->qgroup_rescan_lock);
 	if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
 		if (fs_info->qgroup_rescan_progress.objectid <= bytenr) {
@@ -2725,13 +2711,13 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	seq = fs_info->qgroup_seq;
 
 	/* Update old refcnts using old_roots */
-	ret = qgroup_update_refcnt(fs_info, old_roots, tmp, qgroups, seq,
+	ret = qgroup_update_refcnt(fs_info, old_roots, qgroups, seq,
 				   UPDATE_OLD);
 	if (ret < 0)
 		goto out;
 
 	/* Update new refcnts using new_roots */
-	ret = qgroup_update_refcnt(fs_info, new_roots, tmp, qgroups, seq,
+	ret = qgroup_update_refcnt(fs_info, new_roots, qgroups, seq,
 				   UPDATE_NEW);
 	if (ret < 0)
 		goto out;
@@ -2746,7 +2732,6 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 out:
 	spin_unlock(&fs_info->qgroup_lock);
 out_free:
-	ulist_free(tmp);
 	ulist_free(qgroups);
 	ulist_free(old_roots);
 	ulist_free(new_roots);
-- 
2.41.0

