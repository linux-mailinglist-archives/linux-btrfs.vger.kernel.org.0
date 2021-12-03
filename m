Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B62467FD2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Dec 2021 23:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383398AbhLCWWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Dec 2021 17:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383391AbhLCWWC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Dec 2021 17:22:02 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD605C061751
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Dec 2021 14:18:37 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id p3so4136974qvj.9
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Dec 2021 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WV0LrUOPdRqkwItvm3/BfUCVJeqgGy/IfZHO/mfhQ6U=;
        b=CjrsE5wvvcv+HYSCu8ijyv1aHlcWxGz61I/3JdszIPmbbyMIPHdpul7J6vk5IMhBY1
         ghcgZxtzzo4iOEz9husnP2GTE64Eb4qSNoPzjcTwdi0uE4ykDiJnjoLFFVkugOWHV78Y
         oPL8x7itwJlCc3J5W1GV3MvGVyo6rqGDHwwDQKHBg6sC33bYWJd+fc/c3QFaJGWuq/bm
         da/sveenKOQqkx+CLOsP15xeXRD1Ox4IKEiBlpYhdtUrlOdIBzIekdTZwDPtwRUas/QY
         VjCPrIk7OlSUIqkG2TOBqJwiE99+wXzkQERZhVZRxGyUA9gF++LGIrMcGMnhM5L62iJF
         S5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WV0LrUOPdRqkwItvm3/BfUCVJeqgGy/IfZHO/mfhQ6U=;
        b=6YRwXikxbM6mn2Vcufhf95UPN8utPweNri578BeO5G9fCteHesir/FsaRZm8gpDIul
         XOnuRyS01E5B0b29FAOuwIBvQGvoUD6ybBxHzoHskl68Y1lKf2Jmb4TqojtvvMv1Cy8y
         lTH9QdcvX56KTrvHZnejkdaf8IoTX0JnDj42j9Zgz6svEABOWdH3q46ijmIxWH1A2mI2
         N1MqRniCRVXuPefz1bLuOXYslSOl88NqB57VnTvuouYh8Lha2fLh64Y3xK1RP3H9JiLV
         aqSYt6NCXL/11UeyRs8iKG5dhblHDUKrA79uPIvsuN7NtsTT+FiB9gnmXS39locYlWVA
         BL6g==
X-Gm-Message-State: AOAM531fn8qEIUrqAm/hWd5ux/kBrPdS4JioV4UIkKRTzV/viSL5HG9a
        mAYPlOOmKt9wnLFAk0062sQH64fMRWYdrg==
X-Google-Smtp-Source: ABdhPJzpaYvV6nX9p8vMES7IduUTTdnAuDaDUfh3QESxfqnR0/rxuydxv/ww3u32VrrCpqrGmfjopQ==
X-Received: by 2002:a05:6214:2c5:: with SMTP id g5mr21202275qvu.94.1638569916610;
        Fri, 03 Dec 2021 14:18:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t18sm3302363qtw.64.2021.12.03.14.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:18:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/18] btrfs: pass the ino via btrfs_truncate_control
Date:   Fri,  3 Dec 2021 17:18:14 -0500
Message-Id: <0f979b59665b5607b418fdf5380dd779d72d06b1.1638569556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638569556.git.josef@toxicpanda.com>
References: <cover.1638569556.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the future we are going to want to truncate inode items without
needing to have an btrfs_inode to pass in, so add ino to the
btrfs_truncate_control and use that to look up the inode items to
truncate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 1 +
 fs/btrfs/inode-item.c       | 7 +++----
 fs/btrfs/inode-item.h       | 3 +++
 fs/btrfs/inode.c            | 2 ++
 fs/btrfs/tree-log.c         | 1 +
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3a6bf361409b..c2a34179bddc 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -293,6 +293,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_truncate_control control = {
 		.new_size = 0,
+		.ino = btrfs_ino(BTRFS_I(vfs_inode)),
 		.min_type = BTRFS_EXTENT_DATA_KEY,
 		.clear_extent_range = true,
 	};
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 225a5cd3f0ea..b11c3da680fd 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -458,7 +458,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 	int pending_del_slot = 0;
 	int extent_type = -1;
 	int ret;
-	u64 ino = btrfs_ino(inode);
 	u64 bytes_deleted = 0;
 	bool be_nice = false;
 	bool should_throttle = false;
@@ -480,7 +479,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	path->reada = READA_BACK;
 
-	key.objectid = ino;
+	key.objectid = control->ino;
 	key.offset = (u64)-1;
 	key.type = (u8)-1;
 
@@ -518,7 +517,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		found_type = found_key.type;
 
-		if (found_key.objectid != ino)
+		if (found_key.objectid != control->ino)
 			break;
 
 		if (found_type < control->min_type)
@@ -671,7 +670,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			btrfs_init_generic_ref(&ref, BTRFS_DROP_DELAYED_REF,
 					extent_start, extent_num_bytes, 0);
 			btrfs_init_data_ref(&ref, btrfs_header_owner(leaf),
-					ino, extent_offset,
+					control->ino, extent_offset,
 					root->root_key.objectid, false);
 			ret = btrfs_free_extent(trans, &ref);
 			if (ret) {
diff --git a/fs/btrfs/inode-item.h b/fs/btrfs/inode-item.h
index 50acee3f4e28..1948461e5a46 100644
--- a/fs/btrfs/inode-item.h
+++ b/fs/btrfs/inode-item.h
@@ -22,6 +22,9 @@ struct btrfs_truncate_control {
 	/* OUT: the number of bytes to sub from this inode. */
 	u64 sub_bytes;
 
+	/* IN: the ino we are truncating. */
+	u64 ino;
+
 	/*
 	 * IN: minimum key type to remove.  All key types with this type are
 	 * removed only if their offset >= new_size.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 45dc4355102a..06e7c5e26a65 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5252,6 +5252,7 @@ void btrfs_evict_inode(struct inode *inode)
 
 	while (1) {
 		struct btrfs_truncate_control control = {
+			.ino = btrfs_ino(BTRFS_I(inode)),
 			.new_size = 0,
 			.min_type = 0,
 		};
@@ -8533,6 +8534,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 {
 	struct btrfs_truncate_control control = {
+		.ino = btrfs_ino(BTRFS_I(inode)),
 		.min_type = BTRFS_EXTENT_DATA_KEY,
 		.clear_extent_range = true,
 	};
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 11b9b516af80..fb3bf7cc21c5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4097,6 +4097,7 @@ static int truncate_inode_items(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_truncate_control control = {
 		.new_size = new_size,
+		.ino = btrfs_ino(inode),
 		.min_type = min_type,
 		.skip_ref_updates = true,
 	};
-- 
2.26.3

