Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088122A3C7A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 07:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgKCGCf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 01:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbgKCGCY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 01:02:24 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F180C061A48;
        Mon,  2 Nov 2020 22:02:24 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id z1so8038132plo.12;
        Mon, 02 Nov 2020 22:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=290Bo0sJTh/t678nA8yWOfHRoSh5E7Ekj1ME0hd0Klk=;
        b=tmkhJaJU3VHkDyTbru8lROAJsbWUowjJpfjeebweaYui9+dmpz9dp4CiqwVroJXu4r
         e8qFLTGO7BrrkBcyAJfn8s2nTfvG5gjJ1khl+BjW/1+PVJUxqn9EqV6ZrD0gvug7z8gA
         eY4KuYCaGxS6cQdPkeOmoQrc8TarN3zTBK2tbwqJ7YpAUJ56ov1ZOXJtfACGI+zExXPc
         Esk7bBmXTyf2iTDq9UrZRBWZgsW/jfXOYpNJA72ELOZo6kAHQHKxX3i+3VligPWKziIs
         cVthbjCjS21wLR2JkMrbXMLO8Y4DC/h+kZ4de4lLQ9n3XmynYbfmAnxyI0QNS8VeNWXW
         0rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=290Bo0sJTh/t678nA8yWOfHRoSh5E7Ekj1ME0hd0Klk=;
        b=iAuF+Tiz11XuyfnFEd+l2QYc2utjMo6848eimwuK7YqP5kDuDMK7jYsN123Zh5EzIM
         OAKMTU+qpudWgfd1zdaL7/2uxHiU2EIcbpQEVi/ibQpV0alWoaZ2zVJV+svWrIqCuHZT
         FJ69/43gPC76KGtTqRCFChpxoF3x1OQruWVXUYLlTP6K5j95/5YV3sRXkyvqENAqgvM2
         FUZw1pOy6WYmLxdWq9Xce++awygBUiYIEqQdXT/6UI7Xlknm4B95ae2FSjjvR7bja75V
         OtJMxdF9WrSE2UbRGYs7D5qYJPrQMOGj+9FOLNZIOYd+MuYYDiaOgOOSjQFvuGjLGAVN
         ejAA==
X-Gm-Message-State: AOAM532Hl7SzLUwJGmiHHcaywD5M0drAqnqbJf7DC4bueu0CL7aavtks
        MpllS0lJ6gw3MB4qVOrQHBdCIQudkkc=
X-Google-Smtp-Source: ABdhPJxRj4C0s/7LRqkG1TAIaPpnRoWT0V5FJT5A21qtBTEslWRfNbGEXSp9WpAS5/zlFWRkm2d7KQ==
X-Received: by 2002:a17:902:8d95:b029:d6:521f:2f2d with SMTP id v21-20020a1709028d95b02900d6521f2f2dmr24445166plo.76.1604383343728;
        Mon, 02 Nov 2020 22:02:23 -0800 (PST)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id b16sm15647269pfp.195.2020.11.02.22.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 22:02:23 -0800 (PST)
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
Subject: [PATCH v5 7/9] squashfs: zstd: Switch to the zstd-1.4.6 API
Date:   Mon,  2 Nov 2020 22:05:33 -0800
Message-Id: <20201103060535.8460-8-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103060535.8460-1-nickrterrell@gmail.com>
References: <20201103060535.8460-1-nickrterrell@gmail.com>
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

