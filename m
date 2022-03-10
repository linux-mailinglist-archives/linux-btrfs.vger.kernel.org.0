Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4F4D3EBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 02:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbiCJBdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 20:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbiCJBdH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 20:33:07 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111A91275D0
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 17:32:08 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g19so3778774pfc.9
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 17:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHdkrwykIibP4UR2YOOWR9d7+Xb0er2QDrhPV1Ui5lI=;
        b=XuRAojD7v4h9XdSadJf9KRNKF2tav7rEehX6nSVs6JjbKUs7CiwlLY8jGZkX+QUt68
         plHtSDPcPaV3zfAXrXnXPtTDKGQczZG5TB0CkvC9iMxQ40ow73dmnHjMq0tOTBjUfLrk
         46XUORZQ7nID2Kzi9SnEhqXqRik8exMP/lh3DyW8BHqIlr7TKycUrFcluHYe3ZfP1TS5
         k4YS9PH9r1meEv80HcebcuTq1fTnSDqxI9+xpUBVD2N8vGcrqdY8yujeGa4I6Mj66q02
         TQtlYg6JzFIjMb8icfKODfaTPXHVczF85153qhLtsx/iLoD4xihRmMrfC2Uu/vZp4gK0
         cpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHdkrwykIibP4UR2YOOWR9d7+Xb0er2QDrhPV1Ui5lI=;
        b=jYgIij7UOgvAQEpomIV8UGI+zHuLoRPdveVCz0LY9uaxBbzg6l3p0qmNLjYTIDe8+I
         u0WshJpUzSqfYy0RHlOb5cYo8jC1IbrE1+Ec0B8h3+nJ4dcdrVXPqub61ZqSXQGbEBGQ
         nydPU28OsNP/Ibo38cPFLH8F4Nk+I7LjO7GK5nDEcVnNIco6Vb25IByM+0lh1dax/+5X
         i9RikxPB92vGzwvs/yoovo1QZyLKPRZ/D8T6JVTVQTRQL8uX0XxFoiPY5Mjj83yVvQEF
         NdQRvMpK/m0jWojm2nGRQyM2d3cFnIbX7U8nijb8Xu/Bz8Etkjt23FkVsp9efrgdntSQ
         MygQ==
X-Gm-Message-State: AOAM530EGHILE+mFVtn67nN5ooZKuFonRsepRyHS03g3SB3C1ExCkxZH
        KSZQCdMaG662sEcbFezYc32BQJ2TZ/YI0Q==
X-Google-Smtp-Source: ABdhPJzCove7ffwoIBfVt256QHzOQnBKCrlHJXILRpSKCQBMu79ntV1w7DzEjo4pfhmLG4uX/+tkrg==
X-Received: by 2002:a62:55c4:0:b0:4f6:b396:9caa with SMTP id j187-20020a6255c4000000b004f6b3969caamr2340253pfb.19.1646875927205;
        Wed, 09 Mar 2022 17:32:07 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:6f59])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a3f8b00b001bc299e0aefsm7618627pjc.56.2022.03.09.17.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 17:32:06 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v2 12/16] btrfs: set inode flags earlier in btrfs_new_inode()
Date:   Wed,  9 Mar 2022 17:31:42 -0800
Message-Id: <6fe48a043315a7a81610e8658821838fdbc28974.1646875648.git.osandov@fb.com>
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

btrfs_new_inode() inherits the inode flags from the parent directory and
the mount options _after_ we fill the inode item. This works because all
of the callers of btrfs_new_inode() make further changes to the inode
and then call btrfs_update_inode(). It'd be better to fully initialize
the inode once to avoid the extra update, so as a first step, set the
inode flags _before_ filling the inode item.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 289bb5176e09..c47bdada2440 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6161,6 +6161,16 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 
+	btrfs_inherit_iflags(inode, dir);
+
+	if (S_ISREG(mode)) {
+		if (btrfs_test_opt(fs_info, NODATASUM))
+			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
+		if (btrfs_test_opt(fs_info, NODATACOW))
+			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
+				BTRFS_INODE_NODATASUM;
+	}
+
 	/*
 	 * We could have gotten an inode number from somebody who was fsynced
 	 * and then removed in this same transaction, so let's just set full
@@ -6236,16 +6246,6 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	btrfs_free_path(path);
 
-	btrfs_inherit_iflags(inode, dir);
-
-	if (S_ISREG(mode)) {
-		if (btrfs_test_opt(fs_info, NODATASUM))
-			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
-		if (btrfs_test_opt(fs_info, NODATACOW))
-			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
-				BTRFS_INODE_NODATASUM;
-	}
-
 	inode_tree_add(inode);
 
 	trace_btrfs_inode_new(inode);
-- 
2.35.1

