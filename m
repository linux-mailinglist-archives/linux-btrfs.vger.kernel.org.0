Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63422C2BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 12:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGXKFC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 06:05:02 -0400
Received: from [195.174.65.42] ([195.174.65.42]:23711 "EHLO
        hosting1.nurettinalp.info" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgGXKFC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 06:05:02 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jul 2020 06:05:01 EDT
Received: from localhost (localhost [127.0.0.1])
        by hosting1.nurettinalp.info (Postfix) with ESMTP id E64ADA1E8C
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 12:58:41 +0300 (+03)
X-Virus-Scanned: Debian amavisd-new at server1.nurettinalp.info
Received: from hosting1.nurettinalp.info ([127.0.0.1])
        by localhost (hosting1.nurettinalp.info [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fz4l6pJ5d3mU for <linux-btrfs@vger.kernel.org>;
        Fri, 24 Jul 2020 12:58:37 +0300 (+03)
Received: from www.nurettinalp.com (localhost [IPv6:::1])
        by hosting1.nurettinalp.info (Postfix) with ESMTP id E4C35A1E6A
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 12:58:36 +0300 (+03)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 24 Jul 2020 09:58:36 +0000
From:   nurettin@nurettinalp.com
To:     linux-btrfs@vger.kernel.org
Subject: btrfs repair
Message-ID: <9ae782644c2b9b24485411a512a2ec08@nurettinalp.com>
X-Sender: nurettin@nurettinalp.com
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

which commands repair my btrfs filesystem. thank you.


mdadm -D /dev/md2
/dev/md2:
            Version : 1.2
      Creation Time : Tue Mar 10 18:53:32 2020
         Raid Level : linear
         Array Size : 21455548416 (20461.61 GiB 21970.48 GB)
       Raid Devices : 4
      Total Devices : 4
        Persistence : Superblock is persistent

        Update Time : Wed Jul 22 13:20:52 2020
              State : clean
     Active Devices : 4
    Working Devices : 4
     Failed Devices : 0
      Spare Devices : 0

           Rounding : 64K

Consistency Policy : none

               Name : n0:2
               UUID : fb2b1053:b63f9733:6a34de1b:8a5b6fcd
             Events : 54

     Number   Major   Minor   RaidDevice State
        0       8       19        0      active sync   /dev/sdb3
        1       8       35        1      active sync   /dev/sdc3
        2       8       51        2      active sync   /dev/sdd3
        3       8       67        3      active sync   /dev/sde3


root@ubuntu:~# btrfs fi show
Label: '2020.03.10-18:55:12 v23739'  uuid: 
79471a21-005a-4b82-bc30-42357b9f4105
	Total devices 1 FS bytes used 13.85TiB
	devid    1 size 19.98TiB used 14.28TiB path /dev/mapper/vg1-volume_1


root@ubuntu:~# mount /dev/vg1/volume_1 ./btrfs/
mount: /root/btrfs: wrong fs type, bad option, bad superblock on 
/dev/mapper/vg1-volume_1, missing codepage or helper program, or other 
error.

btrfs-find-root /dev/vg1/volume_1

Couldn't setup extent tree
Couldn't setup device tree
Superblock thinks the generation is 239232
Superblock thinks the level is 1
...........................
Well block 4139877171200(gen: 20533 level: 1) seems good, but 
generation/level doesn't match, want gen: 239232 level: 1
Well block 4139850039296(gen: 20532 level: 1) seems good, but 
generation/level doesn't match, want gen: 239232 level: 1
Well block 4085098168320(gen: 20407 level: 1) seems good, but 
generation/level doesn't match, want gen: 239232 level: 1
Well block 4085102346240(gen: 20388 level: 0) seems good, but 
generation/level doesn't match, want gen: 239232 level: 1
Well block 4030345101312(gen: 20292 level: 1) seems good, but 
generation/level doesn't match, want gen: 239232 level: 1
Well block 4030324768768(gen: 20291 level: 1) seems good, but 
generation/level doesn't match, want gen: 239232 level: 1
Well block 4030343970816(gen: 20272 level: 0) seems good, but 
generation/level doesn't match, want gen: 239232 level: 1

