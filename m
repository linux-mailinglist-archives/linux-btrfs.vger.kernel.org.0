Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E618C446A24
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhKEUwe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbhKEUwd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:52:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96964C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:49:53 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id v4so8326127qtw.8
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1Pzi8cKTTWMu7zmr1kPmls94W22bndG5seuCvzTqER4=;
        b=nvqWcl+1NJJanIoMgJCWE880hD/zs7SIGjEoRebORJo+oYSlEl8ps4gdmVLjYGrKjJ
         pgWPFXz0zFmoVdqGeQ4Aqr98Blt5VT4d2Je6fWAU/VyJqGzgzV7K2UdoAu6Z/rMUGRl9
         yhOnj+8eTUnHpdKqVFprldZ79yF1Ng3sJEmQmg59p0l4p8eoMNpmZ3BKzWwHtAowKQSP
         EmNZroqVDa9+hrOm+5+4nmMKy3MhSKSukCKRL09ZkVZrRUU4Kc1oeqPbPP7GK2ttG5tG
         BcMGN4vh1Pwk6znDyO90N0whuCD60py4FrSa6TlllzuF+FziFvzJ3ILCSRetrN1ErACS
         ohOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Pzi8cKTTWMu7zmr1kPmls94W22bndG5seuCvzTqER4=;
        b=d3bqONFfXPwSJxIbmWdZRPzB7k/aMX7wRVY9nqz8UtylOo3ZgopZX8ccR3LxoislMG
         wILLmfJxGUTyB29qX+vj3ya1K3xHAZtgp2urw7/svCUEHUSC+qmvbc6U4jL1f6fgDmwR
         mfPK8FZLp3yHVGRZ0XiPE/jiFgI0Tm85qYLGWmhCBxZYG/faZsNep1vy1btatHTzOBE3
         CYVMQpETdAkUbFDcZ6k296dXCHtk+CCsg148x25zuJCSypMdfjxEqRa7IlpK1d+/stP9
         UaP/HsrvJ79z9rtxdhL6OQCzz2YaDhPWKk+eX+1xDtBkafM1b05pfN23RRWSViGD1usV
         1dYg==
X-Gm-Message-State: AOAM533dd5lfAlf9YZcig1fQPBMh4GsSlmr74fdL+Ln9A1QFCTehu1LD
        DRjR2M+emMiM9/PVSITTAP3jvTYm1vnQmg==
X-Google-Smtp-Source: ABdhPJw148lrMSDrB/XbIbHATwLXXFG9eL6l/xpH/kJwVEXyhMfKwdFjlM4n668/QlWqQtSYWR9Nkw==
X-Received: by 2002:a05:622a:1d5:: with SMTP id t21mr36102660qtw.382.1636145392522;
        Fri, 05 Nov 2021 13:49:52 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bq30sm6235279qkb.6.2021.11.05.13.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:49:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs: use metadata usage for global block rsv in extent tree v2
Date:   Fri,  5 Nov 2021 16:49:41 -0400
Message-Id: <ea04ef412faa27159e41e01aeac9b596e63b81b9.1636145221.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636145221.git.josef@toxicpanda.com>
References: <cover.1636145221.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With multiple csum and extent roots it makes it tricky to figure out the
total used across all of the different global roots.  Instead just use
the total metadata usage as a guide for the global rsv size.  This will
be adjusted up for the truncate minimum size, and clamped down to 512mb
if it's too much.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 7dcbe901b583..de6d8b4c8213 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -354,9 +354,8 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	struct btrfs_space_info *sinfo = block_rsv->space_info;
-	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, 0);
-	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
-	u64 num_bytes;
+	struct btrfs_root *root, *tmp;
+	u64 num_bytes = btrfs_root_used(&fs_info->tree_root->root_item);
 	unsigned min_items;
 
 	/*
@@ -364,9 +363,14 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	 * checksum tree and the root tree.  If the fs is empty we want to set
 	 * it to a minimal amount for safety.
 	 */
-	num_bytes = btrfs_root_used(&extent_root->root_item) +
-		btrfs_root_used(&csum_root->root_item) +
-		btrfs_root_used(&fs_info->tree_root->root_item);
+	read_lock(&fs_info->global_root_lock);
+	rbtree_postorder_for_each_entry_safe(root, tmp, &fs_info->global_root_tree,
+					     rb_node) {
+		if (root->root_key.objectid == BTRFS_EXTENT_TREE_OBJECTID ||
+		    root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID)
+			num_bytes += btrfs_root_used(&root->root_item);
+	}
+	read_unlock(&fs_info->global_root_lock);
 
 	/*
 	 * We at a minimum are going to modify the csum root, the tree root, and
-- 
2.26.3

