Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A313B44CA68
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhKJUSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhKJUSQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:16 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A02C0613F5
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:28 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id bl12so3645284qkb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AkCQ2BcBy4V2mlHKFbwaIlcHABtcv/nGbJ+ZWF8MQr8=;
        b=upWhVrDm3xaaqym66OBpq7hQeoOg+chVqgTp+oMyUCOH7JJu4OXrVJ+Jl1tv0I7kbL
         nateOkz2Ohc1/mdAWrMgq1BRCD0fj2faIIKtNbeYFxP1Astb6oZ8l/X1pg0PTptURBsm
         lrDNIQJ5n5sxVydBZ1LXFtYFWSVJZa3Dcf2PCYmLGa/m646CKl4xN0jiaOnVTWc4bJqH
         1nvsbDJmr04R/EWxuvVMa3r7JONkJICVMvbTgxjnVYXEh2Uob/uBIpQFwNoLCwbn3HmT
         CCQLfRFLd0Dab3rOSB98QXArlz8kbecYtbfM98QvwmYYKO21sfeyG+ybP3Z0G5L6lk2D
         Nd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkCQ2BcBy4V2mlHKFbwaIlcHABtcv/nGbJ+ZWF8MQr8=;
        b=6bMnhu6BdAG5PuZKsjlt3BLJJwG5tgbOgu5XvIzYyjE64eHNSSNXQ0MyWUJJMmgaTj
         uLG8E/YJ7fIwkBk6SWwiGfr5m6QcyltMqIzUAo3MG51oiiTFGimOUwTfyEbeW8ITcXJ0
         044KOhirkUW1yln9YXj6Wq3WoqNq0GndsTcZcJo9fiJqBhG6fnbGRj3BmqN0CgOQ/UaU
         Jyk7/9B7X46cKWZtH7PeTU+Greh7/jhy/fA9STb36hMaTb82+8m88mPnBsJhraGjgIic
         e1QzqHkNjVvFohDtEf1G0CjH62sWWMp/gVVReA3+QvuMDWSgX58sDivPF+6MXhH4ZSI1
         21Dw==
X-Gm-Message-State: AOAM5306HtBH87DuYW3fKvd2Bnx70kfHoKS/iwQHn9UiloG6LT3plGsH
        fnjtHHjDWhC3HSSKiGir20Jfi24fv+77bw==
X-Google-Smtp-Source: ABdhPJyVH7yzkTNxFJnInEp1vTQGlCIeQ8K+gGvDc5bMORs/IXp8VaR3FIGB8yjhrb5e9li8Zo5fnA==
X-Received: by 2002:a05:620a:298e:: with SMTP id r14mr1712968qkp.509.1636575327224;
        Wed, 10 Nov 2021 12:15:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o15sm458385qtm.8.2021.11.10.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 26/30] btrfs-progs: make btrfs_clear_free_space_tree extent tree v2 aware
Date:   Wed, 10 Nov 2021 15:14:38 -0500
Message-Id: <67784f92356144887bb350f4769acd5b027e883e.1636575147.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With extent tree v2 we'll have multiple free space trees, and we can't
just unset the feature flags for the free space tree.  Fix this to loop
through all of the free space trees and clear them out properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/free-space-tree.c | 37 ++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 0a13b1d6..70306175 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1248,18 +1248,35 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info)
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
 
-	features = btrfs_super_compat_ro_flags(fs_info->super_copy);
-	features &= ~(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |
-		      BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
-	btrfs_set_super_compat_ro_flags(fs_info->super_copy, features);
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		struct btrfs_key key = {
+			.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
+			.type = BTRFS_ROOT_ITEM_KEY,
+			.offset = 0,
+		};
+
+		while (key.offset < fs_info->num_global_roots) {
+			free_space_root = btrfs_global_root(fs_info, &key);
+			ret = clear_free_space_tree(trans, free_space_root);
+			if (ret)
+				goto abort;
+			key.offset++;
+		}
+	} else {
+		features = btrfs_super_compat_ro_flags(fs_info->super_copy);
+		features &= ~(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |
+			      BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE);
+		btrfs_set_super_compat_ro_flags(fs_info->super_copy, features);
 
-	ret = clear_free_space_tree(trans, free_space_root);
-	if (ret)
-		goto abort;
+		ret = clear_free_space_tree(trans, free_space_root);
+		if (ret)
+			goto abort;
 
-	ret = btrfs_delete_and_free_root(trans, free_space_root);
-	if (!ret)
-		ret = btrfs_commit_transaction(trans, tree_root);
+		ret = btrfs_delete_and_free_root(trans, free_space_root);
+		if (ret)
+			goto abort;
+	}
+	ret = btrfs_commit_transaction(trans, tree_root);
 abort:
 	return ret;
 }
-- 
2.26.3

