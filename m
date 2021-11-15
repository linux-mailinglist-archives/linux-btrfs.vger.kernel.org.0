Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC144FEFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 08:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhKOHJR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 15 Nov 2021 02:09:17 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:46588 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbhKOHJG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 02:09:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 73D6B3F5B5;
        Mon, 15 Nov 2021 08:06:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rGy9r8lgrTWf; Mon, 15 Nov 2021 08:06:02 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 41A963F52E;
        Mon, 15 Nov 2021 08:06:02 +0100 (CET)
Received: from [192.168.0.126] (port=47710)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mmW41-000GCZ-Jm; Mon, 15 Nov 2021 08:06:01 +0100
Date:   Mon, 15 Nov 2021 08:06:03 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     waxhead@dirtcellar.net, Pascal <comfreak89@googlemail.com>,
        linux-btrfs@vger.kernel.org
Message-ID: <1f59398.2fa445f5.17d226ac7b8@tnonline.net>
In-Reply-To: <ac1a700.2fa445f4.17d225d1a53@tnonline.net>
References: <CADSoW+KdEuw7qd=dfvL-nCWF_AECVfY3oY5UGzdhm1=uvjA6JA@mail.gmail.com> <123daa93-9354-4df2-8c6b-be403e6ce8bc@dirtcellar.net> <ac1a700.2fa445f4.17d225d1a53@tnonline.net>
Subject: Re: Failed drive in RAID-6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Forza <forza@tnonline.net> -- Sent: 2021-11-15 - 07:51 ----

> 
> 
> ---- From: waxhead <waxhead@dirtcellar.net> -- Sent: 2021-11-14 - 22:53 ----
> 
>> Pascal wrote:
>>> Hi,
>>> 
>>> I have a failed drive in my RAID-6 with Metadata C3.
>>> 
>>> I am able to mount the filesytem via mount -o degraded /dev/sda /mnt/data/.
>>> 
>>> How can I remove the disk from the filesystem? The failed disk is a 8TB drive.
>>> 
>>> Do I have to replace it with a new one (only smaller size available)?
>>> I would like just to remove the drive - I should have plenty of free
>>> space available, even when the drive is missing afterwards.
>>> 
>> 
>> No you do not have to replace the drive. And if you do, you can use a 
>> smaller drive. Note that BTRFS "RAID" is close, but not really RAID in 
>> the traditional sense. You might as well call it BTRFS-RAID, Fred or 
>> Barney because it is NOT your off the shelve RAID implementation.
>> 
>> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices
>> 
>> By the way , I am just a regular BTRFS user, so be warned. Do not 
>> blindly follow my advice - i have not toyed around with raid5/6 in 
>> years. (I suggest waiting for a follow up response if you can). However, 
>> you remove missing devices with:
>> btrfs device delete missing /mnt/data
>> (I think you have to physically remove the device for that to work as 
>> you expect.)
>> 
>> It is very annoying that btrfs does not show WHICH devices are missing, 
>> but if you know that only one drives is faulty it should be straight 
>> forward.
> 
> "btrfs device usage /mnt" will list missing devices and their IDs. It will list something like 
> 
I meant to paste the example output. :) 

 # btrfs device usage /mnt/my-vault/
/dev/nvme0n1, ID: 1
   Device size:             8.00GiB
   Device slack:              0.00B
   Data,RAID10/4:           3.00GiB
   Metadata,RAID10/4:     192.00MiB
   System,RAID10/4:         8.00MiB
   Unallocated:             4.80GiB

/dev/nvme0n2, ID: 2
   Device size:             8.00GiB
   Device slack:              0.00B
   Data,RAID10/4:           3.00GiB
   Metadata,RAID10/4:     192.00MiB
   System,RAID10/4:         8.00MiB
   Unallocated:             4.80GiB

/dev/nvme0n3, ID: 3
   Device size:             8.00GiB
   Device slack:              0.00B
   Data,RAID10/4:           3.00GiB
   Metadata,RAID10/4:     192.00MiB
   System,RAID10/4:         8.00MiB
   Unallocated:             4.80GiB

missing, ID: 4
   Device size:               0.00B
   Device slack:              0.00B
   Data,RAID10/4:           3.00GiB
   Metadata,RAID10/4:     192.00MiB
   System,RAID10/4:         8.00MiB
   Unallocated:             4.80GiB


> 
> https://wiki.tnonline.net/w/Btrfs/Replacing_a_disk#Disk_is_dead_or_removed_from_the_system
> 
> 
>> 
>> After that I would have have run a scrub to ensure that all is good.
> 
> 


