Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8846BB17
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 13:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhLGMfQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 07:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhLGMfQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 07:35:16 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F629C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 04:31:46 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x3-20020a05683000c300b0057a5318c517so17780724oto.13
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Dec 2021 04:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xy5PrarzL8h07azbER8KAbThGe3DNjfs22aQKPHD308=;
        b=fLJQD3bmAgfHpUggVtzOUTwn+sf8w1wKdTyPaObL4Y/XtwSjVzCgRrpcxDVvMihXOR
         yKHo+lTa2mwXzuvtrkawr5Qwsldcf5CWju73QXwFspqQqztpR3wMFGx4pyKgP8PMqKNQ
         PVZyItiftdGyfGOxuvZgcgtf/uhDRtS5n4E7uA0HraIKjwFHBffq5zO9hKwFhKvkv3Jj
         /yDyctE0+esdWSy17eIZ3YrXfZia9lw3sCoKpn2HWYGAzSG03DA6TP9XYXxGFD4In2s/
         Xp1XPLpev4zSFJw6FVjJX60XCUASZpFWkzcWzRt4F1s/UQnZWz6UOgP8bcgFGsBz+Enh
         zjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xy5PrarzL8h07azbER8KAbThGe3DNjfs22aQKPHD308=;
        b=CIN74Bb9sHCZdKoxeYF1eBEjMDWycgkITc/XiYIEzex6THjZEqi7OWugvAewGrOr7C
         Ni28V3BtAcCW7vPwwbABwC/51BfMTzM0NMmRamr47dB73QnMObMgR196W4N7zpJsP8Hv
         PCiNRkb2Z1noYyey8otJgZkXqKk+ph2Bss8mlA6VCi5HFn41kr1X9LfXTKjBq7PbH1Kh
         Vi54wSMdHgT2R0ABFBVryAAfDWaP/9W0DWAhtzCSGHhQ7yP0dLsGZGFrp5jEXYUpkd1K
         DMRFNgl5nxqrJZsOymnSTh9hfgl+aBm6zcAw1bYp6TCcCtVxcjtyuPrJF/XO6ySqJFp7
         QEew==
X-Gm-Message-State: AOAM532f3xR7/DTNQ8VEXC6C8tr4YMSM4cdibYNlIn36cE6/1GLiDT+C
        Q9Bg51CjHl3/IpBhvBZdY76b6wkiq6C3Mm7mmRHpnVDaxRA=
X-Google-Smtp-Source: ABdhPJyyQD9rqw1h+mOYLusPAVCJsdqkx7eYxWF6tr7thBFzX0TWxBTFl/Fld25sdAPdz6LiJymwOVhbhbiR7HbrWqo=
X-Received: by 2002:a05:6830:2692:: with SMTP id l18mr35194472otu.353.1638880305048;
 Tue, 07 Dec 2021 04:31:45 -0800 (PST)
MIME-Version: 1.0
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
 <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com> <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
 <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com> <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
 <20211207072128.GL17148@hungrycats.org>
In-Reply-To: <20211207072128.GL17148@hungrycats.org>
From:   Jorge Bastos <jorge.mrbastos@gmail.com>
Date:   Tue, 7 Dec 2021 12:31:34 +0000
Message-ID: <CAHzMYBR9dFVTw5kJ9_DfkcuvdrO4x+koicfiWgVNndh8qU2aEw@mail.gmail.com>
Subject: Re: ENOSPC while df shows 826.93GiB free
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This looks to me like this issue I reported before:

https://lore.kernel.org/linux-btrfs/CAHzMYBSap30NbnPnv4ka+fDA2nYGHfjYvD-NgT04t4vvN4q2sw@mail.gmail.com/

Data,single: Size:15.97TiB, Used:15.16TiB (94.94%)

When this happens to me I can see the data usage ratio is lower than
normal, there are mostly large files, and you can balance as much as
you like and the data ratio stays unchanged, and the unallocated space
gets to zero much sooner because of that, most times there's no issue
and data usage ratio is much higher, e.g., this filesystem could be
filled up to less than 4GB available:

Data,RAID0: Size:10.89TiB, Used:10.89TiB (99.97%)

This one could only be filled up to about 300GB available:

Data,RAID0: Size:10.89TiB, Used:10.59TiB (97.26%)

Both contain only large 100GiB size files, both file systems were
filled from new in exactly the same way, one file at a time, no
snapshots, no modifications after the initial data copy.

Regards,
Jorge Bastos

On Tue, Dec 7, 2021 at 9:45 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Tue, Dec 07, 2021 at 04:44:13AM +0100, Christoph Anton Mitterer wrote:
> > On Tue, 2021-12-07 at 11:29 +0800, Qu Wenruo wrote:
> > > For other regular operations, you either got ENOSPC just like all
> > > other
> > > fses which runs out of space, or do it without problem.
> > >
> > > Furthermore, balance in this case is not really the preferred way to
> > > free up space, really freeing up data is the correct way to go.
> >
> > Well but to be honest... that makes btrfs kinda broke for that
> > particular purpose.
> >
> >
> > The software which runs on the storage and provides the data to the
> > experiments does in fact make sure that the space isn't fully used (per
> > default, it leave a gap of 4GB).
> >
> > While this gap is configurable it seems a bit odd if one would have to
> > set it to ~1TB per fs... just to make sure that btrfs doesn't run out
> > of space for metadata.
> >
> >
> > And btrfs *does* show that plenty of space is left (always around 700-
> > 800 GB)... so the application thinks it can happily continue to write,
> > while in fact it fails (and the cannot even start anymore as it fails
> > to create lock files).
> >
> >
> > My understanding was the when not using --mixed, btrfs has block groups
> > for data and metadata.
> >
> > And it seems here that the data block groups have several 100 GB still
> > free, while - AFAIU you - the metadata block groups are already full.
> >
> >
> >
> > I also wouldn't want to regularly balance (which doesn't really seem to
> > help that much so far)... cause it puts quite some IO load on the
> > systems.
>
> If you minimally balance data (so that you keep 2GB unallocated at all
> times) then it works much better: you can allocate the last metadata
> chunk that you need to expand, and it requires only a few minutes of IO
> per day.  After a while you don't need to do this any more, as a large
> buffer of allocated but unused metadata will form.
>
> If you need a drastic intervention, you can mount with metadata_ratio=1
> for a short(!) time to allocate a lot of extra metadata block groups.
> Combine with a data block group balance for a few blocks (e.g. -dlimit=9).
>
> You need about (3 + number_of_disks) GB of allocated but unused metadata
> block groups to handle the worst case (balance, scrub, and discard all
> active at the same time, plus the required free metadata space).  Also
> leave room for existing metadata to expand by about 50%, especially if
> you have snapshots.
>
> Never balance metadata.  Balancing metadata will erase existing metadata
> allocations, leading directly to this situation.
>
> Free space search time goes up as the filesystem fills up.  The last 1%
> of the filesystem will fill up significantly slower than the other 99%,
> You might need to reserve 3% of the filesystem to keep latencies down
> (ironically about the same amount that ext4 reserves).
>
> There are some patches floating around to address these issues.
>
> > So if csum data needs so much space... why can't it simply reserve e.g.
> > 60 GB for metadata instead of just 17 GB?
>
> It normally does.  Are you:
>
>         - running metadata balances?  (Stop immediately.)
>
>         - preallocating large files?  Checksums are allocated later, and
>         naive usage of prealloc burns metadata space due to fragmentation.
>
>         - modifying snapshots?  Metadata size increases with each
>         modified snapshot.
>
>         - replacing large files with a lot of very small ones?  Files
>         below 2K are stored in metadata.  max_inline=0 disables this.
>
> > If I really had to reserve ~ 1TB of storage to be unused (per 16TB fs)
> > just to get that working... I would need to move stuff back to ext4,
> > cause that's such a big loss we couldn't justify to our funding
> > agencies.
> >
> >
> > And we haven't had that issue with e.g. ext4 ... that seems to reserve
> > just enough for meta, so that we could basically fill up the fs close
> > to the end.
> >
> >
> >
> > Cheers,
> > Chris.
