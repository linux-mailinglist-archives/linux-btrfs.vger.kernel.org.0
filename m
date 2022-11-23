Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A597D636D5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiKWWiD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKWWhs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:48 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D801835F
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:41 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id q10so2213845qvt.10
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vub/YGyob+lvK8mviiw67Vt9Borg9BoCnIRVylzUkCA=;
        b=yOXtQzooJ0Ackq769KAjCeHNlDeguBFyRt46faGo0wkK4pf0rY3P8gouBKF4uR8aw9
         YOFaMQOmSABGUaF/NvBSe0f0pCUfv7+y0PbXVemuUiFDbXOEiOUYpPkw2c1YJgztsg/m
         9vVHtNNUirseNS29Vzm6DlvqyNAupScT1VX7y03wUOyjB0tSFuYBphVvlOgX26oN3bzM
         92VABWUMjNhKv+0gYmosSccewbIY6OVGudGzVlWR1SOdsYJKmvYqMMLMiNOI/czHGnul
         Y8LTWNvK9UZPwjmarVQgghotI7PWYau2WX8Z0uB16Pys3iaTqNI1CbBVRc9zAcX+adVk
         yr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vub/YGyob+lvK8mviiw67Vt9Borg9BoCnIRVylzUkCA=;
        b=nJ5tZHBSRCL1qrBtWMNBeZ+GKdOTHT3rSoGn/WA75Hjz3ScRv2Qz8jtTYPStlLSJhT
         8WM0qW7vaEQRV0uAD9NtT63t7Mc3suHzyEcNHWx4bYd5M0vKm7mtfchcaO9sZ1Yzc0b1
         tuO5lXFm3akYAHjtdw4/TdAbQXZ//5V+vJLp0u3VWgOtc84IoZ4BYVx1mrZhNTMHIfiS
         xUIGEDd8gm1ZDPUz8VN+2vSwpfC6l30KceN+qEzZYBtXCqF2ontrMsug9Ehm2ltpVfnT
         8DKOx+fl0zh//OzHFYJF8KbJpbxxr3U5KpYdnCREBoBHdljL9OQOevyqEyfiVfon5dOQ
         HSGg==
X-Gm-Message-State: ANoB5pl1yCRkJXvC6CzyjggGMT+nNN0rucDt0TvV+FeVolciAHUv+Lgh
        dch2tC+mrmo5j8ISFET4WR8LdN8/H6IeUg==
X-Google-Smtp-Source: AA0mqf6aJdosbFC8prJlqXg/+47/aRxj7oASswqqJODRlBwyiBXgs+15P+QTRns3kfZjHI5+LBbOUg==
X-Received: by 2002:a05:6214:14eb:b0:4c6:b062:c619 with SMTP id k11-20020a05621414eb00b004c6b062c619mr12421797qvw.107.1669243060050;
        Wed, 23 Nov 2022 14:37:40 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bn4-20020a05622a1dc400b003a62dcf09f0sm9069529qtb.6.2022.11.23.14.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 01/29] btrfs-progs: turn on more compiler warnings and use -Wall
Date:   Wed, 23 Nov 2022 17:37:09 -0500
Message-Id: <ce81309292ac0b5d445e4d7e2b269fc3d0e85d32.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
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

In converting some of our helpers to take new args I would miss some
locations because we don't stop on any warning, and I would miss the
warning in the scrollback.  Fix this by stopping compiling on any error
and turn on the fancy compiler checks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index c74a2ea9..1777a22e 100644
--- a/Makefile
+++ b/Makefile
@@ -94,6 +94,9 @@ CFLAGS = $(SUBST_CFLAGS) \
 	 -D_XOPEN_SOURCE=700  \
 	 -fno-strict-aliasing \
 	 -fPIC \
+	 -Wall \
+	 -Wunused-but-set-parameter \
+	 -Werror \
 	 -I$(TOPDIR) \
 	 $(CRYPTO_CFLAGS) \
 	 -DCOMPRESSION_LZO=$(COMPRESSION_LZO) \
-- 
2.26.3

