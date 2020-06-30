Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69FC20F699
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbgF3OAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388702AbgF3OAD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:00:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEBDC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:02 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id u17so15628103qtq.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hp9/XdwrBAg/OBpZpU0Fky59EByG1ziNL9v3oIP8KJo=;
        b=oIKQVJjUgcAhRwyUTKv9ph52Zletl7E1TQJOW0vEtcWqzzMFTyOK/+saMAY9yRy6fh
         Fe4yE3Wfcd8fWnZScvnqm430V00pvhVV2pHo6cMi550LGdU2RHzFKoyqBnWrmCcEjvTa
         a6f02hxtpo/ln/HGmsHEdUGsoMuNrxE1KPQZybpPbrIWeeunoI/95BDN39LMu6P0qiP7
         D+NXo8qgnZERVcS8lmu4smb2hPYPQNkbnV/BwdNqvdbhq2foAv51jjuv1Ym38B2y9xXN
         PfGT4qqLPLuHeDzcxkZlBiimCQU0/CtOL66NMQIKIGN78kIxIWiRh8ILoLK9nX+FPifs
         cfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hp9/XdwrBAg/OBpZpU0Fky59EByG1ziNL9v3oIP8KJo=;
        b=oTV9M+84tlm0A5qVlv1Y+XaHuCM+FeEY6Q2WeciQUj31zK3pcFBZ9UGOtp0k3L61gx
         TOqa5yOBK7IRV1+qv2i5LHwdT8Z3DxgpRI6g/mYBi9pPNNXoKBZDcUa30lfSiV4vVxfE
         bDfnFLtwL0sNDotWb6aED4iIW4Xsau36cuWz8OSKeRew2C6bBWhuIA0PhkR2QjaMFhxE
         WFw2LRqtfhhAQCvkzNTIYY/1rDLq446oaKcX1/Z75Unfo93gAs+p6EMyzj/5ymjSjIWI
         Ke36k4WIvFmJPuffxdirfsDF1rhBXXOzjRW4J4IK9Fef4YLdcfb/EW6AyLG2M2J0nSuz
         he1Q==
X-Gm-Message-State: AOAM531pkpD9tpvrXZyYaeomRPPbAR7YM3Bw/JLHgGbuOiCPwR70QGJN
        BODo/kUmtdoIVOav7Ud/JCNo2g0+1z3AKw==
X-Google-Smtp-Source: ABdhPJxT5zy0T4f9b56BEUXmqUkeRNwu/SsZOJjW49XataAu6hc+utGyUGZQhQoL/Xa2+tTiVUKotw==
X-Received: by 2002:ac8:110a:: with SMTP id c10mr21519430qtj.163.1593525601572;
        Tue, 30 Jun 2020 07:00:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z4sm3085538qkb.66.2020.06.30.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:00:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 17/23] btrfs: use the same helper for data and metadata reservations
Date:   Tue, 30 Jun 2020 09:59:15 -0400
Message-Id: <20200630135921.745612-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 48 +++++++++++++------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d9a6aefb3a9f..b5a007fab743 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1250,10 +1250,9 @@ static inline bool is_normal_flushing(enum btrfs_reserve_flush_enum flush)
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
@@ -1365,8 +1364,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	int ret;
 
-	ret = __reserve_metadata_bytes(fs_info, block_rsv->space_info,
-				       orig_bytes, flush);
+	ret = __reserve_bytes(fs_info, block_rsv->space_info, orig_bytes,
+			      flush);
 	if (ret == -ENOSPC &&
 	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
 		if (block_rsv != global_rsv &&
@@ -1398,37 +1397,18 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
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

