Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BABB4C7838
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 19:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240768AbiB1Snl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 13:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbiB1Snd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 13:43:33 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E89C34B9C
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 10:41:08 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u7so18646446ljk.13
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 10:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+acwbp8IAqy4EQhdzrRR6UrvnBSYJWdfAOCkLBEf6s=;
        b=LvJ51tK8OGXmUdrq1FTGfGhAU7kyWg6aDacet+/T6m1xcdm96SFLNin6cqkfGY+rbg
         A+4gdF9QL3th8X1CIPS6F2KrwGpjUcAkZFh2wMRAAEhyIS9gK5hzhXTjv7RRLGY5VhDN
         /ORnVKar4p0KNDioI7O/8vsyY3PJ0BwGF0c/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+acwbp8IAqy4EQhdzrRR6UrvnBSYJWdfAOCkLBEf6s=;
        b=naf+iDoIaZJMSQbjvlWrKs0Itv24fKxn8lVxWSwg/9MXZ7e8XAWQrg0aZqzfDjzir+
         HX2I/kiOIEx63kYRoVGmN58+ZBUvwwHwOSw19maCN4pwZTS8RBUnfa9YbBLnWnPWHiQd
         BuVAYzn3WG1KPj6Dznqz+pJmDA4JJY58g3ZSujvqivMbTXbj0z8GBKzfPUBOg19piygd
         Su4y6GLT2zgmOXhOzxGBsZnpmg+EEDNxIc7yrVuWbaDAtSHx35PH6rs3M9+KjF08P1Zf
         TCx0ETuN6uyqNkep9SFwkIiOjdubvX418thGqcl2ch+IzaA0mbMObmgWDHbF19ZHcDJa
         ed0Q==
X-Gm-Message-State: AOAM533YRtFbBNUeMeA6sEe3/OoF+365+HGGWeZKS0obit5HrKzEsZBc
        UVod8a+uRz9T2ymxLoTEuUQaI5XHpolo4Bmnv/c=
X-Google-Smtp-Source: ABdhPJwVleJfQRV5SRQpeWN0nC/4Z+SeokhqVD8AdjrMDzrIDlxHml/jwCL11SlLsO8j0M+YsKPgcA==
X-Received: by 2002:a2e:3c0b:0:b0:239:6106:8d28 with SMTP id j11-20020a2e3c0b000000b0023961068d28mr15983998lja.416.1646073666247;
        Mon, 28 Feb 2022 10:41:06 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id y22-20020a197516000000b0044315947eefsm1081814lfe.186.2022.02.28.10.41.05
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 10:41:05 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id p20so18745420ljo.0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 10:41:05 -0800 (PST)
X-Received: by 2002:ac2:4c8c:0:b0:445:6c26:3cff with SMTP id
 d12-20020ac24c8c000000b004456c263cffmr13670491lfl.435.1646073655129; Mon, 28
 Feb 2022 10:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20220228103142.3301082-1-arnd@kernel.org> <YhyxML05rjJ/57Vk@FVFF77S0Q05N>
 <CAK8P3a0CTmtUq+Uba2S3D7wjSstew2M+LfzZoOcKdKK9cfXO9A@mail.gmail.com>
In-Reply-To: <CAK8P3a0CTmtUq+Uba2S3D7wjSstew2M+LfzZoOcKdKK9cfXO9A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 10:40:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjU+DCbFG4nd3Wne-KbQ1n5=BHynv3xEmRYTaayBj-EfQ@mail.gmail.com>
Message-ID: <CAHk-=wjU+DCbFG4nd3Wne-KbQ1n5=BHynv3xEmRYTaayBj-EfQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Marco Elver <elver@google.com>
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

On Mon, Feb 28, 2022 at 3:37 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> I think the KBUILD_USERCFLAGS portion and the modpost.c fix for it
> make sense regardless of the -std=gnu11 change

I do think they make sense, but I want to note again that people doing
cross builds obviously use different tools for user builds than for
the kernel. In fact, even not cross-building, we've had situations
where the "kbuild" compiler is different from the host compiler,
because people have upgraded one but not the other (upgrading the
kernel build environment is actually much easier than upgrading the
host build environment, because you don't need all the random
libraries etc, and you can literally _just_ build your own gcc and
binutils)

And we have *not* necessarily required that the host tools match the
kernel tools.

So I could well imagine that there are people who build their kernels,
but their host build environment might be old enough that -std=gnu11
is problematic for that part.

And note how any change to  KBUILD_USERCFLAGS is reflected in KBUILD_HOSTCFLAGS.

So I would suggest that the KBUILD_USERCFLAGS part of the patch (and
the modpost.c change that goes with it) be done as a separate commit.
Because we might end up reverting that part.

Hmm?

           Linus
