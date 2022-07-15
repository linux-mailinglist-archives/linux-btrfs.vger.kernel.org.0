Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DADA5767AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiGOTpp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiGOTpn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:45:43 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9257D68DF0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:42 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id d17so4467063qvs.0
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AOfGfiGcgU1XCMFumNksVQdw/sAZMbhxoEEuF/KtzbA=;
        b=DzCO0UirdSLCZvo9Z2gptHxK+ifTImupwSU95Dl9y5Xbv/JgDaggXn+Vrtx5UbVN5M
         glqjIXwovjV+a6kWXh+80FpuTJT6l1TAUWr13eSQCDlzPH5Nr2jHPzifbof+K/2421xd
         +2A+tIOGMpoflosIpQOqTWcSL6825tbdBCUP/4h3UlK70V3A3anCLTec5MJn9BAX8qQK
         tI/qC8//N1FmNGjzvyAqYJBPdXbiqMoZizxQbRMlj8fvxSK/mNf67DuznPz22GVqrM9l
         /dLpWwMYbsjA03vAQidAM6iRi+1BABOTGw56g4/xu56OsFnyNVQ44p+h/Rapg9W3NbmG
         pUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOfGfiGcgU1XCMFumNksVQdw/sAZMbhxoEEuF/KtzbA=;
        b=Bj+wmAvJCbQXo3VG8IugccPloRGWX6LLtmpblPulfA7Qg1SdsCxnkpc3aFn9yey/zl
         /ZT+iKsbDZd98IVCMXggmktB1GTDaTnD8roIj2FFB+X7DrJEaiquQ8biqKFQ8qSFu+pJ
         n9KOZ4C0qxw3cLA3Kzj+wzjjBnVSxpS091a65NkKvmIX0nzjqewSa8jUJVQyd6FcTI42
         2XTk4cyw7qhyNtcUj2IIsVCh6WhEz9Ow29srRVBnvdmj+oqNJdEzNqdGenNhJcOJHCgf
         gfnSizDYE7UG21TrFLec4j91jEb2mWjqtuX/Q+vHPVlk+sYlDCN2UM8HDq1wa8/hRS2p
         3Uxg==
X-Gm-Message-State: AJIora8/v1jW/ecd+HahFf59D+BPwM8w3D51GjMBKIYyKe3z4RveINBU
        Y1Et7n3C6Wd5jueCu5LjB22ZZ5qLQll3JA==
X-Google-Smtp-Source: AGRyM1uq5m+hg7/EyGrU0U3XLyMCGLwq3Kf8qijRfUebAvlk+5lFe0AitEtt2BMIH4fwnMF/f8lYAQ==
X-Received: by 2002:a05:6214:e47:b0:473:7e81:e1a4 with SMTP id o7-20020a0562140e4700b004737e81e1a4mr12993062qvc.57.1657914341973;
        Fri, 15 Jul 2022 12:45:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d9-20020ac86689000000b0031ebb1f8918sm4023228qtp.76.2022.07.15.12.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:45:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 8/9] btrfs: remove bg->lock protection for relocation repair flag
Date:   Fri, 15 Jul 2022 15:45:28 -0400
Message-Id: <1b53941df26e1a34c840c55b05a3a96efe11f0c8.1657914198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1657914198.git.josef@toxicpanda.com>
References: <cover.1657914198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Before when this was modifying the bit field we had to protect it with
the bg->lock, however now we're using bit helpers so we can stop
using the bg->lock.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 83c9bae144c7..05501d7a616c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8279,14 +8279,11 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 	if (!cache)
 		return true;
 
-	spin_lock(&cache->lock);
 	if (test_and_set_bit(BLOCK_GROUP_FLAG_RELOCATING_REPAIR,
 			     &cache->runtime_flags)) {
-		spin_unlock(&cache->lock);
 		btrfs_put_block_group(cache);
 		return true;
 	}
-	spin_unlock(&cache->lock);
 
 	kthread_run(relocating_repair_kthread, cache,
 		    "btrfs-relocating-repair");
-- 
2.26.3

