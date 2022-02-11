Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF14B275F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 14:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350643AbiBKNsj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 08:48:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbiBKNsi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 08:48:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868DEB
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 05:48:37 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso8950002pjg.0
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KFEJIX68QyVtmeqUytOazbzsjlrbylCgiHnYIfrHSVU=;
        b=nRL/Z/wPJcZS+COy0DxLjYCc2MDzDSROoDWwdMPZhOUVCKi6Wl5hA4RfmILXHS1HxG
         mPyhdztCq0qVzXSIqnQGPW6LJAGvptZku/Sa24JGKgffO5LmggdofLg/BpSDtMVIiO8P
         XS/UJkGIUDAO6hTFH9q9r1X6K+HR3EdM97YoXokeUyUDuqITv+yWTGkAWhYO2aCkuC0X
         Aj3InpxyFH9sXUUYRGX/k+q1qLT7lr/5By7CEaE33d/gmXIS361jt2RqvjSR6d5o19G1
         FtMTyGP6DzlSMlSRHpQSwnUxww7nYEzBG8sOdQmMaCDbeiAhn7BnDOJ1JgQ0hyIWxeUP
         BjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KFEJIX68QyVtmeqUytOazbzsjlrbylCgiHnYIfrHSVU=;
        b=qOnyb1HZuqSRu7gCMLNTjAz9O9hMZL00cp4YOMrECfTmwM/ANtGfpXxvAsdAzcU/tu
         o9NfHJiI5nnPoQ2HAjNJ2vOfNHdTTK1N7uZ4KnV/IF++/R1ldzE8j5g2wzo962Nidu2i
         ZXEqcDZjn4JPnVscqDQihqIkJmiXE5PAyZJOeaNmjyqw+96jjZDf8agbBD3QNMlzl35i
         BIKhK7SMi2bQZiF3XALfVV5UMhjo12GTq7NlcSku2/33Y8yOWoSjOY9qoqf60tykAPu9
         P3+j2r6KYI8xH5ekHLSsPeYt9z/83zWIcAJ18LaSH9J5Fuaimzk+EZ9yeWTRHv9franY
         hDiw==
X-Gm-Message-State: AOAM533wK9GAbEQ/DWALPN5H3PjOpsui76hCEGGzPFqtSdG1AO1Y47TC
        C3E9kA+WM1TnZEkLmfP2FuOiX07dcxQ=
X-Google-Smtp-Source: ABdhPJzkdh7+6D9BWBeCnKxDG3vt1St8nVzGKuEUY/vSL6o/kvcDIaVMbjgFJBNx0JNlxtGnmwo+ow==
X-Received: by 2002:a17:902:7fce:: with SMTP id t14mr1666789plb.101.1644587317126;
        Fri, 11 Feb 2022 05:48:37 -0800 (PST)
Received: from localhost.localdomain ([59.12.165.26])
        by smtp.gmail.com with ESMTPSA id g12sm10945698pfj.148.2022.02.11.05.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:48:36 -0800 (PST)
From:   Sidong Yang <realwakka@gmail.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>
Subject: [PATCH] btrfs: qgroup: Remove outdated TODO comments
Date:   Fri, 11 Feb 2022 13:48:29 +0000
Message-Id: <20220211134829.4790-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These comments are too old and outdated. It seems that it doesn't help.
So we can remove those.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 fs/btrfs/qgroup.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index bfd45d52b1f5..db527c277901 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -25,17 +25,6 @@
 #include "sysfs.h"
 #include "tree-mod-log.h"
 
-/* TODO XXX FIXME
- *  - subvol delete -> delete when ref goes to 0? delete limits also?
- *  - reorganize keys
- *  - compressed
- *  - sync
- *  - limit
- *  - caches for ulists
- *  - performance benchmarks
- *  - check all ioctl parameters
- */
-
 /*
  * Helpers to access qgroup reservation
  *
-- 
2.25.1

