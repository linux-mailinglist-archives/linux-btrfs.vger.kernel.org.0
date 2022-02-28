Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598A04C6D57
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 14:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiB1NCE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 08:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiB1NCD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 08:02:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EFD58E66;
        Mon, 28 Feb 2022 05:01:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAA86612B8;
        Mon, 28 Feb 2022 13:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38939C36AE5;
        Mon, 28 Feb 2022 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646053284;
        bh=UiMZXTZJMibeG1EW/yB31l1nItCSfnX4i5UKaUmqYi4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aUSaKk/THutssyZeRam8Ln1InKtmbtGYGpY3YWvcJayXLqxXdTg953ErM2MJCtBtt
         uScw14Tbo5bg0ZHcC8cU7sgK10lL8TIQKSzKXfK2pkZyGxYCp1liVDXA1C4GiuJ7SO
         oKHEAWYavKs1p4i7M729QMm1NwF5516rRrjec/lz5dGWlP1/n5JNj3ETeEYxIsNPJb
         BRWAhjZu7qFxrmpdGKWHJpcfMZ8eeq5JB03Rgt3ARIfPBC1Fwk7KFtLPaICIK7TX3F
         4jMGPC4qPpWyyrTwafEVFhjGRcTqgwWsXE9jDdjsorkbn/AQNdVuR7OlQvIUmEXRhX
         usy66MwlSEfkA==
Received: by mail-wr1-f41.google.com with SMTP id j17so15397622wrc.0;
        Mon, 28 Feb 2022 05:01:24 -0800 (PST)
X-Gm-Message-State: AOAM530eAyIm90JlmkGx8bwrvgMf34umIC8VoJXGc5B3NoIaHR2FxUgX
        /4qVqutsL12UpOLFhDqD32drJAfesPkToibeVxo=
X-Google-Smtp-Source: ABdhPJwJZ+uje/xKx7oLYKDj2bjjjypvvR3EipOurSGA++FmSYe2fJ0pQQWQ1o2kkZufMewj6tiI/1i+DeR+CamQFLs=
X-Received: by 2002:a5d:63c2:0:b0:1ef:840e:e139 with SMTP id
 c2-20020a5d63c2000000b001ef840ee139mr8331744wrw.192.1646053282413; Mon, 28
 Feb 2022 05:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20220228103142.3301082-1-arnd@kernel.org> <87v8wz5frv.fsf@intel.com>
In-Reply-To: <87v8wz5frv.fsf@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 28 Feb 2022 14:01:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1YUR4BNu8Nrc5XW+sFjL7-hWTHh7kstV27wmj1aqc4vA@mail.gmail.com>
Message-ID: <CAK8P3a1YUR4BNu8Nrc5XW+sFjL7-hWTHh7kstV27wmj1aqc4vA@mail.gmail.com>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
To:     Jani Nikula <jani.nikula@linux.intel.com>
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

On Mon, Feb 28, 2022 at 1:36 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >
> > One minor issue that remains is an added gcc warning for shifts of
> > negative integers when building with -Werror, which happens with the
> > 'make W=1' option, as well as for three drivers in the kernel that always
> > enable -Werror, but it was only observed with the i915 driver so far.
> > To be on the safe side, add -Wno-shift-negative-value to any -Wextra
> > in a Makefile.
>
> Do you mean always enable -Wall and/or -Wextra instead of -Werror?
>
> We do use -Werror for our CI and development too, but it's hidden behind
> a config option that depends on COMPILE_TEST=n to avoid any problems
> with allmodconfig/allyesconfig.

What I meant here is that I'm adding -Wno-shift-negative-value to all
four places in the kernel that already use -Wextra.

> For the future, makes me wonder if we couldn't have a way for drivers to
> locally enable -Wall/-Wextra in a way that incorporates the exceptions
> from kbuild instead of having to duplicate them.

I have an older patch series that does this, but it also does a few other
things that I couldn't quite get right in the end with all combinations of
compiler versions and warning levels, so I did not submit that.

What this allows is to have per-directory statements like

KBUILD_WARN1=1
KBUILD_ERROR0=1

to force all the default warnings (-Wall etc) to be errors, while
making the W=1 type warnings (-Wextra etc) normal warnings.

> Anyway, for the i915 changes,
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>

Thanks,

       Arnd
