Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81249FA43
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 14:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiA1NBD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 08:01:03 -0500
Received: from mout.gmx.net ([212.227.17.22]:49397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237938AbiA1NBD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 08:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643374861;
        bh=l9F6Ki7bV2fu9N3gDWqoe1cYKCzIIzZeGP8s+e9x/Ew=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=FKPq1XhftyxsYbwYypDECeQbPz7Xxgr2v1YsdEsPE5ZGg2kjvnkeVg20LEQiyioNY
         vbwTTYyDM2MEGMz917zPikziIDUJAEOQhHGRYTxtIfNVpr4wPJO01pVK+AjLO+pNns
         jpZcgwHjSFiQkHME9EoXMrXXjeGDs0yzBTLtHnAk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5QFB-1nEGDZ2flF-001PA9; Fri, 28
 Jan 2022 14:01:01 +0100
Message-ID: <1e7359dd-c021-0773-fb65-752fb7b6ac49@gmx.com>
Date:   Fri, 28 Jan 2022 21:00:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Kai Krakow <hurikhan77+btrfs@gmail.com>, piorunz <piorunz@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com>
 <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
In-Reply-To: <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xpw0/ui6S5E1NGWetSOxkLvO9IBJk9QRAOMn4QKCAXIUo9AxUlV
 pUpy5LmfRl0mbSeut8HsrgBtBpCLE/XfZIg95PLbJ+8I5GzZ1B6xcixzKuauc+p2WciH2Qb
 l7CN9C1qlnvrCMZOEdR9/iAxj6hJEiUhvXn0e68n1eNxnpI5s4slDqG2XGOFQl1Ezk2NR3Y
 wghM1fsJuagjrVtExqokA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qEEQn+bRskA=:N6JwC/nHwAoHjkcRP5hxTI
 lywcc9CAStJzAHy+O9jHn3jtUPFjDZNAR5LDyX7se/xnsjzeg/gTg23s9qnmYhAxM/bs9ZcpX
 75yIbDhJNIXoBfUBh+zc9mzDv2LpcoGsMR+BzrwVMT+s9yovljiGjKPWMHFZ7kOXpik8g0SCd
 PNSQX9dhDXahnMf47jqBnnYjPxBAIaHZ4az3GBHP0nRwnOfAAwd+01JAT4vfvMVtoMTga6PME
 4XBdbO/hsrELYTXhZZpE74uIiiuXOX6Opcmeols2mZ91mcPSzg/rMiKHLBmy3Ge8J7/3YlP/Y
 l2kEmd9Z7GDQfStw7cK2hQYm7Baq8gGUcdo9nyVpHNM+gAN02Kyg8AfXRMv5GA5nTOiPg6vLR
 50aJSa9I9zKmplw4S4+SbqZclYyyVChfcc17O2yBPMu0ieJsEu4wmU5IyU7ni03barr24t84D
 mTrwB7OGeBjusTBQVNDdN6gqpO3VBhksef+wDNbiZUbPIH+pIbsVocstlvahJrqS1/XtcXJ26
 z+R+VydNQ4aWhi4OG1dMKlMB7FdPJyFYiP42upTEC90frlUbfz+T0bbysk0j6m68GbTxmhDQg
 mDbt2LqRM07Djov4l8DTtmZlwaRAm1k7tpKvsiSa7CWVSNJRWUsZyOUP2xZGR10KL7f2OaiKY
 +IlxZ/fX2/8LxeJJSE6/T/w49ZMLHjZVzeIonrNXcqGRtaEqlnNYy8Ff4uc6omFMPOAqb7MX4
 ZU3+/N9RB6/XM1VM5Pgz8ujgTArb+XxOyYvgi2M0fr6ogs9a7KCEZgyraJwC6cxcQvwiGU31l
 htJHXHdSH8x+mz+W9Uke0kIpr703RBShHJmZH1tlUjYWRwxGPZtDqoQxlJnTvpBFn0O+13C31
 Qti5f6Xh2cktiP2a2N/jptisOsXJ1Zw7EPQu4vLYyP4sLgaIX3fSZPgz2xaJQHgfI3PF0kIYY
 pHGeW/DxtrjLU3PTfLA3Rt8YnOLvauAX4Iqiy67JGrfciQW98AB9q2Kd0np0qWeu+Ekos6kdn
 BLjzudB6IVhdNeqz7rqUQJgZ35vrXqJVvjMRczpJ0WRj+v5OTx4mYqjlLGqJhXNBEPnu5vjra
 qdX2/wOkl9CzCI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/28 19:55, Kai Krakow wrote:
> Hi!
>
> Am Fr., 28. Jan. 2022 um 08:51 Uhr schrieb piorunz <piorunz@gmx.com>:
>
>> Is it safe & recommended to run autodefrag mount option in fstab?
>
> I've tried autodefrag a few times, and usually it caused btrfs to
> explode under some loads (usually databases and VMs), ending in
> invalid tree states, and after reboot the FS was unmountable. This may
> have changed meanwhile (last time I tried was in the 5.10 series).
> YMMV. Run and test your backups.

Mind to share more details?

"Run and test your backups" is always a good principle, but a shame to a
fs developer.

It's better to be sure the problems you hit is already fixed, especially
we're already doing bug hunts in defrag code recently, don't let the
chance escape.

>
>
>> I am considering two machines here, normal desktop which has Btrfs as
>> /home, and server with VM and other databases also btrfs /home. Both
>> Btrfs RAID10 types. Both are heavily fragmented. I never defragmented
>> them, in fact. I run Debian 11 on server (kernel 5.10) and Debian
>> Testing (kernel 5.15) on desktop.
>
> Database and VM workloads are not well suited for btrfs-cow. I'd
> consider using `chattr +C` on the directories storing such data, then
> backup the contents, purge the directory empty, and restore the
> contents, thus properly recreating the files in nocow mode. This
> allows the databases and VMs to write data in-place. You're losing
> transactional guarantees and checksums but at least for databases,
> this is probably better left to the database itself anyways. For VMs
> it depends, usually the embedded VM filesystem running in the images
> should detect errors properly. That said, qemu qcow2 works very well
> for me even with cow but I disabled compression (`chattr +m`) for the
> images directory ("+m" is supported by recent chattr versions).

This may be off-topic as it's not defrag related anymore, but I have
some crazy ideas like forced full block range compression for such files.

Like even if you just dirtied one byte of such file (which has something
like forced_rewrite_block_size=3D16K), then the whole 16K aligned range
will be re-dirtied, and forced to be written back (and forced to be
compressed if it can).

By this, the behavior is still CoW, thus it has csum/compression, and
the extra IO overhead may be saved by compression.

And the on-disk file extents will no longer have cases like CoWed in the
middle of a larger extents, thus has some benefit of nodatacow.

For now it's just one of my wild dreams, and not any benchmark/prototype
to back my dream...

Thanks,
Qu
>
>
>> Running manual defrag on server machine, like:
>> sudo btrfs filesystem defrag -v -t4G -r /home
>> takes ages and can cause 120 second timeout kernel error in dmesg due t=
o
>> service timeouts. I prefer to autodefrag gradually, overtime, mount
>> option seems to be good for that.
>
> This is probably the worst scenario you can create: forcing
> compression forces extents to be no bigger than 128k, which in turn
> increases IO overhead, and encourages fragmentation a lot. Since you
> are forcing compression, setting a target size of 4G probably does
> nothing, your extents will end up with 128k size.
>
> I also found that depending on your workload, RAID10 may not be
> beneficial at all because IO will always engage all spindles. In a
> multi-process environment, a non-striping mode may be better (e.g.
> RAID1). The high fragmentation would emphasize this bottleneck a lot.
>
>
>> My current fstab mounting:
>>
>> noatime,space_cache=3Dv2,compress-force=3Dzstd:3 0 2
>>
>> Will autodefrag break COW files? Like I copy paste a file and I save
>> space, but defrag with destroy this space saving?
>
> Yes, it will. You could run the bees daemon instead to recombine
> duplicate extents. It usually gives better space savings than forcing
> compression. Using forced compression is probably only useful for
> archive storage, or when every single byte counts.
>
>
>> Also, will autodefrag compress files automatically, as mount option
>> enforces (compress-force=3Dzstd:3)?
>
> It should, but I never tried. Compression is usually only skipped for
> very small extents (when it wouldn't save a block), or for inline
> extents. If you run without forced compression, a heuristic is used
> for whether compressing an extent.
>
>
> Regards,
> Kai
