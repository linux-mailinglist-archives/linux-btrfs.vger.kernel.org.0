Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D706378F6F2
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Sep 2023 04:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbjIACLm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Aug 2023 22:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbjIACLm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Aug 2023 22:11:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14A2E6E
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Aug 2023 19:11:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A0821F45E
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 02:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693534294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4rJQOVQwhWFMiDGjgu/RQlSoaTiYhUs9j6abyzoUAfY=;
        b=KlweEAiE+IyScCHW2ndgM/hrFvlZ3F6IpokKtB8U8klzXlz+Bs+XLW/To6phjVZK0Ga1pV
        2ovWIokdXjUyfT///dpNim+DdUW3VHXZSjgdXPnVk71BiJKphMzL8advTZv6jf8uduBQxd
        4ncLUEYXbRNj4QwKMfaBxd6Lq9VgCiA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ADCBB13582
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 02:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F9W9HVVI8WTiegAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Sep 2023 02:11:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: prealloc btrfs_qgroup_list for __add_relation_rb()
Date:   Fri,  1 Sep 2023 10:11:16 +0800
Message-ID: <ca35f1e6134d6e14abee25f1c230c55b1d3f8ae0.1693534205.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
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

Currently we go GFP_ATOMIC allocation for qgroup relation add, this
includes the following 3 call sites:

- btrfs_read_qgroup_config()
  This is not really needed, as at that time we're still in single
  thread mode, and no spin lock is held.

- btrfs_add_qgroup_relation()
  This one is holding spinlock, but we're ensured to add at most one
  relation, thus we can easily do a preallocation and use the
  preallocated memory to avoid GFP_ATOMIC.

- btrfs_qgroup_inherit()
  This is a little more tricky, as we may have as many relationships as
  inherit::num_qgroups.
  Thus we have to properly allocate an array then preallocate all the
  memory.

This patch would remove the GFP_ATOMIC allocation for above involved
call sites, by doing preallocation before holding the spinlock, and let
__add_relation_rb() to handle the freeing of the structure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 74 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 27debc645f97..fd7879f213ec 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -270,21 +270,19 @@ static int del_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
  *         -ENOENT  if one of the qgroups is NULL
  *         <0       other errors
  */
-static int __add_relation_rb(struct btrfs_qgroup *member, struct btrfs_qgroup *parent)
+static int __add_relation_rb(struct btrfs_qgroup_list *prealloc,
+			     struct btrfs_qgroup *member,
+			     struct btrfs_qgroup *parent)
 {
-	struct btrfs_qgroup_list *list;
-
-	if (!member || !parent)
+	if (!member || !parent) {
+		kfree(prealloc);
 		return -ENOENT;
+	}
 
-	list = kzalloc(sizeof(*list), GFP_ATOMIC);
-	if (!list)
-		return -ENOMEM;
-
-	list->group = parent;
-	list->member = member;
-	list_add_tail(&list->next_group, &member->groups);
-	list_add_tail(&list->next_member, &parent->members);
+	prealloc->group = parent;
+	prealloc->member = member;
+	list_add_tail(&prealloc->next_group, &member->groups);
+	list_add_tail(&prealloc->next_member, &parent->members);
 
 	return 0;
 }
@@ -298,7 +296,9 @@ static int __add_relation_rb(struct btrfs_qgroup *member, struct btrfs_qgroup *p
  *         -ENOENT  if one of the ids does not exist
  *         <0       other errors
  */
-static int add_relation_rb(struct btrfs_fs_info *fs_info, u64 memberid, u64 parentid)
+static int add_relation_rb(struct btrfs_fs_info *fs_info,
+			   struct btrfs_qgroup_list *prealloc,
+			   u64 memberid, u64 parentid)
 {
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup *parent;
@@ -306,7 +306,7 @@ static int add_relation_rb(struct btrfs_fs_info *fs_info, u64 memberid, u64 pare
 	member = find_qgroup_rb(fs_info, memberid);
 	parent = find_qgroup_rb(fs_info, parentid);
 
-	return __add_relation_rb(member, parent);
+	return __add_relation_rb(prealloc, member, parent);
 }
 
 /* Must be called with qgroup_lock held */
@@ -502,6 +502,8 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 	if (ret)
 		goto out;
 	while (1) {
+		struct btrfs_qgroup_list *list = NULL;
+
 		slot = path->slots[0];
 		l = path->nodes[0];
 		btrfs_item_key_to_cpu(l, &found_key, slot);
@@ -515,8 +517,14 @@ int btrfs_read_qgroup_config(struct btrfs_fs_info *fs_info)
 			goto next2;
 		}
 
-		ret = add_relation_rb(fs_info, found_key.objectid,
+		list = kzalloc(sizeof(*list), GFP_KERNEL);
+		if (!list) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = add_relation_rb(fs_info, list, found_key.objectid,
 				      found_key.offset);
+		list = NULL;
 		if (ret == -ENOENT) {
 			btrfs_warn(fs_info,
 				"orphan qgroup relation 0x%llx->0x%llx",
@@ -1485,6 +1493,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	struct btrfs_qgroup *parent;
 	struct btrfs_qgroup *member;
 	struct btrfs_qgroup_list *list;
+	struct btrfs_qgroup_list *prealloc = NULL;
 	unsigned int nofs_flag;
 	int ret = 0;
 
@@ -1516,6 +1525,11 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 		}
 	}
 
+	prealloc = kzalloc(sizeof(*list), GFP_NOFS);
+	if (!prealloc) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	ret = add_qgroup_relation_item(trans, src, dst);
 	if (ret)
 		goto out;
@@ -1527,7 +1541,8 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	}
 
 	spin_lock(&fs_info->qgroup_lock);
-	ret = __add_relation_rb(member, parent);
+	ret = __add_relation_rb(prealloc, member, parent);
+	prealloc = NULL;
 	if (ret < 0) {
 		spin_unlock(&fs_info->qgroup_lock);
 		goto out;
@@ -1535,6 +1550,7 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src,
 	ret = quick_update_accounting(fs_info, src, dst, 1);
 	spin_unlock(&fs_info->qgroup_lock);
 out:
+	kfree(prealloc);
 	mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	return ret;
 }
@@ -2897,6 +2913,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
 	struct btrfs_qgroup *prealloc;
+	struct btrfs_qgroup_list **qlist_prealloc = NULL;
 	bool need_rescan = false;
 	u32 level_size = 0;
 	u64 nums;
@@ -2977,8 +2994,23 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 				goto out;
 		}
 		ret = 0;
-	}
 
+		qlist_prealloc = kcalloc(inherit->num_qgroups,
+					 sizeof(struct btrfs_qgroup_list *),
+					 GFP_NOFS);
+		if (!qlist_prealloc) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		for (int i = 0; i < inherit->num_qgroups; i++) {
+			qlist_prealloc[i] = kzalloc(sizeof(struct btrfs_qgroup_list),
+						    GFP_NOFS);
+			if (!qlist_prealloc[i]) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+	}
 
 	spin_lock(&fs_info->qgroup_lock);
 
@@ -3030,7 +3062,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	i_qgroups = (u64 *)(inherit + 1);
 	for (i = 0; i < inherit->num_qgroups; ++i) {
 		if (*i_qgroups) {
-			ret = add_relation_rb(fs_info, objectid, *i_qgroups);
+			ret = add_relation_rb(fs_info, qlist_prealloc[i], objectid, *i_qgroups);
+			qlist_prealloc[i] = NULL;
 			if (ret)
 				goto unlock;
 		}
@@ -3094,6 +3127,11 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
 	if (need_rescan)
 		qgroup_mark_inconsistent(fs_info);
+	if (qlist_prealloc) {
+		for (int i = 0; i < inherit->num_qgroups; i++)
+			kfree(qlist_prealloc[i]);
+		kfree(qlist_prealloc);
+	}
 	kfree(prealloc);
 	return ret;
 }
-- 
2.41.0

