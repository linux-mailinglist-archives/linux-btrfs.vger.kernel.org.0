Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107364C7B52
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 22:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiB1VEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 16:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiB1VEi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 16:04:38 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AB259A4E
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 13:03:58 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 29so19128440ljv.10
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 13:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiqNCFc6U32ONzTNhKfvxI6B2p9x39AVrXt2rLta2M8=;
        b=W1quCfVq9oQhkjVMSeWaW2Z55DxdyDGbetnmG15rPiQ3v4OpkSJBRZVXEMnaa2odqg
         QOxU/DybvDsA1JnfyM0Ii4qw3F6xR+UbY0dAPPGiPqs4IHrP1aOpkQPW6UBPfhHTs8Tm
         PR7CBwZgGDqGkw8bM51JgA90FDhHoPP/FDNizSDpxNc9PDO+WtRrOnLiA4YcU9jxsmrw
         z0maaOELQKiR1hC/GWCjcXmHCEwCPjiDrVGmn41QSQ89BJlDlTrXtLJTHpab0xmVnH4M
         sZrukyP266PjsJuciZ6D4hmibJchflD3xDwtX05kLpAsnblhXyGN7U6wiOr/bpk5iv1a
         EfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiqNCFc6U32ONzTNhKfvxI6B2p9x39AVrXt2rLta2M8=;
        b=OZbIQpJwL+4tC1spE2WWcfhRESc31ANjDClS7vKOBodH6LEaMZ6kIkcigt2KXjwTBF
         IK6f88fSI1ItfAgURryasWZtbVxIbGG/fBnPP3Fs8vVeYw4eK8P5T2E6Z2HC/JiMs63l
         e/Q/m5SgD6aaRLTOWI7QHfaFF5nrx93qvNGnvbqnyhlhXy0fH7GmeHTXDxkMrQ4koSUY
         tDf9V2jnb+tvHqXEFYM3I7ua3Gsgs6sm01sI1gkmXd1PSaXqdavhY0MqWdDRwCo4mU0C
         X9pX0jc8DZcPWDhczq1kOaivR4H9NXaLTrOyuPAQ5PH7+INfcsYwG6guirqxahj1Q0Oe
         UZ8w==
X-Gm-Message-State: AOAM532qjE0Y10M5BBrezS46sDQm/2OTS38/hViWwo45MY9IE857JbyA
        xTfA82QrNz5kjXJdsZj/EIjaEu9mtsrWRT2E/taHew==
X-Google-Smtp-Source: ABdhPJzGFFfCBCn90UYvglywOrc8nxTF2i5r3/1lhRKGwuSQ5VMkWLmIJa+L1faEtfi148WU9C5GVQ0oji3KdUudozI=
X-Received: by 2002:a2e:bf24:0:b0:246:801e:39d3 with SMTP id
 c36-20020a2ebf24000000b00246801e39d3mr8506477ljr.472.1646082236647; Mon, 28
 Feb 2022 13:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20220228103142.3301082-1-arnd@kernel.org>
In-Reply-To: <20220228103142.3301082-1-arnd@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Feb 2022 13:03:45 -0800
Message-ID: <CAKwvOdkLUx1td+qgUYy3w2ojtBG-mJTzpJg3BV8Xv56YHTxHCw@mail.gmail.com>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
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
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Feb 28, 2022 at 2:32 AM Arnd Bergmann <arnd@kernel.org> wrote:
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

More precisely, the semantics of "extern inline" functions changed
between ISO C90 and ISO C99.

That's the only concern I have, which I doubt is an issue. The kernel
is already covered by the function attribute as you note.

Just to have some measure:
$ git grep -rn "extern inline" | wc -l
116

Most of those are in arch/alpha/ which is curious; I wonder if those
were intentional.

(I do worry about Makefiles that completely reset KBUILD_CFLAGS
though; the function attributes still take precedence).

> gnu89 and gnu11, but this was taken care of by defining 'inline' to
> include __attribute__((gnu_inline)) in order to allow building with
> clang a while ago.
>
> One minor issue that remains is an added gcc warning for shifts of
> negative integers when building with -Werror, which happens with the
> 'make W=1' option, as well as for three drivers in the kernel that always
> enable -Werror, but it was only observed with the i915 driver so far.
> To be on the safe side, add -Wno-shift-negative-value to any -Wextra
> in a Makefile.
>
> Nathan Chancellor reported an additional -Wdeclaration-after-statement
> warning that appears in a system header on arm, this still needs a
> workaround.

Ack; I think we can just fix this in clang.

>
> The differences between gnu99, gnu11, gnu1x and gnu17 are fairly
> minimal and mainly impact warnings at the -Wpedantic level that the
> kernel never enables. Between these, gnu11 is the newest version
> that is supported by all supported compiler versions, though it is
> only the default on gcc-5, while all other supported versions of
> gcc or clang default to gnu1x/gnu17.

I agree. With the fixup to s/Werror/Wextra.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Link: https://lore.kernel.org/lkml/CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com/
> Link: https://github.com/ClangBuiltLinux/linux/issues/1603
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

-- 
Thanks,
~Nick Desaulniers
