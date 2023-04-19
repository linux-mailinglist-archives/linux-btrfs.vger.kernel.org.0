Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB966E8333
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjDSVOS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjDSVON (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:14:13 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F536A66
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:07 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id m16so993820qvx.9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681938846; x=1684530846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZPuTKMf29prda0AlpX7LFRIYMCQ9eqOXnvIkO1GWUI=;
        b=g6PhRLv43QNTVE/1mn+ib47qTnp/ZWpn7Xihy9sJDl2ua1uboNKT16HN3Yu4evvxfH
         hUa0ggep/JExU8FmiLnliaWy6poNkDKbh4h8JxLo+4hU7DiEbjfw/OtuhOjrA7Tx+fiu
         XVwG0ANJvT4T+x19aoPS24Oq4kyvduAvz8AmegPXvZZMjYVXsGBU81z+lRWMiFRiRx2u
         lfnAHSIICEasW/LFQGv0+oVEoW6aXzJH6JDV4uSUUqrM+yyarbzpQ5KyOTin/hDDGGau
         XdYb4qL81G1raRAAqwREoJGmK5v5QK2f+L+M9GYma4MqVzM8XFE98qukh8lLa4PVYly2
         ZymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681938846; x=1684530846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZPuTKMf29prda0AlpX7LFRIYMCQ9eqOXnvIkO1GWUI=;
        b=ErVxcLB0g8taz4dcNfIDc0Dn0N1Fvsm+WbL370sJfwsjpl+wGQSdk113WENjf+/o6P
         RiN14V6hHhdApAFemBvI02i/vbF4tUP1Gp8hze08SftdjcL9tCGIjEPHbIaShpwAY+sQ
         el0l1Dhn+Q4hkD9To9liSYVyCsQbapmrHx69FlzV7wTu8LvxdkOs2d+EXh3RbMoCtAxI
         l6TVHP5MvHd7suMFElzKhBFus4sjjryFFsyrMAt/wmnrqnRVEh3SRXeGc2unqB2OEzmB
         ZsUbHruoGb7+ZPBej4GezBrXfngfxHdtbG9fZwcjo2O+L4oB6613KtO7vnDekCmcD/an
         dNEA==
X-Gm-Message-State: AAQBX9fld1M/TZt0aBdheGp2jYgzpHZQBefjHa6fSgvT1yPzRs228ZP0
        7qB9Om4O0kGDmuloV0+WUfveU7LGTPE0wgrr2i6fQg==
X-Google-Smtp-Source: AKy350b44mqYcrjeW468KISOC+ECalofzIEfpFCVSIisOavfG/v95u+LvL6USRak7QSoEIh+zKPzUA==
X-Received: by 2002:a05:6214:c66:b0:5b8:6efe:77f4 with SMTP id t6-20020a0562140c6600b005b86efe77f4mr31973047qvj.46.1681938846456;
        Wed, 19 Apr 2023 14:14:06 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id l19-20020a0ce093000000b005eee5f1f30bsm327qvk.46.2023.04.19.14.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:14:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/11] btrfs-progs: move BTRFS_DISABLE_BACKTRACE check in print_trace
Date:   Wed, 19 Apr 2023 17:13:47 -0400
Message-Id: <ae1535f4741a70488bb30000dfe429fca624c536.1681938648.git.josef@toxicpanda.com>
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

Everybody who calls print_trace wraps it around this check, move the
check instead to print_trace and remove the check from all the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 common/messages.c    |  3 ---
 include/kerncompat.h | 10 +++-------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/common/messages.c b/common/messages.c
index 2d9d55c0..4ef7a34a 100644
--- a/common/messages.c
+++ b/common/messages.c
@@ -96,10 +96,7 @@ void internal_error(const char *fmt, ...)
 	vfprintf(stderr, fmt, vargs);
 	va_end(vargs);
 	fputc('\n', stderr);
-
-#ifndef BTRFS_DISABLE_BACKTRACE
 	print_trace();
-#endif
 }
 
 static bool should_print(int level)
diff --git a/include/kerncompat.h b/include/kerncompat.h
index 62b6a357..cb2a9400 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -94,17 +94,17 @@
 #define BUILD_ASSERT(x)
 #endif
 
-#ifndef BTRFS_DISABLE_BACKTRACE
-#define MAX_BACKTRACE	16
 static inline void print_trace(void)
 {
+#ifndef BTRFS_DISABLE_BACKTRACE
+#define MAX_BACKTRACE	16
 	void *array[MAX_BACKTRACE];
 	int size;
 
 	size = backtrace(array, MAX_BACKTRACE);
 	backtrace_symbols_fd(array, size, 2);
-}
 #endif
+}
 
 static inline void warning_trace(const char *assertion, const char *filename,
 			      const char *func, unsigned line, long val)
@@ -114,9 +114,7 @@ static inline void warning_trace(const char *assertion, const char *filename,
 	fprintf(stderr,
 		"%s:%u: %s: Warning: assertion `%s` failed, value %ld\n",
 		filename, line, func, assertion, val);
-#ifndef BTRFS_DISABLE_BACKTRACE
 	print_trace();
-#endif
 }
 
 static inline void bugon_trace(const char *assertion, const char *filename,
@@ -127,9 +125,7 @@ static inline void bugon_trace(const char *assertion, const char *filename,
 	fprintf(stderr,
 		"%s:%u: %s: BUG_ON `%s` triggered, value %ld\n",
 		filename, line, func, assertion, val);
-#ifndef BTRFS_DISABLE_BACKTRACE
 	print_trace();
-#endif
 	abort();
 	exit(1);
 }
-- 
2.39.1

