Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57DF449810
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 16:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbhKHPYV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 10:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbhKHPYT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 10:24:19 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F6C061714
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 07:21:35 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id bm28so15749342qkb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 07:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9+fVuquQJIxuP7iDXMsIhwbHWIdY5asPN0cP3uQALAM=;
        b=5VlXZhR6gqGEFsqqB1xd5omT0jRDOgJkzPSYLwoS0rx+xNtL8XDcjF3CDd4MUnLA67
         U6Ud/EhCWOmUT9B2CXKn6sQMGyAOoV8lz27WgtHBFyapv7PrmhYcn/GGnWNq0dn1NM76
         OtvTzDcpmc4XoEZTQ6kpFPy8hV6UMwxK7HzbfCdHFOGvAR7oQ4ad5/+qAaj7VOw4R/V5
         XaK8Vk+v8Nraj5njiK2VoRO9fxzVPUeNKVpKfspaWqqX6Ms5fIWeC9Zmz56HchxReYUs
         bATszchjTTeBnFnrOXvDggLid256RMu6KncQUgXEa35+xfCQCfrqnSQ/h+bz1MwLVV3A
         RaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+fVuquQJIxuP7iDXMsIhwbHWIdY5asPN0cP3uQALAM=;
        b=mmGU5ptrguPcvoWovO6KR3fLBk1gIG7r7pApuaZz5J5oKLXvFMFv+NcPkykfZwmJLx
         Xjqewqp7THfsYT7/m5b+TT/v32iQ5KpO1aM/Z6MF6tI/cYiMHH3v3S+JbN0VUQGXLC2j
         fKeE78+y9Gss/bEeI9RlFi5efgRJN/nwO8Md7kpUBtt6aIdL16F037Ow4LBuZj8rjj18
         7lCzNk/OeSvkeoHuJOjxfMWS042hmkItU0CKaTO50edBHFFuqaUqoQaLoHVmexq4fUGK
         iS5sLZsopyTI9Zbjo0vqaEA7v458HkQOjA42TfgPdAvIbSVt66D1Sf/UV4XFxj6yqSqo
         eCQA==
X-Gm-Message-State: AOAM533Pyt8sW6SL8+GcYe2ZBOzqbHFyksG/Lv9GqHoJznVjCe0hP8JD
        wtPO8BuWw7sc2mpq+ETRZWlTfhLAWMF6JA==
X-Google-Smtp-Source: ABdhPJwHJlQ1KOAhHUHbfWPGGhXi2XLrIUhzSFr7IxBjdTYKZIN3VQx4kZCiELiHA1XjworyAFTRoA==
X-Received: by 2002:a05:620a:bca:: with SMTP id s10mr298153qki.416.1636384893976;
        Mon, 08 Nov 2021 07:21:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v18sm4974186qta.56.2021.11.08.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:21:33 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/4] btrfs: make BTRFS_RESERVE_FLUSH_EVICT use the global rsv stealing code
Date:   Mon,  8 Nov 2021 10:21:27 -0500
Message-Id: <e8c55597616b1e34eb15934ea7df6d26e7278589.1636384774.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636384774.git.josef@toxicpanda.com>
References: <cover.1636384774.git.josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 25 ++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 12 deletions(-)

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
index 48d77f360a24..00bbcf9bec40 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1268,10 +1268,10 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 		spin_unlock(&space_info->lock);
 		return;
 	}
-	spin_unlock(&space_info->lock);
 
 	flush_state = 0;
 	do {
+		spin_unlock(&space_info->lock);
 		flush_space(fs_info, space_info, to_reclaim, states[flush_state],
 			    false);
 		flush_state++;
@@ -1280,8 +1280,21 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 			spin_unlock(&space_info->lock);
 			return;
 		}
-		spin_unlock(&space_info->lock);
 	} while (flush_state < states_nr);
+
+	/*
+	 * If we can steal from the block rsv and we didn't make our reservation
+	 * then go ahead and try to steal our reservation.
+	 */
+	if (ticket->bytes && ticket->steal) {
+		/*
+		 * If we succeed we need to run btrfs_try_granting_tickets() for
+		 * the same reason as described in handle_reserve_ticket.
+		 */
+		if (steal_from_global_rsv(fs_info, space_info, ticket))
+			btrfs_try_granting_tickets(fs_info, space_info);
+	}
+	spin_unlock(&space_info->lock);
 }
 
 static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
@@ -1438,6 +1451,12 @@ static inline void maybe_clamp_preempt(struct btrfs_fs_info *fs_info,
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
@@ -1511,7 +1530,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ticket.error = 0;
 		space_info->reclaim_size += ticket.bytes;
 		init_waitqueue_head(&ticket.wait);
-		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
+		ticket.steal = can_steal(flush);
 		if (trace_btrfs_reserve_ticket_enabled())
 			start_ns = ktime_get_ns();
 
-- 
2.26.3

