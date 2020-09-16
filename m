Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C82726BAAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 05:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgIPDkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 23:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgIPDkO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 23:40:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D60C06174A;
        Tue, 15 Sep 2020 20:40:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so831684pjb.2;
        Tue, 15 Sep 2020 20:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S+BtKFBofP+2qj1vMeMT8ZFQXkI1C+ove1wGqcVzSh0=;
        b=Ug5EbU2QiuMXX8B4ONwOPlBHJ6tNwfXqonHrLrKYjezkizaz+GZoC7obTu98823d5V
         LAU9zo+1JFEW7wtzZlRIC0fhpVj02eWFq58FmEaqAyPjBJebu9Gwy2nmn3NItZC0gB0d
         0l58mLR8C16/sXFl/Q4WWpf/5KrNCay2qSnycyRJwx49TfLyWDoDo6z98ycEJQzkI+Qv
         fp7SHqdiicSPgLknqbaah9VR5W07X0nUF6s52wDkTeSB8R7UVZGEOzXq1hN8HDvHTERs
         KuLPrn57F7eS/NKafRu3DZqVlCZIxDCeYM1XZExomw0tta4Xgers0pkpslykJI/U8VdC
         /7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S+BtKFBofP+2qj1vMeMT8ZFQXkI1C+ove1wGqcVzSh0=;
        b=sdKIgLv///eBCakuai1MFXAvGPvaohkTlfIBVn/ZBziBagPMy53+8bl3/42oMqU3Le
         zCiwCSTaowHNf9P3N0UGw+5HtpOUHvLxynqE/hBaQsQioo+eeEDed1TG2P2HLuNj4x7W
         bw9dBdKBW/pDj9M+VUQGxDC0rlKTmMxCWDtyKEQgz98uqhZLg5pKV8EEPszqxFr4t6/y
         sizWbj/fbcDtaqE7EKaeo4rBTH3BfJV7t8VhDsz7VS3PdFc9QgzJZ5i0XniE/cRoaYD2
         r0QCRxB9oE8oZaLVxiSy/PxqGAf9TuWFycew0go2rjSAj92ucgn04+Hl+wlsX/gmpP85
         0X0w==
X-Gm-Message-State: AOAM532V6hccfyi8+AUs7Q4IR3Uh3r0YQOe7q3SorLLPhp8W23oUoSRE
        SuWmXo8+OVkSPU8NqtZ7Mq4=
X-Google-Smtp-Source: ABdhPJx/OhIWKQmofslaKsOosAbxPzPLyW41LggGay5fxkAAuxmLW7t8MXJuK7NJYchNtzUR0VC5eg==
X-Received: by 2002:a17:902:fe13:b029:d0:89f4:6226 with SMTP id g19-20020a170902fe13b02900d089f46226mr22457797plj.14.1600227613759;
        Tue, 15 Sep 2020 20:40:13 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i20sm12856635pgk.77.2020.09.15.20.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 20:40:13 -0700 (PDT)
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
Subject: [PATCH 1/9] lib: zstd: Add zstd compatibility wrapper
Date:   Tue, 15 Sep 2020 20:42:54 -0700
Message-Id: <20200916034307.2092020-2-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916034307.2092020-1-nickrterrell@gmail.com>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

Adds zstd_compat.h which provides the necessary functions from the
current zstd.h API. It is only active for zstd versions 1.4.6 and newer.
That means it is disabled currently, but will become active when a later
patch in this series updates the zstd library in the kernel to 1.4.6.

This header allows the zstd upgrade to 1.4.6 without changing any
callers, since they all include zstd through the compatibility wrapper.
Later patches in this series transition each caller away from the
compatibility wrapper. After all the callers have been transitioned away
from the compatibility wrapper, the final patch in this series deletes
it.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 crypto/zstd.c               |   2 +-
 fs/btrfs/zstd.c             |   2 +-
 fs/f2fs/compress.c          |   2 +-
 fs/squashfs/zstd_wrapper.c  |   2 +-
 include/linux/zstd_compat.h | 112 ++++++++++++++++++++++++++++++++++++
 lib/decompress_unzstd.c     |   2 +-
 6 files changed, 117 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/zstd_compat.h

diff --git a/crypto/zstd.c b/crypto/zstd.c
index 1a3309f066f7..dcda3cad3b5c 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/vmalloc.h>
-#include <linux/zstd.h>
+#include <linux/zstd_compat.h>
 #include <crypto/internal/scompress.h>
 
 
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 9a4871636c6c..a7367ff573d4 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -16,7 +16,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/zstd.h>
+#include <linux/zstd_compat.h>
 #include "misc.h"
 #include "compression.h"
 #include "ctree.h"
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 1dfb126a0cb2..e056f3a2b404 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -11,7 +11,7 @@
 #include <linux/backing-dev.h>
 #include <linux/lzo.h>
 #include <linux/lz4.h>
-#include <linux/zstd.h>
+#include <linux/zstd_compat.h>
 
 #include "f2fs.h"
 #include "node.h"
diff --git a/fs/squashfs/zstd_wrapper.c b/fs/squashfs/zstd_wrapper.c
index b7cb1faa652d..f8c512a6204e 100644
--- a/fs/squashfs/zstd_wrapper.c
+++ b/fs/squashfs/zstd_wrapper.c
@@ -11,7 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/bio.h>
 #include <linux/slab.h>
-#include <linux/zstd.h>
+#include <linux/zstd_compat.h>
 #include <linux/vmalloc.h>
 
 #include "squashfs_fs.h"
diff --git a/include/linux/zstd_compat.h b/include/linux/zstd_compat.h
new file mode 100644
index 000000000000..11acf14d9d70
--- /dev/null
+++ b/include/linux/zstd_compat.h
@@ -0,0 +1,112 @@
+/*
+ * Copyright (c) 2016-present, Facebook, Inc.
+ * All rights reserved.
+ *
+ * This source code is licensed under the BSD-style license found in the
+ * LICENSE file in the root directory of https://github.com/facebook/zstd.
+ * An additional grant of patent rights can be found in the PATENTS file in the
+ * same directory.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation. This program is dual-licensed; you may select
+ * either version 2 of the GNU General Public License ("GPL") or BSD license
+ * ("BSD").
+ */
+
+#ifndef ZSTD_COMPAT_H
+#define ZSTD_COMPAT_H
+
+#include <linux/zstd.h>
+
+#if defined(ZSTD_VERSION_NUMBER) && (ZSTD_VERSION_NUMBER >= 10406)
+/*
+ * This header provides backwards compatibility for the zstd-1.4.6 library
+ * upgrade. This header allows us to upgrade the zstd library version without
+ * modifying any callers. Then we will migrate callers from the compatibility
+ * wrapper one at a time until none remain. At which point we will delete this
+ * header.
+ *
+ * It is temporary and will be deleted once the upgrade is complete.
+ */
+
+#include <linux/zstd_errors.h>
+
+static inline size_t ZSTD_CCtxWorkspaceBound(ZSTD_compressionParameters compression_params)
+{
+    return ZSTD_estimateCCtxSize_usingCParams(compression_params);
+}
+
+static inline size_t ZSTD_CStreamWorkspaceBound(ZSTD_compressionParameters compression_params)
+{
+    return ZSTD_estimateCStreamSize_usingCParams(compression_params);
+}
+
+static inline size_t ZSTD_DCtxWorkspaceBound(void)
+{
+    return ZSTD_estimateDCtxSize();
+}
+
+static inline size_t ZSTD_DStreamWorkspaceBound(unsigned long long window_size)
+{
+    return ZSTD_estimateDStreamSize(window_size);
+}
+
+static inline ZSTD_CCtx* ZSTD_initCCtx(void* wksp, size_t wksp_size)
+{
+    if (wksp == NULL)
+        return NULL;
+    return ZSTD_initStaticCCtx(wksp, wksp_size);
+}
+
+static inline ZSTD_CStream* ZSTD_initCStream_compat(ZSTD_parameters params, size_t pledged_src_size, void* wksp, size_t wksp_size)
+{
+    ZSTD_CStream* cstream;
+    size_t ret;
+
+    if (wksp == NULL)
+        return NULL;
+
+    cstream = ZSTD_initStaticCStream(wksp, wksp_size);
+    if (cstream == NULL)
+        return NULL;
+
+    ret = ZSTD_initCStream_advanced(cstream, NULL, 0, params, pledged_src_size);
+    if (ZSTD_isError(ret))
+        return NULL;
+
+    return cstream;
+}
+#define ZSTD_initCStream ZSTD_initCStream_compat
+
+static inline ZSTD_DCtx* ZSTD_initDCtx(void* wksp, size_t wksp_size)
+{
+    if (wksp == NULL)
+        return NULL;
+    return ZSTD_initStaticDCtx(wksp, wksp_size);
+}
+
+static inline ZSTD_DStream* ZSTD_initDStream_compat(unsigned long long window_size, void* wksp, size_t wksp_size)
+{
+    if (wksp == NULL)
+        return NULL;
+    (void)window_size;
+    return ZSTD_initStaticDStream(wksp, wksp_size);
+}
+#define ZSTD_initDStream ZSTD_initDStream_compat
+
+typedef ZSTD_frameHeader ZSTD_frameParams;
+
+static inline size_t ZSTD_getFrameParams(ZSTD_frameParams* frame_params, const void* src, size_t src_size)
+{
+    return ZSTD_getFrameHeader(frame_params, src, src_size);
+}
+
+static inline size_t ZSTD_compressCCtx_compat(ZSTD_CCtx* cctx, void* dst, size_t dst_capacity, const void* src, size_t src_size, ZSTD_parameters params)
+{
+    return ZSTD_compress_advanced(cctx, dst, dst_capacity, src, src_size, NULL, 0, params);
+}
+#define ZSTD_compressCCtx ZSTD_compressCCtx_compat
+
+#endif /* ZSTD_VERSION_NUMBER >= 10406 */
+#endif /* ZSTD_COMPAT_H */
diff --git a/lib/decompress_unzstd.c b/lib/decompress_unzstd.c
index 0ad2c15479ed..dbc290af26b4 100644
--- a/lib/decompress_unzstd.c
+++ b/lib/decompress_unzstd.c
@@ -77,7 +77,7 @@
 
 #include <linux/decompress/mm.h>
 #include <linux/kernel.h>
-#include <linux/zstd.h>
+#include <linux/zstd_compat.h>
 
 /* 128MB is the maximum window size supported by zstd. */
 #define ZSTD_WINDOWSIZE_MAX	(1 << ZSTD_WINDOWLOG_MAX)
-- 
2.28.0

