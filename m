Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969BA43E919
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhJ1TxI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 15:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhJ1TxH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 15:53:07 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BB4C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 12:50:39 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id k29so4834235qve.6
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=igpfqCDTRAaJ5T6CAE357sI8t2Pmg/YUZTLox5AOsU8=;
        b=0WzLKhXV+ucihkY5I8Y+SzJcsQ+qCdOUP6koMpbhZ8P/l4xdlHDF9Z8mlNpg4Z/yiR
         s4V3ks5bweZV83WU2akYaNuj/XHiIFVfdNh7EqgICGdhfOXt2qFoMWj6m0/saT/cZfZo
         ebVI3dImbvbkeVBW1r/HJEaPltDfBMpPNpX0QWetHwXaTth4mDT9T3IouZ2V5Rf9ZaEE
         ytzYZAdSVe1eoag6iCNLOLBcf2HSBEA09DUwFJyxTT5PcSJOwZX2J3BWt7Qm+JIC5CRu
         Wc49KfhGsCV88/KjMDhD6kFMEcoZyipuipzr5wN0zGV+RTwMV1kr+PVF7cVGGJpmihAz
         cTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=igpfqCDTRAaJ5T6CAE357sI8t2Pmg/YUZTLox5AOsU8=;
        b=MxTW8nfHlWzngSne3K/srSlm8vCIjZo4kB5KND65MkClARhMqxGiafbd2guu7TRSbz
         I2ZK7jN48X2lvs0YF0GWN87lGCbaIlgf1hJZzWkPkVsPwTQurozK+kd4IVpW1GEc+L0y
         xIYaMGQnr/RGxc6PqvPKRAnFCMsMiNeRcge4v8m/6IH09g16W58DJopQu5A/5Q3E/xVt
         C6rcnzZnQg/ut1KTVSe4so8rg9JAc/yLffs+Y3w8zDE+4Qo7Aig+lxSyeAnQPCU4jlAt
         pLbKYOrtCdeIXFlzEJ8WDr2DFruUGK3MAxyU/yuLeO4rnDj2xIalpMvyUvAN1tAPsbVc
         xhhA==
X-Gm-Message-State: AOAM533yJY86NKlV7LocSYD4dAmMb6m7FIrkxQE4CWph30kvyuhehYD7
        4sBCYi6tcSU68GyVD3kr3Mzm8Uudh1/Mgg==
X-Google-Smtp-Source: ABdhPJzMWrE24Qx4jogRyRmt0iQiIVAgybDNjtqVoAVYpXneQbi6Qgk9coDjtdhlm4lu+M1/xw837A==
X-Received: by 2002:a05:6214:5002:: with SMTP id jo2mr6218775qvb.27.1635450638634;
        Thu, 28 Oct 2021 12:50:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t21sm2706270qta.93.2021.10.28.12.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 12:50:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/4] btrfs: make BTRFS_RESERVE_FLUSH_EVICT use the global rsv stealing code
Date:   Thu, 28 Oct 2021 15:50:33 -0400
Message-Id: <81163a975df807763a5526e2aaa7bf8248e8d981.1635450288.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1635450288.git.josef@toxicpanda.com>
References: <cover.1635450288.git.josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 24 +++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5fec009fbe63..c783a3e434b9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5523,7 +5523,6 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
 							struct btrfs_block_rsv *rsv)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	struct btrfs_trans_handle *trans;
 	u64 delayed_refs_extra = btrfs_calc_insert_metadata_size(fs_info, 1);
 	int ret;
@@ -5538,18 +5537,16 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
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
index 48d77f360a24..c548d34aed28 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1380,6 +1380,22 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 
 	spin_lock(&space_info->lock);
 	ret = ticket->error;
+
+	/*
+	 * If we can steal from the block rsv and we don't have an error and we
+	 * didn't make our reservation then go ahead and try to steal our
+	 * reservation.
+	 */
+	if (ticket->steal && !ret && ticket->bytes) {
+		/*
+		 * If we succeed we need to run btrfs_try_granting_tickets() for
+		 * the same reason as described below.
+		 */
+		if (steal_from_global_rsv(fs_info, space_info, ticket))
+			btrfs_try_granting_tickets(fs_info, space_info);
+	}
+
+
 	if (ticket->bytes || ticket->error) {
 		/*
 		 * We were a priority ticket, so we need to delete ourselves
@@ -1438,6 +1454,12 @@ static inline void maybe_clamp_preempt(struct btrfs_fs_info *fs_info,
 		space_info->clamp = min(space_info->clamp + 1, 8);
 }
 
+static inline bool is_steal_flush_state(enum btrfs_reserve_flush_enum flush)
+{
+	return (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
+		flush == BTRFS_RESERVE_FLUSH_EVICT);
+}
+
 /**
  * Try to reserve bytes from the block_rsv's space
  *
@@ -1511,7 +1533,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ticket.error = 0;
 		space_info->reclaim_size += ticket.bytes;
 		init_waitqueue_head(&ticket.wait);
-		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
+		ticket.steal = is_steal_flush_state(flush);
 		if (trace_btrfs_reserve_ticket_enabled())
 			start_ns = ktime_get_ns();
 
-- 
2.26.3

