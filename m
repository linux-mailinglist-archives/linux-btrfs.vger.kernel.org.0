Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B92A577889
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 00:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiGQWBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jul 2022 18:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQWBl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jul 2022 18:01:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198DACE3A
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658095293;
        bh=1nJ9wpO1m5l0Z74EQS8DyewwSolHSqmoxS/Sz7UGEf4=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=BpELnKCRSEaT1P+T6xgW+mTQNM1bIMjqpnY3OuuiE82zEXlNVUDiw82oeqMF788dW
         LPN1TLClDCrLizwpYIz3ZvfRMF1P2Dav+gOvU9meoJJ4Ni+qtL34VjuShQUtTUcjFh
         HHNEwPm8RWjWZHSUPx9YxYIhs/8oeWjcJjh3CaUs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mw9UE-1nLECH05Rc-00s42g; Mon, 18
 Jul 2022 00:01:33 +0200
Message-ID: <152feb63-4515-c16d-19f1-cb2e9192c2c9@gmx.com>
Date:   Mon, 18 Jul 2022 06:01:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Thiago Ramon <thiagoramon@gmail.com>
Cc:     kreijack@inwind.it,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
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
 <8742d25e-cb45-1358-8fdd-2a369c8cd212@gmx.com>
 <CAO1Y9woaC+ANYdb-44SYqZN955tk2Rr3hsTjkSGY=YwaU8HF5w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
In-Reply-To: <CAO1Y9woaC+ANYdb-44SYqZN955tk2Rr3hsTjkSGY=YwaU8HF5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jV5kWpypT8PLxq/c9URAubFLew+Toyd/JVG68Ba5V2uSrT1Iy2N
 t+m42j8XAefa1Q5gUAE1htQQZh1Thfg24344imKn8lyY1uiiEfY3cycwumbZ7vId8qnIaNc
 G5JOdv6qyMgglAxdoXhVOJSECUxJw5gsvDZMa5K/pu/SSMa4trD6BL9aZxU5pXRx+cyY5dN
 AcqGILN255MVIIYfiUw7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O1CEd3kYOuY=:PLHNJpRXB7Jm2JBEI7GUiT
 mbG5s8ZzJQTBFXQ3imIkHT6rm6op+SfGfB8Zy77De1MEsqRjSO0QN1hlMZklPfTOQd8c8Twsf
 yEmcRP5YALK1fsGP0XlBBemW1a9/0cJeM8R7jlc2Y4R8wmgc57QnKI09hA65gPBSskV+bIoxN
 aDg0j3z3sFAC11/xsPEFW0A/OTgTpLkx9oIbWSpNkJ7v51LUpsHqiRdNxSgqJfPLIJ46TuK2F
 Z1D86CuWFelXHtiNfBSQRog+fM2u7NY9zbvznCOrlTy3yv3+zY3neAk+bC4IJNsR4/+vHIvTT
 Kx0JqIaG4JR9SZKXL9N6rY2QsYAMLvZnn92s12Qgv03cfljVjimcbgvbdldXuYhG30csTZQQR
 xMsUPomyfJU8F7z1hpOQeIdU15FUXCahtfxLZGM/EL+ATBMI+sdz674B5XgC+2FlqLqOKHMm6
 PJbxaznftPcyBgNpG3OK58BfuYI5GpAcS1Cy5p6lGU+K3s8a8xFACBwhP/RTaIDfpBMTGLfsq
 6pX738vRirKZeVj8dYMaepBM8OhFucDwNmZYEZvwI2plyAC7ORoYrHkUk0EYIhumWzN+pnIsV
 XpbS4ubghxzWUXQd/vb00eSPtdrGAyqaZaOmTfISZBfMw7SGw0h9G0KE4KiOCKkNJcanHY1Bw
 8mMPU1luswVdE4w65TJHwdtQTgXpucQFHAofLqGQanan1lfcTlCrTAEYey+ygd6kD8SE6g75f
 2Y8l/Bnj1lC+b8cF0yqZeeXQ73W+okRPQJd70YAGI+gFxTU4Pr9BFNUj+l3ddqTqraeKnDemO
 dgd+GPqUq/w7HvyZhXN23qPtAa4oaPwM6Lf1J/pdC7wkEe8FKyBRT0IJ4W1WSjyWyc4ka86Bm
 NrLrpiXsC4sGSHJHIKKsgE1TPqCdcE8k6vPcQDUg0+3BDE+fTnlrL0w3+oLxUkQ66JZ8ALTTt
 0YKPxzZjZe8cD8vCf8yurzzQcMmxe30QyjJP2KnUUMycWim3FHkr7W0OAjhSUckBLvwZSS5M/
 b0Pbt6OezNjkPJBhhMRgAxhR/1FKIL6HW0JoLEupFjhi/q1nNLqIHG9IgXzQ53T2Z7J+nZivH
 XSKWxn7xnsM0b8WGSIpnaptBAbSK+HFxJ8WNEo4Fph/T9+Ps/S3ckx1AQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/17 23:18, Thiago Ramon wrote:
> On Sat, Jul 16, 2022 at 9:30 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2022/7/16 21:52, Thiago Ramon wrote:
>>> On Sat, Jul 16, 2022 at 8:12 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>>
>>>>
>>>>
>>>> On 2022/7/16 08:34, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/7/16 03:08, Thiago Ramon wrote:
>>>>>> As a user of RAID6 here, let me jump in because I think this
>>>>>> suggestion is actually a very good compromise.
>>>>>>
>>>>>> With stripes written only once, we completely eliminate any possibl=
e
>>>>>> write-hole, and even without any changes on the current disk layout
>>>>>> and allocation,
>>>>>
>>>>> Unfortunately current extent allocator won't understand the requirem=
ent
>>>>> at all.
>>>>>
>>>>> Currently the extent allocator although tends to use clustered free
>>>>> space, when it can not find a clustered space, it goes where it can =
find
>>>>> a free space. No matter if it's a substripe write.
>>>>>
>>>>>
>>>>> Thus to full stripe only write, it's really the old idea about a new
>>>>> extent allocator to avoid sub-stripe writes.
>>>>>
>>>>> Nowadays with the zoned code, I guess it is now more feasible than
>>>>> previous.
>>>>>
>>>>> Now I think it's time to revive the extent allcator idea, and explor=
e
>>>>> the extent allocator based idea, at least it requires no on-disk for=
mat
>>>>> change, which even write-intent still needs a on-disk format change =
(at
>>>>> least needs a compat ro flag)
>>>>
>>>> After more consideration, I am still not confident of above extent
>>>> allocator avoid sub-stripe write.
>>>>
>>>> Especially for the following ENOSPC case (I'll later try submit it as=
 an
>>>> future proof test case for fstests).
>>>>
>>>> ---
>>>>      mkfs.btrfs -f -m raid1c3 -d raid5 $dev1 $dev2 $dev3
>>>>      mount $dev1 $mnt
>>>>      for (( i=3D0;; i+=3D2 )) do
>>>>           xfs_io -f -c "pwrite 0 64k" $mnt/file.$i &> /dev/null
>>>>           if [ $? -ne 0 ]; then
>>>>                   break
>>>>           fi
>>>>           xfs_io -f -c "pwrite 0 64k" $mnt/file.$(($i + 1)) &> /dev/n=
ull
>>>>           if [ $? -ne 0 ]; then
>>>>                   break
>>>>           fi
>>>>           sync
>>>>      done
>>>>      rm -rf -- $mnt/file.*[02468]
>>>>      sync
>>>>      xfs_io -f -c "pwrite 0 4m" $mnt/new_file
>>>> ---
>>>>
>>>> The core idea of above script it, fill the fs using 64K extents.
>>>> Then delete half of them interleavely.
>>>>
>>>> This will make all the full stripes to have one data stripe fully
>>>> utilize, one free, and all parity utilized.
>>>>
>>>> If you go extent allocator that avoid sub-stripe write, then the last
>>>> write will fail.
>>>>
>>>> If you RST with regular devices and COWing P/Q, then the last write w=
ill
>>>> also fail.
>>>>
>>>> To me, I don't care about performance or latency, but at least, what =
we
>>>> can do before, but now if a new proposed RAID56 can not do, then to m=
e
>>>> it's a regression.
>>>>
>>>> I'm not against RST, but for RST on regular devices, we still need GC
>>>> and reserved block groups to avoid above problems.
>>>>
>>>> And that's why I still prefer write-intent, it brings no possible
>>>> regression.
>>> While the test does fail as-is, rebalancing will recover all the
>>> wasted space.
>>
>> Nope, the fs is already filled, you have no unallocated space to do bal=
ance.
>>
>> That's exactly why zoned btrfs have reserved zones to handle such
>> problem for GC.
>
> Very good point. What would be the implementation difficulty and
> overall impact of ALWAYS reserving space,

To me, it's not simple, especially for non-zoned devices, we don't have
any existing unit like zones to do reservation.

And since we support device with uneven size, it can be pretty tricky to
calculate what size we should really reserve.


At least for now for non-zoned device, we don't have extra reservation
of unallocated space, nor the auto reclaim mechanism.

We may learn from zoned code, but I'm not confident if we should jump
into the rabbit hole at all, especially we already have a write-intent
implementation to avoid all the problem at least for non-zoned devices.


Another (smaller) problem is latency, if we ran of out space, we need to
kick in GC to reclaim space.
IIRC for zoned device it's mostly balancing near-empty zones into a new
zone, which can definitely introduce latency.

Thanks,
Qu
> for exclusive balance usage,
> for at least 1 metadata or data block group, whichever is larger?
> This would obviously create some unusable space on the FS, but I think
> this would solve the majority of ENOSPC problems with all profiles. Of
> course an option to disable this would also be needed for advanced
> usage, but it sounds like a decent default.
>
>>
>>> It's a new gotcha for RAID56, but I think it's still
>>> preferable than the write-hole, and is proper CoW.
>>> Narrowing the stripes to 4k would waste a lot less space overall, but
>>> there's probably code around that depends on the current 64k-tall
>>> stripes.
>>
>> Yes, limiting stripe size to 4K will cause way less wasted space, but
>> the result is still the same for the worst case script, thus still need
>> garbage collecting and reserved space for GC.
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>>>
>>>>>> there shouldn't be much wasted space (in my case, I
>>>>>> have a 12-disk RAID6, so each full stripe holds 640kb, and discount=
ing
>>>>>> single-sector writes that should go into metadata space, any
>>>>>> reasonable write should fill that buffer in a few seconds).
>>>>
>>>> Nope, the problem is not that simple.
>>>>
>>>> Consider this, you have an application doing an 64K write DIO.
>>>>
>>>> Then with allocator prohibiting sub-stripe write, it will take a full
>>>> 640K stripe, wasting 90% of your space.
>>>>
>>>>
>>>> Furthermore, even if you have some buffered write, merged into an 640=
KiB
>>>> full stripe, but later 9 * 64K of data extents in that full stripe ge=
t
>>>> freed.
>>>> Then you can not use that 9 * 64K space anyway.
>>>>
>>>> That's why zoned device has GC and reserved zones.
>>>>
>>>> If we go allocator way, then we also need a non-zoned GC and reserved
>>>> block groups.
>>>>
>>>> Good luck implementing that feature just for RAID56 on non-zoned devi=
ces.
>>> DIO definitely would be a problem this way. As you mention, a separate
>>> zone for high;y modified data would make things a lot easier (maybe a
>>> RAID1Cx zone), but that definitely would be a huge change on the way
>>> things are handled.
>>> Another, easier solution would be disabling DIO altogether for RAID56,
>>> and I'd prefer that if that's the cost of having RAID56 finally
>>> respecting CoW and stopping modifying data shared with other files.
>>> But as you say, it's definitely a regression if we change things this
>>> way, and we'd need to hear from other people using RAID56 what they'd
>>> prefer.
>>>
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>>
>>>>>> The additional suggestion of using smaller stripe widths in case th=
ere
>>>>>> isn't enough data to fill a whole stripe would make it very easy to
>>>>>> reclaim the wasted space by rebalancing with a stripe count filter,
>>>>>> which can be easily automated and run very frequently.
>>>>>>
>>>>>> On-disk format also wouldn't change and be fully usable by older
>>>>>> kernels, and it should "only" require changes on the allocator to
>>>>>> implement.
>>>>>>
>>>>>> On Fri, Jul 15, 2022 at 2:58 PM Goffredo Baroncelli
>>>>>> <kreijack@libero.it> wrote:
>>>>>>>
>>>>>>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
>>>>>>>> On 14.07.22 09:32, Qu Wenruo wrote:
>>>>>>>>> [...]
>>>>>>>>
>>>>>>>> Again if you're doing sub-stripe size writes, you're asking stupi=
d
>>>>>>>> things and
>>>>>>>> then there's no reason to not give the user stupid answers.
>>>>>>>>
>>>>>>>
>>>>>>> Qu is right, if we consider only full stripe write the "raid hole"
>>>>>>> problem
>>>>>>> disappear, because if a "full stripe" is not fully written it is n=
ot
>>>>>>> referenced either.
>>>>>>>
>>>>>>>
>>>>>>> Personally I think that the ZFS variable stripe size, may be inter=
esting
>>>>>>> to evaluate. Moreover, because the BTRFS disk format is quite flex=
ible,
>>>>>>> we can store different BG with different number of disks. Let me t=
o
>>>>>>> make an
>>>>>>> example: if we have 10 disks, we could allocate:
>>>>>>> 1 BG RAID1
>>>>>>> 1 BG RAID5, spread over 4 disks only
>>>>>>> 1 BG RAID5, spread over 8 disks only
>>>>>>> 1 BG RAID5, spread over 10 disks
>>>>>>>
>>>>>>> So if we have short writes, we could put the extents in the RAID1 =
BG;
>>>>>>> for longer
>>>>>>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending b=
y
>>>>>>> length
>>>>>>> of the data.
>>>>>>>
>>>>>>> Yes this would require a sort of garbage collector to move the dat=
a
>>>>>>> to the biggest
>>>>>>> raid5 BG, but this would avoid (or reduce) the fragmentation which
>>>>>>> affect the
>>>>>>> variable stripe size.
>>>>>>>
>>>>>>> Doing so we don't need any disk format change and it would be
>>>>>>> backward compatible.
>>>>>>>
>>>>>>>
>>>>>>> Moreover, if we could put the smaller BG in the faster disks, we
>>>>>>> could have a
>>>>>>> decent tiering....
>>>>>>>
>>>>>>>
>>>>>>>> If a user is concerned about the write or space amplicfication of
>>>>>>>> sub-stripe
>>>>>>>> writes on RAID56 he/she really needs to rethink the architecture.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> [1]
>>>>>>>> S. K. Mishra and P. Mohapatra,
>>>>>>>> "Performance study of RAID-5 disk arrays with data and parity cac=
he,"
>>>>>>>> Proceedings of the 1996 ICPP Workshop on Challenges for Parallel
>>>>>>>> Processing,
>>>>>>>> 1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.
>>>>>>>
>>>>>>> --
>>>>>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>>>>>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>>>>>>
