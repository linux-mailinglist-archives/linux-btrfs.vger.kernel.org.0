Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9424F4C6ABE
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 12:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbiB1Lif (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 06:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbiB1Lie (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 06:38:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7EC4D248;
        Mon, 28 Feb 2022 03:37:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E1F60FFD;
        Mon, 28 Feb 2022 11:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1022C340F9;
        Mon, 28 Feb 2022 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646048274;
        bh=NMuZjdNCVeQj2VoQ5jMSwA/dHUHPZ7Mhms+WmvHKcaw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=puCfv4I80mTbhnHyUqTc9LSw3FPxPIOJ/vkuheGKL8juHQ+7OafzFbeIoOUiNrCzk
         gMcRYr5uV1QgmlA2AVn6fH3BtT9wmOgIs9iNnH1so1jgptzNGXyJSNUNB+mD3GKWqs
         E2XJQclA3FD72633y5W3VT8t4EU62kfI9ObJFzphTP1SAs7YsrIBe3/G3kytn/9qqP
         5AHT3io7WPI82HCHJY9xunwb0bTqn6d4f/32za5KRCjqEkKdRHTt21XpXMpLeN/tBN
         BbNvU8hEz/6Lp8OapNZxReFBxhZ7uLVFNvhFYK1wsIb1vZ8/L7F83N5gNIw77oSuFB
         0hR/PLkKQ9mRw==
Received: by mail-wr1-f42.google.com with SMTP id d28so14969944wra.4;
        Mon, 28 Feb 2022 03:37:54 -0800 (PST)
X-Gm-Message-State: AOAM533Mxj/AvQK941Qxx8qVLAjzq+Fwfh9hu8qiBRl3rTp5bMyPbkPj
        XZiTdAerH/NqciSV4pnlrpu5IcLcPEjke33fM4Y=
X-Google-Smtp-Source: ABdhPJxtXB6efD/LJ+kcWSKRCDN7bVXv1mCQCSSOtPPswSnZe/jnGK76a+5LOiLNukj3ERUK1wRtMZW5JaW1kqm9z5k=
X-Received: by 2002:a05:6000:1866:b0:1ef:8a14:ab6a with SMTP id
 d6-20020a056000186600b001ef8a14ab6amr7567987wri.12.1646048273093; Mon, 28 Feb
 2022 03:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20220228103142.3301082-1-arnd@kernel.org> <YhyxML05rjJ/57Vk@FVFF77S0Q05N>
In-Reply-To: <YhyxML05rjJ/57Vk@FVFF77S0Q05N>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 28 Feb 2022 12:37:37 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0CTmtUq+Uba2S3D7wjSstew2M+LfzZoOcKdKK9cfXO9A@mail.gmail.com>
Message-ID: <CAK8P3a0CTmtUq+Uba2S3D7wjSstew2M+LfzZoOcKdKK9cfXO9A@mail.gmail.com>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
To:     Mark Rutland <mark.rutland@arm.com>
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
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Marco Elver <elver@google.com>
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

On Mon, Feb 28, 2022 at 12:25 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Feb 28, 2022 at 11:27:43AM +0100, Arnd Bergmann wrote:
> >
> > Nathan Chancellor reported an additional -Wdeclaration-after-statement
> > warning that appears in a system header on arm, this still needs a
> > workaround.
>
> FWIW, I had a go at moving to c99 a few weeks ago (to be able to use
> for-loop-declarations in some concurrency primitives), and when I tried, I also
> saw declaration-after-statement warnings when building modpost.c, which is easy
> enough to fix:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=treewide/gnu99&id=505775bd6fd0bc1883f3271f826963066bbdc194

I think the KBUILD_USERCFLAGS portion and the modpost.c fix for it
make sense regardless of the -std=gnu11 change, but your change
to KBUILD_CFLAGS is not actually needed because the warning is
already enabled there -- gnu89 allows intermingled declarations since
gcc-3.4, so the warning flag was added during early 2.6.x kernels.

       Arnd
