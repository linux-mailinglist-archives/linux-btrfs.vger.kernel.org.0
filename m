Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450854B15F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 20:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343754AbiBJTKo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 14:10:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343750AbiBJTKo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 14:10:44 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4035110C
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:44 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i6so10040030pfc.9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 11:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBHnkiFwQgGlRibgIKmNQj+ejfFIM03MUokocJ326cE=;
        b=3mR/vACmT2E5sICY843LKKHw4xRZ2IWyxcVLwMSlAQW6tOIuyKKCmbcoMz6Pu/zWET
         OmmSauyJzsGDB85zxsuuMQY64WZg7Q4hp1zwKNNXhW1pFK2wR+hktIfzyHHC+hG2lzB2
         cESBHgjbuIretqgpzrbP+6qxPtDrQH+g4NeSj95RJ4oEkKwebGfyEGrRMnKwrNXRFUyJ
         J6somegPucYQ/kGZSdoipvrmxuGPmjoYwHUHnPJ9x8gCb3vsrh7ursTJsho/LleV+uxv
         zgpLzjQD4m1OXF6eJc5LFLUx3Ea8ZNz9oOdNeFjK3NeiCz/ShugMhRdkUxLZh8Y7V73c
         Y8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBHnkiFwQgGlRibgIKmNQj+ejfFIM03MUokocJ326cE=;
        b=jBsN2ax4yvgEMnH5fAK3LSlkg9lclb6eTckuTXsp3SClhVQ3xfagyBb17agWvn7K59
         O3nk9VQpWI/6rZNbxT5hUYYe3MLlHrVoOxUHAYOWqGkEm6VMSJRKIS0mag2atCCNYvST
         j9795s7A4cMKIOGBAM71LTE9dGEwOODC+Nlxj0z0fai8z2xN/4DXLxnAo7iuTxYezFsH
         QOy4tFOCr6Meod7HNcEX1nkoTenT14p1cKFInafWKMpH1ejHONPds0f+9JR8zE806ddm
         fGXaePBNaF/l4rWkxny4KuuRUsElAsMW9Y72l/3YChceXQ6rs5f7HAczb2lNt5IF7DMe
         G4JQ==
X-Gm-Message-State: AOAM5321lJyBomAMC7nmf2tKwGTs7hhii6adopMF8tSPJeLc8kI+3DOf
        A15HaeYh+GxEk9yIfMQxX9TG3Ma0SvvAsA==
X-Google-Smtp-Source: ABdhPJyptkJzZqTLcqdllOgI6jNIvWJvLtgQ0EYLuEWiAUTUbE/rUFOWNevnoFME3zrXowXCM7kODA==
X-Received: by 2002:a63:1d56:: with SMTP id d22mr7270992pgm.149.1644520244066;
        Thu, 10 Feb 2022 11:10:44 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:1975])
        by smtp.gmail.com with ESMTPSA id n5sm8315898pgt.22.2022.02.10.11.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:10:43 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v13 15/17] btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
Date:   Thu, 10 Feb 2022 11:10:05 -0800
Message-Id: <fca5f8f1a18b5e3b975074fe1dd56237db74359e.1644519257.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644519257.git.osandov@fb.com>
References: <cover.1644519257.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

For encoded writes, we need the raw pages for reading compressed data
directly via a bio. So, replace kvmalloc() with vmap() so we have access
to the raw pages. 144k is large enough that it usually gets allocated
with vmalloc(), anyways.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6d0686c51f80..2b0bb8b8f972 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -83,6 +83,7 @@ struct send_ctx {
 	u32 send_size;
 	u32 send_max_size;
 	bool put_data;
+	struct page **send_buf_pages;
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
 	/* Protocol version compatibility requested */
 	u32 proto;
@@ -7497,6 +7498,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
 	u32 i;
+	u32 send_buf_num_pages = 0;
 	u64 *clone_sources_tmp = NULL;
 	int clone_sources_to_rollback = 0;
 	size_t alloc_size;
@@ -7588,10 +7590,28 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	if (sctx->proto >= 2) {
 		sctx->send_max_size = ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED,
 					    PAGE_SIZE);
+		send_buf_num_pages = sctx->send_max_size >> PAGE_SHIFT;
+		sctx->send_buf_pages = kcalloc(send_buf_num_pages,
+					       sizeof(*sctx->send_buf_pages),
+					       GFP_KERNEL);
+		if (!sctx->send_buf_pages) {
+			send_buf_num_pages = 0;
+			ret = -ENOMEM;
+			goto out;
+		}
+		for (i = 0; i < send_buf_num_pages; i++) {
+			sctx->send_buf_pages[i] = alloc_page(GFP_KERNEL);
+			if (!sctx->send_buf_pages[i]) {
+				ret = -ENOMEM;
+				goto out;
+			}
+		}
+		sctx->send_buf = vmap(sctx->send_buf_pages, send_buf_num_pages,
+				      VM_MAP, PAGE_KERNEL);
 	} else {
 		sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V1;
+		sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	}
-	sctx->send_buf = kvmalloc(sctx->send_max_size, GFP_KERNEL);
 	if (!sctx->send_buf) {
 		ret = -ENOMEM;
 		goto out;
@@ -7784,7 +7804,16 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 			fput(sctx->send_filp);
 
 		kvfree(sctx->clone_roots);
-		kvfree(sctx->send_buf);
+		if (sctx->proto >= 2) {
+			vunmap(sctx->send_buf);
+			for (i = 0; i < send_buf_num_pages; i++) {
+				if (sctx->send_buf_pages[i])
+					__free_page(sctx->send_buf_pages[i]);
+			}
+			kfree(sctx->send_buf_pages);
+		} else {
+			kvfree(sctx->send_buf);
+		}
 
 		name_cache_free(sctx);
 
-- 
2.35.1

