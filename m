Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C0B170179
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 15:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBZOpf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 09:45:35 -0500
Received: from mail.dubielvitrum.pl ([91.194.229.150]:43279 "EHLO
        naboo.endor.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727322AbgBZOpf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 09:45:35 -0500
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2020 09:45:33 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id D199B1A10C7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 15:36:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Vgxi2Iofq5vb for <linux-btrfs@vger.kernel.org>;
        Wed, 26 Feb 2020 15:36:51 +0100 (CET)
Received: from [192.168.18.35] (91-231-23-50.studiowik.net.pl [91.231.23.50])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id ACDCB1A0EAE
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 15:36:51 +0100 (CET)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
From:   Leszek Dubiel <leszek@dubiel.pl>
Subject: Newly added disks not used after "soft" rebalance, not used after
 rebalance < 1%
Message-ID: <cc151941-15c1-b15f-04ba-a2085724aa10@dubiel.pl>
Date:   Wed, 26 Feb 2020 15:36:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Added /dev/sdb3, /dev/sdd3 and /dev/sdf3 to btrfs filesystem:


Label: none  uuid: 44803366-3981-4ebb-853b-6c991380c8a6
     Total devices 6 FS bytes used 8.20TiB
     devid    2 size 5.45TiB used 4.36TiB path /dev/sda2
     devid    3 size 5.45TiB used 4.36TiB path /dev/sdc2
     devid    4 size 10.90TiB used 8.71TiB path /dev/sde3
     devid    5 size 9.06TiB used 0.00B path /dev/sdb3 <<<
     devid    6 size 5.43TiB used 0.00B path /dev/sdd3 <<<<
     devid    7 size 3.61TiB used 0.00B path /dev/sdf3 <<<<



Filessytem df looks good 20T of filesystem:

root@wawel:~# df -h /
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda2        20T  8.3T  9.2T  48% /



But disks seem to be NOT used by btrfs:

root@wawel:~# btrfs dev usag /
/dev/sda2, ID: 2
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,RAID1:              4.28TiB
    Metadata,RAID1:         89.00GiB
    Unallocated:             1.09TiB

/dev/sdb3, ID: 5
    Device size:             9.06TiB   <<<<  no data usage?
    Device slack:            3.50KiB
    Unallocated:             9.06TiB

/dev/sdc2, ID: 3
    Device size:             5.45TiB
    Device slack:              0.00B
    Data,RAID1:              4.28TiB
    Metadata,RAID1:         83.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             1.09TiB

/dev/sdd3, ID: 6
    Device size:             5.43TiB <<<<<<<<????
    Device slack:            3.50KiB
    Unallocated:             5.43TiB

/dev/sde3, ID: 4
    Device size:            10.90TiB
    Device slack:            3.50KiB
    Data,RAID1:              8.55TiB
    Metadata,RAID1:        162.00GiB
    System,RAID1:           32.00MiB
    Unallocated:             2.19TiB

/dev/sdf3, ID: 7
    Device size:             3.61TiB   <????
    Device slack:            3.50KiB
    Unallocated:             3.61TiB



Newly added disks seemed not to be used... So I've done:

btrfs balance start -dconvert=raid1,soft -mconvert=raid1,soft /


It didn't help. So I used:



root@wawel:~# btrfs balance start -dusage=0 -musage=0 /
Done, had to relocate 0 out of 9050 chunks


then:


root@wawel:~# btrfs balance start -dusage=1 -musage=1 /
Done, had to relocate 106 out of 9050 chunks



And I still don't see any usage of the devices...


Shall I activate these newly added block devices somehow?
Those 106 reallocated chunks should have been put to new devices, right?


Thank you.


