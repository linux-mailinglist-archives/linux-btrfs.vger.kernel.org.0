Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CAB4C8E1A
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 15:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiCAOqD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 09:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiCAOqA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 09:46:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B6A36E39;
        Tue,  1 Mar 2022 06:45:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2937461592;
        Tue,  1 Mar 2022 14:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BB8C340F8;
        Tue,  1 Mar 2022 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646145917;
        bh=o2NgCtFCCViEWWJZ/MxDt8WYruV+Na6/HFB90W3Ddms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lMdLBJopxDEHQ2byF9/34TX2fjEtkjCCJ8lMoLev24s9mqzvVl87yTCPxcZIksJKl
         iFb5iGRXli28GDe7sXTT7Boj+U8Eg0FFMeFAzJRsZ1VLyvH0x9p0acTDHkBbyBqsLK
         k5GCyDImzqYKb1WXjZEAobLz7CO7SuNCGUByyyVyMH8DuIEprdCTCknAO9lUxgt+yR
         pVRZR5DVF1IMygzEppyOSCmoUaVPFsRdchUQFKaFwxPaHHYfrB2RmfLexGkWWN0XqO
         H0GQE+Gf4s59y/zQ4Gbl1QvMsp5nw9rNyEsHwyGkuLG862yxhilFyASVQEUhhaxMMj
         5BMGXA7qPfjPw==
Received: by mail-wr1-f51.google.com with SMTP id n14so20854482wrq.7;
        Tue, 01 Mar 2022 06:45:17 -0800 (PST)
X-Gm-Message-State: AOAM531c9SV56jrV2wk0qYOBTJIq3FYqNpUdQfIUtt6fgDKWfMj+2pUZ
        pF+vqjAuh2A/z45t8mTEgJ/oF/lbl/fKtoccR9k=
X-Google-Smtp-Source: ABdhPJyPIqVYEILvQbfggjtl7CioQ8YL3W5DTBrAMuOdPQLuzbvqdbkn4EaLjO6EST24WGkIh2N7mmmwovoE5hxEokE=
X-Received: by 2002:a5d:63c2:0:b0:1ef:840e:e139 with SMTP id
 c2-20020a5d63c2000000b001ef840ee139mr12407945wrw.192.1646145915672; Tue, 01
 Mar 2022 06:45:15 -0800 (PST)
MIME-Version: 1.0
References: <20220228103142.3301082-1-arnd@kernel.org> <CANiq72=wmYeBcJvRbBgRj1q_cHjZBVjxStXSu-8Ogv5bJhCqpA@mail.gmail.com>
In-Reply-To: <CANiq72=wmYeBcJvRbBgRj1q_cHjZBVjxStXSu-8Ogv5bJhCqpA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 1 Mar 2022 15:44:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a160RneN60cA2apHVt1D6oiV2KprG=uJ2mJwVvrR3z4pg@mail.gmail.com>
Message-ID: <CAK8P3a160RneN60cA2apHVt1D6oiV2KprG=uJ2mJwVvrR3z4pg@mail.gmail.com>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        Linux Btrfs <linux-btrfs@vger.kernel.org>
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

On Tue, Mar 1, 2022 at 11:43 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Feb 28, 2022 at 11:32 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > -under ``-std=gnu89`` [gcc-c-dialect-options]_: the GNU dialect of ISO C90
> > -(including some C99 features). ``clang`` [clang]_ is also supported, see
> > +under ``-std=gnu11`` [gcc-c-dialect-options]_: the GNU dialect of ISO C11
> > +(including some C17 features). ``clang`` [clang]_ is also supported, see
>
> I think the "(including some C17)" bit would not make much sense
> anymore. There were no major changes in C17 and GCC implements
> `-std=c11` and `-std=c17` as basically the same thing according to the
> docs (and GNU extensions apply equally to both, I would assume).

Ok, changed now.

> When I wrote the "(including some C99 features)" I meant that GCC
> implemented some C99 features as extensions in C90 mode, and the
> kernel used some of those (e.g. the now gone VLAs).

I suppose it's still true for some c2x features (static_assert, fallthrough,
binary literals, ...), but it seems easier to just leave it out.

> With that changed, for `programming-language.rst`:
>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks.
