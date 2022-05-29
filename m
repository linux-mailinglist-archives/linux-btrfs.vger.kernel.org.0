Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C821753716E
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 May 2022 17:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiE2PAs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiE2PAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 11:00:48 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FEC9347B
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 08:00:47 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id s23so9106956iog.13
        for <linux-btrfs@vger.kernel.org>; Sun, 29 May 2022 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/Xj26ATuX5kqg8FLgikWgT/0E+lGAtidm0kbL6zQLk=;
        b=QU3+GBGexLHHoTNG0mI8AHCNh/wVSALw+5MSsGQCSrBWi/h1CA37B7jhizhcpLJV5m
         ftBCMefuSjj5RlqWXrq746dtXJLOl9wCV5axsR7INpQnfX+TpaFGeuXuYsFtpyONBjmp
         NlPYipr4KeqHbYdrmIW9gH0UTg/KZiZB1KwdCaXCN7thFLrAUCkkWArLa5A+pCK15WnI
         79UqU6BEMBjHCkKF1MfIgmMtv5KKn5FzD/tfZPWmb6HtgN7JGTCIoxlTM+HrMsYOFzfZ
         f1PJTkoytbJP1Y9gK2wxp/pcUBEycfbyDYQllQkpx+nayv5NewdJuTQ2EdgmLyqx1qmz
         2AoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/Xj26ATuX5kqg8FLgikWgT/0E+lGAtidm0kbL6zQLk=;
        b=hVMhgHoFpML/Ov9PEyKRT5wiaBZ988Ct5VPGMjYy8bFCmY4/AhbrbQcSm2Xw1Lz5j8
         b5FyDKxmZ3uiCW/JXoJmORQeC72pc0QdnUkVurcDZNnZnyswfIuhSVItfNmLAtFsZgpX
         CyYG0kChl/MiGIDxAVqsR93R6TcnOdYFTW+FgbhxpPTlTS4X108Z7ek4wvSFpD+2PmDI
         raXdnmgIJHcZNqKsyFEBLVuh6zgTsINRLc3mr7aagIvG+kp9sYiu/wfir0yLeDEWv7OG
         flYxkK5+/a5EE/Y2ve6kQLZ6r2b+jS8NlSKlof9pYRf1dzqZFmcdk3o7PztcVvsj0H59
         B60w==
X-Gm-Message-State: AOAM5323/mz33ynx15bpA+J7eCt0An8jI9PAa+t5N0Iio1/Se7hxtK1E
        vEBJsG9TZaG5xGjoQzsFHy861jljOAGvkVVvEYeBvSnXwmE=
X-Google-Smtp-Source: ABdhPJyMjDNVw7/Bt2QfgcALuBH/MRQPP/hUpmbrE63vrUTZZ940XZ2g5001QOnhIDLm1PnSoXIGNzmA4dacZ75fEDY=
X-Received: by 2002:a05:6602:1695:b0:665:8390:fcf with SMTP id
 s21-20020a056602169500b0066583900fcfmr10655894iow.83.1653836446339; Sun, 29
 May 2022 08:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220526191512.GE28329@merlins.org> <CAEzrpqetTskf-UtyfXHBajpJBci4vxdSaBXwDTm5cRs2QtNRkw@mail.gmail.com>
 <20220526213924.GB2414966@merlins.org> <20220527011622.GA24951@merlins.org>
 <CAEzrpqdbuQGwwuCfYyVdiDtGDsPb=3FWmKrTEA5Xukk1ex514g@mail.gmail.com>
 <20220527232604.GA22722@merlins.org> <CAEzrpqeJyupr02nUJkBBVCah46FN+znVczm-RtfBFauvJW9O6w@mail.gmail.com>
 <CAEzrpqfAYRUYttOAMmdth4mfi4e7MTM++s5WOQ+KAzg2Kv0Nsw@mail.gmail.com>
 <20220528225601.GD24951@merlins.org> <CAEzrpqcG+9evRPKixVwGnAS_k2tb7o16jQgORtm1cw7hW_KsAw@mail.gmail.com>
 <20220529035139.GE24951@merlins.org>
In-Reply-To: <20220529035139.GE24951@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 29 May 2022 11:00:35 -0400
Message-ID: <CAEzrpqcKeVNkXa3txx0nyDnKUCp06msmd97d1fBedTzbmR5KcA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 28, 2022 at 11:51 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sat, May 28, 2022 at 09:00:00PM -0400, Josef Bacik wrote:
> > On Sat, May 28, 2022 at 6:56 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Sat, May 28, 2022 at 04:08:25PM -0400, Josef Bacik wrote:
> > > > Sorry my ability to think isn't doing so great right now.  I've wired
> > > > up the detection stuff, but it won't actually fix anything yet.  I
> > > > want to make sure I've got detection part right before I go messing
> > > > with the file system.  If you can pull and build and then run
> > > >
> > > > btrfs rescue recover-chunks <device>
> > > >
> > > > and capture the output that would be great.  Hopefully this shows the
> > > > missing block groups and I can just copy them into place.  Thanks,
> > >
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue recover-chunks /dev/mapper/dshelf1
> > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > > checksum verify failed on 21135360 wanted 0x00000000 found 0x3533f3b5
> > > Csum didn't match
> > > ERROR: cannot read chunk root
> > > WTF???
> > > ERROR: open ctree failed, try btrfs rescue tree-recover
> > > Recover chunks tree failed
> > > gargamel:/var/local/src/btrfs-progs-josefbacik#
> > >
> > > So, should I do what it says?
> >
> > Oh yeah duh sorry, I was adding it to tree-recover but decided it was
> > a bad place for it.  Go ahead and run tree-recover and then do the
> > recover-chunks.  Thanks,
>
> :(
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> ERROR: cannot read chunk root
> WTF???
> ERROR: open ctree failed
> Tree recover failed

Sorry, thought I fixed this before pushing yesterday, try again please.  Thanks,

Josef
