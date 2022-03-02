Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970324CAEB5
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 20:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbiCBTbO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 14:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiCBTbN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 14:31:13 -0500
Received: from libero.it (smtp-17.italiaonline.it [213.209.10.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CDCD225B
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 11:30:27 -0800 (PST)
Received: from [192.168.1.27] ([78.12.27.75])
        by smtp-17.iol.local with ESMTPA
        id PUg2nOQe3PSXePUg2nPzvN; Wed, 02 Mar 2022 20:30:26 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1646249426; bh=mCGKiHLkjydcCxKHCi3eIlwnNDa6bcXnZrNls7m9+9k=;
        h=From;
        b=qHfNjof0pcoLQDNZV/eJTnBrcFiCwxWdZVlwBBJ9bgEXrbcUpPKE3alQY2RJSOFcS
         CPxiAax6wHfePSpUmzAGdb8MYRga5GLf4Ak2b+D8VjWB8UMktX1mxxJCmWiIMIXRjm
         vHGbE19QBW/DVbyUqDTL866HyunY8u8zYstwpiqxkkI2Ca0shqNxQVnfyGf0sAOFQj
         rb7N8485lxGJZ/cpu6y78q4a0u/irdFF4i67KBPnR7wHCHmtddDZPo61lliev6qUpH
         Jjz4eoGJX2qACpAlDQ+FT06+KZvCcVfhmaoCO8/do6dYwWGhFNaiUH1qY4owZtWEPa
         cR9Qaudb2NJEA==
X-CNFS-Analysis: v=2.4 cv=SMyH6MjH c=1 sm=1 tr=0 ts=621fc5d2 cx=a_exe
 a=aCiYQ2Po16U8px2wfyNKfg==:117 a=aCiYQ2Po16U8px2wfyNKfg==:17
 a=IkcTkHD0fZMA:10 a=o1OEnJeP1AuZ2RQ4yD4A:9 a=QEXdDO2ut3YA:10
Message-ID: <90407af0-57bb-9808-7663-6feb56fa7b20@inwind.it>
Date:   Wed, 2 Mar 2022 20:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/7][V11] btrfs: allocation_hint
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
References: <cover.1643228177.git.kreijack@inwind.it>
 <Yh0AnKF1jFKVfa/I@localhost.localdomain>
 <c7fc88cd-a1e5-eb74-d89d-e0a79404f6bf@libero.it>
 <Yh42nDUquZIqVMC0@localhost.localdomain>
 <e8d1a33a-a75a-1a25-b788-a2da5019e6c4@inwind.it>
 <Yh6Tit2dKcLt7xJP@localhost.localdomain>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <Yh6Tit2dKcLt7xJP@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHTcCZ1/oq3tnPxUN9ayhdKr4tFW6QeXcdvmdTker71FPiBLHO12h5q7r6ORooJW6NtibaPgJ4+gVfTt6iC4sQyqrub/hngAUQeOdM5VtIBL6ErhJPHl
 yDv936NPgZqpoeTjDXS02IM71SZp2ar8sfHIcDahCxU2CBG41kTuQS0Q/wqr9I7435g8e5XtmM4LRdvYe6ZsFQk+odYfJgei5a1kPhnORhfGZeTYps1ZA5TA
 /QHSPlgV5Gf+SojzPw7LetcabbwupW5YbonmkqvkSwZJG4r8gaoIAs9eQ3E/AL8i+XCcmwq+BHlx5kse5PljYu2urQmyGSlaV0L1ezobiKhswfU2G3KQ5bNb
 n5ToYF2rOPac+Ptddd+JAta6R9Z2Hw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/03/2022 22.43, Josef Bacik wrote:
> On Tue, Mar 01, 2022 at 07:55:07PM +0100, Goffredo Baroncelli wrote:
>> On 01/03/2022 16.07, Josef Bacik wrote:
>>> On Mon, Feb 28, 2022 at 10:01:35PM +0100, Goffredo Baroncelli wrote:
>>>> Hi Josef,
>>>>
>>>> On 28/02/2022 18.04, Josef Bacik wrote:
>>>>> On Wed, Jan 26, 2022 at 09:32:07PM +0100, Goffredo Baroncelli wrote:
>>>>>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>>>>>
>>>>>> Hi all,
>>>>>>
>>>> [...
>>>>
>>>>>> In V11 I added a new 'feature' file /sys/fs/btrfs/features/allocation_hint
>>>>>> to help the detection of the allocation_hint feature.
>>>>>>
>>>>>
>>>>> Sorry Goffredo I dropped the ball on this, lets try and get this shit nailed
>>>>> down and done so we can get it merged.  The code overall looks good, I just have
>>>>> two things I want changed
>>>>>
>>>>> 1. The sysfs file should use a string, not a magic number.  Think how
>>>>>       /sys/block/<dev>/queue/scheduler works.  You echo "metadata_only" >
>>>>>       allocation_hint, you cat allocation_hint and it says "none" or
>>>>>       "metadata_only".  If you want to be fancy you can do exactly like
>>>>>       queue/scheduler and show the list of options with [] around the selected
>>>>>       option.
>>>>
>>>> Ok.
>>>>>
>>>>> 2. I hate the major_minor thing, can you do similar to what we do for devices/
>>>>>       and symlink the correct device sysfs directory under devid?
>>>>>
>>>> Ok, do you have any suggestion for the name ? what about bdev ?
>>>>
>>>
>>> You literally just add a link to the device kobj to the devid kobj.  If you look
>>> at btrfs_sysfs_add_device(), you would do something like this (completely
>>> untested and uncompiled)
>>
>> I will give an eye to your code; thanks. However my question was more basic.
>>
>> Now we have:
>>
>> .../btrfs/<uuid>/devinfo/<dev-nr>/major_minor
>>
>> with the link, as you suggested, I think that we will have:
>>
>> .../btrfs/<uuid>/devinfo/<dev-nr>/bdev -> ../../../../devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata6/host5/target5:0:0/5:0:0:0/block/sdg/sdg3
>>                                    ^^^^
>>
>> (notice 'bdev', which is the name that I asked)
>>
>> looking at your patch, it seems to me that the link will be named like the device name:
>>
>> .../btrfs/<uuid>/devinfo/<dev-nr>/sdg3 -> ../../../../devices/pci0000:00/0000:00:01.2/0000:01:00.1/ata6/host5/target5:0:0/5:0:0:0/block/sdg/sdg3
>>                                    ^^^^
>>
>> which is quite convoluted as approach, because the code has to find a name that matches a device (sdg3), instead to look for a fixed name (bdev).
>>
>> Because I know that every people has a strong, valid (and above all different !) opinion about the name, I want to ask it before issue another patches set.
>> For the record, I like 'bdev' only because I saw used (by bcache)
>>
>> IMHO, the btrfs world had been simpler if devices/ sysfs directory was populated by the btrfs-dev-nr instead the device name
>>
> 
> Ahh ok I see, you make a good point.  I agree it would have been better to have
> the dev nrs in devices and then links in there, but here we are.
> 
> I think for now drop this patch from this series, since it's another bike
> shedding opportunity and I'd rather get the core functionality in.  Do what I
> asked in #1 and drop this patch from this series, follow up with a different
> series if you feel strongly enough about it and that way we can have that
> discussion in that thread and not hold up your feature.  Thanks,
still be a problem:
- how go from the "dev name" (e.g. /dev/sdg3) to the sysfs field
   (e.g. /sys/btrfs/<uuid>/devinfo/<devid>/allocation_hint) ?

For simple filesystem (e.g. 1 disk), it is trivial (and not useful); for more complex
one (2, 3 disks) it is easy to make mistake.

btrfs-progs relies on major_minor; it is possible to used the BTRFS_IOC_DEV_INFO
but it requires CAP_ADMIN....


> 
> Josef


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
