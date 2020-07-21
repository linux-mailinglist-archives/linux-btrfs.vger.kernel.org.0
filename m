Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C702281FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgGUOXM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgGUOXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA1DC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d14so7660743qke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdzRsWOXAGvB73dIlXqZ3dGxDme3VsWQ5fDO5h3OlXQ=;
        b=s3xfW20Gqdx0bGjl7tquCpRX1hkX4EKV+fXvk4UhikVjFIy+pELPLTzxOgh3p7picx
         wTOeZDt21RuwHGHo3f+OBlik/NBsmIMQKExIrMD4gUZuPi7tFQW9UQ77Ccy3K/V7xqfn
         pCh7h9jXYfM9c3FEak0g2h1blGzA0ECoLJHbPZxGQMrdD2Na4dqKxXvYiiq0pbneY05v
         1tNe1W6Mku0EqDnVzgCxczrF+YCS41VlP2pAUIiUYGVOUPfQ33TTJBCxTVTiTZgYjdFo
         Ob3I70JRnnu9cWiJLxmHedN3KPh3KrFfZr/DklHesbOEcoiygquL7dbUqqnbPGeCAzBB
         0edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdzRsWOXAGvB73dIlXqZ3dGxDme3VsWQ5fDO5h3OlXQ=;
        b=SgGfEdZSPxGcUtWBWPhNzv594uv68LuSY6qR0eokWpCJwkSmDwnOHClnQPmD7pHv1+
         OhHKKl+Wbpdj0pgPlyvN8be0V603Xx4x6H+4KUoNHKXeiJwvrLno32tu64y+VUXRBCDx
         TYOedrb8vuCoAKwVtogaI4Rb65PHh285NV5AaUHr9fv0urhMaTxnBIlqORAaIWYzIMKK
         gcrDcKD5cgPKMV14nIsZsW8kWHFbjneYVLznXtHztmQM3wvXSkTuDh7UNwnu6z86AS2t
         rcgDiOG+dvvSzoDQ27j5rVp6Eiow5T3mdvcF+7d1O+dN00mOJ7Dk2wvCmlpR4KUMiKLz
         QiJQ==
X-Gm-Message-State: AOAM533i7g0c72lmqKUyD7Y8ytMo93wNxQU1z7CqMjbNIy5jWpLcV7jU
        mEUkcKxaY5tve4rx/Dg+++/OnCj0lhTNrg==
X-Google-Smtp-Source: ABdhPJzkClpU/HafqggYInl737MmTeROv8xlb7eh3fnbEVEZ/YxDxmhVfUnY/l78rZG0QLpPfDEGBw==
X-Received: by 2002:a37:9a06:: with SMTP id c6mr28513069qke.161.1595341390461;
        Tue, 21 Jul 2020 07:23:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x13sm21865571qts.57.2020.07.21.07.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:23:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 17/23] btrfs: use the same helper for data and metadata reservations
Date:   Tue, 21 Jul 2020 10:22:28 -0400
Message-Id: <20200721142234.2680-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that data reservations follow the same pattern as metadata
reservations we can simply rename __reserve_metadata_bytes to
__reserve_bytes and use that helper for data reservations.

Things to keep in mind, btrfs_can_overcommit() returns 0 for data,
because we can never overcommit.  We also will never pass in FLUSH_ALL
for data, so we'll simply be added to the priority list and go straight
into handle_reserve_ticket.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 49 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index afdc774cebe9..605be9f4fcac 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1252,10 +1252,9 @@ static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
  * regain reservations will be made and this will fail if there is not enough
  * space already.
  */
-static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
-				    struct btrfs_space_info *space_info,
-				    u64 orig_bytes,
-				    enum btrfs_reserve_flush_enum flush)
+static int __reserve_bytes(struct btrfs_fs_info *fs_info,
+			   struct btrfs_space_info *space_info, u64 orig_bytes,
+			   enum btrfs_reserve_flush_enum flush)
 {
 	struct reserve_ticket ticket;
 	u64 used;
@@ -1367,8 +1366,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	int ret;
 
-	ret = __reserve_metadata_bytes(fs_info, block_rsv->space_info,
-				       orig_bytes, flush);
+	ret = __reserve_bytes(fs_info, block_rsv->space_info, orig_bytes,
+			      flush);
 	if (ret == -ENOSPC &&
 	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
 		if (block_rsv != global_rsv &&
@@ -1400,38 +1399,18 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
-	u64 used;
-	int ret = -ENOSPC;
-	bool pending_tickets;
+	int ret;
 
+	ASSERT(flush == BTRFS_RESERVE_FLUSH_DATA ||
+	       flush == BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE);
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
-	spin_lock(&data_sinfo->lock);
-	used = btrfs_space_info_used(data_sinfo, true);
-	pending_tickets = !list_empty(&data_sinfo->tickets) ||
-		!list_empty(&data_sinfo->priority_tickets);
-
-	if (pending_tickets ||
-	    used + bytes > data_sinfo->total_bytes) {
-		struct reserve_ticket ticket;
-
-		init_waitqueue_head(&ticket.wait);
-		ticket.bytes = bytes;
-		ticket.error = 0;
-		list_add_tail(&ticket.list, &data_sinfo->priority_tickets);
-		data_sinfo->reclaim_size += bytes;
-		spin_unlock(&data_sinfo->lock);
-
-		ret = handle_reserve_ticket(fs_info, data_sinfo, &ticket,
-					    flush);
-	} else {
-		btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
-		ret = 0;
-		spin_unlock(&data_sinfo->lock);
-	}
-	if (ret)
-		trace_btrfs_space_reservation(fs_info,
-					      "space_info:enospc",
+	ret = __reserve_bytes(fs_info, data_sinfo, bytes, flush);
+	if (ret == -ENOSPC) {
+		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      data_sinfo->flags, bytes, 1);
+		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
+			btrfs_dump_space_info(fs_info, data_sinfo, bytes, 0);
+	}
 	return ret;
 }
-- 
2.24.1

