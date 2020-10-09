Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BCD2889C7
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbgJIN2q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgJIN2p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:45 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484B8C0613D5
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:44 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b10so2513139qvf.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OeDbdP/tIxPai6xbCAP/bUyJD8V7RTa9uH5tUYyYHv0=;
        b=tX8ykBbyGGAzv7lCFzSBTWAXwaNxCpuq02vrdDEt27rIvGy0kdBIuqCNdcuNs0+E6m
         jgDaZfSf1OWSLiB7d8SvnL+mm738NyFeKuh67RiSfao/J5kdCRIOeU4BIgYwBeuwHjxH
         MkIE0T3LT/GZrAJ1NybXCrXryUyzlVOUCR5aGTruMe1222iQ+dtmrE+KMxbgjWGMsrPr
         /eG94bcnp1RZCwPl3cuOCUvt9gBvQCt5Aaud5BWXZt1DZC2t77iYXwvuikmogZ9wu5QF
         kufucmot0+I5yiUDm6XmO7ClTj1n7XKP4usFDk4JpOnNWgj9XDyKgGVrsolcLffKV3OJ
         rm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OeDbdP/tIxPai6xbCAP/bUyJD8V7RTa9uH5tUYyYHv0=;
        b=smARDRqJ8fkNqxRJ182jND0sPjF64oOd6f+aw1Mu4dqV9JNC9g+wljSk0ir9fU3Voe
         RqOasRw+O4bzhrGUmAjVwTiQ9fnCKKW37TcJivcFAjfzMn3UBM07K+PX7PvByJQuhxUJ
         YI1BAIWN62NmugZdT+T8t5353vqz+ISMobVQhzpSjUWZEuN+YpiwARwQUVqFZN30AMpu
         5ZikXvsfL3fN8ovdo5zMP9BJS3DANhmg3GRMOyZH2s344ucHFSS6P53D1ekU2uWbTfBq
         GGaswz4LXRVHdOTeYfVjR8Sp+xisZxh5QSprk80UUG4hT4lspp1GnvqB7Y9492Aw+NVV
         WZVw==
X-Gm-Message-State: AOAM5311RdOBZ2JB6PbZvQ63G5lUdL8F1/y+8JL2teCo7lFRYSdVOe2N
        cnHga/ap26L+cygwKdzTOm85xOxKHaHWLGK8
X-Google-Smtp-Source: ABdhPJyknKotXWUMDDlCMmlvNZyd3ASrV3ccZMdaLs0CnORKd1UpVA+VQGTyZiamSZ8513Uw4Qt/ig==
X-Received: by 2002:a0c:9789:: with SMTP id l9mr13557387qvd.2.1602250123065;
        Fri, 09 Oct 2020 06:28:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i62sm6302024qkf.36.2020.10.09.06.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 06/12] btrfs: rename need_do_async_reclaim
Date:   Fri,  9 Oct 2020 09:28:23 -0400
Message-Id: <d998cbf6d167d16ca51adea2fb631d36793a0a6f.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All of our normal flushing is asynchronous reclaim, so this helper is
poorly named.  This is more checking if we need to preemptively flush
space, so rename it to need_preemptive_reclaim.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0f84bee57c29..f37ead28bd05 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -799,9 +799,9 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 	return to_reclaim;
 }
 
-static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
-					struct btrfs_space_info *space_info,
-					u64 used)
+static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
+					   struct btrfs_space_info *space_info,
+					   u64 used)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
 
@@ -1019,7 +1019,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 
 	spin_lock(&space_info->lock);
 	used = btrfs_space_info_used(space_info, true);
-	while (need_do_async_reclaim(fs_info, space_info, used)) {
+	while (need_preemptive_reclaim(fs_info, space_info, used)) {
 		enum btrfs_flush_state flush;
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
@@ -1496,7 +1496,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		 * the async reclaim as we will panic.
 		 */
 		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
-		    need_do_async_reclaim(fs_info, space_info, used) &&
+		    need_preemptive_reclaim(fs_info, space_info, used) &&
 		    !work_busy(&fs_info->preempt_reclaim_work)) {
 			trace_btrfs_trigger_flush(fs_info, space_info->flags,
 						  orig_bytes, flush, "preempt");
-- 
2.26.2

