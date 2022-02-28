Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BA84C7C41
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 22:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiB1Vmc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 16:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiB1Vmb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 16:42:31 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3648E14CC85
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 13:41:51 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y11so12256751pfa.6
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 13:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SDEQwyNhO1YP2PlPCVZv2QT+trnELH3tuuISdUJhH/A=;
        b=d9xMn/X4LpBqF7CCmU2zh6/QLyVNBTRuNZU+e7jV9ejFO0/bkIPnXV0yhaKjw6dJm8
         FJS3J2mi6lbO85oN/dNF+rqWxtAJUijNlNeALlXJL+eaCxB0tcq950US1kKVvr8mqukF
         e0ToSOH4Si3JfzpFzCogjXNl1DMde6d8MLn9SuHccOTRwzid1E81/cSQ/4tTUtiOrMCh
         9TojhlCRrVYJxHlgtGOmRoGhypN9RiWcKC8aFAkMrBK4RGw8XoilLoTMd70dGA9hdZYh
         n+kv4MVL49Db4WfNBmaeThQEFLAURei7cyQEoj8G+S/4PT3zkCcTFjR/aTe5mw8oJWud
         4tvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SDEQwyNhO1YP2PlPCVZv2QT+trnELH3tuuISdUJhH/A=;
        b=xvMm3Kx7QESObcYgbutGgUNtBQWBlUN27nVegfzZCK1rG6AQf+NMoHWfawre3SLPjS
         3ajzcBOAF5XJQqsjmf6a7jbFN2rP32Fy+WJUi1ARaMAFAheqcZOl4meOs7nsS3SCC+wz
         hNRQMcSLbEb5YXnqgJrOK+BV/SAC7Dhc6BOzza2IRhHmyYYsZs/qk83SkmlwnfcOAO5i
         KwIcM0hQ5C6H8x9b87pUJmOO22hVE4Wx6BCASp5iS0yF5KDO0s5mmXNr94Pcav7aNof8
         oBtoY7DOEVWeGaVN5OVJU86l48U4o7ZwrsSUbrw9PCnc4K94O8VEypzety9UfVk9QZBE
         PSjg==
X-Gm-Message-State: AOAM5337ifLaBDr3KKjzlfEhdlD2+1Cic2MYTZEH1lfCW9/yz9T/Bq4X
        oDY6cRj0+q8Au28XrYvK34V2F5eZHjXJ3Q==
X-Google-Smtp-Source: ABdhPJysQYIb7FAhRgqLT3HifNDIOw9MY3JP0SvCbCIF1CiA1nyX5JMrxTKRUKNjLMnj4tBxx48g9A==
X-Received: by 2002:a05:6a00:26e0:b0:4e1:7131:de2b with SMTP id p32-20020a056a0026e000b004e17131de2bmr23819114pfw.20.1646084510471;
        Mon, 28 Feb 2022 13:41:50 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:777f:ae46:e31e:b07e])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a0b9700b001b8f602eaeasm259006pjr.53.2022.02.28.13.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 13:41:50 -0800 (PST)
Date:   Mon, 28 Feb 2022 13:41:45 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kbuild@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
Message-ID: <20220228214145.o37bgp3zl3rxpeo4@google.com>
References: <20220228103142.3301082-1-arnd@kernel.org>
 <CAKwvOdkLUx1td+qgUYy3w2ojtBG-mJTzpJg3BV8Xv56YHTxHCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdkLUx1td+qgUYy3w2ojtBG-mJTzpJg3BV8Xv56YHTxHCw@mail.gmail.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for the patch!

(Was always wondering which of binutils and kernel would migrate to C99+
earlier... binutils won)

On 2022-02-28, Nick Desaulniers wrote:
>On Mon, Feb 28, 2022 at 2:32 AM Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> During a patch discussion, Linus brought up the option of changing
>> the C standard version from gnu89 to gnu99, which allows using variable
>> declaration inside of a for() loop. While the C99, C11 and later standards
>> introduce many other features, most of these are already available in
>> gnu89 as GNU extensions as well.
>>
>> An earlier attempt to do this when gcc-5 started defaulting to
>> -std=gnu11 failed because at the time that caused warnings about
>> designated initializers with older compilers. Now that gcc-5.1 is the
>> minimum compiler version used for building kernels, that is no longer a
>> concern. Similarly, the behavior of 'inline' functions changes between
>
>More precisely, the semantics of "extern inline" functions changed
>between ISO C90 and ISO C99.

Perhaps a clearer explanation to readers is: "extern inline" and "inline" swap
semantics with gnu_inline (-fgnu89-inline or __attribute__((__gnu_inline__))).

>That's the only concern I have, which I doubt is an issue. The kernel
>is already covered by the function attribute as you note.
>
>Just to have some measure:
>$ git grep -rn "extern inline" | wc -l
>116

"^inline" behaves like C99+ "extern inline"

Agree this is handled by

     #define inline inline __gnu_inline __inline_maybe_unused notrace

>Most of those are in arch/alpha/ which is curious; I wonder if those
>were intentional.
>
>(I do worry about Makefiles that completely reset KBUILD_CFLAGS
>though; the function attributes still take precedence).
>
>> gnu89 and gnu11, but this was taken care of by defining 'inline' to
>> include __attribute__((gnu_inline)) in order to allow building with
>> clang a while ago.
>>
>> One minor issue that remains is an added gcc warning for shifts of
>> negative integers when building with -Werror, which happens with the
>> 'make W=1' option, as well as for three drivers in the kernel that always
>> enable -Werror, but it was only observed with the i915 driver so far.
>> To be on the safe side, add -Wno-shift-negative-value to any -Wextra
>> in a Makefile.
>>
>> Nathan Chancellor reported an additional -Wdeclaration-after-statement
>> warning that appears in a system header on arm, this still needs a
>> workaround.
>
>Ack; I think we can just fix this in clang.
>
>>
>> The differences between gnu99, gnu11, gnu1x and gnu17 are fairly
>> minimal and mainly impact warnings at the -Wpedantic level that the
>> kernel never enables. Between these, gnu11 is the newest version
>> that is supported by all supported compiler versions, though it is
>> only the default on gcc-5, while all other supported versions of
>> gcc or clang default to gnu1x/gnu17.
>
>I agree. With the fixup to s/Werror/Wextra.
>
>Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>>
>> Link: https://lore.kernel.org/lkml/CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com/
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1603
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: linux-kbuild@vger.kernel.org
>> Cc: llvm@lists.linux.dev
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>-- 
>Thanks,
>~Nick Desaulniers
>
