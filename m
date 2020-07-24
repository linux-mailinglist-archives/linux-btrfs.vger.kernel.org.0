Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A5822CB3E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 18:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGXQlv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 12:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXQlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 12:41:51 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D0C0619D3
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 09:41:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 2so5077820qkf.10
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HBFSRvFWH+Ir8eIbCnL528l4TLi5HMxmJ08ACA7wj3o=;
        b=AngzZWcUqDrBltF+KWRPh3BGpcPA+Q0DoXIuaoZQIhFaYRO7vMN5Zg2qJzLtnAhxgP
         iMO2K9F4juJRYysB4ZnRgzYGyK6X/3Yrrwk5lyJUepDbPnN+LPfwEye6ChXRckhxMx5U
         2dRuVJmTjypw8/77SnftgS5WgjyWEEEVbsPTUuoGKGsz3Uwb/kTTXVw/dSdtEqXcEf4M
         ehxU5jvOfP1wjRRDF9X+5KBbi5eIWqzMuuO4LOr5tcrSW1HJggXe8MDZe+QZ1JvCKCQj
         kCgtqgyagQlsGoKnOU7WcRMT8koPGpBtWcQ/m9wCPEl6ccx/RiWCL9aP5dNQY8Key4/V
         53ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HBFSRvFWH+Ir8eIbCnL528l4TLi5HMxmJ08ACA7wj3o=;
        b=CuiwGtIx2AXV56Y04D1yIpLBEgD39kfyvOWvSw91fuTdy1KchMXU7ZB1ZCO7Phk4T1
         ThcVZI5o4ZgFR784q6jqPwF/+foXOwWcH3/GZldIOU9Aj5mHzqC34WY6LtlL6erfS8BH
         PbCVw567JRbD3PYTptAGhjAHg/STDw+HImMyTU8Q0AXj90eDpRem0dST501ukYCSnF0M
         vwZWUrAZRnfhPGg01R58gazABB7TAenRiHxm9g1giIToPB1RJ2eWb2vYNBth6QeAU59R
         zusjeTLyN4YFEKeqI09tXFZaHKa4iXCVer2xlJdtBLLHY1HAUjEeGeFA3uI8w32J/tIY
         Xseg==
X-Gm-Message-State: AOAM530lI40W9p5BKhJ1T+zRbluQluf8j6xQVpUGNpnNvJxTWCgPGecD
        ZvDFUBw8hUZeFQgDllF8xp4Oe/qlkd8w0w==
X-Google-Smtp-Source: ABdhPJx1iX2K5rUihlKS/E1JimQA8iYUrPHvUQ6xWh1n83murNOum4WNIEg+qIOujVt/AgONM0E8Sg==
X-Received: by 2002:a05:620a:346:: with SMTP id t6mr11164532qkm.29.1595608909588;
        Fri, 24 Jul 2020 09:41:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a5sm1919582qtc.44.2020.07.24.09.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 09:41:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: do not evaluate the expression with !CONFIG_BTRFS_ASSERT
Date:   Fri, 24 Jul 2020 12:41:47 -0400
Message-Id: <20200724164147.39925-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While investigating a performance issue I noticed that turning off
CONFIG_BTRFS_ASSERT had no effect in what I was seeing in perf,
specifically check_setget_bounds() was around 5% for this workload.
Upon investigation I realized that I made a mistake when I added
ASSERT(), I would still evaluate the expression, but simply ignore the
result.

This is useless, and has a marked impact on performance.  This
microbenchmark is the watered down version of an application that is
experiencing performance issues, and does renames and creates over and
over again.  Doing these operations 200k times without this patch takes
13 seconds on my machine.  With this patch it takes 7 seconds.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h        | 2 +-
 fs/btrfs/struct-funcs.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9c7e466f27a9..b0fe8cca7e86 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3238,7 +3238,7 @@ static inline void assertfail(const char *expr, const char *file, int line)
 
 #else
 static inline void assertfail(const char *expr, const char* file, int line) { }
-#define ASSERT(expr)	(void)(expr)
+#define ASSERT(expr)	((void)0)
 #endif
 
 /*
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 079b059818e9..f44dc1207792 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -17,6 +17,7 @@ static inline void put_unaligned_le8(u8 val, void *p)
        *(u8 *)p = val;
 }
 
+#ifdef CONFIG_BTRFS_ASSERT
 static bool check_setget_bounds(const struct extent_buffer *eb,
 				const void *ptr, unsigned off, int size)
 {
@@ -37,6 +38,7 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
 
 	return true;
 }
+#endif
 
 /*
  * Macro templates that define helpers to read/write extent buffer data of a
-- 
2.24.1

