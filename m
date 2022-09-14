Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507AA5B90DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiINXIL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiINXIH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:08:07 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7144288DE9
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:08:06 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g2so9235520qkk.1
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=4vscmGDixQrgZjf3tzecMOiNjfQewceZNEZsDEmJz74=;
        b=lpfRNv0U+MIm6nwGlN63Eef9JjoVUAp9LeiFp9zEqtwO77EkEpSe/+OCc/tdn5kIn3
         RyL9LxiEWlcBgPYbjmw2rrV6VxGIeM6hR031fE+m90g9f8CD3EUNyG2r9kebG09v7HMf
         ughu9890TcmmMCQJSxgEVwZnf2tKfxNR0zxDZqsQ5cHoOMgmh0Hxf2UjTJOSPKgdmq+t
         oKd/jtzIQ/5cvS87ssDQHtJlMjF68yR7OygJY9Fy99h8rlhhE57gwJqjHgcM0nWxNWL/
         J3E9JIkcZNA1JuInYIUKcEgWQUiVM2Sb0JcbtAccFCc/32XpjGPgrOdGrf7+dBpTNQ/A
         DJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4vscmGDixQrgZjf3tzecMOiNjfQewceZNEZsDEmJz74=;
        b=IPcTnm4SvNyBvIED7QA1hZK/xRUjtd2PmAWlS0tAjzajkCDTHcrKXV4N0MqAiMdKEB
         5moikRohQIpYjkg6PwOB5qtu3LXKKnaNXgyAKsncOL+yV9INvkaAf2ijd2wmEBfZ6v1I
         Bf79pocqzD7XMSJ1w29bLUlSN0OFeKQHbzIV1pAHXxdTMVIxK7N+53e9T+1OtXmiFJz7
         Zml7yVZ+NVvhAxBUK60gzPHLK/iQa9N6fQGGS9W9xbNiPUzebAJKXgifE7UAiQMpbrRO
         ZbZbEm9bc5/Yq4nVTBXVfJ2gZizIcNfjmEhHZ3r3vif33QXKJr+heDU6pFiYp1QG0ars
         ZdMg==
X-Gm-Message-State: ACgBeo1S5uW8ob71OxvaJkVT6em/kiW8hWFJyFBeb7w2yqQFUtrKEI7D
        tFeeU2bC4yMt6gNSiKmOwlXDJJ2Ok1K+Lg==
X-Google-Smtp-Source: AA6agR5paK80xF/bXoDm19yrTBOOqgoVMoSXQav1vrZN/rQZ7rcN7tI7SI4PL5edgkZGhk1ofHUs/w==
X-Received: by 2002:ae9:df01:0:b0:6bb:4e95:6a59 with SMTP id t1-20020ae9df01000000b006bb4e956a59mr28229640qkf.339.1663196885048;
        Wed, 14 Sep 2022 16:08:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id ay7-20020a05620a178700b006b942ae928bsm2718052qkb.71.2022.09.14.16.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:08:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/10] btrfs: delete btrfs_check_super_location helper
Date:   Wed, 14 Sep 2022 19:07:50 -0400
Message-Id: <b3b607429c224b37bf77571a3759a0c5b15c71bc.1663196746.git.josef@toxicpanda.com>
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

This checks if device->zone_info == NULL or if the bytenr falls in a
sequential range, however btrfs_dev_is_sequential already does the NULL
zone_info check, so we can replace this helper with just
!btrfs_dev_is_sequential.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/scrub.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 66f09202ba96..9d130e13c6b9 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4140,16 +4140,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	return ret;
 }
 
-static inline bool btrfs_check_super_location(struct btrfs_device *device, u64 pos)
-{
-	/*
-	 * On a non-zoned device, any address is OK. On a zoned device,
-	 * non-SEQUENTIAL WRITE REQUIRED zones are capable.
-	 */
-	return device->zone_info == NULL ||
-		!btrfs_dev_is_sequential(device->zone_info, pos);
-}
-
 static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 					   struct btrfs_device *scrub_dev)
 {
@@ -4173,7 +4163,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
-		if (!btrfs_check_super_location(scrub_dev, bytenr))
+		if (!btrfs_dev_is_sequential(scrub_dev->zone_info, bytenr))
 			continue;
 
 		ret = scrub_sectors(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
-- 
2.26.3

