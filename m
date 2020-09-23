Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44E12763FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 00:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgIWWjf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 18:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgIWWja (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 18:39:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B804C0613CE;
        Wed, 23 Sep 2020 15:39:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c3so518059plz.5;
        Wed, 23 Sep 2020 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2HCAxyO+XuYMLzto3YJY+q/fwyGyhZhVewL5HVF+qc=;
        b=eLpDqrxN9NOvY6BEWZ8r0J6Hg1IA42S988jZCVhPEyrifHrk1+kez6N3oNJi+64VWU
         0v/nMaeSjGZZqBJzwu5C9f0adQsHPV2jZJVP2KbX1GK1aUYO7T1FVoN2zG+56+3xCo5P
         auSomm5ZsSToHbMmhwv5F8reABWfIAW64r10ScRpMRY5f2DN241xgXWNExy8NvEHt+9F
         hjXGLYdxswq2GAA93wKA6l9s6FeTC675qKb6aQOXdE9WKExxBCWUDTPNbybyUVHv126n
         mmg7jjpXc/Q1VRoPYCr7SqmNcYbRFj29uwtuVmWQIQU1QVgASlRBYAJVt9x79zq4XnjH
         w5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2HCAxyO+XuYMLzto3YJY+q/fwyGyhZhVewL5HVF+qc=;
        b=bD3CXLut4xXCw5Q7FQFkcTWabwQgdPRd4Y5PAkIHI/8oLy5B46Kb0GnoF90Q2OISo9
         5peKZE02ULXssaCSAbCFz+nOpfSd9pSRftYeKKzZghZ6AMHqaDyIpSr3d2zkZ+tObEas
         H6mqh/kCcWQVWQmFWA+75VQtl7UmS57I2HXxCT1HEp2WR32TmULu5N6LH36ostEFYArH
         W6OQvGGWRy5uf6BoHZao4GVsfdtFvYYcFkNBALg1aUZ9ri6rLmlE74n/Bq1H5kwg9n+X
         eCAYYoqwhYdTj8n8JLxzuKM0wJt44/QV9IBPclU7G3kjbbyaVaBGiLAp8xxK38aN7I2b
         tn7w==
X-Gm-Message-State: AOAM5317woJNe/BtCpBw0980QmOpVnYJuLEfsiy9M/Z8zsVDK8cn7qbT
        xPlSWEvWz/gzhHF1JHbNX9E=
X-Google-Smtp-Source: ABdhPJzoKgqsoCy046jumPIK27/+u46M/bZKhAGULWig0jKxb35TB+RdSsFCafaDgvOOyX7ZrFTdMg==
X-Received: by 2002:a17:90b:1487:: with SMTP id js7mr1270240pjb.187.1600900769712;
        Wed, 23 Sep 2020 15:39:29 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id d20sm417964pjv.39.2020.09.23.15.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 15:39:29 -0700 (PDT)
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
Subject: [PATCH v3 9/9] lib: zstd: Remove zstd compatibility wrapper
Date:   Wed, 23 Sep 2020 15:42:06 -0700
Message-Id: <20200923224206.68968-10-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923224206.68968-1-nickrterrell@gmail.com>
References: <20200923224206.68968-1-nickrterrell@gmail.com>
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

