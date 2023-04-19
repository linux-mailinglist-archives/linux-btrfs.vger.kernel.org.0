Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FFC6E8340
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjDSVRd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjDSVRb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:17:31 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CC14C37
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-74dd7f52f18so304785a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939049; x=1684531049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3GO2XLvZPNia8l2y6FQ8F/ozta7KsGyMfyHU4RwaX8=;
        b=ty66nLS/D/FoXGm+0vZyUyuqIz7nFyMyD1PbgoNKBKmuLnuO/4LOmVXRqimdckzQ7l
         TCBvWqKLsH9kyNzICc8aoGtHAvxHQ9Y+8hnqyU+5NFmFKhHtRLlntEbS8Fd43ft8NHcS
         d+WuZIDjeJx/tbPlD+W367cmqrfp3uwYMqnVv6j+q0vtFdT7Cv1miI4bFGexald6NX2Z
         TShzAlhcWmtVznEYlWe9G7MCkdLp3r/WyRfr+P9iTQnITOPAfQiU7hSWNBAw8u5vrpDP
         6nOOuflRRw3Ynw0yUuPV9J7tWplDqgr2qj8SBKj02PRLRNbyKndLBCHI+mbSuGvEyifk
         iNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939049; x=1684531049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T3GO2XLvZPNia8l2y6FQ8F/ozta7KsGyMfyHU4RwaX8=;
        b=CRcFfBALfGFaga9+mBEr90e96s+hIhLJ5Ly+VHoMV7xxL5NmQfEo4WFcRpXRfrwcIg
         4kGaJ+L9i45kcFkaQqEQMLeTgZNl8XmkqFiEk+7v/tD0DuYH8nBLI7G/57zYz9+A1tzJ
         AtPAq0kO+UTJsATOBrgPYKUfj93jqnbGTKvfA2oLoSL85HZkQAE+4PPiSJQXFGWTi6Ti
         IECoAYLCxBoJwzr6RPMtX9JHefxNUkiVl/RTEhxXqKZ8MuXTNE/zP3kYdz23QgVsp+rN
         m6Js6Y16wM5rcooAIJy+J9SPyUDC1I46A6i5PJTwIb8AdZCl1WxdJqsmRm2Qp5JMT5Gs
         2gvg==
X-Gm-Message-State: AAQBX9fRy8+gLwcTLHOF/YFhikmJ2b37vcqpJqBnuhtkekRFhe6W0dS4
        mkPj1+6zVKlzbJJlTUJcJinPQFRA+4743D5NNOpT4g==
X-Google-Smtp-Source: AKy350ZEkw4xE6NFesfDHUROj3IgBeUhbwJR6rbZnlIS3VUXj44Nbv06WwWLxybJalsgvyPo883R6Q==
X-Received: by 2002:ac8:7f07:0:b0:3db:9289:6949 with SMTP id f7-20020ac87f07000000b003db92896949mr24530qtk.3.1681939049353;
        Wed, 19 Apr 2023 14:17:29 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u28-20020a05620a085c00b0074df7857e72sm2211740qku.34.2023.04.19.14.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:17:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/8] btrfs-progs: add struct va_format support to our btrfs_no_printk helper
Date:   Wed, 19 Apr 2023 17:17:15 -0400
Message-Id: <4e645609d525e855ca2a0b87d23c5fc2d1329d54.1681938911.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938911.git.josef@toxicpanda.com>
References: <cover.1681938911.git.josef@toxicpanda.com>
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

We use the struct va_format to do nested printk's internally with our
message handling.  Add the appropriate user space code to make this work
properly so when we start copying this code into btrfs-progs we get the
proper messages.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/messages.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/common/messages.c b/common/messages.c
index 8bcfcc6a..aff5ce48 100644
--- a/common/messages.c
+++ b/common/messages.c
@@ -16,6 +16,7 @@
 
 #include <stdio.h>
 #include <stdarg.h>
+#include <printf.h>
 #include "common/messages.h"
 #include "common/utils.h"
 
@@ -25,6 +26,8 @@ static const char *common_error_string[] = {
 	[ERROR_MSG_COMMIT_TRANS] = "failed to commit transaction",
 };
 
+static int va_modifier = -1;
+
 __attribute__ ((format (printf, 1, 2)))
 void __btrfs_printf(const char *fmt, ...)
 {
@@ -35,11 +38,39 @@ void __btrfs_printf(const char *fmt, ...)
 	va_end(args);
 }
 
+static int print_va_format(FILE *stream, const struct printf_info *info,
+			   const void *const *args)
+{
+	const struct va_format *fmt;
+
+	if (!(info->user & va_modifier))
+		return -2;
+
+	fmt = *((const struct va_format **)(args[0]));
+	return vfprintf(stream, fmt->fmt, *(fmt->va));
+}
+
+static int print_va_format_arginfo(const struct printf_info *info,
+				   size_t n, int *argtypes, int *size)
+{
+	if (n > 0) {
+		argtypes[0] = PA_POINTER;
+		size[0] = sizeof(struct va_format *);
+	}
+	return 1;
+ }
+
 __attribute__ ((format (printf, 2, 3)))
 void btrfs_no_printk(const void *fs_info, const char *fmt, ...)
 {
 	va_list args;
 
+	if (va_modifier == -1) {
+		register_printf_specifier('V', print_va_format,
+					  print_va_format_arginfo);
+		va_modifier = register_printf_modifier(L"p");
+	}
+
 	va_start(args, fmt);
 	vfprintf(stderr, fmt, args);
 	va_end(args);
-- 
2.40.0

