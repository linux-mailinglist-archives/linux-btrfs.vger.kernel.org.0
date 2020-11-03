Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4DA2A3C6D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 07:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgKCGCD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 01:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCGCB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 01:02:01 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85069C061A47;
        Mon,  2 Nov 2020 22:02:01 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id z1so8037691plo.12;
        Mon, 02 Nov 2020 22:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWygwZ+ivEMIi25OaiUo1Zam2MncVHjO+BypAFXIYAo=;
        b=JM0TrRYa221OBNL+3xlD+e2qFNGW+oJCIa+nKENT/oK16ai1/3ZwfwHdCCnZqVlMYB
         E0bGwvZgYl0/v8cs1ZNEUjKZc35gP7wC+1gzWp/U5+9lLGjpLQwLbinx7EZOVtka9aqh
         uQqpNedOzM3YjO3AHViLpvAbo41ENlIS7TKOXGaXRMlaAuIHQnyQoVyML0Ukr6m10WHW
         GBDilgXFImL026l/ZahUnhrUvoCkxVD564hJ5CkoXicJDznfLp7wcpKbh2r71vd9Movt
         O8FkIttZkOI+aw3Oc6SekaaFb+q4R+5M5dK9b/qwhKYJfzeyE2SOubJ+2H5qtH+wPbug
         uZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWygwZ+ivEMIi25OaiUo1Zam2MncVHjO+BypAFXIYAo=;
        b=Iz009n+22Dw4LL/qVlMF7XOBOrUh52jxofvSVDa7ZgudubUeVipdcuXNvrqLLJDY1/
         5GSawlG7bvtjbpsdhG0M7HDmD/ZVf5Wlj/7aE+jyVx4kGmR/UhBQprX+MoBHkWSqTxdu
         My/GPGr/21ITYQGWgKZnqjE7IVZvTkKf1ndPIY1/h4EYhfGAomClZOLVm+tNEPMIVf5V
         JrAjJ27QX+9y3xa3Qjm52W+IlAsis/DeSforYtVJds1A6iDJ9WY4Vjo1fQJmt/dwMkMq
         0x8CmyAi6ACN1X8KHZItgpyNUnC0NJTomhN0IzV2+8M7m0xRkKCoJb+Ie4DCC2Azkr57
         4y7g==
X-Gm-Message-State: AOAM532uMoGup6OrdPf0G1TzHSCCmUE0PyaqzqoWPZk22F9FmRau55mG
        7mSWGJ8RxGmlDNHebhBnNGg=
X-Google-Smtp-Source: ABdhPJwtMrMHoYdikDXTZBypvBnbSnctOVijmsKBxGO4u9Ixf+hOMd80RN9SqJluxhfUII1McD2Y7Q==
X-Received: by 2002:a17:902:8693:b029:d5:d861:6f03 with SMTP id g19-20020a1709028693b02900d5d8616f03mr23725211plo.19.1604383320987;
        Mon, 02 Nov 2020 22:02:00 -0800 (PST)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id b16sm15647269pfp.195.2020.11.02.22.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 22:02:00 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Subject: [PATCH v5 2/9] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Mon,  2 Nov 2020 22:05:28 -0800
Message-Id: <20201103060535.8460-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103060535.8460-1-nickrterrell@gmail.com>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
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
 lib/zstd/decompress_sources.h | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)
 create mode 100644 lib/zstd/decompress_sources.h

diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index 6bb805aeec08..3c6ad01ffcd5 100644
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
index 000000000000..ccb4960ea0cd
--- /dev/null
+++ b/lib/zstd/decompress_sources.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
2.28.0

