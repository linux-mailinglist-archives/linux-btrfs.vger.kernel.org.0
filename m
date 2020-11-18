Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B732B84BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Nov 2020 20:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgKRTTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Nov 2020 14:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgKRTTW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:22 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F9C0613D6
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 11:19:21 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id a18so2056822pfl.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Nov 2020 11:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+TqCFRtTZvpeH3ZlWXpEBOxlCAPGP9uQJpmr+cQTds=;
        b=r3qe8rUpY/JvlCrrwvNYGPGrOVRSr9TYmIL14MpylkfVk+ElV8pBwgicMAHyGFzhRz
         IAElmlBBJhg7uGG/6zC1bfbEvmQkzNeigYzt9bcAfwlB46toPf3XB0mwR9Ms4JH1cVOA
         n+gJRZ4+LIPIOBOefRxEZTgNJlgppKDpCjZF42ZVV2xt0vCNbxGAJ8X/N8EbIFcme1TM
         hyoPoCfVbYOjCmsemTz/i21iEKbnGfdG1I438UWqpWERaz3dD2RidkhSlf+FEeYfq+zE
         AOqKELvQlcD8ztXFSHfBLEiX7mKRUxVX4cb7JxuM25SWalI8/wuWWi/RruNVT3KxKXSc
         hY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+TqCFRtTZvpeH3ZlWXpEBOxlCAPGP9uQJpmr+cQTds=;
        b=f3VPqm7c4Bcic+1j+EeNX26x+tLk8RvFD+tnhpF79BYOsMl2RnQ04h4hM75h39kTYe
         DmWEIlMdxwcU86ul8cZguxb0c6BxBV2azArflqDt2d9WglQR91pFy0jESaXy4S0LRf+E
         LRWgsfrKsYCGANvaxDaDAplKTVaBkIx7swqvJ3pEw5DtXfWc8ZZ2/fAkM7OIG9nrwLB9
         zVi3p40TDBwo9jTDNRRGAYsWuN4NX/k4tGI/BICDgqujra4Vcwy6ribxnkjpuT2F9srq
         KF3K65llgIRa3nM6UdrQJZK56jWncggof2kv37Zhh+kP98Xm/kGCF7/hl58Knw/kvniW
         caBQ==
X-Gm-Message-State: AOAM530kt9kVkayF9hr3lg2MZFpMk0SNtP+3S9ib45mGLglw11nyfYMo
        FSS+rmbpPknkfxsvAr/eKTaQMpPaSzPN6w==
X-Google-Smtp-Source: ABdhPJwUJauYm1zSoMxCBLcPtfM2erSJk2A+9BBFFyNQciUwvihixuvSausqNYkrhRGa+3cNOMae4Q==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr496518pjq.135.1605727160278;
        Wed, 18 Nov 2020 11:19:20 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:19 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 3/5] btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
Date:   Wed, 18 Nov 2020 11:18:48 -0800
Message-Id: <81cba691d5355e218c49c44d657a6503d30c34cd.1605723600.git.osandov@fb.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
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

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 822458e6ffae..f04d815c5d16 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -81,6 +81,7 @@ struct send_ctx {
 	char *send_buf;
 	u32 send_size;
 	u32 send_max_size;
+	struct page **send_buf_pages;
 	u64 total_send_size;
 	u64 cmd_send_size[BTRFS_SEND_C_MAX + 1];
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
@@ -7191,6 +7192,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
 	u32 i;
+	u32 send_buf_num_pages = 0;
 	u64 *clone_sources_tmp = NULL;
 	int clone_sources_to_rollback = 0;
 	size_t alloc_size;
@@ -7271,10 +7273,28 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
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
@@ -7483,7 +7503,16 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 			fput(sctx->send_filp);
 
 		kvfree(sctx->clone_roots);
-		kvfree(sctx->send_buf);
+		if (sctx->flags & BTRFS_SEND_FLAG_STREAM_V2) {
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
2.29.2

