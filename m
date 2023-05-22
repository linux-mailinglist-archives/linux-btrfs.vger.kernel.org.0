Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC870BDF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjEVMZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjEVMZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:25:38 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9052E75
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f3b337e842so3032477e87.3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684758186; x=1687350186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTm7XVsRWqH2HCRI9krBqQuQdUq136YutGjJEaeI4i4=;
        b=oo2r05pILUiyxbRcxUbCt9aBSDf1oiLbuhSnqbi8bta6GtmQvsQNB2m36/aadk7QH5
         CEWm9hsCMLUwzQphqoMNVjDWW4uIwO5G6vCQjjBppoYB9wn4I7JBgKNh6sMDF5l3MnFJ
         jN4xCWZfYg77rjiOQSIfqNhgUIJ/WmbcHHAvnhXhKcjk6cHd5n3b4sccpLnVhOqXDWMl
         Gh00o3Au4aD1j6zeOUl39AcZsKV5+qX/UcWFB82CAYqvgXXoHkNkOFbhOPyiKzV/p+P8
         ldEDPO5qaGFB3Mmu+Nsr9x0F67r29Yyvmkz9hXZPqzuCi4M/CN6tE5uJPMvaxVNbYlzz
         kX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758186; x=1687350186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTm7XVsRWqH2HCRI9krBqQuQdUq136YutGjJEaeI4i4=;
        b=lb78lQ/ee7rmnht1DVcTfPezj8vKmMhwhuHWZEqzdtCeWXuYW3m1XZoUimHKU/vPy7
         473pI2KZPuUBAcs14ZD3rWtv5Wcb6VpyvnJACInt4ug/z1yk6sK0eiG/gUbT4VDwdRLb
         4sL07UpZjOxOJsn1x6PfolNUcrGhXdioGIiTZTltpykxHDERgN4bCeI9dGzEotv52dG6
         6eaDMf01BeQzN+7QbVOU+H/cmGBwI5nD2yEkTdf+I4aQxHj+W52hbhBW3/ecVFvtk6em
         eLayujRGxF9pHtj939dCI4To6vQuvzSwPXHf3quSMF4cBOrTckufZoTSYEfweSwOtXnp
         +tSw==
X-Gm-Message-State: AC+VfDyQysWNhKzxxal59OoIcl0ZlcI0udAJQh/90e81lXpV/REnhnkn
        kr5nhqAJ4fyFR4jC9pJ2paCnLQ==
X-Google-Smtp-Source: ACHHUZ4dVNPnsFfz2BAESY6r6aoue5MyxLHfnCqJPzPkGF4N1x/4qmQEIekavTbLLlLcNFSk6ACLlw==
X-Received: by 2002:ac2:5991:0:b0:4f3:aa1e:8fd with SMTP id w17-20020ac25991000000b004f3aa1e08fdmr3342122lfn.68.1684758186734;
        Mon, 22 May 2023 05:23:06 -0700 (PDT)
Received: from rayden.urgonet (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24469000000b004efe8174586sm974633lfl.126.2023.05.22.05.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:23:06 -0700 (PDT)
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
Subject: [PATCH 6/8] fs/btrfs: use asm/unaligned.h
Date:   Mon, 22 May 2023 14:22:36 +0200
Message-Id: <20230522122238.4191762-7-jens.wiklander@linaro.org>
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

Use asm/unaligned.h instead of linux/unaligned/access_ok.h for unaligned
access. This is needed on architectures that doesn't handle unaligned
accesses directly.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 fs/btrfs/crypto/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/crypto/hash.c b/fs/btrfs/crypto/hash.c
index 891a2974be05..0a0b35fe9b96 100644
--- a/fs/btrfs/crypto/hash.c
+++ b/fs/btrfs/crypto/hash.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
+#include <asm/unaligned.h>
 #include <linux/xxhash.h>
-#include <linux/unaligned/access_ok.h>
 #include <linux/types.h>
 #include <u-boot/sha256.h>
 #include <u-boot/blake2.h>
-- 
2.34.1

