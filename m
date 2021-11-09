Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0331844B01F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhKIPPE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 10:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbhKIPPC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 10:15:02 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0238BC061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 07:12:16 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id de30so4938492qkb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 07:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bQr4D30HD/ZDW+RiO3T5s8aEEGFZHerKBQvHy3sHRww=;
        b=cKZb4R6kLN3bbeQ7ZYMJtPHztvjeb2LP9AJKtcgnICnjgNV1ti0iaaTwXp7Jqu4g0d
         wJqu2WE4/SEAO7ijKuSZKbW4Feu0gb17ib9y0u6V/5A/2K1oiGJWLe3LwkAm/17mYXpR
         etxZD0+cfsGLyfzxQ78Yhw0XdW5DWFHNh5ILuaMzOO2EfL7uO5GyPv8IzgT1ERYhrpyW
         AghNBzCz4twC4uAlAgzOYMvLFSOG068COvsEy0dX0kji871RtztfsKWzu3KXKSe6q4Ov
         Y6mPujHyiAkgoQ1DT/vwdn4DXX3UcLwkHaeMj9zeKnvktxlT3+1IVaLoxQzH6IpdhktN
         yrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bQr4D30HD/ZDW+RiO3T5s8aEEGFZHerKBQvHy3sHRww=;
        b=O9BgaunxpIosO4td5otKiB6z3kMWG6hCDdDC0CcG4W+3Y3ntvTHLYvVpKqxsvvWWhb
         u+nijKVNLkTx99TqUpTJ3hUpNZ9o0S8+YnSjoBuunuozzoiUavaubW3DQgSKShNL+n0w
         iA04uPYc+tixZ6cwPqVdt9svfxlICM40DxbUyjle0vZQztUXCwzIA7mLEg0BLIrsIvcX
         7EXUHcf/tGURNyxT/G0JF8yhU/mQG+MlOV/YCB9/xVfnHI8lMISmJHGCB3MH32iGXkiP
         umuZNUn5Nz4ePd0nhH6bMsH/Cw97wfEwhBu6+mybywhNc9IvJm6hmnhDH/JQJcn4ZC20
         lE2A==
X-Gm-Message-State: AOAM531hDg0urJcvPFqo6dfky4MiIcTrDFP4kij5J3KmxiY+grfGxZIf
        WEhI6ASgrgc7Tb0tMxQ18O4AGZMOLUp35g==
X-Google-Smtp-Source: ABdhPJyXHxrsBEK0L+jwTxcKYUtSGa7akQr6EraFsOppsb/KZJTe3wk2bdpkS+F5W1Hi5x5RwKjXFw==
X-Received: by 2002:a05:620a:19a1:: with SMTP id bm33mr6214106qkb.353.1636470734776;
        Tue, 09 Nov 2021 07:12:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c23sm7209273qka.89.2021.11.09.07.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:12:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 4/7] btrfs: make BTRFS_RESERVE_FLUSH_EVICT use the global rsv stealing code
Date:   Tue,  9 Nov 2021 10:12:04 -0500
Message-Id: <c73af8ce621bbc638b565320e53ab9c51a529fef.1636470628.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636470628.git.josef@toxicpanda.com>
References: <cover.1636470628.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I forgot to convert this over when I introduced the global reserve
stealing code to the space flushing code.  Evict was simply trying to
make its reservation and then if it failed it would steal from the
global rsv, which is racey because it's outside of the normal ticketing
code.

Fix this by setting ticket->steal if we are BTRFS_RESERVE_FLUSH_EVICT,
and then make the priority flushing path do the steal for us.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c      | 15 ++++++---------
 fs/btrfs/space-info.c | 16 +++++++++++++---
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 904b7bb8e2b1..67c7107a79a5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5521,7 +5521,6 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
 							struct btrfs_block_rsv *rsv)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	struct btrfs_trans_handle *trans;
 	u64 delayed_refs_extra = btrfs_calc_insert_metadata_size(fs_info, 1);
 	int ret;
@@ -5536,18 +5535,16 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
 	 * above.  We reserve our extra bit here because we generate a ton of
 	 * delayed refs activity by truncating.
 	 *
-	 * If we cannot make our reservation we'll attempt to steal from the
-	 * global reserve, because we really want to be able to free up space.
+	 * BTRFS_RESERVE_FLUSH_EVICT will steal from the global_rsv if it can,
+	 * if we fail to make this reservation we can re-try without the
+	 * delayed_refs_extra so we can make some forward progress.
 	 */
 	ret = btrfs_block_rsv_refill(root, rsv, rsv->size + delayed_refs_extra,
 				     BTRFS_RESERVE_FLUSH_EVICT);
 	if (ret) {
-		/*
-		 * Try to steal from the global reserve if there is space for
-		 * it.
-		 */
-		if (btrfs_check_space_for_delayed_refs(fs_info) ||
-		    btrfs_block_rsv_migrate(global_rsv, rsv, rsv->size, 0)) {
+		ret = btrfs_block_rsv_refill(root, rsv, rsv->size,
+					     BTRFS_RESERVE_FLUSH_EVICT);
+		if (ret) {
 			btrfs_warn(fs_info,
 				   "could not allocate space for delete; will truncate on mount");
 			return ERR_PTR(-ENOSPC);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6498e79d4c9b..f72d70051f5b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1284,13 +1284,17 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 		}
 	}
 
+	/* Attempt to steal from the global rsv if we can. */
+	if (!steal_from_global_rsv(fs_info, space_info, ticket)) {
+		ticket->error = -ENOSPC;
+		remove_ticket(space_info, ticket);
+	}
+
 	/*
 	 * We must run try_granting_tickets here because we could be a large
 	 * ticket in front of a smaller ticket that can now be satisfied with
 	 * the available space.
 	 */
-	ticket->error = -ENOSPC;
-	remove_ticket(space_info, ticket);
 	btrfs_try_granting_tickets(fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
@@ -1444,6 +1448,12 @@ static inline void maybe_clamp_preempt(struct btrfs_fs_info *fs_info,
 		space_info->clamp = min(space_info->clamp + 1, 8);
 }
 
+static inline bool can_steal(enum btrfs_reserve_flush_enum flush)
+{
+	return (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
+		flush == BTRFS_RESERVE_FLUSH_EVICT);
+}
+
 /**
  * Try to reserve bytes from the block_rsv's space
  *
@@ -1517,7 +1527,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ticket.error = 0;
 		space_info->reclaim_size += ticket.bytes;
 		init_waitqueue_head(&ticket.wait);
-		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
+		ticket.steal = can_steal(flush);
 		if (trace_btrfs_reserve_ticket_enabled())
 			start_ns = ktime_get_ns();
 
-- 
2.26.3

