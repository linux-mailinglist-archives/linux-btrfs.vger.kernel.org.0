Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B49F44FED9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Nov 2021 07:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhKOGyJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 15 Nov 2021 01:54:09 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:60020 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhKOGyI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Nov 2021 01:54:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id CBD513F4E4;
        Mon, 15 Nov 2021 07:51:11 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dkUBkCwXyVPj; Mon, 15 Nov 2021 07:51:10 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 6DE783F3CA;
        Mon, 15 Nov 2021 07:51:10 +0100 (CET)
Received: from [192.168.0.126] (port=47376)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1mmVpZ-000FWp-C4; Mon, 15 Nov 2021 07:51:09 +0100
Date:   Mon, 15 Nov 2021 07:51:06 +0100 (GMT+01:00)
From:   Forza <forza@tnonline.net>
To:     waxhead@dirtcellar.net, Pascal <comfreak89@googlemail.com>,
        linux-btrfs@vger.kernel.org
Message-ID: <ac1a700.2fa445f4.17d225d1a53@tnonline.net>
In-Reply-To: <123daa93-9354-4df2-8c6b-be403e6ce8bc@dirtcellar.net>
References: <CADSoW+KdEuw7qd=dfvL-nCWF_AECVfY3oY5UGzdhm1=uvjA6JA@mail.gmail.com> <123daa93-9354-4df2-8c6b-be403e6ce8bc@dirtcellar.net>
Subject: Re: Failed drive in RAID-6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



---- From: waxhead <waxhead@dirtcellar.net> -- Sent: 2021-11-14 - 22:53 ----

> Pascal wrote:
>> Hi,
>> 
>> I have a failed drive in my RAID-6 with Metadata C3.
>> 
>> I am able to mount the filesytem via mount -o degraded /dev/sda /mnt/data/.
>> 
>> How can I remove the disk from the filesystem? The failed disk is a 8TB drive.
>> 
>> Do I have to replace it with a new one (only smaller size available)?
>> I would like just to remove the drive - I should have plenty of free
>> space available, even when the drive is missing afterwards.
>> 
> 
> No you do not have to replace the drive. And if you do, you can use a 
> smaller drive. Note that BTRFS "RAID" is close, but not really RAID in 
> the traditional sense. You might as well call it BTRFS-RAID, Fred or 
> Barney because it is NOT your off the shelve RAID implementation.
> 
> https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices
> 
> By the way , I am just a regular BTRFS user, so be warned. Do not 
> blindly follow my advice - i have not toyed around with raid5/6 in 
> years. (I suggest waiting for a follow up response if you can). However, 
> you remove missing devices with:
> btrfs device delete missing /mnt/data
> (I think you have to physically remove the device for that to work as 
> you expect.)
> 
> It is very annoying that btrfs does not show WHICH devices are missing, 
> but if you know that only one drives is faulty it should be straight 
> forward.

"btrfs device usage /mnt" will list missing devices and their IDs. It will list something like 


https://wiki.tnonline.net/w/Btrfs/Replacing_a_disk#Disk_is_dead_or_removed_from_the_system


> 
> After that I would have have run a scrub to ensure that all is good.


