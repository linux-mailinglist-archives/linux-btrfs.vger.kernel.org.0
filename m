Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76C964F23F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 21:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiLPUQS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 15:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbiLPUQQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 15:16:16 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AA9659AE
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id x11so3564719qtv.13
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeGRpLFBCU9iZeaT6l+8kozEZPYFZQ++TCDegxZyd5g=;
        b=PQ2+L5Njo1yhp7XK9Fw9mwLudEAg7zalU9mVhM7D/gEM5oE4PjmwNQkbs2C/qoXGOB
         72Zr9p9BobHOc+b2dF52NMVVnn7BrQHxWez1j/QAYsk1IAHlBm70xZg5Wk1+QS5+RX/1
         dWuY9UQSWAxbnuGgOpg0L7ArY67w2sHgQB/9VFUa0hfwD71d2sk8Ok9UKXq+Q5siztWy
         go/UxG/BUdGggsNQP9TaE8vLhsICZmuXeZbmmAOOm6RPWH/mpJ37IQ1txmrokKvO0n/Q
         yDH0G5FciAMyqjdcBPjv5NXsrcWv1Mrx6Bc9a4+EweGUZ+mG52hS8/Ft/S2vx4/7ho/y
         gWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeGRpLFBCU9iZeaT6l+8kozEZPYFZQ++TCDegxZyd5g=;
        b=FioS2vKkPEl/jSOL2MSOuaf4beo6QgqQLVKYh9ZPhuIksTpUWu4blDVQYE24KQvgoS
         lG85THvgST337y7CYoMvNaiAKc2g2PR3rD1yfgXwoX89BeV2rA0qTwflc29/o+Y3UZke
         CIh53cE4z847FpU0eR2I7hv2z2krT0TUy7WvBIFhHF3yVasJaRURA/8Bvcij4Ftg1XtY
         +lHz1wpsgN9fWArkd8xgIb0JipS3kvt4i7uDcCkQbPMu7bFvX7C3bZ27FCn/zgNByjPu
         70cdvqrKUtWoanMSgJ5pNw8tfgbJTyLMidpj9t7MJo3MQLcUA7TJaxJZeM9D0NVE0E5X
         NnZA==
X-Gm-Message-State: AFqh2kpKoUFXrmkijtw0EH354DZq6Y/Se9qixt1TeYBj8dpy4DnH5Kn5
        J+DbUisygQExk0pz6VoVKPn54ZnRL074rUTkXDk=
X-Google-Smtp-Source: AMrXdXsVozMEUimTYhN834XRyqlt0hEqTkXKghix5rJ1GlMvC3X96uVb/nOqHi5jiLQaKEKYO+sjeA==
X-Received: by 2002:a05:622a:59ce:b0:3a7:f091:bfe with SMTP id gc14-20020a05622a59ce00b003a7f0910bfemr1474506qtb.7.1671221770781;
        Fri, 16 Dec 2022 12:16:10 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id ew14-20020a05622a514e00b003a5430ee366sm1890564qtb.60.2022.12.16.12.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:16:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: fix uninit warning in btrfs_sb_log_location
Date:   Fri, 16 Dec 2022 15:15:57 -0500
Message-Id: <81030329cd7526ec374fa4e76ac6bc4b0ed56e25.1671221596.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1671221596.git.josef@toxicpanda.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
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

We only have 3 possible mirrors, and we have ASSERT()'s to make sure
we're not passing in an invalid super mirror into this function, so
technically this value isn't uninitialized.  However
-Wmaybe-uninitialized will complain, so set it to U64_MAX so if we don't
have ASSERT()'s turned on it'll error out later on when it see's the
zone is beyond our maximum zones.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index f3640ab95e5e..54568735415d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -160,7 +160,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
  */
 static inline u32 sb_zone_number(int shift, int mirror)
 {
-	u64 zone;
+	u64 zone = U64_MAX;
 
 	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
 	switch (mirror) {
-- 
2.26.3

