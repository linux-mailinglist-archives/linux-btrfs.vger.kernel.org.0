Return-Path: <linux-btrfs+bounces-44-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F107E5E49
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 20:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF852819DC
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Nov 2023 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7790438DE9;
	Wed,  8 Nov 2023 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CCmK82oy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714936B0B
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 19:09:29 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D398F210A
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Nov 2023 11:09:28 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d76904928so429446d6.2
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Nov 2023 11:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699470568; x=1700075368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ico+2GUXJwyv7sBer+StcB9g2Ut3tasT+1fsfdrc68o=;
        b=CCmK82oyutLhYk8z23eR8UrJxUWNS5Uqj6vL73a4UK2lMDMsDa7l3RPVbWpU5K66uR
         vgcdr99NNxhSC01mV9z9W1wyRY7ufj3teM4KjjSel4dPNZhi7x08Jc5YUcbF/ga6LtCe
         a0WC/2W2zobt8WXo2YB93g4NZZ0VcEd8D/qqCcMZpSyfmJbKp1LLfNu6wOxm5c1yu+Me
         ogVYtxCY/yLppzf62mMl1z7wLsfpG0XiUndktLplrS0818dGj1lNGewlj+693jp/7k8l
         FWDR15qY5jiR6VmMPXF8aMb9/d+5Yo4OAjkA7IzhWDQrviP1MVen+yhgu0pZz4fmDKpY
         5Vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699470568; x=1700075368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ico+2GUXJwyv7sBer+StcB9g2Ut3tasT+1fsfdrc68o=;
        b=CmSDdnDZ3T5ciyBtu/8NfRuXf7yUzmEnGWEOF8JkHC2QvqFdj+IS/j8wYs3aDBv3OX
         obWS9HZPGnd+CcbNB97z9RsU/T9HR1AvdEZm9FdCV0CXZPo4VysWYAEIYpBm2CWVcm/j
         p4DxgB7NRKLLXj7FaKme2lm4nuw7iXrCLkERHl3jJTHcnGJz+ytVotw4qmpH20XgZ1vq
         tpxtoHjfyPMlIAgYQ950fDqCUuoieROBAiAfDccJUFSL/TOU0yybzD2cOLXsNb4BDsqD
         y3onaF/VZ6ggOvZ7cUIkcnOWO7wX6x+SC5a5cGy/Mptr6+BvVkFzthz1mRcJ8Co5JqGJ
         Ss9g==
X-Gm-Message-State: AOJu0YxBysy05B2Qx5I+553wnJ6YrN7DauRuDr3d2AiM7iX09wIhhR1T
	cIvgLWTtBBnEpqELrWCQskWUyiyM2MA1VaAHTmCQ2g==
X-Google-Smtp-Source: AGHT+IEzSqqA6xL+LS+SeYxhpMluNjuS5Iw0RALxGVOKqSX18jnrvJgO9JCWwGJRnzmEdixngHMyDw==
X-Received: by 2002:ad4:5e8f:0:b0:66d:627e:24c0 with SMTP id jl15-20020ad45e8f000000b0066d627e24c0mr3125287qvb.38.1699470567855;
        Wed, 08 Nov 2023 11:09:27 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v13-20020a0ced4d000000b0066e0c924109sm1350642qvq.106.2023.11.08.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:09:27 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2 10/18] btrfs: add fs context handling functions
Date: Wed,  8 Nov 2023 14:08:45 -0500
Message-ID: <6dccddeae0087c99dff9f9ca7ec643ae591f412f.1699470345.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699470345.git.josef@toxicpanda.com>
References: <cover.1699470345.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are going to use the fs context to hold the mount options, so
allocate the btrfs_fs_context when we're asked to init the fs context,
and free it in the free callback.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2f7ee78edd11..facea4632a8d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2641,10 +2641,44 @@ static void btrfs_kill_super(struct super_block *sb)
 	btrfs_free_fs_info(fs_info);
 }
 
-static const struct fs_context_operations btrfs_fs_context_ops __maybe_unused = {
+static void btrfs_free_fs_context(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+
+	if (!ctx)
+		return;
+
+	kfree(ctx->subvol_name);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations btrfs_fs_context_ops = {
 	.parse_param	= btrfs_parse_param,
+	.free		= btrfs_free_fs_context,
 };
 
+static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct btrfs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->thread_pool_size = min_t(unsigned long, num_online_cpus() + 2, 8);
+	ctx->max_inline = BTRFS_DEFAULT_MAX_INLINE;
+	ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
+	ctx->subvol_objectid = BTRFS_FS_TREE_OBJECTID;
+#ifndef CONFIG_BTRFS_FS_POSIX_ACL
+	ctx->noacl = true;
+#endif
+
+	fc->fs_private = ctx;
+	fc->ops = &btrfs_fs_context_ops;
+
+	return 0;
+}
+
 static struct file_system_type btrfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "btrfs",
-- 
2.41.0


