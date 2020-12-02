Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614882CC7C8
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 21:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgLBU3O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 15:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgLBU3N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 15:29:13 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5514C0617A7;
        Wed,  2 Dec 2020 12:28:33 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w187so1979241pfd.5;
        Wed, 02 Dec 2020 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WENPVElJQF3n0FCtwr/Deyj/08dbHxSq1tQKlooFAvw=;
        b=ezehFisbVfB+MB8e754s3Ekkx0EUMSCv2vXtrYfxfh+ntN+w8g96YN7QKALLza/OYJ
         mpanSL+Ly9/PnLfUOOGTw0C/6bozOQ6lX0LrzyEqYN/0cyNh2GcvHPS/aG71VQ/sMKWO
         AND6z5oZxtEjUeNwq0aObCu0zdewzC4QNtTYzymORIggWs2ZQx2wjUuZxsFolCEDf+7v
         bHR6L1FO1cIObDSoDksj/MxYT82noLVvkLCoQrFlt3clf/RlQEx6mzxQt3NFPrs6e/I7
         mQ1Vi7USiZD/8CXlOS3rH83MsN0aVWU57mALEm6mC+3VCBSaWJiWQNorfZq1QqOEDAiz
         9MZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WENPVElJQF3n0FCtwr/Deyj/08dbHxSq1tQKlooFAvw=;
        b=T4ZDoQyV91C+YpZFT6bTrxU6qJHCWSfTqs6Dn/J3nMudu34uPhk7JOH6Potbh09Rcn
         TYC20jQyoIs/hqDbUG6070mbHSaNsfNWSeYhjMfuioZ3FzJOB5jYUmg2/AeHdlWV4Cxg
         PuK/ZdCsf6LG3vEaxKVdoMtSsSzB61CoPlrsEufIGcpbWmNnF6ugeSRnZBHLx/MyHv+b
         ZWWQC93r8YZVL8UFRZURjAgJoOUtAHbHQSxwn+kl4S072luRzUMD7L8UoJAFILpQ9bk8
         DFKDk45YWvSYQiFdGP+J4ZW9vIx1wa21UV7VPWUiBqmoqN1wg5Lhromu91tH9przNo6i
         ffCg==
X-Gm-Message-State: AOAM531r3kmDwtZfOhJ9LDNkDMmaqZsAPigXKy9WS8LmjfRXEMIloS5h
        0sUvJ6bRQeJAlz5/VBvbl/s=
X-Google-Smtp-Source: ABdhPJx8DYIDpxyFh2AnnF0HS8udrS8iv3EKguuhCCjewcbdOTJFX69vygn3dqnL3eh8PqeuPKQTIA==
X-Received: by 2002:a63:b60:: with SMTP id a32mr1424789pgl.275.1606940913171;
        Wed, 02 Dec 2020 12:28:33 -0800 (PST)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id r11sm535120pgn.26.2020.12.02.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 12:28:32 -0800 (PST)
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
Subject: [PATCH v6 2/3] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Wed,  2 Dec 2020 12:32:41 -0800
Message-Id: <20201202203242.1187898-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202203242.1187898-1-nickrterrell@gmail.com>
References: <20201202203242.1187898-1-nickrterrell@gmail.com>
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
index 87ff567fd76d..d42281d7d416 100644
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

