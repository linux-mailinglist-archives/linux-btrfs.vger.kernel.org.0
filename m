Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50F78E3F7
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Aug 2023 02:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbjHaAbE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Aug 2023 20:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjHaAbE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Aug 2023 20:31:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A028CD2
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Aug 2023 17:31:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 234DD2185C;
        Thu, 31 Aug 2023 00:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693441859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/c30b5WsChY5mGKZhsNlbhB3jJdpYC3Hv6tm4A7JeB0=;
        b=KYcFpr4fPlhbxyHJfojXaVIO19yGwEHEUj+MH7LSp637j6YNHgf7MC3yNU+yFzvKPwyfr0
        6wscZbdYDcOcOxqwsKBl+pCnEmoqgPKu9SunC2+bx86q0w+3cficKJK0I+sqDp+uiz6Lz3
        DuAH4t4DWxXFKt32PDGSPj/SaN/R6Yg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 575CB13441;
        Thu, 31 Aug 2023 00:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yNsQCkLf72RcKQAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 31 Aug 2023 00:30:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Boris Burkov <boris@bur.io>
Subject: [PATCH v2 3/6] btrfs: qgroup: use qgroup_iterator facility for qgroup_convert_meta()
Date:   Thu, 31 Aug 2023 08:30:34 +0800
Message-ID: <fc582e2d8fa11dbe9ba6e6672837e16f4bebd8fa.1693441298.git.wqu@suse.com>
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

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c2a1173d9f00..aa8e9e7be4f8 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4119,10 +4119,8 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
 static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref_root,
 				int num_bytes)
 {
-	struct btrfs_qgroup *qgroup;
-	struct ulist_node *unode;
-	struct ulist_iterator uiter;
-	int ret = 0;
+	struct btrfs_qgroup *cur;
+	LIST_HEAD(qgroup_list);
 
 	if (num_bytes == 0)
 		return;
@@ -4130,34 +4128,24 @@ static void qgroup_convert_meta(struct btrfs_fs_info *fs_info, u64 ref_root,
 		return;
 
 	spin_lock(&fs_info->qgroup_lock);
-	qgroup = find_qgroup_rb(fs_info, ref_root);
-	if (!qgroup)
+	cur = find_qgroup_rb(fs_info, ref_root);
+	if (!cur)
 		goto out;
-	ulist_reinit(fs_info->qgroup_ulist);
-	ret = ulist_add(fs_info->qgroup_ulist, qgroup->qgroupid,
-		       qgroup_to_aux(qgroup), GFP_ATOMIC);
-	if (ret < 0)
-		goto out;
-	ULIST_ITER_INIT(&uiter);
-	while ((unode = ulist_next(fs_info->qgroup_ulist, &uiter))) {
-		struct btrfs_qgroup *qg;
+
+	qgroup_iterator_add(&qgroup_list, cur);
+	list_for_each_entry(cur, &qgroup_list, iterator) {
 		struct btrfs_qgroup_list *glist;
 
-		qg = unode_aux_to_qgroup(unode);
-
-		qgroup_rsv_release(fs_info, qg, num_bytes,
+		qgroup_rsv_release(fs_info, cur, num_bytes,
 				BTRFS_QGROUP_RSV_META_PREALLOC);
-		qgroup_rsv_add(fs_info, qg, num_bytes,
+		qgroup_rsv_add(fs_info, cur, num_bytes,
 				BTRFS_QGROUP_RSV_META_PERTRANS);
-		list_for_each_entry(glist, &qg->groups, next_group) {
-			ret = ulist_add(fs_info->qgroup_ulist,
-					glist->group->qgroupid,
-					qgroup_to_aux(glist->group), GFP_ATOMIC);
-			if (ret < 0)
-				goto out;
-		}
+
+		list_for_each_entry(glist, &cur->groups, next_group)
+			qgroup_iterator_add(&qgroup_list, glist->group);
 	}
 out:
+	qgroup_iterator_clean(&qgroup_list);
 	spin_unlock(&fs_info->qgroup_lock);
 }
 
-- 
2.41.0

