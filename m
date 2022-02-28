Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F4E4C6475
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 09:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiB1IMh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 03:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiB1IMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 03:12:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA7F692B9;
        Mon, 28 Feb 2022 00:11:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8239B80D85;
        Mon, 28 Feb 2022 08:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7019AC36AE5;
        Mon, 28 Feb 2022 08:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646035915;
        bh=zMDLEB8toWf2EIp4Gbj5PSCBFzWdzLn4mVbcpqFSMxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G5/HKt1YcKrybKD+1q8UgQW8r6UniPBg+HgJCRHDiawTCCJy2G9uMVmVMIrAH+MIY
         uUZuQAmqf+UgQqG4LSwOUKjuA8mlT2hPXWXAetE6/wffM3OsZ6cQuw+SmzDdC9fizY
         tnKAD3prEcX2CmRCAP5e0Sp4+MmIaoIy7bEgoECFMmrlcDv1M29iegogMcMJXx4EzC
         Ww6E2vE2Ei6Ccl+33CFLA3ixlnEAH6a8FHRWu+p6u8hOq0ib6UliPV2J7DZbNT/orL
         Z5vh8VINzIAjIFdahYuMGIJkpIkpdyHyDhOYN0mcWcjSY+6pRXFj43dgIYPqjgmCqP
         vBf0o1GuFv9eA==
Received: by mail-wm1-f48.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so5259530wmj.0;
        Mon, 28 Feb 2022 00:11:55 -0800 (PST)
X-Gm-Message-State: AOAM531vIwOqzB7n19giBDQ2Mka5Xl1OBa0v+8AFaIgUS11TY9Kc5faf
        ZgUtx62VXAQzxHr12XG1VP+JoKC13ooidjHVDj0=
X-Google-Smtp-Source: ABdhPJx0yttNosgz0Dhhih9aIMEkkBewvoulgcXNOZok4rXBWTX7Xo99SrIvGnmvPy9Xsi9me/xpLhkH8sj6MYMy+yQ=
X-Received: by 2002:a05:600c:4802:b0:381:3b27:89b7 with SMTP id
 i2-20020a05600c480200b003813b2789b7mr11349875wmo.173.1646035913752; Mon, 28
 Feb 2022 00:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20220227215408.3180023-1-arnd@kernel.org> <YhwT2Gw8vsQHPxAB@quad.stoffel.home>
In-Reply-To: <YhwT2Gw8vsQHPxAB@quad.stoffel.home>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 28 Feb 2022 09:11:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1A8Y3F93FzbWum9U=_Mc8zR9T5p=tTkQK90ARan41EbA@mail.gmail.com>
Message-ID: <CAK8P3a1A8Y3F93FzbWum9U=_Mc8zR9T5p=tTkQK90ARan41EbA@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: remove -std=gnu89 from compiler arguments
To:     john@quad.stoffel.home
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 28, 2022 at 1:14 AM John Stoffel <john@quad.stoffel.home> wrote:
>
> On Sun, Feb 27, 2022 at 10:52:43PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > During a patch discussion, Linus brought up the option of changing
> > the C standard version from gnu89 to gnu99, which allows using variable
> > declaration inside of a for() loop. While the C99, C11 and later standards
> > introduce many other features, most of these are already available in
> > gnu89 as GNU extensions as well.
> >
> > An earlier attempt to do this when gcc-5 started defaulting to
> > -std=gnu11 failed because at the time that caused warnings about
> > designated initializers with older compilers. Now that gcc-5.1 is the
> > minimum compiler version used for building kernels, that is no longer a
> > concern. Similarly, the behavior of 'inline' functions changes between
> > gnu89 and gnu89, but this was taken care of by defining 'inline' to
>
> Typo here?  Second one should be gnu99 right?


Fixed, thanks!

        Arnd
