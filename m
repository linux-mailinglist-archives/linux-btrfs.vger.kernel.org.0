Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B003F2A3C81
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 07:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgKCGCe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 01:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgKCGCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 01:02:31 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A20C061A4A;
        Mon,  2 Nov 2020 22:02:31 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i7so10906478pgh.6;
        Mon, 02 Nov 2020 22:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2HCAxyO+XuYMLzto3YJY+q/fwyGyhZhVewL5HVF+qc=;
        b=p7KlBBGLft8dFPRJKfCutgbwfRd5yWhKlvBFON2+wv9VJrvR36DECWzNPpd/n36IED
         ZY0e3i7ASgkz8//vQFonbgL6nACypaK/9bB/rFS8/mbs+s99xOsmELOb7X76+AY87EkX
         rfN5NkpWRgMGfMNIN2yHfvMIluVdHup00vUJg3V0N+NaVvWtWdoDex4v71QSWSbtedcO
         +MhF/WSvq3paW4XfKrZKn+p0I3jhwaRoji0S1tA2iCFfy/ows40uFc/cGQVycZZ0Kr9F
         nt3F6WSayHQmY7NOWGOttU7E+CmTdBR9oQ3w1cC/n9+gzDo2m3549nYpRVaXg9VAm07U
         kkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2HCAxyO+XuYMLzto3YJY+q/fwyGyhZhVewL5HVF+qc=;
        b=dBoZqClT4gjQahzoTvToT2m3AfLWbMrHXsT2rdUIihy//hkMryzo+IANc0bI9EIT4c
         JjV55Kpy9Gsk2w1COu4oD7v59/wZvRZ/ivvgBrSmc0Ls5WTUgrsVGKfPiJpivb/Za1l4
         D893GyV5toExcAcIKr1BF9FJZVRnRiduXGMrMUVbHG8JPd4we46odWglRZ1hHudZPQj8
         /QT06OQAwvU6mfuA36C6vQ8r/7yYx51pX0Qcf4TnG0QqBKi1fH9C06dpUFN6MqD2YLGC
         TpSLtupv+XQMWNE3fhsBHGry143iWGDMfM0HC4tF3PlF4kXadphw2RukM+poj7ZD/Lvl
         2dWQ==
X-Gm-Message-State: AOAM531A5SojjedszKOwR9DE7CLPJbQ1vrMUotBhnbdsX/VpjTCR3mhL
        x8u8eFWz62frYjrArPEj+FM=
X-Google-Smtp-Source: ABdhPJyyTjet0hB3i5D2u5kVje2efJwJ6tBaH7zXqSEo7vAbmIbW8YoDfZXAeBtfOOYzUqpvwNqNeQ==
X-Received: by 2002:a63:d46:: with SMTP id 6mr9709661pgn.227.1604383349363;
        Mon, 02 Nov 2020 22:02:29 -0800 (PST)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id b16sm15647269pfp.195.2020.11.02.22.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 22:02:28 -0800 (PST)
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
Subject: [PATCH v5 9/9] lib: zstd: Remove zstd compatibility wrapper
Date:   Mon,  2 Nov 2020 22:05:35 -0800
Message-Id: <20201103060535.8460-10-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103060535.8460-1-nickrterrell@gmail.com>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
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

