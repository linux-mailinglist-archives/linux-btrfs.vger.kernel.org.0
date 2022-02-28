Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80A34C7244
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 18:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiB1RLm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 12:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiB1RLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 12:11:41 -0500
X-Greylist: delayed 226 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 09:11:02 PST
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E03C86E0C;
        Mon, 28 Feb 2022 09:11:01 -0800 (PST)
Received: from conssluserg-03.nifty.com ([10.126.8.82])by condef-09.nifty.com with ESMTP id 21SH49Do003109;
        Tue, 1 Mar 2022 02:04:09 +0900
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 21SH3bcT021027;
        Tue, 1 Mar 2022 02:03:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 21SH3bcT021027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646067818;
        bh=sryAZLDXD/t7zVmI+J82zVk8l2yloq/oD0nvYGiN984=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DFAl9D3d5SV7l8OlblFtkdudyppXM87TTXLJkKaFiDrnHYA5wFLCqpf/bi6XW+/lL
         Wxcxf4DRuPeQzgRVRD0ZLZqGJVyV92OkIiBQSKCRD0fkbmGaM77V1X8/io54DfJJE1
         WHjVeTmICFjHCNQFMP84l0KM6p9KeusZdxBvunEoZ/3O0KaCmfcm9xJcBOxDBliQLy
         v2hLNwthpmWXp3NyaQ3wZjDjgPQxfdr5sC/vbH+pTH2mOrDULVuZBpmLb5vfOGA989
         Xl28AGykKx2Snuz0kqy9XcABSVfqA/+0wAkzfvVhA8SShTSlLQBtapcr4hUau+8ujK
         GQtrmak7eUByg==
X-Nifty-SrcIP: [209.85.210.175]
Received: by mail-pf1-f175.google.com with SMTP id d17so11571637pfl.0;
        Mon, 28 Feb 2022 09:03:37 -0800 (PST)
X-Gm-Message-State: AOAM533Kduz81j7AsM7VC+DQ+9nUnmn6KGNAdT7DNcrqjsqOTNl+XNCZ
        gEKSzMo1exb75ZkpaPM186/945eCf/hAUmmpbiA=
X-Google-Smtp-Source: ABdhPJxISxDkNdxsVTKDDV2g7ZIxBL9oz/LlNlGrxEOGwup5cilO+xLo89K+cDWbGEDhDHUjyYzEiShtkCuCLkVGAaU=
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id
 bj2-20020a056a02018200b003745a57cbf9mr18072494pgb.616.1646067817034; Mon, 28
 Feb 2022 09:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20220228103142.3301082-1-arnd@kernel.org>
In-Reply-To: <20220228103142.3301082-1-arnd@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 1 Mar 2022 02:02:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVs-yRX4PnURkLv3fz3gAnuzG2GxZ2gdvmJX2g+0P-_w@mail.gmail.com>
Message-ID: <CAK7LNATVs-yRX4PnURkLv3fz3gAnuzG2GxZ2gdvmJX2g+0P-_w@mail.gmail.com>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 28, 2022 at 7:32 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> During a patch discussion, Linus brought up the option of changing
> the C standard version from gnu89 to gnu99, which allows using variable
> declaration inside of a for() loop. While the C99, C11 and later standards
> introduce many other features, most of these are already available in
> gnu89 as GNU extensions as well.
>
> An earlier attempt to do this when gcc-5 started defaulting to
> -std=gnu11 failed because at the time that caused warnings about
> designated initializers with older compilers. Now that gcc-5.1 is the
> minimum compiler version used for building kernels, that is no longer a
> concern. Similarly, the behavior of 'inline' functions changes between
> gnu89 and gnu11, but this was taken care of by defining 'inline' to
> include __attribute__((gnu_inline)) in order to allow building with
> clang a while ago.
>
> One minor issue that remains is an added gcc warning for shifts of
> negative integers when building with -Werror, which happens with the

Is this a typo?

   building with -Werror, ...
->
   building with -Wextra, ...




> 'make W=1' option, as well as for three drivers in the kernel that always
> enable -Werror, but it was only observed with the i915 driver so far.

Same here.

   enable -Werror, but ...
->
  enable -Wextra, but ...




Otherwise,

Acked-by: Masahiro Yamada <masahiroy@kernel.org>


Please let me know if you want me to pick up this.









--
Best Regards

Masahiro Yamada
