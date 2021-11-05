Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5F4469E2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhKEUn5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbhKEUnz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:55 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC9C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g13so7869318qtk.12
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AkCQ2BcBy4V2mlHKFbwaIlcHABtcv/nGbJ+ZWF8MQr8=;
        b=zYdTab9LMs5VccWP27FYcSWd6EZt4Qxu95CFHalLB7/QRXyOhbi9Kn8SI5u310K83m
         m/whxXfKm+cxgoWdNlNYrfa08QnY11Tlr1rFzSlp2HnTGpuLYODIjgqOxBggIOJJ1ju4
         rnRNCV/r7J/NUb2VwBLkMTr3D1xl17uVDovdOvFtVEIpABm3ho1afZpXsTlKu1tlxE4p
         WI0+m1WT78Kh+otkKdEtZCj9ebVKl9oOrrkx68ndxxzw5PbNxYdVaRDzlNQESGC1h0UR
         OKsEqOR6HlUEu9nfC91liE9QedLjC0XexxfKHRRvkiHyP4ZLQybkKinGNp2HhPRc4KY8
         /JuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkCQ2BcBy4V2mlHKFbwaIlcHABtcv/nGbJ+ZWF8MQr8=;
        b=jRZK7zsmN3VYgY0R1DT3LXrEA80UtoVa9zuh4f8lRBc0c5lVV5Kkzzm3M7Uv53/KVD
         FcHpjBjk1rU5EKDEjqkZOAQoe4vbzOM/iG+OD8vDl8FRy+IbpBn0I7fSCp5E15GDExHQ
         2PC8xLZmxOYsnaXRSg+2KTsj/EIeugKINQFHVvyrS4/G3XPrGyOstVx0REXJEa5Cqh83
         L0wT42UrqdTZpa4IeY4Ev/6Jo7eq+ZkaOArZcnE2cUypGpzLPnWidLo8J75VN+iDdgAt
         gxFCrEh6U+RqI7pxF4uBTjUQRJYaJmbZncE8KgeNtl4hIN0pfrs/4H2KF7k5prIA/Fng
         cmcg==
X-Gm-Message-State: AOAM531zgCW4nzoHUGEiIBe2RdblGmfuFre6s5PMkaXk0I5NTtc9oozr
        X8Xmpuv3d5nGlHwqvOc3CigetEdYV6xTLA==
X-Google-Smtp-Source: ABdhPJxHcgU2MVCVThWGmlLpbFkgQD1QF1fT5I/zWjchv/ngI2dWSK2xnsQ1qRzaLVtiF+0EEq3OZQ==
X-Received: by 2002:ac8:1ca:: with SMTP id b10mr63882499qtg.327.1636144874120;
        Fri, 05 Nov 2021 13:41:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u26sm1594260qtc.70.2021.11.05.13.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/22] btrfs-progs: make btrfs_clear_free_space_tree extent tree v2 aware
Date:   Fri,  5 Nov 2021 16:40:44 -0400
Message-Id: <7c11a6aef78ff3379ff69c7ccfbd3dd7069a15c9.1636144276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
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

