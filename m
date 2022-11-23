Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19FE636D4D
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiKWWiG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiKWWht (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:37:49 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954F5183BF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:43 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w9so112983qtv.13
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT2mM25lgFrGB/loZnbI4/1hEaSUKp9iCXTzfgSm4cU=;
        b=7dKrbekBAdT5zcKxyCn6mQitPr+IUbmkO3D+KvQXLbwEYmKpqu7Zk+yzxDbN/TEuql
         Gc5RujfdkiqOPNOMTq0vf7AWKooRzkGLpbhA9qw7swnian9Rf3msnADLlnfbfEBQz1k/
         fm8B87OZCb8xS8BDx87OJhvPNrMRZl1sz7tMbmzSMG9YmUAVkCns4SJ+LbWbm7SBHQlB
         CLUpNZN+aO0pRSUJu22zuMCj24baVEFENdnz7YOYttSu0KPtO3tK7GDcrxXqGmrWeikW
         ztS56CV/mOzqkBdWByMNHRlKQe5H/LNlurXnV+qTlpfR9o18MMlQNHTIqYDshubgR5XS
         2ZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT2mM25lgFrGB/loZnbI4/1hEaSUKp9iCXTzfgSm4cU=;
        b=FIiaFDRpvxGf11Q2vDp0u1MM0uFlWLeN81oyfvK1YQ0uBa1RpRQroN85cCL5Q+9qQ8
         qPum/rn8+CRjsCZYEOYmD3xJo7UIn4qn3yasRhitps/9qIXUewPf761u1/8gM7tfL+ar
         YX0vJJCWwu9MXSY0+FY5bNhaAOhRIe2MBP0jb0dfiOEucaYxN4kds+65Tb+u+03lGLjw
         kpUCj7Yg8a66vQjDomne5LDV1222QEEBFcMh1A0i+XM44FBZ8Q9NPjeOiWILMFlkjBDe
         hJU7eGA8MYBHi6U4xLDsnmJstVU3zdhDdRMJR83PU6AOa3fmokrGLIhcwTWBgYK4zeZQ
         y+Mg==
X-Gm-Message-State: ANoB5pkma1eshNDExwLwl7vGDhj/VFomzTWT9eZaa+h7llCVxFjTsFU9
        IL8aKRrSZRMSfxftAXuGdbPRCx5l0P/9OQ==
X-Google-Smtp-Source: AA0mqf4mn2TVFeNs8mtsixIOE+8d0YfhX0tMujg8e7+lg+Wfyt03B6ILj7MdiCQHWlONtEKYSSaFWg==
X-Received: by 2002:ac8:687:0:b0:3a5:41fd:2216 with SMTP id f7-20020ac80687000000b003a541fd2216mr29251871qth.338.1669243062190;
        Wed, 23 Nov 2022 14:37:42 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u10-20020a05620a430a00b006fa617ac616sm4463062qko.49.2022.11.23.14.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 02/29] btrfs-progs: fix make clean to clean convert properly
Date:   Wed, 23 Nov 2022 17:37:10 -0500
Message-Id: <fee273e52a96c2eaa4783573b20544901c83993e.1669242804.git.josef@toxicpanda.com>
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

We were not clearing the .o files for btrfs-convert as we had the wrong
directory, which meant I missed a compile error that happened when I was
messing with kernel-shared.  Fix this by making sure we clear the .o
files for convert properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1777a22e..475754e2 100644
--- a/Makefile
+++ b/Makefile
@@ -795,7 +795,7 @@ clean: $(CLEANDIRS)
 		kernel-lib/*.o kernel-lib/.deps/*.o.d \
 		kernel-shared/*.o kernel-shared/.deps/*.o.d \
 		image/*.o image/.deps/*.o.d \
-		convert/.deps/*.o convert/.deps/*.o.d \
+		convert/*.o convert/.deps/*.o.d \
 		mkfs/*.o mkfs/.deps/*.o.d check/*.o check/.deps/*.o.d \
 		cmds/*.o cmds/.deps/*.o.d common/*.o common/.deps/*.o.d \
 		crypto/*.o crypto/.deps/*.o.d \
-- 
2.26.3

