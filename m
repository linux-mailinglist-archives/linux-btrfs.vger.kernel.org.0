Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083EF20F682
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388220AbgF3N7f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388159AbgF3N7e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:34 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A3EC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:34 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so15595313qtv.8
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G701bsI8IliaVfeT9eLjM7iHLcC7Fvjl92brNTxJI4s=;
        b=BLrsBDt9z6R8jN1SBp+dORIjca8JDkxrkhExpWaqgyUj8PydNbHhA33lTubFNwE7XI
         y6SLwNeEGxz2kR0+HKyEwrGSql/+4l+hJYqXuFHaqTsf5x1QdhSqwWCOMB8K0vynRDjw
         tA9GhVb6LAqZWoKEiQUgYG1OU3zTdpPj+59sbRLKHGOfLYOuP1yG3XeJIFTBsCIWPLxc
         huRYvOL0gLn467iXoa1JD5eaSzaSH1suW46kCfsVcq/qN8DIGafjiCwX4CCbf+1z74ga
         X9PmyHhun6T+iQHudWI1YySpqPJ5zKH9HcBq8HZjRojUR1Ya3LH01TrtdLsJH0LWzlkc
         4fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G701bsI8IliaVfeT9eLjM7iHLcC7Fvjl92brNTxJI4s=;
        b=iZYtypE/15TmXXxe/pXjgpCnxfeC8Dc5hU5CHVCqUOhVDlGSF0fLJndPfDNWsw+G7R
         R8pIiQcU5JHqdfIKbkSMQsi/qsUx4hQaRq8WUEkurbyPU5WRL+cdvLbRMLUhyC+XtDui
         eggx9KUKBc0cA5SfTBrz8yXqoErWuc0pZMzNJB8Qk7UXUnrA19vOrcMzL8niHxXMcp9l
         QJkGXDCq4D9sujgq0uH35c6+P6EzFlfykpkgbiyZ0JPJbmRDzmcXD/KEcR2FYVUtkHUN
         QMaVK8vv97F1lgs+KfY+xJxyhfOvbjNoCS45SbCkHShlHh8wL7Z6PtQh7AlKyVL1lS1w
         /rmA==
X-Gm-Message-State: AOAM531307+LlY4BoZsMxyzJAgQpbqpv1Ox2x3i4rcYJ5/i/YfUGvYSX
        Q/7GI5+DVfILq6oiFkICBUxxdtYOQCwTqw==
X-Google-Smtp-Source: ABdhPJzBbsrxGaDh34KVRo96fRU480LgocJb85PWxm2WDJtiqsWuDSR2z1TJhSr214lJylDNnEgBYQ==
X-Received: by 2002:aed:3e2e:: with SMTP id l43mr21001410qtf.287.1593525573241;
        Tue, 30 Jun 2020 06:59:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c27sm2853402qkl.125.2020.06.30.06.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/23] btrfs: make shrink_delalloc take space_info as an arg
Date:   Tue, 30 Jun 2020 09:59:02 -0400
Message-Id: <20200630135921.745612-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
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

