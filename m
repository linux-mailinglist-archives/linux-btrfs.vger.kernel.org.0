Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6146E8339
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDSVOh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjDSVOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57B7680
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:10 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ay32so50849qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938849; x=1684530849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn5ETOHgeL99ji5uW62ENcETMqZPjSkdK0pWCTqtEio=;
        b=LukgFlt1IpVsnnsAxKG/S8cVu1KiPP6nIE8EjRd0IqInC9QqiLFoCzcXUxyPnpEDoL
         WJQ23ov5diSrdqkqFd+VYMYrAYQ6ilI+BqXw4Yr5zLf1T+PS8Quszz1V7+4GF6moJSdZ
         Sc9L2NzXrcXT0RHY54BkZ/HRmGpNn5R2mT+zgZeLdNQORRjY8UzZIdd+38/+ge1anFNQ
         cFKCTVdMhjrQDa1M+7yjgTVHZ2/u+vl5S9Mi1xjkNDEv4NPmXoeq7aXV3bswjmdzGK93
         AFrpczfTZ+4TldzxWW8tt/arg+1q4mXcnxDP/oyaC8lTEZMML4M0mLkAxuEoNiDe2meJ
         3GuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938849; x=1684530849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wn5ETOHgeL99ji5uW62ENcETMqZPjSkdK0pWCTqtEio=;
        b=iViFRztkuil7qwAWJE9OuTZsWWhKT2EgjFBSJxErq/WnVYPRKJdpA/Y/IER3lWgEIJ
         yCFBLWRpP6iqwodfwVisRJswxMV3jGirtnbr34pX39d6TMUXmHZnzDVgJdUBOJtEsqhx
         sRqrQA8t3wroYFbXCaprwkwPHHLWq5CUYEnyWYQ+16W+PwYXj3azmG5mN75Y5VNRRV4O
         fQd9luDcB/jqCoYOqoYuizbvUNfE9CmBgDPL/8Z9CgtAKYhHmxnYLD9K8EngV92i55U5
         2UL/JnVECywYRCyXxuGKWFCihvfA7k9yd2hiH3LEugPx6t5gD3R5Cs7cGkV7jbxrm0Bt
         D+1g==
X-Gm-Message-State: AAQBX9cUIZUPO7hv1y7gwu7jwse/tbT/UptJ4cvxMJMN5nFHJwlhxG+r
        NzZxJJpOmAeH4D7/wh/GiPpUZnINh9m0RxQkh1om7A==
X-Google-Smtp-Source: AKy350arUOoLH+N/qfWjo0uymRqXxfzYOs4TZzN3gu2z56ch+QxcnkpuGMXVrGM5NdRkIxxP8I1Qtg==
X-Received: by 2002:ac8:5f0b:0:b0:3e6:4069:9136 with SMTP id x11-20020ac85f0b000000b003e640699136mr7054851qta.45.1681938849159;
        Wed, 19 Apr 2023 14:14:09 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a25c900b00745f3200f54sm4897993qko.112.2023.04.19.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:14:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/11] btrfs-progs: consolidate the btrfs message helpers
Date:   Wed, 19 Apr 2023 17:13:49 -0400
Message-Id: <f8e4600390b15a7e95e22e9c2d2b5687d00a8be2.1681938648.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938648.git.josef@toxicpanda.com>
References: <cover.1681938648.git.josef@toxicpanda.com>
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

These helpers all do variations on the same thing, so add a helper to
just do the printf part, and a macro to handle the special prefix and
postfix, and then make the helpers just use the macro and new helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/messages.c | 32 +-------------------------------
 common/messages.h | 30 +++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/common/messages.c b/common/messages.c
index 5e7f2dfa..d6dc219b 100644
--- a/common/messages.c
+++ b/common/messages.c
@@ -19,9 +19,6 @@
 #include "common/messages.h"
 #include "common/utils.h"
 
-#define PREFIX_ERROR		"ERROR: "
-#define PREFIX_WARNING		"WARNING: "
-
 static const char *common_error_string[] = {
 	[ERROR_MSG_MEMORY]	= "not enough memory",
 	[ERROR_MSG_START_TRANS] = "failed to start transaction",
@@ -29,40 +26,13 @@ static const char *common_error_string[] = {
 };
 
 __attribute__ ((format (printf, 1, 2)))
-void __btrfs_warning(const char *fmt, ...)
-{
-	va_list args;
-
-	fputs(PREFIX_WARNING, stderr);
-	va_start(args, fmt);
-	vfprintf(stderr, fmt, args);
-	va_end(args);
-	fputc('\n', stderr);
-}
-
-__attribute__ ((format (printf, 1, 2)))
-void __btrfs_error(const char *fmt, ...)
+void __btrfs_printf(const char *fmt, ...)
 {
 	va_list args;
 
-	fputs(PREFIX_ERROR, stderr);
 	va_start(args, fmt);
 	vfprintf(stderr, fmt, args);
 	va_end(args);
-	fputc('\n', stderr);
-}
-
-__attribute__ ((format (printf, 1, 2)))
-void internal_error(const char *fmt, ...)
-{
-	va_list vargs;
-
-	va_start(vargs, fmt);
-	fputs("INTERNAL " PREFIX_ERROR, stderr);
-	vfprintf(stderr, fmt, vargs);
-	va_end(vargs);
-	fputc('\n', stderr);
-	print_trace();
 }
 
 static bool should_print(int level)
diff --git a/common/messages.h b/common/messages.h
index 6a105484..4bb9866e 100644
--- a/common/messages.h
+++ b/common/messages.h
@@ -40,6 +40,28 @@
 #define DO_ABORT_ON_ERROR	do { } while (0)
 #endif
 
+#define PREFIX_ERROR		"ERROR: "
+#define PREFIX_WARNING		"WARNING: "
+
+#define __btrfs_msg(prefix, fmt, ...)					\
+	do {								\
+		fputs((prefix), stderr);				\
+		__btrfs_printf((fmt), ##__VA_ARGS__);			\
+		fputc('\n', stderr);					\
+	} while (0)
+
+#define __btrfs_warning(fmt, ...) \
+	__btrfs_msg(PREFIX_WARNING, fmt, ##__VA_ARGS__)
+
+#define __btrfs_error(fmt, ...) \
+	__btrfs_msg(PREFIX_ERROR, fmt, ##__VA_ARGS__)
+
+#define internal_error(fmt, ...)						\
+	do {									\
+		__btrfs_msg("INTERNAL " PREFIX_ERROR, fmt, ##__VA_ARGS__);	\
+		print_trace();							\
+	} while (0)
+
 #define error(fmt, ...)							\
 	do {								\
 		PRINT_TRACE_ON_ERROR;					\
@@ -87,13 +109,7 @@
 	} while (0)
 
 __attribute__ ((format (printf, 1, 2)))
-void __btrfs_warning(const char *fmt, ...);
-
-__attribute__ ((format (printf, 1, 2)))
-void __btrfs_error(const char *fmt, ...);
-
-__attribute__ ((format (printf, 1, 2)))
-void internal_error(const char *fmt, ...);
+void __btrfs_printf(const char *fmt, ...);
 
 /*
  * Level of messages that must be printed by default (in case the verbosity
-- 
2.39.1

