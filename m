Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F0B2172BC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgGGPnY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPnY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FB5C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b4so38491776qkn.11
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JkWrdQ70XFawvSa4oKhSlL1L1YJE6jcK1mafGy9eKn0=;
        b=UGxLZhWByk0yQP4rzXJNKLTVjRRCbQNOPIHhrk7+hm41N5irzWiNCfYvfgSobGLXxc
         jnLYqjMpUyCEbJLwo+Ko3Vpaz3Oc9IU+RKWEbt1hIwu2VKoirNUjvQ26hrCsWNvgfarl
         T9NbsVjkUt8NkxoYUU2jpATWcKcaZCzlG5HbXB0abFRJ7GEr1cKKL/ucO11m7f2S0P+F
         PmSdnEvbrWyWAZAcXcFIHogjg+NU6vUPl3aJdvuQORpyV8Jz4GnAk/4KP69Pm+6GUbfe
         hzXLPShwfMYrL5DDmGYe5/LGZWFDLpdmQ9EAaj5gd0iYjCsiZ0tmPfiZgrebmAi58xRc
         I2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkWrdQ70XFawvSa4oKhSlL1L1YJE6jcK1mafGy9eKn0=;
        b=jQEjJz0KVvMHruEGY2v9lc+pkQSe55uvuNMWe8+NdERqh2Rlm1o5m6R+xM6U6MzimD
         OdxPfo0WCpsHXHAv6qT4hZ7D3Crti7r8fHILVkxOkgsK1HZGgszLiQipubqoP/whDnKn
         KCHS+QxH9lztZYVS1edc8bGylVALLykCb/T+ShoxA5fZ2dgQVXIbwuhJNZrvFiAEjQqK
         nZmnMjwG4f0q8TeCW3na2nm+Vmb0ALiUBS/gaXz/f47MzXhaoSxKW28nOqh3NqGB8b2U
         l1aU5ChqC9+N/OlCWX0vG6VKgiqu6ETAcx+JLhqYlvTPuc4IbDGqsomC2sOnX98FKtKJ
         6E3g==
X-Gm-Message-State: AOAM531p0XcmAX6PnLWxkP2TakVOaSl/AkURATfxiT3upHYng0v8C4e+
        f9b4moaCw7U+HNVNPawzAoDXdsKb/gfowg==
X-Google-Smtp-Source: ABdhPJyEl3IJLDlVNRzFej0Ax7hVoyVt1ux5Fcv7rfkPf1HP/KRwGD9W4sOQsW62Gk/kF4i+47/wXA==
X-Received: by 2002:a37:7a42:: with SMTP id v63mr54081535qkc.258.1594136602753;
        Tue, 07 Jul 2020 08:43:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a6sm24045111qkd.69.2020.07.07.08.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 17/23] btrfs: use the same helper for data and metadata reservations
Date:   Tue,  7 Jul 2020 11:42:40 -0400
Message-Id: <20200707154246.52844-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
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
index abb57ab6bfc9..1e070cd485bc 100644
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

