Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8B770BDEA
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjEVMZu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbjEVMZh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:25:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E810E6
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:29 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso1925047e87.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684758183; x=1687350183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IyoCNdPUejBx0Nfm2fy7tQjrPviRbLySXuMppjkmh8=;
        b=gcgacHdAPcgEhgCGaZG7QK1H1+uKPTsNo0kUUb7TgKgRfAMt0O67jgYz3zwNpvaDJ8
         YLD6IU4Jqe5CtpinZUEHkWpKEw0q02EEKdJzDfGDYHoaKWLYLlAZ32OJwoTB/NRq0nQF
         nWuvHq0XN0XF0mI4GZd6FToZXD1nSzWLtskMoMjRa51hgqzNDHudxRY2Ky4Z7Ft8D4SX
         AtV5+C5q2VDQmIIKvP/AeijYjiPNTAB28wg8M/UPxmCQuLDEO1XoI2U/0O7VzF8xd16g
         qW1kxzGRwVPfjmjxKMc6bQIDxzpV0CtsntTHX7IcBEf7lKqT5poODgBoCRB7uGiRkIHx
         DApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758183; x=1687350183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IyoCNdPUejBx0Nfm2fy7tQjrPviRbLySXuMppjkmh8=;
        b=barnMncFD8m++0YzSndop4tRIYkQNYXF81se/odc36sYEhCJxuI3biiHpPaP2ThPGO
         WF52jP8uGdoOLmTVKUuVg9Tflgq0ocz8qz8kWYNiP55Ky6RPP41s0WZGl/qGbTtKps2C
         w9B42PoZW/BRy9lYRDb1irxMTzX4w+uJaw5lqZoGa6XGCSWz4ztag0VoYOHrIkbMxEe9
         XuIAr4uspxDihKowJRRyfGFr8aYDoVqvs6WwSzFXvZfxWtMQ6sJVqO+CTARUXPdwddfz
         KUIJMWfTKgWZfhcOgaA585Eo4JANBbE5Pb6vKzaF6cDcbve7//ahbFyalQsegN0T7dkF
         v0lQ==
X-Gm-Message-State: AC+VfDynewRl8eKpTA+7lJZ66SPlQ8nXjM91lT9/nphs9SVDkQ4TuP+L
        9QMRbjCfsqsKvXvckv+FT6Hl0w==
X-Google-Smtp-Source: ACHHUZ7GyrHaRLxZJn5CX+edppeQYtkDH6CWlWi/SgK14OWJ9VGKS0i2Zrq5Mv+0/A2rkwsEN2zsJg==
X-Received: by 2002:ac2:5636:0:b0:4f3:89ca:246d with SMTP id b22-20020ac25636000000b004f389ca246dmr3437740lff.41.1684758183253;
        Mon, 22 May 2023 05:23:03 -0700 (PDT)
Received: from rayden.urgonet (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24469000000b004efe8174586sm974633lfl.126.2023.05.22.05.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:23:02 -0700 (PDT)
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
Subject: [PATCH 2/8] sh: use asm-generic/unaligned.h
Date:   Mon, 22 May 2023 14:22:32 +0200
Message-Id: <20230522122238.4191762-3-jens.wiklander@linaro.org>
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

Sh essentially duplicates the content of asm-generic/unaligned.h, so use
that file directly instead.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 arch/sh/include/asm/unaligned.h | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/sh/include/asm/unaligned.h b/arch/sh/include/asm/unaligned.h
index 5acf0819620e..7fb482abc383 100644
--- a/arch/sh/include/asm/unaligned.h
+++ b/arch/sh/include/asm/unaligned.h
@@ -1,20 +1,2 @@
-#ifndef _ASM_SH_UNALIGNED_H
-#define _ASM_SH_UNALIGNED_H
-
-/* Copy from linux-kernel. */
-
-/* Other than SH4A, SH can't handle unaligned accesses. */
-#include <linux/compiler.h>
-#if defined(__BIG_ENDIAN__)
-#define get_unaligned   __get_unaligned_be
-#define put_unaligned   __put_unaligned_be
-#elif defined(__LITTLE_ENDIAN__)
-#define get_unaligned   __get_unaligned_le
-#define put_unaligned   __put_unaligned_le
-#endif
-
-#include <linux/unaligned/le_byteshift.h>
-#include <linux/unaligned/be_byteshift.h>
-#include <linux/unaligned/generic.h>
-
-#endif /* _ASM_SH_UNALIGNED_H */
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/unaligned.h>
-- 
2.34.1

