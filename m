Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3F57CE36
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 16:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiGUOvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiGUOvj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 10:51:39 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BE887F4A
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 07:51:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 198863F5FA;
        Thu, 21 Jul 2022 16:51:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PkmpV95bVeBh; Thu, 21 Jul 2022 16:51:16 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 06F143F20C;
        Thu, 21 Jul 2022 16:51:15 +0200 (CEST)
Received: from [192.168.0.10] (port=56485)
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1oEXWA-000IlJ-Pp; Thu, 21 Jul 2022 16:51:15 +0200
Message-ID: <dce8715a-3179-6e58-1958-0747a17e2a38@tnonline.net>
Date:   Thu, 21 Jul 2022 16:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Forza <forza@tnonline.net>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Content-Language: en-GB
To:     Qu Wenruo <wqu@suse.com>,
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
In-Reply-To: <829a9b85-db35-1527-bf3d-081c3f4211b2@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022-07-19 03:19, Qu Wenruo wrote:
> 
> 
> On 2022/7/19 05:49, Forza wrote:
>>
>>
>> ---- From: Chris Murphy <lists@colorremedies.com> -- Sent: 2022-07-15 
>> - 22:14 ----
>>
>>> On Fri, Jul 15, 2022 at 1:55 PM Goffredo Baroncelli 
>>> <kreijack@libero.it> wrote:
>>>>
>>>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
>>>>> On 14.07.22 09:32, Qu Wenruo wrote:
>>>>>> [...]
>>>>>
>>>>> Again if you're doing sub-stripe size writes, you're asking stupid 
>>>>> things and
>>>>> then there's no reason to not give the user stupid answers.
>>>>>
>>>>
>>>> Qu is right, if we consider only full stripe write the "raid hole" 
>>>> problem
>>>> disappear, because if a "full stripe" is not fully written it is not
>>>> referenced either.
>>>>
>>>>
>>>> Personally I think that the ZFS variable stripe size, may be 
>>>> interesting
>>>> to evaluate. Moreover, because the BTRFS disk format is quite flexible,
>>>> we can store different BG with different number of disks.
>>
>> We can create new types of BGs too. For example parity BGs.
>>
>>>> Let me to make an
>>>> example: if we have 10 disks, we could allocate:
>>>> 1 BG RAID1
>>>> 1 BG RAID5, spread over 4 disks only
>>>> 1 BG RAID5, spread over 8 disks only
>>>> 1 BG RAID5, spread over 10 disks
>>>>
>>>> So if we have short writes, we could put the extents in the RAID1 
>>>> BG; for longer
>>>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by 
>>>> length
>>>> of the data.
>>>>
>>>> Yes this would require a sort of garbage collector to move the data 
>>>> to the biggest
>>>> raid5 BG, but this would avoid (or reduce) the fragmentation which 
>>>> affect the
>>>> variable stripe size.
>>>>
>>>> Doing so we don't need any disk format change and it would be 
>>>> backward compatible.
>>
>> Do we need to implement RAID56 in the traditional sense? As the 
>> user/sysadmin I care about redundancy and performance and cost. The 
>> option to create redundancy for any 'n drives is appealing from a cost 
>> perspective, otherwise I'd use RAID1/10.
> 
> Have you heard any recent problems related to dm-raid56?

No..?

> 
> If your answer is no, then I guess we already have an  answer to your
> question.
> 
>>
>> Since the current RAID56 mode have several important drawbacks
> 
> Let me to be clear:
> 
> If you can ensure you didn't hit power loss, or after a power loss do a
> scrub immediately before any new write, then current RAID56 is fine, at
> least not obviously worse than dm-raid56.
> 
> (There are still common problems shared between both btrfs raid56 and
> dm-raid56, like destructive-RMW)
> 
>> - and that it's officially not recommended for production use - it is 
>> a good idea to reconstruct new btrfs 'redundant-n' profiles that 
>> doesn't have the inherent issues of traditional RAID.
> 
> I'd say the complexity is hugely underestimated.

You are probably right. But is it solvable, and is there a vision of 
'something better' than traditional RAID56?

> 
>> For example a non-striped redundant-n profile as well as a striped 
>> redundant-n profile.
> 
> Non-striped redundant-n profile is already so complex that I can't
> figure out a working idea right now.
> 
> But if there is such way, I'm pretty happy to consider.

Can we borrow ideas from the PAR2/PAR3 format?

For each extent, create 'par' redundancy metadata that allows for n-% or 
n-copies of recovery, and that this metadata is also split on different 
disks to allow for n total drive-failures? Maybe parity data can be 
stored in parity BGs, in metadata itself or in special type of extents 
inside data BGs.

> 
>>
>>>
>>> My 2 cents...
>>>
>>> Regarding the current raid56 support, in order of preference:
>>>
>>> a. Fix the current bugs, without changing format. Zygo has an 
>>> extensive list.
>>
>> I agree that relatively simple fixes should be made. But it seems we 
>> will need quite a large rewrite to solve all issues? Is there a minium 
>> viable option here?
> 
> Nope. Just see my write-intent code, already have prototype (just needs
> new scrub based recovery code at mount time) working.
> 
> And based on my write-intent code, I don't think it's that hard to
> implement a full journal.
> 

This is good news. Do you see any other major issues that would need 
fixing before RADI56 can be considered production-ready?


> Thanks,
> Qu
> 
>>
>>> b. Mostly fix the write hole, also without changing the format, by
>>> only doing COW with full stripe writes. Yes you could somehow get
>>> corrupt parity still and not know it until degraded operation produces
>>> a bad reconstruction of data - but checksum will still catch that.
>>> This kind of "unreplicated corruption" is not quite the same thing as
>>> the write hole, because it isn't pernicious like the write hole.
>>
>> What is the difference to a)? Is write hole the worst issue? Judging 
>> from the #brtfs channel discussions there seems to be other quite 
>> severe issues, for example real data corruption risks in degraded mode.
>>
>>> c. A new de-clustered parity raid56 implementation that is not
>>> backwards compatible.
>>
>> Yes. We have a good opportunity to work out something much better than 
>> current implementations. We could have  redundant-n profiles that also 
>> works with tired storage like ssd/nvme similar to the metadata on ssd 
>> idea.
>>
>> Variable stripe width has been brought up before, but received cool 
>> responses. Why is that? IMO it could improve random 4k ios by doing 
>> equivalent to RAID1 instead of RMW, while also closing the write hole. 
>> Perhaps there is a middle ground to be found?
>>
>>
>>>
>>> Ergo, I think it's best to not break the format twice. Even if a new
>>> raid implementation is years off.
>>
>> I very agree here. Btrfs already suffers in public opinion from the 
>> lack of a stable and safe-for-data RAID56, and requiring several 
>> non-compatible chances isn't going to help.
>>
>> I also think it's important that the 'temporary' changes actually 
>> leads to a stable filesystem. Because what is the point otherwise?
>>
>> Thanks
>> Forza
>>
>>>
>>> Metadata centric workloads suck on parity raid anyway. If Btrfs always
>>> does full stripe COW won't matter even if the performance is worse
>>> because no one should use parity raid for this workload anyway.
>>>
>>>
>>> -- 
>>> Chris Murphy
>>
>>
