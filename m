Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0876A4CE436
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Mar 2022 11:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiCEKed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Mar 2022 05:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCEKec (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Mar 2022 05:34:32 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492401E1139
        for <linux-btrfs@vger.kernel.org>; Sat,  5 Mar 2022 02:33:41 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id g20so11691012vsb.9
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Mar 2022 02:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jankanis-nl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ws7et/iyfSc9NwEjC/Tx2zWZgRnXbk6wYL8vfkLBroc=;
        b=OnuijJu37aJYQvtuxwQoHGUquEf6wiXsFip1Hv139KdQlEoQ4Vbk8PQ8+0ZqIor7qY
         E9mQLSEvf8PdUk/OMZWgmhLwGLKJnzDPOT6ul7evIVmhKxLBbKHCmfvKSgl02A2vNxzS
         BdwNykffXgvnxA8IyiKTkDJUsjKsR9jawCQJEKKaIKfPCrvXGuqc4WG3bEy0qi7pFHTV
         9P066cFTPL/rIeCovMawi+JeE4ehmKgsbmWW4+pNEB/VuuTZQf3DempKNGJT/+rOh5zx
         9z6g+ocAIaq3+SRfWRzomYrM5gNyB+R+93HCYIK585fE9FHFay4wIrISmJdtSnUPr7N2
         E7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ws7et/iyfSc9NwEjC/Tx2zWZgRnXbk6wYL8vfkLBroc=;
        b=iAL70vUCr1Rr9Zux0jO58cfJryQGSCX8CoXLg5BENbGkj70XMPYGAupviPCvHHs9TJ
         KAu78S3VmAVs1ytffdMXupIL4W460L4JIVGEEo9rNhRFlyGD43D3RihEn6TFU9J5wC6n
         ZKzac4cZxym22DwJrdxNAezhP5J7+DiBfGKBEPdJAXi6zyESKh3GI4rPZjah+1evNURZ
         ozLudLSct4cc96O5eu2YAdMja4/jTQYvZt+zPB9dx/2C5MmwjT2rAzpgbHd9xq0jkIlN
         G1hAc+B2pLFtNV+a8yAOCn1bcbUg1cz+QGxuqyr/0ndsPniRjnGI6eqg/EpDqgtvpzPe
         KcMA==
X-Gm-Message-State: AOAM533h1P0QQF0IeGSKH1mr60EGGmfqSzzkbu55pfkpgKMOjZGAr1mG
        iM+7bpRqbz9c8NztE6k5z/yHzgYs7Eq2ZSVx
X-Google-Smtp-Source: ABdhPJzdZq3mM9xK73hYnwn6SzDvoIJy8g1NH2kQlHdQvLnvlCcqGRdoDcOGTyZPpZfLjYlsYbHf0A==
X-Received: by 2002:a05:6102:3714:b0:320:5ff6:1e81 with SMTP id s20-20020a056102371400b003205ff61e81mr1035285vst.0.1646476420326;
        Sat, 05 Mar 2022 02:33:40 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id o124-20020a1fa582000000b0032908b5b846sm1080352vke.26.2022.03.05.02.33.39
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 02:33:39 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id 127so139841vsd.2
        for <linux-btrfs@vger.kernel.org>; Sat, 05 Mar 2022 02:33:39 -0800 (PST)
X-Received: by 2002:a05:6102:956:b0:31b:1b52:ed9f with SMTP id
 a22-20020a056102095600b0031b1b52ed9fmr1130563vsi.28.1646476419399; Sat, 05
 Mar 2022 02:33:39 -0800 (PST)
MIME-Version: 1.0
References: <CAAzDdeysSbH-j-9rBGs3HBv2vyETbVyNoCjfDOKrka1OAkn1_g@mail.gmail.com>
 <2e9ee21e-65aa-9fb5-1d1c-1d6dea93eb12@gmx.com> <d3ad10fc-0e4a-a8b3-28d7-bc1957bf03ca@georgianit.com>
 <7c16b26a-e477-d6fd-d3bb-2ed7d086b1f0@gmx.com>
In-Reply-To: <7c16b26a-e477-d6fd-d3bb-2ed7d086b1f0@gmx.com>
From:   Jan Kanis <jan.code@jankanis.nl>
Date:   Sat, 5 Mar 2022 11:33:28 +0100
X-Gmail-Original-Message-ID: <CAAzDdeyLz42V1tVJE1YK5jX2OpLG4Ghw4XYO0-pEcSR0yrkwGg@mail.gmail.com>
Message-ID: <CAAzDdeyLz42V1tVJE1YK5jX2OpLG4Ghw4XYO0-pEcSR0yrkwGg@mail.gmail.com>
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

I wrote about 40 GB of data to the filesystem before noticing that one
device had failed, but that data is now no longer needed so I don't
care a lot if I might have a corrupted block in there. The filesystem
is used mainly for backups and storage of large files, there's no
operating system automatically updating things on that drive, so I'm
quite sure of what changes are on there.

What surprises me is that I'm getting checksum failures at all now. I
scrubbed both devices independently when I had taken one of them out
of the system, and both passed without errors. The checksum failures
only started happening when I added the out of date device back into
the array. Does btrfs assume that both devices are in sync in such a
case, and thus that a checksum from device 1 is also valid for the
equivalent block on device 2?

The statistics:
The chance of one block matching its checksum by chance is 2**-32. 40
GB is 1 million blocks. The chance of not having any spurious checksum
matches is then (1-2**-32)**1e6, which is 0.999767. That's not as high
as I was expecting but still a very good chance.

> not to mention your data may not be that random.
I think there are many cases where the data is pretty random, which is
when it is compressed. The data on this drive is largely media files
or other compressed files, which are pretty random. The only case I
can think of where you would have large amounts of uncompressed data
on your disk is if you're running a database on it.

I'll see what happens with a scrub.

Thanks for the help, Jan


On Sat, 5 Mar 2022 at 07:47, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/3/5 11:11, Remi Gauvin wrote:
> > On 2022-03-04 6:39 p.m., Qu Wenruo wrote:
> >
> >>   So by now I'm thinking that btrfs
> >>> apparently does not fix this error by itself. What's happening here,
> >>> and why isn't btrfs fixing it, it has two copies of everything?
> >>> What's the best way to fix it manually? Rebalance the data? scrub it?
> >>
> >> Scrub it would be the correct thing to do.
> >>
> >
> > Correct me if I'm wrong, the statistical math is a little above my head.
> >
> > Since the failed drive was disconnected for some time while the
> > filesystem was read write, there is potentially hundreds of thousands of
> > sectors with incorrect data.
>
> Mostly correct.
>
> >  That will not only make scrub slow, but
> > due to CRC collision, has a 'significant' chance of leaving some data on
> > the failed drive corrupt.
>
> I doubt, 2^32 is not a small number, not to mention your data may not be
>   that random.
>
> Thus I'm not that concerned about hash conflicts.
>
> >
> > If I understand this correctly, the safest way to fix this filesystem
> > without unnecessary chance of corrupt data is to do a dev replace of the
> > failed drive to a hot spare with the -r switch, so it is only reading
> > from the drive with the most consistent data.  This strategy requires a
> > 3rd drive, at least temporarily.
>
> That also would be a solution.
>
> And better, you don't need to bother a third device, just wipe the
> out-of-data device, and replace missing device with that new one.
>
> But please note that, if your good device has any data corruption, there
> is no chance to recover that data using the out-of-date device.
>
> Thus I prefer a scrub, as it still has a chance (maybe low) to recover.
>
> But if you have already scrub the good device, mounted degradely without
> the bad one, and no corruption reported, then you are fine to go ahead
> with replace.
>
> Thanks,
> Qu
>
> >
> > So, if /dev/sda1 is the drive that was always good, and /dev/sdb1 is the
> > drive that had taken a vacation....
> >
> > And /dev/sdc1 is a new hot spare
> >
> > btrfs replace start -r /dev/sdb1 /dev/sdc1
> >
> > (On some kernel versions you might have to reboot for the replace
> > operation to finish.  But once /dev/sdb1 is completely removed, if you
> > wanted to use it again, you could
> >
> > btrfs replace start /dev/sdc1 /dev/sdb1
> >
