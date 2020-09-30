Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6735027E1CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 08:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgI3Guk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 02:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgI3GuV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 02:50:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FA7C0613D0;
        Tue, 29 Sep 2020 23:50:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s14so465006pju.1;
        Tue, 29 Sep 2020 23:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2HCAxyO+XuYMLzto3YJY+q/fwyGyhZhVewL5HVF+qc=;
        b=Ze2ZLUn/gHd/WK9x9irPvWqHs/NFiPmCa5P6/Dn+oTk3ExciQxUlXn7Vbe07ylFxkY
         oYGEVI05j3wEE1aWoLEfBGolKTHcWTaKC5yN3ZxVJmln+x3i4mfusxu6g+gOzf0vflXs
         n505H4ojs/SAeR46GGryB7JaAFICMAiR8DjoJcpp2ELnQnuF1IJJV7FwGFkeeNwz2Uqb
         1xdzQQlWRm06NRJYRFUpA8o6XDNU8inQELRr9HRY9Mp5FIwZcZ0dOuOD1w8WsNkzgkgS
         GhudagXYDa71+hD6izNUgWETMwWin6c16O9PIxHFJQIy5p82sxSvUfR7aNs8bORHh/JP
         Klag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2HCAxyO+XuYMLzto3YJY+q/fwyGyhZhVewL5HVF+qc=;
        b=GBN5LLpMcWj5fwexe29FRnmTcVAx8aaRDvBoGmj4Jr2Mg83jebcIxC1z7Zn72C0PUS
         IScYgn/7VHa9Lfw9ehIRJkpLIZM2ZrHyP82UpvM/RIAe9nLS6b68Qn+fn58Q+UUIXM/+
         qgbycG/twqcFXjVrKRxr3m+rYOPJGZL4wkpXByAoqLUMHWuQH7RPcUGo/FoPuddLunJ/
         X36CvXgt14LsOrz/nmw8CP124AjTPWCUsIryEed2T3Kp9zj4Apmrtyyg3BgV+IRTvI87
         8aylORpcwgsqgSgfsXVPUHGxXN7yotYJOvavpKF00V112Vbw07wXp17tPJ8iaigmxbcF
         KkRQ==
X-Gm-Message-State: AOAM533eiTDGaqc3jtAgMW4XbBcgStPzwj2eg69aDs7g3g5zH0aS5tdS
        0BT3r1X/VJgWjrff27eOs6Y=
X-Google-Smtp-Source: ABdhPJxW/k205s0860z7nrp5WJvxzEf5shi5O0SI/xlV4670tL9vX7qZJw9o76EEWxvj2xBzJFYEHg==
X-Received: by 2002:a17:90a:de81:: with SMTP id n1mr1287027pjv.92.1601448620150;
        Tue, 29 Sep 2020 23:50:20 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id 190sm1100865pfy.22.2020.09.29.23.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 23:50:19 -0700 (PDT)
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
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 9/9] lib: zstd: Remove zstd compatibility wrapper
Date:   Tue, 29 Sep 2020 23:53:18 -0700
Message-Id: <20200930065318.3326526-10-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930065318.3326526-1-nickrterrell@gmail.com>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

All callers have been transitioned to the new zstd-1.4.6 API. There are
no more callers of the zstd compatibility wrapper, so delete it.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 include/linux/zstd_compat.h | 116 ------------------------------------
 1 file changed, 116 deletions(-)
 delete mode 100644 include/linux/zstd_compat.h

diff --git a/include/linux/zstd_compat.h b/include/linux/zstd_compat.h
deleted file mode 100644
index cda9208bf04a..000000000000
--- a/include/linux/zstd_compat.h
+++ /dev/null
@@ -1,116 +0,0 @@
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
-static inline ZSTD_CStream* ZSTD_initCStream_compat(ZSTD_parameters params, uint64_t pledged_src_size, void* wksp, size_t wksp_size)
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
-    /* 0 means unknown in old API but means 0 in new API */
-    if (pledged_src_size == 0)
-        pledged_src_size = ZSTD_CONTENTSIZE_UNKNOWN;
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

