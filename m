Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265FF4D3EC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbiCJBc4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbiCJBc4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:32:56 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D9AE1B50
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:31:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z4so3412685pgh.12
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EomJHqlO4yPQZBIbGnPzF8vPcEEnvwb57iKujBCKo9Y=;
        b=Ah/tpPPMnB4MZMfGTj+gs8Q4iAynC/tPXRazw1SK0CO9y3exE1KqvwO/65UNgCqirK
         u9DPcJdwmDalidwhHGkdm+qXAgDTI+xlcJYZbWQ4yaq2vjhN7kD65500x2N7Lcywfqy0
         YvNSstDfwkVRIGcDGDScM8Afqt5DI60L1WIeWtI1zqt7syV9yS+wdYMshb19iB11FBA7
         mE/0sO3K8ts4g04eDWnvdJEksiC1C+5Rz9qMZotI+j05I4ZoDo27Nf3PZjUQxib6dOhZ
         Cl281K+vBhXv202RLp7d3tqhY6hWcmHFS4V0WOU/QqTobYEqa2VUroIHf7V/XYGESNS+
         C8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EomJHqlO4yPQZBIbGnPzF8vPcEEnvwb57iKujBCKo9Y=;
        b=qJzreyqK1FaovZGv5TeFpiClY3aVZk4VYxCIaZ6PjNTa/SsVWARgJo7sUJ5LWdqW/8
         QBzzx+CQ2uCFXga2Gm25hQOPXGJQN9P4P2IHJU9PfZLp+4TRviVjXnez2BiqtvKnXZjx
         s6TQnKRifvt9DoH5vbk0tKrDo6GLar+yxfy/Gy3TLKH58SucZkVLDkJYs16lqri4ycpQ
         vM6urqdl+YglLcRayMpFo9b5oGYTyBoHN4FGRTTpwPRDjE3I2ToziRbZ1WXAxede6s5t
         B1mJ+OeI8AdoSRStK7SEjcMFfLQ5RkS4cWMnae4zOkONWYDCI9D2s7wvve7r4G/rmley
         bWwg==
X-Gm-Message-State: AOAM530Ywpo9/fxmREzPpCt+NyNRxq/ZtWF2R5IKgmuLymoa9K91pLEZ
        fwox6hjjacDaAGbRcYoXKSK/wz/PJSqpGQ==
X-Google-Smtp-Source: ABdhPJx7uas0jappiIzxLrs1PY9VowTGW75pZs5CPOXLQaGotMhBknrW9rJeWl9nP0lAslz24ly6XA==
X-Received: by 2002:a05:6a00:a1d:b0:4f6:5051:6183 with SMTP id p29-20020a056a000a1d00b004f650516183mr2355035pfh.42.1646875915852;
        Wed, 09 Mar 2022 17:31:55 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:31:55 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 02/16] btrfs: reserve correct number of items for rename
Date:   Wed,  9 Mar 2022 17:31:32 -0800
Message-Id: <6dbd84bd116114b3d2deae2e0c24bf19fed2f721.1646875648.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646875648.git.osandov@fb.com>
References: <cover.1646875648.git.osandov@fb.com>
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

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
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

