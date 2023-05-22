Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3033C70BDE9
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 14:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjEVMZt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 08:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjEVMZf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 08:25:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5132E6E
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af29b37bd7so34182811fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684758181; x=1687350181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cUJaXRMKrJZfSuo4O6oHzmU/rUOVfjL2sH+Txpo7XaI=;
        b=alXzzb2V8vmbFWjROTmWQUXQA/rCquA21gy8kDMqQN1ISRu4R5nnerb7sYZb6M5xsj
         TCxA4XIo/7ejgwENQENVbtSVC0aVuL+2Odc/Stx63GdRiCtECWJHS78Mr+bY81BJ4Mta
         reOLAVeLtngYe+cRN2d6qglyy1WXjAARhQHUwAuzJpzExUxWde5KRJqu7iJQ09H+GkF7
         Ecfabmweku5HeardZEMImRIPnmLGcD88dLOCzUQRr8/2an6a60JBIj5uLYKRpNqXWYW5
         rlvdYw47JtpEtlYmui20fJ22ewvKsWJxOAz/wva7lzhMvE3f6gt+lD+vjvTCbteRuEu+
         bs4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684758181; x=1687350181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUJaXRMKrJZfSuo4O6oHzmU/rUOVfjL2sH+Txpo7XaI=;
        b=mBjsaynhYpyjqDbv+F2HDWhCK4k0mtP9OQIiddLov06LfXwalK5Nqk9TNR8BdmNT5h
         oJpvXjSij+OQPVoQ/hysJ1uFODP+K3dtC5vMuDLRsWoKH92HNXZYNladCixnYUbI1XvY
         5/lf6mGVZUlAFIrwrdoP1cQEIGFfjdIX67CL02YHb5lf8RkgEFI/G6WCzXS5CE+LjLY+
         IFg1MSQtDQuVgj01X+S9NpPPhEC9vPE3eUWmLwVe7MMMsavs6suG65jVCpzNTu/L6E3m
         NtZI2wxSr3LVPk7myT1V16qN79z8lw5cmioYJYcwoLFQgxYYx5g7hYy8GvUDSvzv/tLX
         WNZA==
X-Gm-Message-State: AC+VfDwCmS4rpXWf8TFqIuH/B9HreRkaOwqcVoR/6flc8t4EJiFv6D4j
        Sp+6GkGcQk4obthKTW26wKIlikxVjSssRBeIJCE=
X-Google-Smtp-Source: ACHHUZ4c/EF4pEY/c1jvx/7JM/1UA+HULM+i+GCXQ4VVh8LOcI27LmwnjJiFxcGTV8jx2kKStYCvOA==
X-Received: by 2002:ac2:4c14:0:b0:4f0:81c:73eb with SMTP id t20-20020ac24c14000000b004f0081c73ebmr3500821lfq.42.1684758181304;
        Mon, 22 May 2023 05:23:01 -0700 (PDT)
Received: from rayden.urgonet (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id y9-20020ac24469000000b004efe8174586sm974633lfl.126.2023.05.22.05.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 05:23:00 -0700 (PDT)
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
Subject: [PATCH 0/8] Cleanup unaligned access macros
Date:   Mon, 22 May 2023 14:22:30 +0200
Message-Id: <20230522122238.4191762-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

There are two versions of get/set_unaligned, get_unaligned_be64,
put_unaligned_le64 etc in U-Boot causing confusion (and bugs).

In this patch-set, I'm trying to fix that with a single unified version of
the access macros to be used across all archs. This work is inspired by
similar changes in this Linux kernel by Arnd Bergman,
https://lore.kernel.org/lkml/20210514100106.3404011-1-arnd@kernel.org/

Thanks,
Jens

Jens Wiklander (8):
  arm: use asm-generic/unaligned.h
  sh: use asm-generic/unaligned.h
  mips: use asm-generic/unaligned.h
  m68k: use asm-generic/unaligned.h
  powerpc: use asm-generic/unaligned.h
  fs/btrfs: use asm/unaligned.h
  linux/unaligned: remove unused access_ok.h
  asm-generic: simplify unaligned.h

 arch/arm/include/asm/unaligned.h     | 21 +------
 arch/m68k/include/asm/unaligned.h    | 17 +-----
 arch/mips/include/asm/unaligned.h    | 23 +------
 arch/powerpc/include/asm/unaligned.h | 18 +-----
 arch/sh/include/asm/unaligned.h      | 22 +------
 fs/btrfs/crypto/hash.c               |  2 +-
 include/asm-generic/unaligned.h      | 89 +++++++++++++++++++++++-----
 include/linux/unaligned/access_ok.h  | 66 ---------------------
 8 files changed, 83 insertions(+), 175 deletions(-)
 delete mode 100644 include/linux/unaligned/access_ok.h

-- 
2.34.1

