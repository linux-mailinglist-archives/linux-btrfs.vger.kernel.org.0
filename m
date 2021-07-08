Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1BF3C1B30
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 23:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhGHVrs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 17:47:48 -0400
Received: from smtp02.belwue.de ([129.143.71.87]:46991 "EHLO smtp02.belwue.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhGHVrr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 8 Jul 2021 17:47:47 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 17:47:47 EDT
Received: from fex.rus.uni-stuttgart.de (fex.rus.uni-stuttgart.de [129.69.1.129])
        by smtp02.belwue.de (Postfix) with SMTP id AD812522F
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jul 2021 23:38:07 +0200 (MEST)
Date:   Thu, 8 Jul 2021 23:38:06 +0200
From:   Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To:     linux-btrfs@vger.kernel.org
Subject: where is the parent of a snapshot?
Message-ID: <20210708213806.GA8249@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



This is btrfs v5.4.1 on Ubuntu 20.04:

I have created several snapshots of the btrfs root filesystem /mnt/spool:

root@unifex:~# df -HT /mnt/spool
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/loop0     btrfs   32T  258G   32T   1% /mnt/spool

root@unifex:~# btrfs filesys show /mnt/spool
Label: none  uuid: 217ccc65-6ab9-44f0-b691-ec9bbcdd9496
        Total devices 2 FS bytes used 238.70GiB
        devid    1 size 14.55TiB used 161.02GiB path /dev/loop0
        devid    2 size 14.55TiB used 101.00GiB path /dev/loop1

root@unifex:~# btrfs subvolume list -q /mnt/spool
ID 30401 gen 193524 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_0000.daily
ID 30424 gen 194441 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2100.hourly
ID 30425 gen 194472 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2200.hourly
ID 30426 gen 194497 top level 5 parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2 path .snapshot/2021-07-08_2300.hourly


I have expected to see the parent_uuid as the uuid of the root subvolume.
Where is parent_uuid 7f010d85-b761-45e7-8d4a-453f81bb10b2?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK         
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    http://www.tik.uni-stuttgart.de/
REF:<20210708213806.GA8249@tik.uni-stuttgart.de>
