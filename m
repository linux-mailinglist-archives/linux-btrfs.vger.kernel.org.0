Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1700E4D510C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 18:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244112AbiCJR7a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 12:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245230AbiCJR73 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 12:59:29 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3B3E72AC
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 09:58:28 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id a1so5250081qta.13
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 09:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U1i55CUj16/A/aS2C9LbkhSteVXNQOCntZY/K8xVzUo=;
        b=VTtxrsYh4meAwXd2Y8wG8GWr9dgMwHfuev6fZKLH3sZFZ3oPITtxgGgKDgSG+nMedf
         2GNLXyZSEm3IFGF2TFqPkySXyd8oNg6Yv4nXeY095uxJShWqO0DRQe38IzwDi/YFfNMs
         yvcxVQewRjnAjWNGQ9sUlUFA6sHVk7GBVkDFm1nDULydcotK5y5EdC1CmGhCFs2VBKlX
         17JGf2JEUIiAYBEJd0/9tZdBWLCol6PbxGbCF/QwHIC0tUiGtZFUAMzioiW62TanEn8V
         Wl805fQrAnYnSwKNbpYJmpX7u8RrWnEbtKUDdbECtONxdbvifRLV1e5HIlUFAE/EtUzi
         rJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1i55CUj16/A/aS2C9LbkhSteVXNQOCntZY/K8xVzUo=;
        b=H9SIffrG3w8Go3Xwt1ILB/g9aDrsUtCOOyzOGC3SWLX4K7J75uVwY6BBLNZ8tijRAV
         ujdHAANZwQ2bp6k6UXqdl1O6cjFUz2gPeuYj3I+75j8EZPCNdrYqls2sM0VS16zy9SKe
         LvoAqhQLzyu96j2D6BT/jJTiO7IsUfPnPmYOUq452pAkfWpHLMqmLjwHpOg3RrnmGZR6
         ygH6v+L/IKIhJD7I8Gw1k4zLvYBMuFCmBWlMcc6+1brAyZZ24EYrPMYW2rz2sIEgh7oY
         QHR5tyaThWDHzrFglPdtFvQGJ/aAgYAAcRvbMqODj78IMUXChjkkhSGDZAiBR79vR6kv
         JCIw==
X-Gm-Message-State: AOAM531cia1w2TXKMZ6c0KyFmMleUsu7CW7dvQTqhuJqq7TcFCAeCySG
        zgOoLpByT5eA40yChCVW+vEEpp4n7O44JpIo
X-Google-Smtp-Source: ABdhPJwg66dcavs4QoaZBJ4idIkjSmFPf7E+DC25oLxC7IX3RM+oLNuA27T6tNQiUj00y6vmR/4csA==
X-Received: by 2002:a05:622a:54a:b0:2e0:4a6f:7c8c with SMTP id m10-20020a05622a054a00b002e04a6f7c8cmr4997794qtx.458.1646935106245;
        Thu, 10 Mar 2022 09:58:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n143-20020a37a495000000b0067b12bc1d7bsm2619877qke.13.2022.03.10.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:58:25 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: change the bg_reclaim_threshold valid region from 0 to 100
Date:   Thu, 10 Mar 2022 12:58:20 -0500
Message-Id: <234b8cb6da042df7d5bfa4ee10ff6d80c5908e90.1646934721.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646934721.git.josef@toxicpanda.com>
References: <cover.1646934721.git.josef@toxicpanda.com>
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

For the !zoned case we may want to set the threshold for reclaim to
something below 50%.  Change the acceptable threshold from 50-100 to
0-100.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d11ff1c55394..400ce18d6a81 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -746,7 +746,7 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 	if (ret)
 		return ret;
 
-	if (thresh != 0 && (thresh <= 50 || thresh > 100))
+	if (thresh < 0 || thresh > 100)
 		return -EINVAL;
 
 	WRITE_ONCE(space_info->bg_reclaim_threshold, thresh);
-- 
2.26.3

