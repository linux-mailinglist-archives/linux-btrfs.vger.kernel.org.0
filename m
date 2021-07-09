Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911CF3C200C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 09:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhGIHek (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 03:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhGIHej (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 03:34:39 -0400
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97C4C0613DD
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 00:31:56 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1m1kon-0004Ri-OR
        for linux-btrfs@vger.kernel.org; Fri, 09 Jul 2021 08:21:01 +0100
Date:   Fri, 9 Jul 2021 08:21:01 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     linux-btrfs@vger.kernel.org
Subject: Re: where is the parent of a snapshot?
Message-ID: <20210709072101.GE11526@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs@vger.kernel.org
References: <20210708213806.GA8249@tik.uni-stuttgart.de>
 <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
 <20210709071555.GD8249@tik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709071555.GD8249@tik.uni-stuttgart.de>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

   Try adding -a to the options. That should list all of the subvols on
the filesystem.

   Hugo.

On Fri, Jul 09, 2021 at 09:15:55AM +0200, Ulli Horlacher wrote:
> On Fri 2021-07-09 (08:03), Andrei Borzenkov wrote:
> > On 09.07.2021 00:38, Ulli Horlacher wrote:
> > 
> > > 
> > > 
> > > This is btrfs v5.4.1 on Ubuntu 20.04:
> > > 
> > > I have created several snapshots of the btrfs root filesystem /mnt/spool:
> > > 
> > > root@unifex:~# df -HT /mnt/spool
> > > Filesystem     Type   Size  Used Avail Use% Mounted on
> > > /dev/loop0     btrfs   32T  258G   32T   1% /mnt/spool
> > > 
> > > root@unifex:~# btrfs filesys show /mnt/spool
> > > Label: none  uuid: 217ccc65-6ab9-44f0-b691-ec9bbcdd9496
> > >         Total devices 2 FS bytes used 238.70GiB
> > >         devid    1 size 14.55TiB used 161.02GiB path /dev/loop0
> > >         devid    2 size 14.55TiB used 101.00GiB path /dev/loop1
> > > 
> > > root@unifex:~# btrfs subvolume list -q /mnt/spool
> > > ID 30401 gen 193524 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_0000.daily
> > > ID 30424 gen 194441 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2100.hourly
> > > ID 30425 gen 194472 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2200.hourly
> > > ID 30426 gen 194497 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2300.hourly
> > > 
> > 
> > Is it really full list?
> 
> Yes, that's all!
> 
> 
> > subvolume uuid is not shown by this command.
> 
> root@unifex:/# btrfs subvolume list -qu /mnt/spool
> ID 30428 gen 194535 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid 7f044b92-d928-2f44-a880-e453feaa551d path .snapshot/2021-07-09_0000.daily
> ID 30435 gen 194686 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid eeace077-5f22-c541-8fb4-f0523fd76c9e path .snapshot/2021-07-09_0700.hourly
> ID 30436 gen 194715 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid 70fc8ced-7c13-f947-bab6-5354eb71483f path .snapshot/2021-07-09_0800.hourly
> ID 30437 gen 194756 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 uuid 254fcaba-9549-0244-8467-baaa3d68cb7b path .snapshot/2021-07-09_0900.hourly
> 
> root@unifex:/# btrfs version
> btrfs-progs v5.4.1
> 
> My aim is to discover which directory is the parent of a snapshot. In this
> particular case I know it is /mnt/spool but I want to do it by a script,
> so I need a generic solution: "Directory XY is a snapshot of directory XZ"
> 
> 
> 
> 

-- 
Hugo Mills             | Modern medicine does not treat causes: headaches are
hugo@... carfax.org.uk | not caused by a paracetamol deficiency.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
