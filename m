Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147E83F0D64
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 23:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhHRVeR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Aug 2021 17:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhHRVeJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Aug 2021 17:34:09 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B20C0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:34 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 22so4785476qkg.2
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Aug 2021 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ucsvVayXzM8TAR4Dtcw0ycObH8tG5BWbtmJCrRdXMwM=;
        b=ejxXKKdW7l7wWcw/Lpb7Jg+fT4w5FqpdDAcFY2p/zUB6bYSd5tZhLBFHDHnDnovwbP
         HmKtDzXAYUDyCIulx9SSo/Bh2LNWwGlS1PnLxSJVZnF7vbLx1cr9gbNGwaFztugaisui
         dKNHvIIEFxlRfi83FBcY3GeyQk3UWSn5AUcS8JaSSdUu8EWD2dEWUNIfhX4amAjeaiCV
         NyFWD4+sYI/z/Pl+KW7BjmomuinHREHJ3GOnN4QCIbb5ADbQKLxIaQS0zA2OvFkc2dQR
         i6VYzP9YVwYiSNI98jLIVLEbUDotTuttd07BGhd4tphIRuNvDeuIu7Pak3kJTheqvnAg
         46Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucsvVayXzM8TAR4Dtcw0ycObH8tG5BWbtmJCrRdXMwM=;
        b=hyX1fzLAiukJk5oXXD1TvSVLqj5FMBNO8tr4cq28PGWsqkO9p6t0gTXTMWM1OE8Nhk
         J+rKlEsTPYKWRTUyyPL1RbB4xvORiWnoSFMxVcRTj0yM+lcyNLF1971wpv8mEYjWo6rf
         PwM8G8CK6HmdWjJcGoxRqqVnrHqx0ut+C946lNEgNwcFAZvnkuKAYGgsLsK/y4wyW2us
         D9Ihzc7psPX+ivcvbI/MR2IGJ6CsgZwsFhnRYdjcJ+Opur09Q9AbyOJJ+xgpXnBnBiin
         iyac3t9s3dKHsfwMMu4DNmZPDzBFRzOUjSf78bjtrrEV1lADnJCls6T3ZwcTTLwwZINd
         DIzQ==
X-Gm-Message-State: AOAM530I935IzGEDZc9UdEd41Qt2nqDkRa880RpOi0Mnu8/THQtlP90g
        RzFknZEg2Am/R3sgU5SsRv6Dcd1Viynh6w==
X-Google-Smtp-Source: ABdhPJwQwpYoq4tZ4ISxdNs7iBVLaTTK4ecpuloLjheZeS2uqN9gY3hD2EhXvvfx875h/pFEJQCfGg==
X-Received: by 2002:a37:8906:: with SMTP id l6mr391943qkd.210.1629322413030;
        Wed, 18 Aug 2021 14:33:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 37sm555445qtf.33.2021.08.18.14.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 14:33:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 04/12] btrfs-progs: propagate extent item errors in lowmem mode
Date:   Wed, 18 Aug 2021 17:33:16 -0400
Message-Id: <06d91ded263de8668fdbb72d86eb26ab4dfaec45.1629322156.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1629322156.git.josef@toxicpanda.com>
References: <cover.1629322156.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test 044 was failing with lowmem because it was not bubbling up the
error to the user.  This is because we try to allow repair the
opportunity to clear the error, however if repair isn't set we simply do
not add the temporary error to the main error return variable.  Fix this
by adding the tmp_err to err before moving on to the next item.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/mode-lowmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index d278c927..14815519 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4390,6 +4390,7 @@ next:
 		goto next;
 	}
 
+	err |= tmp_err;
 	ptr_offset += btrfs_extent_inline_ref_size(type);
 	goto next;
 
-- 
2.26.3

