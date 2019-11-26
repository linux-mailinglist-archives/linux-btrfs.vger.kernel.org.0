Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60394109C66
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2019 11:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfKZKhK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 26 Nov 2019 05:37:10 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42105 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfKZKhK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 05:37:10 -0500
Received: by mail-oi1-f195.google.com with SMTP id o12so16142341oic.9;
        Tue, 26 Nov 2019 02:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=zopcK9DsIvrRMoKJaFBKq6wC/oxcFlyic0ael7BkN/8=;
        b=ZwVGY8zZHU5ZLlSEHGkPOB3WBZlU+FiSvWqw44quKppgl1s6DVA0XOwR/NoRmZKAqp
         G9F7+R3vQgynRQndg27qMClcfGPlquhPu1hT8D/dAQaWhaPBKgoTm34N4ntgWccIWQ66
         avgX31kibPnRfWKhTm34CXTORtTEovoNsD1wiQCEmCsw3tTtMySmX8jYycJ6NTQuLfyg
         XRfU14g70wJgEAV1xQg15my1zL8ZBMpNz8kzq8DNWUfc9JQ4K93SAMe+0OzcVLlbq1V8
         R1FfmF1LJZGZstb861SXWChE3arTel8q8w2JMU6VsR2HzmZWWifSa4QD9OjM2DGRPSM2
         bq9A==
X-Gm-Message-State: APjAAAUV6hPUiPm7vpIBV5oeArCblh2/6Lieo2R4Ae/47reKO//92F8W
        kIi13oOB9oe5X+t5lupMA7abLXK2qBez588NsHI=
X-Google-Smtp-Source: APXvYqy4IeHlk78TvbZm1ZoZWnHSVBVTAMMciv5D+d1SOKzarsswVbnPuPy/zEICeY+bC7LzL429WWkDb12wjApJxSY=
X-Received: by 2002:a05:6808:5d9:: with SMTP id d25mr3047363oij.54.1574764629163;
 Tue, 26 Nov 2019 02:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20191108213853.16635-1-afaerber@suse.de> <20191108213853.16635-2-afaerber@suse.de>
 <20191111183158.GT3001@twin.jikos.cz>
In-Reply-To: <20191111183158.GT3001@twin.jikos.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Nov 2019 11:36:58 +0100
Message-ID: <CAMuHMdVbcfB0FFS=gLDathXFM3x0WYXJEq99S_g7mjAPS94rAQ@mail.gmail.com>
Subject: Re: [PATCH next 1/2] btrfs: tree-checker: Fix error format string
To:     David Sterba <dsterba@suse.cz>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

On Mon, Nov 11, 2019 at 7:32 PM David Sterba <dsterba@suse.cz> wrote:
> On Fri, Nov 08, 2019 at 10:38:52PM +0100, Andreas Färber wrote:
> > From: Andreas Färber <afaerber@suse.com>
> >
> > Argument BTRFS_FILE_EXTENT_INLINE_DATA_START is defined as offsetof(),
> > which returns type size_t, so we need %zu instead of %lu.
> >
> > This fixes a build warning on 32-bit arm:
> >
> >   ../fs/btrfs/tree-checker.c: In function 'check_extent_data_item':
> >   ../fs/btrfs/tree-checker.c:230:43: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=]
> >     230 |     "invalid item size, have %u expect [%lu, %u)",
> >         |                                         ~~^
> >         |                                           |
> >         |                                           long unsigned int
> >         |                                         %u
>
> Is there a gcc warning option that can catch that on 64bit too?
> -Wformat=2 does not and I don't see any other of the option family to do
> that. We've had fixups of the size_t printk formats and I'd like to
> catch that when the patches are added to the devel branches. I can't run
> 32bit build check each time but this seems to be the only way so far.

Yep. On 64-bit, size_t _is_ unsigned long.
So you have to compile for both 32-bit and 64-bit.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> > Fixes: a31ccb4b7ba2 ("btrfs: tree-checker: Check item size before reading file extent type")
>
> As the patch is still in the devel branch, the commit id is not stable

It indeed is not:
Fixes: 153a6d299956983d ("btrfs: tree-checker: Check item size before
reading file extent type")

> and I'll fold the change to to the patch. Thanks.

Apparently that was forgotten, and now the issue is part of Linus' tree.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
