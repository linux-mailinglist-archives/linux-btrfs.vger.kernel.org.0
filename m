Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B188E4CE440
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 11:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiCEKoE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 05:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiCEKoD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 05:44:03 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A052261F2
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 02:43:11 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id 63so4578061uaw.10
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Mar 2022 02:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jankanis-nl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuFuSC2vN3VjJWPqIGPkgAz0tO89KLyhO8dY9L7PvMY=;
        b=rBnA0jj+f+g7AFWCPxaWnhE2k/X0uiPJVemllk4D3xMf7IMqG/GIZxmt1btUaeb9it
         wH1J1AR53C+ZjfMCJ8ByPxfWW5vkv+iqn24Lbl9sSizBtree+WnEoRJIoMUR8EKWVHkx
         sPZG0bVQ6RQSvc0OGRCsEX6Jksq3vJ5VNGdImJWnydF5KswyL8dY79bggPpdQB2DM0fu
         RArct84247epMadybh9E6VvEMGwsVtKXnsVVfEOG8tMGoOnPqlBJhX8ZUB/truRHHTRv
         NGh596NK+XcQYQfiRL6OwHpVEsiU+lEGdvIqhmHkOt0+Uj5EdiQAjjGuJVNPuAS1c0Pz
         PvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuFuSC2vN3VjJWPqIGPkgAz0tO89KLyhO8dY9L7PvMY=;
        b=a4/3bqH3m1JDhJsyOZ0hFUY3T3e25VQzt3tHh+mp/TF3iIolHnsd186B9Iybtdi7t7
         D6ZCZLZPP5nHjllqG8urruKtvRfF1EnZXhIySELGOtYK+aK/WGHIdOtnXVkq1RZXC0EE
         cfbzwx6X7nUhADvgDHhmm6h/ojsMGHC7KbGOkioFGxMKPi77pIkD8ZKoF+uOHO3XLTH4
         POI28uNZkZ+meCoXA1j0I7CrNA+6KqE2/Dv0uHRksYOT5QjYRxVmwh18jpYSEstqBfKo
         WFe45IdiTO+Ho+EerMZerIqVkWRuw1whKMJZam0m/JxOM139KK2Gker4KFyL5Wk3hAsE
         Lumg==
X-Gm-Message-State: AOAM532eIQFa483pktU5wt4ZH132NTtcJKpGYBWMzQwDbeNsZ/+fOB29
        Lf1Ma8Dq7GJ/ysassF3Jt68P5nqWvXSu4y1R
X-Google-Smtp-Source: ABdhPJzzdZcxK/kl7HQQ3oXxA2/t7syoddrUxND1/oxYucRpouyOoOBPK+USZr6vaMHjoaGRqQNWIg==
X-Received: by 2002:ab0:3a85:0:b0:343:d243:ddfe with SMTP id r5-20020ab03a85000000b00343d243ddfemr856288uaw.59.1646476991008;
        Sat, 05 Mar 2022 02:43:11 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id q9-20020ab02649000000b0034a4433fe82sm1211311uao.36.2022.03.05.02.43.10
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 02:43:10 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id b37so4572301uad.12
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Mar 2022 02:43:10 -0800 (PST)
X-Received: by 2002:ab0:6f4f:0:b0:342:3ccf:e981 with SMTP id
 r15-20020ab06f4f000000b003423ccfe981mr928493uat.115.1646476990151; Sat, 05
 Mar 2022 02:43:10 -0800 (PST)
MIME-Version: 1.0
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
 <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com> <d3ad10fc-0e4a-a8b3-28d7-bc1957bf03ca@georgianit.com>
 <7c16b26a-e477-d6fd-d3bb-2ed7d086b1f0@gmx.com> <CAAzDdeyLz42V1tVJE1YK5jX2OpLG4Ghw4XYO0-pEcSR0yrkwGg@mail.gmail.com>
In-Reply-To: <CAAzDdeyLz42V1tVJE1YK5jX2OpLG4Ghw4XYO0-pEcSR0yrkwGg@mail.gmail.com>
From:   Jan Kanis <jan.code@jankanis.nl>
Date:   Sat, 5 Mar 2022 11:42:58 +0100
X-Gmail-Original-Message-ID: <CAAzDdewtg7__fg-fgc1650OncVVp9EX+Yh8jDxeFgRh6TOa3Fg@mail.gmail.com>
Message-ID: <CAAzDdewtg7__fg-fgc1650OncVVp9EX+Yh8jDxeFgRh6TOa3Fg@mail.gmail.com>
Subject: Re: Is this error fixable or do I need to rebuild the drive?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Remi Gauvin <remi@georgianit.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Correction on the statistics: 40 GB is 10 million blocks. Chance of no
spurious checksum matches is then (1-2**-32)**1e67 = 0.99767. The risk
starts to become significant when writing a few terabyte.

On Sat, 5 Mar 2022 at 11:33, Jan Kanis <jan.code@jankanis.nl> wrote:
>
> I wrote about 40 GB of data to the filesystem before noticing that one
> device had failed, but that data is now no longer needed so I don't
> care a lot if I might have a corrupted block in there. The filesystem
> is used mainly for backups and storage of large files, there's no
> operating system automatically updating things on that drive, so I'm
> quite sure of what changes are on there.
>
> What surprises me is that I'm getting checksum failures at all now. I
> scrubbed both devices independently when I had taken one of them out
> of the system, and both passed without errors. The checksum failures
> only started happening when I added the out of date device back into
> the array. Does btrfs assume that both devices are in sync in such a
> case, and thus that a checksum from device 1 is also valid for the
> equivalent block on device 2?
>
> The statistics:
> The chance of one block matching its checksum by chance is 2**-32. 40
> GB is 1 million blocks. The chance of not having any spurious checksum
> matches is then (1-2**-32)**1e6, which is 0.999767. That's not as high
> as I was expecting but still a very good chance.
>
> > not to mention your data may not be that random.
> I think there are many cases where the data is pretty random, which is
> when it is compressed. The data on this drive is largely media files
> or other compressed files, which are pretty random. The only case I
> can think of where you would have large amounts of uncompressed data
> on your disk is if you're running a database on it.
>
> I'll see what happens with a scrub.
>
> Thanks for the help, Jan
>
>
> On Sat, 5 Mar 2022 at 07:47, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2022/3/5 11:11, Remi Gauvin wrote:
> > > On 2022-03-04 6:39 p.m., Qu Wenruo wrote:
> > >
> > >>   So by now I'm thinking that btrfs
> > >>> apparently does not fix this error by itself. What's happening here,
> > >>> and why isn't btrfs fixing it, it has two copies of everything?
> > >>> What's the best way to fix it manually? Rebalance the data? scrub it?
> > >>
> > >> Scrub it would be the correct thing to do.
> > >>
> > >
> > > Correct me if I'm wrong, the statistical math is a little above my head.
> > >
> > > Since the failed drive was disconnected for some time while the
> > > filesystem was read write, there is potentially hundreds of thousands of
> > > sectors with incorrect data.
> >
> > Mostly correct.
> >
> > >  That will not only make scrub slow, but
> > > due to CRC collision, has a 'significant' chance of leaving some data on
> > > the failed drive corrupt.
> >
> > I doubt, 2^32 is not a small number, not to mention your data may not be
> >   that random.
> >
> > Thus I'm not that concerned about hash conflicts.
> >
> > >
> > > If I understand this correctly, the safest way to fix this filesystem
> > > without unnecessary chance of corrupt data is to do a dev replace of the
> > > failed drive to a hot spare with the -r switch, so it is only reading
> > > from the drive with the most consistent data.  This strategy requires a
> > > 3rd drive, at least temporarily.
> >
> > That also would be a solution.
> >
> > And better, you don't need to bother a third device, just wipe the
> > out-of-data device, and replace missing device with that new one.
> >
> > But please note that, if your good device has any data corruption, there
> > is no chance to recover that data using the out-of-date device.
> >
> > Thus I prefer a scrub, as it still has a chance (maybe low) to recover.
> >
> > But if you have already scrub the good device, mounted degradely without
> > the bad one, and no corruption reported, then you are fine to go ahead
> > with replace.
> >
> > Thanks,
> > Qu
> >
> > >
> > > So, if /dev/sda1 is the drive that was always good, and /dev/sdb1 is the
> > > drive that had taken a vacation....
> > >
> > > And /dev/sdc1 is a new hot spare
> > >
> > > btrfs replace start -r /dev/sdb1 /dev/sdc1
> > >
> > > (On some kernel versions you might have to reboot for the replace
> > > operation to finish.  But once /dev/sdb1 is completely removed, if you
> > > wanted to use it again, you could
> > >
> > > btrfs replace start /dev/sdc1 /dev/sdb1
> > >
