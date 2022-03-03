Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AF04CC9EC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbiCCXUK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiCCXUJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0D03A1AA
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:23 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ay5so6178473plb.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcxJqW3xQG5uNguk36DKjVBeVd3Q8mLAF97DK5rZGSc=;
        b=Z0i4+ZXEm228gR0Mh8tLw8Ce5PwilHjpf28RnZTnFPdUg3cq6qdO4BKonJZzGbG9Lf
         eH9bX9NkiA18pOsGXkk6/rLl3o2UiCzJmyo00G+tFXzykLirhyirITdNu2TmZMJJvwZU
         d3qqZOqx6SdY8yW8/vEgL/xpu+3TDGiLUMRk+XWRvYmEcHzWa2/rpCbhete8zgN1+qxP
         +oWBU7wc/k4fFUYnFH+/X1FuvfimGegAdIX8v0/ujVkzHlj2rAwb4P2YAsNo3fTrwOvL
         2S2TSplfjbMyxChxIt3hY1AkS4LaX80pPJX4q6nf3IdI6hXOUjSlBaOFAZ21GTDE1bjB
         nNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcxJqW3xQG5uNguk36DKjVBeVd3Q8mLAF97DK5rZGSc=;
        b=xYC+GFJ6/zIpKJW4uHAYIx0nbvL17hDH+ukOGzDVyoKSb0yXwmeOc/vXBsSiRajHzg
         46d1xAoTZuj4WvhFFFAx9OTgJXSczZibWwwOnJCSz+XbRbHIpi1FCPIrnq9D3yMAjpjM
         ihloF0cZOmcUiZqNxIaPsdmmWQHvlHiIUk+XNSjjcXfbPS774kdXxjR+7V9WTop9oJEW
         Tf4uaOywWxrhd2iv9XxE9RArr9IIZ+7ehJpgBjrj1j8GFpRwnG20gqJBOHFDLplgs9rt
         2m1xoRLbdrX5bIzObFCa7/fV08Gzjb9EUQ6582t+0qAa8kWEAydcEIoKMNYZ7ZVvSdoF
         oyog==
X-Gm-Message-State: AOAM530H6S+AsGfwskhOiVFJe90KSkHk9IJSXOfKs5B6ohd+p5U/Hf24
        AyQMx1mReN15X5BVirwEfTn2Ls7JXgK6fQ==
X-Google-Smtp-Source: ABdhPJzBp5lTxJYXNHkeqfSznNUX8EfP5iSQQVGrIpJcSDsHRS88QztGHujRvBr4GIqtxsPj5JT4gw==
X-Received: by 2002:a17:903:1c3:b0:151:a54b:95f4 with SMTP id e3-20020a17090301c300b00151a54b95f4mr7601353plh.10.1646349562506;
        Thu, 03 Mar 2022 15:19:22 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:22 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 02/12] btrfs: reserve correct number of items for rename
Date:   Thu,  3 Mar 2022 15:18:52 -0800
Message-Id: <e5e3cbaf959136a44ad87b00bca366e6e072e8e0.1646348486.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646348486.git.osandov@fb.com>
References: <cover.1646348486.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_rename() and btrfs_rename_exchange() don't account for enough
items. Replace the incorrect explanations with a specific breakdown of
the number of items and account them accurately.

Note that this glosses over RENAME_WHITEOUT because the next commit is
going to rework that, too.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 86 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2fb8aa36a9ac..be51630160f5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9058,6 +9058,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(old_dir->i_sb);
 	struct btrfs_trans_handle *trans;
+	unsigned int trans_num_items;
 	struct btrfs_root *root = BTRFS_I(old_dir)->root;
 	struct btrfs_root *dest = BTRFS_I(new_dir)->root;
 	struct inode *new_inode = new_dentry->d_inode;
@@ -9089,14 +9090,37 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		down_read(&fs_info->subvol_sem);
 
 	/*
-	 * We want to reserve the absolute worst case amount of items.  So if
-	 * both inodes are subvols and we need to unlink them then that would
-	 * require 4 item modifications, but if they are both normal inodes it
-	 * would require 5 item modifications, so we'll assume their normal
-	 * inodes.  So 5 * 2 is 10, plus 2 for the new links, so 12 total items
-	 * should cover the worst case number of items we'll modify.
+	 * For each inode:
+	 * 1 to remove old dir item
+	 * 1 to remove old dir index
+	 * 1 to add new dir item
+	 * 1 to add new dir index
+	 * 1 to update parent inode
+	 *
+	 * If the parents are the same, we only need to account for one
 	 */
-	trans = btrfs_start_transaction(root, 12);
+	trans_num_items = old_dir == new_dir ? 9 : 10;
+	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
+		/*
+		 * 1 to remove old root ref
+		 * 1 to remove old root backref
+		 * 1 to add new root ref
+		 * 1 to add new root backref
+		 */
+		trans_num_items += 4;
+	} else {
+		/*
+		 * 1 to update inode item
+		 * 1 to remove old inode ref
+		 * 1 to add new inode ref
+		 */
+		trans_num_items += 3;
+	}
+	if (new_ino == BTRFS_FIRST_FREE_OBJECTID)
+		trans_num_items += 4;
+	else
+		trans_num_items += 3;
+	trans = btrfs_start_transaction(root, trans_num_items);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_notrans;
@@ -9375,21 +9399,45 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	if (new_inode && S_ISREG(old_inode->i_mode) && new_inode->i_size)
 		filemap_flush(old_inode->i_mapping);
 
-	/* close the racy window with snapshot create/destroy ioctl */
-	if (old_ino == BTRFS_FIRST_FREE_OBJECTID)
+	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
+		/* close the racy window with snapshot create/destroy ioctl */
 		down_read(&fs_info->subvol_sem);
+		/*
+		 * 1 to remove old root ref
+		 * 1 to remove old root backref
+		 * 1 to add new root ref
+		 * 1 to add new root backref
+		 */
+		trans_num_items = 4;
+	} else {
+		/*
+		 * 1 to update inode
+		 * 1 to remove old inode ref
+		 * 1 to add new inode ref
+		 */
+		trans_num_items = 3;
+	}
 	/*
-	 * We want to reserve the absolute worst case amount of items.  So if
-	 * both inodes are subvols and we need to unlink them then that would
-	 * require 4 item modifications, but if they are both normal inodes it
-	 * would require 5 item modifications, so we'll assume they are normal
-	 * inodes.  So 5 * 2 is 10, plus 1 for the new link, so 11 total items
-	 * should cover the worst case number of items we'll modify.
-	 * If our rename has the whiteout flag, we need more 5 units for the
-	 * new inode (1 inode item, 1 inode ref, 2 dir items and 1 xattr item
-	 * when selinux is enabled).
+	 * 1 to remove old dir item
+	 * 1 to remove old dir index
+	 * 1 to update old parent inode
+	 * 1 to add new dir item
+	 * 1 to add new dir index
+	 * 1 to update new parent inode (if it's not the same as the old parent)
 	 */
-	trans_num_items = 11;
+	trans_num_items += 6;
+	if (new_dir != old_dir)
+		trans_num_items++;
+	if (new_inode) {
+		/*
+		 * 1 to update inode
+		 * 1 to remove inode ref
+		 * 1 to remove dir item
+		 * 1 to remove dir index
+		 * 1 to possibly add orphan item
+		 */
+		trans_num_items += 5;
+	}
 	if (flags & RENAME_WHITEOUT)
 		trans_num_items += 5;
 	trans = btrfs_start_transaction(root, trans_num_items);
-- 
2.35.1

