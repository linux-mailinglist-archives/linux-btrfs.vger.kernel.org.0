Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5708C26BACB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 05:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgIPDo3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 23:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgIPDn2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 23:43:28 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578DDC06178C;
        Tue, 15 Sep 2020 20:43:28 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d19so2440973pld.0;
        Tue, 15 Sep 2020 20:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B734eLzegOM69YIdpTuPy5IVI8KUhGsW2HbQRBZhAtU=;
        b=Qb0a55r+vERIPUYnWefspZ6CFa3mChTlb0U1FvAm9wOux4XHtj5h17hErBneWzg5+O
         By4bxU23KjZm3hCuLdEy3os8y0eSqzjJ9+GWXP0ToUseyIBEiUd+d9UHNkEiBUcpBD8j
         oo5bsPq/kpXqIaP1hHMgQzdiWBSnVQMSEKg24BX991ug6HRp3TLsRd6yH5ypOW+/qz6x
         qVrznHgPN1uQ1r0vTLPIG7/gEPTbqs0tKSQcvIkl8JfNAseKFACn3GLq3/ouLGPgw4eD
         ATZOxuEevmOZH3GQgZmYWTUNYcn7cfucmCqrAOav5ReHuvT95R8YmDN7gYTr5ah4AbO3
         z0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B734eLzegOM69YIdpTuPy5IVI8KUhGsW2HbQRBZhAtU=;
        b=Aomie2QbcHLj6PIBdwMWGCU99tWEr52fTJNQiwfjCZUahaR9v++NUf6Aq4h9gJJNUK
         FkLLvdgF4qWlshNJca9Tqs5xVZWvTwI69NDIeNUUUVoNWdcm4tiAM5athqSWIqw+QRtY
         /yGf3G8QLGjJIntMZMbZNp00lIw9mP42ySLeP+uGK3fy5q/dxdLv4oOlo/zyERbL9d2R
         t4hxKmjBnLZliYwvetn8clehJsy3SjFiDn5NPl86MFFE47i2qvbjeuyTaukIx3qIOGxx
         yDZJk5iI/JIeGtwnKabwBvwzM6ZBZFv7WhjOyVsJJXbTKnZ4+lZLWXFMGI5P9emHePZx
         dwOA==
X-Gm-Message-State: AOAM531PXkfmgFO2LGlvlpWsU7f3qy/41RbfMA+5KM88BtYH8VMUwkfT
        8Go22Fvau/iUPuLHnWLT/UY=
X-Google-Smtp-Source: ABdhPJwg85Xa27iP37NCc1r+81+i4vrU9TLljdl8yvWrL1Dr5vcgXQMqlD5lvcoD/N/eTAko5z4qVw==
X-Received: by 2002:a17:90b:2341:: with SMTP id ms1mr2059849pjb.80.1600227807811;
        Tue, 15 Sep 2020 20:43:27 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i20sm12856635pgk.77.2020.09.15.20.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 20:43:27 -0700 (PDT)
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
Subject: [PATCH 9/9] lib: zstd: Remove zstd compatibility wrapper
Date:   Tue, 15 Sep 2020 20:43:07 -0700
Message-Id: <20200916034307.2092020-15-nickrterrell@gmail.com>
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

All callers have been transitioned to the new zstd-1.4.6 API. There are
no more callers of the zstd compatibility wrapper, so delete it.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 include/linux/zstd_compat.h | 112 ------------------------------------
 1 file changed, 112 deletions(-)
 delete mode 100644 include/linux/zstd_compat.h

diff --git a/include/linux/zstd_compat.h b/include/linux/zstd_compat.h
deleted file mode 100644
index 11acf14d9d70..000000000000
--- a/include/linux/zstd_compat.h
+++ /dev/null
@@ -1,112 +0,0 @@
-/*
- * Copyright (c) 2016-present, Facebook, Inc.
- * All rights reserved.
- *
- * This source code is licensed under the BSD-style license found in the
- * LICENSE file in the root directory of https://github.com/facebook/zstd.
- * An additional grant of patent rights can be found in the PATENTS file in the
- * same directory.
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation. This program is dual-licensed; you may select
- * either version 2 of the GNU General Public License ("GPL") or BSD license
- * ("BSD").
- */
-
-#ifndef ZSTD_COMPAT_H
-#define ZSTD_COMPAT_H
-
-#include <linux/zstd.h>
-
-#if defined(ZSTD_VERSION_NUMBER) && (ZSTD_VERSION_NUMBER >= 10406)
-/*
- * This header provides backwards compatibility for the zstd-1.4.6 library
- * upgrade. This header allows us to upgrade the zstd library version without
- * modifying any callers. Then we will migrate callers from the compatibility
- * wrapper one at a time until none remain. At which point we will delete this
- * header.
- *
- * It is temporary and will be deleted once the upgrade is complete.
- */
-
-#include <linux/zstd_errors.h>
-
-static inline size_t ZSTD_CCtxWorkspaceBound(ZSTD_compressionParameters compression_params)
-{
-    return ZSTD_estimateCCtxSize_usingCParams(compression_params);
-}
-
-static inline size_t ZSTD_CStreamWorkspaceBound(ZSTD_compressionParameters compression_params)
-{
-    return ZSTD_estimateCStreamSize_usingCParams(compression_params);
-}
-
-static inline size_t ZSTD_DCtxWorkspaceBound(void)
-{
-    return ZSTD_estimateDCtxSize();
-}
-
-static inline size_t ZSTD_DStreamWorkspaceBound(unsigned long long window_size)
-{
-    return ZSTD_estimateDStreamSize(window_size);
-}
-
-static inline ZSTD_CCtx* ZSTD_initCCtx(void* wksp, size_t wksp_size)
-{
-    if (wksp == NULL)
-        return NULL;
-    return ZSTD_initStaticCCtx(wksp, wksp_size);
-}
-
-static inline ZSTD_CStream* ZSTD_initCStream_compat(ZSTD_parameters params, size_t pledged_src_size, void* wksp, size_t wksp_size)
-{
-    ZSTD_CStream* cstream;
-    size_t ret;
-
-    if (wksp == NULL)
-        return NULL;
-
-    cstream = ZSTD_initStaticCStream(wksp, wksp_size);
-    if (cstream == NULL)
-        return NULL;
-
-    ret = ZSTD_initCStream_advanced(cstream, NULL, 0, params, pledged_src_size);
-    if (ZSTD_isError(ret))
-        return NULL;
-
-    return cstream;
-}
-#define ZSTD_initCStream ZSTD_initCStream_compat
-
-static inline ZSTD_DCtx* ZSTD_initDCtx(void* wksp, size_t wksp_size)
-{
-    if (wksp == NULL)
-        return NULL;
-    return ZSTD_initStaticDCtx(wksp, wksp_size);
-}
-
-static inline ZSTD_DStream* ZSTD_initDStream_compat(unsigned long long window_size, void* wksp, size_t wksp_size)
-{
-    if (wksp == NULL)
-        return NULL;
-    (void)window_size;
-    return ZSTD_initStaticDStream(wksp, wksp_size);
-}
-#define ZSTD_initDStream ZSTD_initDStream_compat
-
-typedef ZSTD_frameHeader ZSTD_frameParams;
-
-static inline size_t ZSTD_getFrameParams(ZSTD_frameParams* frame_params, const void* src, size_t src_size)
-{
-    return ZSTD_getFrameHeader(frame_params, src, src_size);
-}
-
-static inline size_t ZSTD_compressCCtx_compat(ZSTD_CCtx* cctx, void* dst, size_t dst_capacity, const void* src, size_t src_size, ZSTD_parameters params)
-{
-    return ZSTD_compress_advanced(cctx, dst, dst_capacity, src, src_size, NULL, 0, params);
-}
-#define ZSTD_compressCCtx ZSTD_compressCCtx_compat
-
-#endif /* ZSTD_VERSION_NUMBER >= 10406 */
-#endif /* ZSTD_COMPAT_H */
-- 
2.28.0

