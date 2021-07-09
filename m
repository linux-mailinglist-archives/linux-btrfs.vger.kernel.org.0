Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360003C2101
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 10:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhGIIsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 04:48:09 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:63457 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbhGIIsH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 9 Jul 2021 04:48:07 -0400
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id 79BB94F70
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 10:45:23 +0200 (MEST)
Date:   Fri, 9 Jul 2021 10:45:23 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: Re: where is the parent of a snapshot?
Message-ID: <20210709084523.GB1548@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20210708213806.GA8249@tik.uni-stuttgart.de>
 <0f03c92b-f3c6-bab8-fa37-ef1b489e2d38@gmail.com>
 <20210709071555.GD8249@tik.uni-stuttgart.de>
 <20210709072101.GE11526@savella.carfax.org.uk>
 <20210709073731.GB582@tik.uni-stuttgart.de>
 <20210709074810.GA1548@tik.uni-stuttgart.de>
 <eb210591-3d91-72c3-783f-ccedb9ef3359@georgianit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb210591-3d91-72c3-783f-ccedb9ef3359@georgianit.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 2021-07-09 (04:09), Remi Gauvin wrote:
> On 2021-07-09 3:48 a.m., Ulli Horlacher wrote:
> 
> > 
> > So, where is subvolume uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2??
> > 
> 
> btrfs subvolume show /mnt/spool   will display what you want.  It seems
> as though the subvolume list does not include the root subvolume.

root@unifex:/# btrfs subvolume show /mnt/spool
/
        Name:                   <FS_TREE>
        UUID:                   7f010d85-b761-45e7-8d4a-453f81bb10b2
        Parent UUID:            -
        Received UUID:          -
(...)

Ahhhh!
I was using the wrong command!

root@unifex:/# btrfs filesystem show /mnt/spool
Label: none  uuid: 217ccc65-6ab9-44f0-b691-ec9bbcdd9496
        Total devices 2 FS bytes used 209.81GiB
        devid    1 size 14.55TiB used 161.02GiB path /dev/loop0
        devid    2 size 14.55TiB used 100.00GiB path /dev/loop1

The filesystem has different uuid than the root subvolume?!

This was on Ubuntu 20.04 with btrfs 5.4.1

On Ubuntu 18.04 with btrfs 4.15.1 it looks different:

root@fex:~# btrfs filesystem show /mnt/spool
Label: none  uuid: dfece157-dd48-4868-b4a3-51e539325aaa
        Total devices 1 FS bytes used 1.85TiB
        devid    1 size 14.55TiB used 1.90TiB path /dev/loop0

root@fex:~# btrfs subvolume show /mnt/spool
/
        Name:                   <FS_TREE>
        UUID:                   -
        Parent UUID:            -
        Received UUID:          -
        Creation time:          -
        Subvolume ID:           5
        Generation:             85076
        Gen at creation:        0
        Parent ID:              0
        Top level ID:           0
        Flags:                  -
        Snapshot(s):
                                .snapshot/2021-07-07_0000.daily
                                .snapshot/2021-07-08_0000.daily
                                .snapshot/2021-07-09_0000.daily
                                .snapshot/2021-07-09_0800.hourly
                                .snapshot/2021-07-09_0900.hourly
                                .snapshot/2021-07-09_1000.hourly



-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<eb210591-3d91-72c3-783f-ccedb9ef3359@georgianit.com>
