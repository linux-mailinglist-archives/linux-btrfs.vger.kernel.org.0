Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFEA2281F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgGUOXD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgGUOXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C2EC061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:02 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j187so550419qke.11
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUKAcr8sj48zILP/O4FAQLxv8qd7Y3tPkuEZI7Xe0C0=;
        b=YkPUxssaUrTMIZJyxyt26rfZOPvJBvDBX1IImSssMiuS0I3TNe3pWJNC2c0uvS/qyx
         6aTlxczK+BsPw8ntKk9QBVn9wb+jfCmaUll36jGDa5G5Ewhm2FVV/ANzpb6vLT97y4+3
         OJnEB98pGK8d167LcOPqrpNvZ0XLE4qCdd3JIqA0+2jJ1NAo81U/KfzQNsozfwohf4KM
         4CRH3/dvRndz7a3Tz4uyY1xkCfZ1/L7v5Juf84ZJDdEYc2C6gZu9gkc44l3qIKZlWVyW
         qviGNlNlsmEk3QzORuvr7ga5rMGsXO0yCHf/yH2x82YzqEUsAcHIAxaM1HNF1dHETFND
         DQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUKAcr8sj48zILP/O4FAQLxv8qd7Y3tPkuEZI7Xe0C0=;
        b=niBN/Y2UottnSpxKH1kAMgL0b+I2Ypr4lhHI2URMKO7VF8ZtzfiaEjGcGyeTWuVNJh
         uX83hVX5w6flTlWW7fx2qmc0rX9pEzd8/VDO2ccyuJKzP2cQaM406HQXe8ng1Wnrucuw
         dFwCM4A47gPDn4kuxv4648qMTGyUZxkiCIQk5IYpzFbBStF4VeKphdaLBw4CIjKAaz7o
         glnC5/cyzYvIu45frgkOvLu2sJb6dp7y56worrq7Y/5JJDrttvP8sPXuLzDIo/fQi/EU
         CZdFlec9guf6VgVLwIWEZo/SMYz/AiRQ4SE/ZMaV2cfLbfEWfqI0nnBHxGC9eKTkAV1v
         MtIw==
X-Gm-Message-State: AOAM531GL0E8rW1Zt07Q9+5jMoCaCHBCcc/j5YO0n+aCuu6DR9ysF3Ba
        FB/afwkoMs8lV6UyUGAOMYDlHO3CKDqigA==
X-Google-Smtp-Source: ABdhPJxTZZ2PmG2DGmUiA9vmFEjAxgscfZmz9OoFB1Ly9z4LcJ1+FXYAW6Z/XaGoQRHolew+RcXEgA==
X-Received: by 2002:a37:4884:: with SMTP id v126mr19008144qka.118.1595341381213;
        Tue, 21 Jul 2020 07:23:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o184sm2707330qkd.41.2020.07.21.07.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:23:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 12/23] btrfs: add flushing states for handling data reservations
Date:   Tue, 21 Jul 2020 10:22:23 -0400
Message-Id: <20200721142234.2680-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the way we do data reservations is by seeing if we have enough
space in our space_info.  If we do not and we're a normal inode we'll

1) Attempt to force a chunk allocation until we can't anymore.
2) If that fails we'll flush delalloc, then commit the transaction, then
   run the delayed iputs.

If we are a free space inode we're only allowed to force a chunk
allocation.  In order to use the normal flushing mechanism we need to
encode this into a flush state array for normal inodes.  Since both will
start with allocating chunks until the space info is full there is no
need to add this as a flush state, this will be handled specially.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      | 2 ++
 fs/btrfs/space-info.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4e882ae15eea..a181f4959a1d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2592,6 +2592,8 @@ enum btrfs_reserve_flush_enum {
 	 *
 	 * Can be interruped by fatal signal.
 	 */
+	BTRFS_RESERVE_FLUSH_DATA,
+	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
 	BTRFS_RESERVE_FLUSH_ALL,
 
 	/*
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3b5064a2a972..94da7b43e152 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1018,6 +1018,12 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	COMMIT_TRANS,
 };
 
+static const enum btrfs_flush_state data_flush_states[] = {
+	FLUSH_DELALLOC_WAIT,
+	COMMIT_TRANS,
+	RUN_DELAYED_IPUTS,
+};
+
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket,
-- 
2.24.1

