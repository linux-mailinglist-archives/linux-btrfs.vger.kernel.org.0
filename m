Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF426BAD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 05:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgIPDoU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 23:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIPDnR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 23:43:17 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FCC061351;
        Tue, 15 Sep 2020 20:43:13 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d13so3118404pgl.6;
        Tue, 15 Sep 2020 20:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=290Bo0sJTh/t678nA8yWOfHRoSh5E7Ekj1ME0hd0Klk=;
        b=KEm0UVHF1Z/Vd0ckYj7yXuuG2AXFzwVDsLdcdoVQhNvG6DuSNx/aQJ6PPeHhVcQSuZ
         u2VxPlPV30RHTwhHAM5T8aC/Mftiyqsy8vGBRLuXefq5lF0QCKk6+2e7BbkPxBsgv74a
         BCBCLAHFqhCI4dTN3g5qGZlL3bUQSf/I/eHUoF+SImgPfbAC2vfI3b+1Dr9PgEbJzJz8
         6Pee+NmrM9WC0Cms5Zua+0mBnMCugV6xej/EplN3TrcJayU/UwLp+pdqpCgHSNMZvWOK
         Y+lDOzxqJeud3zPIRok5iX50CwArL4vaEJsMzHCme7lPl5RigPxKb/V8y7XCvaDFJri2
         mY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=290Bo0sJTh/t678nA8yWOfHRoSh5E7Ekj1ME0hd0Klk=;
        b=RAn11rJsHuoLA8u+7kcHHTrt7t7xxRJNLna6OjpmFxh7/IhaMJaI5B8Ik+S/DYyuGF
         lgWXWkrRLLN0VC0AjQgDHwcpHUg5JhuYSNkSa+tweJmly6r3aBG0mKIxtoGfr/87o8oE
         yGeUgWE9e/YGzzhikyQdEzi6p4v1zBGt361sZfvavIZonUF1sHkS2zUlVcy09IOoHepN
         1CqEkU1yjXr2jrYnB9eVBhSuUvO6K5U7AcSDkkCRZDBWdg3AYvxovhdFvPJi0e/QKrbk
         rtgMetpeDL+K+k/aclW5OdrHkMs/sJGjpTjfJyFgaHhN90FwsW3Domb6HhU86ynoK0V7
         tyXg==
X-Gm-Message-State: AOAM530vUfXmFkS17RsxFdXkJmu/yUdtvlu7fqlRPTqfVdtCY+auwKW/
        lRgS6dphIu8eeG8YlRFYZjI=
X-Google-Smtp-Source: ABdhPJwz0tJz5V2Zp6LFHtcG67dfL9Sa620SacOp3zJK/NqJ2OB/Y4U6PnsTvIhiG018YR6FJ37l/w==
X-Received: by 2002:aa7:948d:0:b029:13e:cb8d:60e0 with SMTP id z13-20020aa7948d0000b029013ecb8d60e0mr21545205pfk.9.1600227792869;
        Tue, 15 Sep 2020 20:43:12 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id i20sm12856635pgk.77.2020.09.15.20.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 20:43:12 -0700 (PDT)
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
Subject: [PATCH 7/9] squashfs: zstd: Switch to the zstd-1.4.6 API
Date:   Tue, 15 Sep 2020 20:43:03 -0700
Message-Id: <20200916034307.2092020-11-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916034307.2092020-1-nickrterrell@gmail.com>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
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

