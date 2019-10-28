Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB01CE71E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2019 13:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbfJ1Mn4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Oct 2019 08:43:56 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39905 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfJ1Mnz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Oct 2019 08:43:55 -0400
Received: by mail-ua1-f65.google.com with SMTP id o25so2628484uap.6
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Oct 2019 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=+QBDf9wn80JFmrHJ1DaQTjiEBmw0iIoRyz+gYFM92mQ=;
        b=d/A1/sa0mmJg+zS497+q7tQOVwCt88jTiH3Qi7J9frcc3QCQx5j8P37QsL9LBjRGq/
         P8Io66efxq+4mzcZNsTpZgbbzSGucpTlUWFExGsjjw8w79kVjqlzHh123wyPJZFbeluG
         k9T8j3kkra91lC/re4iQWcoYPgABB2hW2l6CujOMuh98ZOK6mxc3nCgTMP7hIb5TH03u
         hOe5Hglo7CFrhyl2MN3EZPSuGWfPQaLb21mH/U2wEtRoEIKjmThioZsNuqT1+GPjuDtS
         6Absx+g3ffMiqnLDgqYIs7QV8O2e/Q3+nETP6LkLpRXHI+/6JjDEzmWondM6a9L+PLVk
         isGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=+QBDf9wn80JFmrHJ1DaQTjiEBmw0iIoRyz+gYFM92mQ=;
        b=gV+MU2EyyUR127fluQRITyPZzfVeT4jvHISxI6v+PCpJR60B1mLVGL+4NK46bkaW0R
         4s004GbORtopT4yOkNPatM/Suniqcng39/RjS6yuQRr5jBcOdKHwl/ZPqpOMEJmsFNoN
         nBnAbREw1m3vnv4q4sictr1/vGHzoIGYkwbz1hzV9GXKXi8/YRy/YG+ueDYrarAsIZvF
         Ms3DlELpkaRYvLKqYtG9olf56ezbqQBy3vpFV/LDPryHRxtTILKg4tzN26Ns/m+fex8o
         Cl9RzU+XPx/TN1wef951XUd9tOR8Z/c+D147wZ2Uq6eG7/Eql87hT6nct9278tXvPfaT
         Kumg==
X-Gm-Message-State: APjAAAULDhOQwITSvzGsanhHeTp9Dp6/GY5UZ8AHBgK9AxF5+yfr2kez
        e8lUMnG5KM4FttShaGRD07FGoZuJbvD59MO2HFQ=
X-Google-Smtp-Source: APXvYqzYb8VVw1CMP5J16z7YfUnBVVFHTWrstY8NeBxmOxjWufrsgbxlNNSTNJpED9cwmGucEBCjRaK22VDHR7lRFc8=
X-Received: by 2002:ab0:7058:: with SMTP id v24mr7778151ual.83.1572266634372;
 Mon, 28 Oct 2019 05:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com> <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com> <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
 <CAL3q7H4Wc0GnKNORVvwCOEk1QhzUweJr1JnN=+Scx5-TpQ5+yA@mail.gmail.com> <6364c263-0e47-9ff1-9288-7f6cadcc69bb@gmx.com>
In-Reply-To: <6364c263-0e47-9ff1-9288-7f6cadcc69bb@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 28 Oct 2019 12:43:43 +0000
Message-ID: <CAL3q7H7B=dBmKNm7V6Pb13VKa2bWt9GjX25zh=e_7epqPx7LYA@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Atemu <atemu.main@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 28, 2019 at 12:36 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/10/28 =E4=B8=8B=E5=8D=887:30, Filipe Manana wrote:
> > On Sun, Oct 27, 2019 at 4:51 PM Atemu <atemu.main@gmail.com> wrote:
> >>
> >>> It's really hard to determine, you could try the following command to
> >>> determine:
> >>> # btrfs ins dump-tree -t extent --bfs /dev/nvme/btrfs |\
> >>>   grep "(.*_ITEM.*)" | awk '{print $4" "$5" "$6" size "$10}'
> >>>
> >>> Then which key is the most shown one and its size.
> >>>
> >>> If a key's objectid (the first value) shows up multiple times, it's a
> >>> kinda heavily shared extent.
> >>>
> >>> Then search that objectid in the full extent tree dump, to find out h=
ow
> >>> it's shared.
> >>
> >> I analyzed it a bit differently but this should be the information we =
wanted:
> >>
> >> https://gist.github.com/Atemu/206c44cd46474458c083721e49d84a42
> >
> > That's quite a lot of extents shared many times.
> > That indeed slows backreference walking and therefore send which uses i=
t.
> > While the slowdown is known, the memory consumption I wasn't aware of,
> > but from your logs, it's not clear
> > where it comes exactly from, something to be looked at. There's also a
> > significant number of data checksum errors.
> >
> > I think in the meanwhile send can just skip backreference walking and
> > attempt to clone whenever the number of
> > backreferences for an inode exceeds some limit, in which case it would
> > fallback to writes instead of cloning.
>
> Long time ago I had a purpose to record sent extents in an rbtree, then
> instead of do the full backref walk, go that rbtree walk instead.
> That should still be way faster than full backref walk, and still have a
> good enough hit rate.

The problem of that is that it can use a lot of memory. We can have
thousands of extents, tens of thousands, etc.
Sure one can limit such cache to store up to some limit N, cache only
the last N extents found (or some other policy), etc., but then either
hits become so rare that it's nearly worthless or it's way too
complex.
Until the general backref walking speedups and caching is done (and
honestly I don't know the state of that since who was working on that
is no longer working on btrfs), a simple solution would be better IMO.

Thanks.

> (And of course, if it fails, falls back to regular write)
>
> Thanks,
> Qu
>
> >
> > I'll look into it, thanks for the report (and Qu for telling how to
> > get the backreference counts).
> >
> >>
> >> Yeah...
> >>
> >> Is there any way to "unshare" these worst cases without having to
> >> btrfs defragment everything?
> >>
> >> I also uploaded the (compressed) extent tree dump if you want to take
> >> a look yourself (205MB, expires in 7 days):
> >>
> >> https://send.firefox.com/download/a729c57a94fcd89e/#w51BjzRmGnCg2qKNs3=
9UNw
> >>
> >> -Atemu
> >
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
