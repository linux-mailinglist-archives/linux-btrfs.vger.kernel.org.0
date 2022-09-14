Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70D5B90DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiINXID (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiINXIA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:08:00 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A38F88DF1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:56 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q11so9016252qkc.12
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=4eGczGLZTkmdb3LjA+84lArlPiAPZprT358D2WG+w18=;
        b=ftFp/I76kIXjwxj2Dtg+oZ6rpPWBaedqdB6uqd3I5yMVPxEM1XN4I7M15k5k9+T+o9
         j9sONFSmKGP5NxFddRqY+9s4tZDNafGcmrXIxyWtJokHgAGdh4twxZ03ZSmCLePUIK3n
         6IFgwwNaq26zZkHGjnEnJW2wsIK+kTD1a9pGPG+3HpWSes7NkeTU3OaADy+O7rcFaLOe
         hJ9eFZQw2mUdflDrGVPS6dk45LHQfrgYpe7Gh2naEk2mLaRF4yeWe0rtkGNvroAMNOOR
         civJNp9LEJl479XgmcRvgdDiAYqMJPv/+pXCob8iZM5/hD1swPY0j82H3wOmoGLS2rSi
         20mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4eGczGLZTkmdb3LjA+84lArlPiAPZprT358D2WG+w18=;
        b=EmlYPCbAuw/yJzBeV2q0S7WsbMR2YY1RNuc+on52nHyRkl1lq9WH82khn/vAGI8/Gx
         fcyHx6v+3FoeomSapacUD/opoltjZ47pg/d/6+lp2JO7tkOFNKKE2lvD5LP1jibpxy2a
         hPwNuRO6ez5rkfALsMgKB4MqtyS+wR7r6520EOK90jD5/Qfpdx9rtaRoZ9XgFsu2e0n6
         W5zK3GnT/EC6Po/9qc44GYMcF3DocFnwWZ3KSK0ivQBkBCK7Z3SGqWUhrO09GBXWFq1P
         7Bs5MftPjP6ssSEZbUlcN4b7SBIba52Yi8nlxgjqqmJM2q1bZskUef1bz0BajaGuUQF5
         5DRw==
X-Gm-Message-State: ACgBeo2mhGBTZH8a5qqnW1IRZPUlLO6zArhh0Y9Q0yb8Fnb0RwFRN1Sb
        OBzQPGWXn2dTHMVeHxx/wLT4iajxWE74Ug==
X-Google-Smtp-Source: AA6agR7AuGcq0mIF/v1GNjOcaYgtSogfvoL/rVHMPTrD0LTDIGFUm0bm2rHap3JPLwh3NyysPmvEZg==
X-Received: by 2002:a05:620a:43a2:b0:6c7:f2f5:4a1c with SMTP id a34-20020a05620a43a200b006c7f2f54a1cmr28562063qkp.439.1663196875622;
        Wed, 14 Sep 2022 16:07:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m12-20020ac866cc000000b0035bbc29b3c9sm2414815qtp.60.2022.09.14.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:07:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/10] btrfs: move btrfs_can_zone_reset into extent-tree.c
Date:   Wed, 14 Sep 2022 19:07:43 -0400
Message-Id: <ee8a825f6de91a3b8ee7d4594cc62e8c4e71057c.1663196746.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196746.git.josef@toxicpanda.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
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

This helper is only used in extent-tree.c to decide if we need to zone
reset for a discard.  Move it out of zoned.h locally to extent-tree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 15 +++++++++++++++
 fs/btrfs/zoned.h       | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7cf7844c9dba..0785c1491313 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1271,6 +1271,21 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	return ret;
 }
 
+static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
+					u64 physical, u64 length)
+{
+	u64 zone_size;
+
+	if (!btrfs_dev_is_sequential(device, physical))
+		return false;
+
+	zone_size = device->zone_info->zone_size;
+	if (!IS_ALIGNED(physical, zone_size) || !IS_ALIGNED(length, zone_size))
+		return false;
+
+	return true;
+}
+
 static int do_discard_extent(struct btrfs_discard_stripe *stripe, u64 *bytes)
 {
 	struct btrfs_device *dev = stripe->dev;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 20d7f35406d4..aabdd364e889 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -320,21 +320,6 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device, u64 p
 	return device->zone_info == NULL || !btrfs_dev_is_sequential(device, pos);
 }
 
-static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
-					u64 physical, u64 length)
-{
-	u64 zone_size;
-
-	if (!btrfs_dev_is_sequential(device, physical))
-		return false;
-
-	zone_size = device->zone_info->zone_size;
-	if (!IS_ALIGNED(physical, zone_size) || !IS_ALIGNED(length, zone_size))
-		return false;
-
-	return true;
-}
-
 static inline void btrfs_zoned_meta_io_lock(struct btrfs_fs_info *fs_info)
 {
 	if (!btrfs_is_zoned(fs_info))
-- 
2.26.3

