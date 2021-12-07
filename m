Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D835F46BFFF
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 16:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbhLGP5h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 10:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbhLGP5c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 10:57:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F57C0617A2
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 07:54:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1A9BB81852
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 15:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CE7C341CF
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638892439;
        bh=Bxp6sGNxp0ASDJtcBnSB7YevMGOZhTa+oocneYTBCQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=o8PWCMvCGLtEDHX+kcaTo/cfTSQXLQ4UGo0K5cp2ZbICThhD3NbM/WhJyTqJY2G++
         Oq15Xb3zU7Hsra+dFRWI9JaIqNCjE1TO6RqnjZy6UtsEMNgFSEtM2mTbM6Wk8S01m8
         5yjEO2Q1HH3Uyx15Pb7gd5hicS9ti0VDHrjwm587NPawHQMc1Oyh8m8LlEMtkK2P7d
         mHnmlY0+0eGFUB+Y2QPWAHdS6hNccuHvwCNR/H90wyqM37x2mkPD8mhlCHwcie7zzw
         ge+7fe5nI0ISPT5/WHcL3OWRYqYxiXTWQAwszoEQgas76EkE0lgD/RmI+NcEqxk8eP
         ++qsk9Y16QXzw==
Received: by mail-qk1-f176.google.com with SMTP id t6so15091597qkg.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Dec 2021 07:53:59 -0800 (PST)
X-Gm-Message-State: AOAM532ciNyJ3U1fCgwCq5Hndn7a2z0h4Jv4mVq7xRL0Tvw334Ts+p0F
        zscTtKJSwqh8dABJHVNJam27IU8jjfb0R42yAOQ=
X-Google-Smtp-Source: ABdhPJzAddw6RJgtFHDMT9e3xcg0+PIGMeundHdSAJwIReJgKOOHGoqFyZT7FcucV1GzziICcJyGsxVQJuVO5seZ84o=
X-Received: by 2002:a05:620a:44c1:: with SMTP id y1mr42187433qkp.187.1638892438753;
 Tue, 07 Dec 2021 07:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20211207074400.63352-1-wqu@suse.com> <Ya8/NpvxmCCouKqg@debian9.Home>
 <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com> <Ya9L2qSe+XKgtesq@debian9.Home>
 <a91e60a4-7f5a-43eb-3c10-af2416aade9f@suse.com> <20211207145329.GW28560@twin.jikos.cz>
 <20211207154048.GX28560@twin.jikos.cz>
In-Reply-To: <20211207154048.GX28560@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 7 Dec 2021 15:53:22 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6uUasjNSxpfAN_oNEVQiTtMNGbsEKrvywES4fCbHcByg@mail.gmail.com>
Message-ID: <CAL3q7H6uUasjNSxpfAN_oNEVQiTtMNGbsEKrvywES4fCbHcByg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
To:     David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        Filipe Manana <fdmanana@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 7, 2021 at 3:41 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Dec 07, 2021 at 03:53:29PM +0100, David Sterba wrote:
> > On Tue, Dec 07, 2021 at 08:01:04PM +0800, Qu Wenruo wrote:
> > > On 2021/12/7 19:56, Filipe Manana wrote:
> > > > On Tue, Dec 07, 2021 at 07:43:49PM +0800, Qu Wenruo wrote:
> > > >> On 2021/12/7 19:02, Filipe Manana wrote:
> > > >>> On Tue, Dec 07, 2021 at 03:43:58PM +0800, Qu Wenruo wrote:
> > > >>>> This is originally just my preparation for scrub refactors, but when the
> > > >>>> readahead is involved, it won't just be a small cleanup.
> > > >>>>
> > > >>>> The metadata readahead code is introduced in 2011 (surprisingly, the
> > > >>>> commit message even contains changelog), but now only one user for it,
> > > >>>> and even for the only one user, the readahead mechanism can't provide
> > > >>>> much help in fact.
> > > >>>>
> > > >>>> Scrub needs readahead for commit root, but the existing one can only do
> > > >>>> current root readahead.
> > > >>>
> > > >>> If support for the commit root is added, is there a noticeable speedup?
> > > >>> Have you tested that?
> > > >>
> > > >> Will craft a benchmark for that.
> > > >>
> > > >> Although I don't have any HDD available for benchmark, thus would only
> > > >> have result from SATA SSD.
> >
> > I'm doing some tests, in a VM on a dedicated HDD.
>
> There's some measurable difference:
>
> With readahead:
>
> Duration:         0:00:20
> Total to scrub:   7.02GiB
> Rate:             236.92MiB/s
>
> Duration:         0:00:48
> Total to scrub:   12.02GiB
> Rate:             198.02MiB/s
>
> Without readahead:
>
> Duration:         0:00:22
> Total to scrub:   7.02GiB
> Rate:             215.10MiB/s
>
> Duration:         0:00:50
> Total to scrub:   12.02GiB
> Rate:             190.66MiB/s
>
> The setup is: data/single, metadata/dup, no-holes, free-space-tree,
> there are 8 backing devices but all reside on one HDD.
>
> Data generated by fio like
>
> fio --rw=randrw --randrepeat=1 --size=3000m \
>          --bsrange=512b-64k --bs_unaligned \
>          --ioengine=libaio --fsync=1024 \
>          --name=job0 --name=job1 \
>
> and scrub starts right away this. VM has 4G or memory and 4 CPUs.

How about using bare metal? And was it a debug kernel, or a default
kernel config from a distro?
Those details often make all the difference (either for the best or
for the worse).

I'm curious to see as well the results when:

1) The reada.c code is changed to work with commit roots;

2) The standard btree readahead (struct btrfs_path::reada) is used
instead of the reada.c code.

>
> The difference is 2 seconds, roughly 4% but the sample is not large
> enough to be conclusive.

A bit too small.

Thanks.
