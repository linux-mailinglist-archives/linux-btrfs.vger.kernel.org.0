Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B276226BAB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 05:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgIPDkc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 23:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgIPDkZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 23:40:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C5CC06174A;
        Tue, 15 Sep 2020 20:40:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gf14so822045pjb.5;
        Tue, 15 Sep 2020 20:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=;
        b=beGwVBILqaiGpiT+75iT50tdl4GOlO+U/RTraSf3f+81k3pMHTEARmVXl/HtPPMVzj
         T4bcclVyKBh7YNHecZ4ZQZsUSKdDuuP1drlk99lLR5udm5ltlTCtUWzp6CnCsVmwyu2q
         9KAPj6A8DE2/R6VoZOjy48UCYwM/gtitbgryTwCQgi42xbEQo1bZFcGv0VGhDqjehQMj
         kjCnzzHZeOT13zfrdOcMYLJ5Q/rEqgAmrp1UgQ3iN8bKpfH4wR+DN+jcm1weBggcXwm9
         oABmElw+TqYgkO7eiF9Pll2Zhj2KgyNXSuQpYOgXcMLbzGM2HeqcJYamsDKxj20BZmUg
         NIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=;
        b=fTKC/+JoR8Dm1R4aPYLBAHnROxpraf308Q8USLhha2m3aqSSkbHEwXkayMmQTYrMWP
         vW9wlBEN0WAew+mvNATpegT1dGVs0ZLpee/TmpOgDuBDL33RtROPZ1UjZdshPh0IaR0G
         Fvlbsd1IxACMHDpauEyZmPj5vivoMljRbOEpT1XVhmWx39ukykrod/ohERpNFlA376c3
         i0iOioYN30ZJZjjYHeIb+oGhMg8ioiEWWfSGSYLLPA7odXOtQf3BiiVT36LTwX59YE0g
         pdxH8B+qwxK2YdPnxH8teRfialY4vzG6M+qTfP4lJozjDZTMHSWczV0xO8M5JUmEP0pB
         FCTw==
X-Gm-Message-State: AOAM530ji87tB1f02uoqOFWN68UOkgBzMeWg1eD3CKqQvxh6t85FyQR+
        db2mPinn8TZ7OcmfJNZ4i9M=
X-Google-Smtp-Source: ABdhPJzSQK/mccXT+Owi5SwS9HxQdQLIsp7WFSykJWpQoFEU50K6UTg3SvDO9HVvKqiZtT4pYwtTLg==
X-Received: by 2002:a17:902:9b91:b029:d1:cbfc:6319 with SMTP id y17-20020a1709029b91b02900d1cbfc6319mr10733775plp.3.1600227624748;
        Tue, 15 Sep 2020 20:40:24 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i20sm12856635pgk.77.2020.09.15.20.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 20:40:24 -0700 (PDT)
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
Subject: [PATCH 2/9] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Tue, 15 Sep 2020 20:42:55 -0700
Message-Id: <20200916034307.2092020-3-nickrterrell@gmail.com>
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

