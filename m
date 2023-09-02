Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029A679046D
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Sep 2023 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243557AbjIBAO0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Sep 2023 20:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIBAOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Sep 2023 20:14:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87461A8
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Sep 2023 17:14:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DA2F1F45F;
        Sat,  2 Sep 2023 00:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693613661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6zAeF2aGQOiDktXzhQFwCnRpGstGlV2rIRfIrfElv0=;
        b=LNF/qu8fYgb6ovtpjePS7VPxuimN04B/q2EpC5EcZoons0lwc1u9XdJnFGjKlKvK9WPAuD
        RtuiIUnfEMtF+qcy07Fxw840yGLtIACcMcivQtnqwp7GONNf71AxHhNGw1eCk1mBloJdnP
        i5j0rzgF3k9IOcvQ+wQ1lXmi25LRPFQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3952B13587;
        Sat,  2 Sep 2023 00:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GJERO1t+8mSzUgAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 02 Sep 2023 00:14:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v3 2/6] btrfs: qgroup: use qgroup_iterator facility for btrfs_qgroup_free_refroot()
Date:   Sat,  2 Sep 2023 08:13:53 +0800
Message-ID: <e0cb7c4075bddde0d87ff4b9b52655255ba5dc57.1693613265.git.wqu@suse.com>
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

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index de34e2aef710..c2a1173d9f00 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3237,10 +3237,8 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 			       u64 ref_root, u64 num_bytes,
 			       enum btrfs_qgroup_rsv_type type)
 {
-	struct btrfs_qgroup *qgroup;
-	struct ulist_node *unode;
-	struct ulist_iterator uiter;
-	int ret = 0;
+	struct btrfs_qgroup *cur;
+	LIST_HEAD(qgroup_list);
 
 	if (!is_fstree(ref_root))
 		return;
@@ -3257,8 +3255,8 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 	if (!fs_info->quota_root)
 		goto out;
 
-	qgroup = find_qgroup_rb(fs_info, ref_root);
-	if (!qgroup)
+	cur = find_qgroup_rb(fs_info, ref_root);
+	if (!cur)
 		goto out;
 
 	if (num_bytes == (u64)-1)
@@ -3266,32 +3264,19 @@ void btrfs_qgroup_free_refroot(struct btrfs_fs_info *fs_info,
 		 * We're freeing all pertrans rsv, get reserved value from
 		 * level 0 qgroup as real num_bytes to free.
 		 */
-		num_bytes = qgroup->rsv.values[type];
+		num_bytes = cur->rsv.values[type];
 
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
-		qgroup_rsv_release(fs_info, qg, num_bytes, type);
-
-		list_for_each_entry(glist, &qg->groups, next_group) {
-			ret = ulist_add(fs_info->qgroup_ulist,
-					glist->group->qgroupid,
-					qgroup_to_aux(glist->group), GFP_ATOMIC);
-			if (ret < 0)
-				goto out;
+		qgroup_rsv_release(fs_info, cur, num_bytes, type);
+		list_for_each_entry(glist, &cur->groups, next_group) {
+			qgroup_iterator_add(&qgroup_list, glist->group);
 		}
 	}
-
 out:
+	qgroup_iterator_clean(&qgroup_list);
 	spin_unlock(&fs_info->qgroup_lock);
 }
 
-- 
2.41.0

