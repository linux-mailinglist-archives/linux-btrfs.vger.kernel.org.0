Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32CC34AF1F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 20:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhCZTOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Mar 2021 15:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhCZTOU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Mar 2021 15:14:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5DBC0613AA;
        Fri, 26 Mar 2021 12:14:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v23so1380348ple.9;
        Fri, 26 Mar 2021 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eZ1XyrRmWI9aSyLAK6XW+5gukvn2M+SvfUE70SUpDQ=;
        b=Jl6NIyEEkokUTYkrd5gDZszVhtnDTLPQZnzzowtNmfnfe/k/eDnmFmtOdCwNtQEfOz
         ASHjeC7TO3Q6WqVBlLuahcUDTayqS70gvIV1DQOL5ssz59nP3pdzSS2Rq7m8WT4COuAn
         2n6QEwqMIRdrxW4edFPe6EauqlbjPA5VPxjCGu/fWdHzslSe02Ec1LcwC48GuOQEbzyk
         /xLbpj93pniQTBqj9RXjL2mZ9l9mgvLQ5yXYbWd53pQn+sPlLBbjxN2mdskdKBj8kd2H
         PfNwnOSplZ8gAjjwfqFNDhzvHLjypauL9hXKgGKRKoJfhf8JK1JuulpxNJjDV62GH/NA
         nXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eZ1XyrRmWI9aSyLAK6XW+5gukvn2M+SvfUE70SUpDQ=;
        b=b8LBo6USgz9uv3Q0kxxeJrGr5v60fzH5pW37dykm7juU6R9X4C+yAtGz3bBfGnLSVi
         RLo9T0H/VgvmH57E+rLluzg7b0lh6rRJWwMb7lOHT4LdejjwLKhgWemsTzFwC4+zNBpg
         hPaoKa0JEQJSTYLWKet/Gv5JrhBnqfqay4eynmwgNf84kNoSdvtui3OQCMLuC2Qu5ZpI
         hmaR51dPU8BcM8eaF9E0aUuLnZfIl8pVQ+Bi6bCPPPs1aQRA8NL9jZCXp9ULnD7BbRAw
         +k5atovo2IHYwDuPgnHxkYX3kEiEbFgqHL/PxeKRcSWsCdqxsSei6T4w+/kKF+CmMptZ
         HPtA==
X-Gm-Message-State: AOAM530T9nnZOXIPIr+V6NdAO8Y9QgjtxKYvhUJpCCOxs8s3FydhpnyK
        Atp5j0eRID7Mx44g4zmB/48=
X-Google-Smtp-Source: ABdhPJwC5GQ5QiIvjxNM+oEQ5vB0p6D7E7m6FIhXTLkEZ1knmX0LiYX6gLmUXgQ0AlQ2xFoFn/C5eA==
X-Received: by 2002:a17:902:ead2:b029:e5:ba7a:a232 with SMTP id p18-20020a170902ead2b02900e5ba7aa232mr16732246pld.19.1616786059579;
        Fri, 26 Mar 2021 12:14:19 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id j20sm13113765pji.3.2021.03.26.12.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:14:19 -0700 (PDT)
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
        David Sterba <dsterba@suse.cz>
Subject: [PATCH v8 2/3] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Fri, 26 Mar 2021 12:18:58 -0700
Message-Id: <20210326191859.1542272-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326191859.1542272-1-nickrterrell@gmail.com>
References: <20210326191859.1542272-1-nickrterrell@gmail.com>
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
2.31.0

