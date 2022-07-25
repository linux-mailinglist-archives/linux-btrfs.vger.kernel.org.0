Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C042257F7CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 02:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiGYA0F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jul 2022 20:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYA0F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jul 2022 20:26:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E60411A1E
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658708750;
        bh=raMu1Pfsf0VVHk1SN6DZ+C+/RbGWu1q/MEg7XYeC0yI=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=ZKL5jq0dqn5UMrJOMrZKw46zBOW0k64BjTb6DqgFbv4jPn7/+mIS+03DXLLmcetQ3
         F1JQ4zYwe+37zDqz61R3IM979lv9lS9hbE22Jzs+HUAMd2RNYrGSW/5x/BmDOMFMZH
         ZWbDtOxvVszx6ZBQwnXP/kYFQcszyp6Oy4A4g5z4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N79u8-1nPrjF1Mi4-017UxS; Mon, 25
 Jul 2022 02:25:50 +0200
Message-ID: <5f8d4e01-5ede-6f0f-aa86-3337e8e5ecb1@gmx.com>
Date:   Mon, 25 Jul 2022 08:25:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Forza <forza@tnonline.net>, Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>,
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
In-Reply-To: <Yt3dLAZQk1QGhVo2@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8M+hWY0DKntvN+SPJKyDd5g858tSQ/Cx/i+stc4KMt9fF7oz8nr
 U+gpCFCIxxGrgwsgwLSkzloB31SPqRYbvR4GqWUVFBTD3cjLT08gA7hYbDoNM5XSCTJvtX6
 YoOglOuOc6lADgUlYjBcwX87PFkbVAwRngvHQIGjHgRNjYBtiRbzKperYPvEl+1KYdkPwVh
 hqHWSUgEFRcrOPRG4fn9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H4WRbYBQXmo=:I6/LTfYujgF49F4GFMUmHV
 C4wabCLDu7d0y2OfZeeufKKQIi5mM9sy4UwDeosp3+DjSwuPNdQcYB8pkHNHQmwD0GwiCUkiS
 wLyQHgu2CBDEvWxjJNCyHYTib+JgDSp7m622FoYbuhu79/eBVDJ3ckwfXowOYkvG0vQYgfZtJ
 rrAFu/DZJwHMeFkPJYEvXFqVeMMH804k2EvsutYt9l4rZexuIhuO8FrVYpdaua7a5HmxvgesI
 H9Xl4kCWyR4utieT5CaeBRYIe41ktxMT+C2ZVmy8j4qbX3SDjId5aE+8l8btSPtwtdOyhahUS
 6Y9RjuEgdJPrNLSPJXFCEDZZurmen27ubrPGVSUg22HpTAyHzEyMSjYyauHoYxQfXiN2mrkC3
 YBjtug7SbBDwWoAyc2W+Yo0Rpv7d4NJwBJr99nu3z/SGRq6IegBayuFh0qOxYYB6c5VlfvUWg
 tGQRE2fJZrtLk/G5t14urZtM6cAnBciVUB0yr0eGjqz1TkzreP2O4tO6K+wfcjZFUwypO55nV
 pMD4+73lwgMwpsfwpgQRgsdh+Zmkrou7Rtro6eJmli+8mCdaIGljfYpProw75liEK4bOEay9w
 8Ep9/QTzpByN0+J9OnxCQG/D2u3wVusbj1cEpcdSGDO9aNuYWbcfip3ZTcDMurLgJd8Bw6W54
 Ts3OhnIgNmLpHQN+0o0BnQaIwNNOGxh7qlhxoNaAAoL7G+D1sAolljvAL6wAAK2tTXSwHBqlJ
 kSLbFn6M67b+C+sBVgN+j9dHmZBWGqO5eu+Nz5Vr5LYWW3QQMINl+F8zFAP9ZS+dkn0Fs49zH
 pSNSKP/c3nettyNK4sYS43x6X44uqnoE0rL68EqQq+tq87OVSmPGL7uAz3OjzUGkGfhiwWvn6
 vIjOU14noyeYiqibjLdfH21Hz5llaP1zcXucOXkI2ZDqCgtL/fWlgBrcFGGMkzObRPzllDiMo
 H86UFoymMNQ34lS7YN0wVz/5DSAlTXTKBgmDpaTwZgPs5L5SY8Wu0MvDmWC6nT0LwHpM07pn+
 rFj6oLQk8d98GKAnPjpwumssZrQEwquEjt5HSpV1m5uNCkW0SK+CLjVSAS/GZ1Yx5O0KP1VnR
 54JbvCfvb4dERTpX69nHUcMZ5j3DXKwiipiKt6ZxGRri/Hh7fV/viaLKA==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/25 08:00, Zygo Blaxell wrote:
> On Tue, Jul 19, 2022 at 09:19:21AM +0800, Qu Wenruo wrote:
>>>>> Doing so we don't need any disk format change and it would be backwa=
rd compatible.
>>>
>>> Do we need to implement RAID56 in the traditional sense? As the
>> user/sysadmin I care about redundancy and performance and cost. The
>> option to create redundancy for any 'n drives is appealing from a cost
>> perspective, otherwise I'd use RAID1/10.
>>
>> Have you heard any recent problems related to dm-raid56?
>>
>> If your answer is no, then I guess we already have an  answer to your
>> question.
>
> With plain dm-raid56 the problems were there since the beginning, so
> they're not recent.

Are you talking about mdraid? They go internal write-intent bitmap and
PPL by default.

>  If there's a way to configure PPL or a journal
> device with raid5 LVs on LVM, I can't find it.

LVM is another story.

>  AFAIK nobody who knows
> what they're doing would choose dm-raid56 for high-value data, especiall=
y
> when alternatives like ZFS exist.

Isn't it the opposite? mdraid is what most people go, other than LVM raid.

>
> Before btrfs, we had a single-digit-percentage rate of severe data losse=
s
> (more than 90% data lost) on filesystems and databases using mdadm +
> ext3/4 with no journal in degraded mode.  Multiply by per-drive AFR
> and that's a lot of full system rebuilds over the years.
>
>>> Since the current RAID56 mode have several important drawbacks
>>
>> Let me to be clear:
>>
>> If you can ensure you didn't hit power loss, or after a power loss do a
>> scrub immediately before any new write, then current RAID56 is fine, at
>> least not obviously worse than dm-raid56.
>
> I'm told that scrub doesn't repair parity errors on btrfs.

That's totally untrue.

You can easily verify that using "btrfs check --check-data-csum", as
recent btrfs-progs has the extra code to verify the rebuilt data using
parity.

In fact, I'm testing my write-intent bitmaps code with manually
corrupted parity to emulate a power loss after write-intent bitmaps update=
.

And I must say, the scrub code works as expected.



The myth may come from some bad advice on only scrubbing a single device
for RAID56 to avoid duplicated IO.

But the truth is, if only scrubbing one single device, for data stripes
on that device, if no csum error detected, scrub won't check the parity
or the other data stripes in the same vertical stripe.

On the other hand, if scrub is checking the parity stripe, it will also
check the csum for the data stripes in the same vertical stripe, and
rewrite the parity if needed.

>  That was a
> thing I got wrong in my raid5 bug list from 2020.  Scrub will fix data
> blocks if they have csum errors, but it will not detect or correct
> corruption in the parity blocks themselves.

That's exactly what I mentioned, the user is trying to be a smartass
without knowing the details.

Although I think we should enhance the man page to discourage the usage
of single device scrub.

By default, we scrub all devices (using mount point).

>  AFAICT the only way to
> get the parity blocks rewritten is to run something like balance,
> which carries risks of its own due to the sheer volume of IO from
> data and metadata updates.

Completely incorrect.

>
> Most of the raid56 bugs I've identified have nothing to do with power
> loss.  The data on disks is fine, but the kernel can't read it correctly
> in degraded mode, or the diagnostic data from scrub are clearly garbage.

Unable to read in degraded mode just means parity is out-of-sync with data=
.

There are several other bugs related to this, mostly related to the
cached raid bio and how we rebuild the data. (aka, btrfs/125)
Thankfully I have submitted patches for that bug and now btrfs/125
should pass without problems.

But the powerloss can still lead to out-of-sync parity and that's why
I'm fixing the problem using write-intent-bitmaps.

>
> I noticed you and others have done some work here recently, so some of
> these issues might be fixed in 5.19.  I haven't re-run my raid5 tests
> on post-5.18 kernels yet (there have been other bugs blocking testing).
>
>> (There are still common problems shared between both btrfs raid56 and
>> dm-raid56, like destructive-RMW)
>
> Yeah, that's one of the critical things to fix because btrfs is in a goo=
d
> position to do as well or better than dm-raid56.  btrfs has definitely
> fallen behind the other available solutions in the 9 years since raid5 w=
as
> first added to btrfs, as btrfs implements only the basic configuration
> of raid56 (no parity integrity or rmw journal) that is fully vulnerable
> to write hole and drive-side data corruption.
>
>>> - and that it's officially not recommended for production use - it
>> is a good idea to reconstruct new btrfs 'redundant-n' profiles that
>> doesn't have the inherent issues of traditional RAID.
>>
>> I'd say the complexity is hugely underestimated.
>
> I'd agree with that.  e.g. some btrfs equivalent of ZFS raidZ (put parit=
y
> blocks inline with extents during writes) is not much more complex to
> implement on btrfs than compression; however, the btrfs kernel code
> couldn't read compressed data correctly for 12 years out of its 14-year
> history, and nobody wants to wait another decade or more for raid5
> to work.
>
> It seems to me the biggest problem with write hole fixes is that all
> the potential fixes have cost tradeoffs, and everybody wants to veto
> the fix that has a cost they don't like.

Well, that's why I prefer multiple solutions for end users to choose,
other than really trying to get a silver bullet solution.

(That's also why I'm recently trying to separate block group tree from
extent tree v2, as I really believe progressive improvement over a death
ball feature)

Thanks,
Qu

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
> full will have to journal writes and also throttle writes on the journal=
.
>
>>> For example a non-striped redundant-n profile as well as a striped red=
undant-n profile.
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
>>>> a. Fix the current bugs, without changing format. Zygo has an extensi=
ve list.
>>>
>>> I agree that relatively simple fixes should be made. But it seems we w=
ill need quite a large rewrite to solve all issues? Is there a minium viab=
le option here?
>>
>> Nope. Just see my write-intent code, already have prototype (just needs
>> new scrub based recovery code at mount time) working.
>>
>> And based on my write-intent code, I don't think it's that hard to
>> implement a full journal.
>
> FWIW I think we can get a very usable btrfs raid5 with a small format
> change (add a journal for stripe RMW, though we might disagree about
> details of how it should be structured and used) and fixes to the
> read-repair and scrub problems.  The read-side problems in btrfs raid5
> were always much more severe than the write hole.  As soon as a disk
> goes offline, the read-repair code is unable to read all the surviving
> data correctly, and the filesystem has to be kept inactive or data on
> the disks will be gradually corrupted as bad parity gets mixed with data
> and written back to the filesystem.
>
> A few of the problems will require a deeper redesign, but IMHO they're n=
ot
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
>>>> corrupt parity still and not know it until degraded operation produce=
s
>>>> a bad reconstruction of data - but checksum will still catch that.
>>>> This kind of "unreplicated corruption" is not quite the same thing as
>>>> the write hole, because it isn't pernicious like the write hole.
>>>
>>> What is the difference to a)? Is write hole the worst issue? Judging f=
rom the #brtfs channel discussions there seems to be other quite severe is=
sues, for example real data corruption risks in degraded mode.
>>>
>>>> c. A new de-clustered parity raid56 implementation that is not
>>>> backwards compatible.
>>>
>>> Yes. We have a good opportunity to work out something much better than=
 current implementations. We could have  redundant-n profiles that also wo=
rks with tired storage like ssd/nvme similar to the metadata on ssd idea.
>>>
>>> Variable stripe width has been brought up before, but received cool re=
sponses. Why is that? IMO it could improve random 4k ios by doing equivale=
nt to RAID1 instead of RMW, while also closing the write hole. Perhaps the=
re is a middle ground to be found?
>>>
>>>
>>>>
>>>> Ergo, I think it's best to not break the format twice. Even if a new
>>>> raid implementation is years off.
>>>
>>> I very agree here. Btrfs already suffers in public opinion from the la=
ck of a stable and safe-for-data RAID56, and requiring several non-compati=
ble chances isn't going to help.
>>>
>>> I also think it's important that the 'temporary' changes actually lead=
s to a stable filesystem. Because what is the point otherwise?
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
