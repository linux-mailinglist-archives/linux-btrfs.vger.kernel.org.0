Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4564F240
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 21:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiLPUQT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 15:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiLPUQQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 15:16:16 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CC9659B5
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:13 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id jr11so3594135qtb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Dec 2022 12:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuaPXloxLhAftLUFO5H+ZxRIJ1ioDiYP8OOa8CufXVw=;
        b=Vdk+ROI9+zPolLsEFnqa7XX3bgap2URPsCrjGUItbQBOJm62nhHG3Oq8omfa840USy
         ZbGlvV+TpW3MNu8tShwlKrCEJvo4itbS4eEDqMZkMWk1XTxLqbRu98l+YAHR3lHEJIhc
         3w4leEEW8Gwx1Ebh89iHD/W4eTDl9JVyP8OLCjND9DWS6w6ndvYVIu5+YHli6zcBHg72
         QfMTsAxYrIpCfhp9mTIIxZqViijRaQ4g6kfMta6Q0b6aLu7vnbKA+BCJrbwrzwH2BZHF
         LuOuDuMU8YEybwy8SM8TLVyYWmkcXBq1y3MbVaSHfNEPrgtMyOfOwr8c9OfV7tZOudB5
         EFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuaPXloxLhAftLUFO5H+ZxRIJ1ioDiYP8OOa8CufXVw=;
        b=TaoRrsBbEhDMqQNRHDEoz1GJIc9RRyjNy+zmjX7YZqAKyRSPNHImLSkkFD9KlYuB/1
         n+I7x2pihj1X9qEQbu8d+JzEWy3Fs7mD8CresVohbhdAIlUGYYKYtIwwEku/7AsGxk15
         PQDVA47tQ2xy2rgHXeJCTumzYDSZskSnKRhmhxwpGDpCFJ9cgBoi5a7UbPdoYTq1bZ9P
         3Xl52n12aAalcR5MVNsgNV4/2wnD8eQKJc00UcWBgqIGnesJpmrr+mR2VqnY6djYahN+
         iHH5RXOYtM/9uTCOC85D0ztAgZ9r5PGpQ/qwIXcoXAjKiD+Px71+DDZymDPiHtWdqb5i
         j72g==
X-Gm-Message-State: AFqh2koeExB2ScVhdZZka0Y0ggTo8yPJ1C2GncT8ZfSG4Cv6MxbOPxPa
        8DNaTV/hPRCyXYRIeC4fwd2T9+5oqbV0pQVN+cY=
X-Google-Smtp-Source: AMrXdXtvHk7X41DyI557Rl/38pEJFEi54YOJNG5qoIKT8SbmgBC6zyhTedhb2lR4cgDVf6XpUZFrOA==
X-Received: by 2002:ac8:6683:0:b0:3a9:6b73:fb91 with SMTP id d3-20020ac86683000000b003a96b73fb91mr8862154qtp.64.1671221772111;
        Fri, 16 Dec 2022 12:16:12 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id fu25-20020a05622a5d9900b003a57eb7f212sm1849891qtb.10.2022.12.16.12.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:16:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs: turn on -Wmaybe-uninitialized
Date:   Fri, 16 Dec 2022 15:15:58 -0500
Message-Id: <1d9deaa274c13665eca60dee0ccbc4b56b506d06.1671221596.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1671221596.git.josef@toxicpanda.com>
References: <cover.1671221596.git.josef@toxicpanda.com>
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

We had a recent bug that would have been caught by a newer compiler with
-Wmaybe-uninitialized and would have saved us a month of failing tests
that I didn't have time to investigate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 555c962fdad6..eca995abccdf 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -7,6 +7,7 @@ subdir-ccflags-y += -Wmissing-format-attribute
 subdir-ccflags-y += -Wmissing-prototypes
 subdir-ccflags-y += -Wold-style-definition
 subdir-ccflags-y += -Wmissing-include-dirs
+subdir-ccflags-y += -Wmaybe-uninitialized
 condflags := \
 	$(call cc-option, -Wunused-but-set-variable)		\
 	$(call cc-option, -Wunused-const-variable)		\
-- 
2.26.3

