Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED94C7202
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 17:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238057AbiB1Q5C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 11:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbiB1Q5B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 11:57:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF2D79C75;
        Mon, 28 Feb 2022 08:56:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71B42612CB;
        Mon, 28 Feb 2022 16:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46A1C340E7;
        Mon, 28 Feb 2022 16:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646067380;
        bh=523gBdVPJChXozDXmy5Cb2pK2i/xRfAcGRZVUQAHjNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgVJuH4da0tpuW1nX+TSzWKpqT1/5OI3uq9Url+IKydIaNvJrwxxCJ02pDsUamp0J
         BXgyENWeP0ucoramTVXNaT23Z6w+IPOpRsVnisqnZwdBL4ARuBusSY6JLdz3305OfE
         YtZvql2BfkwdTq2LxRIJRizjGmx3hngX5RBUDcSxgf2mLkssqkaZFIqarTisHboNdy
         Xy986yF0zeYZbw6HX61O+ecCg/MIlsoP4bKonolKYJ+91DSdYuEy6Ckl7v583fSXhJ
         fxInQ5iK44jGAKr2Pvl9ywk4psfT+Vv0H/AbdegLc3kV5x8iLrYBvahTmACsIjfZ5u
         Ol9BFIfpBb+FA==
Date:   Mon, 28 Feb 2022 09:56:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
Message-ID: <Yhz+rfcdp9jxgr+P@archlinux-ax161>
References: <20220228103142.3301082-1-arnd@kernel.org>
 <CANpmjNP6VE9G8Yng4W7Mayk-0QsqUtAXkrMUSvL5pAP5DpXSmA@mail.gmail.com>
 <CAK8P3a3cRa1piP2BSmN2dTW4QErhSP7AMO9xqAm=_FFYprAkOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3cRa1piP2BSmN2dTW4QErhSP7AMO9xqAm=_FFYprAkOA@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 28, 2022 at 12:57:55PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 28, 2022 at 12:47 PM Marco Elver <elver@google.com> wrote:
> > On Mon, 28 Feb 2022 at 11:32, Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > > Nathan Chancellor reported an additional -Wdeclaration-after-statement
> > > warning that appears in a system header on arm, this still needs a
> > > workaround.
> >
> > On the topic of Wdeclaration-after-statement, Clang only respects this
> > warning with C99 and later starting with Clang 14:
> > https://github.com/llvm/llvm-project/commit/c65186c89f35#diff-ec770381d76c859f5f572db789175fe44410a72608f58ad5dbb14335ba56eb97R61
> >
> > Until Clang 14, -Wdeclaration-after-statement is ignored by Clang in
> > newer standards. If this is a big problem, we can probably convince
> > the Clang stable folks to backport the fixes. However, the build won't
> > fail, folks might just miss the warning if they don't also test with
> > GCC.

Unfortunately, none of the branches prior to release/14.x are going to
see any more updates (at least as far as I am aware, as the LLVM
community only supports one release branch at a time) but as Arnd
mentioned below, I do not really see that as a problem, as newer
versions of clang and GCC will catch these warnings.

> I don't expect this is to be a big issue, as long as the latest clang behaves
> as expected. There are many warnings that are only produced by one of the
> two compilers, so this is something we already deal with.
> 
> I think it's more important to address the extra warning that Nathan
> reported, where clang now complains about the intermingled declaration
> in a system header when previously neither gcc nor clang noticed this.

Right. Based on the upstream LLVM bug, I think we should just fix
arm_neon.h to avoid triggering -Wdeclaration-after-statement to have
something that is (hopefully) relatively low risk for a clang-14
backport, rather than addressing the root cause of clang warning in
system macros, as it sounds like fixing that has some risks that are not
fully understood at this point. The kernel only uses very specific
system headers after commit 04e85bbf71c9 ("isystem: delete global
-isystem compile option"), so I don't think that my suggested approach
will have many downsides.

I think I see how to potentially fix arm_neon.h in
clang/utils/TableGen/NeonEmitter.cpp, I just have to think about it a
little more.

Realistically, I don't think special casing this in lib/raid6 is the end
of the world:

diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index 45e17619422b..a41ff71b90af 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -38,6 +38,10 @@ ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
 NEON_FLAGS := -ffreestanding
 # Enable <arm_neon.h>
 NEON_FLAGS += -isystem $(shell $(CC) -print-file-name=include)
+# https://github.com/ClangBuiltLinux/linux/issues/1603
+ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_CPU_BIG_ENDIAN),yy)
+NEON_FLAGS += -Wno-declaration-after-statement
+endif
 ifeq ($(ARCH),arm)
 NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
 endif

> > > The differences between gnu99, gnu11, gnu1x and gnu17 are fairly
> > > minimal and mainly impact warnings at the -Wpedantic level that the
> > > kernel never enables. Between these, gnu11 is the newest version
> > > that is supported by all supported compiler versions, though it is
> > > only the default on gcc-5, while all other supported versions of
> > > gcc or clang default to gnu1x/gnu17.
> > >
> > > Link: https://lore.kernel.org/lkml/CAHk-=wiyCH7xeHcmiFJ-YgXUy2Jaj7pnkdKpcovt8fYbVFW3TA@mail.gmail.com/
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1603
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Cc: linux-kbuild@vger.kernel.org
> > > Cc: llvm@lists.linux.dev
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Acked-by: Marco Elver <elver@google.com>

Cheers,
Nathan
