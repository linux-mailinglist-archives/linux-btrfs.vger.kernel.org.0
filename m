Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D1562FE91
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 21:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiKRUJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 15:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiKRUJp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 15:09:45 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8105F17AA7
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 12:09:44 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id z1so4217917qkl.9
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 12:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=abkvfUNhQl+VcWk86be86Up3S0wCdbhCPl914Mvaqcg=;
        b=o4FfP7p/YotAmKU6EMOunY7YImMh82um5mW1DTru0ND1XE5di2EK886AsLwTtDdYHj
         VL4g1xpSXoz9DPHJc7TGfUwAhBVGnEnSRctEZNwLtWMEojD1UGzdYNNnaChk9IVz0TYC
         bDdzCjDAra5oDKaFCevyAj8Ip7EEkrZAAxba0MkCHgWeztFWiBgEVCQl2azdB2cp5dKS
         7E5q18s0iIxUtIxrO+Ig03/sYstucyLwFlhwUC5xzmiapYMmvUJb/evajG+wK1SuNuBE
         q411aEMN6y9VdAqHB9+4jqWl5G4s2W7aZ5w8vHqTufrLYZhwRnIKsN31KAO4Ni4zzQiy
         WUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abkvfUNhQl+VcWk86be86Up3S0wCdbhCPl914Mvaqcg=;
        b=1y1NMbNC0oC7cZtCGo2O7e6OyAz0Wn9yRGlYubRZ4X/hvmJ61knlDD3OM4Xi48/KpG
         dMlPlgyTQBTm/VUwcpewnFT79r7TXtNibwUwMwGTvH/hUe1vBQTmpm9Fvd3fZpW7yckP
         UMRRp01l5q1rh7Jz8Ow2s4YMMfgFNyRebbi+aIDymuZPwKaocddBJGCNsbhaKLNiJWaW
         1J2Ux0CMHZAnwtW9Q2/J/OUAYeq6Jy25giYz/UDHXQInBTJCHQJYsredVr7sItBphZ6W
         Z00Ic1bPm6qxfehuI5emooxbD2pvxPI2y0CEjI2UCEd4yKye5yHcuQXYcwf50xCgCZPb
         HRXw==
X-Gm-Message-State: ANoB5pkEpRMSN02yzAj4/xAxXCGzWUP3eFlnrDDZVhwlTpk5oPQKv4lo
        sCCGiDmvfizGqaIbkuAMVxWq/MIcKnosWg==
X-Google-Smtp-Source: AA0mqf4pXSFstnutx/TP3W5WLd8qx6tElXjdJmZ7+8O6qFUPhbP+SoM9Da1ajVbbkdv4pKzmsfoaTw==
X-Received: by 2002:a37:6847:0:b0:6fa:22f4:6a62 with SMTP id d68-20020a376847000000b006fa22f46a62mr7211877qkc.268.1668802183336;
        Fri, 18 Nov 2022 12:09:43 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a284900b006f9ddaaf01esm3074548qkp.102.2022.11.18.12.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 12:09:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix uninitialized variable in find_first_clear_extent_bit
Date:   Fri, 18 Nov 2022 15:09:42 -0500
Message-Id: <bf7143200d35786f2d20e929cb3a626a94b4e9b4.1668802173.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
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

This was caught when syncing extent-io-tree.c into btrfs-progs.  This
however isn't really a problem, the only way next would be uninitialized
is if we found the range we were looking for, and in this case we don't
care about next.  However it's a compile error, so fix it up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 25215667a3de..af11e3b89125 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1425,7 +1425,7 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, u32 bits)
 {
 	struct extent_state *state;
-	struct extent_state *prev = NULL, *next;
+	struct extent_state *prev = NULL, *next = NULL;
 
 	spin_lock(&tree->lock);
 
-- 
2.26.3

