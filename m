Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383ED454E6F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbhKQUX1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240680AbhKQUXP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:15 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C706C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:16 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id m25so3837418qtq.13
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5Zki3IDt4r6PccCuQgtvcWDAYx/BgmU2YdgzEIORh8=;
        b=JNCQIDUtEmyVP0r123eqEtSUSjuERhrlbyt5BKU3uEiZwmxwrIKfq4Skcxd7ddyjmv
         A7crQDBrVA/76vqLmPwgvQqYLbbMqI8bXh+CPJQhYwmRMQRGmj+20UwWOtmg136M5WSS
         6JotuPUYvONPn6HuUudaLoHNIFQEV4tT5KTkVyeHbyNcayd1WncjYrjTblh7kYZWOeMg
         A9Sp4JaiBXGVhHf5N3LLWQUbWOSbfxBkFQth9Anx9L7WSmsimJFhhKVypjiaEttF83Lx
         tlo0/qv+IlNzklGrxA/z+gLpOoejsYaUWlhs8Un4OvrgmbFmiKpapQQwtx94QS4PwEQl
         2PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5Zki3IDt4r6PccCuQgtvcWDAYx/BgmU2YdgzEIORh8=;
        b=5qszRgxj1nm11Jhr4YKsFd5qb8qKeDt/XHof/1HC0++iitOWfzVN6VsPZu88IWVcr3
         Bx61jhU09+K9DNbDhrUd8pUrhYGIdK/gEDG3qty8x7BWKk8Kw85l2HfqnhSIc/q5Io+h
         6C8qWytBwNULBSGJgz8OASBJ5TS2wRJnYy2jyoEFK7b24fi/sVXwwO0AxBpRZY/b3pVb
         DUj68j1UBBDa8GuLwjdANBe+6VtJD4pgMJMuPo0ydPf37On5M0MQPZ26mFmDpGsVzYuO
         iA+P50OB93z58BTSyH0fHGgKQeRw0EhOFLxiTlRDTTtmKDl7LmsDU4c1eBqh8TQFSndW
         A6lg==
X-Gm-Message-State: AOAM5315IdFeTr2paLeDACaFCx3OYWft0JATPpXKYYgdzZ0sNTM4wWJi
        QPpW+wLosf1We1htPm8IwR++GcvEUr2VVA==
X-Google-Smtp-Source: ABdhPJyzb8E1VJ9VX0VbLLyKqh8Zk2wKKNcCOY41eUjkf3FWEWuoaZhX/gBSArzs1MUInf/uG71i9A==
X-Received: by 2002:ac8:5c50:: with SMTP id j16mr20418863qtj.255.1637180414922;
        Wed, 17 Nov 2021 12:20:14 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:14 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 15/17] btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
Date:   Wed, 17 Nov 2021 12:19:25 -0800
Message-Id: <0a04aed8ad4bfd2137afbf5a5ffb6f07080c3d31.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 12844cb20584..8493335ef47a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -82,6 +82,7 @@ struct send_ctx {
 	u32 send_size;
 	u32 send_max_size;
 	bool put_data;
+	struct page **send_buf_pages;
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
 	/* Protocol version compatibility requested */
 	u32 proto;
@@ -7225,6 +7226,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
 	u32 i;
+	u32 send_buf_num_pages = 0;
 	u64 *clone_sources_tmp = NULL;
 	int clone_sources_to_rollback = 0;
 	size_t alloc_size;
@@ -7316,10 +7318,28 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
@@ -7526,7 +7546,16 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
2.34.0

