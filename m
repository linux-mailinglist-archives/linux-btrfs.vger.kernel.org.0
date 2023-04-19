Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956376E832F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjDSVOF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjDSVOC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1754A4C1A
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:01 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-5ed99ebe076so7846d6.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938840; x=1684530840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWOiix+CZpnRrg0RGVEFc9lRocCcVk4TK0A2OuoCLpQ=;
        b=MO7Kb8Vs5ORbE3wSBmxNeJWNi9Sravzn/OaWnZXaTxxtusxyFdtppTC+THXVTfDgLY
         SPMwypC8H0+xIGopBkdd6L00tUmj20Fglp43eBAwV8YVy2dlqhF+OIpOzRCtYIsMIzeQ
         +kedH52LS44N94kL/YUrm0907kvewOEdYRbjd8c5U6gcYKSWPbhuaJjBdqy46Dnaljjq
         EWi1nnwZQeQusOrxb6yeo64XbddMb+2id6FWw6q4Pw4VgFn4oXHp/pHo00/PUbLjRPL7
         J19OrumIQ4b7yopTuUul0vPqx70mVpPwCxKFIW6O6yIT74CxrFrpsSCA/xV3v0uj+fir
         /OwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938840; x=1684530840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWOiix+CZpnRrg0RGVEFc9lRocCcVk4TK0A2OuoCLpQ=;
        b=c6DjuVt423Swv8SlZGl+bj3I7bBOB081tvfoXq59v25Dbh18J7h6bV6y9MZawPdOs/
         Hjz+kbNBbFKyx1ylKG03FGe6Svt72JIZ5My8T+LWVUNuEDypEGmUQGvKB5j88+ptj0Jz
         lmOT618LRxwvr+U/awiMaT9tlo1d9GswX3lIHhOwFDbjQT3oKy88IfXxf+Kr2N84rOI0
         zGg1+oLFwHE/znU5mNXqYs8n1W3Dm74ryRLH4UmkWkXViC+iXnon8zUyyqiSlNNdvF+s
         baW5kTumAL5V2cYgN1ho2u6NAdMh0BgSNxZyW1KqW6UOfC904mEhgd/wm3UTTC61Og/u
         fBWw==
X-Gm-Message-State: AAQBX9dLY4BUmd5mSRIHrFwJjpfdyu+C6LIB+mFhn3MAZY/uQinAnlbZ
        lMtubwFJXp9/tAw/TKlzPHj6ZrUZBmV8tmDS51ZLQA==
X-Google-Smtp-Source: AKy350bNlbMn2eJG67kjeEIey3N2TZegE1G4Zchw1rNS2Kcer+7sOMNlmGbfQ57dNFutxVuBt5aRVA==
X-Received: by 2002:ad4:5fcc:0:b0:5e3:c84a:9422 with SMTP id jq12-20020ad45fcc000000b005e3c84a9422mr7926qvb.2.1681938839893;
        Wed, 19 Apr 2023 14:13:59 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id r184-20020a37a8c1000000b007441b675e81sm3106277qke.22.2023.04.19.14.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:13:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 01/11] btrfs-progs: fix kerncompat.h include ordering for libbtrfs
Date:   Wed, 19 Apr 2023 17:13:43 -0400
Message-Id: <e135e7ccca0e52de2326d446b06271796ec4d4a1.1681938648.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938648.git.josef@toxicpanda.com>
References: <cover.1681938648.git.josef@toxicpanda.com>
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

We're keeping a libbtrfs compatible kerncompat.h around to make it
easier to modify the rest of btrfs-progs.  Unfortunately we also use
some of kernel-lib in libbtrfs, and those also include kerncompat.h.
Those getting included first means we'll pull include/kerncompat.h
instead of libbtrfs/kerncompat.h, which will mess things up.

Fix this by making sure we include our local copy of kerncompat.h first
before we include any other header in btrfs-progs.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 libbtrfs/ctree.h      | 4 ++--
 libbtrfs/send-utils.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libbtrfs/ctree.h b/libbtrfs/ctree.h
index e7a51c4b..ea2a680e 100644
--- a/libbtrfs/ctree.h
+++ b/libbtrfs/ctree.h
@@ -22,14 +22,14 @@
 #include <stdbool.h>
 
 #if BTRFS_FLAT_INCLUDES
+#include "libbtrfs/kerncompat.h"
 #include "kernel-lib/list.h"
 #include "kernel-lib/rbtree.h"
-#include "libbtrfs/kerncompat.h"
 #include "libbtrfs/ioctl.h"
 #else
+#include <btrfs/kerncompat.h>
 #include <btrfs/list.h>
 #include <btrfs/rbtree.h>
-#include <btrfs/kerncompat.h>
 #include <btrfs/ioctl.h>
 #endif /* BTRFS_FLAT_INCLUDES */
 
diff --git a/libbtrfs/send-utils.c b/libbtrfs/send-utils.c
index 831ec0dc..eb0ed5af 100644
--- a/libbtrfs/send-utils.c
+++ b/libbtrfs/send-utils.c
@@ -24,10 +24,10 @@
 #include <fcntl.h>
 #include <limits.h>
 #include <errno.h>
-#include "kernel-lib/rbtree.h"
 #include "libbtrfs/ctree.h"
 #include "libbtrfs/send-utils.h"
 #include "libbtrfs/ioctl.h"
+#include "kernel-lib/rbtree.h"
 
 static int btrfs_subvolid_resolve_sub(int fd, char *path, size_t *path_len,
 				      u64 subvol_id);
-- 
2.39.1

