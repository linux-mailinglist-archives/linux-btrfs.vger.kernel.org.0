Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34385576D6C
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Jul 2022 13:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiGPLML (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 Jul 2022 07:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiGPLMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 Jul 2022 07:12:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4829495BF
        for <linux-btrfs@vger.kernel.org>; Sat, 16 Jul 2022 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657969920;
        bh=VEN9L2DMbcrDAKJA/lQMQvhPRO8C8CXYPFTcZ0zN294=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=WMDibXFZl4bnXZGcZieyfCSB+69x1p4m/d9bmsfMRWqpzwo0Ifa5Yj5ByBm11heM+
         ygPH4WylF5TGKmDTtlkJjjvyIWRqt1OVd8vW+zIKJmPSF7PwMRHxZ0MYuIAbK4WTgS
         YrREM9r3nPyv31MO+GKoNjp3gUcDolys2LjVp5gg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXp5Q-1o2qRv3Cgu-00YDm7; Sat, 16
 Jul 2022 13:12:00 +0200
Message-ID: <928e46e3-51d2-4d7a-583a-5440f415671e@gmx.com>
Date:   Sat, 16 Jul 2022 19:11:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Thiago Ramon <thiagoramon@gmail.com>, kreijack@inwind.it
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
In-Reply-To: <1dcfecba-92fc-6f49-bdea-705896ece036@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NwflKomuAWbE6hOLRVTRcYRJ91QNNO/XAZIGcYUdho738FrsNym
 BgR0c8p/lFDgzwaQh3qNcB7b0Z6F5izt34y2BkmGOGXNx4Rumf4O/F3T9fzCnuhQLgSny28
 p45JK8fihqDDSRO4UDKlg0p9slTVEFjxMPBEybvhnFaqiS7VqOfVpoOx9/mTkZSHzcZiCUS
 m6TWwo/mKqaJFzeYJtkEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oikA+Ng/JPo=:r+CRVaiyAqgLSqZF1K3tnK
 uyU16k4WQyaQ3hqiRzhLMrV18WhJc6aS4Pv8xuwvYmEuS40IeNv+aHCVPDXV/ghQnJJ0SbKHB
 OrxK12RRG+VFjYFUiF1/Y+LjHTqOStQcY/zmLmu58074VIdbT7BafmSc6uSaDKZ+qILPBe6Wc
 55jS+RNdI1gx7OCAU8oeuhkSIubZetYRHqY1kMyblR1e2hKgo2dlt+dqsl3QGsm0qKusKCUWN
 ZAomdUbkn4hWBZ6UJ17tMSUtO7iD41qHLgnAW3aQx+oJFfGdVOsFDkcR9P4JT7zqgG6U7vaCy
 ascp7DkKXVYYT+PECMetsUOtKReaiZwcogtLfvlkOUk3Xi2DY9QQSEJ528tUmD8AKWL5ywjr9
 E4nTuKpzgcQeSGdgb5k/8w1IHBD7NKt604ECKh3wGFQn5FA5NNdsi7Rs2+Dda6faNZnHWQ7ZM
 MEi/iHseAQH5fWqhp3PoXMrMjqAosT1XM0XAwIg1mWusn7grKkIdpL9i35iq+AkVIog3p/oPc
 acuxsil5Qk7zyAZp0WwKGt7RKLFh9TvTw7nc6uzRpOTENPozhWtqXF5m96UxaLrz0GbC7NIxE
 c+25FDe0ec4wt60MWgSx7i/78EPwdOUu17I4suP5wUk/317YmgnYCoqh1XRsqcY5XErx5d27B
 j9FqZvIEWNpKeUhIHnuUma8pncn0ejPCXxoNtbXWM/gkJzBhysWYNBx6zkxWGyFzWO7eX2lzS
 6cFhfxeYEAUhjZIrbiALVlyiY4Bhl90CrvH01BaqxznkUbQUtP/AX2EYX9Gp+0ffK9QjBQO6l
 dAcOs2fNEE+RqDJCCfmcM4wPmWxVBAzDySB1H265dQXmC8XY8GQKgO4vhVs3M2+uAffm+n3F0
 jqvYi+uxz9SAAHne43uNiqDO6gN6P85qNRmN840XZ9WhS5j39sbD+s9znutn7ZF8pzi9ZtRsE
 ihPsvPOSKyFpbY7LjqQJUGVXCuYyF+HLc9h1gz4a/g9z1sHN0v7xUooktbB5XOEqvdeS9gkt8
 NBS135iJY+70bbr51eaw9ZU0yUhyYfWYIPN3onV9NO24y7X8ec8Dkqy60Q2SW9Or/1W5sgDyW
 Yk00lLcznKUz81kdmpYdme6vSttLlUBf3DhpMJf/VUaHBRnBd/UoikLPg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/16 08:34, Qu Wenruo wrote:
>
>
> On 2022/7/16 03:08, Thiago Ramon wrote:
>> As a user of RAID6 here, let me jump in because I think this
>> suggestion is actually a very good compromise.
>>
>> With stripes written only once, we completely eliminate any possible
>> write-hole, and even without any changes on the current disk layout
>> and allocation,
>
> Unfortunately current extent allocator won't understand the requirement
> at all.
>
> Currently the extent allocator although tends to use clustered free
> space, when it can not find a clustered space, it goes where it can find
> a free space. No matter if it's a substripe write.
>
>
> Thus to full stripe only write, it's really the old idea about a new
> extent allocator to avoid sub-stripe writes.
>
> Nowadays with the zoned code, I guess it is now more feasible than
> previous.
>
> Now I think it's time to revive the extent allcator idea, and explore
> the extent allocator based idea, at least it requires no on-disk format
> change, which even write-intent still needs a on-disk format change (at
> least needs a compat ro flag)

After more consideration, I am still not confident of above extent
allocator avoid sub-stripe write.

Especially for the following ENOSPC case (I'll later try submit it as an
future proof test case for fstests).

=2D--
   mkfs.btrfs -f -m raid1c3 -d raid5 $dev1 $dev2 $dev3
   mount $dev1 $mnt
   for (( i=3D0;; i+=3D2 )) do
	xfs_io -f -c "pwrite 0 64k" $mnt/file.$i &> /dev/null
	if [ $? -ne 0 ]; then
		break
	fi
	xfs_io -f -c "pwrite 0 64k" $mnt/file.$(($i + 1)) &> /dev/null
	if [ $? -ne 0 ]; then
		break
	fi
	sync
   done
   rm -rf -- $mnt/file.*[02468]
   sync
   xfs_io -f -c "pwrite 0 4m" $mnt/new_file
=2D--

The core idea of above script it, fill the fs using 64K extents.
Then delete half of them interleavely.

This will make all the full stripes to have one data stripe fully
utilize, one free, and all parity utilized.

If you go extent allocator that avoid sub-stripe write, then the last
write will fail.

If you RST with regular devices and COWing P/Q, then the last write will
also fail.

To me, I don't care about performance or latency, but at least, what we
can do before, but now if a new proposed RAID56 can not do, then to me
it's a regression.

I'm not against RST, but for RST on regular devices, we still need GC
and reserved block groups to avoid above problems.

And that's why I still prefer write-intent, it brings no possible
regression.

>
>> there shouldn't be much wasted space (in my case, I
>> have a 12-disk RAID6, so each full stripe holds 640kb, and discounting
>> single-sector writes that should go into metadata space, any
>> reasonable write should fill that buffer in a few seconds).

Nope, the problem is not that simple.

Consider this, you have an application doing an 64K write DIO.

Then with allocator prohibiting sub-stripe write, it will take a full
640K stripe, wasting 90% of your space.


Furthermore, even if you have some buffered write, merged into an 640KiB
full stripe, but later 9 * 64K of data extents in that full stripe get
freed.
Then you can not use that 9 * 64K space anyway.

That's why zoned device has GC and reserved zones.

If we go allocator way, then we also need a non-zoned GC and reserved
block groups.

Good luck implementing that feature just for RAID56 on non-zoned devices.

Thanks,
Qu

>>
>> The additional suggestion of using smaller stripe widths in case there
>> isn't enough data to fill a whole stripe would make it very easy to
>> reclaim the wasted space by rebalancing with a stripe count filter,
>> which can be easily automated and run very frequently.
>>
>> On-disk format also wouldn't change and be fully usable by older
>> kernels, and it should "only" require changes on the allocator to
>> implement.
>>
>> On Fri, Jul 15, 2022 at 2:58 PM Goffredo Baroncelli
>> <kreijack@libero.it> wrote:
>>>
>>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
>>>> On 14.07.22 09:32, Qu Wenruo wrote:
>>>>> [...]
>>>>
>>>> Again if you're doing sub-stripe size writes, you're asking stupid
>>>> things and
>>>> then there's no reason to not give the user stupid answers.
>>>>
>>>
>>> Qu is right, if we consider only full stripe write the "raid hole"
>>> problem
>>> disappear, because if a "full stripe" is not fully written it is not
>>> referenced either.
>>>
>>>
>>> Personally I think that the ZFS variable stripe size, may be interesti=
ng
>>> to evaluate. Moreover, because the BTRFS disk format is quite flexible=
,
>>> we can store different BG with different number of disks. Let me to
>>> make an
>>> example: if we have 10 disks, we could allocate:
>>> 1 BG RAID1
>>> 1 BG RAID5, spread over 4 disks only
>>> 1 BG RAID5, spread over 8 disks only
>>> 1 BG RAID5, spread over 10 disks
>>>
>>> So if we have short writes, we could put the extents in the RAID1 BG;
>>> for longer
>>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by
>>> length
>>> of the data.
>>>
>>> Yes this would require a sort of garbage collector to move the data
>>> to the biggest
>>> raid5 BG, but this would avoid (or reduce) the fragmentation which
>>> affect the
>>> variable stripe size.
>>>
>>> Doing so we don't need any disk format change and it would be
>>> backward compatible.
>>>
>>>
>>> Moreover, if we could put the smaller BG in the faster disks, we
>>> could have a
>>> decent tiering....
>>>
>>>
>>>> If a user is concerned about the write or space amplicfication of
>>>> sub-stripe
>>>> writes on RAID56 he/she really needs to rethink the architecture.
>>>>
>>>>
>>>>
>>>> [1]
>>>> S. K. Mishra and P. Mohapatra,
>>>> "Performance study of RAID-5 disk arrays with data and parity cache,"
>>>> Proceedings of the 1996 ICPP Workshop on Challenges for Parallel
>>>> Processing,
>>>> 1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.
>>>
>>> --
>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D=C2=A0 17B2 0EDA 9B37 8B82 E0B=
5
>>>
