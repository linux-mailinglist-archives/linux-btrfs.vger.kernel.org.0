Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE0F466AF4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 21:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348834AbhLBUiC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 15:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348823AbhLBUiA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 15:38:00 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16340C06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 12:34:38 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id m25so1033801qtq.13
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Dec 2021 12:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+7EM8PYmSwliNskEaG6FKq8Xpu8J0mkA2cvC5fGMft0=;
        b=F2HGbLEp9IA8KdZsSGb4H98PNCa50VFT17DAxNdJLA9zUhrpx4GmPeNYqrFMxhLXwJ
         TF6BAn9LQR8SOLcZqCYLgLnzIg6O8U8pKV3SUr3L7fKsr43rpTyGIhiMRAhyKUXP9oUY
         Y8K60npWjn5yYhFbcVFxJhj1Qbt14m3uBTnbNYbO0Jgh0OinWrgZ4CGfJkIbeIQoLUY+
         Opls+08FlYFPD14AFzloy9NvMaiADvCaUqMAUVQVqapjrCCSzfdstR62h5RIpNPnIOfK
         OopbdIGSWfza2QPzNJyG+E02wfcK3yQyrIelwZYNGzKsrH6uXQUpt/RboIpCwdQ2i8RD
         TNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+7EM8PYmSwliNskEaG6FKq8Xpu8J0mkA2cvC5fGMft0=;
        b=c+JC27a2LS3U8wFRLktlmTnhJzReEzb4qmFH5avRcK4ewhM/NmVo3qUOZJIeMTFBQc
         uJsjm8kHDxA7fxfVDw7ek7JNgSeLDqJYbMB8QdIWAg98A7XbnU+UUhJYWqKmon9mOo9g
         Tbb4YMWL3XNrXeZ+94ScXV6eOX6K/M7DBmEgiqlysai8kquMp8beYlpsRuDVOJtnEt/s
         00bSRj3Qm/MI2WjwHqXGlQv5GXuue/2TpOC5+R4d3WssdTdCug8vHIKQe3b3h0yIivsh
         dme/0taVEIx3EslmfcKpK1jPgw4Ec8HFuz0qERTd0MFpu5hjhF2v/R/G+QfUZSkKKWG2
         7cyw==
X-Gm-Message-State: AOAM531DogOO6WCZHN5rxD625Vg0SZ+NCvW1RCDZFWxp5kRMucfXAeFp
        OBH4lEx+uC1+WZAMjPXUIB1Cm73Jv2o9Yw==
X-Google-Smtp-Source: ABdhPJw2XexdQ25IezZ3sSjAXmXwIU9mWClegDQwrnCzCf/IBC1n/40u3+90TfoDuZ8nXy8iSsCkjw==
X-Received: by 2002:ac8:5dcb:: with SMTP id e11mr15980252qtx.559.1638477277003;
        Thu, 02 Dec 2021 12:34:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u7sm742024qkp.17.2021.12.02.12.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 12:34:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs: reserve extra space for the free space tree
Date:   Thu,  2 Dec 2021 15:34:32 -0500
Message-Id: <18b2ae0948a035aa809ba38641439e2d4167ca29.1638477127.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638477127.git.josef@toxicpanda.com>
References: <cover.1638477127.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe reported a problem where sometimes he'd get an ENOSPC abort when
running delayed refs with generic/619 and the free space tree enabled.
This is partly because we do not reserve space for modifying the free
space tree, nor do we have a block rsv associated with that tree.

The delayed_refs_rsv tracks the amount of space required to run delayed
refs.  This means 1 modification means 1 change to the extent root.
With the free space tree this turns into 2 changes, because modifying 1
extent means updating the extent tree and potentially updating the free
space tree to either remove that entry or add the free space.  Thus if
we have the FST enabled, simply double the reservation size for our
modification.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c   |  1 +
 fs/btrfs/delayed-ref.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index b3086f252ad0..b3ee49b0b1e8 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -426,6 +426,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	switch (root->root_key.objectid) {
 	case BTRFS_CSUM_TREE_OBJECTID:
 	case BTRFS_EXTENT_TREE_OBJECTID:
+	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 		root->block_rsv = &fs_info->delayed_refs_rsv;
 		break;
 	case BTRFS_ROOT_TREE_OBJECTID:
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index da9d20813147..533521be8fdf 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -84,6 +84,17 @@ void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 	u64 num_bytes = btrfs_calc_insert_metadata_size(fs_info, nr);
 	u64 released = 0;
 
+	/*
+	 * We have to check the mount option here because we could be enabling
+	 * the free space tree for the first time and don't have the compat_ro
+	 * option set yet.
+	 *
+	 * We need extra reservations if we have the free space tree because
+	 * we'll have to modify that tree as well.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		num_bytes <<= 1;
+
 	released = btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
 	if (released)
 		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
@@ -108,6 +119,17 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 
 	num_bytes = btrfs_calc_insert_metadata_size(fs_info,
 						    trans->delayed_ref_updates);
+	/*
+	 * We have to check the mount option here because we could be enabling
+	 * the free space tree for the first time and don't have the compat_ro
+	 * option set yet.
+	 *
+	 * We need extra reservations if we have the free space tree because
+	 * we'll have to modify that tree as well.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		num_bytes <<= 1;
+
 	spin_lock(&delayed_rsv->lock);
 	delayed_rsv->size += num_bytes;
 	delayed_rsv->full = 0;
-- 
2.26.3

