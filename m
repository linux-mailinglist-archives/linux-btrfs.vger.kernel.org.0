Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CAE70BDE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjEVMZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbjEVMZf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:25:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F3710DD
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso729827e87.3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684758182; x=1687350182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNGtYZHP+K0ibUJVp062Om/gTc5vNRdHlING4IaIZzs=;
        b=fLHAUMJE8wSslvQMdWoVmJPTUxLmmJXq6lrPAOjCD7b7WdJBGdTqFAaNBI9jAZ0JnN
         1lML9Dvcdw8cfKAS5ZwZzear3U1/ExvV9Dq0uwg4AbG9X930/+8klNVewm2TS3f5RYM6
         YJlL0KdOgaD4sdtPBX3atS4uhxD3S9K4PapPDDlBqEeyuYE1Pbk/4NyOGXMj8JBJcEVp
         Q5XSkl2M8oLm3mNJGPUwGGTPLdm4PSGp91X0g1U1EPP3OKwOWXOEOvpAoXQXjs0dZrJQ
         Jn8VjriZB29nI6Dm9mlh/o25bKdLJjDC3s6DeR0Papit83bnIIoJQMUuKxaNVWOhA0f9
         Ct5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758182; x=1687350182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNGtYZHP+K0ibUJVp062Om/gTc5vNRdHlING4IaIZzs=;
        b=gkINNTPil/u/Mcq7/bxerSXyPe6XA6pzX7lP35RRbcQORApdVAcgEDmco0XTj6wrRf
         2ezrDTGadHhNJmpiTcYw7FqIyP/0XiIMFyw2OpLXLrm6NU1T96sh0Oy9pjqARF39mR/z
         lgvh/u1x9rWabYK2qbRV8QLEj9zsoU3VsVtgWnNkhJthytvLkX2z5+wRjDC3HTg/WsGh
         OTksrf9UF5HstVgbafpfIiLiekkVzWk+uW+e+ScJocfHQDvaok06omrEDUeM+S+4K4/u
         gj4NyV8gwQiUqS97YkxKrhfZFm91MH4vXdXw+uHyqUDX9JJTGt0dzkSHc5i64GEAC+JS
         IK8w==
X-Gm-Message-State: AC+VfDyF2wbbbO74Fog0iLxx2TEeRepgAftNQKBUsu9J/1FdmU7WxWzt
        wbpaM7vvSTDDz1IcbzXU5K3+vQ==
X-Google-Smtp-Source: ACHHUZ75C39ShNDSb5J/HnD7gSQQwUoKvdbJfUs/lt1VYFYSSAAnerCgHJ23litPwTEt4Ouev7iEfw==
X-Received: by 2002:a19:ad02:0:b0:4f1:866d:9b01 with SMTP id t2-20020a19ad02000000b004f1866d9b01mr3249814lfc.3.1684758182323;
        Mon, 22 May 2023 05:23:02 -0700 (PDT)
Received: from rayden.urgonet (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24469000000b004efe8174586sm974633lfl.126.2023.05.22.05.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:23:01 -0700 (PDT)
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
Subject: [PATCH 1/8] arm: use asm-generic/unaligned.h
Date:   Mon, 22 May 2023 14:22:31 +0200
Message-Id: <20230522122238.4191762-2-jens.wiklander@linaro.org>
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

Arm duplicates the content of asm-generic/unaligned.h, so use that file
directly instead.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/arm/include/asm/unaligned.h | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/unaligned.h b/arch/arm/include/asm/unaligned.h
index 0a228fb8eea8..7fb482abc383 100644
--- a/arch/arm/include/asm/unaligned.h
+++ b/arch/arm/include/asm/unaligned.h
@@ -1,19 +1,2 @@
-#ifndef _ASM_ARM_UNALIGNED_H
-#define _ASM_ARM_UNALIGNED_H
-
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-/*
- * Select endianness
- */
-#if __BYTE_ORDER == __LITTLE_ENDIAN
-#define get_unaligned	__get_unaligned_le
-#define put_unaligned	__put_unaligned_le
-#else
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-#endif
-
-#endif /* _ASM_ARM_UNALIGNED_H */
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/unaligned.h>
-- 
2.34.1

