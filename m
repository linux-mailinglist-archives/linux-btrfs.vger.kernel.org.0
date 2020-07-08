Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95CF62189B4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgGHOAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgGHOAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CE4C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:54 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i3so34500159qtq.13
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sdzRsWOXAGvB73dIlXqZ3dGxDme3VsWQ5fDO5h3OlXQ=;
        b=bVyVtMZsTU6AuejjaQNhXDcnvf1kWfl9zRgK36ILS/nfwORGM9YcWoXU1Y6C7LlXKQ
         QbRCBtvRyiAgh6c0xYSIvqLHD+Ac74qQNgmd0iqMnYBXoWjEuivU8g5xl6ImzfCYf8Q2
         QIJmRV+NzwtycF8KbrTo6V9/MaP6c70eMrOoxvQuDGVGZCqkMY7DF+/HlQZ7VhkA97/H
         erRhZYVHp75OtfFuCkECWrpYjn5wb/6dSoHgMX80mqtdVOVlCqB2yruRN5KGC2OOT92K
         YeI2lDsbaU4jsSPrYh6d2W4uN8QqLQEtUwOtEZC0jzemdUTtK7kLi602meSaWjdoHHD5
         2KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdzRsWOXAGvB73dIlXqZ3dGxDme3VsWQ5fDO5h3OlXQ=;
        b=Cyc4w9LWyaKQvT8GbzHoWenDYBGOlMHhnAjTvBaHHDXRMXGosnHeYhnVgctQmKuqaH
         Azn777y+qvQsb/SWkt9E/eMrfTfp60uag/jrsyZ5mybevhzypTt+1bH+eApyG2P1NDdD
         +NuXgXK1gE77oyp0EsO4HDhegC72kJvKTAlU27dEysTW4nBdmMqs9VS5oI+iVm00klvk
         RylZwetJAMB7+6Jdj2fHqsoDya3N7hKQhZKtss+bnEuAIVxjYgQ3+KUbKIA7iTSuYDy5
         OHSdMEnWHYhqvUp/JOeI9VCp8mNXQiH0EydJrOvD5OVGUBAP6i34GFYbDPFwnH8+rBfL
         2oJg==
X-Gm-Message-State: AOAM533WkV5LA+DOtEz2VVXOjRCtXpnTAreSgii2st6yyTvQFJrV7m5/
        4xSBMhXfws21+uLzzWK8WNCfhOvTDl9W+g==
X-Google-Smtp-Source: ABdhPJxnHQ+tjev3fVQnTM5pgN7IhZKFgFh0Y96KdfyHas9tdLkoA6AKTQXR24nHz+ySHdTkaBRpxQ==
X-Received: by 2002:ac8:2928:: with SMTP id y37mr61026724qty.245.1594216853633;
        Wed, 08 Jul 2020 07:00:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o20sm31783371qtk.56.2020.07.08.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 17/23] btrfs: use the same helper for data and metadata reservations
Date:   Wed,  8 Jul 2020 10:00:07 -0400
Message-Id: <20200708140013.56994-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
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

