Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19E42DB4DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 21:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgLOUF6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 15:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgLOUFt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 15:05:49 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36240C06179C
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 12:05:09 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id y15so15587739qtv.5
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Dec 2020 12:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YrxMuOGWvkprZMb1x75BdJyXXjXtm6F/0Udwp3GUEqs=;
        b=ZJtoHuBdW3zRpME4bbT60IhztExJnSh3IPmgY7zG5xJx2hfZxlDjxQkehybYQXkn4g
         oydKCAltt4Do3Pf4GsJ8ep/iJz9diaDCBmhOIBpx+0JFegfE3RTmxshRYa2NO3afgvzj
         MDpZFc70MUA6eBrLH9dZDxiSfkx2NMjzpofftwKOOL9ELcaZbSIt79Kw09jw1yIkIGhY
         aR43Y44RlG8Ru2ICHwL6nJs/J1HcRnkbEJPg4yEtXxf9kqtFhMT4OWBsTGXSz/Yx0fJy
         0NEzqzwBV0lxN4c58nsUazzqdZ+s64+6+u/g5zXQk0aj3c7buzK3IYjSZu+fcnoeO+Rc
         DXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YrxMuOGWvkprZMb1x75BdJyXXjXtm6F/0Udwp3GUEqs=;
        b=fah2PtlBQIM55fKU3mbBriqDolwSwdDvvsMuJjRPgC3Mc/CtQhSISLAyTY0y7ES/t2
         3aYSwsrssOKmjdqQNQkEDPiChIHsAtfxWu3CRlC1CnpDkGMANX0UF5FllUW+XyuufnA8
         IOHDVxzkhWjTppGSXMG7xUxZIGtb2C4O8urAZZb1Abpraronl3w8iEXqTRM8pivtjH6D
         7muxZ9nWYLh7Y41b7y6MrMQcoptGBWck075fJPArU4T/qWsbzzp6RKLvyIZuFSYNvgnw
         oHcqfNzkguhr9awXM8ddYmCIRLRh9pK+eXJ4brNkzpzzdFUI40H2T5sw4xgnhvWnjvWH
         pp3Q==
X-Gm-Message-State: AOAM532C/5+vKvCdJ3Ze9okjVH5hpKKYpfWVpcukdUhzTJ8i/koo9v5d
        PWcoT72ZFo2M5sAFUAmWo1ebmRDMj+Pc0VaDlfk6O8RX9arVOw==
X-Google-Smtp-Source: ABdhPJwldSUvFQO7eku2OqC+YJ77V+khDSr2WliC8DuluRUVt6TK967KcdOYpe5m5eC6/HTLzsebm1lRYkh5hzQ7XoQ=
X-Received: by 2002:ac8:5893:: with SMTP id t19mr39615721qta.3.1608062708222;
 Tue, 15 Dec 2020 12:05:08 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtU1dAYMSUR4fXbcuS4i=gU=ukC-9Y7io3pUMUt3S+Bjw@mail.gmail.com>
 <ccb8c05e-fa56-c88b-c211-f250fe85d815@applied-asynchrony.com>
 <CAA85sZvFBMad6N8hHR5YM56X9DxKE_3CyOT3xEnp9KsWX=fuHQ@mail.gmail.com>
 <CAA85sZt_deCX-jwtwfT_izf_6nsQXbroe=ksKfNErCwjFXWu_g@mail.gmail.com>
 <CAA85sZseX5FLT-RBFRHjZ0_F0V3X9fFEG4faU02KLaXwgaV=PA@mail.gmail.com>
 <CAA85sZs6_tj-vE8Yve5ixTez7-9sompG4P24FKmbpZ3ZOY_HnQ@mail.gmail.com> <20201216003139.00922c07@natsu>
In-Reply-To: <20201216003139.00922c07@natsu>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Tue, 15 Dec 2020 21:04:57 +0100
Message-ID: <CAA85sZveChvTbXzNm-LJA0=hKRoSWTYq-A6G0FJY9ahh8pHKJQ@mail.gmail.com>
Subject: Re: Odd filesystem issue, reading beyond device
To:     Roman Mamedov <rm@romanrm.net>
Cc:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 15, 2020 at 8:31 PM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Mon, 14 Dec 2020 23:27:51 +0100
> Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> > Aaaand sorry, turns out that my raid device was 1 fifth of its
> > original size and it had to be manually remedied...
> >
> > Now lets see if data survives this...
>
> So, how did it went, and was all data OK?

According to btrfs check everything is a-ok! ;)

> This was a really nasty release, there will be many people with the same
> issue. For instance, just posted:
> https://marc.info/?l=3Dlinux-raid&m=3D160805755832376&w=3D2
> Would be helpful if you could reply there with the steps you took to solv=
e it
> and your experiences.

Will do!

> Thanks!
>
> > On Mon, Dec 14, 2020 at 10:18 PM Ian Kumlien <ian.kumlien@gmail.com> wr=
ote:
> > >
> > > On Mon, Dec 14, 2020 at 9:33 PM Ian Kumlien <ian.kumlien@gmail.com> w=
rote:
> > > >
> > > > On Mon, Dec 14, 2020 at 8:57 PM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
> > > > >
> > > > > On Mon, Dec 14, 2020 at 5:50 PM Holger Hoffst=C3=A4tte
> > > > > <holger@applied-asynchrony.com> wrote:
> > > > > >
> > > > > > On 2020-12-14 17:28, Ian Kumlien wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > Upgraded from 5.9.6 to 5.10 and now I get this:
> > > > > > > [  581.665506] BTRFS: device fsid 3c16de2d-33b6-436a-ba17-38b=
917ae3e33
> > > > > > > devid 1 transid 258057 /dev/dm-0 scanned by systemd-udevd (10=
43)
> > > > > > > [  589.602444] BTRFS info (device dm-0): use lzo compression,=
 level 0
> > > > > > > [  589.602459] BTRFS info (device dm-0): enabling auto defrag
> > > > > > > [  589.602465] BTRFS info (device dm-0): using free space tre=
e
> > > > > > > [  589.602470] BTRFS info (device dm-0): has skinny extents
> > > > > > > [  589.603082] attempt to access beyond end of device
> > > > > > >                 dm-0: rw=3D4096, want=3D36461289632, limit=3D=
10971543296
> > > > > > > [  589.603108] attempt to access beyond end of device
> > > > > > >                 dm-0: rw=3D4096, want=3D36461355168, limit=3D=
10971543296
> > > > > > > [  589.603125] BTRFS error (device dm-0): failed to read chun=
k root
> > > > > > > [  589.603412] BTRFS error (device dm-0): open_ctree failed
> > > > > > > [  834.619193] BTRFS info (device dm-0): use lzo compression,=
 level 0
> > > > > > > [  834.619209] BTRFS info (device dm-0): enabling auto defrag
> > > > > > > [  834.619214] BTRFS info (device dm-0): using free space tre=
e
> > > > > > > [  834.619219] BTRFS info (device dm-0): has skinny extents
> > > > > > > [  834.619825] attempt to access beyond end of device
> > > > > > >                 dm-0: rw=3D4096, want=3D36461289632, limit=3D=
10971543296
> > > > > > > [  834.619844] attempt to access beyond end of device
> > > > > > >                 dm-0: rw=3D4096, want=3D36461355168, limit=3D=
10971543296
> > > > > > > [  834.619858] BTRFS error (device dm-0): failed to read chun=
k root
> > > > > > > [  834.620205] BTRFS error (device dm-0): open_ctree failed
> > > > > > >
> > > > > > > Any ideas?
> > > > > > >
> > > > > >
> > > > > > See https://lore.kernel.org/lkml/20201214053147.GA24093@codemon=
key.org.uk/
> > > > > > + followups. Nothing to do with btrfs.
> > > > >
> > > > > Thank you! and 5.0.1 has been released with the patches reverted,=
 FYI =3D)
> > > >
> > > > No, I'm sad to report that that's not it... or there are other deep=
er
> > > > raid issues...
> > > >
> > > > [  108.688424] BTRFS info (device dm-0): use lzo compression, level=
 0
> > > > [  108.688439] BTRFS info (device dm-0): enabling auto defrag
> > > > [  108.688444] BTRFS info (device dm-0): using free space tree
> > > > [  108.688449] BTRFS info (device dm-0): has skinny extents
> > > > [  108.688955] attempt to access beyond end of device
> > > >                dm-0: rw=3D4096, want=3D36461289632, limit=3D1097154=
3296
> > > > [  108.688978] attempt to access beyond end of device
> > > >                dm-0: rw=3D4096, want=3D36461355168, limit=3D1097154=
3296
> > > > [  108.688994] BTRFS error (device dm-0): failed to read chunk root
> > > > [  108.689310] BTRFS error (device dm-0): open_ctree failed
> > > >
> > > > This is with 5.0.1
> > >
> > > As an update, 5.9.6 can't mount it either
> > >
> > > > > > -h
>
>
> --
> With respect,
> Roman
