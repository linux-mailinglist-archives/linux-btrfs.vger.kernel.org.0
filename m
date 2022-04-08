Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF44F9C57
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Apr 2022 20:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiDHSR5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Apr 2022 14:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiDHSRz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Apr 2022 14:17:55 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CAD50462;
        Fri,  8 Apr 2022 11:15:51 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q11so11580169iod.6;
        Fri, 08 Apr 2022 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3Xrv6LMioFNeM47iTh+QPIRD6lKAvxyIDHYfbx6Cp8=;
        b=XNepYenzO1+4vCMxmSc6PTdn4UDbb0fjRnAwLRxRgkvfSl2NnTFDGZOg2b82mxZTmR
         o24oB2RYs2thuujqbTO7lFoQ0A/jWkDS7cNRh+VtNWO5zEL8FFJmGZWiyJh2tciEkUsF
         VIZRaWx/mXaHXE6elqX+2aTFf5tRlcCgKndectaYSLc9xBTwtRyfylsMQOqsYo89f7Ja
         EvjdTMDRUNdusn4rz+0ueu6BETJgQdSwlzYuutpW+3TQylkDA3KCaHSb9kgPzpPKcNNW
         cJX/yoR7XjS10+yoMgb5yPAVHPzbX5loZcVWRnfwn1CZ6wwkGuqLCfHCNGt5iPuCj/M7
         8Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J3Xrv6LMioFNeM47iTh+QPIRD6lKAvxyIDHYfbx6Cp8=;
        b=P5qS7hyp4svBZbvQM2Dj4tVsu/lX4u7YTUB1xPyou4YArV1F9tPm3/HunLSIT0BxaJ
         ePfdImcKvV65u16Hyf4q1Od4OF9oXrEeiwMkBFdyNQYRLaLuMWGSnIz1OvfhC14GnJcV
         +ws1Rqyu7zJGw1YYJ0C2WVHCFgQcaNyN/0NX+dkhK4V/R+KATrd5obd3t0H58vMCpRo6
         qNPmM68VzsjbsFBxiIw2sq1GM+KJBjvFCENS9OVY71yCTWL9UWDcoNtOaW0dqpEDPwzX
         p2vxkHjYdMsnkQ4EHAMeMubRQparpJ6pNLEeP5R/rfL0jC0i9yzRWYgWkTBGkYbUiU3L
         W5xA==
X-Gm-Message-State: AOAM533dwLFayyDgCM+2A7aACTl8UE5r00FHvih9x9p0N5+NORAzcfK+
        G6yQZr4zkFF5U5VwgeUiMi0=
X-Google-Smtp-Source: ABdhPJxO4yPJjBSr3Aw/GzP1KHEEekShiDjHVB9mzOHI/e7M8VnkRdFJojeU5V0BuTPX6bhLtUWhwg==
X-Received: by 2002:a05:6638:300b:b0:317:a127:53ac with SMTP id r11-20020a056638300b00b00317a12753acmr9645537jak.77.1649441751278;
        Fri, 08 Apr 2022 11:15:51 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id n35-20020a056602342300b006115627b87csm15361899ioz.55.2022.04.08.11.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 11:15:51 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, terrelln@fb.com
Cc:     schspa@gmail.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: zstd: use spin_lock in timer function
Date:   Sat,  9 Apr 2022 02:15:23 +0800
Message-Id: <20220408181523.92322-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

timer callback was running on bh, and there is no need to disable bh again.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 fs/btrfs/zstd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index fc42dd0badd7..faa74306f0b7 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -105,10 +105,10 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 	unsigned long reclaim_threshold = jiffies - ZSTD_BTRFS_RECLAIM_JIFFIES;
 	struct list_head *pos, *next;
 
-	spin_lock_bh(&wsm.lock);
+	spin_lock(&wsm.lock);
 
 	if (list_empty(&wsm.lru_list)) {
-		spin_unlock_bh(&wsm.lock);
+		spin_unlock(&wsm.lock);
 		return;
 	}
 
@@ -137,7 +137,7 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 	if (!list_empty(&wsm.lru_list))
 		mod_timer(&wsm.timer, jiffies + ZSTD_BTRFS_RECLAIM_JIFFIES);
 
-	spin_unlock_bh(&wsm.lock);
+	spin_unlock(&wsm.lock);
 }
 
 /*
-- 
2.24.3 (Apple Git-128)

