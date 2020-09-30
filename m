Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1110D27E1B1
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 08:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgI3Gto (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 02:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgI3Gtk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 02:49:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B89C061755;
        Tue, 29 Sep 2020 23:49:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d13so490383pgl.6;
        Tue, 29 Sep 2020 23:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=;
        b=VTD6SCyZPXt/5nIAOEqALhGagetdiFPpYbIX86qlGxbocho1y+f/mpB80lXEz+tm7C
         WPqAJDixQU0DnytgSTNpm86PRzC4bTyHZxzdH07dQaxcBmAC98P4JRlPQytUlDnujCYw
         VCsdX6QF1B02CM23+AJV8X7BVrHIXixUbS0yeeRHhIkH1zwu1ShforEv739Ju+sB6gmL
         31LGEumu0hEvVb7seUGzaCvZaOBZYnzRUnxV4oYPoH3oI0utmkBBYtWHKCu+Jf5K4clj
         sHMtq1TgNfc44BNLwIcegLpJB66wA/8eIYjaBs0sYHw5Mv6rRakjsuEcif2kLmaWxV7L
         Dhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=981H7COrDglg2y2OsdhN4Ry4swXs13dJrOliSNOnl9g=;
        b=X+qvdSMGFqPED8yy4uKjBWd/6n/QGi3XJV0jDiin0F5PmlRSYCAnOxutKfSCi7d3jc
         AMy9KhWfLKX/i5eMVcIFA3LqKXRJ6HuaaNvSyLRHmqHrYsg1cw6FwZoMWjcb8lkSHRWr
         GnvBY7VIcDFQru6dQHcUta85qz/84CgMyGaxXJPIHAdIMB/vxyfEP6xy2knELyjqoO9N
         rA379L9uOe+z/8yOemuqDYBsQQS8j4U/YzucKDWe9i5CYs4lYYOCZiGw9Ek01Wc2X5+k
         XjK0aLOLOsomDZZRFAyAz/l+q86P+BJ9lpSvIfjM08MZcfIHiR7ZSLqxfkcPt9x6MtTD
         nCAA==
X-Gm-Message-State: AOAM532qomhp4OBJYAt/glq+Ei1hrjzVwO/LLqpCeL8LZ0bVWdhXWP9P
        122stvZ3nVfauoD20oJ1ilc=
X-Google-Smtp-Source: ABdhPJw9Vmlwv8qFlV+Os7mUuWY82swGcHqlIj/BIfXkC1jOiYDEGvYsgv1t43sX4UNIWOFDU2oM8Q==
X-Received: by 2002:a65:5bcf:: with SMTP id o15mr1054550pgr.126.1601448579954;
        Tue, 29 Sep 2020 23:49:39 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id 190sm1100865pfy.22.2020.09.29.23.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 23:49:39 -0700 (PDT)
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
Subject: [PATCH v4 2/9] lib: zstd: Add decompress_sources.h for decompress_unzstd
Date:   Tue, 29 Sep 2020 23:53:11 -0700
Message-Id: <20200930065318.3326526-3-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930065318.3326526-1-nickrterrell@gmail.com>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
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

