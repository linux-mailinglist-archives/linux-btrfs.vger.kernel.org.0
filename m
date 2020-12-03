Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1782F2CE028
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 21:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbgLCUuw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 15:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLCUuv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 15:50:51 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D42EC061A52;
        Thu,  3 Dec 2020 12:50:11 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id b23so1826441pls.11;
        Thu, 03 Dec 2020 12:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oICP2DQXRz8kl3Xw+I5CA1wnwdRsIw2lNW3EwvVVu50=;
        b=aHId6xA2iubISELUZk/324zK7BTZaQETDGqINUX2A2iZLmEQvZspp/hwZFliEp3cfS
         mGT0Ttge7bxjHp2ZBuaXVerSKvDvzLUEuqj4vL9Ep145emNtIVqorf7N+iaqYBkPn4s7
         sjX77mP6YI8N+aY/TGByh4w/SBOGMTbnhAKvxHVzHtkPYLpM9/XksS0CU3OajnV15lgh
         MeYey5ZtQmMZlxt5MIaaIS98kTYRBGmJrMXzKuTQXB5RQ+LNDu+8ePKfXnSmgEUYgJ7U
         oCGMvZXt/B36lPAKZo1dKIhEIgc+bkbpysqnISkdAKYtQIi/gde37hrBcxab7ab3wJtq
         G2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oICP2DQXRz8kl3Xw+I5CA1wnwdRsIw2lNW3EwvVVu50=;
        b=Yc47o+p+SbIjDaGYDKrUpW8/pxvbIspFyD/xGQ0FmVSmy8J+BssIuFJixjsRxbZNCD
         ZcMQ0pjfZ278WU70m9zo2MThI0UzJT7GG8xHtJUCXpjrl30jqNaD1QR4HTtpAGuEAl8l
         kr2Uhm2rxBxM+w6Xc8FxdlMPBhyQ04dvgLXAZY8D3R5KFx5X4IBJNSlVKKyZNJZNnsu9
         iNDzv/K+5u4TTTp9PzMeCHzLkbNwGSLRHf3aTKMQkCKAsSOMIfwKt0+l2sZooKKbDMBo
         T9LgjNs79NC1E8ZF+S99y5zLlmBtwrsKmvVuc4u40K9rLo5ui+grObHkAwnFOAhz9JFp
         8Lug==
X-Gm-Message-State: AOAM533+gMl61yh3MGRgFnnA2Flt6ZLhmmYZWFoy6XWNC3BSEx5whG5m
        Y8M981DHb1mG5FaYtU7i5Fs=
X-Google-Smtp-Source: ABdhPJxyTibG0ShhjkpVbPwQH8bIIH8MbkFKmMnx0qM8GSU5rDO9Ep5nPttliuie3dYyEhr4s1HTJw==
X-Received: by 2002:a17:902:a607:b029:d8:ba6e:9b54 with SMTP id u7-20020a170902a607b02900d8ba6e9b54mr764505plq.42.1607028610963;
        Thu, 03 Dec 2020 12:50:10 -0800 (PST)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id s189sm2529151pfb.60.2020.12.03.12.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 12:50:10 -0800 (PST)
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
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v7 2/3] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Thu,  3 Dec 2020 12:51:13 -0800
Message-Id: <20201203205114.1395668-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203205114.1395668-1-nickrterrell@gmail.com>
References: <20201203205114.1395668-1-nickrterrell@gmail.com>
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
index dab2d55cf08d..e6897a5063a7 100644
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
index 000000000000..d2fe10af0043
--- /dev/null
+++ b/lib/zstd/decompress_sources.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
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
2.29.2

