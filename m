Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFE9274AA2
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 23:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIVVFf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 17:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVVFe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 17:05:34 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14AC061755;
        Tue, 22 Sep 2020 14:05:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z18so13627880pfg.0;
        Tue, 22 Sep 2020 14:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=;
        b=ML0s+z4JiTGGpbGPOVB62fUQXSz8pBkrRGE1exLoA5L8vRau2DwvSWAXq5wm8EfgfS
         eO88W0lcJ0tX/ctYDhv/PwogvmF3gpvH7/XNB5AAcGy4qZwD0VnfGjN7iNStIFA4+Fxy
         wwTL4MzsEQAkh2IEJc/x9MH7j3pe5wliicssOGpMOFguasGvioTiF87/VBdMCrlDhJaz
         vCxOZJw/Q+TH2sSIr+kVXxR8lOFWnCWswm6nDTZSRPz9GFvZBl8VTRsyEtf/GIaeVGbQ
         Z6+Ld/5dYMMq+fGLtJ8DOS0JNLuc5IB0IaSeUql+ezqKOXj7lCQVXHfU7W/GpalbKAjE
         qEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=;
        b=Uj+7zJoQLKko/RZP7vBPRNEZb7sO3PVQiGkTUy8HfDm2q+Yd/FHju02TXkycH4XHS9
         Bcq1FIAa3uqYZKUt3xdkKQ9o6k64mOvDU07sUWYEJMtKoLlKSwDn0aYiuzPLe9fz2ovf
         GOBal5NTuXrGVpvRmPs4uiHQr44yzTg0iCcSMfWVfHBbwZM8O+TkseIxAnRjzY8WOjnK
         sWxnvfJqoCLaJGr7X69Bu3hNB+mupP5az14zqXzMY7tegCUjAjzniSTtQrNEPQcWX+Iz
         yDsM1tHmY1lph2nERLHQWRV2gBQiaWv6Df9vhYzODaRMnC4P0GkZmpPbEWcn2ijh8M+3
         sfXg==
X-Gm-Message-State: AOAM533Ou77c32jJzmotcgGA7cGsNnWjE/qlA/6UEuCGPcrymWEdp9Mb
        CaOqbug6DSGISwtapnwanno=
X-Google-Smtp-Source: ABdhPJzpIRe/uXi9oko6PATw8guaQq7mv8V7LLBJQB2a9sT+vfvvH75/JxXt+7bx/mgfndJLJK6jQQ==
X-Received: by 2002:a17:902:aa02:b029:d0:cbe1:e7b4 with SMTP id be2-20020a170902aa02b02900d0cbe1e7b4mr6181491plb.37.1600808734213;
        Tue, 22 Sep 2020 14:05:34 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i15sm16118945pfk.145.2020.09.22.14.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:05:33 -0700 (PDT)
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
Subject: [PATCH v2 2/9] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Tue, 22 Sep 2020 14:09:17 -0700
Message-Id: <20200922210924.1725-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922210924.1725-1-nickrterrell@gmail.com>
References: <20200922210924.1725-1-nickrterrell@gmail.com>
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
index dbc290af26b4..a79f705f236d 100644
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

