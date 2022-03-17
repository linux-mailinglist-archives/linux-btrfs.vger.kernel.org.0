Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DFB4DCC61
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Mar 2022 18:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbiCQR1b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Mar 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbiCQR12 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Mar 2022 13:27:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA470114FCA
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e13so5026352plh.3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Mar 2022 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Ema1oqCVoL3SOLFCC5gLkP1k9e610J2xmQvzR4oaQA=;
        b=0UoTKvukDlHDjNVtAdLAwMKKAyahmOxmrFPmBiZvnbHb0p26PALHtjf5xlZQ4obSkS
         onaddbon6yz0bqQsm1e9iV+kheWeZ3H4Hb+Kx4IHXW+Jih8rE2COWd1oeX9dOOBx+8lQ
         jgDNyvj56VmxQ1AORVTDLdaPfhlgPE+fn32uH/J4sFBT27T9z07IbLHkvNYX78n1kCqm
         jgg5ibTG53iTU5o9TX4bcRShvtTk0+dLndju7yk8S2jA6lv+jXcnO4vJbm7FFRg+KpE8
         jondBMZKdKXwdd1UHQtUp6mFiFoU6hedEzpFx5ifVwRJPjzuAqugr4U0Gom+xuU+hnOb
         uFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Ema1oqCVoL3SOLFCC5gLkP1k9e610J2xmQvzR4oaQA=;
        b=oOyzhCO0neHj+nb8QQPyXVqrEWYRxUmzwUciMijLlUmn7Ew5cVW6JRI8tutUHWnDVQ
         fPxfAIGeE8FjoBdZEtWAFH7sJ+HUu02XbT0FhN/abvQ+rlX4zDaMqVGVXHUfxd6sF5ty
         zKbQADnAUKiPF/SB0hw9XgbiIOYQeTmrQO00eUQ3nCfCwuFYT/dOrSF4Qk1AgfCz7N4E
         lGmZWPFXjNFbK7IwQJS6iwvAXFR/nE+e0yh9qvzomghfXpfptv8mA2muoUpUA4ISXU51
         C6hMwERhg7JfHPzJMaouEDplqiw0QKQRVZLFGPYgDMrk9A3Keq4xfzY90OfzBzbt5rkH
         5pCA==
X-Gm-Message-State: AOAM532Q6IV1j2NOOUm1Kt6v3+KbUogjYT07ajM1e0ubzOgN/CzfZmm3
        x7sEiuLiYvZEsyWA9YeTNKYq7Pj2Kj2vgw==
X-Google-Smtp-Source: ABdhPJxqey2tPftKrTdw4XtKJFIDnQGvOFdGlQO94D+N7W9Qb7Ann3aR+54W6eWnUVxz2ndAL7DGkQ==
X-Received: by 2002:a17:90a:3906:b0:1bf:a0a6:d208 with SMTP id y6-20020a17090a390600b001bfa0a6d208mr16967877pjb.21.1647537970952;
        Thu, 17 Mar 2022 10:26:10 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:624e])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00088a00b004f7ceff389esm7815424pfj.152.2022.03.17.10.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:26:10 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v14 5/7] btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
Date:   Thu, 17 Mar 2022 10:25:41 -0700
Message-Id: <4353fe7122eb0aae24e3c9ff2399f2b58b74f79e.1647537027.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647537027.git.osandov@fb.com>
References: <cover.1647537027.git.osandov@fb.com>
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
index 02053fff80ca..ac2a1297027a 100644
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
@@ -7392,6 +7393,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
 	u32 i;
+	u32 send_buf_num_pages = 0;
 	u64 *clone_sources_tmp = NULL;
 	int clone_sources_to_rollback = 0;
 	size_t alloc_size;
@@ -7483,10 +7485,28 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
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
@@ -7679,7 +7699,16 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
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

