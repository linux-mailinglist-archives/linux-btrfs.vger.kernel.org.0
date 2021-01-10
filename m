Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDC22F061C
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Jan 2021 10:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbhAJJA4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Jan 2021 04:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbhAJJA4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Jan 2021 04:00:56 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49379C061786
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 01:00:14 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p14so12293694qke.6
        for <linux-btrfs@vger.kernel.org>; Sun, 10 Jan 2021 01:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=baFJfo71OOE9so4+4MiZfwVdkPvUXb+hwOSL3OMq9Pc=;
        b=U2TPiSxufF0GzsdvvAUJfC2JRCM4eFtNCJqolRHDKQq6ZUMEM+RlT+UtgIyuvaNU1H
         NsTab5nZTIa2QrSEsAdKEh8nunHhTmZI0Fq6lmHFUxGCZa/eJ2a8+ycGoCITqmoVn/8K
         oZKa7qy8q8bO8D1ktRNWMAv3BA7yW4CjqojMez4AV47kgzbLROCfVJe8B5khcXsbylcT
         7x49VuizmYuEVKNgdQ7d5Wtd3VK5MGVKkVkxOdMpoFbODDYxolL5cTRqka11BZSFhkq1
         8xlAkJpTI4xrQzDNrwizR2pFuPoyMIj7xEYzinvAGWkKrc+O84cRYE9WYouumVrEiLsj
         ZWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=baFJfo71OOE9so4+4MiZfwVdkPvUXb+hwOSL3OMq9Pc=;
        b=hFcndTe8LopSgorS8e4NKqthIovZgSgy+arPgX+nEO2IULXmt4eJsPxiQjYgdY9HAJ
         Bm0V7ymUX9h06Ki5wzlS9NaPvM8MkOp54E3A37Lo3Ju6c+aPqjcLLBoDwqvThwSv/dXP
         dwPm+QjMNH7b4zizuKL/kNe/shNOjBx7nBNZYAXw+xsoUrEg8cW6H0zI8h4RCQzWvb44
         u8ib3Tr8dfrYIw6JhbGvbLNr885LjKnCl8zzBMbXmZdyatV/lf+Nzlsngh5RjbLllh79
         Yr2pVR1342R7iUKKZ9SnRxq6uLYXCzSAhiWxTVltvzia+H7mb/f4Vpc7BL2KBZEXsRyf
         t5VA==
X-Gm-Message-State: AOAM530k+QWdXj5yFgc0oJEEaqh67vvePFA/pFYeHW6oQrYFj/RSRfmK
        pDyRIzwq/FTwUcFH2xEUlKIXNkmUU/DqPEgkIyA=
X-Google-Smtp-Source: ABdhPJz5wIEtTCP9LafdDPk4NdMS1CbwD4YwYYkhYt9y/W+TShpsP/ZZde4TraWd17+JtOVI6Grn53YvunXPy9LTJDg=
X-Received: by 2002:a37:a06:: with SMTP id 6mr11434487qkk.376.1610269213388;
 Sun, 10 Jan 2021 01:00:13 -0800 (PST)
MIME-Version: 1.0
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
 <CAK-xaQZS+ANoD+QbPTHwL-ErapA-7PDZe_z=OOWq_axAyR1KfA@mail.gmail.com>
 <eb0f5e05a563009af95439f446659cf3@mail.eclipso.de> <CAK-xaQbQPSS7=cH1qmb9S51CL34VRfyE_=eNwb-GhSL1b8Yz2g@mail.gmail.com>
 <20210109214032.GC31381@hungrycats.org>
In-Reply-To: <20210109214032.GC31381@hungrycats.org>
From:   Andrea Gelmini <andrea.gelmini@gmail.com>
Date:   Sun, 10 Jan 2021 10:00:01 +0100
Message-ID: <CAK-xaQZ=ZNqkruDSjNdprDfj5nAh5TdCpT+sv0nB6LqCRu7dmQ@mail.gmail.com>
Subject: Re: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize
 the SSD?
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Cedric.dewijs@eclipso.eu, Linux BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Il giorno sab 9 gen 2021 alle ore 22:40 Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> ha scritto:
>
> On Fri, Jan 08, 2021 at 08:29:45PM +0100, Andrea Gelmini wrote:
> > Il giorno ven 8 gen 2021 alle ore 09:36 <Cedric.dewijs@eclipso.eu> ha scritto:
> > > What happens when I poison one of the drives in the mdadm array using this command? Will all data come out OK?
> > > dd if=/dev/urandom of=/dev/dev/sdb1 bs=1M count = 100?
> You have used --assume-clean and didn't tell mdadm otherwise since,
> so this test didn't provide any information.

I know mdadm, no need of your explanation.

"--assume-clean" is used on purpose because:
a) the two devices are already identical;
b) no need two sync something (even if they were random filled), that
are going to be formatted and data filled, so - more or less - each
block is rewritten.

> On real disks a mdadm integrity check at this point fail very hard since
> the devices have never been synced (unless they are both blank devices
> filled with the same formatting test pattern or zeros).

I disagree. My point is: who cares about blocks never touched by the filesystem?

> > root@glet:/mnt/sg10# dd if=/dev/urandom of=/dev/loop32 bs=1M count=100
>
> With --write-mostly, the above deterministically works, and
>
>         dd if=/dev/urandom of=/dev/loop31 bs=1M count=100
>
> deterministically damages or destroys the filesystem.

My friend, read the question, he asked about what happens if you
poison the second device.
Of course if you poison /dev/md0 or the main device what else can
happen, in such situation?
Thanks god you told us, because we are all so much stupid!

My point of view is: you can use mdadm to defend from real case
scenario  (first hard drive die,
the second slow one goes on, and you have all your data up to date,
and if you are afraid of
bit rotten data, you have btrfs checksum).
Also, even if the second/slow hard drive is out-of-sync of seconds, it
would like if unplugged while working.
All cool feature of BTRFS (transaction, checksums, dup btree and so
on) will recover filesystem and do the rest, isn't it?

Thinking about "what if I trick my system here and there" is
absolutely fun, but no real use case, for me.

What if I expose BTRFS devices to cosmic rays and everything is wiped out?

(I know, my only hero Qu is already preparing a patch - as usual -
while others starts to write poems...)

Don't take it personally and smile,
Gelma
