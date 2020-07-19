Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031A8225495
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jul 2020 00:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGSWs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 18:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGSWs2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 18:48:28 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F288C0619D2
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jul 2020 15:48:28 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w27so11689781qtb.7
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Jul 2020 15:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zTpKP+jV9HKNoGFZiu60KJkJBbvZ+n9+IkEd01mlcbs=;
        b=eeYyw/gQUIEje0CXa0hPHyKXb614ACGSt19n30CXIZBsQFP/IJAQow7gQbBOd8Ak/4
         T7zV4Eehgs2By7M50waWw2IUbLOSGQ7I67ZeuU1Hq4ki3dYdHuqoT9zPDJBbCM0wXJbY
         Ct8u+3pXjI31w5gYSOQo5qslR87aEBr6kPTWNivPgnDVrlFKpqzdcjN72Nx3CQZU2xCN
         HGVlgfBGdQkGf78GVAiuk/hTFnxpaGnpOO6wQPm78Yn3AeprLipTqTTuT9dbq9xF6n+h
         9C3r6pXrnjspJldGrIfGuDgl80A2CiFzJU1Sx8J4pQXMi34Vboz229dNfBQFwfj0iUzl
         4/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=zTpKP+jV9HKNoGFZiu60KJkJBbvZ+n9+IkEd01mlcbs=;
        b=Ob9XS+38JukPyMSVMhW85d536vQpaaW9wuQh/MtgpHPB38dDMn3bz14jiW8jGAYhGx
         C3oAt/+f7iDmRy6teAbKNeyN7IhbBDhoRWNkcb5kI4YgOeo62yFbjnYQ9i9bgbivHqFH
         iaQMimKeOyLr52VT8vyW1gfotc0ObTXA4t1MNDfR5QN2+8JzJERlk+uTJHFYbTONy6MQ
         jQSxeh//7bTRGrttbbsXcEsCXswjUBH3SGt4tqgLaTKU/uQQNDsvxKfEp8xS5zysV/xJ
         +d3GauWyQRjJKseXl6UxVg+wURaOpvrQoKjDAhd3zCJCVIMW7o4wCNf/BDP1FQo97ct3
         9pHg==
X-Gm-Message-State: AOAM531sUw/tr/mHbIA6dDo2dU8yA6hyjYqC/iQT3q5uSB+Ul8ph62m0
        AqSQ4me8jfLFkJbjJPy0cvDrRKIvw2Qc08OzN4fclzto
X-Google-Smtp-Source: ABdhPJwzRqr9MC5KMj3LeTVvHumr4p1+yF+Ry6x+G9ubLOHkntCg/EFfITCPWuInYCWV2qgleG98lNQj+maF86o96jo=
X-Received: by 2002:ac8:c4e:: with SMTP id l14mr21617910qti.106.1595198907036;
 Sun, 19 Jul 2020 15:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <a85c20.e6b39479.1736906f225@lechevalier.se>
In-Reply-To: <a85c20.e6b39479.1736906f225@lechevalier.se>
From:   Falk Bay <falkartis@gmail.com>
Date:   Mon, 20 Jul 2020 00:48:15 +0200
Message-ID: <CANUBKXj0=dWao_ZtLAZ3ai1htDT+099WjTJ9Spt=s8xoYTSfeA@mail.gmail.com>
Subject: Re: Possible bug detected, need help
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you very much for the fast responses.

I'll try out the suggested tips starting with the fastest/easiest ones.

The kernel is surely outdated, blame on me, I'll upgrade it as soon as poss=
ible.

Things I already tested, but forgot to mention in my first e-mail:
memtest86+ I had it running for 2 pases and no errors where found,
I'll be running it for longer to see if there is some temperature
related error or any other kind.
I runned a SMART automatic health test, again no errors.
I runned btrfs check --repair, I didn't think it would be dangerous,
also no errors.
I mounted the fs in ro mode and copied everything to an external backup hdd=
.

So now I'm going to try out your suggestions to see what extra
information I get.

Thanks to all of you,
Falk

El dom., 19 jul. 2020 a las 23:42, A L (<mail@lechevalier.se>) escribi=C3=
=B3:
>
>
>
> ---- From: Falk Bay <falkartis@gmail.com> -- Sent: 2020-07-19 - 22:24 ---=
-
>
> > Hi,
> >
> > First of all I want to thank you for this great piece of software,
> > I've been using it for a long time and it perfectly suits my needs.
> >
> > After a unclean shutdown, with a balancing in progress and very little
> > free space in my RAID1 filesystem I ended up with a btrfs filesystem
> > that only works in ro mode.
> > If I try to mount it as normal, any read or write operation will hang
> > forever, not even "umount" will return.
> > As a side note, if I mount it as normally I have to force my machine
> > to power off since the normal shutdown will wait until any filesystem
> > is unmounted.
> >
> > Here are my technical details:
> >
> > uname -a
> > Linux poloni 4.15.0-111-generic #112-Ubuntu SMP Thu Jul 9 20:32:34 UTC
> > 2020 x86_64 x86_64 x86_64 GNU/Linux
> >
> > btrfs --version
> > btrfs-progs v4.15.1
> >
> > sudo btrfs fi show
> > Label: none  uuid: aa1f67a3-8cd3-4d1b-87de-a04b48efbcfd
> >     Total devices 2 FS bytes used 27.58GiB
> >     devid    1 size 32.00GiB used 31.00GiB path /dev/sda7
> >     devid    2 size 32.00GiB used 31.00GiB path /dev/sdb7
> >
> > Label: 'my-btrfs'  uuid: 5ea692ab-c7b1-4618-be39-d82eaf5c6b34
> >     Total devices 2 FS bytes used 888.89GiB
> >     devid    3 size 891.51GiB used 891.51GiB path /dev/sda5
> >     devid    5 size 891.51GiB used 891.51GiB path /dev/sdb5
> >
> > this aa1f67a3-8cd3-4d1b-87de-a04b48efbcfd works fine.
> > this 5ea692ab-c7b1-4618-be39-d82eaf5c6b34, my-btrfs is the one that
> > causes problems
> >
> > btrfs fi df /mnt/
> > Data, RAID1: total=3D888.48GiB, used=3D886.92GiB
> > System, RAID1: total=3D32.00MiB, used=3D208.00KiB
> > Metadata, RAID1: total=3D3.00GiB, used=3D1.97GiB
> > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >
> > I was willing, but unable, to remove some large files to have enough
> > free space to operate normally.
> >
> > I add the dmesg.log file in the attachment.
> >
> > I wonder if I should try to fix it or if I should format the partition
> > and recover a backup.
> >
> > Thanks in advance,
> > Falk
>
> The dmesg suggest a balance in running. The skip_balance is a good option=
 here.
>
> I'd to see the output of `btrfs fi us /mnt/` as it will show the allocati=
ons better. You may have a situation with not enough space to allocate a ne=
w data or metadata block and the balance is not very good at handling this.
>
> A note is that deleting files actually can increase metadata usage.
>
> To solve that youd have to do very specific balancing options. But the su=
ggested memtest is good! Do you have earlier kernel outputs with errors to =
share?
>
> https://wiki.tnonline.net/w/Btrfs/ENOSPC shows a high level on how block =
allocation work..
> Official FAQ is here: https://btrfs.wiki.kernel.org/index.php/FAQ#Help.21=
_I_ran_out_of_disk_space.21
>
> I suggest you do look for those earlier logs and do the testing suggested=
 by Chris Murphy.
>
> Good luck!
>
> /Anders
>
>
