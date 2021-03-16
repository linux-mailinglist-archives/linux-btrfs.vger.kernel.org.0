Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BA933DDF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 20:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbhCPTpq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 15:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbhCPToh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 15:44:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA13C0613D7
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:33 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c17so5955331pfv.12
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnFkdLJUN9TtvBAkU5e5gC8CjqnLnnasN5mbIWLeeYY=;
        b=ReDgWn6Bd9w+s2lcR0+83v4j8619TtqfvJyE6zZDOVJkwN3Ar50vaup7tsLEC9aqf3
         4Gljz73V+iSHPmbi/lKJlootjqYPmlXHpsFeTLLsvdPQTAfrAKC4Te+Lv1jXMK2tGquQ
         K5FSdG1KcsYd1nGfDp3E63U0z5L+Oz+hJXNvewNb3MIvlh21srFYJoY4NNKziyZWg51E
         BCWE6ixSW4CtZwDv/04dMlGew4HuQI0X6saI3dH4v9VYBj1agXbr+INJl3hJtmFnEvdI
         tUyvwa9HuefXJzS5aMmNZl1K5XIxCQYtnt2yhSQLoc9BdIpY05FEWM3oS0f1UdOVVGW7
         uTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnFkdLJUN9TtvBAkU5e5gC8CjqnLnnasN5mbIWLeeYY=;
        b=fKkYTI4JY13WU8Znz7Ag3Xdp4RpczKJ79EYPtRrAxttM9JTUIBld7PBKgC/2vuDDYS
         VnQukgNiLdxg/6NXbsZ1Qbgu2dX3mnndJQq6SAyp7C/xGeRWh/2Qa+rsnxtnqKQ/YuZq
         eE+gIvi2w99Ug2yXCztLM8MBEbpy9lFxTtnuusHJ5LSHcvV/guPu0U83jQOhrSO/JxDT
         /3j8NtFPyicOw940+RNSONWcK1UK4hBfvUqKsKpvThS4Co+NGE+pMzl/D37Sokw/ZDdr
         2yXRmjZPqQPVWrOiclXL//D5G7qEUT5SZ2TX+2hOqbLif/g7fIkHriAJtW2pkHQmXmkT
         vm1w==
X-Gm-Message-State: AOAM533YKoxG+JB+wsYzgKaYm66ioKsfeaelvjds/4ijYLGGU2Y0kb1r
        gxsVLtUTz8OOAxlkF6Uj5KEexq7Q6ORwTQ==
X-Google-Smtp-Source: ABdhPJwErqasvPtJK2lkxLDfU67zMGlFywvbyUETipq/bhyzk5aqcThTiFfQBAngEXwXAmZWzCFofg==
X-Received: by 2002:a63:1d4d:: with SMTP id d13mr1094657pgm.103.1615923872244;
        Tue, 16 Mar 2021 12:44:32 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:31 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 3/5] btrfs: send: allocate send buffer with alloc_page() and vmap() for v2
Date:   Tue, 16 Mar 2021 12:43:55 -0700
Message-Id: <41449ae28ca4133f7aa27e6ec477d0c60586b3d4.1615922753.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
index 98948568017c..25b1a60a568c 100644
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
@@ -7203,6 +7204,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
 	u32 i;
+	u32 send_buf_num_pages = 0;
 	u64 *clone_sources_tmp = NULL;
 	int clone_sources_to_rollback = 0;
 	size_t alloc_size;
@@ -7283,10 +7285,28 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
@@ -7495,7 +7515,16 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
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
2.30.2

