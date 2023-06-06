Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172417236E2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 07:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjFFFhF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 01:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFFFhD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 01:37:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9291A7
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 22:37:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6532671ccc7so4652720b3a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jun 2023 22:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=slowstart.org; s=google; t=1686029821; x=1688621821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3+xiEI337AU8hRkvpfals6+m/yNEy48+V0XCft029k=;
        b=ag+3DBEmYwlaxBM1tsekRFA6MsgLYYuHFB3f7CcHdch/bOcwG2KSJjDxV0h/aHXpWb
         XKr1xbgUKbwE8xvYHm1q6L9pLLyemGxJmv6WUdbJ283tFQKdfMB75JV80OaUhhQp0ST3
         1DVjSnWpl0nnUSuKRfu9myL804u9BhoUXURHPu4TriEjLiCq35ivoAW3w5BmBgLE6Dn+
         JV49tO2vw1ObEqBP1hdbqaPOVsdFTI95Cw2X3wWWc2Pc+i4Wbi/uTP9EVeyfrGS8dZOm
         gW44Eb3vk2BR59Yy/kVMHciPMs9g/T596m6pi1h/pWYsyV1AwWyu9RLEeAkAOG8xSs35
         erFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elisp-net.20221208.gappssmtp.com; s=20221208; t=1686029821; x=1688621821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3+xiEI337AU8hRkvpfals6+m/yNEy48+V0XCft029k=;
        b=Ye90u+m4bPTi/sK5WUFx4IxLqhV12NMJ9QT/tMa4guMFmqPtB+Dxx1Hg6WiBWcgPxb
         VSl/2o2V2cPo/CWYDS+KgjfjfynJ3SF3BKbgs9aPNxlaqa8//AzMY8yPhBxEQWYiH1p6
         p8EObT155UPUHDSbIOK2BhEl19N4lY6ZUguBnXlWmTWeEmdlRPzzx3ZE4Wppt/NnAJNH
         0rKWc4CbIp5F0WaM+7PWNRUWopM6EMoUVoqwKV8A0qxY37J8N2AKIt5DgmrqaUH8jlVz
         lw+p60s25591vNBc7Eawz4bP47SY3/OA5jMEsYQwS5ABnKmMVfaOzN/qH4PIYjdZ7+rn
         FEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686029821; x=1688621821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3+xiEI337AU8hRkvpfals6+m/yNEy48+V0XCft029k=;
        b=lQku+oKPgzopIC09EKDnVxZN8sqQLIYA6r1TYdUSTYB2yeoQ1TMS1R0CYF5rbThqKK
         rk7bP4A9pvSgUU651k1bUTkWHz2L6pxIlhnGft7jHWWYeBk+ahB9EdzgPw4K8Qk1ocwp
         q7n+V5XA0j9U+aI78E2VdSaUJSn0CnyZF2jsx7/Xh6ZkOCn/4hUAwZutlVYTQkCXsJ36
         /Wa6jGDWoC1nKixH0FJDu+Q7r9JySUPMNFInAfbpv8aqnjgf7djm0Z+CtgwyYMB/FcFf
         iJWQgTeFBqaEpwrbpigM4Tby8wKEyqqy9y8LvrEA3EJeThMxZgk49xDKyg/KAdK0iBAm
         6Z/g==
X-Gm-Message-State: AC+VfDzKlK8G9AHdY3feZxTSEIe5EpgqlVqh8fg9I9U+JNPL0DCwTkPz
        FRfRIQGGQZBqcIGm/TP/F22W+Wb+lrIQnh92CrjPbtVFcgrEwmYjAdzPmsb9ly/YbyqoTbuEkKm
        dW5oAy99ElpMCS4tz+2REYhUFuj/0GWzMCvpNiLNXfxaW0KCWYM4lfWxgewoIze2w03IPkZkodZ
        aMMbpqxhMcVPxM
X-Google-Smtp-Source: ACHHUZ6nwCiH9rUT/q6CJovbceh6mcJOSkH4ntDuXrvX1YTJFydLIX5ToN2C6Ur4Mc39uzJlag9Zow==
X-Received: by 2002:a05:6a21:6704:b0:10d:d18b:95ce with SMTP id wh4-20020a056a21670400b0010dd18b95cemr1389972pzb.22.1686029821292;
        Mon, 05 Jun 2023 22:37:01 -0700 (PDT)
Received: from naota-xeon.wdc.com (fp96936df3.ap.nuro.jp. [150.147.109.243])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b001b06f7f5333sm7521853plg.1.2023.06.05.22.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:37:00 -0700 (PDT)
Sender: Naohiro Aota <naohiro@slowstart.org>
From:   Naohiro Aota <naota@elisp.net>
X-Google-Original-From: Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/4] btrfs: move out now unused BG from the reclaim list
Date:   Tue,  6 Jun 2023 14:36:34 +0900
Message-Id: <6a25b9266b8fb08ff990214aae9efd04fed6b549.1686028197.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686028197.git.naohiro.aota@wdc.com>
References: <cover.1686028197.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

An unused block group is easy to remove to free up space and should be
reclaimed fast. Such block group can often already be a target of the
reclaim process. As we check list_empty(&bg->bg_list), we keep it in the
reclaim list. That block group is never reclaimed until the file system is
filled e.g, 75%.

Instead, we can move unused block group to the unused list and delete it
fast.

Fixes: 18bb8bbf13c1 ("btrfs: zoned: automatically reclaim zones")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c5547da0f6eb..d5bba02167be 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1633,11 +1633,14 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
+	trace_btrfs_add_unused_block_group(bg);
 	spin_lock(&fs_info->unused_bgs_lock);
 	if (list_empty(&bg->bg_list)) {
 		btrfs_get_block_group(bg);
-		trace_btrfs_add_unused_block_group(bg);
 		list_add_tail(&bg->bg_list, &fs_info->unused_bgs);
+	} else {
+		/* Pull out the BG from the reclaim_bgs list. */
+		list_move_tail(&bg->bg_list, &fs_info->unused_bgs);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
-- 
2.40.1

