Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0523436DE87
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbhD1RlC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242744AbhD1Rjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:39:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3DC061573
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d12so9205600qtr.4
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qW1N7zEB+kpEjEKsVRxA1+eNSucsLWII2KirqoGlpPw=;
        b=RytIVD5jTepOB2igOAej1uDG9ieXMAoz0nryuF7W2AWaWaVC6ZkEgmuiT6+WQXnxqp
         T9Tuwc8OUAsUCo9YNA2jkGTAa6l2NE9F79cr+huKA1MZEm9UwlxjZ43UaPT82trSujFY
         7t2p2WNjuxDkqvXk/h5ITB/Kt91RnbrDGRsu3zmkkXBtS05WQrG3SJ2bPrkp0+XmCGTm
         2hLViBhSbcU8PAzAzzqtxY4INyV147ZHClJ6uIRz3FIWEVFd2Xi0mRndcM0/54U1DEHj
         0TmiMs9sZT7gxnMzyBX6tBZucfjdHlH4SAf9pDksxGkIaiTVHYSWUUlG6YQTRGjuCW87
         zipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qW1N7zEB+kpEjEKsVRxA1+eNSucsLWII2KirqoGlpPw=;
        b=co0qIMcxi3uPSMwQQ0qROBeSSyEj9dF1f8XT8OB+johfTunEbcHc4I18m2LLK+h8Kq
         3J+MAfCojtdBGR5qgoAeq786ZcK8/TzTDYWrbvrAiD5Riv85L4/F+h05YSo0nFmTE3Rs
         9yFG3U6739ISN/JaaFtnraH90BP03mh+Qe4fIHsbIGyaU8cDu+IubBMBb/CX7sZck5nI
         MU1KzKryfFBjGbeZwElRmHssXYoVRj+NDm6mvleUk1uPHQeTAtSVfVGUNyPBXTNQUHqQ
         LzJICccG8T0EWBb0IHAwvl/dTJ/KKcQloWx0TEa42gzC5cM9zZ6t+vA35grn8HQhys7x
         Aa0g==
X-Gm-Message-State: AOAM530YpsKTsUqBjj5o49WbpnE2ZsbFkqqOZNoO+lZB+Q1tYTz09iIg
        dpd03HGfdhDCQLt3ZJc1gKNbrPmxKzgX2w==
X-Google-Smtp-Source: ABdhPJzc7sUNgA9g5hRf2spxUyCz5I8jtnMmFaxnsnQUqPVUbaqedvuMe5EFgPuPF/IUzsDO7DA5zw==
X-Received: by 2002:ac8:6b19:: with SMTP id w25mr5917425qts.42.1619631534040;
        Wed, 28 Apr 2021 10:38:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k18sm279866qkg.53.2021.04.28.10.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:38:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/7] btrfs: take into account global rsv in need_preemptive_reclaim
Date:   Wed, 28 Apr 2021 13:38:44 -0400
Message-Id: <febdf6d9ff9efc92034ed688d61b38a9b53a5abf.1619631053.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619631053.git.josef@toxicpanda.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Global rsv can't be used for normal allocations, and for very full file
systems we can decide to try and async flush constantly even though
there's really not a lot of space to reclaim.  Deal with this by
including the global block rsv size in the "total used" calculation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 33edab17af0d..e341f995a7dd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -792,12 +792,14 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info)
 {
+	u64 global_rsv_size = fs_info->global_block_rsv.reserved;
 	u64 ordered, delalloc;
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
 	u64 used;
 
 	/* If we're just plain full then async reclaim just slows us down. */
-	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
+	if ((space_info->bytes_used + space_info->bytes_reserved +
+	     global_rsv_size) >= thresh)
 		return false;
 
 	/*
-- 
2.26.3

