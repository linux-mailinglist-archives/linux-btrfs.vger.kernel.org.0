Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF91948F2D7
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jan 2022 00:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiANXJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jan 2022 18:09:18 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:41895 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229533AbiANXJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jan 2022 18:09:17 -0500
X-Sender-Id: 9wt3zsp42r|x-authuser|pete@petezilla.co.uk
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0F4362C0C81;
        Fri, 14 Jan 2022 23:09:15 +0000 (UTC)
Received: from kamino.krystal.uk (unknown [127.0.0.6])
        (Authenticated sender: 9wt3zsp42r)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9EC162C0BAC;
        Fri, 14 Jan 2022 23:09:13 +0000 (UTC)
X-Sender-Id: 9wt3zsp42r|x-authuser|pete@petezilla.co.uk
Received: from kamino.krystal.uk (kamino.krystal.uk [77.72.1.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.115.218.19 (trex/6.4.3);
        Fri, 14 Jan 2022 23:09:14 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: 9wt3zsp42r|x-authuser|pete@petezilla.co.uk
X-MailChannels-Auth-Id: 9wt3zsp42r
X-Sponge-Reign: 7ec35efa5d48b2ab_1642201754787_4013213654
X-MC-Loop-Signature: 1642201754786:4160496549
X-MC-Ingress-Time: 1642201754786
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=petezilla.co.uk; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gra6nX/EWxBofETI9Pi3XpqlNqvD27tY0P6dKJFL2Oc=; b=XxC6MIvxwv9syTMykUyhiI/JIH
        ntFhf3v3aduBxlw+T0jkK9G+LhkKsyaNfCD5qFVayVnowIPpXhrX/qBUgVsZ6iRq/ZTE12H0XclZS
        HU/8U8EOyMKaFg65T416V3Gg4dggRJcQG5ZAfW/hRvDnkF8egj+oJ95Kzru03sD5hjlx7vkTEf2EF
        dw5b5Bw2XS9+PnTF7ldSinFAiZUT2FjmQYR8qE5/xR6l5+MqLh82LqlVHSccoPap8fYGX1sFejuPa
        hFEmnbF+wjECJ9vzgvFI1tjqQPWXobvvmLa60LiRmptkyOHjxlmUbG4vSkxqGVhAyWAzDypH1HgTm
        ISgcCU/g==;
Received: from cpc75872-ando7-2-0-cust919.15-1.cable.virginm.net ([86.13.79.152]:54152 helo=[172.16.100.1])
        by kamino.krystal.uk with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <pete@petezilla.co.uk>)
        id 1n8Vh0-000DKT-G0; Fri, 14 Jan 2022 23:09:10 +0000
Message-ID: <ed95c0e2-3029-45d0-c039-a275037d8bf4@petezilla.co.uk>
Date:   Fri, 14 Jan 2022 23:09:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: ENOSPC on file system with nearly empty 12TB drive
Content-Language: en-US
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b717a01c-c152-97e9-5485-2f0a95a5d4f5@petezilla.co.uk>
 <CAJCQCtTexbZf0TTPsW1Rd-nmooNvsT+MbT1AYZX66WeDeB-5SA@mail.gmail.com>
From:   Pete <pete@petezilla.co.uk>
In-Reply-To: <CAJCQCtTexbZf0TTPsW1Rd-nmooNvsT+MbT1AYZX66WeDeB-5SA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AuthUser: pete@petezilla.co.uk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/01/2022 22:12, Chris Murphy wrote:
> On Fri, Jan 14, 2022 at 1:30 PM Peter Chant <pete@petezilla.co.uk> wrote:

A lot of snipping - I hope I don't cause confusion.


>> hit ENOSPC.  Surely adding a drive to a full file system fixes this?
> 
> Not necessarily, in fact depending on the profile of the block group
> type being balanced, e.g. if it's raid1 or raid10, you might need 2 or
> 4 drives added at once.
> 

Raid1 data, raid1 metadata.

> 
>> Especially one that nearly doubles its capacity?  Yet I kept hitting
>> this issue when
>>
>> trying to rebalance and also remove a 4TB  full drive.
>>
>> Yet I have a drive with 11TB of free space. (24TB array)!?
> 
> Sounds like metadata block groups are raid1. But it still can't add a
> new metadata block group on *two* separate devices, so there's enospc.

There are five drives, excluding any (smallish) disk image I've added as 
a loop device to help, but _four_ are painfully full.

...6281]  btrfs_commit_transaction+0x60/0xa00
>> [86348.556285]  ? start_transaction+0xd2/0x600
>> [86348.556287]  relocate_block_group+0x334/0x580
>> [86348.556290]  btrfs_relocate_block_group+0x175/0x340
>> [86348.556292]  btrfs_relocate_chunk+0x27/0xe0
>> [86348.556296]  btrfs_shrink_device+0x260/0x530
>> [86348.556298]  btrfs_rm_device+0x15b/0x4c0
> 
> Looks like a device in the process of being removed, the file system
> is undergoing shrink, and a bg is being relocated...
> 

Well, I was trying to rebalance.  But it was very slow.  So I changed my 
mind and though just removing one of the drives, which I intended to do 
anyway, might help moving data onto the new device.

The drive I tried removing is a WD Red with Drive Managed SMR - so that 
is helping with the speed...

...
>> btrfs_run_delayed_refs:2150: errno=-28 No space left
>> [86348.556349] BTRFS info (device dm-1): forced readonly
> 
> And it gets confused because it can't successfully relocate the block
> group, and it shuts down the file system to prevent confusion being
> written to the file system.
> 

Ok, that bit was a bit beyond my understanding.

...
> 
> OK metadata is raid1, and it's nearly full. But there's multiple
> devices with at least a couple GiB unallocated such that at least 2
> metadata block groups could be created.

The latest (several hours later):
root@dodo:/home/pete# btrfs fi u /srv/nfs/backup-pull
Overall:
     Device size:                  23.65TiB
     Device allocated:             13.51TiB
     Device unallocated:           10.14TiB
     Device missing:                  0.00B
     Used:                         13.51TiB
     Free (estimated):              5.07TiB      (min: 5.07TiB)
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 256.00KiB)

Data,RAID1: Size:6.74TiB, Used:6.73TiB (99.98%)
    /dev/mapper/backup_disk_AC8F    3.43TiB
    /dev/mapper/backup_disk_CCDZ    2.60TiB
    /dev/mapper/backup_disk_XVN6    2.60TiB
    /dev/mapper/backup_disk_E4U5    2.42TiB
    /dev/mapper/backup_disk_4RNH    2.41TiB

Metadata,RAID1: Size:21.00GiB, Used:20.49GiB (97.59%)
    /dev/mapper/backup_disk_AC8F   12.00GiB
    /dev/mapper/backup_disk_CCDZ    9.00GiB
    /dev/mapper/backup_disk_XVN6    9.00GiB
    /dev/mapper/backup_disk_E4U5    6.00GiB
    /dev/mapper/backup_disk_4RNH    6.00GiB

System,RAID1: Size:32.00MiB, Used:1.28MiB (4.00%)
    /dev/mapper/backup_disk_E4U5   32.00MiB
    /dev/mapper/backup_disk_4RNH   32.00MiB

Unallocated:
    /dev/mapper/backup_disk_AC8F  199.99GiB
    /dev/mapper/backup_disk_CCDZ  120.00GiB
    /dev/mapper/backup_disk_XVN6  124.00GiB
    /dev/mapper/backup_disk_E4U5    1.21TiB
    /dev/mapper/backup_disk_4RNH    8.50TiB
root@dodo:/home/pete#

> 
> Are you trying to do balance and device remove at the same time?
> 
> 

Well, I cancelled a balance, tried a remove and since that ENOSPC'ed I'm 
now running a full balance.

Any suggestions?  Just be patient, and hope the balance finishes without 
ENOSPC?  Go for the remove again.  I'd like to remove a 4TB drive if I 
can without adding a 6th HD to the system.  Still don't understand why I 
might need more than one practically empty drive for raid1?

Or, given that I've got another 12TB drive on the way, just abandon this 
file system (apart from reading any relevant data) and create a new file 
system as single, and migrate the current 12TB disk over later on to go 
back to raid1?

I'm wondering if part of the problem is a 3.6TB disk image that is 
sitting on the file system (fixing someone else's external drive). 
Deleting that might speed things up, but since I don't think that drive 
is fully backed up I'd rather keep the disk image until I am sure that 
all is well.  (I don't need the backup lecture...)

Apart from a loop device mounted drive image I might be able to mount 
another disk in the five disk file system - but I'd rather not.  I'd 
have to add a controller (have one spare) which might move the boot 
device (not using initrd and UUIDs) - and shoehorning another drive in 
is a little tricky but not impossible.  Its an old midi tower cased 
machine repurposed as my backup server.




