Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AD2EF399
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Jan 2021 15:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbhAHOA7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 8 Jan 2021 09:00:59 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38826 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbhAHOA7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Jan 2021 09:00:59 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id A166992E765; Fri,  8 Jan 2021 09:00:17 -0500 (EST)
Date:   Fri, 8 Jan 2021 09:00:17 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Cedric.dewijs@eclipso.eu
Cc:     Andrea Gelmini <andrea.gelmini@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize
 the SSD?
Message-ID: <20210108140017.GA31381@hungrycats.org>
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
 <CAK-xaQZS+ANoD+QbPTHwL-ErapA-7PDZe_z=OOWq_axAyR1KfA@mail.gmail.com>
 <eb0f5e05a563009af95439f446659cf3@mail.eclipso.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <eb0f5e05a563009af95439f446659cf3@mail.eclipso.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 08, 2021 at 09:36:13AM +0100,   wrote:
> 
> --- Ursprüngliche Nachricht ---
> Von: Andrea Gelmini <andrea.gelmini@gmail.com>
> Datum: 08.01.2021 09:16:26
> An: Cedric.dewijs@eclipso.eu
> Betreff: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize the SSD?
> 
> Il giorno mar 5 gen 2021 alle ore 07:44 <Cedric.dewijs@eclipso.eu>
> ha scritto:
> >
> > Is there a way to tell btrfs to leave the slow hdd alone, and to prioritize
> the SSD?
> 
> You can use mdadm to do this (I'm using this feature since years in
> setup where I have to fallback on USB disks for any reason).
> 
> >From manpage:
> 
>        -W, --write-mostly
>               subsequent  devices  listed in a --build, --create, or
> --add command will be flagged as 'write-mostly'.  This is valid for
>               RAID1 only and means that the 'md' driver will avoid
> reading from these devices if at all possible.  This can be useful if
>               mirroring over a slow link.
> 
>        --write-behind=
>               Specify  that  write-behind  mode  should be enabled
> (valid for RAID1 only).  If an argument is specified, it will set the
>               maximum number of outstanding writes allowed.  The
> default value is 256.  A write-intent bitmap is required  in  order
> to
>               use write-behind mode, and write-behind is only
> attempted on drives marked as write-mostly.
> 
> So you can do this:
> (be carefull, this wipe your data)
> 
> mdadm --create --verbose --assume-clean /dev/md0 --level=1
> --raid-devices=2 /dev/sda1 --write-mostly /dev/sdb1
> 
> Then you use BTRFS on top of /dev/md0, after mkfs.btrfs, of course.
> 
> Ciao,
> Gelma
> 
> Thanks Gelma.
> 
> What happens when I poison one of the drives in the mdadm array using
> this command? Will all data come out OK?
> dd if=/dev/urandom of=/dev/dev/sdb1 bs=1M count = 100?

mdadm doesn't handle data corruption, and (except for a /sys counter),
reads from mirror devices interchangeably, and silently propagates
data between devices during resync, so the array will almost certainly
be destroyed.

> When I do this test on a plain btrfs raid 1 with 2 drives, all the data
> comes out OK (while generating a lot of messages about correcting data
> in dmesg -w)
> 
> Cheers,
> Cedric
> 
> ---
> 
> Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!
> 
> 
