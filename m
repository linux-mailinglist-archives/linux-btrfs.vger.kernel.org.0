Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD227E1C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 08:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgI3GuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 02:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgI3GuO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 02:50:14 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B15CC0613D1;
        Tue, 29 Sep 2020 23:50:14 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d23so420795pll.7;
        Tue, 29 Sep 2020 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=290Bo0sJTh/t678nA8yWOfHRoSh5E7Ekj1ME0hd0Klk=;
        b=quExN3Iu3Mb6d/UbSzvBc9+cO4HZkGevMkWHJJ7W1q2osihKIEitmFTUS7S4DC/a8B
         Djq2RRxKptwhCyVnDAAKLhiLPhj6j70fqz5FZ1O8s+TP499yKjY9uweY3C1DUsHsEmxr
         Wj8OhKdZ4gvV2O2CcWu3A5CEKTA42mJ82M2LoegMyBjduowXfl4Tb/lU/q57++1a0czJ
         xUJPCpEKzzjTPW1b7ccAGvQKY0SRaT//CVcuJ6iVa7JVmy0OAVbV2V5VZXsltNjr2nK8
         YTxNeKVOSAjLdde08BBUN82CxzAoHJqym4o8/Ir/ErgsyYrdHeBIAv5j/EpU8icjiihI
         A2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=290Bo0sJTh/t678nA8yWOfHRoSh5E7Ekj1ME0hd0Klk=;
        b=IB1Vyi1w1Adrxmx+ZMAbEya4BTQ/H5T7wqEBRVYHSEGrhEeyVUXSNiFY8YwCkY/zFD
         wIbuHQCy7AJHUaTlLS/ByovvIlk753Gm6PikxCFgCF/KfBAs+qq+m9ykPrUnogh5m1Lz
         qEfPQ898cKMOwh3zHQ7MHu0R4DfY8A8k3oV/pr/zGOx+z53QBzMrbtrzqwjJsgyopa+/
         7EsUrt4g2nTstnDJsZ3ji9LZBV7iuefi7uVmU2hlk/YGoY1RIhoyJYYx2p2Gt7xhS9GW
         E7gQaP7/eCi+cnHF1j5/Wt7gUAGiM8LSlUYVu79/ObauWXDeFPjbhNId2V3MtBwFEREw
         lN7w==
X-Gm-Message-State: AOAM531+1VqtjqpeFVDWp38nfFoQ6nCjbrxf2gkMIxoyv1TaFx5LsgwM
        fgfxE8zTJXaIGKLm3FHKU3c=
X-Google-Smtp-Source: ABdhPJwZAqxnVJJGlifdOFLWl5NCGkwvpGyckSZ7o9lTNGIZUmlSvZKrTdsofp7uNXk7hCIRx3HFew==
X-Received: by 2002:a17:902:7890:b029:d3:782e:8a8e with SMTP id q16-20020a1709027890b02900d3782e8a8emr687882pll.70.1601448613562;
        Tue, 29 Sep 2020 23:50:13 -0700 (PDT)
Received: from nickserv.localdomain (c-98-33-101-203.hsd1.ca.comcast.net. [98.33.101.203])
        by smtp.gmail.com with ESMTPSA id 190sm1100865pfy.22.2020.09.29.23.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 23:50:12 -0700 (PDT)
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
Subject: [PATCH v4 7/9] squashfs: zstd: Switch to the zstd-1.4.6 API
Date:   Tue, 29 Sep 2020 23:53:16 -0700
Message-Id: <20200930065318.3326526-8-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930065318.3326526-1-nickrterrell@gmail.com>
References: <20200930065318.3326526-1-nickrterrell@gmail.com>
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

