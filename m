Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6B12DE69
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jan 2020 10:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgAAJyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jan 2020 04:54:22 -0500
Received: from mail-vs1-f53.google.com ([209.85.217.53]:34078 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAJyV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jan 2020 04:54:21 -0500
Received: by mail-vs1-f53.google.com with SMTP id g15so23846748vsf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jan 2020 01:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CJ7M2pYIx9LANG93aaEpTL5/tbCMcbxZN/5UQJWAJBg=;
        b=sjQ4Be2ogqMnFKzooghY2TWKaeHc4EhSU7VPgurDkJpsAztcMxESQcG/OJg/wxynEC
         SBJqMb9yCiLgZh8Xo2oL+nm8SK5+uMJGhGD6iw4QLmxYuq8JR5j8pa6a4etQyJXJ3b3L
         I91mBJKdDpmlbpI51/55AAz2HLdPZPGBbr25Q+ZmQB5xUk63QLEsX7gBFVD0Clw9tqWu
         BKCNWw+16gb0wntfagznWXWfbhIEG/tf6Y+Wl8i40Lx4RAlyLlm5TO9VHikQJFidOCFx
         2dn8L94sJEafJm4X7oD0exz2i56KXymFg7y3dEsv8wZyEmM24q+EN4BXqFFmTtEA0qqR
         uvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CJ7M2pYIx9LANG93aaEpTL5/tbCMcbxZN/5UQJWAJBg=;
        b=nfF726KMNjedcVpuhjmZSAaZjA31SLC8lW04fdmnEZZ9rr0iW2CxUP8SKdvNhTyLo6
         HsfdiCaPfz4Z961SctjsDb1BDzIbpuU1PiO1N1Bc+K7Kq6/AqGpz1vaJnmjbKNeKZ8hr
         hLM47Fde/WHoVmd1kEfV2gdGYjrvtOgcZIKQPdNZ1PVWH89zf6AJBjXTFxtvhZLYwktT
         weAINMhCEOTo4PUytdlcLwvi2lahWHzPsqSp1Y67gJ/dq6QbsjuszZOE+l3GlLqIifdy
         kk5KXSlxDJC9B95betKmjfuq28XQuU0n5qpLKnFhNKRq2fINIQb/w8zW4opSWTXoGBi+
         EdIQ==
X-Gm-Message-State: APjAAAXhKownzgP+FkzVagHhYiJPb/5KljwXyEzJrdRdoOL0HgVRU7ZO
        h7XR27WjMbiprjQ9yv27G3HYjULOW+kN51N6vzZ6OgMRLHI=
X-Google-Smtp-Source: APXvYqx8Fy9CQew6QBlC8QTXN4sj6De0fjgKs2OT0WDUWFSRC9HdxphYX9eB9G/v9KNSTRPkcBpLAbi2ycxz2etODOU=
X-Received: by 2002:a67:3187:: with SMTP id x129mr36445943vsx.23.1577872460600;
 Wed, 01 Jan 2020 01:54:20 -0800 (PST)
MIME-Version: 1.0
References: <495cfb98-7afd-a36d-151b-d7cc58f1d352@gmail.com> <9689db15-bf00-2a9d-d5d4-7e0a47f7cd1f@gmx.com>
In-Reply-To: <9689db15-bf00-2a9d-d5d4-7e0a47f7cd1f@gmx.com>
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Wed, 1 Jan 2020 12:54:08 +0300
Message-ID: <CAN4oSBdqngZHvOG5uJ0_bqfv0Lh=kfz3kP5mRWgd83LAD90AAw@mail.gmail.com>
Subject: Re: repeated enospc errors during balance on a filesystem with spare
 room - pls advise
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Ole Langbehn <neurolabs.de@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I learned a lot from previous replies. However, I had been in a very
similar situation recently and I followed
http://marc.merlins.org/perso/btrfs/post_2014-05-04_Fixing-Btrfs-Filesystem=
-Full-Problems.html
so I added a pendrive to create extra space in order to be able to run
btrfs balance. The extra space was not sufficient and I lost the
ability to remove the pendrive. So I added another 1TB external disk,
then removed the pendrive with `btrfs dev remove`, run the `btrfs
balance`, then converted the profile to single/dup and then finally
removed the external disk. Cost my 3 full days to overcome the issue.
I'm posting this experience as a warning :)

https://unix.stackexchange.com/q/558363/65781

Qu Wenruo <quwenruo.btrfs@gmx.com>, 1 Oca 2020 =C3=87ar, 03:13 tarihinde =
=C5=9Funu yazd=C4=B1:
>
>
>
> On 2019/12/31 =E4=B8=8B=E5=8D=8811:04, Ole Langbehn wrote:
> > Hi,
> >
> > I have done three full balances in a row, each of them ending with an
> > error, telling me:
> >
> > BTRFS info (device nvme1n1p1): 2 enospc errors during balance
> > BTRFS info (device nvme1n1p1): balance: ended with status: -28
> >
> > (first balance run it was 4 enospc errors).
> >
> > The filesystem has enough space to spare, though:
> >
> > # btrfs fi show /
> > Label: none  uuid: 34ea0387-af9a-43b3-b7cc-7bdf7b37b8f1
> >         Total devices 1 FS bytes used 624.36GiB
> >         devid    1 size 931.51GiB used 627.03GiB path /dev/nvme1n1p1
> >
> > # btrfs fi df /
> > Data, single: total=3D614.00GiB, used=3D613.72GiB
> > System, single: total=3D32.00MiB, used=3D112.00KiB
> > Metadata, single: total=3D13.00GiB, used=3D10.64GiB
> > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >
> > This is after the balances, but was about the same before the balances.
> > Before them, data had about 50GB diff between total and used.
> >
> > The volume contains subvolumes (/ and /home) and snapshots (around 20
> > per subvolume, 40 total, oldest 1 month old).
> >
> > My questions are:
> >
> > 1. why do I get enospc errors on a device that has enough spare space?
>
> A known bug in v5.4, where extra space check in relocation doesn't match
> the new metadata over-commit.
>
> > 2. is this bad and if yes, how can I fix it?
>
> There are patches for that:
> https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D208445
>
> >
> >
> >
> > A little more (noteworthy) context, if you're interested:
> >
> > The reason I started the first balance was that a df on the filesystem
> > showed 0% free space:
> >
> > # df
> > Filesystem     1K-blocks      Used Available Use% Mounted on
> > /dev/nvme1n1p1 976760584 655217424       0 100% /
>
> Another known bug, which we also had a patch for it:
> https://patchwork.kernel.org/patch/11293419/
>
> Thanks,
> Qu
>
> > ...
> >
> > and a big download (chromium sources) was aborted due to "not enough
> > space on device".
> >
> > I monitored the first balance more closely, and right after the start,
> > df looked normal again, showing available blocks, but during the
> > balance, it flip-flopped a couple of times between again showing 0
> > available bytes and showing the complement between actual size and used
> > bytes. I did not observe this behavior any more during balance 2 and 3,
> > but did not observe as closely.
> >
> > TiA for any insights and ideas on how to proceed and a healthy start
> > into the new year for everyone.
> >
> >
> >
> >
>
