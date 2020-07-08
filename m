Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB72189A4
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgGHOAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgGHOAY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA777C08C5CE
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:23 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so34521115qtg.4
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tlhyn6Io+XWJV27UN298PnUC9Kg6hHIiKF1O0jj30xw=;
        b=SmN99C2nabPjvJiRco+1Us9kEeHohZM4xOh/K6jCMCrcxMc7VUOV6NGiFMi1bgTFC2
         dsqRR1CrKI3I0E4i0S16NVBLR/kjxK19I2JTjQ76tmLDYcaamnGnTZ0j1PjcFfol0EO9
         MFjS4WqMk1VkRkCj7DfGkO99T18tRIp3RDfgB664LM3FTDGVlNVpKeh1lgLRtL9LKJcU
         5xhzSVj3bK0cmQ5pymafNJIXC/SOZr3gLKrNp0+6EZE0247VVp2iLt+Lk1vb6Pvl7+/T
         7fswVOaDDUX4cWuVY9821xu49qQMzVvvLzKUxK8w78uWS+/4tHlPXBaxaxY2Z7XAx90d
         7yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlhyn6Io+XWJV27UN298PnUC9Kg6hHIiKF1O0jj30xw=;
        b=byteDEo0Uu9fhR3BzumxLaPfQPp2YLazGrlD/Ktkn/YE2Qjo3E5OY+ompky3AZBunh
         rmQlUlxMsheM4RxN62YQFsQl+Y+O0W9a498arz/qyg/iRdsXSshuY96AhEXW5Yj3PmgD
         vy0AiJyfOrA+/kavuiqTYPfjUrak1NxK6UrFYJ0BcfGarxoEXcHZ3s0OeDTGRV+jsw0U
         a+gNMjK/NB3XkCuzqwDcPqQnHg6CF5n2V0fQNqJoW7U4R6R9GhnUnemvGYEcObyu23W5
         Mv0x52fDqGT1eBlfrjN2oT/rCA454Yy1giUY5Ol4wgfSSGZORFEijE8U/NgDYmZzXnBx
         04hQ==
X-Gm-Message-State: AOAM533wKqiJRHpEMGvZRCYkU3RB4Be1BHEvRarfQwfEXcKcpSHjmYqx
        gRZuqQGv/OJSfDqy9ylSPwxwoj6+T5QgaQ==
X-Google-Smtp-Source: ABdhPJy8UWGzlDr8OjZgHlCDuwS6ad0f39SjQlBy9YwKEf93ZuEOF1B82m4ge6YZ+1ECofgWuzSK1Q==
X-Received: by 2002:ac8:4b4f:: with SMTP id e15mr62611366qts.305.1594216822674;
        Wed, 08 Jul 2020 07:00:22 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f4sm29254230qtv.59.2020.07.08.07.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/23] btrfs: handle U64_MAX for shrink_delalloc
Date:   Wed,  8 Jul 2020 09:59:53 -0400
Message-Id: <20200708140013.56994-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
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
index 10cae5b55235..78ad8f01785c 100644
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

