Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF77A465529
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352257AbhLASVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352223AbhLASVF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:21:05 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328C3C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:44 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id 8so24975064qtx.5
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AkCQ2BcBy4V2mlHKFbwaIlcHABtcv/nGbJ+ZWF8MQr8=;
        b=u2wbQPMoPRhI121q4hCZiYnvxLPEnGojFHqWij34f5TwXgdK5Jd5lLcHYMUMk2eVgx
         8CcLwsqCFuujzOsaPdfoIQwRVQ6FvHe3COZ01T5J1cVgP2WLW479dNdukLYWzzq1m9rZ
         KNdxjYE801apwUxVj3QBsza4Yj/w45sf0cpQELkEOWVoyDKac7dY6741M17KcRsZdb0w
         3weD+l3NLBZyD3KEsIeijcIR2oJSDyOexBJ3LEp0t5XTcZc8TNnJRVMydzHbERv6UPRO
         02cZ5xTNUMRzDMt1a8/o4DzAvD1JR7d1lhhU4V2Ofm6txGZSVS0tcrBs5xCLwfi1GV3w
         bwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkCQ2BcBy4V2mlHKFbwaIlcHABtcv/nGbJ+ZWF8MQr8=;
        b=mmw4/wn20rbThRKKmpTfMqy1nTs9DLc7TVJUIOoL1r+Cg6IuEr82kxVm7F3ZDCcuTx
         gzU7puKbIW1ZNQMHPKfAZNZwcfymgBO/S4x4N35U+FHJO6cxbZdZeFEaXRfVKCTUww0B
         mANHApQmSECM90RHwGBvZ5tph1UTvegbYfgKpjAZkfM2Xh+iPJPG/9dIpGNbBngXVwEv
         iBRHpFdsmYCEF4sXLR1rW56RATg2y86Qtd6bNoqNPUeB5WqTv8wn/cRaKcPqXMiRMrno
         oj5su2TmFegyWpXaiyBc0NvrNMgXgrlu79NfJX/wM8cB1pP0YHSXnf8db1JWSsPfElme
         PN8w==
X-Gm-Message-State: AOAM530+k/tSCX6WXUL3BQgUTPV2ZzFM+Aa6dOzE8hza/R17kTwrrOv5
        Web5/5UZ0djURpx/+7FxZN5XXk+9zQVWlQ==
X-Google-Smtp-Source: ABdhPJxA5U2acDYHLjMziK0F+ppZZ5SNiVYYBj2f53c9slfL4iVfieVrBmzdvho6lHDDxv6yhTzDVA==
X-Received: by 2002:ac8:7d8a:: with SMTP id c10mr8872235qtd.415.1638382662944;
        Wed, 01 Dec 2021 10:17:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o17sm276036qtv.30.2021.12.01.10.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:42 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 18/22] btrfs-progs: make btrfs_clear_free_space_tree extent tree v2 aware
Date:   Wed,  1 Dec 2021 13:17:12 -0500
Message-Id: <d99424e92350f01feef71428ed24bdb6b3999d54.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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

