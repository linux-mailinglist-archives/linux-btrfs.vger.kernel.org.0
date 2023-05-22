Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A9970BDEE
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjEVMZx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbjEVMZh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:25:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAC11722
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:30 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3b9e54338so2194101e87.0
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684758185; x=1687350185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBQsGdAhjjQtrzp+A7D4JOJ/F5C9lrwx8Cr88FFeedo=;
        b=B5hfoPVCbs+fGyuD7c/Az/QZbDhOGBZajdppQjZGe1J9Ec5sNrp+TxfGFNQTGtDJE3
         nGVnJ8uWgzHU4t8C0w74tJg+RfQMPFqKVXAq6tEEW0/4NqSbd4QXSMNzzsFcyCH3FIrs
         cRveOY0AhXCi1/+SZtqo6mRpdi2YMsG0RBZCwGmNw6VMJiwkgCMwJ4i1JrwIk9Hdma0I
         TdvkxxJgBftgEKsW9ZxFRCNRK4hPIy1oW/gGPOIt1GWH7pdETOU2R3rIRGJgCHfvg91f
         tNUwCCzgr1UdKoR33w9Et21ux0dKslj2eyb78/IOrz8l0pDUDBXE//sHv3S+Tmk8CGsx
         3ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758185; x=1687350185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBQsGdAhjjQtrzp+A7D4JOJ/F5C9lrwx8Cr88FFeedo=;
        b=gF+SspeVr+WHxqOvU/ANOeuiaOgAZqh+b43OvMNPz5XEjxQMkurG17rNIWXriDFWty
         eJz2WfGO+vPge13hPln7RvR8RJJf/HIBm9AWA3+Ut/s8Mf448rfgc/g0+JRf37Ct8mZ2
         BJkAw6UB5wnhki7k+Q3bI6ZjU0Q5Jj37mE8t6bm35VTIZhCyhm393QktxHj73RKxrdir
         hBeBcNUqaNYufTiRC3Tr+ZlQ9X0YbzIlB7rNxE7sw0uKbpbGaT6Zz/t2c3BEqYSOPOiX
         M4PoE6qLP3uW/tswrYexC06CMKm9Jb0IinHKQnr4u7feEgzgxrCkk3gxCeTw/7RUv+ZL
         yspg==
X-Gm-Message-State: AC+VfDwDvkXZ9tfUrRfN1NeTr+AHo31Kg/+kW115vUFDS3MxiBU/q9Jf
        CACkpcJ8o/kXyafh5vVfYsbnCw==
X-Google-Smtp-Source: ACHHUZ6h4606sIqJkCQPTzjkF4aKTV8L/fsdm2txu7CToQG4LG4MRzJSsHixS5eFgiBKFPbJ0el5Fg==
X-Received: by 2002:ac2:5e87:0:b0:4f3:bbe1:34e2 with SMTP id b7-20020ac25e87000000b004f3bbe134e2mr1361959lfq.2.1684758184975;
        Mon, 22 May 2023 05:23:04 -0700 (PDT)
Received: from rayden.urgonet (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24469000000b004efe8174586sm974633lfl.126.2023.05.22.05.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:23:04 -0700 (PDT)
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
Subject: [PATCH 4/8] m68k: use asm-generic/unaligned.h
Date:   Mon, 22 May 2023 14:22:34 +0200
Message-Id: <20230522122238.4191762-5-jens.wiklander@linaro.org>
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

M68k essentially duplicates the content of asm-generic/unaligned.h, with
an exception for non-Coldfire configurations. Coldfire configurations
are apparently able to do unaligned accesses. But in an attempt to clean
up and handle unaligned accesses in the same way we ignore that and use
the common asm-generic/unaligned.h directly instead.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/m68k/include/asm/unaligned.h | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/m68k/include/asm/unaligned.h b/arch/m68k/include/asm/unaligned.h
index 328aa0c316c9..7fb482abc383 100644
--- a/arch/m68k/include/asm/unaligned.h
+++ b/arch/m68k/include/asm/unaligned.h
@@ -1,15 +1,2 @@
-#ifndef _ASM_M68K_UNALIGNED_H
-#define _ASM_M68K_UNALIGNED_H
-
-#ifdef CONFIG_COLDFIRE
-#include <linux/unaligned/be_byteshift.h>
-#else
-#include <linux/unaligned/access_ok.h>
-#endif
-
-#include <linux/unaligned/generic.h>
-
-#define get_unaligned	__get_unaligned_be
-#define put_unaligned	__put_unaligned_be
-
-#endif /* _ASM_M68K_UNALIGNED_H */
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/unaligned.h>
-- 
2.34.1

