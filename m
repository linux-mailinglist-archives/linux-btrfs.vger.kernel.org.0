Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204B82D37D7
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Dec 2020 01:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbgLIAba (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 19:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731894AbgLIAbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 19:31:25 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE06C0613CF
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 16:30:39 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id w4so55234pgg.13
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 16:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brunner-ninja.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ne2Sp2d5nWfP1SJn1SF1LdiwmWsFEGixyOoVqCNruQ=;
        b=lebfslONNZWbzqWxzjXpwQxh+DVw+2hoB+ctacsuTVeFmviXCPR5Bp9kIX9G9Sp222
         UwFcDrX/iFe1+hekgMl0fNWwvgchkQCCN60iJdLiju3iv7S8d5u0V976YEx+j8jL9B/V
         ZG0Jce/wqMGQIGl3a4PAfTXaZQdnViogpia65xZMYgF29KY/nWgHFz7MD3kMW2ZVYMly
         y2BQnYceLLwFD8Rs8OtJt1of3VBeBYsh5T1o+L8bkBcWs8JRd81IvqKOW78Gqg9vspvG
         SrT5lULOP8tRIPQlSLTB6yWRiDh/kiF6pL/LZbXwzPOL+4oMwyhBC43H6vCro6R8yC3K
         2u/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ne2Sp2d5nWfP1SJn1SF1LdiwmWsFEGixyOoVqCNruQ=;
        b=bKv/ctukhtiu70KSXZn9Uwng40YA3j/ndkiavVaIodij8z6HEDPEWCghzyOiiwbT9m
         mTjGVmfLGZgxu7ExTgfmLqLaU59m60tf+zd5XsTro7tuN41ibp5BW6d7GSV8ryA4fmm/
         mq/b+uC+rgBF+P/OzVgMBtbwpmjAap3mgkvWUuwT9Rl0QKuQ7TvMRsMYI+f8iQBMoumj
         5aETRZ8AbsfnJW7n7bl86n+gqgGLR5B5dpN50E6EUlcjV8q2+icW8LoDaGvz2vHD8M37
         xiYfW2iUInduszX5aZNyvdwaxwJ7Y1DpJV66QB9LB7bHpx90rSmVduQC2qwI+1C/neN3
         kujw==
X-Gm-Message-State: AOAM531RiHiNf18EPpBdYjeWcWN9+LlCy4w+3lLi6osDk1+/k6WhFu+f
        BbspohiEziwwi5QZk8RQS34Y6jxipuPstWa5srpegtUrx6Y=
X-Google-Smtp-Source: ABdhPJx5yekxPGpxD3sVJsvQfQlgWOx95LHBXErxkgXLa0AdNLwFuDHHeIL36kmh8Y+HueXgHDEnutO54IgVUxMi9D8=
X-Received: by 2002:a17:90a:f3c3:: with SMTP id ha3mr94313pjb.202.1607473839220;
 Tue, 08 Dec 2020 16:30:39 -0800 (PST)
MIME-Version: 1.0
References: <CAD7Y51gpvZ79nVnkg+i3AuvT-1OiXj0eaq2-aig38pGmBtm-Xw@mail.gmail.com>
 <CAJCQCtS0HVBQZ1-=oAhvYnywUVuhjS__8qf553YMoRWriabADg@mail.gmail.com>
 <CAD7Y51imT3BhQzMHqVUB=ZMcAQiSPoG8E8HZMVmpggzjDgN9fA@mail.gmail.com> <CAD7Y51i=mTDnEWEJtSnUsq=xqbEtGC2NP0Yo4vAcPkSu+Wq+Rg@mail.gmail.com>
In-Reply-To: <CAD7Y51i=mTDnEWEJtSnUsq=xqbEtGC2NP0Yo4vAcPkSu+Wq+Rg@mail.gmail.com>
From:   Daniel Brunner <daniel@brunner.ninja>
Date:   Wed, 9 Dec 2020 01:30:28 +0100
Message-ID: <CAD7Y51hdeJVNBAYQXxvf=kUOKh_KYX286Hzoy-qJ8izn+crVtQ@mail.gmail.com>
Subject: Re: corrupted root, doesnt check, repair or mount
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi again,

do the outputs of said commands help in finding the issue?

This corrupted fs blocks my homeserver usage and if the data is not
recoverable, i would start all over again.
I do not have enough disks to backup the current corrupted state.

Losing the data would mean about 10 years of hamstering/collecting
stuff would be lost (only some parts are backed up externally),
so if there is any chance of recovering I would keep the machine
offline until any new ideas pop up.

Best regards,
Daniel


Am Mo., 30. Nov. 2020 um 14:15 Uhr schrieb Daniel Brunner
<daniel@brunner.ninja>:
>
> Additional comment: I cannot recover the list of commands I executed
> on the mdadm and bcache back then because I used a user which's home
> is on the btrfs :)
>
> BR,
> Daniel
>
> Am Mo., 30. Nov. 2020 um 14:14 Uhr schrieb Daniel Brunner
> <daniel@brunner.ninja>:
> >
> > Hi,
> >
> > thx for the reply, here the outputs:
> >
> > # btrfs insp dump-s /dev/mapper/bcache0-open
> > superblock: bytenr=65536, device=/dev/mapper/bcache0-open
> > ---------------------------------------------------------
> > csum_type 0 (crc32c)
> > csum_size 4
> > csum 0xe29c4dff [match]
> > bytenr 65536
> > flags 0x1
> > ( WRITTEN )
> > magic _BHRfS_M [match]
> > fsid 4e970755-09c3-4df2-992d-d2f1e0b7d5e4
> > metadata_uuid 4e970755-09c3-4df2-992d-d2f1e0b7d5e4
> > label
> > generation 23991070
> > root 51642824081408
> > sys_array_size 97
> > chunk_root_generation 23971935
> > root_level 2
> > chunk_root 1064960
> > chunk_root_level 1
> > log_root 0
> > log_root_transid 0
> > log_root_level 0
> > total_bytes 29202801745920
> > bytes_used 17674898116608
> > sectorsize 4096
> > nodesize 16384
> > leafsize (deprecated) 16384
> > stripesize 4096
> > root_dir 6
> > num_devices 1
> > compat_flags 0x0
> > compat_ro_flags 0x0
> > incompat_flags 0x161
> > ( MIXED_BACKREF |
> >   BIG_METADATA |
> >   EXTENDED_IREF |
> >   SKINNY_METADATA )
> > cache_generation 23991070
> > uuid_tree_generation 23991070
> > dev_item.uuid 0b210cdb-1581-41af-b4a4-a71707f53bec
> > dev_item.fsid 4e970755-09c3-4df2-992d-d2f1e0b7d5e4 [match]
> > dev_item.type 0
> > dev_item.total_bytes 29202801745920
> > dev_item.bytes_used 19385355862016
> > dev_item.io_align 4096
> > dev_item.io_width 4096
> > dev_item.sector_size 4096
> > dev_item.devid 1
> > dev_item.dev_group 0
> > dev_item.seek_speed 0
> > dev_item.bandwidth 0
> > dev_item.generation 0
> >
> >
> >
> > # btrfs rescue super -v /dev/mapper/bcache0-open
> > All Devices:
> > Device: id = 1, name = /dev/mapper/bcache0-open
> >
> > Before Recovering:
> > [All good supers]:
> > device name = /dev/mapper/bcache0-open
> > superblock bytenr = 65536
> >
> > device name = /dev/mapper/bcache0-open
> > superblock bytenr = 67108864
> >
> > device name = /dev/mapper/bcache0-open
> > superblock bytenr = 274877906944
> >
> > [All bad supers]:
> >
> > All supers are valid, no need to recover
> >
> >
> > Am Fr., 27. Nov. 2020 um 00:55 Uhr schrieb Chris Murphy
> > <lists@colorremedies.com>:
> > >
> > > On Wed, Nov 25, 2020 at 2:16 PM Daniel Brunner <daniel@brunner.ninja> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > I used btrfs resize to shrink the filesystem and then used mdadm to
> > > > shrink the backing device.
> > > >
> > > > Sadly I did not use btrfs for the software raid itself.
> > > >
> > > > After shrinking the mdadm device, my btrfs filesystem doesnt want to
> > > > mount or repair anymore.
> > >
> > > First, make no writes to any of the drives until you understand
> > > exactly what went wrong. Any attempt to repair it without
> > > understanding the problem comes with risk of making the problem worse
> > > and not reversible.
> > >
> > > What were the exact commands, in order? Best to use the history
> > > command so we know for sure what every relevant command is.
> > >
> > > > # btrfs check --repair --force /dev/mapper/bcache0-open
> > >
> > > Yeah first mistake is to try and repair. Fortunately it looks like it
> > > couldn't get far enough along to even attempt writes.
> > >
> > > I don't know anything about bcache so I looked at this:
> > > https://wiki.archlinux.org/index.php/bcache#Resize_backing_device
> > >
> > > So the question is, what was the bcache device cache mode? Writeback
> > > or writethrough? And did you confirm that bcache reports a clean state
> > > before doing the mdadm resize?
> > >
> > > > # blockdev --getsize64 /dev/mapper/bcache0-open
> > > > 40002767544320
> > >
> > > What do you get for
> > >
> > > # btrfs insp dump-s /dev/mapper/bcache0-open
> > > # btrfs rescue super -v /dev/mapper/bcache0-open
> > >
> > > Importantly these are read only commands and make no changes.
> > >
> > >
> > > --
> > > Chris Murphy
