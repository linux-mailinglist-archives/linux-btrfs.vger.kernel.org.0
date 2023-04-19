Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5456E8334
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjDSVOj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDSVOO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:14 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE33A8A42
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:08 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id oo30so967404qvb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938848; x=1684530848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wp7JRuy1EErxfwqeKDMuoBMSJHlCf3KZHOe0EPEXt7Y=;
        b=T2Uf62MHAwawIn+KQOX9hKH+ebyjz0j6tF8Klv7FxlcPKISlH0fu20ryFr/7L63blV
         8X7FXobtZiicty1rhyCoQalchOwmG3j+XH0L0UFyz/LZK7ghDSEWmjaYlQiJfx7F7EKX
         RcaKkrXDw1AjyQSQImsnKcytOH1kdgNHyb23D5WDA53QlXTN/NouWy1I/5906xptYfA6
         dmnNpbHnv713XneQvhbFbDRbgAynv4B549TK9zgs78Zv8+foR2yDrxfyWTjlmAogJczR
         Nt9Py0yUJDjdwE7sqJzaeApguJScJ/c6gMGqJbZvmHKYCrdW/KmYMkLjXpxGshOSpv6k
         FrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938848; x=1684530848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp7JRuy1EErxfwqeKDMuoBMSJHlCf3KZHOe0EPEXt7Y=;
        b=Ps4pSJXFXvT0rOXuWPFtI8j3hHr9ZIz3rbzXru8h3LYnTA12nqBT44LgvvkvWrcXvw
         VOx/9ic8d8VuY7PAxcTquod9dArAYoLqX3EcExLVCMAVJ50oolRd3Pu1ziWzmF0MGWRF
         bRunDbFDsQK7khitEMsiKM8yDYm9E+ZsSz+WRktJuSovH1hYpXnu3jfvLXKto1YRoegK
         ywuDokmOmStIoSK5WY9MS/vBYGbweZlID4uciYSH+sMc9PA/kX+SY2Xt0JoDpBLUm5Uk
         NE4awmoYnaWpmCEdV5Uh4v5DfkbsI8QXJsGRMO6XitbzCSUJNvLCofJZ+FnrrtPablf6
         X9Ig==
X-Gm-Message-State: AAQBX9dKMCMsi7pyGakCd5FS1qb+c2sHyg8Fw+8OObfdx76Ce3moS5Xk
        jqGlivAJJ7JhTR4FKP6oMNoyZ8hyap4RgVqtnUr2dw==
X-Google-Smtp-Source: AKy350aHxHo1r15noBlojZZC5/VmmDnZR+2bathopwu0HRoRg+h5IrDSe6jPhSTbWnTWqhvH0OHXvg==
X-Received: by 2002:a05:6214:2a89:b0:5d1:acb8:f126 with SMTP id jr9-20020a0562142a8900b005d1acb8f126mr26006986qvb.38.1681938847811;
        Wed, 19 Apr 2023 14:14:07 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b007486aae42fasm4942966qkb.33.2023.04.19.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:14:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/11] btrfs-progs: remove the _on() related message helpers
Date:   Wed, 19 Apr 2023 17:13:48 -0400
Message-Id: <e9c06678e0b87678c9b753358c5bfe9667c07008.1681938648.git.josef@toxicpanda.com>
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

We have different helpers for warning_on and error_on(), which take the
condition and then do the printf.  However we can just check the
condition in the macro and call the normal warning or error helper, so
clean this usage up and delete the unneeded message helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/messages.c | 34 ----------------------------------
 common/messages.h | 20 ++++++--------------
 2 files changed, 6 insertions(+), 48 deletions(-)

diff --git a/common/messages.c b/common/messages.c
index 4ef7a34a..5e7f2dfa 100644
--- a/common/messages.c
+++ b/common/messages.c
@@ -52,40 +52,6 @@ void __btrfs_error(const char *fmt, ...)
 	fputc('\n', stderr);
 }
 
-__attribute__ ((format (printf, 2, 3)))
-int __btrfs_warning_on(int condition, const char *fmt, ...)
-{
-	va_list args;
-
-	if (!condition)
-		return 0;
-
-	fputs(PREFIX_WARNING, stderr);
-	va_start(args, fmt);
-	vfprintf(stderr, fmt, args);
-	va_end(args);
-	fputc('\n', stderr);
-
-	return 1;
-}
-
-__attribute__ ((format (printf, 2, 3)))
-int __btrfs_error_on(int condition, const char *fmt, ...)
-{
-	va_list args;
-
-	if (!condition)
-		return 0;
-
-	fputs(PREFIX_ERROR, stderr);
-	va_start(args, fmt);
-	vfprintf(stderr, fmt, args);
-	va_end(args);
-	fputc('\n', stderr);
-
-	return 1;
-}
-
 __attribute__ ((format (printf, 1, 2)))
 void internal_error(const char *fmt, ...)
 {
diff --git a/common/messages.h b/common/messages.h
index b512544f..6a105484 100644
--- a/common/messages.h
+++ b/common/messages.h
@@ -50,13 +50,11 @@
 
 #define error_on(cond, fmt, ...)					\
 	do {								\
-		if ((cond))						\
+		if ((cond)) {						\
 			PRINT_TRACE_ON_ERROR;				\
-		if ((cond))						\
 			PRINT_VERBOSE_ERROR;				\
-		__btrfs_error_on((cond), (fmt), ##__VA_ARGS__);		\
-		if ((cond))						\
-			DO_ABORT_ON_ERROR;				\
+			__btrfs_error((fmt), ##__VA_ARGS__);		\
+		}							\
 	} while (0)
 
 #define error_btrfs_util(err)						\
@@ -81,11 +79,11 @@
 
 #define warning_on(cond, fmt, ...)					\
 	do {								\
-		if ((cond))						\
+		if ((cond)) {						\
 			PRINT_TRACE_ON_ERROR;				\
-		if ((cond))						\
 			PRINT_VERBOSE_ERROR;				\
-		__btrfs_warning_on((cond), (fmt), ##__VA_ARGS__);	\
+			__btrfs_warning((fmt), ##__VA_ARGS__);		\
+		}							\
 	} while (0)
 
 __attribute__ ((format (printf, 1, 2)))
@@ -94,12 +92,6 @@ void __btrfs_warning(const char *fmt, ...);
 __attribute__ ((format (printf, 1, 2)))
 void __btrfs_error(const char *fmt, ...);
 
-__attribute__ ((format (printf, 2, 3)))
-int __btrfs_warning_on(int condition, const char *fmt, ...);
-
-__attribute__ ((format (printf, 2, 3)))
-int __btrfs_error_on(int condition, const char *fmt, ...);
-
 __attribute__ ((format (printf, 1, 2)))
 void internal_error(const char *fmt, ...);
 
-- 
2.39.1

