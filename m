Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EA559A6C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 21:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350600AbiHSToq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 15:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHSTop (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 15:44:45 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED5EE69C
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 12:44:44 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h21so4118660qta.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=DdajeRa1xF/ufYAPyKdYacIy3Cotwa81OP2FtLRRN/4=;
        b=XeJE+bhgjARMsiTToXhD9OiAyD+w6X1Cg4SYebxh23eQviGnsl3oel8q2/jO+KBdcd
         GZaiJkMWe6OowUSpwSxaGL7tXgcQU2Z7hL07t5g3rrULkx4QmyzAHaMYn8BBiiPz4kez
         JyIjy4XiCbXFTs5YiB/19VD6jjgHrKDgwQuDftEo5+egZquEv/ZLj1uaulknJD8yVk2z
         vJnDezjQ1SXRzCKnVs4+w2HC1Mkt+I6NZUXXxcC3pgZ01DCgp/q1GguiAStEzG69gIOG
         XUtA02EVDO+C1YzVlsuPeaiRgUkzY4S+iOWyoiejjKmYpW0vpHsVTiBbb8XMmS6xhli8
         mKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=DdajeRa1xF/ufYAPyKdYacIy3Cotwa81OP2FtLRRN/4=;
        b=qvMB3NrEiZqlPlCka2MpYXMVS7LmX/zJotFttQY/vVGWk+shaYjcnZ3mRTDbC9iMlU
         qbvg4FmAZAkiKEgTC+NPvIeDQfONxjhb3IGVQhKFfxlWHqB1kxJ3zrgaBxuvS61WnYBv
         vPbMq8l/Yq8TXu3AOQ/Ii7KvhUXYO9MgSfv8SDFA0Gg2DKb+9E3xWwXmeG9HN4Pr2dLx
         LL0x5/3EN63QK7JApS7HlLvGGXN2fakxvfoZk//8k0EwyeOxn2qzpr6QPxSE9cs+EaY7
         f6h/pbjDlIGpwZu2lLtxcKYaM0UBzXWA2pcuByLXMF35hs9tl84Dfju+ClNvViqxG90e
         4skg==
X-Gm-Message-State: ACgBeo19xpdWfFjo8KyKd1XNKTzLf0FLonHSibHJLL7H7to/wxM2bqL8
        /x7XpqEQLpVAqGkoC27hC/QUl3ChIypV/Q==
X-Google-Smtp-Source: AA6agR5qgsBEsG1lXvrZ63cqHYURVXiQuoR+FXPeHSkGpMsQRqXkWC1Ks71ovgYUAMg0Yl3Ir2KZiw==
X-Received: by 2002:a05:622a:143:b0:344:95bf:8f02 with SMTP id v3-20020a05622a014300b0034495bf8f02mr6026110qtw.202.1660938282793;
        Fri, 19 Aug 2022 12:44:42 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id br38-20020a05620a462600b006bbc09af9f5sm3853760qkb.101.2022.08.19.12.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:44:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: take the correct ctl lock when removing free space cache
Date:   Fri, 19 Aug 2022 15:44:41 -0400
Message-Id: <409ff4f5a9365bec56c6a6dc77190b7a3b3645e6.1660938272.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

This is a fixup for

btrfs: call __btrfs_remove_free_space_cache_locked on cache load failure

I was taking the wrong ctl lock, this can be folded into that patch.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6b70371d4918..157cd712a923 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1035,9 +1035,9 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 		if (ret == 0)
 			ret = 1;
 	} else {
-		spin_lock(&ctl->tree_lock);
+		spin_lock(&tmp_ctl->tree_lock);
 		__btrfs_remove_free_space_cache(&tmp_ctl);
-		spin_unlock(&ctl->tree_lock);
+		spin_unlock(&tmp_ctl->tree_lock);
 		btrfs_warn(fs_info,
 			   "block group %llu has wrong amount of free space",
 			   block_group->start);
-- 
2.26.3

