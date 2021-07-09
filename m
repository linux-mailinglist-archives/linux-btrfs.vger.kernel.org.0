Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07383C1FE6
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhGIHSk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 03:18:40 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:56835 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhGIHSk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 03:18:40 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 31DE48D99
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 09:15:56 +0200 (MEST)
Date:   Fri, 9 Jul 2021 09:15:55 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: where is the parent of a snapshot?
Message-ID: <20210709071555.GD8249@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210708213806.GA8249@tik.uni-stuttgart.de>
 <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 2021-07-09 (08:03), Andrei Borzenkov wrote:
> On 09.07.2021 00:38, Ulli Horlacher wrote:
> 
> > 
> > 
> > This is btrfs v5.4.1 on Ubuntu 20.04:
> > 
> > I have created several snapshots of the btrfs root filesystem /mnt/spool:
> > 
> > root@unifex:~# df -HT /mnt/spool
> > Filesystem     Type   Size  Used Avail Use% Mounted on
> > /dev/loop0     btrfs   32T  258G   32T   1% /mnt/spool
> > 
> > root@unifex:~# btrfs filesys show /mnt/spool
> > Label: none  uuid: 217ccc65-6ab9-44f0-b691-ec9bbcdd9496
> >         Total devices 2 FS bytes used 238.70GiB
> >         devid    1 size 14.55TiB used 161.02GiB path /dev/loop0
> >         devid    2 size 14.55TiB used 101.00GiB path /dev/loop1
> > 
> > root@unifex:~# btrfs subvolume list -q /mnt/spool
> > ID 30401 gen 193524 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_0000.daily
> > ID 30424 gen 194441 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2100.hourly
> > ID 30425 gen 194472 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2200.hourly
> > ID 30426 gen 194497 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2300.hourly
> > 
> 
> Is it really full list?

Yes, that's all!


> subvolume uuid is not shown by this command.

root@unifex:/# btrfs subvolume list -qu /mnt/spool
ID 30428 gen 194535 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid 7f044b92-d928-2f44-a880-e453feaa551d path .snapshot/2021-07-09_0000.daily
ID 30435 gen 194686 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid eeace077-5f22-c541-8fb4-f0523fd76c9e path .snapshot/2021-07-09_0700.hourly
ID 30436 gen 194715 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid 70fc8ced-7c13-f947-bab6-5354eb71483f path .snapshot/2021-07-09_0800.hourly
ID 30437 gen 194756 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid 254fcaba-9549-0244-8467-baaa3d68cb7b path .snapshot/2021-07-09_0900.hourly

root@unifex:/# btrfs version
btrfs-progs v5.4.1

My aim is to discover which directory is the parent of a snapshot. In this
particular case I know it is /mnt/spool but I want to do it by a script,
so I need a generic solution: "Directory XY is a snapshot of directory XZ"




-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
