Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68E22763E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 00:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIWWi0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 18:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWiZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 18:38:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E5C0613CE;
        Wed, 23 Sep 2020 15:38:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so542634pfo.12;
        Wed, 23 Sep 2020 15:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=;
        b=kXDCaLmCHlCSpz3GfLkhMgqT2UiSchxs5QLNNey72m88X40FqFzAB8d/lJuk2hihzl
         dugC0DuxKytS6WI6Dm1OOBaT9MPLn74HBXdmdLC5ZGdJVr14cZeKMwxY39NIefmex8sd
         AhrMes9dESnY9cXs18acSyeaXkrtGwFCbVr7BpU1NN0JalwShqwlXanMvQb3cycVmmP+
         0LeBnNffCVSRyt89wEY+V3H/hi+2e83ENuJbk5mQQjaPyydLEtQzGAluQ3+2oQgGHoRI
         h6vqo3AW3SgDNBiu8M4V4bw/rlHyURk6q9Sn0zaLz29ntujQc/H1MXR/rQsrqWEX8TsK
         6g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=;
        b=qtYQYwmSwOuRMFvYYcDmrsTi2y9usj3QWLz5h/T4Ehy9H8qGVHPeU2LrnJ9p69N9OC
         oDC6ngElo7fXKD+lhBNYfWI4uLJoC65dbg+cohq143vSfmeDmtTSeXyThGIwPAInJxkT
         YelejVO01+Elcj93F9gLbLxCxACV4V9VaiAsrpkY2IxFhaQSFeyXbTjeCAhPKSStAnZI
         o+LhmeDFmmXJ/Nh6IXlbkIhcWuzMmwDNPeap1dx6SIfVUuUbwAgVzIfGVwd0qrhm2Tzy
         dDZb6i17cU+n4K5efTJels7gxugyglKNaZVnQUfdzFRhuQmm480K4zV4k60WinGDqt/c
         LzcQ==
X-Gm-Message-State: AOAM53220u43LXazVHbQGLYDZJvHXPN9lpt+/TpVOqkpoPgaw5t9f9/2
        SZVi5ct8HJIyc/Gv1TCaABU=
X-Google-Smtp-Source: ABdhPJxRaooL2/Pt/x6Pz7ecJvtE3gZiEyaO6muoljDlIAGEiDU0hFyUt5AftFnqj1HWMnKgVTYpWQ==
X-Received: by 2002:a63:384f:: with SMTP id h15mr1576492pgn.144.1600900705185;
        Wed, 23 Sep 2020 15:38:25 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id d20sm417964pjv.39.2020.09.23.15.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 15:38:24 -0700 (PDT)
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
Subject: [PATCH v3 2/9] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Wed, 23 Sep 2020 15:41:59 -0700
Message-Id: <20200923224206.68968-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923224206.68968-1-nickrterrell@gmail.com>
References: <20200923224206.68968-1-nickrterrell@gmail.com>
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

