Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321B34C6555
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 10:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiB1JEl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 04:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiB1JEX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 04:04:23 -0500
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D06643496
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 01:03:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 3C6D83FBDF;
        Mon, 28 Feb 2022 10:03:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.911
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ensFLqQHO2Nn; Mon, 28 Feb 2022 10:03:20 +0100 (CET)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 8E8B73FBD4;
        Mon, 28 Feb 2022 10:03:20 +0100 (CET)
Received: from [192.168.0.134] (port=55902)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1nObw7-000Fl6-CH; Mon, 28 Feb 2022 10:03:19 +0100
Message-ID: <ef34c380-dfae-dc5e-17fa-efde40ff02af@tnonline.net>
Date:   Mon, 28 Feb 2022 10:03:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Crash/BUG on during device delete
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <c574966a-4b9e-0a50-cb47-e6f904f95eaf@tnonline.net>
 <4e094239-c987-8b1a-bc56-b4252481fbaa@gmx.com>
 <feada357-9340-0ec3-4899-91b7351d17ad@tnonline.net>
 <3c25d70c-43fe-cf38-33f8-05e35ceb03f0@suse.com>
 <b964eb55-537f-dab4-e8a0-1326d5ee2c67@tnonline.net>
 <90be0040-74f9-29fa-4552-57f45dbf0a86@suse.com>
 <5a8a1ecf-d8ef-7db3-7a97-3f9f29b57bb1@tnonline.net>
 <173dc4fc-21fa-1534-9e6e-d1ff4c1b7564@suse.com>
 <dfb3e621-7331-2733-1735-34d0a252e4d8@suse.com>
From:   Forza <forza@tnonline.net>
In-Reply-To: <dfb3e621-7331-2733-1735-34d0a252e4d8@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2/24/22 10:30, Nikolay Borisov wrote:
> 
> 
> On 24.02.22 г. 2:33 ч., Qu Wenruo wrote:
> <snip>
> 
>>
>> OK, this is indeed chunk discard optimization causing the problem.
>>
>> @nik, any idea on this problem?
> 
> No, so looking at the code it we can exclude a race condition since 
> set/clear bit are taking the spinlock for the extent_io_tree. From the 
> first screenshot we can see we want to insert an extent whose start is 
> after it's end and the difference is 1: 8590983167 - 8590983168
> 
> 
> Since we are passing well-formed chunks as the original input into 
> add_extent_mapping respectively into discard-related routines.
> 
> So in order to be able to debug this we should really find a way to 
> reproduce it and dump the state of the in-memory device_alloc tree to 
> see how the search logic goes awry.
> 

I have not been able to reproduce the problem with several runs on 
device add and device delete in various configurations.

One thing I did notice is that when removing multiple devices on the 
same command line, btrfs seems to remove data from one device at the 
time, putting data on the other devices also scheduled to be deleted. 
This is very ineffective and means data is rewritten multiple times and 
takes twice as long to perform, than if data would be balanced over to 
the remaining devices from the beginning.

Example:

Before device delete:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Overall:
     Device size:                   9.02TiB
     Device allocated:             90.06GiB
     Device unallocated:            8.94TiB
     Device missing:                  0.00B
     Used:                         86.73GiB
     Free (estimated):              4.47TiB      (min: 4.47TiB)
     Free (statfs, df):             4.47TiB
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:               93.84MiB      (used: 0.00B)
     Multiple profiles:                  no

              Data     Metadata  System
Id Path      RAID1    RAID1     RAID1    Unallocated
-- --------- -------- --------- -------- -----------
  9 /dev/sdd1        -         -        -   894.25GiB
10 /dev/sde1        -         -        -   894.25GiB
11 /dev/sdg1 22.00GiB   1.00GiB        -     1.80TiB
12 /dev/sdc1 22.00GiB         - 32.00MiB     1.80TiB
13 /dev/sdh1 22.00GiB   1.00GiB        -     1.80TiB
14 /dev/sdf1 22.00GiB         - 32.00MiB     1.80TiB
-- --------- -------- --------- -------- -----------
    Total     44.00GiB   1.00GiB 32.00MiB     8.94TiB
    Used      43.23GiB 132.64MiB 16.00KiB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I am going to remove devices 11-14: `btrfs device delete /dev/sdf1 
/dev/sdh1 /dev/sdc1 /dev/sdg1 /mnt/nas_ssd/`

After a few moments we see that data from device 14 is moved to devices 
11 and 13.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Overall:
     Device size:                   7.20TiB
     Device allocated:             90.06GiB
     Device unallocated:            7.12TiB
     Device missing:                  0.00B
     Used:                         86.73GiB
     Free (estimated):              3.56TiB      (min: 3.56TiB)
     Free (statfs, df):             4.46TiB
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:               93.88MiB      (used: 0.00B)
     Multiple profiles:                  no

              Data     Metadata  System
Id Path      RAID1    RAID1     RAID1    Unallocated
-- --------- -------- --------- -------- -----------
  9 /dev/sdd1        -         -        -   894.25GiB
10 /dev/sde1        -         -        -   894.25GiB
11 /dev/sdg1 32.00GiB   1.00GiB 32.00MiB     1.79TiB
12 /dev/sdc1 22.00GiB         - 32.00MiB     1.80TiB
13 /dev/sdh1 33.00GiB   1.00GiB        -     1.79TiB
14 /dev/sdf1  1.00GiB         -        -     1.82TiB
-- --------- -------- --------- -------- -----------
    Total     44.00GiB   1.00GiB 32.00MiB     8.94TiB
    Used      43.23GiB 132.77MiB 16.00KiB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Waiting a bit longer we see that data from device 13 is moved over to 11 
and 12 while devices 9 and 10 remain empty.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Overall:
     Device size:                   5.38TiB
     Device allocated:             92.06GiB
     Device unallocated:            5.29TiB
     Device missing:                  0.00B
     Used:                         88.74GiB
     Free (estimated):              2.65TiB      (min: 2.65TiB)
     Free (statfs, df):             2.65TiB
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:               94.05MiB      (used: 0.00B)
     Multiple profiles:                  no

              Data     Metadata  System
Id Path      RAID1    RAID1     RAID1    Unallocated
-- --------- -------- --------- -------- -----------
  9 /dev/sdd1        -         -        -   894.25GiB
10 /dev/sde1        -         -        -   894.25GiB
11 /dev/sdg1 45.00GiB   1.00GiB 32.00MiB     1.77TiB
12 /dev/sdc1 42.00GiB   1.00GiB 32.00MiB     1.78TiB
13 /dev/sdh1  3.00GiB         -        -     1.82TiB
-- --------- -------- --------- -------- -----------
    Total     45.00GiB   1.00GiB 32.00MiB     7.11TiB
    Used      44.23GiB 138.19MiB 16.00KiB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Only at the end we see that data is being moved to the final two devices.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Overall:
     Device size:                   3.57TiB
     Device allocated:             92.06GiB
     Device unallocated:            3.48TiB
     Device missing:                  0.00B
     Used:                         86.73GiB
     Free (estimated):              1.74TiB      (min: 1.74TiB)
     Free (statfs, df):             2.65TiB
     Data ratio:                       2.00
     Metadata ratio:                   2.00
     Global reserve:               93.95MiB      (used: 0.00B)
     Multiple profiles:                  no

              Data     Metadata  System
Id Path      RAID1    RAID1     RAID1    Unallocated
-- --------- -------- --------- -------- -----------
  9 /dev/sdd1  2.00GiB         -        -   892.25GiB
10 /dev/sde1  3.00GiB         -        -   891.25GiB
11 /dev/sdg1 45.00GiB   1.00GiB 32.00MiB     1.77TiB
12 /dev/sdc1 40.00GiB   1.00GiB 32.00MiB     1.78TiB
-- --------- -------- --------- -------- -----------
    Total     45.00GiB   1.00GiB 32.00MiB     5.29TiB
    Used      43.23GiB 132.84MiB 16.00KiB
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks,
Forza

> 
>>
>> Thanks,
>> Qu
>>
>>> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/extent_map.c:362 
>>>
>>> (inlined by) add_extent_mapping at 
>>> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/extent_map.c:413 
>>>
>>> (inlined by) add_extent_mapping at 
>>> /home/forza/aports/main/linux-lts/src/linux-5.15/fs/btrfs/extent_map.c:400 
> 
> 
> 
> <snip>
