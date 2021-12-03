Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43462467FCC
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383386AbhLCWVz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383382AbhLCWVy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:21:54 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1340BC061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:30 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id 8so4853166qtx.5
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XqAIWxCeVhJhfycau7RWLN/sT+F//qXYcejmX7pU5BU=;
        b=C4E6uG253angtZQtHZzduHp+ByJZETwUyGdqHS4ANBDo7/c0QLYFZXOBfW6/0BLel0
         ddv6p4DeOP6tCvK6VT4MIpmIKc+jkenC+vqc/U5PyUrsWZDuKv61o1uXg9HMHGU1OG4F
         xkVtGRS8+vmwXjOHD35Z1cJhz1MnsjUCq8PLVbyQ1WCder06MDejyuncnPjxJKCOTMDP
         CvvmuhaUdRumRQSxbZrmf5uoB1bF5vX74NQKKjFg5Jj0AcZUEWkL73n/AgxIPLns3lBH
         bpjQ8y28RHg5jJXoEw6AaoVvDJmy4mR+idjO4rlcPi0U4jzTQTvCF+dCe6vwSnzuuC4K
         dnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqAIWxCeVhJhfycau7RWLN/sT+F//qXYcejmX7pU5BU=;
        b=N6cWe3ISNEw3d4yXABp+n11d61wmuNdoWmM1oUCwRKOMV5IEf+phVbUEWLCcpPZOFQ
         5L60d8YZ0eIYMsIoKyzus1sD+png14kfYpmTyIdn/b+/mUqopS6GQB5l0VDGrrajbU5w
         I0h93RsQYIhsKWUMJXqWxjax2IEsm+iIf41o7STcY4DLNhpuPQpqPm83mxby/fYvUJYe
         CTFQiyR0lj+o/wQyq4fiMHVcqqyr0fcllPlOQL7sDKa6JtOKMYpkkDSVEj25GCdTK+F8
         pJL2N645JvGKJaPX11da50tNKKrsbZD+15+wTgJ1D3WPoBdAHh4vBF6A3MZ9hXz84Kw3
         0hmQ==
X-Gm-Message-State: AOAM532h38PIFLHBWYE3BZLNwTprCvmvLQujNTKwMlmL8rV0R4xKglK2
        i39wGRbaXPhE0JqIbJD2VYx0MHZONM3sQg==
X-Google-Smtp-Source: ABdhPJxLqpkZBINa/KEyLlQbPOZh2ZBHfAvc7kSRmeUDSgSZl8hL68I/rkzVLmCuhCh7CPFRjqOk6w==
X-Received: by 2002:ac8:5990:: with SMTP id e16mr23797650qte.615.1638569908815;
        Fri, 03 Dec 2021 14:18:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m4sm3149260qtu.87.2021.12.03.14.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/18] btrfs: remove found_extent from btrfs_truncate_inode_items
Date:   Fri,  3 Dec 2021 17:18:08 -0500
Message-Id: <eb948ed6fb42b7f7aeff049fa478a6b58a8bc778.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We only set this if we find a normal file extent, del_item == 1, and the
file extent points to a real extent and isn't a hole extent.  We can use
del_item == 1 && extent_start != 0 to get the same information that
found_extent provides, so remove this variable and use the other
variables instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode-item.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index bc59f80510ad..8afc8d1c607b 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -457,13 +457,11 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
 	struct btrfs_key found_key;
-	u64 extent_start = 0;
 	u64 extent_num_bytes = 0;
 	u64 extent_offset = 0;
 	u64 item_end = 0;
 	u64 last_size = new_size;
 	u32 found_type = (u8)-1;
-	int found_extent;
 	int del_item;
 	int pending_del_nr = 0;
 	int pending_del_slot = 0;
@@ -519,7 +517,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	}
 
 	while (1) {
-		u64 clear_start = 0, clear_len = 0;
+		u64 clear_start = 0, clear_len = 0, extent_start = 0;
 
 		fi = NULL;
 		leaf = path->nodes[0];
@@ -563,7 +561,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			else
 				del_item = 0;
 		}
-		found_extent = 0;
+
 		/* FIXME, shrink the extent if the ref count is only 1 */
 		if (found_type != BTRFS_EXTENT_DATA_KEY)
 			goto delete;
@@ -603,7 +601,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 				/* FIXME blocksize != 4096 */
 				num_dec = btrfs_file_extent_num_bytes(leaf, fi);
 				if (extent_start != 0) {
-					found_extent = 1;
 					if (test_bit(BTRFS_ROOT_SHAREABLE,
 						     &root->state))
 						inode_sub_bytes(&inode->vfs_inode,
@@ -682,7 +679,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		}
 		should_throttle = false;
 
-		if (found_extent &&
+		if (del_item && extent_start != 0 &&
 		    root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
 			struct btrfs_ref ref = { 0 };
 
-- 
2.26.3

