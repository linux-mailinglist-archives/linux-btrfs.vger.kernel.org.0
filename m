Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D7F6263A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 22:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbiKKVaX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 16:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiKKVaV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 16:30:21 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CB7DEA2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:20 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id n18so4096506qvt.11
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 13:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vub/YGyob+lvK8mviiw67Vt9Borg9BoCnIRVylzUkCA=;
        b=i5NSlVVl9/wRm/GxSDstJHFWDSNXU6+6fvr/FZf1aTDo+uXuh45lEVne6FKUpKUDpL
         Gp/YVrKnzDx7LGP73+XWDtIRstpVpFVt3xBXEiB9AB1fEJco5ZwyPYY2cTg3Wm3olnOC
         FfedJdUhN1FyLbrBc1em0a4d9GlGjKeub2TxKC+nIOPBOn+sZsI4VflltwguTEhk6Piq
         WDHkI06ri0gQ4YrQ/SZjnSzA9HfDDA2STIAZ8vrp1ugcD2sVVmxBV2y6SdxF4l+NhldA
         DIFm+Z3iIT788Ti5XrU3MehAfi9QxZqOX3fRZVtPEbg7y4sIPFNtcEWjPKmjyk3Wn1zJ
         Maew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vub/YGyob+lvK8mviiw67Vt9Borg9BoCnIRVylzUkCA=;
        b=jArt97wgJ0J8GPuXyrNvWYKU67Cj7VhyUn3NHk1Jh2pGVYncD8ZNMKDurkQwmyNk9p
         Tn+E0nEVARSN5lGH68XTkEs0LksUGBKUE2KfAsvRMpRuWg/o5vldR1o3VRI8Bw7UHO4M
         vpNass1sAWLic9bwo3Jd3A4UykyaMYZc4M/aJWGUmfeGAXkiUF8pFvsb7QLlgwOaSgCK
         2ecLRAI90wdGWrlAu8jaqwyxraaS8GOK4C8Kkf7X8Mfj3zrKcHjn90AUGtiY+j6iotzI
         mUhQL0ZIzF7fQLm4At4niFzYO6d6JpJi1QR7i6q9f+dgwiptePqEe8vOByt1+Qw/zEq1
         XacA==
X-Gm-Message-State: ANoB5pmWGyWTYOlkEP+FCoIn765MTIzcxutc8q1Z2cF/jzZ8vB9ocau5
        finG2tEyyCGftlyDKc2u+HsRPYv1RgRRmg==
X-Google-Smtp-Source: AA0mqf4KzM+hO9aD+cd7lpqrL0i5Q/dUUwwARU+R6tLeor4YSxrbhf4h3NaKpE+Ngftpda7TMVOoGQ==
X-Received: by 2002:ad4:50ab:0:b0:4bb:5b85:5591 with SMTP id d11-20020ad450ab000000b004bb5b855591mr3690388qvq.59.1668202218511;
        Fri, 11 Nov 2022 13:30:18 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bs40-20020a05620a472800b006bbc3724affsm2089296qkb.45.2022.11.11.13.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:30:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/14] btrfs-progs: turn on more compiler warnings and use -Wall
Date:   Fri, 11 Nov 2022 16:30:02 -0500
Message-Id: <ce81309292ac0b5d445e4d7e2b269fc3d0e85d32.1668201935.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1668201935.git.josef@toxicpanda.com>
References: <cover.1668201935.git.josef@toxicpanda.com>
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

