Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9081820F681
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbgF3N7d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388159AbgF3N7c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:32 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E80C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:31 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i3so15563745qtq.13
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8OvljpuILSWk6dPIuW+DVZm/J9jdzzmI+Wl8q8HkOY=;
        b=Qc1pQgOWhtkPeFHuaOLmoHDDxxx1hCLLOC0QenFJhmcxSiULhbnVyz6pua8zpD7HHh
         6a8HbkJ8isjBjbPUUKCAy9AxqXvNirGZUHjf/AQiVUjwvV+T8Rb2JdYCDDtcBGYzQMKg
         ua5Z1+Xg0F3ruWdXiMkV8/BPNRKYrN6RV43E96rU/Mo5/wbsYa5wkZm20XvuHzsNqo7U
         47maVFT+P4YiXwJPV4Ht8MViEyXxD7eFfc71WmFb3d8KeIszTH9LQS1BuY+0u40n51Sd
         ipdfqe9jk5c6RX+ozJ0RmnuVEXoyu/+E1GXZBuYs0R2lwR/WQWKgZbMVd700XTrqYwau
         UkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8OvljpuILSWk6dPIuW+DVZm/J9jdzzmI+Wl8q8HkOY=;
        b=Lu/mcbM7kMXFISMpxrHkKjXWRqNrtcTF8RSe8WLdC3qINPvf6ZMeBSrSsg7UJ8Nda2
         Lz5b7l7++A8u3DEfS7IM6bebdyJ31r8dTSie3Vq0qoHe1OIcxkFh1S/XnA1HafBvcAKj
         f9j5r2j7fwmI+djkujRGxUhP3mjZfeLWwXW1Cy4B9lMgyHWs6V9JI9zcVqQ3mdIGKcb2
         XVs/SziJGpKi50+X55Z0kcmwz9MyVoyy/s9Hd+SsOaPYNsBGnRAbSCBO5Ymo8plMsz6V
         vlxii3F4omleE63Pr09nEYlygvxAAhMHF/sfRIDTVdJOYOy6vpgrGktQPuSsOHlGY5oG
         nznA==
X-Gm-Message-State: AOAM533Qr0AuGRqN7E4+DPvywpP9Sifnk0CTPd3fdxVMOwvfBvP3ZYg7
        0cWgOgiDWKq1RbI3yXomiSM/fxfOjuQJVQ==
X-Google-Smtp-Source: ABdhPJwgQrKcB8wJiece15D7cYIrNFeaz3fD32eTXYrrQlVHS1liJ66uEVpHhSq7s8c+jjNz15DKtQ==
X-Received: by 2002:ac8:260b:: with SMTP id u11mr21184884qtu.380.1593525570676;
        Tue, 30 Jun 2020 06:59:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i22sm2837074qki.4.2020.06.30.06.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/23] btrfs: handle U64_MAX for shrink_delalloc
Date:   Tue, 30 Jun 2020 09:59:01 -0400
Message-Id: <20200630135921.745612-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Data allocations are going to want to pass in U64_MAX for flushing
space, adjust shrink_delalloc to handle this properly.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 266b9887fda4..c2a2326f9a79 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -530,8 +530,19 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	int loops;
 
 	/* Calc the number of the pages we need flush for space reservation */
-	items = calc_reclaim_items_nr(fs_info, to_reclaim);
-	to_reclaim = items * EXTENT_SIZE_PER_ITEM;
+	if (to_reclaim == U64_MAX) {
+		items = U64_MAX;
+	} else {
+		/*
+		 * to_reclaim is set to however much metadata we need to
+		 * reclaim, but reclaiming that much data doesn't really track
+		 * exactly, so increase the amount to reclaim by 2x in order to
+		 * make sure we're flushing enough delalloc to hopefully reclaim
+		 * some metadata reservations.
+		 */
+		items = calc_reclaim_items_nr(fs_info, to_reclaim) * 2;
+		to_reclaim = items * EXTENT_SIZE_PER_ITEM;
+	}
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
@@ -742,7 +753,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2,
+		shrink_delalloc(fs_info, num_bytes,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

