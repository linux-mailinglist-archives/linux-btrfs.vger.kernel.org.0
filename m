Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212544C8E27
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 15:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiCAOqx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 09:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiCAOqx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 09:46:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717CD3F881;
        Tue,  1 Mar 2022 06:46:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E10CB81986;
        Tue,  1 Mar 2022 14:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7958C36AEA;
        Tue,  1 Mar 2022 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646145969;
        bh=O7PMjYoyVgpMGjTVJdUqo4vjOgkMH6zVD28CMdfxejY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ScbK0J6pozv/c2GDJYHlIZpbvfONFwSIK/2j9QTvGy0h6OxUAoFSJS7ACLBifahWv
         DcEHKw3lZtb+uu9XBfWLbqlt4501Amp6VUN+Dzs96ZiZLJ0WrXZIhbPfc31qIWMyNy
         ATq4x+Oqa8aCq2GW5gs+Y/j2lbHCJQUV8G4qbfbhkoke2or1lVhj8owINILXGePjRZ
         R7WocAjuMhKmJQAgH9JZzvEWwPneWdjxvB9/qREXxhHUchmngRvsvQS8MYiNKoAhTS
         lRIGGo0c7PSqmvXlDIU+2nV4tRgWSUE8CyjB1CiW2iruBEJHgJWl3+5y31XDNWkEo7
         0CfBGfIlQclkw==
Received: by mail-wm1-f43.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso1542527wmr.1;
        Tue, 01 Mar 2022 06:46:09 -0800 (PST)
X-Gm-Message-State: AOAM530xrUzL/4VE+Tn7ZYIacTNeAK5iM4lcZlW2s+G7H+zS0MHPiRYY
        XiUrtu5nEsPeXAVZBO6Pc/z0sbbVgANUYI+pXWs=
X-Google-Smtp-Source: ABdhPJxXTbyRPUGWO5ZqEHYDoeKGRHcrrv5eZPJqecMQqdHX7hdx2ouYJfmaJG1ZffheKZ5NWAXaiF6wK5E6lkn8a4k=
X-Received: by 2002:a7b:c001:0:b0:381:1afd:5caa with SMTP id
 c1-20020a7bc001000000b003811afd5caamr17359158wmb.35.1646145967920; Tue, 01
 Mar 2022 06:46:07 -0800 (PST)
MIME-Version: 1.0
References: <20220228103142.3301082-1-arnd@kernel.org> <CAKwvOdkLUx1td+qgUYy3w2ojtBG-mJTzpJg3BV8Xv56YHTxHCw@mail.gmail.com>
 <20220228214145.o37bgp3zl3rxpeo4@google.com>
In-Reply-To: <20220228214145.o37bgp3zl3rxpeo4@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 1 Mar 2022 15:45:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2ZBOdEWTB1K9wA0v657VTZc-BC4LkDoQ0uw8Hw8FfSyg@mail.gmail.com>
Message-ID: <CAK8P3a2ZBOdEWTB1K9wA0v657VTZc-BC4LkDoQ0uw8Hw8FfSyg@mail.gmail.com>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
To:     Fangrui Song <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Michal Marek <michal.lkml@markovi.net>,
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

On Mon, Feb 28, 2022 at 10:41 PM Fangrui Song <maskray@google.com> wrote:
> >
> >More precisely, the semantics of "extern inline" functions changed
> >between ISO C90 and ISO C99.
>
> Perhaps a clearer explanation to readers is: "extern inline" and "inline" swap
> semantics with gnu_inline (-fgnu89-inline or __attribute__((__gnu_inline__))).
>
> >That's the only concern I have, which I doubt is an issue. The kernel
> >is already covered by the function attribute as you note.
> >
> >Just to have some measure:
> >$ git grep -rn "extern inline" | wc -l
> >116
>
> "^inline" behaves like C99+ "extern inline"
>
> Agree this is handled by
>
>      #define inline inline __gnu_inline __inline_maybe_unused notrace
>

Ok, I've reworded it again, but kept it a bit shorter, I don't think we
need the full explanation in this patch description in the end.

Thanks,

      Arnd
