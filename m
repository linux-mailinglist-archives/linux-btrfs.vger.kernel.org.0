Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909F45B18A0
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Sep 2022 11:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIHJ2T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Sep 2022 05:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIHJ2S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Sep 2022 05:28:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5C2E127B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Sep 2022 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662629292;
        bh=YksnPiaUMcFqustWxZEAee8AJ7+Cw6q2NmiSheWvffI=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=ZEdy330AHs+nl4MV0WDyZBA0P4/IsAcwBbMVoqTOyHW7cSfun5TWEF74sC1ltH9Za
         plMcqNA4A+1d0gZsczDdA5h9WrcwCwIjerESA3VL6DaEqfCITLXaXFB0bLRahci1CU
         rdLmCKTXwhAW0dx4UfdfhJxcto+KNF6cDvb9m09o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4Jqb-1oVwiI28nJ-000Khh; Thu, 08
 Sep 2022 11:28:12 +0200
Message-ID: <f7cd8b0f-be71-4503-fb75-3df97c7950e7@gmx.com>
Date:   Thu, 8 Sep 2022 17:28:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     hmsjwzb <hmsjwzb@zoho.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <fb056073-5bd6-6143-9699-4a5af1bd496d@zoho.com>
 <655f97cc-64e6-9f57-5394-58f9c3b83a6f@gmx.com>
 <40b209eb-9048-da0c-e776-5e143ab38571@zoho.com>
 <72a78cc0-4524-47e7-803c-7d094b8713ee@gmx.com>
 <00984321-3006-764d-c29e-1304f89652ae@zoho.com>
 <18300547-1811-e9da-252e-f9476dca078c@gmx.com>
 <4691b710-3d71-bd26-d00a-66cc398f57c5@zoho.com>
 <7553372e-1485-63ae-d3f1-e9e0a318b2f6@gmx.com>
 <9c295a8c-5167-116e-4fae-d548f1deb3b2@zoho.com>
 <1b00d889-bf4b-a092-38c0-fb6c6aa09fdf@gmx.com>
 <e2e84e6c-147a-b54b-1213-32a1b7c34660@zoho.com>
 <70caa5b6-af86-2841-c602-602c0306fca2@gmx.com>
 <fa865b92-fb3b-19d8-81d9-fad7928da6ba@zoho.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: some help for improvement in btrfs
In-Reply-To: <fa865b92-fb3b-19d8-81d9-fad7928da6ba@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yjeiBwV/PkAPEGxy2SfYA6APCqkARoGINPvsCWOOdDjfHJfAuDz
 8/lvEdofhHKYA+fPJPbQ8hKGpOY2T5O/NGOt3VPAFsdTKhqKIDnVXknmNfUNIQjdH8ssx0s
 ETLu0if3YGkEkK+QDhoEkoExLt9H35RVOjURxa2bM3fWMBySnuLJoOZGNB/ezra3D3RMDqM
 JDRkdH6+t0rB60vILPG+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rgL4NYQE8ac=:KNsDYbH1y2axaHS3s+kZXq
 RW/Dydoyi/K5QKFy8SpGVdSfb9S43u/wdfyOI4FOEAjYr9ZN8jFa1+hbuI0a/ERJyrZeqWKik
 e3OzLDTf8of90Qt/rklVNHTnks/bDKArAJOXGpQgSQ5EQT+vu7wEMBn210D7qz/T3NTximpOD
 2RMoUY0dtt9Aen01JtcxkKrKoXV/7B3G97w4gDhLXQXIld+MLBwHPVm6upgKJUx+/4WLRHmGo
 AZ9eytRpQLbxZc+/xo1IDKU0PYXuceWaKHKyRDnmpCqqa6Uv2TWMpYxF6wVpztL99DSl+G19X
 6rWDAW4zW58/RYqmwoffaRfpo0/POBfDsgFK4t3LNlP0QQtBxOvcAlaHUA7u04kchPcba1sJR
 RPMMs/5NWe/AOYj9o3WpM6vP00+KMx15w5wwDXTepboSehrtDh64zySzz7d/Y9d+QbkM2Dix8
 QmeHQ0wie/EehlcR6b/n5jS8gZx0pZYZhE3CS58i4FdIxB+rU/AVpmmE16n/3ekvg08XN93iH
 EdhjEu27LLP+AU+N87++UGjMSKoNNkC5ZY02hGv0oXc0UPyvAJrxoEg5yTXekdLlH7zsSu2UD
 yxKexDutaRUwsWKhwNrHuaumblCKZbe+UHDhwZSAAJb4dDtq0cnwCnseIwy/TJf8EbbCdJlde
 0yXOagHfJ+V9h/dFxAuPKJAI9afKYTaXc+SpXjJHIUuKUNti7yUcJpJMOsER37hyS0xc+Rl97
 OYQk7PDsRI6Ksk8QR6wsiyY1zM3Fj1KHUc7/dunsP2JNxrXhB6RzU5uJBTElfgipo0SPFuNeT
 ptw6PClEVQ92LW8aawAeBw20xMGpam7o+4fHuEFV1GMIPCWFFL4Om7UHU5XNCccJ4hl6YZ/D3
 8MKr2iwd8md1gzhRWdase0capKFbjyLH+XJORXKgeLfI44RGDojFohm+i9o9SWU448wVZyy4g
 p521KS5GdmcQdFnxSI4tRRNuEi6chfujIwT2TlKTTGZGJr7Va5rH3NcJWXZXddQpEoB8KGIiW
 mNkbrCAqoT9YJI3WE3tNw2UNXIyKgZZjXCYyg+fk8rgyU6hEYXK3pv9EJ8CqPSGyRof/08PHi
 Zx4xVKiqDsYeH9XHJSPV4SbNosEGbJ76jW/fkHx4VeYwNoa07wWuOlF50hX9FycucOwEuVrEX
 uuyAQ9TjWzs5xpv0N/qc+yXs2o
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/8 17:21, hmsjwzb wrote:
> Hi Qu,
>
> Thanks for your reply. Sorry for the ambiguous and inaccuracy in last ma=
il.
> This email is intend to express my idea in detail.
>
> [Main idea]
>
>      Calculate the checksum of all blocks in a full stripe. Use these ch=
ecksums to
>      tell which stripe is corrupted.

That means a on-disk format change first.

>
>
> Let's go back to the destructive RMW.
>
> [test case]
>
>      mkfs.btrfs -f -m raid5 -d raid5 -b 1G /dev/vda /dev/vdb /dev/vdc
>      mount /dev/vda /mnt
>      xfs_io -f -c "pwrite -S 0xee 0 64k" /mnt/file1
>      sync
>      umount /dev/vda
>      xfs_io -f -c "pwrite -S 0xff 119865344 64k" /dev/vda
>      mount /dev/vda /mnt
>      xfs_io -f -c "pwrite -S 0xee 0 64k" -c sync /mnt/file2
>
>          At this point, the layout of devices is as follows.
>
>                  |<---stripe1---->|
>          vda |...|CCCCCCCCCCCCCCCC|...|
>
>                  |<---stripe2---->|
>          vdb |...|UUUUUUUUUUUUUUUU|...|
>
>                  |<---parity----->|
>          vdc |...|PPPPPPPPPPPPPPPP|...|
>
> 		C:corrupted    U:unused    P:parity
>
>          Before the data of file2 written to the stripe2 of vdb, we can =
still
>          recover the data of stripe1 by stripe2 and parity.
>          But Here is the problem.
>
>          How can we know which stripe is corrupted?
>            We need checksum for whole stripe.

That's unnecessary.

If we read that file1, we know it's corrupted and will trigger recovery.

So before writing the 2nd data stripe, if we search for checksum of the
full stripe (which would only find the csum for the data stripe 1).

And read out all stripes (data stripe 1, data stripe 2, parity stripe),
then we can compare the checksum against what we found (even csum only
covers data stripe 1).

Then for the range we have csum, we can verify if the csum matches.
If not, try recovery using data stripe 2 and parity, and check again.

>
>
>
>          But If we calculate the checksum of all blocks of a stripe, we =
can also tell which stripe is corrupted.
>          As for our test case, Here is my plan.

I see no obvious benefit.

You need a on-disk format change first, then you also need extra
metadata updates to handle the full stripe update.

Note that, parity is updated more frequently, thus the metadata update
is not that a small thing.

>
>          1. If we use some part or all of stripe1, then we calculate the=
 checksum of stripe1 and stripe2.
>
>          When the write request of file2 comes, we can calculate the che=
cksum of stripe1 and stripe2 block by block
>          in the RMW process. If some block in stripe1 mismatch, then str=
ipe1 is corrupted. If some block in stripe2 mismatch
>          then stripe2 is corrupted.
>
>          In this case, we know stripe1 is corrupted, so we can use strip=
e2 and parity to recover stripe1.
>
>          In my opinion, the checksum stored in checksum tree is by byte =
number. So we can calculate the checksum of stripe2
>          during the writing process and store it to csum tree in later e=
nd_io process.
>
>      cat /mnt/file1 > /dev/null
>      umount /mnt
>
> Thanks,
> Flint
>
> On 9/7/22 04:46, Qu Wenruo wrote:
>>
>>
>> On 2022/9/7 16:24, hmsjwzb wrote:
>>>
>> [...]
>>>> That's the idea to fix the destructive RMW, aka when doing sub-stripe
>>>> write, we need to:
>>>>
>>>> 1. Collected needed data to do the recovery
>>>>  =C2=A0=C2=A0=C2=A0 For data, it should be all csum inside the full s=
tripe.
>>>>  =C2=A0=C2=A0=C2=A0 For metadata, although the csum is inlined, we st=
ill need to find out
>>>>  =C2=A0=C2=A0=C2=A0 which range has metadata, and this can be a littl=
e tricky.
>>>
>>> Hi Qu,
>>>
>>>  =C2=A0=C2=A0 As for fix solution, I think the following method don't =
need a on-disk format.
>>
>> I never mentioned we need a on-disk format change.
>>
>> I just mentioned some pitfalls you need to look after.
>>
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 For Data:
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 When we write to disk, we do che=
cksum for the writing data.
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev1 |...|DDUUUUUUUU=
UU|...|
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev2 |...|UUUUUUUUUU=
UU|...|
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev3 |...|PPPPPPPPPP=
PP|...|
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0D:data Space:unused P:parity=C2=A0 U:unused
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The checksum block will look lik=
e the following.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev1 |...|CC=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |...|
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev2 |...|=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |...|
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev3 |...|=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |...|
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C:Checksum
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 So if data is corrupted in the a=
rea we write, we can know it. But when the corruption happened in
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the unused block. We can do noth=
ing about it.
>>
>> We don't need to bother corruption happened in unused space at all.
>>
>> We only need to ensure our data and parity is correct.
>>
>> So if the data sectors are fine, although parity mismatches, it's not a
>> problem, we just do the regular RMW, and correct parity will be
>> re-calculated and write back to that disk.
>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The checksum of blocks marked wi=
th C will be calculated and inserted into checksum tree.
>>
>> Why insert? There is no insert needed at all.
>>
>> And furthermore, data csum insert happens way later, RAID56 layer shoul=
d
>> not bother to insert the csum.
>>
>> If you're talking about writing the first two sectors, they should not
>> have csum at all, as data COW ensured we can only write data into unuse=
d
>> space.
>>
>> Please make it clear what you're really wanting to do, using W for
>> blocks to write, U for unused, C for old data which has csum.
>>
>> (Don't bother NODATASUM case for now).
>>
>> Thanks,
>> Qu
>>
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 But what if we do the checksum o=
f the full stripe.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |<--stripe1->|
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev1 |...|CCCCCCCCCC=
CC|...|
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |<--stripe2->|
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev2 |...|CCCCCCCCCC=
CC|...|
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev3 |...|=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |...|
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 So in the rmw process, we can do=
 the following operation.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.Calculate the chec=
ksum of blocks in stripe1 and compare them with the checksum in checksum t=
ree.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 If misma=
tch then stripe1 is corrupted, otherwise stripe1 is good.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.We can do the same=
 process for stripe2. So we can tell whether stripe2 is corrupted or good.
>>>  =C2=A0=C2=A0=C2=A0=C2=A03.In this condition, if parity check failed, =
we can know which stripe is corrupted and use the good
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data to =
recover the bad.
>>>
>>> Thanks,
>>> Flint
>>>
>>>> 2. Read out all data and stripe, including the range we're writing in=
to
>>>>  =C2=A0=C2=A0=C2=A0 Currently we skip the range we're going to write,=
 but since we may
>>>>  =C2=A0=C2=A0=C2=A0 need to do a recovery, we need the full stripe an=
yway.
>>>>
>>>> 3. Do full stripe verification before doing RMW.
>>>>  =C2=A0=C2=A0=C2=A0 That's the core recovery, thankfully we should ha=
ve very similiar
>>>>  =C2=A0=C2=A0=C2=A0 code existing already.
>>>>
>>>>>
>>>>> [question]
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0I have noticed this patch.
>>>>>
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [PATCH PoC 0/9] bt=
rfs: scrub: introduce a new family of ioctl, scrub_fs
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hi Qu,
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Is some part of this patch aim to solve this problem?
>>>>
>>>> Nope, that's just to improve scrub for RAID56, nothing related to thi=
s
>>>> destructive RMW thing at all.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Thanks,
>>>>> Flint
>>>>>
>>>>>
>>>>> On 8/16/22 01:38, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/8/16 10:47, hmsjwzb wrote:
>>>>>>> Hi Qu,
>>>>>>>
>>>>>>> Sorry for interrupt you so many times.
>>>>>>>
>>>>>>> As for
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0scrub level checks at RAID56 =
substripe write time.
>>>>>>>
>>>>>>> Is this feature available in latest linux-next branch?
>>>>>>
>>>>>> Nope, no one is working on that, thus no patches at all.
>>>>>>
>>>>>>> Or may I need to get patches from mail list.
>>>>>>> What is the core function of this feature ?
>>>>>>
>>>>>> The following small script would explain it pretty well:
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0 mkfs.btrfs -f -m raid5 -d raid5 -b 1G $dev1 $de=
v2 $dev3
>>>>>>  =C2=A0=C2=A0=C2=A0 mount $dev1 $mnt
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0 xfs_io -f -c "pwrite -S 0xee 0 64K" $mnt/file1
>>>>>>  =C2=A0=C2=A0=C2=A0 sync
>>>>>>  =C2=A0=C2=A0=C2=A0 umount $mnt
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0 # Currupt data stripe 1 of full stripe of above=
 64K write
>>>>>>  =C2=A0=C2=A0=C2=A0 xfs_io -f -c "pwrite -S 0xff 119865344 64K" $de=
v1
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0 mount $dev1 $mnt
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0 # Do a new write into data stripe 2,
>>>>>>  =C2=A0=C2=A0=C2=A0 # We will trigger a RMW, which will use on-disk=
 (corrupted) data to
>>>>>>  =C2=A0=C2=A0=C2=A0 # generate new P/Q.
>>>>>>  =C2=A0=C2=A0=C2=A0 xfs_io -f -c "pwrite -S 0xee 0 64K" -c sync $mn=
t/file2
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0 # Now we can no longer read file1, as its data =
is corrupted, and
>>>>>>  =C2=A0=C2=A0=C2=A0 # above write generated new P/Q using corrupted=
 data stripe 1,
>>>>>>  =C2=A0=C2=A0=C2=A0 # preventing us to recover the data stripe 1.
>>>>>>  =C2=A0=C2=A0=C2=A0 cat $mnt/file1 > /dev/null
>>>>>>  =C2=A0=C2=A0=C2=A0 umount $mnt
>>>>>>
>>>>>> Above script is the best way to demonstrate the "destructive RMW".
>>>>>> Although this is not btrfs specific (other RAID56 is also affected)=
,
>>>>>> it's definitely a real problem.
>>>>>>
>>>>>> There are several different directions to solve it:
>>>>>>
>>>>>> - A way to add CSUM for P/Q stripes
>>>>>>  =C2=A0=C2=A0=C2=A0 In theory this should be the easiest way implem=
entation wise.
>>>>>>  =C2=A0=C2=A0=C2=A0 We can easily know if a P/Q stripe is correct, =
then before doing
>>>>>>  =C2=A0=C2=A0=C2=A0 RMW, we verify the result of P/Q.
>>>>>>  =C2=A0=C2=A0=C2=A0 If the result doesn't match, we know some data =
stripe(s) are
>>>>>>  =C2=A0=C2=A0=C2=A0 corrupted, then rebuild the data first before w=
rite.
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0 Unfortunately, this needs a on-disk format.
>>>>>>
>>>>>> - Full stripe verification before writes
>>>>>>  =C2=A0=C2=A0=C2=A0 This means, before we submit sub-stripe writes,=
 we use some scrub like
>>>>>>  =C2=A0=C2=A0=C2=A0 method to verify all data stripes first.
>>>>>>  =C2=A0=C2=A0=C2=A0 Then we can do recovery if needed, then do writ=
es.
>>>>>>
>>>>>>  =C2=A0=C2=A0=C2=A0 Unfortunately, scrub-like checks has quite some=
 limitations.
>>>>>>  =C2=A0=C2=A0=C2=A0 Regular scrub only works on RO block groups, th=
us extent tree and csum
>>>>>>  =C2=A0=C2=A0=C2=A0 tree are consistent.
>>>>>>  =C2=A0=C2=A0=C2=A0 But for RAID56 writes, we have no such luxury, =
I'm not 100% sure if
>>>>>>  =C2=A0=C2=A0=C2=A0 this can even pass stress tests.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> I think I may use qemu and gdb to get basic understanding about th=
is feature.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Flint
>>>>>>>
>>>>>>> On 8/15/22 04:54, Qu Wenruo wrote:
>>>>>>>> scrub level checks at RAID56 substripe write time.
