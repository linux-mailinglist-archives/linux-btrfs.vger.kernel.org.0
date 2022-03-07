Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CA54D0AE7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343705AbiCGWS5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343703AbiCGWSz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:18:55 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7099F43AC1
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:18:00 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id b13so13255352qkj.12
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6gCPFFfPkKFhDPJWVrL6vWdJOSv7pkxv68N3CKGljYg=;
        b=cZkBHnJlygtP6SLzMEeK/P6ZbLx+D+57c5n8sUIjcoB/eYAqe1v8I7235Cz3MWBQeJ
         ah4lKhmdph3RWlTYtmNG9xkS6sCgAQjWzNe2XZSJK/GtTxS1IXz2x6SM9NQx2qReV/9w
         qXAAdH5GyE/OdHPJCMievoBotjNvlZByvdPrV2cRkhziF8VOj9BV1BkS/C5ZMeIyl/xv
         B6IYAeHCquyR8i+qb9X7FIBz35gKnxBiDPhGsJF4guEuVL7qqaeKVRJi+QapigQwOijK
         Xdh7SjcmOUy1DyWu14B9Fz2YLuZxTw18UjaIuB840Y8IC9pQjAsnQ3YBnyhnroRZAxZQ
         n6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6gCPFFfPkKFhDPJWVrL6vWdJOSv7pkxv68N3CKGljYg=;
        b=eHh6evk8eDpNlq0pCupHTsxyep1/5sqKsRlGfRyTwo5uUciHe7pnecptdz65r8DaZE
         C0J/7M34iNhMLgotz/1LN6dFyGuaw7Tesu0dwHe7NSfqxonMOrfyMBG2TdcaKHgS1u6+
         6CfMfq0hbBVTHujsTev8C/VL1Etz/8sivKu/AX5RxE7idqcX23zqhJaPhF+0N/J+hQzM
         cVnsps+OHIcMDYgMPvI46/WXf6UKOc25FNqe4wByVeRGJNlAkO9Wxox5RsTJVOPKax+S
         flWothWuz9wxiU5RYuGC6x03hqP6d9+insISbaaOolIWWTdng/w+XueQpJB1eMMyaHaM
         yuow==
X-Gm-Message-State: AOAM531FNnwakNeD/xDbekiOFGsTRZb2dRdevsduOEjVqc+ASDQJUIOm
        3H3GukpDf9vqhGy4ziuYLSNJF/nAIan0oa+L
X-Google-Smtp-Source: ABdhPJwQDMjkwf8zLxD+U2Zm1eRU7bGJCATprB2M0rk3fXFHqmeQTZoHFRtsRojSs1U1cWSV1rnavA==
X-Received: by 2002:a05:620a:31a2:b0:648:c4f7:118f with SMTP id bi34-20020a05620a31a200b00648c4f7118fmr8350073qkb.600.1646691479284;
        Mon, 07 Mar 2022 14:17:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k10-20020a05622a03ca00b002e0684cf81fsm2418693qtx.73.2022.03.07.14.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:17:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/15] btrfs-progs: fix item check to use the size helpers
Date:   Mon,  7 Mar 2022 17:17:40 -0500
Message-Id: <19014616da62a01712410885ecf4d43911da151b.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
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

Right now we're duplicating the math to figure out the maximum number of
items a leaf/node can hold for the sanity checks.  Instead convert this
to use the appropriate helpers to that it does the correct thing with
extent tree v2.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index e5ad2c82..bd316b46 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -45,14 +45,13 @@
 #define BTRFS_BAD_NRITEMS		(-4)
 
 /* Calculate max possible nritems for a leaf/node */
-static u32 max_nritems(u8 level, u32 nodesize)
+static u32 max_nritems(struct btrfs_fs_info *fs_info, u8 level)
 {
 
 	if (level == 0)
-		return ((nodesize - sizeof(struct btrfs_header)) /
-			sizeof(struct btrfs_item));
-	return ((nodesize - sizeof(struct btrfs_header)) /
-		sizeof(struct btrfs_key_ptr));
+		return BTRFS_LEAF_DATA_SIZE(fs_info) /
+			sizeof(struct btrfs_item);
+	return BTRFS_NODEPTRS_PER_BLOCK(fs_info);
 }
 
 static int check_tree_block(struct btrfs_fs_info *fs_info,
@@ -60,7 +59,6 @@ static int check_tree_block(struct btrfs_fs_info *fs_info,
 {
 
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	u32 nodesize = fs_info->nodesize;
 	bool fsid_match = false;
 	int ret = BTRFS_BAD_FSID;
 
@@ -68,8 +66,8 @@ static int check_tree_block(struct btrfs_fs_info *fs_info,
 		return BTRFS_BAD_BYTENR;
 	if (btrfs_header_level(buf) >= BTRFS_MAX_LEVEL)
 		return BTRFS_BAD_LEVEL;
-	if (btrfs_header_nritems(buf) > max_nritems(btrfs_header_level(buf),
-						    nodesize))
+	if (btrfs_header_nritems(buf) > max_nritems(fs_info,
+						    btrfs_header_level(buf)))
 		return BTRFS_BAD_NRITEMS;
 
 	/* Only leaf can be empty */
-- 
2.26.3

