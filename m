Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A518A4C8993
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 11:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbiCAKot (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Mar 2022 05:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiCAKoq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Mar 2022 05:44:46 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08968B6D2;
        Tue,  1 Mar 2022 02:44:05 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q8so17972978iod.2;
        Tue, 01 Mar 2022 02:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dohQLzfhr7wZu6SxVtIw3CHG42SObGN2SXyswtlVBsg=;
        b=WrUDonvN2fO25UTk5VNVhFhd8gruRaN5xzDoP4JD0Sakac0hlwGn0vLFs4yYd4XAFv
         uZKJIKn4j7cuELvqeeSDPXMNu2C1n0MsJpfl9rt1CcXMWz8ysAwYiWu0FU5ssFw8GnBu
         KImb7bl4uZxpEQ889GR2FwiQtAowT5cOncwrkuheaR+UErGWa6dJdP5knzUj9ZNji+C6
         SaCIGAmJwbqyXPo1H+nGW/xKoV4Sv5xxMQcmeQv2UvCQ1LPx9cytIPoPatO3xtpXO37Q
         QL3drAKRoTDr8u6LO2OfPrWDqwyTUyYOMOn4N3XOwbIN3FW3QG+ijjXJMFfWWnQ72HyS
         YuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dohQLzfhr7wZu6SxVtIw3CHG42SObGN2SXyswtlVBsg=;
        b=fWjcwHYaEZ8qElLi1dKVLNNEPPJlBkdYfAk9mLmtpjVniiaQknwJyHzxkiX1oEYBUR
         NXdoKB5jAMVa/3+5lrduGHA6Qy5ZQAMD5FsM+JRv5LQjvtX/pYcdFUB3dfEzd9bGfnhI
         ogtZSpBp/4sIp1G/GF9enXN2VCrlZIiF5D4E/k2eFhyiP0TiSVh0PNwcnpHRrJeg/Kt5
         vMIptiG7xI6OqKCd8pXxdpE4psbkP9lvKHI7wa8Ht8Dn7MecvofHFAxJqssltKXMnhNJ
         k1Q4aTpcKdBvpdnpoI5/xol71EZzd7AR1RjcDx3A7goskIR8wQ3BmufPe4xE/g2r9Ofr
         eSEw==
X-Gm-Message-State: AOAM530jyOQQEssfOEowONXnC/Cn7vxJZs1oKym0bhQjdFYYkKFntgrX
        8Qh8AxQ7MXVqO1hTswymG+W5hmw6AzhkGsdK8CA=
X-Google-Smtp-Source: ABdhPJw1aZ/CGkeAZM6RKVYVHBay0f9lMjJdsMqyLhdijbZf60uaKu7bggqdaHiabrS+XPZY5qiqhEF5Hass1iDJqZk=
X-Received: by 2002:a6b:661a:0:b0:640:dd42:58ff with SMTP id
 a26-20020a6b661a000000b00640dd4258ffmr18921633ioc.64.1646131444958; Tue, 01
 Mar 2022 02:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20220228103142.3301082-1-arnd@kernel.org>
In-Reply-To: <20220228103142.3301082-1-arnd@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 1 Mar 2022 11:43:53 +0100
Message-ID: <CANiq72=wmYeBcJvRbBgRj1q_cHjZBVjxStXSu-8Ogv5bJhCqpA@mail.gmail.com>
Subject: Re: [PATCH] [v2] Kbuild: move to -std=gnu11
To:     Arnd Bergmann <arnd@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 28, 2022 at 11:32 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> -under ``-std=gnu89`` [gcc-c-dialect-options]_: the GNU dialect of ISO C90
> -(including some C99 features). ``clang`` [clang]_ is also supported, see
> +under ``-std=gnu11`` [gcc-c-dialect-options]_: the GNU dialect of ISO C11
> +(including some C17 features). ``clang`` [clang]_ is also supported, see

I think the "(including some C17)" bit would not make much sense
anymore. There were no major changes in C17 and GCC implements
`-std=c11` and `-std=c17` as basically the same thing according to the
docs (and GNU extensions apply equally to both, I would assume).

When I wrote the "(including some C99 features)" I meant that GCC
implemented some C99 features as extensions in C90 mode, and the
kernel used some of those (e.g. the now gone VLAs).

With that changed, for `programming-language.rst`:

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
