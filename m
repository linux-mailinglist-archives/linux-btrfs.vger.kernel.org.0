Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DA936BC3D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 01:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhDZXmd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 19:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbhDZXmb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 19:42:31 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C577BC061574;
        Mon, 26 Apr 2021 16:41:49 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id p12so41088102pgj.10;
        Mon, 26 Apr 2021 16:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zdyCdL1O6MHAZHMO3v3t2Hk2heeS+Nt7HrJ8IUq+ohk=;
        b=qG3AVIVOlh+jJAOJ/ofL/jF064Kdo+t1ZiyY6bwAW3+1Lc7RHlrWp+TJUJsEiP/YMb
         sX6Yq29euQNHsthnAyeGOC4Rorfs1B821jugW16rtBwkZi2FOVHInyRwY9p10HrNRuec
         x8tIHvo57UGYouJ31Fymm9TgAEbKcoXmlPxTPMxTgtbXiijTTQe5QromLPe4BmYVVd7g
         eNMMftuRueq/3z/ocASgs2oHugUz3eutvdih9+Ao2/IyBSi8nNY9ublhgFhzLFLH7r8h
         buUS4nltPkoh7Op69X12o4ghAJhj/uv5d0vh4hwRNkzg8qA9O6o4v4D0I2jmkBAN/nV1
         CzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zdyCdL1O6MHAZHMO3v3t2Hk2heeS+Nt7HrJ8IUq+ohk=;
        b=tgCgBW22qj9D+X8dCPdpHNZulx2Pbei+1uqBLIqDcSO4A7YcKEBiRJ8kseVYv14aRL
         m2/AHXUp3ITXDK4dhBKu7uSWhimEUt1N5Fzz9/zQaBl17Xn+lBp9wO2DPV8Ync7qltCL
         xCtXR5VlyUekr0/aIM6lV+dfs7ri7UG3wTZU9brPL3UMMUpbqZsln/I/O54BYnG2smoC
         1vi/gulL5DFVYG6JbAziSHWwJHG8HhlKFoiIdIv3mLzTozS3vAow2LAB/PHiUjo721Lp
         SD1FqZZ/aPu+p6OShItYnxL4lyYPOL7E7UBckMGG0fNL/UqsdoUh9NY3hfMhe2U5lQsn
         MRaw==
X-Gm-Message-State: AOAM5325UYxCIduP2Mwg/nBC7KFEVEVWfQJp23zbYKgigsxFW62dbqj/
        Uj3ZSwu4EdbnMKB8FCBWtPE=
X-Google-Smtp-Source: ABdhPJwNMzveK5M3WOq6bGS5Dy35S6A+cXn6A21maNSg0rPzd/8N2wfhp/TFPPiKuoKq/hEF7DwaXQ==
X-Received: by 2002:a05:6a00:1a4a:b029:261:d9ed:fd80 with SMTP id h10-20020a056a001a4ab0290261d9edfd80mr20213974pfv.20.1619480509313;
        Mon, 26 Apr 2021 16:41:49 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id m7sm640828pfc.218.2021.04.26.16.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 16:41:48 -0700 (PDT)
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
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v10 2/4] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Mon, 26 Apr 2021 16:46:19 -0700
Message-Id: <20210426234621.870684-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426234621.870684-1-nickrterrell@gmail.com>
References: <20210426234621.870684-1-nickrterrell@gmail.com>
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

