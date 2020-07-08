Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6652189A5
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgGHOA0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgGHOAZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9437C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b185so30958435qkg.1
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUsScBbpNuEa/GRgx27yvwOsrj7ecK3MJGcmAjuWUPo=;
        b=ChDc4FIFV79Irl73yq7dFllQS1sAUdS6Igp+oeIFzKaAB10rShC5T3odjbs2R8SEcS
         zJEvXuAR/EwrUfBS5tAqDQYaw6fTGWotQniwpiLvgWU/5lZbwEq8eAG/q0pAri+/0Ref
         siZ8zWqGiZGsV+ivhx7xCBpuqXL7A8XwcAN4TcBz/DoFWACKNglr2MFmWoy+cY4flD+I
         0Vbvp+9BnLUkNQrRbOoJdJQRD4iTS5A0tkxNlNR0QXsvQ08Y+qBpUGi8Uso6juVbyKY3
         ++dcHdzE78TZ3+h+e17AdZgnOtnjk2ECiiShY+Gu0sEoIKRX89ZhLRJ0LKupbPgn/M+P
         7f9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUsScBbpNuEa/GRgx27yvwOsrj7ecK3MJGcmAjuWUPo=;
        b=DEJEOllHXXMXgBYkD1HHy+I5DvJXXW/i52+IRrW21v0/lHcne3cqFCEOHF4Sy1A1Nu
         8gkN5tB3HxGtNW5DQ9BiJRkBoTjgFOqCyosjva/Gqglrwp6FNG5iTgpMS/ZJRKEPo1QJ
         SIg9oa0q1mBCWG4hp1lvR3J3KXGHWsjwRlibFrXrOqzj2v51RV92RtdsdEKckmhF4No7
         vtBCk5Fxfgbfvfb72dalAcVoFt9Cds2SujN7FOAj+eyexgFtUt5YSBKo5jokHMprtYzo
         DCWUNlgWDJRhG82Ydo+bE2AqAEa/JPFUlpO+IPkGjglV/lcB7FtoKGzXvJljO9y4tmFD
         xxrw==
X-Gm-Message-State: AOAM532lo7WD+TJ8xuilyXh1Z9t3SNRJRLSc75mFNLVChyRsX2cw16UI
        bdq+TNGvhxf/QkXVxJ9hrL2JdPQ9dxbd6w==
X-Google-Smtp-Source: ABdhPJwCUuR/kwgw3Y9a4ESjXstRaI/MA7w1YeV4Rq10YtQyIZbRdWGPNuivIxMoG3iwxNGxjEzU3g==
X-Received: by 2002:a37:5bc6:: with SMTP id p189mr56119952qkb.112.1594216824601;
        Wed, 08 Jul 2020 07:00:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s52sm29866172qtj.52.2020.07.08.07.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:24 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/23] btrfs: make shrink_delalloc take space_info as an arg
Date:   Wed,  8 Jul 2020 09:59:54 -0400
Message-Id: <20200708140013.56994-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
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
index 78ad8f01785c..1bf40328b0ee 100644
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

