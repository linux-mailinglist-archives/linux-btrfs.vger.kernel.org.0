Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BB54D0AA4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343614AbiCGWMY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343538AbiCGWMX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:23 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5008BF01
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:28 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id j5so13191998qvs.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Lj2sCD9qkxfc79B+4FFRwofYXIw8fDSYZskn+59/Cy8=;
        b=ajJKeM917UKYomUaZ6A0vxoMjKyOCXSQStQDLCoj4nLP17r9K0rAEaQCloxr54mcRk
         aYzrCOxzOaAJOkFRLBf/Lh81lw2qouvYV8Y/+aJBPc/BhwPO6++R2kHK18LBQJ1Jop0l
         JgVhl5iGWD0hvlMMtgfKxhZW9vojiKXri7O4YLNyp9QYrbQF7qqp6tbCd746CDMWAUqw
         XKbWT6GpX5TYw8AezqYRjuHB+o9wpUX6hIw8/qsZb1YOcQlX6lb8psSyypuzxCKM4Lsw
         DpgnFBFkM6NEmttrUTp4x3M5oNLJtJ+EKgXAQWXopTgRy1cFOlulBOv+67kEhz1Jm2GE
         0hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lj2sCD9qkxfc79B+4FFRwofYXIw8fDSYZskn+59/Cy8=;
        b=kIEdAoH9/ZNIstU+0vV2n2XEBxDETJQIWrjkidDQHQbYAT+FV1n3tpPFKtCKSQK6qT
         wbD7M8ldr50MaWFzrmyT5892P6rOxzpcL2Bv+aAth+Zu7eNbeU1Xvsd8ZGYpgiH0gtoZ
         +dk0w0mXp6HRJt3IbToVT0xRx2x14o9/s5qxtvTfIm/SJ3/cQJiwYy+GXRkFm6cwgu6y
         7nLVVFdz8x6Rv/Rx1dMxzVz44zgNObQdvixddfDAsLD8PjKT/rtGr3cryxjbQgKGwvmE
         rO+891YFShJyHrIFd8KCKJ2KVBQDooIeI3DJ0nDajJD7kZwlw0iGPxgBLzXDGlS856x7
         WtgA==
X-Gm-Message-State: AOAM532i0ehwFWjf1fARyaipGRWh2ubhDWn6mGy3acKhdTUy2lp7X0dx
        uYaEJs7wDvu/wl0uWnxm70lhXYZfFnEytlav
X-Google-Smtp-Source: ABdhPJz+J+0cLcWYKFL46Vjkzds29bLGE6nWZRDwA3JW+LqKdi4qgZiAMhoO9sbaWMpmwYidl0O2wA==
X-Received: by 2002:a05:6214:21a8:b0:435:6aa1:30e2 with SMTP id t8-20020a05621421a800b004356aa130e2mr9846616qvc.17.1646691087210;
        Mon, 07 Mar 2022 14:11:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a108900b0067b13036bd5sm2702981qkk.52.2022.03.07.14.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 15/19] btrfs-progs: make btrfs_clear_free_space_tree extent tree v2 aware
Date:   Mon,  7 Mar 2022 17:11:00 -0500
Message-Id: <b3ec8f58b31fca40d6832bc72b6d8ef902e3f8d4.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
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

With extent tree v2 we'll have multiple free space trees, and we can't
just unset the feature flags for the free space tree.  Fix this to loop
through all of the free space trees and clear them out properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/free-space-tree.c | 37 ++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 0a13b1d6..7ac75c20 100644
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
+		while (key.offset < fs_info->nr_global_roots) {
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

