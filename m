Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E347E2F7C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Nov 2023 23:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjKFWIv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Nov 2023 17:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjKFWIu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Nov 2023 17:08:50 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEB8D75
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Nov 2023 14:08:47 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b9ba0c07f9so1370080241.3
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Nov 2023 14:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308526; x=1699913326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNj+yYFj8tqbacxBJz1am0Z6u5J0WjWsVcH94aw05E4=;
        b=BHVlEeJuuWvNk7U5IB68dWDP4yKfUFn9+sWB+K+z3xNPndQ8cVAP09IFOuSeSwUasv
         A0gSlFxhzk+bkBtZVDQ+vw6qwsC/4cuyR9yyyjY7SqNifmiKi11wyZznaPBIkxqlX4JZ
         f9VUoLhCE/45e2IQPZZr1hliQXpz5b2hS1NayGFKBnvJRz3aqAIrnh6a4o112cT9hR6c
         YuZUMY/XHv3sUlOn49Kd9OBJqywutIruY+2sAqzGMI2wdhFm8ELmMNXF9HmgI5nBGEXr
         3Z+bY2KWum68fTbuZNS0smsT2roLIH5EaeuXvA1m3YHR1ls3vBxKNmgwzeiq89Bg2DGn
         3xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308526; x=1699913326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNj+yYFj8tqbacxBJz1am0Z6u5J0WjWsVcH94aw05E4=;
        b=Hxzao7peHGQHWO69QMBfB4G6R8+VbOSJkuORqs/v5ijNwdBavkr162itGgdP99P60Y
         M59qqooXcc4+DN+PJP7x5mTZQv4Plq7BR4y4VDJ3B0DQqXwiyxwCainXD61QjN7dw7Rm
         IlPuoQhZKxUyauCrrzvQFBa987fG8PUdYwSjBMp2MeZzU9efd38QKFMdq8dkhd4/nYFf
         tVQH8sNzM6CUQHOky3XvHoXoxYdn3T+WeaRVXmNaPr+1dT9mZHzXm1yQ31inr0+hj0GE
         I7GQ581catfB0CbJrcmWR8XxjWCbA+dKBkEbANam53Ay9I5xQRzmDw9q9XwB1a1p6WKl
         BQpQ==
X-Gm-Message-State: AOJu0YyXcd44nNDJ46z8tPgFzgUFXD7a355ctwIoBsOR33xhIyCDYGhp
        aLJHhVqJXcwhJL6P/RFl+ugGRECLP7SaYINQtlmMog==
X-Google-Smtp-Source: AGHT+IHVhBh30f+JOoAVyc2QKsR/ah623UmoWl1SgIkgpR+dr8rnAw01DthOC2rPkDANWzHKMwaNFA==
X-Received: by 2002:a67:c315:0:b0:45d:a616:78c with SMTP id r21-20020a67c315000000b0045da616078cmr5820829vsj.21.1699308526373;
        Mon, 06 Nov 2023 14:08:46 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ks12-20020ac8620c000000b0041cb8732d57sm3778912qtb.38.2023.11.06.14.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: [PATCH 10/18] btrfs: add fs context handling functions
Date:   Mon,  6 Nov 2023 17:08:18 -0500
Message-ID: <e6dfe2604e70f50ca96ab03f8bd2c7bb03c8a6ba.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to use the fs context to hold the mount options, so
allocate the btrfs_fs_context when we're asked to init the fs context,
and free it in the free callback.

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

