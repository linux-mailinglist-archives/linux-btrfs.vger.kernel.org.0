Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B9E79046E
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245460AbjIBAOa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 20:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIBAO3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 20:14:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12F71A8
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 17:14:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A2E6A21865;
        Sat,  2 Sep 2023 00:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693613665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf/9MCjeK21P2h1IVL8OTW6pzH3LdZwIHVlmIhYOj8s=;
        b=sDds6dG9/HarbMBnJy+IqyGLRMOfnB8XJqw1SddSQKLBQcUBjO7ZLPAYT3F+GB5ed5qQic
        OAn/zGGCrztCfPybRE+sb7GjnMwGkyMJ2QM4ltLCN42RpItZEAlG2XY2gx4aiInVz0EZ8C
        V0GyS/kueR+HY2XuuUSdHRqICjIG6IE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F0F413587;
        Sat,  2 Sep 2023 00:14:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KBlyEF9+8mSzUgAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 02 Sep 2023 00:14:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v3 4/6] btrfs: qgroup: use qgroup_iterator facility for __qgroup_excl_accounting()
Date:   Sat,  2 Sep 2023 08:13:55 +0800
Message-ID: <799066bf9271470d397f3420641b47e6b9f2c4f1.1693613265.git.wqu@suse.com>
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

With the new qgroup_iterator_add() and qgroup_iterator_clean(), we can
get rid of the ulist and its GFP_ATOMIC memory allocation.

Furthermore we can merge the code handling the initial and parent
qgroups into one loop, and drop the @tmp ulist parameter for involved
call sites.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 81 ++++++++++-------------------------------------
 1 file changed, 17 insertions(+), 64 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index aa8e9e7be4f8..3d768045aa5c 100644
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
@@ -1511,21 +1484,12 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
-	struct ulist *tmp;
-	unsigned int nofs_flag;
 	int ret = 0;
 
 	/* Check the level of src and dst first */
 	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
 		return -EINVAL;
 
-	/* We hold a transaction handle open, must do a NOFS allocation. */
-	nofs_flag = memalloc_nofs_save();
-	tmp = ulist_alloc(GFP_KERNEL);
-	memalloc_nofs_restore(nofs_flag);
-	if (!tmp)
-		return -ENOMEM;
-
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
 		ret = -ENOTCONN;
@@ -1562,11 +1526,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
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
 
@@ -1577,19 +1540,10 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
-	struct ulist *tmp;
 	bool found = false;
-	unsigned int nofs_flag;
 	int ret = 0;
 	int ret2;
 
-	/* We hold a transaction handle open, must do a NOFS allocation. */
-	nofs_flag = memalloc_nofs_save();
-	tmp = ulist_alloc(GFP_KERNEL);
-	memalloc_nofs_restore(nofs_flag);
-	if (!tmp)
-		return -ENOMEM;
-
 	if (!fs_info->quota_root) {
 		ret = -ENOTCONN;
 		goto out;
@@ -1627,11 +1581,10 @@ static int __del_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
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

