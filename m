Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514313B1E96
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhFWQ1X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 12:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWQ1W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 12:27:22 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8796DC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 09:25:03 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c138so6651547qkg.5
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/TDAscweSUSj8j7984ak/aOckcoa4LhdcAYslNZE35E=;
        b=TYE47APV1FQ78aGK/huYNAHpvVUJavJD+Qt5APTr8d9Osz3BZNZv936/NZFNqNigR+
         91BP2TfcU6LL3P5XRBVCmtPIru1to3uDDwhpmkuL30Qf33F07CWbiJA/egUKlbsstZ/W
         15coUPzlxf+ho0FCBNUM+/sY0BuWHRjiHayFCA0Vm2o1fWdSAFNpyPo0guDBE+fWb2Nb
         772tgDdARrcgqcU4FfNqq5KStO1IkhPdb6G9AKsgcaRMt9hImRsEkR/uOjvZEbPWVbA3
         0Ulu4gtfGblFBdoiQaWBEs1X6UhVODFM+ykMwvRRtAL5HIvqZyoWFGDZ+PE/9+xnwNYZ
         /i6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/TDAscweSUSj8j7984ak/aOckcoa4LhdcAYslNZE35E=;
        b=rUsfL9p6J/33Gsx459BwmP2GY4SSU2vRWJ+g9gccOUIO8DqwY8mjKl/Gxw4Aq8Johl
         EzMfLStlHIQRIel02Rw8LPahUiSi95/Ri72tVwHerKfmRyTdRnBMcBPBV1xeDhse5CRG
         zMcfrIWl3YcDRqdvGduEu1c+vmtgDZHn7LcN9B6j4FcPw5VX88dKF6k02CHsB+w7X7Ki
         3msN+KdvwafMly8mI1B4s9R32S6oR6529WIkrEkO7cvB2fchtk9/7pw7BznRmhgnO4AN
         cpvQpGgTCnNAsFsKiSsg0nim4EdTg6xZsloWU4Y56JJGNVqdXPVnJ8XKzcukGeLRheWI
         nNrg==
X-Gm-Message-State: AOAM5338sHbXLMLZAH/ppYPHwi7jMOphIPwM5psZtPyJvfTRKqHkMNAw
        He5Dg2xzzznj4gs05FI1EdGA/QfC2JI4JRvR6fY=
X-Google-Smtp-Source: ABdhPJxhVaG87Ijll6ZKkZlQ0dOwxIz6Mi5/L7q1kaXy629JNhKrih44e6Z3YRfoL/ml/7NABdW7Ma3YjkBRL5vPQzw=
X-Received: by 2002:a25:dfd0:: with SMTP id w199mr353620ybg.337.1624465502779;
 Wed, 23 Jun 2021 09:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com> <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com> <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
 <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com> <CAHw5_hkUhV8OvrdZOWTnQU_ksh3z94+ivskyw_h069HwYhvNXg@mail.gmail.com>
 <CAHw5_hmUda4hO7=sNQNWtSxyyzm7i9MU50nsQkrZRw7fsAW3NA@mail.gmail.com>
 <e12010fe-6881-c01c-f05f-899b8b76c4fd@gmx.com> <CAHw5_hmeUWf0RdqXcFjfSEEeK4+jTb1yxRuRB5JSnK1Avha0JQ@mail.gmail.com>
 <83e8fa57-fc20-bc5b-8a63-3153327961a6@gmx.com> <CAHw5_hm+UX2EHSdZHcMXWMNYxOtccKMQ1qtfbu1gKUm-WZFXYg@mail.gmail.com>
 <CAJCQCtTW0tR-55UkkE=r0ONQucCO7_An2ASOQeBjZiZXtPrLSg@mail.gmail.com>
 <CAHw5_hnLSwMBqNxE6pPvau+-9LQoCmWp7fy6vuxtT-UPPLL4Fw@mail.gmail.com> <4d1f2c32-521a-aab4-7da9-6a0a8d3ecdc6@gmx.com>
In-Reply-To: <4d1f2c32-521a-aab4-7da9-6a0a8d3ecdc6@gmx.com>
From:   Asif Youssuff <yoasif@gmail.com>
Date:   Wed, 23 Jun 2021 12:24:51 -0400
Message-ID: <CAHw5_h=izT2+AzXFK03uETYM2go=mKnSWYkW_5ki-36fkoYaNg@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Murphy <lists@colorremedies.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 23, 2021 at 5:38 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/6/23 =E4=B8=8B=E5=8D=885:32, Asif Youssuff wrote:
> > On Tue, Jun 22, 2021 at 5:33 PM Chris Murphy <lists@colorremedies.com> =
wrote:
> >>
> >> On Tue, Jun 22, 2021 at 12:37 AM Asif Youssuff <yoasif@gmail.com> wrot=
e:
> >>
> >>> I went ahead and also created two partitions each on the two new usb
> >>> disks (for a two of four new partitions) and added them to the btrfs
> >>> filesystem using "btrfs device add", then removing a snapshot followe=
d
> >>> by a "btrfs fi sync". The filesystem still goes ro after a while.
> >>
> >> Yeah Qu is correct, and I had it wrong. Two devices have enough space
> >> for a new metadata BG, but no other disks. And it requires four. All
> >> you need is to add two but it won't even let you add one before it
> >> goes ro. So it's stuck. Until there is a kernel fix for this, it's
> >> permanently read-only (unless we're missing some other work around).
> >
> > Hmm, would this be something that would be fixed in the near term?
> > Just wondering how long I'd have to leave this as ro.
> >
> > Happy to continue to try any other ideas of course, but I'd rather not
> > destroy the fs and start over.
>
> The problem is, I don't see why we can't do anything, including adding a
> new device.
>
>  From the fi df output, we still have around 512M metadata free space,
> it means unless there is something wrong with globalrsv, we should be
> able to add new devices, which doesn't require much new space.
>
> For the worst case, I can craft a btrfs-progs program to manually
> degrade all your RAID1C3/C4 chunks to SINGLE.
>
> By that you can have tons of space left, but that should be the last
> thing to do IMHO.
>
> Currently I prefer to find a way to stop all background work like
> balance/subvolume deletion, and try to add two new devices to the array,
> then continue.
>
> I still can't get why "btrfs device add" would success while "btrfs fi
> show" shows no new device.
>
> The new devices to add are really blank new devices, right? Not some
> disks already used by btrfs?

Yes, absolutely. I even formatted them as ext4 and rebooted in order
to ensure that btrfs processes would not be acting on them until I did
btrfs device add.

Once I run btrfs device add, the filesystem type shows up in gparted
as "unknown" - eg:

/dev/sdk1           2048 15187967 15185920  7.2G 83 Linux
/dev/sdk2       15187968 30375935 15187968  7.2G 83 Linux

I am also adding the devices like what Paul jones suggested - like:

sudo mount /media/camino/ && sudo btrfs device add -f /dev/sdl1
/dev/sdl2 /dev/sdk1 /dev/sdk2 /media/camino/

>
> Thanks,
> Qu
> >
> >>
> >>
> >>> Would mounting as degraded make it possible to add the disks and have
> >>> it stick?
> >>
> >> No, that's even more fragile and you're sure to run into myriad
> >> degraded raid5 bugs, not least of which are the bogus errors. And it
> >> won't be obvious which ones are important and which ones are not.
> >>
> >>
> >> --
> >> Chris Murphy
> >
> >
> >



--=20
Thanks,
Asif
