Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7494C6E03
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 14:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbiB1NXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 08:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiB1NXn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 08:23:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E626121;
        Mon, 28 Feb 2022 05:23:04 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2BDED2113A;
        Mon, 28 Feb 2022 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646054583;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNvLdI+iZsXcVPiWs0ldraacfaGBUEaJwBk4ZA2v124=;
        b=rWm36XAZ+Llc9U2KXh2MPBcdn+RT/qlvq2rSEOELa7CXgyIbCnSv3eYuDAtuPoL2SvdM58
        lh4PAaind+isGMTnTBPbFB9f6c6VikkIJrmmVYoyhA4rLWPCvoPkmVAF3Xp5EU0w3AcUnQ
        A79o4qcmmjPCwQH/x+MN0LKM2sKO4Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646054583;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNvLdI+iZsXcVPiWs0ldraacfaGBUEaJwBk4ZA2v124=;
        b=NTy2NkO24rhwN3/jLw4GQXPDL/VZeLSdeIm58qi61G+/SIy2JEKcfSCmGpKt/FLfgZhQ7D
        CyLReitTHv7C/uAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 84B2CA3B85;
        Mon, 28 Feb 2022 13:23:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A0D17DA823; Mon, 28 Feb 2022 14:19:11 +0100 (CET)
Date:   Mon, 28 Feb 2022 14:19:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
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
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
Message-ID: <20220228131911.GH12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
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
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220228103142.3301082-1-arnd@kernel.org>
 <87v8wz5frv.fsf@intel.com>
 <CAK8P3a1YUR4BNu8Nrc5XW+sFjL7-hWTHh7kstV27wmj1aqc4vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1YUR4BNu8Nrc5XW+sFjL7-hWTHh7kstV27wmj1aqc4vA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 28, 2022 at 02:01:06PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 28, 2022 at 1:36 PM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > >
> > > One minor issue that remains is an added gcc warning for shifts of
> > > negative integers when building with -Werror, which happens with the
> > > 'make W=1' option, as well as for three drivers in the kernel that always
> > > enable -Werror, but it was only observed with the i915 driver so far.
> > > To be on the safe side, add -Wno-shift-negative-value to any -Wextra
> > > in a Makefile.
> >
> > Do you mean always enable -Wall and/or -Wextra instead of -Werror?
> >
> > We do use -Werror for our CI and development too, but it's hidden behind
> > a config option that depends on COMPILE_TEST=n to avoid any problems
> > with allmodconfig/allyesconfig.
> 
> What I meant here is that I'm adding -Wno-shift-negative-value to all
> four places in the kernel that already use -Wextra.
> 
> > For the future, makes me wonder if we couldn't have a way for drivers to
> > locally enable -Wall/-Wextra in a way that incorporates the exceptions
> > from kbuild instead of having to duplicate them.
> 
> I have an older patch series that does this, but it also does a few other
> things that I couldn't quite get right in the end with all combinations of
> compiler versions and warning levels, so I did not submit that.
> 
> What this allows is to have per-directory statements like
> 
> KBUILD_WARN1=1

We've added the individual warnings to the per-directory flags so it's a
bit more flexible than just enabling W=1. The idea is to add possibly
stricter warnings once we make sure it builds fine and does not
produce false reports. Extending W=1 in the same way would affect
everybody.
