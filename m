Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C254C646F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 09:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiB1IMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 03:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiB1IMP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 03:12:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C4692B9;
        Mon, 28 Feb 2022 00:11:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B330DB80E58;
        Mon, 28 Feb 2022 08:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61635C340F1;
        Mon, 28 Feb 2022 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646035894;
        bh=DljB/ws5J9Owyl5yds3GZxgK+VN9CcGAOjBMjtsvHLY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lUHl1zVGtsG7blAH/F0UTToBcop4tD/U31a16Z8iFIbr3Yz3NZyMMruEmqnjff4ZV
         sOXR4ep1bZSZFP0thZxfJu86f2z6+1scEBxEdmX2MzzbIbTJIcJ58A29zDedh4boJZ
         xAOME5veJRutesYxFUwWk5sQ+QrLNYM/TVXnCtonVD/qOrj4pXJn2RS2GVaVmp52BQ
         5iwZQ45A8fmgwsj70jPmE+MF5yxYndWMbRpKn6LVhUyC6bqg4uPpX27ECqsMIMGs2u
         XUwEuPOV78DTReq/jMwlT/mX0z/iDJpT5zge+xiLD8/j5HMuuicA5nzcXCsD/SOF5J
         RTmRglaDYVWmw==
Received: by mail-wm1-f42.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so5460950wmp.5;
        Mon, 28 Feb 2022 00:11:34 -0800 (PST)
X-Gm-Message-State: AOAM5318uRMZ+6Bmb5GQS2dvPlhhsmRiLvvuJkrAHm1W+tsEqzYNxghQ
        wqMu5NpdjUPw3h8ZuoIowHfatgE+zy+oEqaJnsk=
X-Google-Smtp-Source: ABdhPJwcMEK5ybaUtjnn+nhdYBsBMcvPLAK49eN6lkpL2rzIto/bB9bCpNQVYXjU55YpRRxY6tLnPO6gmy6I0G+qdwc=
X-Received: by 2002:a05:600c:3b87:b0:381:428c:24c1 with SMTP id
 n7-20020a05600c3b8700b00381428c24c1mr8612916wms.1.1646035892684; Mon, 28 Feb
 2022 00:11:32 -0800 (PST)
MIME-Version: 1.0
References: <20220227215408.3180023-1-arnd@kernel.org> <dd41c574-05b0-23bc-646c-0bd341e6e50b@linaro.org>
In-Reply-To: <dd41c574-05b0-23bc-646c-0bd341e6e50b@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 28 Feb 2022 09:11:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a05aLS1sgQdeUDN6LD3oS0khZh07pyEO9LhUC5CJHN-Kg@mail.gmail.com>
Message-ID: <CAK8P3a05aLS1sgQdeUDN6LD3oS0khZh07pyEO9LhUC5CJHN-Kg@mail.gmail.com>
Subject: Re: [greybus-dev] [PATCH] Kbuild: remove -std=gnu89 from compiler arguments
To:     Alex Elder <elder@linaro.org>
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

On Mon, Feb 28, 2022 at 12:04 AM Alex Elder <elder@linaro.org> wrote:
> On 2/27/22 3:52 PM, Arnd Bergmann wrote: From: Arnd Bergmann <arnd@arndb.de>

> > I put the suggestion into patch form, based on what we discussed
> > in the thread.  I only gave it minimal testing, but it would
> > be good to have it in linux-next if we want to do this in the
> > merge window.
>
> Did you determine what needed the new compiler flag based on
> compilation results?
>
> Glancing at the Greybus code, I don't believe there's any
> reason it needs to shift a negative value.  Such warnings
> could be fixed by making certain variables unsigned, for
> example.
>
> I have no objection, I'll just make a note of it.

I've clarified in the changelog that I'm adding the -Wno-shift-negative-value
everywhere that -Wextra is used, not because I saw actual warnings
for greybus and btrfs. The -Wextra is copied from scripts/Makefile.extrawarn,
so this keeps it in sync. Ideally we should have an easier way for a
subdirectory to get the W=1 flags without copying the list, but the
patch I started to do this never got close to getting integrated.

         Arnd
