Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0266D70BDEB
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbjEVMZv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjEVMZh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:25:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976D310FF
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:29 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f00c33c3d6so7033614e87.2
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684758184; x=1687350184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkynZCUSnXptnuFw0RrqFS1rki/zRgAPQZ+NR3djBSE=;
        b=j9n6oHiT28ypjm7yeymv/pn49MlFnBO0IanLlw3hx8RQYzwx+GiFOst0CPJQwOXQ6a
         fRUzqTQSlJU9S5qpVOzpXAGhjUkJRBZCJ6RJOL83J1eUiYwPxaDDYIQ5tWLo3xxbwjpl
         ctycr/Af7TUy0PUu3MixSBf2noa3il39n8pcw/EhHbBjcCBUjwNVjAIoHH0sQwTdKVwH
         xcVDiJteFeuHC/4hXpXNhnj9At51QrQOw4a/VCXs/NrewMWoxE60SIJXcZLdBYJtzWQA
         jdhN55g3rEQRqOWiK1EgrI+A2t/gSwPJIF3y5LFvcCOYFu6JvDhA/fFisTj/7TJe1R9T
         KpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758184; x=1687350184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkynZCUSnXptnuFw0RrqFS1rki/zRgAPQZ+NR3djBSE=;
        b=fEjpLpY5ndjtxmNiHolnqq4asxIx8nhVgq1Np1jlrG4JgxDdTVhnEmNSVFF04wNRwm
         lmaZClrqHnKWxrC4bcfAzl7c1Tyh35/PWUmDX1I6UeuDFlWWX2QTqhtIP7CAgmSZgK+2
         XZF5hWBHXgGwXY9LBFe7hgbMxRRBCNXOrOmSy9w5OC/YK3o5KvfalhwP9EbkcdgkrnC/
         mg0k2CdoBRAn+B/zFmZqtJjsCiSlH+HCQgZh2C3PWWzZuDcmEFFoZehQfhJit5QvoPP2
         jaXI5dIRQbfUAuFO/V90JDVFvcX3RsdJa+pZbi1LT5jAWTWvHRFe3VDTBvPOlMGG+zLZ
         ko4w==
X-Gm-Message-State: AC+VfDxQ8hN86R0HhSh8RUUqE2BW87nt1g6/GKZ0qbRc66IjhnmBbr1G
        3XId+ozzDpqB1JoMsEDFlSMSyUPZnSHva0pNo10=
X-Google-Smtp-Source: ACHHUZ4r/5hzp40R2860qVVD2TeL+9dpxzKr4cQukxP7E2K64BFDcW01/6GHmbhisYb7fP0IKcYaHg==
X-Received: by 2002:ac2:4a85:0:b0:4f1:3eea:eaf9 with SMTP id l5-20020ac24a85000000b004f13eeaeaf9mr3519639lfp.24.1684758184110;
        Mon, 22 May 2023 05:23:04 -0700 (PDT)
Received: from rayden.urgonet (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24469000000b004efe8174586sm974633lfl.126.2023.05.22.05.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:23:03 -0700 (PDT)
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
Subject: [PATCH 3/8] mips: use asm-generic/unaligned.h
Date:   Mon, 22 May 2023 14:22:33 +0200
Message-Id: <20230522122238.4191762-4-jens.wiklander@linaro.org>
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

Mips essentially duplicates the content of asm-generic/unaligned.h, so use
that file directly instead.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/mips/include/asm/unaligned.h | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/mips/include/asm/unaligned.h b/arch/mips/include/asm/unaligned.h
index debb9cf7aba6..7fb482abc383 100644
--- a/arch/mips/include/asm/unaligned.h
+++ b/arch/mips/include/asm/unaligned.h
@@ -1,23 +1,2 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
- */
-#ifndef _ASM_MIPS_UNALIGNED_H
-#define _ASM_MIPS_UNALIGNED_H
-
-#include <linux/compiler.h>
-#if defined(__MIPSEB__)
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-#elif defined(__MIPSEL__)
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
-#else
-#error "MIPS, but neither __MIPSEB__, nor __MIPSEL__???"
-#endif
-
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* _ASM_MIPS_UNALIGNED_H */
+#include <asm-generic/unaligned.h>
-- 
2.34.1

