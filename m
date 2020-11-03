Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A572F2A4097
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 10:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgKCJrg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 04:47:36 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39353 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgKCJrg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 04:47:36 -0500
Received: by mail-ot1-f67.google.com with SMTP id z16so10223779otq.6;
        Tue, 03 Nov 2020 01:47:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cba+VQPJ3bKB8guN4yxCTN7pQm5OxFW1OgZpRjUzQYk=;
        b=U2Co7yJH5U6+P7YtEJtw/vWjv3DCvqTbcgB6IEcUL0ZfAHtAfxkOSjNyY1L8XJEVno
         x6Mcj9mfLvlesGWyjPwkF4Se5i4EVmmHp/Noapb2+8iGvMGGO5JuGeK0Rg1D7kIiO5SU
         HCB7ETl7Tt82Pg1EC5k+fVc/MZR1nrBxPdw8kpdGhIxsAUCrfVO+wP9yZIxa6y2S3KBA
         Q/IRQpb+e7R7i6E7uKnWuxziHo8HeVenAZTHUMfcO50zbtZSHemdOSRKmeR10RXCWwiA
         EHdEcSdoXnsrBNP9cLQR6tUAZM9Z6nIgccvdKkfIou+X91TpPIRbC+i7i0eFszPX7mPI
         7ZXQ==
X-Gm-Message-State: AOAM5313CHYqMakpFYE/bxHl3E1/RoSC3rdon+hdGuUWVHBbBwFlNVWr
        d0CmwRxXpBsgNgc06vLk1eVKwsHXEeButifuNjqa4Q/iI3zbQw==
X-Google-Smtp-Source: ABdhPJyhK0IWZ9FCIE6v/gd9tPg0tEMMHOM5N+BbAswvGPn0bjJBNJsl8CJ61HKEaz/udlVYbIeaMVODQRVkR/7m1bA=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr15073445otb.250.1604396853837;
 Tue, 03 Nov 2020 01:47:33 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsqbbtYXaw3=upAMnhccjLezaN7RUjysEF4QhS6TfRr-A@mail.gmail.com>
In-Reply-To: <CA+G9fYsqbbtYXaw3=upAMnhccjLezaN7RUjysEF4QhS6TfRr-A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Nov 2020 10:47:22 +0100
Message-ID: <CAMuHMdV2A21oMcA9=rQVfL9xJfRZpV__87byMo4GsXH2i7Y2uQ@mail.gmail.com>
Subject: Re: ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 3, 2020 at 10:43 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
> Linux next 20201103 tag make modules failed for i386 and arm
> architecture builds.
>
> Error log:
>   LD [M]  fs/btrfs/btrfs.o
>   MODPOST Module.symvers
> ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> scripts/Makefile.modpost:111: recipe for target 'Module.symvers' failed
> make[2]: *** [Module.symvers] Error 1
>
> Full build log,
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-lkft/891/consoleText
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/891/consoleText
>
> --
> Linaro LKFT
> https://lkft.linaro.org

Yeah, I had a look earlier today, thanks to the kisskb builder, and
the btrfs people are working on a fix.
Interestingly, the issue was reported in September, and still entered
linux-next, so we all had a great time to look into it ;-)

https://lore.kernel.org/linux-btrfs/202009160107.DZZO6Dfi%25lkp@intel.com/
https://lore.kernel.org/linux-btrfs/20201102073114.66750-1-wqu@suse.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
