Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4759658E8FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Aug 2022 10:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiHJIpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Aug 2022 04:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiHJIpP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Aug 2022 04:45:15 -0400
Received: from libero.it (smtp-34.italiaonline.it [213.209.10.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE382720
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Aug 2022 01:45:12 -0700 (PDT)
Received: from [192.168.1.27] ([84.222.35.163])
        by smtp-34.iol.local with ESMTPA
        id LhKuoDwllMK28LhKuoUSGr; Wed, 10 Aug 2022 10:45:09 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1660121109; bh=0Q/VVvawt8LEMiCGX3WGMaK+1L0L7MQ+yD/gjlh1CpQ=;
        h=From;
        b=NH6RWQGxMl9XCWy/ZSOMwljri2UKvK3UPNhqz9lXJvZLqtj/UaAmA8P7Ap2uE7FoP
         sU8dhzDPe0eqw74+nGf7hWO1L2XyCfpzKYxIwgVN86usoqLrP+jGSculbyglEKW2/e
         7ESKDCXI+YS5tfZXNLOTKdaLqW7lEBA6KW1GiKgkswxGKgJxa3Oh3k8a0+CbnW/D80
         3eX3ntyeSpS6TNoO8+DOAH8xSRQa2Q6YRYIe2xNO5K5LLbuUe8wUnoe/D7wqYNy+oc
         SnePfjLAXioxg9Q9A+ERrk7oPTAYdbX4Ezcr0CqdHMSP8RBYYX89ImrAvb2UdcS04q
         erzF4OW61zuIA==
X-CNFS-Analysis: v=2.4 cv=a6H1SWeF c=1 sm=1 tr=0 ts=62f37015 cx=a_exe
 a=FwZ7J7/P4KMHneBNQvmhbg==:117 a=FwZ7J7/P4KMHneBNQvmhbg==:17
 a=IkcTkHD0fZMA:10 a=9_hX1_VS7Wh35Jn7LmYA:9 a=QEXdDO2ut3YA:10
Message-ID: <8935ce6e-3801-b35a-7468-3f6fcbab82f0@inwind.it>
Date:   Wed, 10 Aug 2022 10:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Reply-To: kreijack@inwind.it
Subject: Re: misc-next and for-next: kernel BUG at fs/btrfs/extent_io.c:2350!
 during raid5 recovery
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
References: <YvHVJ8t5vzxH9fS9@hungrycats.org>
 <d3a3fea9-a260-dcdc-d3a0-70b1d1f0fb2d@gmx.com>
 <YvK1gqSvQRi0B+05@hungrycats.org>
 <9f504e1b-3ee2-9072-51c7-c533c0fb315f@gmx.com>
 <92a7cc01-4ecc-c56a-5ef4-26b28e0b2aae@libero.it>
 <8015f630-3dc9-4655-3e30-5d241af3e0bc@gmx.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <8015f630-3dc9-4655-3e30-5d241af3e0bc@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIa69ZKOy0r8gm89sp2JB5/3tp7tHdjspH9MhL8T1ukOx6ldQ9IwS640riGzAAZEZ3D8pJlJvYmnubIPMB2r8W9+ZQtxAMK9agasRIxyxFmT7aqwXVla
 72QcU/7cXUdc3mct5DoV6lR7opFB6kU3Fhqzc+VK6n0OkrAoPwyp5Q5sv+QNbFygPIukHkUE5ljKMel/JODK3EGDUTYSGUrD8WcFSmOc6E6Wlb52Bp4K4Qlf
 DsA4YkBG09InKIcgz5eDcx6P2PYenP/Z97D2oMiYfwE=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/08/2022 10.24, Qu Wenruo wrote:
> 
> 
> On 2022/8/10 16:08, Goffredo Baroncelli wrote:
>> On 09/08/2022 23.50, Qu Wenruo wrote:
>>>>> n 2022/8/9 11:31, Zygo Blaxell wrote:
>>>>>> Test case is:
>>>>>>
>>>>>>     - start with a -draid5 -mraid1 filesystem on 2 disks
>>>>>>
>>>>>>     - run assorted IO with a mix of reads and writes (randomly
>>>>>>     run rsync, bees, snapshot create/delete, balance, scrub, start
>>>>>>     replacing one of the disks...)
>>>>>>
>>>>>>     - cat /dev/zero > /dev/vdb (device 1) in the VM guest, or run
>>>>>>     blkdiscard on the underlying SSD in the VM host, to simulate
>>>>>>     single-disk data corruption
>>>>>
>>>>> One thing to mention is, this is going to cause destructive RMW to
>>>>> happen.
>>>>>
>>>>> As currently substripe write will not verify if the on-disk data stripe
>>>>> matches its csum.
>>>>>
>>>>> Thus if the wipeout happens while above workload is still running, it's
>>>>> going to corrupt data eventually.
>>>>
>>>> That would be a btrfs raid5 design bug,
>>>
>>> That's something all RAID5 design would have the problem, not just btrfs.
>>>
>>> Any P/Q based profile will have the problem.
>>
>>
>> Hi Qu,
>>
>> I looked at your description of 'destructive RMW' cyle:
>>
>> ----
>> Test case btrfs/125 (and above workload) always has its trouble with
>> the destructive read-modify-write (RMW) cycle:
>>
>>          0       32K     64K
>> Data1:  | Good  | Good  |
>> Data2:  | Bad   | Bad   |
>> Parity: | Good  | Good  |
>>
>> In above case, if we trigger any write into Data1, we will use the bad
>> data in Data2 to re-generate parity, killing the only chance to recovery
>> Data2, thus Data2 is lost forever.
>> ----
>>
>> What I don't understood if we have a "implementation problem" or an
>> intrinsic problem of raid56...
>>
>> To calculate parity we need to know:
>>      - data1 (in ram)
>>      - data2 (not cached, bad on disk)
>>
>> So, first, we need to "read data2" then to calculate the parity and then
>> to write data1.
> 
> First thing first, the idea of RAID5/6 itself doesn't involve how to
> verify the data is correct or not.
> 
> Btrfs is better because it has extra csum ability.
> 
> Thus for bad on-disk data case, it's even worse for all the other
> RAID5/6 implementations which don't have csum for its data.
> 
>>
>> The key factor is "read data", where we can face three cases:
>> 1) the data is referenced and has a checksum: we can check against the
>> checksum and if the checksum doesn't match we should perform a recover
>> (on the basis of the data stored on the disk)
> 
> Then let's talk about the detail problems in the btrfs specific areas.
> 
> Yes, it's possible that we can try to check the csums when doing RMW for
> sub-stripe writes.
> 
> But there are problems:
> 
> === csum tree race ===
> 
> 1) Data writes (with csum) into some data 1 stripes finished
> 
> 2) By somehow the just written data is corrupted
> 
> 3) RAID56 RMW triggered for write into data 2
> 
> 4) We search csum tree, and found nothing, as the csum insert hasn't
>     happen yet
> 
This is the point. Theoretically this is doable, but this would require a "strict"
order not only inside the stripe but also between all the data and metadata.
This would have an impact on the performance; however I think that this is not
the highest problem. The highest problem is increase of the complexity of the code.

It seems that the ZFS approach (parity inside the extent) should not have this problem.


> 5) Csum insert happens for data write in 1)
> 
> Then we still have the destructive RMW.
> Yes we can argue that 2) is so rare that we shouldn't really bother, but
> in theory this can still happen, all just because the csum tree search
> and csum insert has race window.
> 
> === performance ===
> 
> This means, every time we do a RMW, we have to do a full csum tree and
> extent tree search.
> And this also mean, we have to read the full stripe, including the range
> we're going to write data into.

Likely we need to read the checksums in any case, because we need to update
the page that hosts it for the first write.
Also we need to read the full stripe to compute the parity; only for
raid 5 we can do:

	new_parity = old_parity ^ new_data

> 
> AKA, this is full scrub level check.
Is the usual cost that we need to pay when we read a data from the disk.

> 
> This is definitely not a small cost, which will further slowdown the
> RAID56 write.
> 
> Thus even if we're going to implement such scrub level check, I'm not
> going to make it the default option, but make it opt-in.
> 
> Although recently since I'm working on RAID56, unless there are some
> possible dead-lock, I believe it's possible to implement.
> 
> Maybe in the near future we may see some prototypes to try to address
> this problem.
> 
> Thanks,
> Qu
> 
> 
>> 2) the data is referenced but doesn't have a checksum (nocow): we cannot
>> ensure the corruption of the data if checksum is not enabled. We can
>> only ensure the availability of the data (which may be corrupted)
>> 3) the data is not referenced: so the data is good.
>>
>> So in effect for the case 2) the data may be corrupted and not
>> recoverable (but this is true in any case); but for the case 1) from a
>> theoretical point of view it seems recoverable. Of course this has a
>> cost: you need to read the stripe and their checksum (doing a recovery
>> if needed) before updating any part of the stripe itself, maintaining a
>> strict order between the read and the writing.
>>
>>

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

