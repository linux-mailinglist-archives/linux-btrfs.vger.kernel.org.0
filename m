Return-Path: <linux-btrfs+bounces-301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946C67F4E1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30ABEB214D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901D859B67;
	Wed, 22 Nov 2023 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jjCoQYd3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E657911F
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:14 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5c8c8f731aaso54850617b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673494; x=1701278294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In9hJLjWS6zK/dhcsmyoCh7QbuZA4L9Viz0TrhYQUBc=;
        b=jjCoQYd3NOVH7PqObx0E9sPshXek2W87kqMhlivkOFAzun+i31fUDr4aGXnYIdczv7
         f4bTKGWcnDLQbmlot10ZjAiRk5cPia75X3Ih7qc5HznkXZkBpxx0glrJKEWEBtj8cKLP
         yOe1QA6m88LkejC4PnPhuXeb6hyO4RQ6UI6pZXFePUB8fBWuxIGhyO3uh4RaKB8f7TVW
         VOQIiS+NoWfO3nqN6Jit1TV1ZZ+MflZ2HW40zJvayMRmG0cASIY+g0n9JD9sLiFjTtgb
         OvDJsMDhwAdKmucpUjKIR9vJRgQtLak1/569Eq8ZgtGm4EH/yrivijGEmMX3RD3cj3Sj
         PL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673494; x=1701278294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=In9hJLjWS6zK/dhcsmyoCh7QbuZA4L9Viz0TrhYQUBc=;
        b=e37FR6jNKd3mSlRKQTvInT8l7VRBr6qPSXVa+KoXMVAiNGk2iyAkmTpLAwGNzh3dsc
         hJ1ntoZJOh2q3/0309ElTLvC+wCLf8ibONrQ+om9XyN3EgDQkIO1IRty9uRSnvTsHphF
         uWiCnaNxMV/x5k4/8tbpiPu4QfaYl5pycktK94qvEsB9Y1/CgESGrG0PeDxTzFzXjaXA
         75bX9Ka9GPGy3bS/C48IJWrTEmcXB8p4m9CRcca2OtEHXBnECe04YXPWibk3oySbB882
         vGCmcSZHcCldtdwnapPmsVh8S/7VRHd6Z9hA+G0WKPUvwp/lWPM6dCD2SgYASPgio4Gj
         +P5g==
X-Gm-Message-State: AOJu0YwFenjjC/QiMHbf7FkkkERItj7V90b6Rf4hX1+0lRJXQDXoOeWu
	70AbHT4yYOYk2uwOSPLLzJlSVxYy1U0QrhuAxA0LM4I1
X-Google-Smtp-Source: AGHT+IH4PbK+wpvGEbHamGbl2197DPtnAzDD3QykWVeYddDahHAe/wBRWEj3TfvywkSLL3lTHBLtTQ==
X-Received: by 2002:a0d:e60f:0:b0:5cb:e94d:17e1 with SMTP id p15-20020a0de60f000000b005cbe94d17e1mr3018302ywe.10.1700673493993;
        Wed, 22 Nov 2023 09:18:13 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id h7-20020a81dc07000000b005cb331f463esm1520443ywj.8.2023.11.22.09.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:13 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 10/19] btrfs: add fs context handling functions
Date: Wed, 22 Nov 2023 12:17:46 -0500
Message-ID: <505b7f1e781ae401e1e774cbbd01222776a3f5d2.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
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
index b1764efbc8f5..ef7de1e6d242 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2650,10 +2650,44 @@ static void btrfs_kill_super(struct super_block *sb)
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


