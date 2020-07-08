Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149B32189A3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgGHOAW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgGHOAW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:22 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F55C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w27so11483583qtb.7
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psc9iFpr11NrkpfCqKSXQMbsM0IUWL8y4wKOAVQjwHQ=;
        b=fOwHSlZZact8L6FH/i+B3pi4NrtswBIdym1+HhbIUg1/HsPJBwVHt6SQGjpaDUOkPu
         COSpBuxu9GQX1shLLO0vRk5/5g4AQDzljHNGzMl8xnjzJYgXcBOL+Fb2NZtR9T/Wtbd2
         uAsOUIh2F4mze/xe7HHOMXQmjsxubdqFsnemw2zSAY0pOVgz6e0fGStc6KlQPeY2Dv87
         IAo9pQcvXN2VC/lXiZ6A8rEnXMCmQSfxLVJ1Gweh6ij4AHwkv1E/Z+DRpkKPpQ9uoOsy
         hs8LMLWzBizR84BmDoRlHDnnEm/4nRHga+c0iQ1nR62ohhYi8YVDafsM8t44FdFb3Qjq
         r7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psc9iFpr11NrkpfCqKSXQMbsM0IUWL8y4wKOAVQjwHQ=;
        b=hstiLu/8Eho2EiP1+hXTYd7O1pTMYCLEZe0hlFU1brv7Q/wUtSqd5oYn5dyo6H0u1D
         ZhaRCjJRr/p+8ar0CtWsI1lzTG6yiB0IErEnhOWd/bmReS6an9nVItfPlb4rwtMycv0C
         K3c8D5pxWjD7aMhpQDu6/EGiH9o/zH2Vppr0ng/AvEd2J3ANxQpM0ThjOPbbdfCJclYV
         KsjyHQCoMG6ic6MKlAiID8oYXiGluM8TyEqDunOxmM6tASe/YKniBmfhFmsVSckShyKT
         oMRYk43FGM6TwU5Nd4n46EUOU+hW2WNKDalNuWqvVTIx9SQNNcsdm1jicxgQ1LnlHl9z
         LgVQ==
X-Gm-Message-State: AOAM530IfQg2xb/Y+lecmL/xIoN/C9vZRkANm38U/J87/qNYhTCwBxqR
        70ZRV5seHxergz36joA2WzS7evyxvVCcQQ==
X-Google-Smtp-Source: ABdhPJz+xU1Wk3jcqTHA1PhEtaFXP/8TUNFIcu4px2TTvkyPCpE23u27Iza1qx8EJKf1CTXo/dOYXA==
X-Received: by 2002:ac8:4718:: with SMTP id f24mr56359872qtp.95.1594216820846;
        Wed, 08 Jul 2020 07:00:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g1sm31094449qko.70.2020.07.08.07.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 02/23] btrfs: remove orig from shrink_delalloc
Date:   Wed,  8 Jul 2020 09:59:52 -0400
Message-Id: <20200708140013.56994-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't use this anywhere inside of shrink_delalloc, remove it.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ef6e264746fc..10cae5b55235 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -517,7 +517,7 @@ static inline u64 calc_reclaim_items_nr(struct btrfs_fs_info *fs_info,
  * shrink metadata reservation for delalloc
  */
 static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
-			    u64 orig, bool wait_ordered)
+			    bool wait_ordered)
 {
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
@@ -742,7 +742,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case FLUSH_DELALLOC:
 	case FLUSH_DELALLOC_WAIT:
-		shrink_delalloc(fs_info, num_bytes * 2, num_bytes,
+		shrink_delalloc(fs_info, num_bytes * 2,
 				state == FLUSH_DELALLOC_WAIT);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
-- 
2.24.1

