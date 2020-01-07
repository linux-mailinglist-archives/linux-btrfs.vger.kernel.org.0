Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A283132036
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2020 08:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgAGHJN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jan 2020 02:09:13 -0500
Received: from naboo.endor.pl ([91.194.229.149]:60444 "EHLO naboo.endor.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgAGHJN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Jan 2020 02:09:13 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by naboo.endor.pl (Postfix) with ESMTP id 0EB671A184A;
        Tue,  7 Jan 2020 08:09:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from naboo.endor.pl ([91.194.229.149])
        by localhost (naboo.endor.pl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J1iSRlELpsaR; Tue,  7 Jan 2020 08:09:10 +0100 (CET)
Received: from [192.168.1.16] (aaeh140.neoplus.adsl.tpnet.pl [83.4.111.140])
        (Authenticated sender: leszek@dubiel.pl)
        by naboo.endor.pl (Postfix) with ESMTPSA id C92121A1849;
        Tue,  7 Jan 2020 08:09:10 +0100 (CET)
Subject: Re: very slow "btrfs dev delete" 3x6Tb, 7Tb of data
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <879f2f45-f738-da74-9e9c-b5a7061674b6@dubiel.pl>
 <0354c266-5d50-51b1-a768-93a78e0ddd51@gmx.com>
 <09ec71c0-e3c2-8bb5-acaf-0317e7204ca9@dubiel.pl>
 <6058c4c4-fcb3-c7cd-6517-10b5908b34da@georgianit.com>
 <602a4895-f2f7-f024-c312-d880f12e1360@dubiel.pl>
 <CAJCQCtQEpXvgbs+Y0+A4cLZUft3oqp+sLW8xVPfxt2aqYhMj_g@mail.gmail.com>
 <2c135c87-d01b-53f1-9f76-a5653918a4e7@dubiel.pl>
 <cc364577-1bb8-1512-4d2e-dc7e465ca2d6@dubiel.pl>
 <20191228202344.GE13306@hungrycats.org>
 <c278f501-f5a5-c905-5431-2d735e97fa13@dubiel.pl>
 <CAJCQCtRvAZS1CNgJLdUZTNeUma6A74oPT-SeQe7NYHhXKrMzoA@mail.gmail.com>
 <4aff5709-5644-daa8-08b9-94dcefe65b19@dubiel.pl>
 <CAJCQCtT13m+k4aWWmmj_ysLpmr7U_5dKOowEy8JuSJKaBfM1Rg@mail.gmail.com>
From:   Leszek Dubiel <leszek@dubiel.pl>
Message-ID: <fddb956a-2a0c-6eee-9988-f2de709ff9e1@dubiel.pl>
Date:   Tue, 7 Jan 2020 08:09:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJCQCtT13m+k4aWWmmj_ysLpmr7U_5dKOowEy8JuSJKaBfM1Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl-PL
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


 >> # reduce slack
 >> root@zefir:~# btrfs fi resize 4:max /
 >> Resize '/' of '4:max'
 >> root@zefir:~# btrfs dev usage /
 >> ...
 >> /dev/sdb3, ID: 4
 >>     Device size:             1.80TiB
 >>     Device slack:            3.50KiB <<<<<<<<<<<<<<<<<<<<
 >
 > Maybe the partition isn't aligned on a 4KiB boundary? *shrug*

Yes... this is old partition table.




 > But yeah one gotcha with 'btrfs replace' is that the replacement must
 > be equal to or bigger than the drive being replaced; and once
 > complete, the file system is not resized to fully utilize the
 > replacement drive.

 From my "user view" it is ok. After device replace was finished there 
was slack = 1.7GiB.
Then I resised to max, and slack got down to 3.5KiB.



 > That's intentional because by default you may want
 > allocations to have the same balance as with the original device. If
 > you resize to max, Btrfs will favor allocations to the drive with the
 > most free space.

That's perfect.





 >> Jan  5 13:52:09 zefir kernel: [1291932.446093] BTRFS warning (device
 >> sdc1): i/o error at logical 11658111352832 on dev /dev/sde1, physical
 >> 867246145536: metadata leaf (level 0) in tree 9109477097472
 >
 > Ahh yeah I see what you mean. I think that's confusing also. The error
 > is on sde1. But I guess why sdc1 is reported first is probably to do
 > with the device the kernel considers mounted, there's not really a
 > good facility (or maybe it's in the newer VFS mount code, not sure)
 > for showing two devices mounted on a single mount point.

Uhhh... you're right -- sdc1 is shown as mounted filesystem. Thank you.
I didn't see this detail at first, I thought information about sdc1 
comes from BTRFS and not kernel mount.

root@zefir:~# mount | egrep sdc
/dev/sdc1 on / type btrfs 
(rw,relatime,space_cache,subvolid=83043,subvol=/zefir)

root@zefir:~# cat /etc/fstab | egrep /
UUID=9d6e641c-ec71-411e-9312-f1f67a70913f  /          btrfs 
defaults,subvol=/zefir  0   0

root@zefir:~# blkid | egrep 0913f
/dev/sdb3: UUID="9d6e641c-ec71-411e-9312-f1f67a70913f" 
UUID_SUB="e9eb3d18-2d87-479a-808d-74d61903196c" TYPE="btrfs" 
PARTUUID="c1befd42-e38c-be48-b8df-4301fa1d3b07"
/dev/sda1: UUID="9d6e641c-ec71-411e-9312-f1f67a70913f" 
UUID_SUB="8bcae5cb-b3a5-4fd8-9284-602203f2a43e" TYPE="btrfs"
/dev/sdc1: UUID="9d6e641c-ec71-411e-9312-f1f67a70913f" 
UUID_SUB="fb7055ef-6ae7-48e0-8f09-a315fc20f399" TYPE="btrfs"
/dev/sdf1: UUID="9d6e641c-ec71-411e-9312-f1f67a70913f" 
UUID_SUB="5e38a881-9b21-4a35-a1bb-889095b32254" TYPE="btrfs"
/dev/sdd1: UUID="9d6e641c-ec71-411e-9312-f1f67a70913f" 
UUID_SUB="1d776ab6-3ef2-4fe1-8026-78b6d87f85c1" TYPE="btrfs"





 >> [/dev/sda1].write_io_errs    10418
 >> [/dev/sda1].read_io_errs     227
 >> [/dev/sda1].flush_io_errs    117
 >> [/dev/sda1].corruption_errs  77
 >> [/dev/sda1].generation_errs  47
 >
 > This isn't good either. I'd keep an eye on that. read errors can be
 > fixed up if there's a good copy, Btrfs will use the good copy and
 > overwrite the bad sector, *if* SCT ERC is lower duration than SCSI
 > command timer. But write and flush errors are bad. You need to find
 > out what that's about.

This was about wrong cable.
Cable was replaced. SCT ERC workarouds installed.

I would like to reset counters to ZERO... if it is possible (?).


