Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF270BDEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjEVMZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjEVMZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:25:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46964173C
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:31 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f380cd1019so6857017e87.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684758186; x=1687350186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3st1/PAYQMvCElncbKXPE+lFmIJcFQFBwuXv80unt4=;
        b=n0zC7oRvoC8++nW2PXO3OgOjJ3Xmoo4wtrIL1cmxjBuVIK+Q0z4KWjCW1aAqDzT7cF
         aIuNCHSd2ZoYkShHE9W3r9r7+GSeyUsN+97jWEVz4CB1APTRYin3Pw3/LkNT/1OfMRAC
         52SkNugdtN3RTRFPQn3LIZxrO3PCQg9B3kXgzbfqj7WuHLa/Un38cYUtiGH7xNsiVEkY
         AkJhcW7v95Gui7FWD7e3iHbSpZBBtIwcsH3o4gIknEcXkBgLj9hfZFCJwBpKemX716kI
         KNLZGT/NFreXM2+ynakCAEKDsCh2tzQGjnd+siss4KFXP8wCSBa6bMDGG2K96k+kMSAO
         V6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758186; x=1687350186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3st1/PAYQMvCElncbKXPE+lFmIJcFQFBwuXv80unt4=;
        b=Up+iu9XOKq9jDiBMl7uUTNuSFnevqnTTrelk9lh7mSyq6qAyyRkHTebH8mTKkkuCAE
         GK9nKdbRSdo97VmbJZd0fyMNvnwckTA9rzJGFcRy3XtHRO4uaS+QBX1CCOaTgDrfiTfr
         /hWoq9uYBUMDGqoWVlYBqO/g0OQed0C22EgAUe5kwoLtk0OvI+P0kHaM7mmSKQ4HFlgv
         PKcjoDR1ZtjrZU6FfKNnq2lLnDf4iYWneTeoRQAxhr/9XhHY5EXJ2OinLWFolFc9r8LX
         /se4Y4IaczAr95zMIstB1zVuZ6+593ZlpDA9xFl1lg9wWnfm9Z+IfGfPJ09KLmT9mTSc
         NJtw==
X-Gm-Message-State: AC+VfDw+eoOAJa4JIZ+zSRdxA7KNSpWmQ/cqcATXSgbzA55cJB7+4vow
        2c4uQEBXTL46KTX/4KBXpfyQBtV/Kk1Uen6Q1kI=
X-Google-Smtp-Source: ACHHUZ6jbKvVV/iDts8KAcrrVsUl1aheesF2zeGMr0Wd48C3BfCC23VeXLLRSoBAWet5tPpeiGCP5A==
X-Received: by 2002:ac2:52aa:0:b0:4ef:d6e2:6530 with SMTP id r10-20020ac252aa000000b004efd6e26530mr3034459lfm.37.1684758185844;
        Mon, 22 May 2023 05:23:05 -0700 (PDT)
Received: from rayden.urgonet (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24469000000b004efe8174586sm974633lfl.126.2023.05.22.05.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:23:05 -0700 (PDT)
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
Subject: [PATCH 5/8] powerpc: use asm-generic/unaligned.h
Date:   Mon, 22 May 2023 14:22:35 +0200
Message-Id: <20230522122238.4191762-6-jens.wiklander@linaro.org>
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

Powerpc configurations are apparently able to do unaligned accesses. But
in an attempt to clean up and handle unaligned accesses in the same way
we ignore that and use the common asm-generic/unaligned.h directly
instead.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/powerpc/include/asm/unaligned.h | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/unaligned.h b/arch/powerpc/include/asm/unaligned.h
index 5f1b1e3c2137..7fb482abc383 100644
--- a/arch/powerpc/include/asm/unaligned.h
+++ b/arch/powerpc/include/asm/unaligned.h
@@ -1,16 +1,2 @@
-#ifndef _ASM_POWERPC_UNALIGNED_H
-#define _ASM_POWERPC_UNALIGNED_H
-
-#ifdef __KERNEL__
-
-/*
- * The PowerPC can do unaligned accesses itself in big endian mode.
- */
-#include <linux/unaligned/access_ok.h>
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
-#endif	/* __KERNEL__ */
-#endif	/* _ASM_POWERPC_UNALIGNED_H */
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/unaligned.h>
-- 
2.34.1

