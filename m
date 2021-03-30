Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD21734F48B
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 00:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhC3Wqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 18:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhC3WqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 18:46:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6299AC061574;
        Tue, 30 Mar 2021 15:46:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so2004390pjb.1;
        Tue, 30 Mar 2021 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXAaMKABaV2jajtKsKxGYYT+hHSjapVgGR5gnAv4wPY=;
        b=rpG4RHEUrKUL6vWLsoj95XHwN2l0nQLe4AAc8HhYTS8iauHIrun2MGyTAmgQbOhmJC
         WZWrL/YFsAL6U1Gc7+PrZOfsRKKkkygUbOsLM0pChao5wo9Oy1r9tOQzPkVu4Rv9Rtnk
         oABxDCZz+2hIQYOhZdZdVKFyOzGFLrDJ2dJMMkYryx6WBzGiXxbO6/2RYlHOF7UyRq8E
         u1LZWOjVtmS9EZA6/onhpk99mJUYA1VCu0PYRjCaClpn5fDxNGDlDUO5PgNILTG/5gfY
         xsz4T5W4nMnY2aX9NzMwdy5edsXDfOF6Xsc8tJH4mkkbxrzQWJrCLMARlM0HvIxgb64O
         lGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXAaMKABaV2jajtKsKxGYYT+hHSjapVgGR5gnAv4wPY=;
        b=n8VPyHMhXbamZHBo5cOO3V8nrpQ4g8sLOQV23tkRExdgPw3ZnuWTjq4w5Sh438ySNl
         MgII9sDWCQkYg7/JRhv1F3vmB8wDTfLRQsbklPKWVkjDWxxRaGUJ9HAxuLyryUqG2FI7
         D+cbdftxJgyhL0DQaaa4X8DAk8056/0tliWHTOUIWhQvrZzNqtzfE9mBEkJkTUFu8g/o
         tDG7SklfWlrksPffCb7/w0lJ3/icFgHRssNwXNNqFVoW/VP2vR69IlWYEUxrq67ZDDCP
         7CTvozfIlN0D7H+l5mUgvQV/ihsFnWS1x5AYm/It6DdULHwWaq2PUBqi2Pc4vIKLjhBb
         plaQ==
X-Gm-Message-State: AOAM531PGwvtqVtMJepbTMVhK8UUAFUEg9R1m+4bZ7Qn8knBd2NE+puJ
        DD2uEwKa8/4VXEQt7W+S2U8=
X-Google-Smtp-Source: ABdhPJyGgru2+ezHpj1LM0whxIWM74Z/P76Hr1X70Q5Zuk8tI0sLvMZTLt5Q2qm8vHnHsPgLWsJMfQ==
X-Received: by 2002:a17:902:8685:b029:e6:5ff6:f7df with SMTP id g5-20020a1709028685b02900e65ff6f7dfmr517568plo.40.1617144377869;
        Tue, 30 Mar 2021 15:46:17 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id t12sm227780pga.85.2021.03.30.15.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 15:46:17 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>,
        Christoph Hellwig <hch@infradead.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Sterba <dsterba@suse.cz>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH v9 2/3] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Tue, 30 Mar 2021 15:51:11 -0700
Message-Id: <20210330225112.496213-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210330225112.496213-1-nickrterrell@gmail.com>
References: <20210330225112.496213-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

Adds decompress_sources.h which includes every .c file necessary for
zstd decompression. This is used in decompress_unzstd.c so the internal
structure of the library isn't exposed.

This allows us to upgrade the zstd library version without modifying any
callers. Instead we just need to update decompress_sources.h.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 lib/decompress_unzstd.c       |  6 +-----
 lib/zstd/decompress_sources.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)
 create mode 100644 lib/zstd/decompress_sources.h

diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index c88aad49e996..6e5ecfba0a8d 100644
--- a/lib/decompress_unzstd.c
+++ b/lib/decompress_unzstd.c
@@ -68,11 +68,7 @@
 #ifdef STATIC
 # define UNZSTD_PREBOOT
 # include "xxhash.c"
-# include "zstd/entropy_common.c"
-# include "zstd/fse_decompress.c"
-# include "zstd/huf_decompress.c"
-# include "zstd/zstd_common.c"
-# include "zstd/decompress.c"
+# include "zstd/decompress_sources.h"
 #endif
 
 #include <linux/decompress/mm.h>
diff --git a/lib/zstd/decompress_sources.h b/lib/zstd/decompress_sources.h
new file mode 100644
index 000000000000..d82cea4316f5
--- /dev/null
+++ b/lib/zstd/decompress_sources.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Facebook, Inc.
+ * All rights reserved.
+ *
+ * This source code is licensed under both the BSD-style license (found in the
+ * LICENSE file in the root directory of this source tree) and the GPLv2 (found
+ * in the COPYING file in the root directory of this source tree).
+ * You may select, at your option, one of the above-listed licenses.
+ */
+
+/*
+ * This file includes every .c file needed for decompression.
+ * It is used by lib/decompress_unzstd.c to include the decompression
+ * source into the translation-unit, so it can be used for kernel
+ * decompression.
+ */
+
+#include "entropy_common.c"
+#include "fse_decompress.c"
+#include "huf_decompress.c"
+#include "zstd_common.c"
+#include "decompress.c"
-- 
2.31.0

