Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDB577291
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jul 2022 02:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiGQAaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jul 2022 20:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGQAaZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jul 2022 20:30:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333861C90E
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jul 2022 17:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658017817;
        bh=QbPa69ye0qI61VZN+SHq6oCp5Bkx8ffv+d9rGao+SZ4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=A+A1PJT9wGArk1u30QRNSdI89aR34zqnbD4BH3yXcIC3Qn4dck1XbmjFCQLBlyCVE
         UEfQBQpnxxxJGLS71b3Gz53oD5OA53dmjheMnYgg2jt2b1mQ1rw+hrk+FOiR1z6irT
         Fja9yaJR7C54Ti2dR7ZuWBzyEsn9tLxhsjsGg4Kw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3lcJ-1oC3EB0h9f-000qO4; Sun, 17
 Jul 2022 02:30:16 +0200
Message-ID: <8742d25e-cb45-1358-8fdd-2a369c8cd212@gmx.com>
Date:   Sun, 17 Jul 2022 08:30:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Content-Language: en-US
To:     Thiago Ramon <thiagoramon@gmail.com>
Cc:     kreijack@inwind.it,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAO1Y9woJUhuQ+Q2yWSvscnBJb9D5cYiBaY-WG3Re=7V=OzWVhw@mail.gmail.com>
 <1dcfecba-92fc-6f49-bdea-705896ece036@gmx.com>
 <928e46e3-51d2-4d7a-583a-5440f415671e@gmx.com>
 <CAO1Y9woENiZOokwqSeSbmr30w7ksw+ZkXUR9pU68Kmfm8X+K=g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAO1Y9woENiZOokwqSeSbmr30w7ksw+ZkXUR9pU68Kmfm8X+K=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:491hu60b8I0LzI28t7zfcqqbDlmBhWY634AhDpGR3uKmiyZlMVe
 QRTL1XrLGfJeyGa0Pse9kMzNWAnQp8nXf2TQY7iB8VXpysPQTx52XaPlN5U+FPEjP7Dg2d+
 w5bW04OExekF6HxDqZXuKYuM5zjCFb3xtv/u00ptoxKOFsnf6gY5WmqxRsuQ2K05KRD/hWd
 V+6Yq4li9a5A4IVt+xSZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CESV7asTcW4=:lNZgZjtylop9ePIbCCpz/5
 FTumVzuL4wgEIxjsYUmTnsOrRa6SbuWK4XXJuu+UKBmZlwdM97mbtfoy8Nv9bZAq8HHqKg9ne
 fyjQ6+7zP+V8uAOEVF05eiVvl53EC54tmUg0FnR34fyhkVhp83sKKqYoUtcq1sEct1duQgEgZ
 eS4atHdmZWl3jRkqTYbU3xZAzX8CYHJVIyoHCq7uRzh8hxjs8PWobF/+PGGftAkdyQ0kD3yD1
 5HGzJUb1PQgd8to1GMg4tiKzwnzxll1CaDzXhCriERphLo6YPcGzu20hHg2eEhWzhF8vq6DP4
 aJmM1tKf70csWE5JuybUWbdZ3MrGoUW/P8+jQwpaEa25wsNfyyYXD2KOxLz/7Ao5DqD3uljGr
 uQfrLpZREBjDjrKN6kUFK9CNktmMAMgKiNbTbVUESqYbZGMAIS5p6iloDR+S+TNJ/KkRHDavs
 ixmWcIQCCnaVzKEU0BE8hRsoN8AYmQA8THLi3mAL1biHD/QbK3cEZBKppCJBJlT5Fw814j+qB
 p4kcZsTVVdskDPF+io2wcXHasV5IOgvaNXyryS/YVeEDdDGJqhAipZq9T8las885phf4gYgQt
 UJGiBNES5Wg49x/C5xpkLR5K35U2Qq7kvcwXrty30AsR202rycprztbbzoqHIjG7sVqdzFdR+
 odswkgaHYCrUu1bY4JxFvDGfumPs3f0QI9hTe2rmqqmNGZifwY6T1DgWiUyKNhqAGONPOU3i2
 AOEqQu18d4sqxeSkjnmRXIQpcwQQLAJ1eotdTJY4JSeDco+i53yK8pRABXuk8WVgNFDVT485F
 TPPe73Kal82hUuLaGeL33+k32ukVuRnOMQXDSIJuvqlxFN4Z5d3PqM5abNqnK5/2g3pChFM4k
 ojCtoTVBXLWXTaIgsbbcWB+ZtQ6vbWpsUotmxaPI1+mqoKoL+5INc4KKCQTojLn2s9apTiFpX
 D/FS1oYDiKz21/lveoWcPJuFOoprvg40FZE2ZphyVNpJEekY9WTjOdb2yo0sqAyjAqTY8LthR
 9ChVFo5ZJPTz0hvm9gErspy+lQwertCwpcsX9QVeCboEqUTvAIK3xgjlXWpX19ArAuDc/ayZg
 Ue3kNJ2LApvILR2uoWALgw64VzE83bn5QsMqkXnBKOPLPRoYicpWAesNg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/16 21:52, Thiago Ramon wrote:
> On Sat, Jul 16, 2022 at 8:12 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2022/7/16 08:34, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/7/16 03:08, Thiago Ramon wrote:
>>>> As a user of RAID6 here, let me jump in because I think this
>>>> suggestion is actually a very good compromise.
>>>>
>>>> With stripes written only once, we completely eliminate any possible
>>>> write-hole, and even without any changes on the current disk layout
>>>> and allocation,
>>>
>>> Unfortunately current extent allocator won't understand the requiremen=
t
>>> at all.
>>>
>>> Currently the extent allocator although tends to use clustered free
>>> space, when it can not find a clustered space, it goes where it can fi=
nd
>>> a free space. No matter if it's a substripe write.
>>>
>>>
>>> Thus to full stripe only write, it's really the old idea about a new
>>> extent allocator to avoid sub-stripe writes.
>>>
>>> Nowadays with the zoned code, I guess it is now more feasible than
>>> previous.
>>>
>>> Now I think it's time to revive the extent allcator idea, and explore
>>> the extent allocator based idea, at least it requires no on-disk forma=
t
>>> change, which even write-intent still needs a on-disk format change (a=
t
>>> least needs a compat ro flag)
>>
>> After more consideration, I am still not confident of above extent
>> allocator avoid sub-stripe write.
>>
>> Especially for the following ENOSPC case (I'll later try submit it as a=
n
>> future proof test case for fstests).
>>
>> ---
>>     mkfs.btrfs -f -m raid1c3 -d raid5 $dev1 $dev2 $dev3
>>     mount $dev1 $mnt
>>     for (( i=3D0;; i+=3D2 )) do
>>          xfs_io -f -c "pwrite 0 64k" $mnt/file.$i &> /dev/null
>>          if [ $? -ne 0 ]; then
>>                  break
>>          fi
>>          xfs_io -f -c "pwrite 0 64k" $mnt/file.$(($i + 1)) &> /dev/null
>>          if [ $? -ne 0 ]; then
>>                  break
>>          fi
>>          sync
>>     done
>>     rm -rf -- $mnt/file.*[02468]
>>     sync
>>     xfs_io -f -c "pwrite 0 4m" $mnt/new_file
>> ---
>>
>> The core idea of above script it, fill the fs using 64K extents.
>> Then delete half of them interleavely.
>>
>> This will make all the full stripes to have one data stripe fully
>> utilize, one free, and all parity utilized.
>>
>> If you go extent allocator that avoid sub-stripe write, then the last
>> write will fail.
>>
>> If you RST with regular devices and COWing P/Q, then the last write wil=
l
>> also fail.
>>
>> To me, I don't care about performance or latency, but at least, what we
>> can do before, but now if a new proposed RAID56 can not do, then to me
>> it's a regression.
>>
>> I'm not against RST, but for RST on regular devices, we still need GC
>> and reserved block groups to avoid above problems.
>>
>> And that's why I still prefer write-intent, it brings no possible
>> regression.
> While the test does fail as-is, rebalancing will recover all the
> wasted space.

Nope, the fs is already filled, you have no unallocated space to do balanc=
e.

That's exactly why zoned btrfs have reserved zones to handle such
problem for GC.

> It's a new gotcha for RAID56, but I think it's still
> preferable than the write-hole, and is proper CoW.
> Narrowing the stripes to 4k would waste a lot less space overall, but
> there's probably code around that depends on the current 64k-tall
> stripes.

Yes, limiting stripe size to 4K will cause way less wasted space, but
the result is still the same for the worst case script, thus still need
garbage collecting and reserved space for GC.

Thanks,
Qu

>
>>
>>>
>>>> there shouldn't be much wasted space (in my case, I
>>>> have a 12-disk RAID6, so each full stripe holds 640kb, and discountin=
g
>>>> single-sector writes that should go into metadata space, any
>>>> reasonable write should fill that buffer in a few seconds).
>>
>> Nope, the problem is not that simple.
>>
>> Consider this, you have an application doing an 64K write DIO.
>>
>> Then with allocator prohibiting sub-stripe write, it will take a full
>> 640K stripe, wasting 90% of your space.
>>
>>
>> Furthermore, even if you have some buffered write, merged into an 640Ki=
B
>> full stripe, but later 9 * 64K of data extents in that full stripe get
>> freed.
>> Then you can not use that 9 * 64K space anyway.
>>
>> That's why zoned device has GC and reserved zones.
>>
>> If we go allocator way, then we also need a non-zoned GC and reserved
>> block groups.
>>
>> Good luck implementing that feature just for RAID56 on non-zoned device=
s.
> DIO definitely would be a problem this way. As you mention, a separate
> zone for high;y modified data would make things a lot easier (maybe a
> RAID1Cx zone), but that definitely would be a huge change on the way
> things are handled.
> Another, easier solution would be disabling DIO altogether for RAID56,
> and I'd prefer that if that's the cost of having RAID56 finally
> respecting CoW and stopping modifying data shared with other files.
> But as you say, it's definitely a regression if we change things this
> way, and we'd need to hear from other people using RAID56 what they'd
> prefer.
>
>>
>> Thanks,
>> Qu
>>
>>>>
>>>> The additional suggestion of using smaller stripe widths in case ther=
e
>>>> isn't enough data to fill a whole stripe would make it very easy to
>>>> reclaim the wasted space by rebalancing with a stripe count filter,
>>>> which can be easily automated and run very frequently.
>>>>
>>>> On-disk format also wouldn't change and be fully usable by older
>>>> kernels, and it should "only" require changes on the allocator to
>>>> implement.
>>>>
>>>> On Fri, Jul 15, 2022 at 2:58 PM Goffredo Baroncelli
>>>> <kreijack@libero.it> wrote:
>>>>>
>>>>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
>>>>>> On 14.07.22 09:32, Qu Wenruo wrote:
>>>>>>> [...]
>>>>>>
>>>>>> Again if you're doing sub-stripe size writes, you're asking stupid
>>>>>> things and
>>>>>> then there's no reason to not give the user stupid answers.
>>>>>>
>>>>>
>>>>> Qu is right, if we consider only full stripe write the "raid hole"
>>>>> problem
>>>>> disappear, because if a "full stripe" is not fully written it is not
>>>>> referenced either.
>>>>>
>>>>>
>>>>> Personally I think that the ZFS variable stripe size, may be interes=
ting
>>>>> to evaluate. Moreover, because the BTRFS disk format is quite flexib=
le,
>>>>> we can store different BG with different number of disks. Let me to
>>>>> make an
>>>>> example: if we have 10 disks, we could allocate:
>>>>> 1 BG RAID1
>>>>> 1 BG RAID5, spread over 4 disks only
>>>>> 1 BG RAID5, spread over 8 disks only
>>>>> 1 BG RAID5, spread over 10 disks
>>>>>
>>>>> So if we have short writes, we could put the extents in the RAID1 BG=
;
>>>>> for longer
>>>>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by
>>>>> length
>>>>> of the data.
>>>>>
>>>>> Yes this would require a sort of garbage collector to move the data
>>>>> to the biggest
>>>>> raid5 BG, but this would avoid (or reduce) the fragmentation which
>>>>> affect the
>>>>> variable stripe size.
>>>>>
>>>>> Doing so we don't need any disk format change and it would be
>>>>> backward compatible.
>>>>>
>>>>>
>>>>> Moreover, if we could put the smaller BG in the faster disks, we
>>>>> could have a
>>>>> decent tiering....
>>>>>
>>>>>
>>>>>> If a user is concerned about the write or space amplicfication of
>>>>>> sub-stripe
>>>>>> writes on RAID56 he/she really needs to rethink the architecture.
>>>>>>
>>>>>>
>>>>>>
>>>>>> [1]
>>>>>> S. K. Mishra and P. Mohapatra,
>>>>>> "Performance study of RAID-5 disk arrays with data and parity cache=
,"
>>>>>> Proceedings of the 1996 ICPP Workshop on Challenges for Parallel
>>>>>> Processing,
>>>>>> 1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.
>>>>>
>>>>> --
>>>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>>>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>>>>
