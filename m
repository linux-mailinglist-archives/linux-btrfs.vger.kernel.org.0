Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E557F4D1
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jul 2022 13:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiGXL1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jul 2022 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGXL1e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jul 2022 07:27:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26C140AA
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658662049;
        bh=ka42AUBV6Sk6xPcFcvwK3P6b6JLPNWKi116Zj3QfSgM=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=C/ponQbxVv3Ust3BCg330zQBL/WfasiXARie2Hhy6FtEfagD04Cbbk9yIqOZDW6U5
         sgsbEb5721DRZ/SQSa4OTXXqLluNfntLwMmORXWuFBvh2CQpMknWEJsnjFzktDMzu+
         3yM886ny+oxQXyMtJ8iFvs8UoKDKdHHTkqb3xJco=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHnm-1nNKSQ1BZi-00tgyo; Sun, 24
 Jul 2022 13:27:28 +0200
Message-ID: <390ec19b-3bbd-8eba-ea54-01a31e6b745c@gmx.com>
Date:   Sun, 24 Jul 2022 19:27:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Forza <forza@tnonline.net>, Qu Wenruo <wqu@suse.com>,
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
 <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
 <b62a80a.e3c8d435.182134a0f8d@tnonline.net>
 <829a9b85-db35-1527-bf3d-081c3f4211b2@gmx.com>
 <dce8715a-3179-6e58-1958-0747a17e2a38@tnonline.net>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
In-Reply-To: <dce8715a-3179-6e58-1958-0747a17e2a38@tnonline.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:62VbfcjV2Sr36uhlAtK/uH2BUqXA8PBSCt5e4xd+oTxk51K0b+N
 haVyAtG89kY7nQEajf+BM8uvFTeTYClX2l6hef5yLcpp/n071iPmx/JOPbWUfHbhYjSYeNH
 tgd9EByU8mHk8UtVDgC9Yw4x9lJP2SXSVYyt8/zRxXU/O09DxwVgxsiVw1TaXR2ea1ghyZj
 ojF3AAe9E7E17mHlX7YsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yu+v6OJgyAI=:HuMSEjUS93wj8hWo3HoDK0
 Jzyhgx89RzsljgMa/M9bxa4eVuA0RkAUZIHaQnKqosDjiGqE1Nm6xtBV+KrcBWyUlJGjNalaj
 Gj03otm0GmtkIqQLEHGmVYDgwcmK6jLCp6xiLtkY4US7ieyWOyFCqHgmoACl5Jl/0K3PeyF5s
 YKwIXtLNAX1L4KCtgH2FJrPWzdsNxpbz1YNsvsWfTIaMT8Kjifh3QBhlkjnNoy7c6HzOzT1JO
 bc51AlAgMFpZO9GMMhCFRxUnw1pckDrmZ/wJm+81dkGeB0zJw5VAHXCON+HX76REqpSMc8A87
 Z4JWqztAsBKx24oU8f2IvW2PiXkRyxLs5ihPEmhdJKR9mwOWzRYoGcys8jZ76yVet2QKNN62+
 rP4xKt2xoiLOi337Quw8KxYAQAXzg6cFwO2PGU3dymP01OJeaanJWo/78dtm0ntcLnLAmjLIA
 udXEL1ExMUpT6Po9m5NZKAOq1iAOuHiQsb7sychkHv+UbxeYyegGMSVrFaEAxCT2qvTz52+gu
 1gfN/3vH5lT7fScTnFJvvNf1w5qABMW8WDmIpDqghuqF7PH/mwphj0CMdyGdk9pisPsRRApon
 4LAZ6iXINhK0f1KNKygngcn1kyAQqidhu4pAd0R46r5RvJ3zXmxHxYMbfh1AcpK3uP9Xo+oVx
 vhw1OJVrpLz5cTh9/Q8ilzTFpCSiZ0Qc1Mfh9Tmrr/baW63VIpVXqZWWFNveqtXkDwMRyD/ZE
 vGC/e1dsLWZAOzn5ZtehrQJSTIqMmguXPRCRCa9HfJLKQbosaki06FbRqKZeDgwzgm2cn/Mio
 6ynmWRdfV2+lDax45LMTccXJ0g0MOGRASQxf9i1+laS7C/4GOYOB8DOBes28lyjQaIfpaIEHe
 V5GN7nNuCusz9eiTLkIuX8wY33hjz4Rh0DGCvkPwCfhlL7TRnh2nTj8xv/P1xhDd8d23MVOg1
 DfqomT6zQ+gvGqBOCe9UPAyiUUvx4ZgoIs0x9+ReV/XWKzwo20yCNkAxbUnCFkVHvUXduNx0M
 7vw3IKzybxAC7PfCB/XyO5Bn5YbWZL7C89xLOSMy2W4nbMhW2xbZ3/82bi3ajh/sE291B6yWW
 kFvOYfkAtetD+PtjdtZgfD7DJ49qwZPmEP/v7nUfJv88tUAUt7DayFSRg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/21 22:51, Forza wrote:
>
>
> On 2022-07-19 03:19, Qu Wenruo wrote:
>>
>>
>> On 2022/7/19 05:49, Forza wrote:
>>>
>>>
>>> ---- From: Chris Murphy <lists@colorremedies.com> -- Sent: 2022-07-15
>>> - 22:14 ----
>>>
>>>> On Fri, Jul 15, 2022 at 1:55 PM Goffredo Baroncelli
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
>>>>> Personally I think that the ZFS variable stripe size, may be
>>>>> interesting
>>>>> to evaluate. Moreover, because the BTRFS disk format is quite
>>>>> flexible,
>>>>> we can store different BG with different number of disks.
>>>
>>> We can create new types of BGs too. For example parity BGs.
>>>
>>>>> Let me to make an
>>>>> example: if we have 10 disks, we could allocate:
>>>>> 1 BG RAID1
>>>>> 1 BG RAID5, spread over 4 disks only
>>>>> 1 BG RAID5, spread over 8 disks only
>>>>> 1 BG RAID5, spread over 10 disks
>>>>>
>>>>> So if we have short writes, we could put the extents in the RAID1
>>>>> BG; for longer
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
>>>
>>> Do we need to implement RAID56 in the traditional sense? As the
>>> user/sysadmin I care about redundancy and performance and cost. The
>>> option to create redundancy for any 'n drives is appealing from a
>>> cost perspective, otherwise I'd use RAID1/10.
>>
>> Have you heard any recent problems related to dm-raid56?
>
> No..?

Then, I'd say their write-intent + journal (PPL for RAID5, full journal
for RAID6) is a tried and true solution.

I see no reason not to follow.

>
>>
>> If your answer is no, then I guess we already have an=C2=A0 answer to y=
our
>> question.
>>
>>>
>>> Since the current RAID56 mode have several important drawbacks
>>
>> Let me to be clear:
>>
>> If you can ensure you didn't hit power loss, or after a power loss do a
>> scrub immediately before any new write, then current RAID56 is fine, at
>> least not obviously worse than dm-raid56.
>>
>> (There are still common problems shared between both btrfs raid56 and
>> dm-raid56, like destructive-RMW)
>>
>>> - and that it's officially not recommended for production use - it is
>>> a good idea to reconstruct new btrfs 'redundant-n' profiles that
>>> doesn't have the inherent issues of traditional RAID.
>>
>> I'd say the complexity is hugely underestimated.
>
> You are probably right. But is it solvable, and is there a vision of
> 'something better' than traditional RAID56?

I'd say, maybe.

I prefer some encode at file extent level (like compression) to provide
extra data recovery, other than relying on stripe based RAID56.

The problem is, normally such encoding is to correct data corruption for
a small percentage, but for regular RAID1/10 or even small number of
disks RAID56, the percentage is not small.

(missing 1 disk in 3 disks RAID5, we're in fact recovery 50% of our data)

If we can find a good encode (probably used after compression), I'm 100%
fine to use that encoding, other than traditional RAID56.

>
>>
>>> For example a non-striped redundant-n profile as well as a striped
>>> redundant-n profile.
>>
>> Non-striped redundant-n profile is already so complex that I can't
>> figure out a working idea right now.
>>
>> But if there is such way, I'm pretty happy to consider.
>
> Can we borrow ideas from the PAR2/PAR3 format?
>
> For each extent, create 'par' redundancy metadata that allows for n-% or
> n-copies of recovery, and that this metadata is also split on different
> disks to allow for n total drive-failures? Maybe parity data can be
> stored in parity BGs, in metadata itself or in special type of extents
> inside data BGs.

The problem is still there, if there is anything representing a stripe,
and any calculate extra info based on stripes, then we can still hit the
write-hole problem.

If we do sub-stripe write, we have to update the checksum or whatever,
which can be out-of-sync during power loss.


If you mean an extra tree to store all these extra checksum/info (aka,
no longer need the stripe unit at all), then I guess it may be possible.

Like we use a special csum algorithm which may take way larger space
than our current 32 bytes per 4K, then I guess we may be able to get
extra redundancy.

There will be some problems like different metadata/data csum (metadata
csum is limited to 32bytes as it's inlined), and way larger metadata
usage for csum.

But those should be more or less solvable.

>
>>
>>>
>>>>
>>>> My 2 cents...
>>>>
>>>> Regarding the current raid56 support, in order of preference:
>>>>
>>>> a. Fix the current bugs, without changing format. Zygo has an
>>>> extensive list.
>>>
>>> I agree that relatively simple fixes should be made. But it seems we
>>> will need quite a large rewrite to solve all issues? Is there a
>>> minium viable option here?
>>
>> Nope. Just see my write-intent code, already have prototype (just needs
>> new scrub based recovery code at mount time) working.
>>
>> And based on my write-intent code, I don't think it's that hard to
>> implement a full journal.
>>
>
> This is good news. Do you see any other major issues that would need
> fixing before RADI56 can be considered production-ready?

Currently I have only finished write-intent bitmaps, which requires
after power loss, all devices are still available and data not touched
is still correct.

For powerloss + missing device, I have to go full journal, but the code
should be pretty similar thus I'm not that concerned.


The biggest problem remaining is, write-intent bitmap/full journal
requires regular devices, no support for zoned devices at all.

Thus zoned guys are not a big fan of this solution.

Thanks,
Qu

>
>
>> Thanks,
>> Qu
>>
>>>
>>>> b. Mostly fix the write hole, also without changing the format, by
>>>> only doing COW with full stripe writes. Yes you could somehow get
>>>> corrupt parity still and not know it until degraded operation produce=
s
>>>> a bad reconstruction of data - but checksum will still catch that.
>>>> This kind of "unreplicated corruption" is not quite the same thing as
>>>> the write hole, because it isn't pernicious like the write hole.
>>>
>>> What is the difference to a)? Is write hole the worst issue? Judging
>>> from the #brtfs channel discussions there seems to be other quite
>>> severe issues, for example real data corruption risks in degraded mode=
.
>>>
>>>> c. A new de-clustered parity raid56 implementation that is not
>>>> backwards compatible.
>>>
>>> Yes. We have a good opportunity to work out something much better
>>> than current implementations. We could have=C2=A0 redundant-n profiles
>>> that also works with tired storage like ssd/nvme similar to the
>>> metadata on ssd idea.
>>>
>>> Variable stripe width has been brought up before, but received cool
>>> responses. Why is that? IMO it could improve random 4k ios by doing
>>> equivalent to RAID1 instead of RMW, while also closing the write
>>> hole. Perhaps there is a middle ground to be found?
>>>
>>>
>>>>
>>>> Ergo, I think it's best to not break the format twice. Even if a new
>>>> raid implementation is years off.
>>>
>>> I very agree here. Btrfs already suffers in public opinion from the
>>> lack of a stable and safe-for-data RAID56, and requiring several
>>> non-compatible chances isn't going to help.
>>>
>>> I also think it's important that the 'temporary' changes actually
>>> leads to a stable filesystem. Because what is the point otherwise?
>>>
>>> Thanks
>>> Forza
>>>
>>>>
>>>> Metadata centric workloads suck on parity raid anyway. If Btrfs alway=
s
>>>> does full stripe COW won't matter even if the performance is worse
>>>> because no one should use parity raid for this workload anyway.
>>>>
>>>>
>>>> --
>>>> Chris Murphy
>>>
>>>
