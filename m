Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A49C454E69
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Nov 2021 21:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbhKQUXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Nov 2021 15:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240665AbhKQUXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Nov 2021 15:23:11 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD00C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:12 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l8so3879287qtk.6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Nov 2021 12:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBQva0FUvt3/5vG/ecPqeKPJFo4tO0Jrs3EWII0VQ54=;
        b=IHrt7ef/F10KfuYQXnzg26k8VxkjppqEW+UIqeXu1EF5M5waQcu+xtaffU1noxOlcj
         l7ii6BQYYhwr+tHs+Hinpv3MFJ/kZn67KqSZQg2LBdrWBREDzraoWQ2HvRS7zX4Kozhn
         qkSCyI7iw7e8RaAQSrCMlIk1e+ZCAqmFDSeOuhlb78EUTg0iGwII8TVcLCLrbX98ADS/
         8T5k0Cr8/t+oR7fTbwv16sePnhXUxIwRxa6Hl+S3QrcQH9VgF+jKniPcMJioRRLGItwx
         6Zfao4Gqnjlhhx5Wb4FLuxtPG8e7lRqHJcDMHNThlJcL8rhe5oAvm1nPpW+/8hWb1hKy
         4GxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBQva0FUvt3/5vG/ecPqeKPJFo4tO0Jrs3EWII0VQ54=;
        b=UNC1IBWWGxYuaYgoEAOcprhBs7pB3ptRuVU6YRJTZq8wOlbO++0Rgbdt2PZtsTXz6e
         5uyQfSWIqihnbbO02GeVvV8MKIhAWdohyLjKAv5ywnj6/yb4m0UORKY/fqcgJMeO9eSv
         mZAdvwGHCBNbFURGAhnNl068Y36JCaUZ8k3oWKUyjOfiyf1DNOaxeHzK7NaYzjIpwtuG
         DTYmxj3s79M8wIxizP8x3X89Wq6Bx1XMSq/hJ2rkDs4RcdWMcj6/BKJvXXS6zq9drXIX
         GzzF7RUWo2mUgFRkAIsW7gQDDxJhozkUus+xdsq3bdlWUfkMdWCdMc1mvKwxdsaA0IQH
         RRtw==
X-Gm-Message-State: AOAM532zvD7qwU5rAW7mo3vBfrkbzCzl3fldt0LIh0Km++Poog7sWAmC
        e58HK47jQIgbIgouO4XcI4dQdiXNf/Oy1Q==
X-Google-Smtp-Source: ABdhPJx9r/04O5IehEisXGLFVPtDNv3IDa+/CJYNLMdJA2sOVbMwtnMqx364AstNjI78b9Nj/KO3wQ==
X-Received: by 2002:a05:622a:18e:: with SMTP id s14mr20896510qtw.203.1637180411174;
        Wed, 17 Nov 2021 12:20:11 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c091:480::1:153e])
        by smtp.gmail.com with ESMTPSA id bj1sm438074qkb.75.2021.11.17.12.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:20:10 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH v12 11/17] btrfs: send: remove unused send_ctx::{total,cmd}_send_size
Date:   Wed, 17 Nov 2021 12:19:21 -0800
Message-Id: <27b1a93caae1666ea29ea76f3eb6a7aa2878e65e.1637179348.git.osandov@fb.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <cover.1637179348.git.osandov@fb.com>
References: <cover.1637179348.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We collect these statistics but have never used them for anything.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6bdcb9d481d5..500b866ede43 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -81,8 +81,6 @@ struct send_ctx {
 	char *send_buf;
 	u32 send_size;
 	u32 send_max_size;
-	u64 total_send_size;
-	u64 cmd_send_size[BTRFS_SEND_C_MAX + 1];
 	u64 flags;	/* 'flags' member of btrfs_ioctl_send_args is u64 */
 	/* Protocol version compatibility requested */
 	u32 proto;
@@ -722,8 +720,6 @@ static int send_cmd(struct send_ctx *sctx)
 	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
 					&sctx->send_off);
 
-	sctx->total_send_size += sctx->send_size;
-	sctx->cmd_send_size[get_unaligned_le16(&hdr->cmd)] += sctx->send_size;
 	sctx->send_size = 0;
 
 	return ret;
-- 
2.34.0

