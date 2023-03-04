Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3696AA8B6
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Mar 2023 09:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCDIYs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Mar 2023 03:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjCDIYr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Mar 2023 03:24:47 -0500
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F001A1204A
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Mar 2023 00:24:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 428DC3F82B;
        Sat,  4 Mar 2023 09:24:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.993
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Md_OEWerqOPI; Sat,  4 Mar 2023 09:24:38 +0100 (CET)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id B23CE3F6C4;
        Sat,  4 Mar 2023 09:24:38 +0100 (CET)
Received: from [192.168.0.122] (port=51810)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pYNC1-00089z-2I; Sat, 04 Mar 2023 09:24:37 +0100
Message-ID: <a8c6921c-48a4-9511-8df8-5250d819fb46@tnonline.net>
Date:   Sat, 4 Mar 2023 09:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Salvaging the performance of a high-metadata filesystem
Content-Language: sv-SE, en-GB
To:     Matt Corallo <blnxfsl@bluematt.me>, Roman Mamedov <rm@romanrm.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <59b6326d-42d4-5269-72c1-9adcda4cf66c@bluematt.me>
 <20230303102239.2ea867dd@nvm>
 <aca66935-0ee5-bdb9-2fbc-eac0e5682163@tnonline.net>
 <a851e040-9568-acf0-a08f-593280350840@bluematt.me>
 <4d17590f-b938-6c6d-93ba-a6a61d3ea475@bluematt.me>
From:   Forza <forza@tnonline.net>
In-Reply-To: <4d17590f-b938-6c6d-93ba-a6a61d3ea475@bluematt.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023-03-03 20:05, Matt Corallo wrote:
> 
> 
> On 3/3/23 11:04 AM, Matt Corallo wrote:
>>
>>
>> On 3/3/23 1:30 AM, Forza wrote:
>>>
>>>
>>> On 2023-03-03 06:22, Roman Mamedov wrote:
>>>> On Thu, 2 Mar 2023 20:34:27 -0800
>>>> Matt Corallo <blnxfsl@bluematt.me> wrote:
>>>>
>>>>> The problem is there's one folder that has backups of workstation, 
>>>>> which were done by `cp
>>>>> --reflink=always`ing the previous backup followed by rsync'ing over 
>>>>> it.
>>>>
>>>> I believe this is what might cause the metadata inflation. Each time cp
>>>> creates a whole another copy of all 3 million files in the metadata, 
>>>> just
>>>> pointing to old extents for data.
>>>>
>>>> Could you instead make this backup destination a subvolume, so that 
>>>> during each
>>>> backup you create a snapshot of it for historical storage, and then 
>>>> rsync over
>>>> the current version?
>>>>
>>>
>>> I agree. If you make a snapshot of a subvolume, the additional 
>>> metadata is effectively 0. Then you rsync into the source subvolume. 
>>> This would add metadata for all changed files,
>>
>> Ah, good point, I hadn't considered that as an option, to be honest. 
>> I'll convert the snapshots to subvolumes and see how much metadata is 
>> reduced...may take a month or two to run, though :/
>>
>>> Make sure you use `mount -o noatime` to prevent metadata updates when 
>>> rsync checks all files.
>>
>> Ah, that's quite the footgun. Shame noatime was never made default :(
>>
>>> Matt, what are your mount options for your filesystem (output of 
>>> `mount`). Can you also provide the output of `btrfs fi us -T 
>>> /your/mountpoint`
> 
> Oops, sorry, mount options are default with a long commit:
> 
> /dev/mapper/bigraid33_crypt on /bigraid type btrfs 
> (rw,relatime,space_cache=v2,commit=3600,subvolid=5,subvol=/)

Unless you need to, replace relatime with noatime. This makes a big 
difference when you have lots of reflinks or snapshots as it avoids 
de-duplication of metadata when the atimes are updated.
> 
>> Sure:
>>
>> btrfs filesystem usage -T /bigraid
>> Overall:
>>      Device size:         85.50TiB
>>      Device allocated:         64.67TiB
>>      Device unallocated:         20.83TiB
>>      Device missing:            0.00B
>>      Used:             63.03TiB
>>      Free (estimated):         10.10TiB    (min: 5.92TiB)
>>      Free (statfs, df):          6.30TiB
>>      Data ratio:                 2.22
>>      Metadata ratio:             3.00
>>      Global reserve:        512.00MiB    (used: 48.00KiB)
>>      Multiple profiles:              yes    (data)
>>
>>                                 Data     Data      Metadata  System
>> Id Path                        RAID1    RAID1C3   RAID1C3   RAID1C4  
>> Unallocated
>> -- --------------------------- -------- --------- --------- -------- 
>> -----------
>>   1 /dev/mapper/bigraid33_crypt  7.48TiB   3.73TiB 808.00GiB 
>> 32.00MiB     2.56TiB
>>   2 /dev/mapper/bigraid36_crypt  6.22TiB   4.00GiB 689.00GiB        
>> -     2.20TiB
>>   3 /dev/mapper/bigraid39_crypt  8.20TiB   3.36TiB 443.00GiB 
>> 32.00MiB     2.56TiB
>>   4 /dev/mapper/bigraid37_crypt  3.64TiB   4.57TiB 152.00GiB 
>> 32.00MiB     2.56TiB
>>   5 /dev/mapper/bigraid35_crypt  3.46TiB 367.00GiB 310.00GiB        
>> -     1.33TiB
>>   6 /dev/mapper/bigraid38_crypt  3.71TiB   3.24TiB   1.40TiB 
>> 32.00MiB     2.56TiB
>>   7 /dev/mapper/bigraid41_crypt  3.05TiB  25.00GiB 377.00GiB        
>> -     2.02TiB
>>   8 /dev/mapper/bigraid20_crypt  6.66TiB   2.54TiB 322.00GiB        
>> -     5.03TiB
>> -- --------------------------- -------- --------- --------- -------- 
>> -----------
>>     Total                       21.21TiB   5.94TiB   1.48TiB 
>> 32.00MiB    20.83TiB
>>     Used                        21.14TiB   5.46TiB   1.46TiB  4.70MiB

Not sure if running with multiple profiles will cause issues or 
slowness, but it might be good to try to convert the old raid1c3 data 
chunks into raid1 over time. You can use balance filters to minimise the 
work each run.

# btrfs balance start -dconvert=raid1,soft,limit=10 /bigraid

This will avoid balancing blockgroups already in RAID1 (soft option) and 
limit to only balance 10 block groups. You can then schedule this during 
times with less active I/O.

It is also possible to defragment the subvolume and extent trees[*]. 
This could help a little, though if the filesystem is frequently 
changing it might only be a temporary thing. It can also take a long 
time to complete.

# btrfs filesystem defragment /path/to/subvolume-root

[*] 
https://wiki.tnonline.net/w/Btrfs/Defrag#Defragmenting_the_subvolume_and_extent_trees

