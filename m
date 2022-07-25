Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377A558043C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 20:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbiGYS6m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 14:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGYS6k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 14:58:40 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E308DE80
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 11:58:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 12so10951880pga.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x7FKOR3rx2/0e455L1nk2BefuwfXdYmT+tDpoOw/d7M=;
        b=BqFT68YO5N6x9y8+tCXgUfI5+aHtdbXc9bSTjzLCsavYmvxeJxRWbKVzLh+/muqinX
         bMkMFHPahBA8T5cJbMC0PwHzHMRZI9xmIP6/8miL0M1XTBjwhoeh5Iq0iHTfws2qvKVw
         ClUAa7TV3K+lvQ8/4G8MFevtGHs0iremWEozKKA+B7t8VJi9RbI6imiXN/H++j458EFw
         24RKPoshKoxDAvHvGY4isJ0dCRatBE+dmSdTBZ5jmYB+4Q+wAICMLjLu3O9vI/PDOoce
         ScatPvECPTQU5ukSejzwkO/DeELN7t1d9Jfhg7qq7TPHCppT4VIsBgL7Zx8oMG5isQS7
         EDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x7FKOR3rx2/0e455L1nk2BefuwfXdYmT+tDpoOw/d7M=;
        b=rVt1IGVVd9ehLseCs8ClEuP1qtEhAVc1h8G1U8yh8yPF0lUfH+/JoBtjx6ckELKZrd
         u9zpPR806DnBV5Vu7tWD4ZwYCgDXTW5y5KMlncfttPuCResW9eeHIR88caeamz1KpqrQ
         c30ux1U/XJKHSacaECRtIZDPXZhAJ9K/OjtykWCYaZT9DyO+drvnfkaKak+51ABX+PEW
         i6SzTcQOLup76gm7C2sjzc0cmbk5c1WCQaapr7FTlxx4ylJkqPvQ2bl98ieULTGPR1j4
         yMuupQPYDJMDMu15+v+F7211R8EM6RGaBzAu/bk05X5o0BhVjni12WaDlwkVrnz76iK4
         dpHQ==
X-Gm-Message-State: AJIora/5YHh+cl9IocvA/vABYahH16SIqCRYrJ4nhISWuUb0vpL0no4+
        qy0L7tIIH4eoY+YwMSiQo/58+YQQQVCbIQ==
X-Google-Smtp-Source: AGRyM1vuVX/G0nd2+Lf1EJRw7bF/7jt+2BkrmQIZEcAQQQJuaTOGLdTsvGPQBnN/IuHWiR7Uwp5/EA==
X-Received: by 2002:a05:6a02:44:b0:41a:a606:1910 with SMTP id az4-20020a056a02004400b0041aa6061910mr11793491pgb.121.1658775518643;
        Mon, 25 Jul 2022 11:58:38 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9200:a0f0::a78c])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b0016cae5f04e6sm9487783plk.135.2022.07.25.11.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 11:58:37 -0700 (PDT)
From:   Khem Raj <raj.khem@gmail.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] device-utils.c: Use linux mount.h instead of sys/mount.h
Date:   Mon, 25 Jul 2022 11:58:35 -0700
Message-Id: <20220725185835.1356165-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This file includes linucx/fs.h which includes linux/mount.h and with
glibc 2.36 linux/mount.h and glibc mount.h are not compatible [1]
therefore try to avoid including both headers

[1] https://sourceware.org/glibc/wiki/Release/2.36

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 common/device-utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 617b6746..25a4fb8c 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -15,7 +15,6 @@
  */
 
 #include <sys/ioctl.h>
-#include <sys/mount.h>
 #include <sys/statfs.h>
 #include <sys/types.h>
 #include <stdio.h>
-- 
2.37.1

