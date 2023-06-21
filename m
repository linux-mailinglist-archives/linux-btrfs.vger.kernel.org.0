Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CEF73847D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jun 2023 15:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjFUNJz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jun 2023 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjFUNJq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jun 2023 09:09:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C62C199B;
        Wed, 21 Jun 2023 06:09:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f86dbce369so5105212e87.0;
        Wed, 21 Jun 2023 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687352979; x=1689944979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=itwb9Cgqe4LPJLF1L10bNoqbQPmNuEgB4oxI2zCKoaQ=;
        b=gzO+LSsXSDFErn1INaYei3n7YDBSmFzaOv/u/1f5dOnG/NfkL/mWWy+Okxa2A4Jb+R
         yKMIrBEyNBQz6vT1rpL5mpaOODqPJTamMkzIwmzfZnl3JkFQqRp0v2NV5lhTurpoGzHG
         HtY2ma32uh7NYhGiQANZuj3NrVjE/FNNIwWuf3AiDsszJVlXALdrn6ro0by/vo3OI95+
         mu8Gc1FcGdOi82NS/TuZ2SnuZES3aRUiQzV5oD+xjsoTAy43IcpxvJ1klPv70H4QKq2O
         I8xWbCp8z6RDD8ioHtPzl32dIQuLQe8QXmzSVpH9D//rwQSm6yhvlvxgwoPkBCGiAd/q
         FJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687352979; x=1689944979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itwb9Cgqe4LPJLF1L10bNoqbQPmNuEgB4oxI2zCKoaQ=;
        b=gwxRSRf27gUoTKTpQRK+o+4q6/fr5HTNVpJ1WUojPbAKW5zHweJ/7f1+ZfPvGiEnn6
         ru3n9CXVKZBrmKZEZpvn/2t9O5p/aVrSpuHZzfU1fRRRayFiwW463Vz+DqXRflKHWeyr
         A2FUnAB/qZk+ZSbpA4wlmLFjwS9EQoE9qXWHCQUzF9TsxszPVJGZeG+FedztLPMhY1v0
         bOtEy7lk2qXvVe4R6aGypzl0MWhA3WgoXa18IWKcB7CR2lnpFLgEAEPc4P+2Jx5i87hI
         4swv7lHcgfP3baCLOYhVg9ArJwAh8ywIpg0xqbEbm/dGnF+HHEUYUuISg4PXUW2epzw7
         /aHg==
X-Gm-Message-State: AC+VfDzABhCuMopDtXz2GwW3u6VBJ4uqbeBGxsW4/yNhqlKwqZkQXlnt
        PSqH06ZParpMFDt//U9rgHI=
X-Google-Smtp-Source: ACHHUZ5ZIkz67DxCK4edbIQh90vWhjPTO4MfSW5ISWzZyTBWBSIsfyWfn/OO71EMNgVC0iifq/trww==
X-Received: by 2002:a19:5006:0:b0:4f8:711b:18b0 with SMTP id e6-20020a195006000000b004f8711b18b0mr5686159lfb.3.1687352979205;
        Wed, 21 Jun 2023 06:09:39 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003f8c5ceeb77sm5024814wmg.21.2023.06.21.06.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:09:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] btrfs: scrub: remove redundant division of stripe_nr
Date:   Wed, 21 Jun 2023 14:09:37 +0100
Message-Id: <20230621130937.2676434-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable stripe_nr is being divided by map->num_stripes however the
result is never read. The division and assignment are redundant and
can be removed. Cleans up clang scan build warning:

fs/btrfs/scrub.c:1264:3: warning: Value stored to 'stripe_nr' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/btrfs/scrub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2c7fdbb60314..8fc4f9ea3d20 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1261,7 +1261,6 @@ static int get_raid56_logic_offset(u64 physical, int num,
 
 		/* Work out the disk rotation on this stripe-set */
 		rot = stripe_nr % map->num_stripes;
-		stripe_nr /= map->num_stripes;
 		/* calculate which stripe this data locates */
 		rot += i;
 		stripe_index = rot % map->num_stripes;
-- 
2.39.2

