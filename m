Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765BA486DC1
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 00:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245564AbiAFX0P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 6 Jan 2022 18:26:15 -0500
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:33048 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245586AbiAFX0M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 18:26:12 -0500
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Jan 2022 18:26:11 EST
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 76C773F65E;
        Fri,  7 Jan 2022 00:17:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7uWT8QsswoEH; Fri,  7 Jan 2022 00:17:08 +0100 (CET)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 733453F49D;
        Fri,  7 Jan 2022 00:17:08 +0100 (CET)
Received: from [192.168.0.126] (port=55256)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1n5c0E-000116-JA; Fri, 07 Jan 2022 00:17:06 +0100
Date:   Fri, 7 Jan 2022 00:17:02 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     Chris Murphy <lists@colorremedies.com>,
        =?UTF-8?Q?Juan_Sim=C3=B3n?= <decedion@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <fc57894.138b7c30.17e31ae6f21@tnonline.net>
In-Reply-To: <CAJCQCtR_oogvxKozaMM8UUiW2kKxFUnc+1cqTuwT12ZBOTDFgQ@mail.gmail.com>
References: <CAMQzBqCSzr4UO1VFTjtSDPt+0ukhf6yqK=q+eLA+Tp1hiB_weA@mail.gmail.com> <CAJCQCtR_oogvxKozaMM8UUiW2kKxFUnc+1cqTuwT12ZBOTDFgQ@mail.gmail.com>
Subject: Re: 48 seconds to mount a BTRFS hard disk drive seems too long to
 me
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: Chris Murphy <lists@colorremedies.com> -- Sent: 2022-01-06 - 20:58 ----

> On Thu, Jan 6, 2022 at 8:48 AM Juan Simón <decedion@gmail.com> wrote:
>>
>> Hard disk: 16TB SEAGATE IRONWOLF PRO 3.5", 7200 RPM 256MB CACHE
>> Arch Linux
>> Linux juan-PC 5.15.13-xanmod1-tt-1 #1 SMP Thu, 06 Jan 2022 12:14:06
>> +0000 x86_64 GNU/Linux
>> btrfs-progs v5.15.1
>>
>> $ btrfs fi df /multimedia
>> Data, single: total=10.89TiB, used=10.72TiB
>> System, DUP: total=8.00MiB, used=1.58MiB
>> Metadata, DUP: total=15.00GiB, used=13.19GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>
>> I have formatted it as BTRFS and the mounting options (fstab) are:
>>
>> /multimedia     btrfs
>> rw,noatime,autodefrag,compress-force=zstd,nossd,space_cache=v2    0 0
>>
>> The disk works fine, I have not detected any problems but every time I
>> reboot the system takes a long time due to the mounting of this drive
>>
>> $ systemd-analyze blame
>> 48.575s multimedia.mount
>> ....
>>
>> I find it too long to mount a drive, is this normal, is it because of
>> one of the mounting options, or because of the size of the hard drive?
> 
> I think it's due to reading all the block group items which are buried
> in the extent tree. And on large file systems with a large extent
> tree, it results in a lot of random IO reads, so on spinning drives
> you get a ton of latency hits for this search.
> 
> This thread discusses some of the details as it relates to zoned
> devices, which have even longer mount times I guess. But the comments
> about block groups and extent tree apply the same to non-zoned.
> https://lore.kernel.org/linux-btrfs/CAHQ7scVGPAwEGQOq3Kmn75GJzyzSQ9qrBBZrHFu+4YWQhGE0Lw@mail.gmail.com/
> 
> The mount options you're using aren't causing the mount delay. But be
> certain you really want autodefrag - it's designed for the desktop,
> small databases used by desktops, web browsers, and the like. If you
> use it with bigger and/or very busy databases, it just results in a
> ton of I/O and can really slow things down rather than speed them up.
> You're better off in such a use case with scheduled defragment on a
> dir by dir basis, which you can do using the btrfsmaintenance
> package's btrfs-defrag.timer and .service unit, which you can
> customize. It's maintained by kdave, also maintainer of btrfs-progs.
> https://github.com/kdave/btrfsmaintenance
> 

It might be worth trying to defragment the extent tree of each subvolume by pointing btrfs defrag to the subvolume and not use the -r option. I don't think the btrfsmaintenance script does this.

# btrfs fi defragment /mnt/btrfs 
# btrfs fi defragment /mnt/btrfs/subvol_A
# btrfs fi defragment /mnt/btrfs/subvol_B
...

Read-only snapshots can't be defragmented this way. 


