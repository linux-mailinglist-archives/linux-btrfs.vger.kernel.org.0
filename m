Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9392172AE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgGGPm7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:42:58 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA47C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:42:58 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x62so32069595qtd.3
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G701bsI8IliaVfeT9eLjM7iHLcC7Fvjl92brNTxJI4s=;
        b=iv5kMzQs86E40i/JvIrGQWiMFUP7iUfhbMC8jB4lfCanihaW2FA4zR84VZH/T46QIO
         22Z5X8rNCpICJgnbM+oi9bLMEWl32nmcQr+ZpVN9gyg+otx2egfg1l5vS9dsrDjThtz6
         oxzzW2ev7XoeDkz+KAZjJy5V7VC9dBoduquBEodzejmWDls8u5k/A6d54j50gzuPVnYA
         VpuujOTlH4ro9rGLx/vpx9e5fkEp82ZPw+9NSc4aMHYQIj/QfCku81sxZn1uPIvhNaaI
         fyXcxOJR6qJUCYA/vHFzfQIhLd3jvdqPoCofFdzM1eRqQ+mbl33d37cDmOMGniB4PjII
         LKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G701bsI8IliaVfeT9eLjM7iHLcC7Fvjl92brNTxJI4s=;
        b=fcLcCYzoP0WzAOIww3ZmKnmYVJkbISkDd4wtopvFYc/xyLFxhjVwHWJZ9L/WmnJet6
         iHTA488JO5RPfg7Nc0nvan9ZcQLtPyWiwPf5q41+QhZ7BajQqPDBaA+LrWmvYSNAhqWQ
         gek4otx5x95DHuj1ylAPBuX5y4DZvI0WRgZgu6QXcnTiLK9Mh/NRfLEM6tfbxE0cDW+W
         5H8RhHqX0YXIikUgmzzRkPS13Jwfj8CwXvcMTlr1VJhiWWTIL0i1xzHUz2+CyTf+bBcL
         kAHM3jtbXYwjW1bvZc7itYaNfgXhHktDLKFNUNU3jnTS85GpdZTNCmHfcHduxepBTqCa
         to8Q==
X-Gm-Message-State: AOAM53373DuATqDxGcrHtJz/URuFHJs8fISgikEOS1m7Klriuw22GeGR
        4ajLianOdE/Y5sW14E8YJ31/i120YrOZVg==
X-Google-Smtp-Source: ABdhPJwJHe96ah9j0Hk8NTELcYnJvWWhntJzdI2I8oEUcdOybKWMrx3rWmJj2xei2CFkaBkcH+COfg==
X-Received: by 2002:ac8:53c1:: with SMTP id c1mr55815861qtq.193.1594136577630;
        Tue, 07 Jul 2020 08:42:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x34sm2071940qth.62.2020.07.07.08.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:42:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/23] btrfs: make shrink_delalloc take space_info as an arg
Date:   Tue,  7 Jul 2020 11:42:27 -0400
Message-Id: <20200707154246.52844-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently shrink_delalloc just looks up the metadata space info, but
this won't work if we're trying to reclaim space for data chunks.  We
get the right space_info we want passed into flush_space, so simply pass
that along to shrink_delalloc.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index c2a2326f9a79..dda0e9ec68e3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -516,10 +516,10 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
 /*
  * shrink metadata reservation for delalloc
  */
-static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    bool wait_ordered)
+static void shrink_delalloc(struct btrfs_fs_info *fs_info,
+			    struct btrfs_space_info *space_info,
+			    u64 to_reclaim, bool wait_ordered)
 {
-	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
 	u64 dio_bytes;
@@ -545,7 +545,6 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	}
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
-	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 
 	delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
@@ -753,7 +752,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes,
+		shrink_delalloc(fs_info, space_info, num_bytes,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

