Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DA55AB95A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiIBURf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIBUR3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:29 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DE4D7CD0
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:28 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id h27so2596903qkk.9
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=pJaO90J+KIVu2AkMg0BstJPyn9eCjvbtqQaAMqhFCZE=;
        b=D131+0kVpTQNSKLhk7pIlhCfai/FiKB3NemwVfSyiYrAN/oIdHmE6BCw9mqImC12Cf
         dMZsL8iYnKKXejUMOw5Cgnf3ZG5fC4gRCj7G63SzBdNO3IShpoDLX9dWZPA/Dimxy7Sv
         mcabVneZeSlE5CpAynFhBgutBTCv8Xns7VmUHzAJgfeR1LMJAa//YUbWmsisRLt1v5lU
         sNjS14Xa7sc2n6n3Pc4czIfq3ZhbNO+gxQpXwW7zy6WORZV8IIuiBqRiiktWc12540CO
         lyBWzBl+nn0x+Pbl5ssi/9y8wl3a5nDjbeNZX5KQLZZvsCVI7VGyDgf+kv7pYKrcln18
         21Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pJaO90J+KIVu2AkMg0BstJPyn9eCjvbtqQaAMqhFCZE=;
        b=0cYDUHwJG9FKRi+1x3sEqh+i8ase4K62aMeQrtp6/Uclp9Q1g6J0AcFDq2FuKqo3ct
         vG2FTZFlJGbcoEwaYkwg23vYvYBYQGqDb/IHjNl8VMbHigyxXKAnSdXpXVyCP84fTjxf
         VLII9lUrJTy2j6snEE5hmH1QQ0R25k0udjQI5anxNIoVWRYcACm5AT4nPxqHaeUUw/Zi
         5kPAFLDGyE2KGx/PL7/ldcapqh15dpW6A5UlzTCOO4SqHCqvUOKg+6Mtm0tuWhUC0gxQ
         gDKDpPcaIoqPE7ePscNDSTj19U0S6DZrQUC9idHq+5nSTTonRoN62C3gtA9NNFZLzAcC
         LPsw==
X-Gm-Message-State: ACgBeo1ezcuZfZnWJac3pLE3UChlLsuuW9NbUx+y6Zp/0aYOoQY0Lonm
        x3cM8cMBGOQmi4s6KsbVPbMtlx61yhsWfA==
X-Google-Smtp-Source: AA6agR5x9iC6eAQR1IHiJZjL714xI5yS12PMRAgfUcNOhls8ikUj/yD6pmVUiVtQivfmx+5rc1UbsA==
X-Received: by 2002:a05:620a:4587:b0:6bb:a6c6:14c5 with SMTP id bp7-20020a05620a458700b006bba6c614c5mr24004238qkb.362.1662149847292;
        Fri, 02 Sep 2022 13:17:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x9-20020a05620a448900b006b5e296452csm2253378qkp.54.2022.09.02.13.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 28/31] btrfs: don't clear CTL bits when trying to release extent state
Date:   Fri,  2 Sep 2022 16:16:33 -0400
Message-Id: <ceee5232ba282c91af38ac917430221a6707ecc5.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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

When trying to release the extent states due to memory pressure we'll
set all the bits except LOCKED, NODATASUM, and DELALLOC_NEW.  This
includes some of the CTL bits, which isn't really a problem but isn't
correct either.  Exclude the CTL bits from this clearing.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 92244f3370b8..849ecccca53e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3389,15 +3389,17 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
 		ret = 0;
 	} else {
+		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
+				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS);
+
 		/*
 		 * At this point we can safely clear everything except the
 		 * locked bit, the nodatasum bit and the delalloc new bit.
 		 * The delalloc new bit will be cleared by ordered extent
 		 * completion.
 		 */
-		ret = __clear_extent_bit(tree, start, end,
-			 ~(EXTENT_LOCKED | EXTENT_NODATASUM | EXTENT_DELALLOC_NEW),
-			 0, NULL, mask, NULL);
+		ret = __clear_extent_bit(tree, start, end, clear_bits, 0, NULL,
+					 mask, NULL);
 
 		/* if clear_extent_bit failed for enomem reasons,
 		 * we can't allow the release to continue.
-- 
2.26.3

