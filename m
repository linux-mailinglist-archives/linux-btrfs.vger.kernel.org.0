Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7489C3D4803
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhGXNVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 09:21:10 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:37328 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhGXNVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 09:21:10 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Jul 2021 09:21:09 EDT
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 92A393F5AD;
        Sat, 24 Jul 2021 15:54:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.969
X-Spam-Level: 
X-Spam-Status: No, score=-1.969 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, NICE_REPLY_A=-0.07, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ban7PenhHSUY; Sat, 24 Jul 2021 15:54:20 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 53A603F54E;
        Sat, 24 Jul 2021 15:54:19 +0200 (CEST)
Received: from [192.168.0.10] (port=56946)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1m7I6c-0001hO-AR; Sat, 24 Jul 2021 15:54:18 +0200
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
To:     Hugo Mills <hugo@carfax.org.uk>, waxhead <waxhead@dirtcellar.net>,
        dsterba@suse.cz, Roman Mamedov <rm@romanrm.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210722192955.18709-1-dsterba@suse.com>
 <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
 <20210723140843.GE19710@twin.jikos.cz> <20210723222730.1d23f9b4@natsu>
 <20210723192145.GF19710@suse.cz>
 <18a1bdd5-321e-68d3-517f-84c8d9bacb9c@dirtcellar.net>
 <20210724123050.GD992@savella.carfax.org.uk>
From:   Forza <forza@tnonline.net>
Message-ID: <7cdf230d-8b0d-03e0-9b32-57bead264870@tnonline.net>
Date:   Sat, 24 Jul 2021 15:54:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210724123050.GD992@savella.carfax.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021-07-24 14:30, Hugo Mills wrote:
> On Sat, Jul 24, 2021 at 01:04:19PM +0200, waxhead wrote:
>> David Sterba wrote:
>>
>>> Maybe it's still too new so nobody is used to it and we've always had
>>> problems with the raid naming scheme anyway.
>>
>> Perhaps slightly off topic , but I see constantly that people do not
>> understand how BTRFS "RAID" implementation works. They tend to confuse it
>> with regular RAID and get angry because they run into "issues" simply
>> because they do not understand the differences.
>>
>> I have been an enthusiastic BTRFS user for years, and I actually caught
>> myself incorrectly explaining how regular RAID works to a guy a while ago.
>> This happened simply because my mind was so used to how BTRFS uses this
>> terminology that I did not think about it.
>>
>> As BTRFS is getting used more and more it may be increasingly difficult (if
>> not impossible) to get rid of the "RAID" terminology, but in my opinion also
>> increasingly more important as well.
>>
>> Some years ago (2018) there was some talk about a new naming scheme
>> https://marc.info/?l=linux-btrfs&m=136286324417767
>>
>> While technically spot on I found Hugo's naming scheme difficult. It was
>> based on this idea:
>> numCOPIESnumSTRIPESnumPARITY
>>
>> 1CmS1P = Raid5 or 1 copy, max stripes, 1 parity.
>>
>> I also do not agree with the use of 'copy'. The Oxford dictionary defines
>> 'copy' as "a thing that is made to be the same as something else, especially
>> a document or a work of art"
>>
>> And while some might argue that copying something on disk from memory makes
>> it a copy, it ceases to be a copy once the memory contents is erased. I
>> therefore think that replicas is a far better terminology.
>>
>> I earlier suggested Rnum.Snum.Pnum as a naming scheme which I think is far
>> more readable so if I may dare to be as bold....
>>
>> SINGLE  = R0.S0.P0 (no replicas, no stripes (any device), no parity)
>> DUP     = R1.S1.P0 (1 replica, 1 stripe (one device), no parity)
>> RAID0   = R0.Sm.P0 (no replicas, max stripes, no parity)
>> RAID1   = R1.S0.P0 (1 replica, no stripes (any device), no parity)
>> RAID1c2 = R2.S0.P0 (2 replicas, no stripes (any device), no parity)
>> RAID1c3 = R3.S0.P0 (3 replicas, no stripes (any device), no parity)
>> RAID10  = R1.Sm.P0 (1 replica, max stripes, no parity)
>> RAID5   = R0.Sm.P1 (no replicas, max stripes, 1 parity)
>> RAID5   = R0.Sm.P2 (no replicas, max stripes, 2 parity)
> 
>     Sorry, I missed a detail here that someone pointed out on IRC.
> 
>     "r0" makes no sense to me, as that says there's no data. I would
> argue strongly to add one to all of your r values. (Note that
> "RAID1c2" isn't one of the current btrfs RAID levels, and by extension
> from the others, it's equivalent to the current RAID1, and we have
> RAID1c4 which is four complete instances of any item of data).
> 
>     My proposal counted *instances* of the data, not the redundancy.
> 
>     Hugo.
> 

I think Hugu is right that the terminology of "instance"[1] is easier to 
understand than copies or replicas.

Example:
"single" would be 1 instance
"dup" would be 2 instances
"raid1" would be 2 instances, 1 stripe, 0 parity
"raid1c3" would be 3 instances, 1 stripe, 0 parity
"raid1c4" would be 4 instances, 1 stripe, 0 parity
... and so on.

Shortened we could then use i<num>.s<num>.p<num> for Instances, Stripes 
and Parities.

Do we need a specific term for level of "redundancy"? In the current 
suggestions we can have redundancy either because of parity or of 
multiple instances. Perhaps the output of btrfs-progs could mention 
redundancy level such as this:

# btrfs fi us /mnt/btrfs/ -T
Overall:
     Device size:                  18.18TiB
     Device allocated:             11.24TiB
     Device unallocated:            6.93TiB
     Device missing:                  0.00B
     Used:                         11.21TiB
     Free (estimated):              6.97TiB      (min: 3.50TiB)
     Free (statfs, df):             6.97TiB
     Data ratio:                       1.00
     Metadata ratio:                   2.00
     Global reserve:              512.00MiB      (used: 0.00B)
     Multiple profiles:                  no

              Data     Metadata System
Mode:        i1,s0,p0 i2,s0,p0 i2,s0,p0
Redundancy:  0        1        1
------------ -------- -------- -------- -----------
Id Path                                 Unallocated
-- --------- -------- -------- -------- -----------
  3 /dev/sdb2  5.61TiB 17.00GiB 32.00MiB     3.47TiB
  4 /dev/sdd2  5.60TiB 17.00GiB 32.00MiB     3.47TiB
-- --------- -------- -------- -------- -----------
    Total     11.21TiB 17.00GiB 32.00MiB     6.94TiB
    Used      11.18TiB 15.76GiB  1.31MiB




Thanks
~Forza



[1] https://www.techopedia.com/definition/16325/instance
