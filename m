Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33EE614F00
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 17:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiKAQQJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 12:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiKAQQH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 12:16:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4E1C90E
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 09:16:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F28E3611DA
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D33C4347C
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667319362;
        bh=5ood/zz0uWAJhNxB/ehvZP6xcqECuC8Jj+qtE+otfaU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=O9OxuyxuYj14+vH2raAKOdy1BwnRmIKfUlT3HMISTaHhJl9v20H51H7RdfTq+XS5/
         6Az9GgjNX1a0mNaHUe4rG3iox48IjYIhEHRx6acsZnGm6y4j70YCCsu+cI08NzrzeL
         XnMIYrAwsBnsEXhYjl/xXtdDQreLjOzGWr4oWZ1bxfhmk9cnIy/d2E6JDDQ0vfTp44
         60d7cqNFEqkWiwXPE/sQBQireP8VvCx7Xb79Q7lMLC/SS2moTq0IRo981BZrnuqs+u
         WOHg4a4sXT4jq/zxzNlSuZAkocOw6Bn9S/6GIMyWLK7Xt9Mrc8f+/LUHqUqXSULDqG
         1wL5s0IsGAEyw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/18] btrfs: send: avoid unnecessary path allocations when finding extent clone
Date:   Tue,  1 Nov 2022 16:15:41 +0000
Message-Id: <8a45ac7ffef6caedbbee1a22bdbe1c7049091caa.1667315100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667315100.git.fdmanana@suse.com>
References: <cover.1667315100.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When looking for an extent clone, at find_extent_clone(), we start by
allocating a path and then check for cases where we can't have clones
and exit immediately in those cases. It's a waste of time to allocate
the path before those cases, so reorder the logic so that we check for
those cases before allocating the path.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 50063ac83830..2226296ca691 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1365,40 +1365,35 @@ static int find_extent_clone(struct send_ctx *sctx,
 	int compressed;
 	u32 i;
 
-	tmp_path = alloc_path_for_send();
-	if (!tmp_path)
-		return -ENOMEM;
-
-	/* We only use this path under the commit sem */
-	tmp_path->need_commit_sem = 0;
-
 	if (data_offset >= ino_size) {
 		/*
 		 * There may be extents that lie behind the file's size.
 		 * I at least had this in combination with snapshotting while
 		 * writing large files.
 		 */
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
-	fi = btrfs_item_ptr(eb, path->slots[0],
-			struct btrfs_file_extent_item);
+	fi = btrfs_item_ptr(eb, path->slots[0], struct btrfs_file_extent_item);
 	extent_type = btrfs_file_extent_type(eb, fi);
-	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-		ret = -ENOENT;
-		goto out;
-	}
-	compressed = btrfs_file_extent_compression(eb, fi);
+	if (extent_type == BTRFS_FILE_EXTENT_INLINE)
+		return -ENOENT;
 
-	num_bytes = btrfs_file_extent_num_bytes(eb, fi);
 	disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
-	if (disk_byte == 0) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (disk_byte == 0)
+		return -ENOENT;
+
+	compressed = btrfs_file_extent_compression(eb, fi);
+	num_bytes = btrfs_file_extent_num_bytes(eb, fi);
 	logical = disk_byte + btrfs_file_extent_offset(eb, fi);
 
+	tmp_path = alloc_path_for_send();
+	if (!tmp_path)
+		return -ENOMEM;
+
+	/* We only use this path under the commit sem */
+	tmp_path->need_commit_sem = 0;
+
 	down_read(&fs_info->commit_root_sem);
 	ret = extent_from_logical(fs_info, disk_byte, tmp_path,
 				  &found_key, &flags);
-- 
2.35.1

