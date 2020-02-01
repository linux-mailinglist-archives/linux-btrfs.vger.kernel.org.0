Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F214FA91
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Feb 2020 21:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgBAU4W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Feb 2020 15:56:22 -0500
Received: from mail.nethype.de ([5.9.56.24]:41611 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgBAU4W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 1 Feb 2020 15:56:22 -0500
X-Greylist: delayed 949 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Feb 2020 15:56:21 EST
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1ixzZ9-003oqe-ME
        for linux-btrfs@vger.kernel.org; Sat, 01 Feb 2020 20:40:31 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1ixzZ9-0001a0-Gk
        for linux-btrfs@vger.kernel.org; Sat, 01 Feb 2020 20:40:31 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1ixzZ9-0001BT-GP
        for linux-btrfs@vger.kernel.org; Sat, 01 Feb 2020 21:40:31 +0100
Date:   Sat, 1 Feb 2020 21:40:31 +0100
From:   Marc Lehmann <schmorp@schmorp.de>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs wrongly reports 0 space available in 5.4.15
Message-ID: <20200201204031.GA4203@schmorp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I upgraded one machine from 5.2.21 to 5.4.15, and one (freshly-created)
btrfs filesystem wrongly shows 0 avail in df after writing a bit of data:

   Filesystem               Size  Used Avail Use% Mounted on
   /dev/mapper/vg_ssd-data  6.5G  160M     0 100% /ssd

When at the same time, the filesystem should claim gobs of free space
(the df output corresponds to a time a bit earlier when not all data was
written yet):

   Overall:
       Device size:                           6.00GiB
       Device allocated:                      0.63GiB
       Device unallocated:                    5.37GiB
       Device missing:                        0.00GiB
       Used:                                  0.22GiB
       Free (estimated):                      5.77GiB      (min: 5.77GiB)
       Data ratio:                               1.00
       Metadata ratio:                           1.00
       Global reserve:                        0.00GiB      (used: 0.00GiB)

   Data,single: Size:0.62GiB, Used:0.22GiB
      /dev/mapper/vg_ssd-data         0.62GiB

   Metadata,single: Size:0.01GiB, Used:0.00GiB
      /dev/mapper/vg_ssd-data         0.01GiB

   System,single: Size:0.00GiB, Used:0.00GiB
      /dev/mapper/vg_ssd-data         0.00GiB

   Unallocated:
      /dev/mapper/vg_ssd-data         5.37GiB

This didn't happen under 5.2.21 for me, obviously.

Deleting some files makes the remaining space appear again, creating
them again changes to 0 free. I retried with a 76G partition but had
essentially the same results.

Only df output seems affected, the fs is still writable (I only realized
because apt told me the disk was full - the fs only stores apt package
lists and the apt cache).

When writing, this switch to 0 free happens suddenly (example with bigger
partition):

   /dev/mapper/vg_ssd-data   76G  3.9M   76G   1% /ssd
   /dev/mapper/vg_ssd-data   76G  3.9M   76G   1% /ssd
   /dev/mapper/vg_ssd-data   76G  122M   76G   1% /ssd
   /dev/mapper/vg_ssd-data   76G  201M     0 100% /ssd
   /dev/mapper/vg_ssd-data   76G  244M     0 100% /ssd

Mount options are noatime,nossd,discard.

I see there were multiple reports for this and some discussion in december
(https://www.spinics.net/lists/linux-btrfs/msg95694.html), but apparently
nothing came of it and the bug still persists.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
