Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065E62281EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgGUOWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOWo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:22:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C732C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so16207900qtm.10
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tlhyn6Io+XWJV27UN298PnUC9Kg6hHIiKF1O0jj30xw=;
        b=sDZ2Rg/YTY2LZmL8hxSj05UOiTB9qS7GqJ6B9XAclxL9dWzZBtZmNeaeRSP3XglS5R
         NS4YsPrwdxiuqddhEENrk6ijSwSevWzp3XUEMwAeKgqCy9H02XIHKZj2sYdWNq/5zpL/
         iLN4+p6leOAVTGiF7lLafnztIPOHFozOS6NjPyGKhRsFEDqB7RUCN9tY0j+lTzUGWdC9
         q2JoEeOSYeufITwL6Q7cpr+OKmijtdVT64fcoRspvNQH9PExIHPab/OnSxj8cmKj1E4W
         4AuiJ/6VxGM7Lg3O2kDmVZfHAi1tyEzNn+Bn1ibnYPs0LqJUqeE3aDxWeNPk+b/agcbX
         UlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tlhyn6Io+XWJV27UN298PnUC9Kg6hHIiKF1O0jj30xw=;
        b=IrnHMgdpj8zHOM90dx94W/Bwn8uUDgl2SCNi/FbMPTNjIp9xsf+jdn3nqxd3YrMuCw
         HWuDkJwoe8IHE17FDg/dnavoMQqojFlhTnCczLWmxuiqwVmIrXKjsSHG4iqA/fDwZDRb
         fIPmiNrUY/ikepR7NsWB5ulHCJc0tYJFQQzEs81rl9C2SKzBMHgyfYagVygvUbCpu/5c
         wKKKfcZI8TYhuL1PuYr5gG8kC50qxoJTacq+WTVsszKEYjsjNnGv1O/QK/sw8HZlyf/0
         SWGk6xGXu2GFqK/ZaE27n+HXaQTCwhJ0udrDVBFb6EoipxghzTzt4WgKv42vn0uRWIu4
         mJsA==
X-Gm-Message-State: AOAM533CK4UtkWVrSma/k7HZF89aVJV6c6zgV8OkEu2Boc79u5ic73a0
        UQbjwPxhU5DbEDA5a+V1IarTlqvAQT4YCQ==
X-Google-Smtp-Source: ABdhPJyb7ZNhsnT1bvKKjA6P7vfXriUjGFp+jxYdpM0p+5/Gi8mr0KRL4F+CvLSXzuMe9SJytRHKHw==
X-Received: by 2002:ac8:53c1:: with SMTP id c1mr29625734qtq.193.1595341363151;
        Tue, 21 Jul 2020 07:22:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w4sm23531215qtc.5.2020.07.21.07.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:22:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/23] btrfs: handle U64_MAX for shrink_delalloc
Date:   Tue, 21 Jul 2020 10:22:14 -0400
Message-Id: <20200721142234.2680-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
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

