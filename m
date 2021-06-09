Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4055F3A206C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 00:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFIWwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 18:52:15 -0400
Received: from mail-yb1-f174.google.com ([209.85.219.174]:35368 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhFIWwO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 18:52:14 -0400
Received: by mail-yb1-f174.google.com with SMTP id i4so37840650ybe.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Jun 2021 15:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=PugCeV9TeMiNsSdvYWaeZzQxDR/ACUEOJGTAWw4Dazc=;
        b=rRDS6Z8gpePOb8MJ1ryqzfstOit2u6DaKzDS/bxgESW0VedypRnG7qwq8iOsRyTLkK
         NajQQIywu8NKopu5c/H76zgtZP9+G7IaPI6vriC7BORmH5R9HcCvrCQ87EXnauBf9NYA
         QiOEKDGI3CouGuRmi8y/wzz4+J74urJ26LScWPJ5NJaBjapBTuERhAXE6HdSM9mL1Q4z
         zLfDeLRmCCsgODF5/6wRKyOL5GkX9SXI8rRWBl384D3eGoVkfEKQV8MdjpLWkizOL/oL
         pQfiSxadKjZSAbvtWh8FTvO7YPpOMR2RvyDbsdAwmA/lQauefdxVHszADlH/tSk9e1gR
         SYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=PugCeV9TeMiNsSdvYWaeZzQxDR/ACUEOJGTAWw4Dazc=;
        b=qrE6nimdwoBw3hCcSdr8DuNDxbSNOsdaj+DGtTahTh1qL9NZl6Pdow8tNFqZvcxnbr
         lH8WrT+BmQKwUG2i5FJVd5kAX1EaoFp1HmnaUdHoIHix4KR+HJ57Fu4j11tlkdDNUjTo
         wGeYtSNji88bogeMEo/o29Rt809NLOFE4MTCmBqlGSwBaA/zz5XrFMAdlBVUMivBKszn
         S6rbx1J1mshNOO65oJQCV4SIaM3BJPot/nyizZm6/CdYe+W+XzLyrTNCQFX4OJy+277h
         SB1Tn3L4wYX1R3R2lMx3ID0Kp0cUUxr9sC3qPT9dX6RKC30y3qAOSx4ZTC8Lu657g/I7
         k8yg==
X-Gm-Message-State: AOAM531U5uSWL2zY4IOeZfr1u7esdO6MjRHx+xnOhyrPaWg2TG+TEe5j
        c9eD1dWlvS5G0iam2Km9gSyFC1NDI1QOLy0jC7c=
X-Google-Smtp-Source: ABdhPJwA9Pvn3JxCiVNckmmb7H1ftvbSMXbqxeZgtTTH8GnfW05i7pHtiah4877ny0oSyydOaPCISDJTi0SiG91YN04=
X-Received: by 2002:a25:aa66:: with SMTP id s93mr3239310ybi.260.1623278947461;
 Wed, 09 Jun 2021 15:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210608025927.119169-1-wqu@suse.com> <20210609152650.GC27283@twin.jikos.cz>
In-Reply-To: <20210609152650.GC27283@twin.jikos.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 9 Jun 2021 18:48:31 -0400
Message-ID: <CAEg-Je_8sDQNWM9tdka_Zd=v5pQzf0AsnJJAVAeKy7nMO5CE8Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] btrfs: defrag: rework to support sector perfect defrag
To:     David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 9, 2021 at 12:23 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Jun 08, 2021 at 10:59:17AM +0800, Qu Wenruo wrote:
> > This branch is based on subpage RW branch, as the last patch needs to
> > enable defrag support for subpage cases.
> >
> > But despite that one, all other patches can be applied on current
> > misc-next.
> >
> > [BACKGROUND]
> > In subpage rw branch, we disable defrag completely due to the fact that
> > current code can only work on page basis.
> >
> > This could lead to problems like btrfs/062 crash.
> >
> > Thus this patchset will make defrag to work on both regular and subpage
> > sectorsize.
> >
> > [SOLUTION]
> > To defrag a file range, what we do is pretty much like buffered write,
> > except we don't really write any new data to page cache, but just mark
> > the range dirty.
> >
> > Then let later writeback to merge the range into a larger extent.
> >
> > But current defrag code is working on per-page basis, not per-sector,
> > thus we have to refactor it a little to make it to work properly for
> > subpage.
> >
> > This patch will separate the code into 3 layers:
> > Layer 0:      btrfs_defrag_file()
> >               The defrag entrace
> >               Just do proper inode lock and split the file into
> >               page aligned 256K clusters to defrag
> >
> > Layer 1:      defrag_one_cluster()
> >               Will collect the initial targets file extents, and pass
> >               each continuous target to defrag_one_range()
> >
> > Layer 2:      defrag_one_range()
> >               Will prepare the needed page and extent locking.
> >               Then re-check the range for real target list, as initial
> >               target list is not consistent as it doesn't hage
> >               page/extent locking to prevent hole punching.
> >
> > Layer 3:      defrag_one_locked_target()
> >               The real work, to make the extent range defrag and
> >               update involved page status
> >
> > [BEHAVIOR CHANGE]
> > In the refactor, there is one behavior change:
> >
> > - Defraged sector counter is based on the initial target list
> >   This is mostly to avoid the paremters to be passed too deep into
> >   defrag_one_locked_target().
> >   Considering the accounting is not that important, we can afford some
> >   difference.
>
> As you're going to resend, please fix all occurences of 'defraged' to
> 'defragged'.
>
> I'll give the patchset some testing bug am not sure if it isn't too
> risky to put it to the 5.14 queue as it's about time to do only safe
> changes.

This patch set makes it possible to do compression and balance in
subpage cases, right? At least, that's what I understood of it (defrag
code is used for balance and compression...).


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
