Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B676170BDF3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjEVM0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjEVMZj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:25:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4744C198A
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f122ff663eso6536707e87.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684758188; x=1687350188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2CVbqNckF43m3ty4BotwDE58WAGFSlKLdkpEY7V8JY=;
        b=XBsnnBEBxOg0EE/geZVsCvMl8WOUCesvlS7tMnpzZWExxFnoe+ZW6WN2RCeQmxVvkz
         9LWlh69ynmKgBH8EE7OJLPoVw4pVYzShp8Elf+012cyVZ6IQEW/VL2K2z0xP5KtBF2cJ
         dPO+dXKS9Zf/+aZ1vp1hyDZXAH/I3KSMCVESK47xN7SeMbyyS1LP/VCG2Zl1quqjirGO
         qzO6hVBzfaZHqLhLnLV138pTkh2ihcY8vQpDUekKFk5Po8RTJbFn+n2juSKTR8cpIOCr
         aOs6klcR+1eICyqloJTe2/3qglmfssFe2ZXo0vDpDaj9d+V375XdtgCV4F8DVplroVfb
         YjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758188; x=1687350188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2CVbqNckF43m3ty4BotwDE58WAGFSlKLdkpEY7V8JY=;
        b=UXA/xe+BMqW1zSC7fO+iB+HZchQnbYRmQw1MWZTNEpYD/d5Fz4OHXsoHjKkJ41E63C
         DdwZxCNfn4P9WVQvHuQsHkU+OQuxljPxX7MMx+/9rVFn2+KtxT8dGFLTRdLCUONJk+WM
         TMIDHCrVbYqTd3/uIuhhcmCROlMK5W/WTc00wAgb2btUqlJ1AftP98RjJAw1o/++fRvF
         XD+AUCk9RjPTW9Pfe3eITyU2Rmy5TEIeXBDpGkeVM+5m4uXalZ/wltHf/OuXX4rm/9l/
         vedivoUr/Wf6ZQS14ByqSnq2lCtgLtqOzlf4S0EyjIqYWWaohBAW7sCATcgJXDYzPpb8
         tYKA==
X-Gm-Message-State: AC+VfDxbcVpTsubZmFLzlfXKXoDgv6M0455xkQBkT4J97Q7cF+pUwhwP
        Hg+tvFOG45shs6/JqjmD62xZQg==
X-Google-Smtp-Source: ACHHUZ6vXBs+yoSqZqT3/15SvcvJIboKiRqZ7ovmbUF14Bbh1pV+ByRcEL2+X7pAVnLKAEYCWI0SCg==
X-Received: by 2002:ac2:44d4:0:b0:4f4:7a2:643b with SMTP id d20-20020ac244d4000000b004f407a2643bmr1062913lfm.14.1684758188390;
        Mon, 22 May 2023 05:23:08 -0700 (PDT)
Received: from rayden.urgonet (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24469000000b004efe8174586sm974633lfl.126.2023.05.22.05.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:23:08 -0700 (PDT)
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org
Cc:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Huan Wang <alison.wang@nxp.com>,
        Angelo Dureghello <angelo@kernel-space.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Wolfgang Denk <wd@denx.de>, Marek Vasut <marex@denx.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Marek Behun <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
        Tom Rini <trini@konsulko.com>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 8/8] asm-generic: simplify unaligned.h
Date:   Mon, 22 May 2023 14:22:38 +0200
Message-Id: <20230522122238.4191762-9-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522122238.4191762-1-jens.wiklander@linaro.org>
References: <20230522122238.4191762-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The get_unaligned()/put_unaligned() implementations are more
complex than necessary.

Move everything into one file and use a more compact implementation based
on packed struct access and byte swapping macros.

This patch is based on the Linux kernel commit 803f4e1eab7a
("asm-generic: simplify asm/unaligned.h") by Arnd Bergmann.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 include/asm-generic/unaligned.h | 89 +++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 16 deletions(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 3d33a5a063e8..9e5d93ec3041 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -1,24 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _GENERIC_UNALIGNED_H
 #define _GENERIC_UNALIGNED_H
 
 #include <asm/byteorder.h>
 
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-/*
- * Select endianness
- */
-#if defined(__LITTLE_ENDIAN)
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
-#elif defined(__BIG_ENDIAN)
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-#else
-#error invalid endian
-#endif
+#define __get_unaligned_t(type, ptr) ({						\
+	const struct { type x; } __packed * __pptr = (typeof(__pptr))(ptr);	\
+	__pptr->x;								\
+})
+
+#define __put_unaligned_t(type, val, ptr) do {					\
+	struct { type x; } __packed * __pptr = (typeof(__pptr))(ptr);		\
+	__pptr->x = (val);							\
+} while (0)
+
+#define get_unaligned(ptr)	__get_unaligned_t(typeof(*(ptr)), (ptr))
+#define put_unaligned(val, ptr) __put_unaligned_t(typeof(*(ptr)), (val), (ptr))
+
+static inline u16 get_unaligned_le16(const void *p)
+{
+	return le16_to_cpu(__get_unaligned_t(__le16, p));
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return le32_to_cpu(__get_unaligned_t(__le32, p));
+}
+
+static inline u64 get_unaligned_le64(const void *p)
+{
+	return le64_to_cpu(__get_unaligned_t(__le64, p));
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_t(__le16, cpu_to_le16(val), p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_t(__le32, cpu_to_le32(val), p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_t(__le64, cpu_to_le64(val), p);
+}
+
+static inline u16 get_unaligned_be16(const void *p)
+{
+	return be16_to_cpu(__get_unaligned_t(__be16, p));
+}
+
+static inline u32 get_unaligned_be32(const void *p)
+{
+	return be32_to_cpu(__get_unaligned_t(__be32, p));
+}
+
+static inline u64 get_unaligned_be64(const void *p)
+{
+	return be64_to_cpu(__get_unaligned_t(__be64, p));
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	__put_unaligned_t(__be16, cpu_to_be16(val), p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	__put_unaligned_t(__be32, cpu_to_be32(val), p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	__put_unaligned_t(__be64, cpu_to_be64(val), p);
+}
 
 /* Allow unaligned memory access */
 void allow_unaligned(void);
-- 
2.34.1

