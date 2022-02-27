Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80594C5F80
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Feb 2022 23:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiB0WnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 17:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiB0WnI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 17:43:08 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3714BE3
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 14:42:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p15so21299463ejc.7
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 14:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8l4d/g0eKsVGAXwcSHou4m9texHyFwjSyXWV84L8X0=;
        b=aS+Cuu53E5xh6ezL4BQQcygkZ7taEG098ncxgu4s2QZu+Pf48uAsX8EMwnsNmZzs5O
         eo+kkcQwg/L9tnVyFaERl40XHOJRfEwQ+3p4bNjtTIEqFgNZTrhkUr5c7jHIQo0R2QlD
         6Z3HbL6vTEGo3aFlsNtdBL0CtUa6ZZQikH6w4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8l4d/g0eKsVGAXwcSHou4m9texHyFwjSyXWV84L8X0=;
        b=qQxr1XokfcsESdF6KjFsfJXzqEejj+KTwACq5JacFAOTdiF3ffWZrfHynNIri002yr
         HjQFbLa5HRFsJgWDGPT2fG3NZMA7BjM2grUHhGTq/bT+voGJWLyg/OlYZVFbT47dly7p
         Mi6PRDVul3i1Nvs3Fj0xkYDlGo3+wUPFFgwhesTkBTrGxY7XhwBpyHhN6vc9Hja9NNmu
         74JFW2Z99//8XKjLgsSoPaUgOheuNdQJ1o/KIn9qczM2qd41csGzu40ElzYzd48fAGKg
         XI6t+B8TEX8knPCuW2TMAPqevnUgmxVK5E3H0y8eUpP3WtyYw+LLnApx3xa3GEu2rUcq
         WiHA==
X-Gm-Message-State: AOAM531u6GFGWsVYmtsu2OrUBuag3RiiYz335QcyiYhEk+R5ugxSz5Pv
        43mbVu5r76kPYOSZs1PDaUXppaOXNIFBJyJG5lM=
X-Google-Smtp-Source: ABdhPJzNfaR3yOnWgkoLq2A1CPuKVvVymPrQnJpQnF9vyMiI1derEzb9J+y2awXlaP5Y6KdxB7pQjg==
X-Received: by 2002:a17:907:76fc:b0:6ce:a836:34a1 with SMTP id kg28-20020a17090776fc00b006cea83634a1mr13798234ejc.663.1646001748219;
        Sun, 27 Feb 2022 14:42:28 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id k7-20020a170906578700b006d59878f60csm3756142ejq.207.2022.02.27.14.42.27
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 14:42:28 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id s1so12656712wrg.10
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 14:42:27 -0800 (PST)
X-Received: by 2002:a2e:aaa2:0:b0:244:bf42:3e6e with SMTP id
 bj34-20020a2eaaa2000000b00244bf423e6emr12796324ljb.176.1646001378532; Sun, 27
 Feb 2022 14:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20220227215408.3180023-1-arnd@kernel.org>
In-Reply-To: <20220227215408.3180023-1-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Feb 2022 14:36:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com>
Message-ID: <CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com>
Subject: Re: [PATCH] Kbuild: remove -std=gnu89 from compiler arguments
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 27, 2022 at 1:54 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Since the differences between gnu99, gnu11 and gnu17 are fairly minimal
> and mainly impact warnings at the -Wpedantic level that the kernel
> never enables, the easiest way is to just leave out the -std=gnu89
> argument entirely, and rely on the compiler default language setting,
> which is gnu11 for gcc-5, and gnu1x/gnu17 for all other supported
> versions of gcc or clang.

Honestly, I'd rather keep the C version we support as some explicit
thing, instead of "whatever the installed compiler is".

Not only do I suspect that you can set it in gcc spec files (so the
standard version might actually be site-specific, not compiler version
specific), but particularly with clang, I'd like that "GNU extensions
enabled" to be explicit. Yes, maybe it's the default, but let's make
sure.

The C version level has traditionally had a lot of odd semantic
meaning details - you mention "inline", others have existed. So it's
not just the actual new features that some C version implements, it's
those kind of "same syntax, different meaning" issues. I really don't
think that's something we want in the kernel any more.

Been there, done that, and we did the explicit standards level for a reason.

It may be true that c99/c11/c17 are all very similar, and don't have
those issues. Or maybe they do.

And I don't want somebody with a newer compiler version to not notice
that he or she ended up using a c17 feature, just because _that_
compiler supported it, and then other people get build errors because
their compilers use gnu11 instead by default.

Put another way: I see absolutely no upside to allowing different
users using higher/lower versions of the standard. There are only
downsides.

If gnu11 is supported by gcc-5.1 and up, and all the relevant clang
versions, then let's just pick that.

And if there are any possible future advantages to gnu17 (or eventual
gnu2x versions), let's document those, so that we can say "once our
compiler version requirements go up sufficiently, we'll move to gnuXX
because we want to take advantage of YY".

Please?

                   Linus

                   Linus
