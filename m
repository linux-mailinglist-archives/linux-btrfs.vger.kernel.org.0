Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B0D70CB31
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 May 2023 22:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbjEVUfM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 16:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjEVUep (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 16:34:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549D5B9
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 13:34:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30948709b3cso3527702f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 13:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684787679; x=1687379679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jAqJ/BJY8hiB8/bsM9KyerJ3ZpTjZIuvz5dOXoRZUnc=;
        b=jEEYng3vDdbmgv129vrLwtveDVSneLSOQHzV0s7ucNYmPag7u/m7L8LvC+9D0PS2ld
         BshM+TZKawD/+yESCli3cSi1gJek/L8Q/J2pmmI5FUUSnL2/5Nk2K4KjmnapQMqOEO/M
         9xuAxnvjo0mMG+drshHjEAuv3F+GO+TyacSUo8QfbdJ7Dv4rfV2gIP9F2/OcxCUJfF6W
         2iq2pnXxHc0Qmbdz+UwmGLWwH6qSpYdgof/xGnRv61PxAhy/l9aZfLMsaKpGexPFJhpI
         HWvSyBfAjqgzv0ImR3UOdEtomUL+2+9/7iYTu2nDaIhXP180oDZEQ9t7nDxRoaWXXreG
         PKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684787679; x=1687379679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAqJ/BJY8hiB8/bsM9KyerJ3ZpTjZIuvz5dOXoRZUnc=;
        b=ZnYmfuFEj/Bx/3SCGt0OuvYU86brTtKXZGsOLYhZiIXtybXdszBqbV67nXG16NNKpp
         ULHA8hpmMZSWsNnGgLThfxBgT24q5y2pLf+PtCaW3C5x915pRsvpRPu5+NYOLTjq6EAm
         hbod1SGtMtrxUte+B6BnD9oHMe7Xb0PsR+oKBU/En/UoSRYRFz26opF5Zd20ZuMa2cqm
         yWUp2TFZUo4mH+8HakFMl3ZsBciaxrcnJFfT3dJKwdbbJoV6yU4ddP0AAOfsCoLbtU+e
         rVkedbcsDdFpP/M2+nezUBALgyayPLCD+15dE/SJcKgSURhOa6Wjoh+RypEWXiie0y1g
         xWYQ==
X-Gm-Message-State: AC+VfDyVj6vUHZa+yFD2vCA4Hc77rdgmyS2E+6eJHHXEfT6v7EglD7Bh
        yHMxixIgoAkQRBER/eW68aYilg==
X-Google-Smtp-Source: ACHHUZ4dyYkVut9SxmDE5ejGYoIwP7dQUC0jn6ygQUSwZoBj/9IfAKZAIjGIiUxSQVSLkf8Np+Hi0Q==
X-Received: by 2002:a5d:694e:0:b0:309:4227:6d1a with SMTP id r14-20020a5d694e000000b0030942276d1amr7248168wrw.70.1684787679572;
        Mon, 22 May 2023 13:34:39 -0700 (PDT)
Received: from hera (ppp176092130041.access.hol.gr. [176.92.130.41])
        by smtp.gmail.com with ESMTPSA id s4-20020a5d4244000000b00307bc4e39e5sm8685124wrr.117.2023.05.22.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 13:34:39 -0700 (PDT)
Date:   Mon, 22 May 2023 23:34:36 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     u-boot@lists.denx.de, linux-btrfs@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Huan Wang <alison.wang@nxp.com>,
        Angelo Dureghello <angelo@kernel-space.org>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Wolfgang Denk <wd@denx.de>, Marek Vasut <marex@denx.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Marek Behun <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>,
        Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/8] Cleanup unaligned access macros
Message-ID: <ZGvR3LoSN20QNrNM@hera>
References: <20230522122238.4191762-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522122238.4191762-1-jens.wiklander@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Jens

On Mon, May 22, 2023 at 02:22:30PM +0200, Jens Wiklander wrote:
> Hi,
>
> There are two versions of get/set_unaligned, get_unaligned_be64,
> put_unaligned_le64 etc in U-Boot causing confusion (and bugs).
>
> In this patch-set, I'm trying to fix that with a single unified version of
> the access macros to be used across all archs. This work is inspired by
> similar changes in this Linux kernel by Arnd Bergman,
> https://lore.kernel.org/lkml/20210514100106.3404011-1-arnd@kernel.org/
>
> Thanks,
> Jens

Thanks for the cleanup.

For the series
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Although I'd like to hear from arch maintainers as well.

Tom, This did pass all the CI successfully, but regardless I think it
should be pulled into -next.  If you want me to pick it up via the TPM tree
please let me know.

Thanks
/Ilias
>
> Jens Wiklander (8):
>   arm: use asm-generic/unaligned.h
>   sh: use asm-generic/unaligned.h
>   mips: use asm-generic/unaligned.h
>   m68k: use asm-generic/unaligned.h
>   powerpc: use asm-generic/unaligned.h
>   fs/btrfs: use asm/unaligned.h
>   linux/unaligned: remove unused access_ok.h
>   asm-generic: simplify unaligned.h
>
>  arch/arm/include/asm/unaligned.h     | 21 +------
>  arch/m68k/include/asm/unaligned.h    | 17 +-----
>  arch/mips/include/asm/unaligned.h    | 23 +------
>  arch/powerpc/include/asm/unaligned.h | 18 +-----
>  arch/sh/include/asm/unaligned.h      | 22 +------
>  fs/btrfs/crypto/hash.c               |  2 +-
>  include/asm-generic/unaligned.h      | 89 +++++++++++++++++++++++-----
>  include/linux/unaligned/access_ok.h  | 66 ---------------------
>  8 files changed, 83 insertions(+), 175 deletions(-)
>  delete mode 100644 include/linux/unaligned/access_ok.h
>
> --
> 2.34.1
>
