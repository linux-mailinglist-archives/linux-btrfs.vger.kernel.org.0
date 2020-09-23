Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DD62763F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 00:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIWWjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 18:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 18:39:19 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46206C0613CE;
        Wed, 23 Sep 2020 15:39:19 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so593176pgo.13;
        Wed, 23 Sep 2020 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=290Bo0sJTh/t678nA8yWOfHRoSh5E7Ekj1ME0hd0Klk=;
        b=rntHv/l8i81xrUrJZaum/4CBHjVaChe93wcHMpr4kzhSayGTC4JlwUReQdim/gtble
         IW3nWXYd8niBBBYiaTnC+8/MzFwoZFPaXqfgPUL4NZE5HzFziZ9U1rU1ng4pdet+QXWz
         bCUFdYUxktEXcB8Cdl8aLthah9Q66m1Qk/WZiQ0eWyjtAD/Y77/UsoAhXePNaXjkSnD0
         ljujAj6qnYv6sRv3yX1AHCK9QngPBUzlrkdEmo7dxRHrM7ra+Deb6Cldrc1XGJqyW4nD
         lCvvBAe7kd5DY1k4Mu+WtGIrnzbvgdTN3Vp32EMSXlww1CxjD7UJFgpbHh9MuZ5SMx/4
         ejeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=290Bo0sJTh/t678nA8yWOfHRoSh5E7Ekj1ME0hd0Klk=;
        b=e0q2TmjmefwbzWMGrnLfXt9nwZ2wT/q5fpGcpRBN10Xr+A2tem2OaOii2jMX7jnBdb
         Pea24XVmu0/7MHq2sxamoXz7xoha5Ex9RiiJYIcB/WyZNv/7l0JM6EYMEhaLsxpeEkHy
         2t4aXa/qxV/eiztBbOH+iGoLDyCwVyhODPXVrSL5cjc/Dogbea9EalMcMw5GR6u0YMMp
         i4T+0nvU+nudhN/+PULw+nmCM4RiOWNn3tFm8GOz3tfVcsO0B3ZAauKhACls8VIAwiso
         SlnVOsjjFXoHKBg192QH3nQ3TnRBCDwvkC8wTuJMvdHoKpaiIcRJ+9JUxpadbbYu35lS
         mkGA==
X-Gm-Message-State: AOAM530SZSVKV/GH7XIUECOzVHEy7J23wWn77uvYuI7uCvACWTHVfTt3
        FIHzsP2GhW6XtdQLo4KB2fk=
X-Google-Smtp-Source: ABdhPJwxxbrCN2rraAHy6PxgAVcj0F+cZCxi+3LujAkBcpHIA4r7LjmnWzG/ktYMG+XnAVCJ0r5a+w==
X-Received: by 2002:a62:19c4:0:b029:13e:d13d:a081 with SMTP id 187-20020a6219c40000b029013ed13da081mr1867606pfz.24.1600900758806;
        Wed, 23 Sep 2020 15:39:18 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id d20sm417964pjv.39.2020.09.23.15.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 15:39:18 -0700 (PDT)
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
Subject: [PATCH v3 7/9] squashfs: zstd: Switch to the zstd-1.4.6 API
Date:   Wed, 23 Sep 2020 15:42:04 -0700
Message-Id: <20200923224206.68968-8-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923224206.68968-1-nickrterrell@gmail.com>
References: <20200923224206.68968-1-nickrterrell@gmail.com>
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

