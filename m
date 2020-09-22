Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07E4274ABF
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgIVVGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 17:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgIVVGq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 17:06:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13003C061755;
        Tue, 22 Sep 2020 14:06:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so2073006pjh.5;
        Tue, 22 Sep 2020 14:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=290Bo0sJTh/t678nA8yWOfHRoSh5E7Ekj1ME0hd0Klk=;
        b=udWInwD6+iDMDF5qa5ECiPoWwamXQZS4jUL9DfMoKR24Bo9+KJ/iJcaOtCwW3b+YNQ
         3qi9uuzap/5RzlsoHVYpxbNAvLrViJYLnqvFbcQRT0PFISfLjKELFIfqSsRi9I4a8Wao
         ORIRPG5SBSJqL421NhXPOOgIhJdNctoMXQAzftEPTk/oRQjEtKXNO+okItqSJQJP9TaE
         oSAKCnhrC7ryW47txY9LSUvjFOmet2iaVShjDbwtPXYgzcsafBFNvTNhgHdTSB0YInzE
         7wwzRvRg5lFm2Xpdbvr1lkR0ylpD2GgcIuXJWA4pxFDfTx1fRn/MvwteTBtnQZJ66z4l
         g7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=290Bo0sJTh/t678nA8yWOfHRoSh5E7Ekj1ME0hd0Klk=;
        b=M/BzpVr3efxB4CF0i2YrBG6tSbilQxDF3UO3UbMNl/Wks+VilA2Psk5RJBVwGG8bC1
         v0CPq444XyEcOQOgw4QHJEpElzo4ThnsfYyCwLCaAqm8riOsnmRConR2lurL+fsR1/uT
         arDN80zn6IaAixRB2+x2JjRuydJrxh1eknhtXYqVDHuwvZ7pwnf8Rr8CiXSeAVWK+HQ4
         JUWZ5BQzC8rGq+fySmv9VjGoK3vS3V1uKnBjwMzjzD5m/TRg+Q0Ai7o0N4bgB2sFEcGw
         hQUvBMIe4kR9xlUFYZG5H6ofIv4DD1jJgTh8/nQ/uqjatJE6fqUlelMeZTetJkk1V2py
         6fRg==
X-Gm-Message-State: AOAM531a/ivEZgV4DtFoUBDuHJx5WrOm/4/49HCjKKD8thOjKIZi95v3
        JoQHkJd01PuiE3iP8fAAOC0=
X-Google-Smtp-Source: ABdhPJx8EYU7jI5znDDCeD8P5MYNtlPo3YntB87Innw8jLk6l3pYufRW7NKM6HFDhc7EwXzet46KjA==
X-Received: by 2002:a17:90a:f309:: with SMTP id ca9mr5511873pjb.0.1600808805569;
        Tue, 22 Sep 2020 14:06:45 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i15sm16118945pfk.145.2020.09.22.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:06:44 -0700 (PDT)
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
Subject: [PATCH v2 7/9] squashfs: zstd: Switch to the zstd-1.4.6 API
Date:   Tue, 22 Sep 2020 14:09:22 -0700
Message-Id: <20200922210924.1725-8-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922210924.1725-1-nickrterrell@gmail.com>
References: <20200922210924.1725-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

Move away from the compatibility wrapper to the zstd-1.4.6 API. This
code is functionally equivalent.

Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 fs/squashfs/zstd_wrapper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/squashfs/zstd_wrapper.c b/fs/squashfs/zstd_wrapper.c
index f8c512a6204e..add582409866 100644
--- a/fs/squashfs/zstd_wrapper.c
+++ b/fs/squashfs/zstd_wrapper.c
@@ -11,7 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/bio.h>
 #include <linux/slab.h>
-#include <linux/zstd_compat.h>
+#include <linux/zstd.h>
 #include <linux/vmalloc.h>
 
 #include "squashfs_fs.h"
@@ -34,7 +34,7 @@ static void *zstd_init(struct squashfs_sb_info *msblk, void *buff)
 		goto failed;
 	wksp->window_size = max_t(size_t,
 			msblk->block_size, SQUASHFS_METADATA_SIZE);
-	wksp->mem_size = ZSTD_DStreamWorkspaceBound(wksp->window_size);
+	wksp->mem_size = ZSTD_estimateDStreamSize(wksp->window_size);
 	wksp->mem = vmalloc(wksp->mem_size);
 	if (wksp->mem == NULL)
 		goto failed;
@@ -71,7 +71,7 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	struct bvec_iter_all iter_all = {};
 	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
 
-	stream = ZSTD_initDStream(wksp->window_size, wksp->mem, wksp->mem_size);
+	stream = ZSTD_initStaticDStream(wksp->mem, wksp->mem_size);
 
 	if (!stream) {
 		ERROR("Failed to initialize zstd decompressor\n");
@@ -122,8 +122,7 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 			break;
 
 		if (ZSTD_isError(zstd_err)) {
-			ERROR("zstd decompression error: %d\n",
-					(int)ZSTD_getErrorCode(zstd_err));
+			ERROR("zstd decompression error: %s\n", ZSTD_getErrorName(zstd_err));
 			error = -EIO;
 			break;
 		}
-- 
2.28.0

