Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7A78E3F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Aug 2023 02:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245688AbjHaAbF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 20:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjHaAbE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 20:31:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B780EBE
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 17:31:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4792F1F853;
        Thu, 31 Aug 2023 00:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693441860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBQC5omSyQiac6IF0CPHTMX/1Bxlu2xSzLgfhNK+gSM=;
        b=rMrjnl+831zXiHe0p34huBuzSJj07uHNbR45M4bfiP5fIrYDgfGjQbExB3qXuTBcYC5FJ8
        GgafWYNFQr2Qam1OEyKqjRl9ExwhGr32y47UubiMUtZCwok0I65uQw794ZrQyeP14ZcD19
        LaDV5pOomUob7wzJzoJ1df+H9vOU0CI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7DEF213441;
        Thu, 31 Aug 2023 00:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2Cc9E0Pf72RcKQAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 31 Aug 2023 00:30:59 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v2 4/6] btrfs: qgroup: use qgroup_iterator facility for __qgroup_excl_accounting()
Date:   Thu, 31 Aug 2023 08:30:35 +0800
Message-ID: <4e3de8062737bf82144144746ae5d1564711e402.1693441298.git.wqu@suse.com>
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

With the new qgroup_iterator_add() and qgroup_iterator_clean(), we can
get rid of the ulist and its GFP_ATOMIC memory allocation.

Furthermore we can merge the code handling the initial and parent
qgroups into one loop, and drop the @tmp ulist parameter for involved
call sites.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 72 +++++++++++------------------------------------
 1 file changed, 17 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index aa8e9e7be4f8..08f4fc622180 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1401,14 +1401,12 @@ static void qgroup_iterator_clean(struct list_head *head)
  *
  * Caller should hold fs_info->qgroup_lock.
  */
-static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info,
-				    struct ulist *tmp, u64 ref_root,
+static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info, u64 ref_root,
 				    struct btrfs_qgroup *src, int sign)
 {
 	struct btrfs_qgroup *qgroup;
-	struct btrfs_qgroup_list *glist;
-	struct ulist_node *unode;
-	struct ulist_iterator uiter;
+	struct btrfs_qgroup *cur;
+	LIST_HEAD(qgroup_list);
 	u64 num_bytes = src->excl;
 	int ret = 0;
 
@@ -1416,53 +1414,30 @@ static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info,
 	if (!qgroup)
 		goto out;
 
-	qgroup->rfer += sign * num_bytes;
-	qgroup->rfer_cmpr += sign * num_bytes;
+	qgroup_iterator_add(&qgroup_list, qgroup);
+	list_for_each_entry(cur, &qgroup_list, iterator) {
+		struct btrfs_qgroup_list *glist;
 
-	WARN_ON(sign < 0 && qgroup->excl < num_bytes);
-	qgroup->excl += sign * num_bytes;
-	qgroup->excl_cmpr += sign * num_bytes;
-
-	if (sign > 0)
-		qgroup_rsv_add_by_qgroup(fs_info, qgroup, src);
-	else
-		qgroup_rsv_release_by_qgroup(fs_info, qgroup, src);
-
-	qgroup_dirty(fs_info, qgroup);
-
-	/* Get all of the parent groups that contain this qgroup */
-	list_for_each_entry(glist, &qgroup->groups, next_group) {
-		ret = ulist_add(tmp, glist->group->qgroupid,
-				qgroup_to_aux(glist->group), GFP_ATOMIC);
-		if (ret < 0)
-			goto out;
-	}
-
-	/* Iterate all of the parents and adjust their reference counts */
-	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(tmp, &uiter))) {
-		qgroup = unode_aux_to_qgroup(unode);
 		qgroup->rfer += sign * num_bytes;
 		qgroup->rfer_cmpr += sign * num_bytes;
+
 		WARN_ON(sign < 0 && qgroup->excl < num_bytes);
 		qgroup->excl += sign * num_bytes;
+		qgroup->excl_cmpr += sign * num_bytes;
+
 		if (sign > 0)
 			qgroup_rsv_add_by_qgroup(fs_info, qgroup, src);
 		else
 			qgroup_rsv_release_by_qgroup(fs_info, qgroup, src);
-		qgroup->excl_cmpr += sign * num_bytes;
 		qgroup_dirty(fs_info, qgroup);
 
-		/* Add any parents of the parents */
-		list_for_each_entry(glist, &qgroup->groups, next_group) {
-			ret = ulist_add(tmp, glist->group->qgroupid,
-					qgroup_to_aux(glist->group), GFP_ATOMIC);
-			if (ret < 0)
-				goto out;
-		}
+		/* Append parent qgroups to @qgroup_list. */
+		list_for_each_entry(glist, &qgroup->groups, next_group)
+			qgroup_iterator_add(&qgroup_list, glist->group);
 	}
 	ret = 0;
 out:
+	qgroup_iterator_clean(&qgroup_list);
 	return ret;
 }
 
@@ -1479,8 +1454,7 @@ static int __qgroup_excl_accounting(struct btrfs_fs_info *fs_info,
  * Return < 0 for other error.
  */
 static int quick_update_accounting(struct btrfs_fs_info *fs_info,
-				   struct ulist *tmp, u64 src, u64 dst,
-				   int sign)
+				   u64 src, u64 dst, int sign)
 {
 	struct btrfs_qgroup *qgroup;
 	int ret = 1;
@@ -1491,8 +1465,7 @@ static int quick_update_accounting(struct btrfs_fs_info *fs_info,
 		goto out;
 	if (qgroup->excl == qgroup->rfer) {
 		ret = 0;
-		err = __qgroup_excl_accounting(fs_info, tmp, dst,
-					       qgroup, sign);
+		err = __qgroup_excl_accounting(fs_info, dst, qgroup, sign);
 		if (err < 0) {
 			ret = err;
 			goto out;
@@ -1511,7 +1484,6 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
-	struct ulist *tmp;
 	unsigned int nofs_flag;
 	int ret = 0;
 
@@ -1521,10 +1493,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 
 	/* We hold a transaction handle open, must do a NOFS allocation. */
 	nofs_flag = memalloc_nofs_save();
-	tmp = ulist_alloc(GFP_KERNEL);
 	memalloc_nofs_restore(nofs_flag);
-	if (!tmp)
-		return -ENOMEM;
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
@@ -1562,11 +1531,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 		spin_unlock(&fs_info->qgroup_lock);
 		goto out;
 	}
-	ret = quick_update_accounting(fs_info, tmp, src, dst, 1);
+	ret = quick_update_accounting(fs_info, src, dst, 1);
 	spin_unlock(&fs_info->qgroup_lock);
 out:
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
-	ulist_free(tmp);
 	return ret;
 }
 
@@ -1577,7 +1545,6 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
-	struct ulist *tmp;
 	bool found = false;
 	unsigned int nofs_flag;
 	int ret = 0;
@@ -1585,11 +1552,7 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 
 	/* We hold a transaction handle open, must do a NOFS allocation. */
 	nofs_flag = memalloc_nofs_save();
-	tmp = ulist_alloc(GFP_KERNEL);
 	memalloc_nofs_restore(nofs_flag);
-	if (!tmp)
-		return -ENOMEM;
-
 	if (!fs_info->quota_root) {
 		ret = -ENOTCONN;
 		goto out;
@@ -1627,11 +1590,10 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	if (found) {
 		spin_lock(&fs_info->qgroup_lock);
 		del_relation_rb(fs_info, src, dst);
-		ret = quick_update_accounting(fs_info, tmp, src, dst, -1);
+		ret = quick_update_accounting(fs_info, src, dst, -1);
 		spin_unlock(&fs_info->qgroup_lock);
 	}
 out:
-	ulist_free(tmp);
 	return ret;
 }
 
-- 
2.41.0

