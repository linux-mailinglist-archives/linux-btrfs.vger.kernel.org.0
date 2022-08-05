Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D49458AC42
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbiHEOPU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 10:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240920AbiHEOPR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 10:15:17 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C69CB
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 07:15:14 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id r11so1924342qkm.7
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 07:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jUGPBZ5oxW4yT11QIYfmobfVY4Y1QanvhsLfItcTPR4=;
        b=xbizgm+CT/chgRFwwcrxOqZ0BGJlSe398GBeJvKTI3EBErMb2r5DeWfhtU58Manqgy
         JfAMEJXeBPJcfCRIGyrcU3vqfBfwa5RcmE9do7+QSiapBA15WK5LE0BpzjsyHoOwtPst
         G2BKa0u9UOrGlWtQ9O0XyVvAQaTrwVqx2y5hKhspfireEWNj0VT5ORolf9iqN7RwZPLX
         DxdbdqcUA325u3FqYzUYTQEjDaTLaU330V459myMIfpgwALtZUrD2UM0cST4mqP6WOyd
         JZUJhLxzIE2Al2kTOhqOz9Ibyus2ypH88+jkuPfiZqSO9+jfJMS/nHJXP2JjQoLkG9n5
         2scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUGPBZ5oxW4yT11QIYfmobfVY4Y1QanvhsLfItcTPR4=;
        b=tiijzple2QV0icQ0VVSGYrU0oWedLzC/B7bdYUBIKgXGqgNY1mhW7I2LRLx30bh23f
         o+f1tAi4OJ1WjkDoQiCzRGyyh55oekI+ylQWY/WDiwqFy3hmQy2giPm3MQZ/W62LX2cW
         IlI/PYLfFcVPNrGsbMHv2kEvhFxCCUpFCScwgk8vcgivKWvt2LX3qjW6lickAkwtripi
         HnScnkQp8ne/3E58eRgnjrzqTqSmHCXQuWnVpmqGHtKPD8+ZP0DcfIlOT39ctCG/stCh
         In/i5q0xV05bGnxGndHGT/UlbaxLSmbiFrB38CqVxaI5LLkG9kevn2coggHB0p+WsQwA
         Xr2g==
X-Gm-Message-State: ACgBeo2p1kQNLZkMymxWwrYnZwAEvQh0dEkCzMrMfcUwRMnRRH1RqOpv
        AgvWXudole72pj/8WO4YXQX1AdpQaQheQg==
X-Google-Smtp-Source: AA6agR6Pnahb1b5zlAcMGQp9JeTUmx5zTWzhLmnw8wbleq77VOmZTkotpBcjTSWazoJfNStjK9qu1w==
X-Received: by 2002:a37:b041:0:b0:6b5:ce22:62c8 with SMTP id z62-20020a37b041000000b006b5ce2262c8mr5090351qke.640.1659708912698;
        Fri, 05 Aug 2022 07:15:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m22-20020ac866d6000000b0031f229d4427sm2594407qtp.96.2022.08.05.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 8/9] btrfs: remove bg->lock protection for relocation repair flag
Date:   Fri,  5 Aug 2022 10:14:59 -0400
Message-Id: <0559d7a06b24a557bd9d308fd708a284e18a8cb8.1659708822.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1659708822.git.josef@toxicpanda.com>
References: <cover.1659708822.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 8a6b5f6a8f8c..7eebd2c5e5b3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8277,14 +8277,11 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
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

