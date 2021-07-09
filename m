Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509C93C2235
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 12:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhGIK3i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 06:29:38 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:39329 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232010AbhGIK3i (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 06:29:38 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 091A2B896
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 12:26:54 +0200 (MEST)
Date:   Fri, 9 Jul 2021 12:26:53 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: where is the parent of a snapshot?
Message-ID: <20210709102653.GC1548@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210708213806.GA8249@tik.uni-stuttgart.de>
 <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
 <20210709071555.GD8249@tik.uni-stuttgart.de>
 <20210709072101.GE11526@savella.carfax.org.uk>
 <20210709073731.GB582@tik.uni-stuttgart.de>
 <20210709074810.GA1548@tik.uni-stuttgart.de>
 <eb210591-3d91-72c3-783f-ccedb9ef3359@georgianit.com>
 <20210709084523.GB1548@tik.uni-stuttgart.de>
 <b3d67963-7bb5-2fbf-f8a0-d7712925855a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d67963-7bb5-2fbf-f8a0-d7712925855a@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 2021-07-09 (12:07), Nikolay Borisov wrote:

> > root@unifex:/# btrfs subvolume show /mnt/spool
> > /
> >         Name:                   <FS_TREE>
> >         UUID:                   7f010d85-b761-45e7-8d4a-453f81bb10b2
> >         Parent UUID:            -
> >         Received UUID:          -
> > (...)
> > 
> > root@unifex:/# btrfs filesystem show /mnt/spool
> > Label: none  uuid: 217ccc65-6ab9-44f0-b691-ec9bbcdd9496
> >         Total devices 2 FS bytes used 209.81GiB
> >         devid    1 size 14.55TiB used 161.02GiB path /dev/loop0
> >         devid    2 size 14.55TiB used 100.00GiB path /dev/loop1
> > 
> > The filesystem has different uuid than the root subvolume?!
> 
> Yes, it's been like that forever.

No:

root@fex:~# btrfs version
btrfs-progs v4.15.1

root@fex:~# btrfs subvolume show /mnt/spool
/
        Name:                   <FS_TREE>
        UUID:                   -
        Parent UUID:            -
        Received UUID:          -
        Creation time:          -
        Subvolume ID:           5
        Generation:             85112
        Gen at creation:        0
        Parent ID:              0
        Top level ID:           0
        Flags:                  -

root@fex:~# btrfs filesystem show /mnt/spool
Label: none  uuid: dfece157-dd48-4868-b4a3-51e539325aaa
        Total devices 1 FS bytes used 1.85TiB
        devid    1 size 14.55TiB used 1.90TiB path /dev/loop0

There is no UUID on the root subvolume!

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<b3d67963-7bb5-2fbf-f8a0-d7712925855a@suse.com>
