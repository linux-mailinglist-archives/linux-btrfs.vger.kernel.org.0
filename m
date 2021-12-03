Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E0D467FD1
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383397AbhLCWWC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383393AbhLCWWA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:22:00 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68548C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:36 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id j9so4115911qvm.10
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5KmbS+8OgjJksWB2vTqx97Mpyu6/QKGGCISuLJbxFGA=;
        b=A2aLCwaS6Zc13Nua07b8GiTF5fPQVx2qC5tlmeXOWasZ5F+8yQJoJ8wEllRyxOQIaI
         Fh3A1IY0jM6GO3VYqbN94ToPM2ve4cYPAGxW7ke8gjnmNpoefzsQp7nqAQyqMit1mmrb
         6PMeU8klPJB3SdvNxxvGYjWrVCZbz9Biz9V2oVYDfQyEct83YPOWCXYeTxFjoEdUJdMj
         Nl4JMHBN/pFn7DGtFcmq+OPxdHBr8nousTshbOkse6GOB8xSHUk37MidOPLsOE/ugGiV
         yhh0VkNYP9uydlJvv7bb0QH/XXZ2fa5KqPej8ENKJXKtRUQWzqG895O7NQugFIZDkKAe
         RXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KmbS+8OgjJksWB2vTqx97Mpyu6/QKGGCISuLJbxFGA=;
        b=6mPiSJfuxTUihyJFls+QYS471Y51O4n0lu10SqN+PFVqhmwyYan455ubTHkWrwyYP9
         KyuE6iMX0GtShZqrVId/Nj1G/rh6CVOO0DcPRUkTKxnuTNLZEdRwFyAnOyUPOnCZE7ti
         zVgH7f7hogTsTNnc9U0RPJpKuWBaULqpo2BDa1H9yUk3bPHRUg6fmZCWUVUlNgV/MzWj
         NwZze1GJoA+OrFpbs2al3Sv5Q8hXfXVC/zrBNtKZJ5CfWUhDOjacy4YRpUTWSxldUdtl
         G6KfJ9hHK4hmFh8MVpGU21uBdXIZp40E6zhX/syu4ibYncdPv3PvS4TY6AiryHMEqJcX
         jFjw==
X-Gm-Message-State: AOAM531h07sdxMXf+UxwErJVBj+GTeS5fBx4jywwLvkP82UA9fZYRhHV
        CYg3LHev77f/bw4I6MtJZwKINZ4tlqD+pA==
X-Google-Smtp-Source: ABdhPJymjTcuXXgVze+7jiTs3CvfCI93C8zq7XiFpQerCjoVszoykzSHl3KfIEyF9ut/HPxAaKZcSA==
X-Received: by 2002:a05:6214:767:: with SMTP id f7mr22693277qvz.36.1638569915279;
        Fri, 03 Dec 2021 14:18:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r16sm3301232qta.46.2021.12.03.14.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:34 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/18] btrfs: use a flag to control when to clear the file extent range
Date:   Fri,  3 Dec 2021 17:18:13 -0500
Message-Id: <9bf47eb21a7497c3ea75d0a1ff5b6309d4465183.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We only care about updating the file extent range when we are doing a
normal truncation.  We skip this for tree logging currently, but we can
also skip this for eviction as well.  Using a flag makes it more
explicit when we want to do this work.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 1 +
 fs/btrfs/inode-item.c       | 8 ++++----
 fs/btrfs/inode-item.h       | 6 ++++++
 fs/btrfs/inode.c            | 1 +
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d2f4716f8485..3a6bf361409b 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -294,6 +294,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	struct btrfs_truncate_control control = {
 		.new_size = 0,
 		.min_type = BTRFS_EXTENT_DATA_KEY,
+		.clear_extent_range = true,
 	};
 	struct btrfs_inode *inode = BTRFS_I(vfs_inode);
 	struct btrfs_root *root = inode->root;
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 79305d646b98..225a5cd3f0ea 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -628,11 +628,11 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		}
 delete:
 		/*
-		 * We use btrfs_truncate_inode_items() to clean up log trees for
-		 * multiple fsyncs, and in this case we don't want to clear the
-		 * file extent range because it's just the log.
+		 * We only want to clear the file extent range if we're
+		 * modifying the actual inode's mapping, which is just the
+		 * normal truncate path.
 		 */
-		if (root == inode->root) {
+		if (control->clear_extent_range) {
 			ret = btrfs_inode_clear_file_extent_range(inode,
 						  clear_start, clear_len);
 			if (ret) {
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 0cb16cac07d1..50acee3f4e28 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -33,6 +33,12 @@ struct btrfs_truncate_control {
 	 * extents we drop.
 	 */
 	bool skip_ref_updates;
+
+	/*
+	 * IN: true if we need to clear the file extent range for the inode as
+	 * we drop the file extent items.
+	 */
+	bool clear_extent_range;
 };
 
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 306d410b4db4..45dc4355102a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8534,6 +8534,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 {
 	struct btrfs_truncate_control control = {
 		.min_type = BTRFS_EXTENT_DATA_KEY,
+		.clear_extent_range = true,
 	};
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-- 
2.26.3

