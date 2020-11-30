Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA582C84E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Nov 2020 14:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgK3NQR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Nov 2020 08:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgK3NQR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Nov 2020 08:16:17 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D159C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 05:15:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq13so1308859pjb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Nov 2020 05:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brunner-ninja.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irT2x6yco+hczHGgYhVWT/z/mn8GGEB21D2X43iPjdg=;
        b=NoMYlV0BewBUlmhOKe1ARZGVHtnxdWqjEd/oW5X4HUwn+kozTCONBKiw2iDEJd+FvF
         fAizmVl70RwcOZAWrxs0XvTv1yIg4rBaXoOZgVliSTCrMnrGLTaXvhjdnP/XTEQjHdHJ
         Fbm8A7yL5aJB77zj+y8Ehp6nen+6LmPKjbpUS9mA77LsuP3i76vvwxV6+RcWoLYNLmUS
         cimTlmu+y7MjWBsXdZaDG98/4Uuf6veEaFP6vgECcpj9vHx1RREF3wi1+hmf4Wg5uUP7
         agpnGsGEk0IZVxBDXA9AZrJU90+t3on4JILpWAtNkuJSOLsj1tY+VbZWKZATlTKvBtdL
         A2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irT2x6yco+hczHGgYhVWT/z/mn8GGEB21D2X43iPjdg=;
        b=WpwiaFDMzDZjUUrBFI/+x4ExjakbKVyZ9VedGYJdHnMxKDV20ZEBPt594QeWi/wuYq
         fQHQAdLBCPEuM7DXUMbulxopdt/1rPNj+dYBT2+xE30rzSFczNDndgQRvQ7MXr9yFOfP
         ziVQKd8/zDBvARYpn/CoN1/GZBdV7XfCqBUq0mGgUAsH8bJDryomDGVfgLoZ7WNWrYCz
         B0JsUukZgduPZilNz29A+MUrrIGmo46KVxUJzNBt+ictU1CxqOYHUa3W+OZiIpJ+etEk
         bkippYAd7uzeqsf6QZeRvfBHYz499g207E7Bpg3dY1Qh+OFJlTtbbJgCT02mQOXHhhKa
         pCyQ==
X-Gm-Message-State: AOAM533d4o7Y67C3m2j4DJ2OKUUVCyZr3tT5Ow1wGTIsvhX7JbtLBKlT
        6OGZmemxIZ7o2W0qxetB26UaPIKffAtD1jjqcEi0dxWzo9I=
X-Google-Smtp-Source: ABdhPJyoBW7OiOs/ScZgMPGM6SvzrXoWq0BsEOsO+yW18maH6Y/p+l3/nwfqJ5+OCSyV4Nz3ZsxIqZStLWOL1JwSR1I=
X-Received: by 2002:a17:90a:f3c3:: with SMTP id ha3mr9122875pjb.202.1606742136735;
 Mon, 30 Nov 2020 05:15:36 -0800 (PST)
MIME-Version: 1.0
References: <CAD7Y51gpvZ79nVnkg+i3AuvT-1OiXj0eaq2-aig38pGmBtm-Xw@mail.gmail.com>
 <CAJCQCtS0HVBQZ1-=oAhvYnywUVuhjS__8qf553YMoRWriabADg@mail.gmail.com> <CAD7Y51imT3BhQzMHqVUB=ZMcAQiSPoG8E8HZMVmpggzjDgN9fA@mail.gmail.com>
In-Reply-To: <CAD7Y51imT3BhQzMHqVUB=ZMcAQiSPoG8E8HZMVmpggzjDgN9fA@mail.gmail.com>
From:   Daniel Brunner <daniel@brunner.ninja>
Date:   Mon, 30 Nov 2020 14:15:25 +0100
Message-ID: <CAD7Y51i=mTDnEWEJtSnUsq=xqbEtGC2NP0Yo4vAcPkSu+Wq+Rg@mail.gmail.com>
Subject: Re: corrupted root, doesnt check, repair or mount
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Additional comment: I cannot recover the list of commands I executed
on the mdadm and bcache back then because I used a user which's home
is on the btrfs :)

BR,
Daniel

Am Mo., 30. Nov. 2020 um 14:14 Uhr schrieb Daniel Brunner
<daniel@brunner.ninja>:
>
> Hi,
>
> thx for the reply, here the outputs:
>
> # btrfs insp dump-s /dev/mapper/bcache0-open
> superblock: bytenr=65536, device=/dev/mapper/bcache0-open
> ---------------------------------------------------------
> csum_type 0 (crc32c)
> csum_size 4
> csum 0xe29c4dff [match]
> bytenr 65536
> flags 0x1
> ( WRITTEN )
> magic _BHRfS_M [match]
> fsid 4e970755-09c3-4df2-992d-d2f1e0b7d5e4
> metadata_uuid 4e970755-09c3-4df2-992d-d2f1e0b7d5e4
> label
> generation 23991070
> root 51642824081408
> sys_array_size 97
> chunk_root_generation 23971935
> root_level 2
> chunk_root 1064960
> chunk_root_level 1
> log_root 0
> log_root_transid 0
> log_root_level 0
> total_bytes 29202801745920
> bytes_used 17674898116608
> sectorsize 4096
> nodesize 16384
> leafsize (deprecated) 16384
> stripesize 4096
> root_dir 6
> num_devices 1
> compat_flags 0x0
> compat_ro_flags 0x0
> incompat_flags 0x161
> ( MIXED_BACKREF |
>   BIG_METADATA |
>   EXTENDED_IREF |
>   SKINNY_METADATA )
> cache_generation 23991070
> uuid_tree_generation 23991070
> dev_item.uuid 0b210cdb-1581-41af-b4a4-a71707f53bec
> dev_item.fsid 4e970755-09c3-4df2-992d-d2f1e0b7d5e4 [match]
> dev_item.type 0
> dev_item.total_bytes 29202801745920
> dev_item.bytes_used 19385355862016
> dev_item.io_align 4096
> dev_item.io_width 4096
> dev_item.sector_size 4096
> dev_item.devid 1
> dev_item.dev_group 0
> dev_item.seek_speed 0
> dev_item.bandwidth 0
> dev_item.generation 0
>
>
>
> # btrfs rescue super -v /dev/mapper/bcache0-open
> All Devices:
> Device: id = 1, name = /dev/mapper/bcache0-open
>
> Before Recovering:
> [All good supers]:
> device name = /dev/mapper/bcache0-open
> superblock bytenr = 65536
>
> device name = /dev/mapper/bcache0-open
> superblock bytenr = 67108864
>
> device name = /dev/mapper/bcache0-open
> superblock bytenr = 274877906944
>
> [All bad supers]:
>
> All supers are valid, no need to recover
>
>
> Am Fr., 27. Nov. 2020 um 00:55 Uhr schrieb Chris Murphy
> <lists@colorremedies.com>:
> >
> > On Wed, Nov 25, 2020 at 2:16 PM Daniel Brunner <daniel@brunner.ninja> wrote:
> > >
> > > Hi all,
> > >
> > > I used btrfs resize to shrink the filesystem and then used mdadm to
> > > shrink the backing device.
> > >
> > > Sadly I did not use btrfs for the software raid itself.
> > >
> > > After shrinking the mdadm device, my btrfs filesystem doesnt want to
> > > mount or repair anymore.
> >
> > First, make no writes to any of the drives until you understand
> > exactly what went wrong. Any attempt to repair it without
> > understanding the problem comes with risk of making the problem worse
> > and not reversible.
> >
> > What were the exact commands, in order? Best to use the history
> > command so we know for sure what every relevant command is.
> >
> > > # btrfs check --repair --force /dev/mapper/bcache0-open
> >
> > Yeah first mistake is to try and repair. Fortunately it looks like it
> > couldn't get far enough along to even attempt writes.
> >
> > I don't know anything about bcache so I looked at this:
> > https://wiki.archlinux.org/index.php/bcache#Resize_backing_device
> >
> > So the question is, what was the bcache device cache mode? Writeback
> > or writethrough? And did you confirm that bcache reports a clean state
> > before doing the mdadm resize?
> >
> > > # blockdev --getsize64 /dev/mapper/bcache0-open
> > > 40002767544320
> >
> > What do you get for
> >
> > # btrfs insp dump-s /dev/mapper/bcache0-open
> > # btrfs rescue super -v /dev/mapper/bcache0-open
> >
> > Importantly these are read only commands and make no changes.
> >
> >
> > --
> > Chris Murphy
