Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ABC36F38E
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 03:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhD3B1K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 21:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhD3B1I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 21:27:08 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01439C06138B;
        Thu, 29 Apr 2021 18:26:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j189so1368434pgd.13;
        Thu, 29 Apr 2021 18:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdyCdL1O6MHAZHMO3v3t2Hk2heeS+Nt7HrJ8IUq+ohk=;
        b=BYxmhK1n9H0nKDwO+Ha+zT+rMPj0BzlGTzWDyIUEvUJ27eS/Ny06fZjIa178mQ5kAK
         6KWXx959qlaBOih9YYjuXhRR30lUCqEIjJ+SzYKjXhTJVxEbjOCnbgwfbunn65KI12bG
         MKMNdxbh6g+3fhJaQ7DhxVNM3i7yCd7GlfKrfAMb2pmhgk2R9baWfkP9nbaBrSuOpYzc
         GKq9Ff3w7QwWWbA/etFwGyclavrFk5Dfv92VUIyycgq2nJbU3sh+SRsEc6XHOD++w3+/
         608R0qjpax0lIvHZ9VPSTbNjsVqvQsrOfEw24xPJzRiifGaGdf1Gwp6lwuNfoe3vqNPV
         kGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdyCdL1O6MHAZHMO3v3t2Hk2heeS+Nt7HrJ8IUq+ohk=;
        b=OHsaEjN3QH479xybQ+evGRL8rv/mBe9E76kSWBaaGpMl8GpJkA8cecdExDpOx+D6Y3
         2DWn7NJjxJ1uHnnx7wvWh/2rT5bzzEiecKDGSYAKjPBJb+NVmH41862+t9Y+CsGYQt03
         UWRvP8MWGbjRis/BSn6duPVWKu1xi+mJoMOoOe2baqB8M5XH5nfZAaLNLe1gvecEFLs5
         3Lb2aGGUJAEuNK3IWam63wbBVwPRI0TQKehTF51teSEXgaITduaiesgRcByj3q/+pNMO
         xQiyCzVedhqC6WgCTeZRTa9ahCsyRVQpFLO3T7oJKaRkUVl5LD2fVQWJlVA9GBKNEpzb
         RLrQ==
X-Gm-Message-State: AOAM5305he57tzmpUHM67Jx7uU0fg386sWxap+Wcgq5WzHv8pkFDcmDO
        jaPnWU8JOf5FuhYzBOkMyMG38NZ32fqPPGUT
X-Google-Smtp-Source: ABdhPJxasLAAXECB+ejCznswoVICk6jyMEwCmKhGuuiYamVdkto9Mr5qLdUoNKMo7NUkMExKCMsCew==
X-Received: by 2002:a63:f715:: with SMTP id x21mr2280456pgh.399.1619745979497;
        Thu, 29 Apr 2021 18:26:19 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id b186sm311004pfb.27.2021.04.29.18.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 18:26:19 -0700 (PDT)
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
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Felix Handte <felixh@fb.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v11 2/4] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Thu, 29 Apr 2021 18:31:55 -0700
Message-Id: <20210430013157.747152-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430013157.747152-1-nickrterrell@gmail.com>
References: <20210430013157.747152-1-nickrterrell@gmail.com>
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
2.31.1

