Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCF95804EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiGYT6z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 15:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiGYT6y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 15:58:54 -0400
Received: from libero.it (smtp-34.italiaonline.it [213.209.10.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028FA20BED
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 12:58:50 -0700 (PDT)
Received: from [192.168.1.27] ([84.222.35.163])
        by smtp-34.iol.local with ESMTPA
        id G4E2otaVOMK28G4E3oDPoo; Mon, 25 Jul 2022 21:58:47 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1658779127; bh=kqGnhEqJKR0dVvv8gdhVHhE7fAQl4BUy7f3Nv9E78dQ=;
        h=From;
        b=YsTafFmnZ79d+yY3LBGwCHpPZNA93/9bujiwwHmrRF7fXzZadGXGYDAcLoG3RuVT/
         cFbmFPMK5Qe95iP5zKIEnEnIsBP9rxPxHvFAA4ZpOnjz7gAh6ZRKLlGSrjFjFIYRIY
         tsSwBvIgtqepAIrEU8NG2eMoR+cZ/o6nsPR5Vdvh7HPuNRQVYiHkuRQZfKEO6RFDP3
         hdNccy/BKfB+ZQKljIDt1vpB62PiFCCznoz5eKbcKIIjzyxQyX08ozvEVghqCMXVZO
         UStZ7Wtdcqfu2OkmcdKFbkNKOs4KGdtj8pKtqNoVNnX4kCMr0nrBVrevZzZA4/wI5a
         v27nSGIKmH3JA==
X-CNFS-Analysis: v=2.4 cv=a6H1SWeF c=1 sm=1 tr=0 ts=62def5f7 cx=a_exe
 a=FwZ7J7/P4KMHneBNQvmhbg==:117 a=FwZ7J7/P4KMHneBNQvmhbg==:17
 a=IkcTkHD0fZMA:10 a=1UJxPEZwJJEJuDuWUrwA:9 a=QEXdDO2ut3YA:10
Message-ID: <a3d3d872-f0f8-7cd7-7abd-6f4e8f511b57@inwind.it>
Date:   Mon, 25 Jul 2022 21:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Reply-To: kreijack@inwind.it
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Forza <forza@tnonline.net>, Chris Murphy <lists@colorremedies.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
 <b62a80a.e3c8d435.182134a0f8d@tnonline.net>
 <829a9b85-db35-1527-bf3d-081c3f4211b2@gmx.com>
 <Yt3dLAZQk1QGhVo2@hungrycats.org>
Content-Language: en-US
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <Yt3dLAZQk1QGhVo2@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfONUv7korjOe23ScuCeiIuLTRFJzKCBfnCG56PDn3K2iy9XtZ3VupgasPCH5f764DbEiKGFvXo70z/DasA47FoIRnpbD9vj9q3Rqk2kF8VP6qyHk6XYm
 w9RKXhEf2g2vTqY9pT67IvLB28HoCKRvb6Bo0rRRKsxGqsIGrY+g7ccouO2842xPeHl79lV0UK0ly8PzDuQPPBFgNFJMb4+Vmj6ZoU/j15odTHgfSM8DT5Ey
 rsYLnfd3Udb6dWXZnHo7Yh9EIlGelb3D74oS1ukdS7sPcntjtRTbPk6q6KDSub0LEPH4wSTY2D1c/xAr+ZgtVE1jOr2PPKgYbibnkTarZcrUDQj+McsIycpl
 9wdfsQHpdGGrg3OU9ROCHednAPRXERG5RBBxL6xpR+wA2iIF/Io=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/07/2022 02.00, Zygo Blaxell wrote:
> On Tue, Jul 19, 2022 at 09:19:21AM +0800, Qu Wenruo wrote:
[...]
> 
> I'd agree with that.  e.g. some btrfs equivalent of ZFS raidZ (put parity
> blocks inline with extents during writes) is not much more complex to
> implement on btrfs than compression; however, the btrfs kernel code
> couldn't read compressed data correctly for 12 years out of its 14-year
> history, and nobody wants to wait another decade or more for raid5
> to work.
> 
> It seems to me the biggest problem with write hole fixes is that all
> the potential fixes have cost tradeoffs, and everybody wants to veto
> the fix that has a cost they don't like.
> 
> We could implement multiple fix approaches at the same time, as AFAIK
> most of the proposed solutions are orthogonal to each other.  e.g. a
> write-ahead log can safely enable RMW at a higher IO cost, while the
> allocator could place extents to avoid RMW and thereby avoid the logging
> cost as much as possible (paid for by a deferred relocation/garbage
> collection cost), and using both at the same time would combine both
> benefits.  Both solutions can be used independently for filesystems at
> extreme ends of the performance/capacity spectrum (if the filesystem is
> never more than 50% full, then logging is all cost with no gain compared
> to allocator avoidance of RMW, while a filesystem that is always near
> full will have to journal writes and also throttle writes on the journal.

Kudos to Zygo; I have to say that I never encountered before a so clearly
explanation of the complexity around btrfs raid5/6 problems and the related
solutions.

> 
>>> For example a non-striped redundant-n profile as well as a striped redundant-n profile.
>>
>> Non-striped redundant-n profile is already so complex that I can't
>> figure out a working idea right now.
>>
>> But if there is such way, I'm pretty happy to consider.
>>
>>>
>>>>
>>>> My 2 cents...
>>>>
>>>> Regarding the current raid56 support, in order of preference:
>>>>
>>>> a. Fix the current bugs, without changing format. Zygo has an extensive list.
>>>
>>> I agree that relatively simple fixes should be made. But it seems we will need quite a large rewrite to solve all issues? Is there a minium viable option here?
>>
>> Nope. Just see my write-intent code, already have prototype (just needs
>> new scrub based recovery code at mount time) working.
>>
>> And based on my write-intent code, I don't think it's that hard to
>> implement a full journal.
> 
> FWIW I think we can get a very usable btrfs raid5 with a small format
> change (add a journal for stripe RMW, though we might disagree about
> details of how it should be structured and used)...

Again, I have to agree with Zygo. Even tough I am fascinating by a solution
like ZFS (parity block inside the extent), I think that a journal (and a
write intent log) is a more pragmatic approach:
- this kind of solution is below the btrfs bg; this would avoid to add further
   pressure on the metadata
- being below to the other btrfs structure may be shaped more easily with
   less risk of incompatibility

It is true that a ZFS solution may be more faster in some workload, but
I think that these are very few:
   - for high throughput, you likely write the full stripe which doesn't need
     journal/ppl
   - for small block update, a journal is more efficient than rewrite the
     full stripe


I hope that the end of Qu activities, will be a more robust raid5 btrfs
implementation, which will in turn increase the number of user, and which
in turn increase the pressure to improve this part of btrfs.

My only suggestion is to evaluate if we need to develop a write intent log
and then a journal, instead of developing the journal alone. I think that
two disk format changes are too much.


BR
G.Baroncelli
> and fixes to the
> read-repair and scrub problems.  The read-side problems in btrfs raid5
> were always much more severe than the write hole.  As soon as a disk
> goes offline, the read-repair code is unable to read all the surviving
> data correctly, and the filesystem has to be kept inactive or data on
> the disks will be gradually corrupted as bad parity gets mixed with data
> and written back to the filesystem.
> 
> A few of the problems will require a deeper redesign, but IMHO they're not
> important problems.  e.g. scrub can't identify which drive is corrupted
> in all cases, because it has no csum on parity blocks.  The current
> on-disk format needs every data block in the raid5 stripe to be occupied
> by a file with a csum so scrub can eliminate every other block as the
> possible source of mismatched parity.  While this could be fixed by
> a future new raid5 profile (and/or csum tree) specifically designed
> to avoid this, it's not something I'd insist on having before deploying
> a fleet of btrfs raid5 boxes.  Silent corruption failures are so
> rare on spinning disks that I'd use the feature maybe once a decade.
> Silent corruption due to a failing or overheating HBA chip will most
> likely affect multiple disks at once and trash the whole filesystem,
> so individual drive-level corruption reporting isn't helpful.
> 
>> Thanks,
>> Qu
>>
>>>
>>>> b. Mostly fix the write hole, also without changing the format, by
>>>> only doing COW with full stripe writes. Yes you could somehow get
>>>> corrupt parity still and not know it until degraded operation produces
>>>> a bad reconstruction of data - but checksum will still catch that.
>>>> This kind of "unreplicated corruption" is not quite the same thing as
>>>> the write hole, because it isn't pernicious like the write hole.
>>>
>>> What is the difference to a)? Is write hole the worst issue? Judging from the #brtfs channel discussions there seems to be other quite severe issues, for example real data corruption risks in degraded mode.
>>>
>>>> c. A new de-clustered parity raid56 implementation that is not
>>>> backwards compatible.
>>>
>>> Yes. We have a good opportunity to work out something much better than current implementations. We could have  redundant-n profiles that also works with tired storage like ssd/nvme similar to the metadata on ssd idea.
>>>
>>> Variable stripe width has been brought up before, but received cool responses. Why is that? IMO it could improve random 4k ios by doing equivalent to RAID1 instead of RMW, while also closing the write hole. Perhaps there is a middle ground to be found?
>>>
>>>
>>>>
>>>> Ergo, I think it's best to not break the format twice. Even if a new
>>>> raid implementation is years off.
>>>
>>> I very agree here. Btrfs already suffers in public opinion from the lack of a stable and safe-for-data RAID56, and requiring several non-compatible chances isn't going to help.
>>>
>>> I also think it's important that the 'temporary' changes actually leads to a stable filesystem. Because what is the point otherwise?
>>>
>>> Thanks
>>> Forza
>>>
>>>>
>>>> Metadata centric workloads suck on parity raid anyway. If Btrfs always
>>>> does full stripe COW won't matter even if the performance is worse
>>>> because no one should use parity raid for this workload anyway.
>>>>
>>>>
>>>> --
>>>> Chris Murphy
>>>
>>>

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

