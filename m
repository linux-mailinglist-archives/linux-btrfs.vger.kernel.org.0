Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB477C413B
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 22:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjJJU2l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 16:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjJJU2k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 16:28:40 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430DAAC
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:38 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d90da64499cso6665004276.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1696969717; x=1697574517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TiFA2tlBh5ynC20r8LqCQ79wIpbpnZvS1/ifeJfrw0=;
        b=kuyGk9NT1Ma25pohl9uta0T3A1FDE62p3r4ZxR6oJeffEeG4SO2LqOokpOFlN4UDZG
         npzCgzLDbg5QVESymd9BHR/GE2Lk5X41r9ys8CKWnmQwXunvi11TgnLDxW912yT3jdIU
         3STKkcQWa2NrNV2287NiCxONy9IrpxOGm7WsTttm5w8YzMQSBO0QPR3gnGgFnjF6ycrx
         3QSkYzDLlv9aruryjaLETw16E0EeicPaV3MoRKfOGJ4rb/KhUwBBKq2S0JKYJPoVi/jJ
         kqDGo0MLZl/eOIHpEDHgIAuLsGhWU2JfCEF1iQXl/9i6CTnYPvKGtWUgj0wePlUgx0V5
         rbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696969717; x=1697574517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TiFA2tlBh5ynC20r8LqCQ79wIpbpnZvS1/ifeJfrw0=;
        b=d7958N5IEi60drgEBcjYNtD5wAu+6Q9WOhFtkyjXleP9Epw+aLZz3oy8d4zT3Py3HK
         vCQnVu/FxxJ+021IFwGdi/kBdYJKQ535vOCy2kruqYsaBnt5lr9W9i68+EqCaeX9pji2
         oPPh7GIAT9/eNhTyGvq2fvM/QMS2PAbf8RSA0knMryTMuzcj/V5Y/yxKJPa+7HN9dWzp
         0MiG+c38H0WDjkgeSI8gFypjhtiMR9ewS8RiczG3QIrAIW28ZoROW91j1qeiEqI2dW6s
         +kkTS3uU8xbZ8G7gJzMTpZUB2hjCZapzHQfqzqHjjQWSNaFT+Te3S8KxhyhjInp170BC
         FYTg==
X-Gm-Message-State: AOJu0YwUmXOgr0lNVWxtKINHPchfmO7eKhLiCmtcwhLsISLMM8VxdZgH
        L9iwvLYt2H7Rhd5iEbj7UaeL/NGv4P8KxJbMHU9LAA==
X-Google-Smtp-Source: AGHT+IEQis5Oy/EdWfgdP1tJ4QrBpBf7n2iH0lvxAjmkiO6ZSBR0lTJr2kgjMs0sj2r/JMahYcmVLw==
X-Received: by 2002:a25:9302:0:b0:d9a:36f6:fa61 with SMTP id f2-20020a259302000000b00d9a36f6fa61mr4287494ybo.42.1696969717378;
        Tue, 10 Oct 2023 13:28:37 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b33-20020a25aea1000000b00d8179f577basm4011322ybj.49.2023.10.10.13.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 13:28:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 7/8] btrfs-progs: escape unprintable characters in names
Date:   Tue, 10 Oct 2023 16:28:24 -0400
Message-ID: <4db28c419c3fbd6337034e9ae25d3fb234b81a41.1696969632.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696969632.git.josef@toxicpanda.com>
References: <cover.1696969632.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

There are several item types which have an associated name: inode refs
and dir items. While they could always be unprintable, the advent of
encryption makes it much more likely that the names contain characters
outside the normal ASCII range. As such, it's useful to print the
characters outside normal ASCII in hex format.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/print-tree.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 38086275..9aa1ce16 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -30,6 +30,19 @@
 #include "kernel-shared/file-item.h"
 #include "common/utils.h"
 
+static void print_name(const char *buf, size_t len)
+{
+	size_t i;
+	printf("name: ");
+	for(i = 0; i < len; i++) {
+		if (buf[i] >= ' ' && buf[i] <= '~')
+			printf("%c", buf[i]);
+		else
+			printf("\\x%02hhx", buf[i]);
+	}
+	printf("\n");
+}
+
 static void print_dir_item_type(struct extent_buffer *eb,
                                 struct btrfs_dir_item *di)
 {
@@ -79,7 +92,7 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)(di + 1), len);
-			printf("\t\tname: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 
 		if (data_len) {
@@ -137,7 +150,7 @@ static void print_inode_extref_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)extref->name, len);
-			printf("name: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 
 		len = sizeof(*extref) + name_len;
@@ -167,7 +180,7 @@ static void print_inode_ref_item(struct extent_buffer *eb, u32 size,
 		} else {
 			read_extent_buffer(eb, namebuf,
 					(unsigned long)(ref + 1), len);
-			printf("name: %.*s\n", len, namebuf);
+			print_name(namebuf, len);
 		}
 		len = sizeof(*ref) + name_len;
 		ref = (struct btrfs_inode_ref *)((char *)ref + len);
-- 
2.41.0

