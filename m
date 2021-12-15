Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F7C476278
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhLOUAU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbhLOUAT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:19 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0161C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:18 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id i13so21335430qvm.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AkCQ2BcBy4V2mlHKFbwaIlcHABtcv/nGbJ+ZWF8MQr8=;
        b=GT4hit66hqY5XODd8aBPuMjMFUfJFKaqOKwhx5dmzc9p4w+J2q3GQWbNKo0wRQHLrV
         pHSzCOpY4XfRxJDRN5NxZE10ucYMr6YnRRNCYQVbSJkSrkuIPWMdJqWdXVsdoZwEHQJw
         6Vdo3UFchnW9l+pJxI/af7jJT3PLICG36+ZTWy5qJ/QwDCotMzXWsvlgNKRgE+HGNRJi
         0q8I8yvsFergGIY6NmQ/2R4hUg3DTcGT4aVx2CbprXTlKTJaW8iNM7OnCsoLtNYqYHTo
         orjU3gsgJnHGa57FfhRWpiYjNNBWFZOT8Ob90W6yXRJv/r44DyVc7MLqS4ttmN5VfwU7
         IfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkCQ2BcBy4V2mlHKFbwaIlcHABtcv/nGbJ+ZWF8MQr8=;
        b=7P4VZt9Ef7HF3jK0xVZQorN24HgWl7uCvONqqHe9NX8S23wjeU/Q1EMXwOIIgqWEoK
         rZQCq4eI1+rAwKdDjj5iDnM3JhCpW9WcNQ5RyrBPOm3Dz5859rPwbm278DSO0sUsA7zS
         ebxzBGlRFuaaDHn+QKemhSnZkaIOn7GJpxbOOXYzFHAyNKVgKbG4XnLde+u54cdK9sn/
         gXz49fbZZ6s6ynsW9qjJxmmI5YG7NLk8rq1Jp6twl4SspXXHeHvF+nVnGUu4RGUfHgA/
         j5LkMDdomjcGSGwUj8NrJsOB6Hn8cxubxEa5Djuf8X2KYvk9J7kpDBfyaBA6/dNnDtmu
         FDxQ==
X-Gm-Message-State: AOAM5336hTs2NB48IFCoVkzwc8cqVxpQUCPuMChMhbSzdWAWq3GtjbSi
        mfMpyPrGOVZMaY5HwXeO8V/S8yJKvCzV8g==
X-Google-Smtp-Source: ABdhPJyLAo8ipTHVw+XCQ+T/sT3fe7jFSjWb2EvYqKP3vJkNHQN5cG/y7IrnNeV1CNwW2Fp29oRDAw==
X-Received: by 2002:ad4:5bec:: with SMTP id k12mr12674757qvc.94.1639598417888;
        Wed, 15 Dec 2021 12:00:17 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n20sm1608816qkp.65.2021.12.15.12.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 18/22] btrfs-progs: make btrfs_clear_free_space_tree extent tree v2 aware
Date:   Wed, 15 Dec 2021 14:59:44 -0500
Message-Id: <68e5d620e2b1fda218332e2bbd4e4c37418df7a1.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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

