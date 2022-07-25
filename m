Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA22357FA77
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 09:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiGYHt3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 03:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiGYHt2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 03:49:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5251A12619
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658735352;
        bh=O3v3uyBV0l4bGwV1PbNzdU3J0Zv25jJjLXYcWZeZWfs=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=bKUo6Rg0/oQ1sBMIvV276X6Y5KizqQ/CycLwfecbauP0j+O1cN5qgsIZoTHxYZX8W
         G1B4szin2eZmdtqJhvtrVE/ZOEKJKLSKe7qfxTuOnJVEnpiTsYlWw4ayxssb+dllJC
         6ckpVRV5eGfIuyCa9VnN9H9nrHqrlB6b7wdP4m7o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2E1G-1nU8GP10b0-013brm; Mon, 25
 Jul 2022 09:49:12 +0200
Message-ID: <67ecc010-39b8-9b59-e51f-faa29e2697f0@gmx.com>
Date:   Mon, 25 Jul 2022 15:49:06 +0800
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
References: <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
 <b62a80a.e3c8d435.182134a0f8d@tnonline.net>
 <829a9b85-db35-1527-bf3d-081c3f4211b2@gmx.com>
 <Yt3dLAZQk1QGhVo2@hungrycats.org>
 <5f8d4e01-5ede-6f0f-aa86-3337e8e5ecb1@gmx.com>
 <Yt4tDieKURNGuysK@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
In-Reply-To: <Yt4tDieKURNGuysK@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0+cBjrpYF4yQhIPJo96QaEO4a8i96b0Qj6zT/TJ3UV7F9Qh85m2
 BrTVK2EsgARO4z54dm7+P0DYlcmZD/EZLgaW53ISMO9AFZWvpKK4DwIRy0XXEg98dHIUOee
 1AgyEpNuT2r6DPeiiHYoo85x4eAySpGFCygRuuIGHtO5A3AgaijY8JxuE1R2tRvNhSC1aGO
 EOGif5qoyfWKoJgqMk45Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P23nljJqY6s=:tRjtbE6KxhKcuLKQuypHHD
 nmymgI3IYBYe00c/62oWJPNm7j8Oy58rC4NmJq8+s7Q4lrlrkTRf4IxF8v3wMaee2iTA0QdvG
 3GBOR+KbvXzS3M6BinPUf+rAJ+2g+ClOEWKL2f2l7+8CnxJEjBh5m52ws1Lv0heiFuDIccAVq
 HFMmWWgY/idR575DNgzLJjp1+gg7D6yGYq1b/HR2nP4Xx0wQul7gP0jX5yCBt8NrYQgNwAHYf
 q/fbtzBLqVz5/sSAG3m8dd8nvIv04fCRzSXFq73uEaEWI4Ik+jiQsdHPEk9eCmPg/ntL00/ca
 a4ZsskWMS8ELIcHvq+YVNs8ylHbKxpUrz3Mul3cGYzPx4artCNuAJX9X06aTwsPdcuz5XwZD9
 nKG8l3p26Gh25B0RX/Ckdw1nyzbH7BptM5W1y1nMULdsRP9ZvRqlRtAfFWkPG0G3beUDhOK37
 +CwnzwDhW++nqDEJEvHtLb73E2Sp//eql07w2QTwB+28bC0E1lY/KHZKBRaqCpM2C86HY3L/8
 hTrKIcxYjed1VlfW00iHTfxWFuRtKtHGuRugNgqTxgLCeQbTe279uqEt+F1RBgzDomHGUn9vg
 888nrVYFVVz5iyZYxstA6LzKXPygsL+VU1kmHwJR/yaaR3eSzJOJ8SM93zIpqyd1N7fT62In+
 PcLUM8YmA1gISbw7uqZTReUZ8QUr8HNBRjDJV/MkYaGYr024EcPXwbefZLosoRKmoJSB08t5X
 iK8nOm88ZTXEjptUHBWULmoRl/2r/Y5r4IThTPlKTckZ0bD6BMU+7jOxwuQJuAfmZCdB2V3pE
 P6oOfch5O56TeIuCB/8LUlR9/MzS3xY2DWi/CBmStuZ31Oueb/9t8A4qIueqfnEHkSZJY3g5l
 FFffAGTpmdTnviwyXCgqSXI3KT85xMtopn08LkjP3KLezhQZHEdQYUuZ9yUxBSXG0a8//JN8A
 Ifbitf7QqvdEe5SIKnjYbH/+z8/TAVYNXbXbfbxn3uMrZaqOkAWP1ueHM+sluID8bSormzM5a
 F79nti8bvai/oAxCiBa/73lywGfpX2JgtCVR5J/z3MNaY2/9al21xQrLxzlytv1Nsz+sIpPS7
 iXh+S8t2GddQ/QRp+6+ACzX7U7FZpn3RKrqSOUfBUIaG9dhuXz/0NBtBQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/25 13:41, Zygo Blaxell wrote:
> On Mon, Jul 25, 2022 at 08:25:44AM +0800, Qu Wenruo wrote:
[...]
>>
>> You can easily verify that using "btrfs check --check-data-csum", as
>> recent btrfs-progs has the extra code to verify the rebuilt data using
>> parity.
>>
>> In fact, I'm testing my write-intent bitmaps code with manually
>> corrupted parity to emulate a power loss after write-intent bitmaps upd=
ate.
>>
>> And I must say, the scrub code works as expected.
>
> That's good, but if it's true, it's a (welcome) change since last week.
> Every time I've run a raid5 repair test with a single corrupted disk,
> there has been some lost data, both from scrub and reads.  5.18.12 today
> behaves the way I'm used to, with read repair unable to repair csum
> errors and scrub leaving a few uncorrected blocks behind.

Have you tried misc-next?

The following patches are not yet in upstream nor backported:

btrfs: raid56: don't trust any cached sector in __raid56_parity_recover()
btrfs: update stripe_sectors::uptodate in steal_rbio
btrfs: only write the sectors in the vertical stripe which has data stripe=
s


>
>> The myth may come from some bad advice on only scrubbing a single devic=
e
>> for RAID56 to avoid duplicated IO.
>>
>> But the truth is, if only scrubbing one single device, for data stripes
>> on that device, if no csum error detected, scrub won't check the parity
>> or the other data stripes in the same vertical stripe.
>>
>> On the other hand, if scrub is checking the parity stripe, it will also
>> check the csum for the data stripes in the same vertical stripe, and
>> rewrite the parity if needed.
>>
>>>   That was a
>>> thing I got wrong in my raid5 bug list from 2020.  Scrub will fix data
>>> blocks if they have csum errors, but it will not detect or correct
>>> corruption in the parity blocks themselves.
>>
>> That's exactly what I mentioned, the user is trying to be a smartass
>> without knowing the details.
>>
>> Although I think we should enhance the man page to discourage the usage
>> of single device scrub.
>
> If we have something better to replace it now, sure.  The reason for
> running the scrub on devices sequentially was because it behaved so
> terribly when the per-device threads ran in parallel.

Really? For mirror/stripe based profiles they should be fine.

Since each device scrubbing is only doing IO from that device (if no
rebuild is needed).
Although things like extent and csum tree iteration would cause some
conflicts, I don't think that would be a big problem as tree block
caching should work pretty well.

It's RAID56 we're doing racing between each other, as for parity
scrubbing, we will do extra IO from data stripes, thus it will cause
performance problems.

To that aspect, we indeed need a better interface for RAID56 scrubbing.
But that's RAID56 only.

>  If scrub is now
> behaving differently on raid56 then the man page should be updated to
> reflect that.
>
>> By default, we scrub all devices (using mount point).
>
> The scrub userspace code enumerates the devices and runs a separate
> thread to scrub each one.  Running them on one device at a time makes
> those threads run sequentially instead of in parallel, and avoids a
> lot of bad stuff with competing disk accesses and race conditions.
> See below for a recent example.
>
>>>   AFAICT the only way to
>>> get the parity blocks rewritten is to run something like balance,
>>> which carries risks of its own due to the sheer volume of IO from
>>> data and metadata updates.
>>
>> Completely incorrect.
>
> And yet consistent with testing evidence going back 6 years so far.
>
> If scrub works, it should be possible to corrupt one drive, scrub,
> then corrupt the other drive, scrub again, and have zero errors
> and zero kernel crashes.  Instead:
>
> 	# mkfs.btrfs -draid5 -mraid1 -f /dev/vdb /dev/vdc
> 	# mount -ospace_cache=3Dv2,compress=3Dzstd /dev/vdb /testfs
> 	# cp -a /testdata/. /testfs/. &  # 40TB of files, average size 23K
>
> 	[...wait a few minutes for some data, we don't need the whole thing...]
>
> 	# compsize /testfs/.
> 	Processed 15271 files, 7901 regular extents (7909 refs), 6510 inline.
> 	Type       Perc     Disk Usage   Uncompressed Referenced
> 	TOTAL       73%      346M         472M         473M
> 	none       100%      253M         253M         253M
> 	zstd        42%       92M         219M         219M
>
> 	# cat /dev/zero > /dev/vdb
> 	# sync
> 	# btrfs scrub start /dev/vdb  # or '/testfs', doesn't matter
> 	# cat /dev/zero > /dev/vdc
> 	# sync
>
> 	# btrfs scrub start /dev/vdc  # or '/testfs', doesn't matter
> 	ERROR: there are uncorrectable errors
> 	# btrfs scrub status -d .
> 	UUID:             8237e122-35af-40ef-80bc-101693e878e3
>
> 	Scrub device /dev/vdb (id 1)
> 		no stats available
>
> 	Scrub device /dev/vdc (id 2) history
> 	Scrub started:    Mon Jul 25 00:02:25 2022
> 	Status:           finished
> 	Duration:         0:00:22
> 	Total to scrub:   2.01GiB
> 	Rate:             1.54MiB/s
> 	Error summary:    csum=3D1690
> 	  Corrected:      1032
> 	  Uncorrectable:  658
> 	  Unverified:     0
> 	# cat /proc/version
> 	Linux version 5.19.0-ba37a9d53d71-for-next+ (zblaxell@tester) (gcc (Deb=
ian 11.3.0-3) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38) #82 SMP PREEM=
PT_DYNAMIC Sun Jul 24 15:12:57 EDT 2022
>
> Running scrub threads in parallel sometimes triggers stuff like this,
> which killed one of the test runs while I was writing this:
>
> 	[ 1304.696921] BTRFS info (device vdb): read error corrected: ino 411 o=
ff 135168 (dev /dev/vdb sector 3128840)
> 	[ 1304.697705] BTRFS info (device vdb): read error corrected: ino 411 o=
ff 139264 (dev /dev/vdb sector 3128848)
> 	[ 1304.701196] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 	[ 1304.716463] ------------[ cut here ]------------
> 	[ 1304.717094] BUG: KFENCE: use-after-free read in free_io_failure+0x15=
7/0x210
>
> 	[ 1304.723346] kernel BUG at fs/btrfs/extent_io.c:2350!
> 	[ 1304.725076] Use-after-free read at 0x000000001e0043a6 (in kfence-#22=
8):
> 	[ 1304.725103]  free_io_failure+0x157/0x210
> 	[ 1304.725115]  clean_io_failure+0x11d/0x260
> 	[ 1304.725126]  end_compressed_bio_read+0x2a9/0x470

This looks like a problem relater to read-repair code with compression,
HCH is also working on this, in the long run we would get rid of io
failure record completely.

Have you tried without compression?

[...]
>
> On kernels without KASAN or page poisoning, that use-after-free might le=
ad
> to a hang at the end of a btrfs replace.  I don't know exactly what's
> going on there--there is often a hang at the end of a raid5 replace,
> it's caused by a mismatch between the count of active bios and the actua=
l
> number of active bios, and a use-after-free might be causing that by
> forgetting to decrement the counter.  There are multiple overlapping
> bugs in btrfs raid5 and it's hard to reliably separate them until some
> of them get fixed.
>
> Another data point:  I ran 5 test runs while writing this, and the third
> one did fix all the errors in scrub.  It sometimes does happen over test
> cases of a few gigabytes.  It's just not anywhere near reliable enough
> to fix a 50TB array with one busted disk.
>
> I think you need better test cases.  btrfs raid5 has been broken like th=
is
> since the beginning, with failures that can be demonstrated in minutes.
> btrfs raid1 can run these tests all day.

I'd say, the compression is adding a completely different complexity
into the equation.

Yep, for sysadmin's point of view, this is completely fine, but to us to
locate the problems, I'd prefer something without compression, just
RAID56 and plain file operations to see if it's really compression or
other things screwed up.

Remember, for read time repair, btrfs is still just trying the next
mirror, no difference than RAID1.

It's the RAID56 recovery code converting the 2nd mirror by using extra
P/Q and data stripes to rebuild the data.

We had problems which can cause exact the same unrepairable problems in
the RAID56 repair path (not read-repair path), in that case, please try
misc-next to see if there is any improvement (better without compression).

>
>>> Most of the raid56 bugs I've identified have nothing to do with power
>>> loss.  The data on disks is fine, but the kernel can't read it correct=
ly
>>> in degraded mode, or the diagnostic data from scrub are clearly garbag=
e.
>>
>> Unable to read in degraded mode just means parity is out-of-sync with d=
ata.
>
> No, the degraded mode case is different.  It has distinct behavior from
> the above test case where all the drives are online but csums are failin=
g.
> In degraded mode one of the devices is unavailable, so the read code
> is trying to reconstruct data on the fly.  The parity and data on disk
> is often OK on the surviving disks if I dump it out by hand, and often
> all the data can be recovered by 'btrfs replace' without error (as
> long as 'btrfs replace' is the only active process on the filesystem).
>
> Rebooting the test VM will make a different set of data unreadable
> through the filesystem, and the set of unreadable blocks changes over
> time if running something like:
>
> 	sysctl vm.drop_caches=3D3; find -type f -exec cat {} + >/dev/null
>
> in a loop, especially if something is writing to the filesystem at the
> same time.  Note there is never a write hole in these test cases--the
> filesystem is always cleanly umounted, and sometimes there's no umount
> at all, one device is simply disconnected with no umount or reboot.
>
>> There are several other bugs related to this, mostly related to the
>> cached raid bio and how we rebuild the data. (aka, btrfs/125)
>> Thankfully I have submitted patches for that bug and now btrfs/125
>> should pass without problems.
>
> xfstests btrfs/125 is an extremely simple test case.  I'm using btrfs
> raid5 on 20-80TB filesystems, millions to billions of files.

That's the difference between developer and end users, and I totally
understand you want to really go heavy testing and squeeze out every bug.

But from a developer's view, we prefer to fix bugs one by one.

Btrfs/125 is a very short but effective test case to show how the
original RAID56 repair path has problems mostly related to its cached
radi56 behavior.

I'm not saying the test case representing all the problems, but it's a
very quick indicator of whether your code base has the fixes for RAID56
code.

>  The error
> rate is quantitatively low (only 0.01% of data is lost after one disk
> failure) but it should be zero, as none of my test cases involve write
> hole, nodatacow, or raid5 metadata.
>
> for-next and misc-next are still quite broken, though to be fair they
> definitely have issues beyond raid5.

I'm more interesting in how misc-next is broken.

I know that previous misc-next has some problems related to page
faulting and can hang fsstress easily.

But that should be fixed in recent misc-next, thus I strongly recommend
to try it (and without compression) to see if there is any improvement
for RAID56.

Thanks,
Qu

>  5.18.12 can get through the
> test without tripping over KASAN or blowing up the metadata, but it
> has uncorrectable errors and fake read errors:
>
> 	# btrfs scrub start -Bd /testfs/
>
> 	Scrub device /dev/vdb (id 1) done
> 	Scrub started:    Mon Jul 25 00:49:28 2022
> 	Status:           finished
> 	Duration:         0:03:03
> 	Total to scrub:   4.01GiB
> 	Rate:             1.63MiB/s
> 	Error summary:    read=3D3 csum=3D7578
> 	  Corrected:      7577
> 	  Uncorrectable:  4
> 	  Unverified:     1
>
> I know the read errors are fake because /dev/vdb is a file on a tmpfs.
>
>> But the powerloss can still lead to out-of-sync parity and that's why
>> I'm fixing the problem using write-intent-bitmaps.
>
> None of my test cases involve write hole, as I know write-hole test case=
s
> will always fail.  There's no point in testing write hole if recovery
> from much simpler failures isn't working yet.
>
>>> I noticed you and others have done some work here recently, so some of
>>> these issues might be fixed in 5.19.  I haven't re-run my raid5 tests
>>> on post-5.18 kernels yet (there have been other bugs blocking testing)=
.
>>>
>>>> (There are still common problems shared between both btrfs raid56 and
>>>> dm-raid56, like destructive-RMW)
>>>
>>> Yeah, that's one of the critical things to fix because btrfs is in a g=
ood
>>> position to do as well or better than dm-raid56.  btrfs has definitely
>>> fallen behind the other available solutions in the 9 years since raid5=
 was
>>> first added to btrfs, as btrfs implements only the basic configuration
>>> of raid56 (no parity integrity or rmw journal) that is fully vulnerabl=
e
>>> to write hole and drive-side data corruption.
>>>
>>>>> - and that it's officially not recommended for production use - it
>>>> is a good idea to reconstruct new btrfs 'redundant-n' profiles that
>>>> doesn't have the inherent issues of traditional RAID.
>>>>
>>>> I'd say the complexity is hugely underestimated.
>>>
>>> I'd agree with that.  e.g. some btrfs equivalent of ZFS raidZ (put par=
ity
>>> blocks inline with extents during writes) is not much more complex to
>>> implement on btrfs than compression; however, the btrfs kernel code
>>> couldn't read compressed data correctly for 12 years out of its 14-yea=
r
>>> history, and nobody wants to wait another decade or more for raid5
>>> to work.
>>>
>>> It seems to me the biggest problem with write hole fixes is that all
>>> the potential fixes have cost tradeoffs, and everybody wants to veto
>>> the fix that has a cost they don't like.
>>
>> Well, that's why I prefer multiple solutions for end users to choose,
>> other than really trying to get a silver bullet solution.
>>
>> (That's also why I'm recently trying to separate block group tree from
>> extent tree v2, as I really believe progressive improvement over a deat=
h
>> ball feature)
>
> Yeah I'm definitely in favor of getting bgtree done sooner rather
> than later.  It's a simple, stand-alone feature that has well known
> beneficial effect.  If the extent tree v2 project wants to do something
> incompatible with it later on, that's extent tree v2's problem, not a
> reason to block bgtree in the short term.
>
>> Thanks,
>> Qu
>>
>>>
>>> We could implement multiple fix approaches at the same time, as AFAIK
>>> most of the proposed solutions are orthogonal to each other.  e.g. a
>>> write-ahead log can safely enable RMW at a higher IO cost, while the
>>> allocator could place extents to avoid RMW and thereby avoid the loggi=
ng
>>> cost as much as possible (paid for by a deferred relocation/garbage
>>> collection cost), and using both at the same time would combine both
>>> benefits.  Both solutions can be used independently for filesystems at
>>> extreme ends of the performance/capacity spectrum (if the filesystem i=
s
>>> never more than 50% full, then logging is all cost with no gain compar=
ed
>>> to allocator avoidance of RMW, while a filesystem that is always near
>>> full will have to journal writes and also throttle writes on the journ=
al.
>>>
>>>>> For example a non-striped redundant-n profile as well as a striped r=
edundant-n profile.
>>>>
>>>> Non-striped redundant-n profile is already so complex that I can't
>>>> figure out a working idea right now.
>>>>
>>>> But if there is such way, I'm pretty happy to consider.
>>>>
>>>>>
>>>>>>
>>>>>> My 2 cents...
>>>>>>
>>>>>> Regarding the current raid56 support, in order of preference:
>>>>>>
>>>>>> a. Fix the current bugs, without changing format. Zygo has an exten=
sive list.
>>>>>
>>>>> I agree that relatively simple fixes should be made. But it seems we=
 will need quite a large rewrite to solve all issues? Is there a minium vi=
able option here?
>>>>
>>>> Nope. Just see my write-intent code, already have prototype (just nee=
ds
>>>> new scrub based recovery code at mount time) working.
>>>>
>>>> And based on my write-intent code, I don't think it's that hard to
>>>> implement a full journal.
>>>
>>> FWIW I think we can get a very usable btrfs raid5 with a small format
>>> change (add a journal for stripe RMW, though we might disagree about
>>> details of how it should be structured and used) and fixes to the
>>> read-repair and scrub problems.  The read-side problems in btrfs raid5
>>> were always much more severe than the write hole.  As soon as a disk
>>> goes offline, the read-repair code is unable to read all the surviving
>>> data correctly, and the filesystem has to be kept inactive or data on
>>> the disks will be gradually corrupted as bad parity gets mixed with da=
ta
>>> and written back to the filesystem.
>>>
>>> A few of the problems will require a deeper redesign, but IMHO they're=
 not
>>> important problems.  e.g. scrub can't identify which drive is corrupte=
d
>>> in all cases, because it has no csum on parity blocks.  The current
>>> on-disk format needs every data block in the raid5 stripe to be occupi=
ed
>>> by a file with a csum so scrub can eliminate every other block as the
>>> possible source of mismatched parity.  While this could be fixed by
>>> a future new raid5 profile (and/or csum tree) specifically designed
>>> to avoid this, it's not something I'd insist on having before deployin=
g
>>> a fleet of btrfs raid5 boxes.  Silent corruption failures are so
>>> rare on spinning disks that I'd use the feature maybe once a decade.
>>> Silent corruption due to a failing or overheating HBA chip will most
>>> likely affect multiple disks at once and trash the whole filesystem,
>>> so individual drive-level corruption reporting isn't helpful.
>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>>> b. Mostly fix the write hole, also without changing the format, by
>>>>>> only doing COW with full stripe writes. Yes you could somehow get
>>>>>> corrupt parity still and not know it until degraded operation produ=
ces
>>>>>> a bad reconstruction of data - but checksum will still catch that.
>>>>>> This kind of "unreplicated corruption" is not quite the same thing =
as
>>>>>> the write hole, because it isn't pernicious like the write hole.
>>>>>
>>>>> What is the difference to a)? Is write hole the worst issue? Judging=
 from the #brtfs channel discussions there seems to be other quite severe =
issues, for example real data corruption risks in degraded mode.
>>>>>
>>>>>> c. A new de-clustered parity raid56 implementation that is not
>>>>>> backwards compatible.
>>>>>
>>>>> Yes. We have a good opportunity to work out something much better th=
an current implementations. We could have  redundant-n profiles that also =
works with tired storage like ssd/nvme similar to the metadata on ssd idea=
.
>>>>>
>>>>> Variable stripe width has been brought up before, but received cool =
responses. Why is that? IMO it could improve random 4k ios by doing equiva=
lent to RAID1 instead of RMW, while also closing the write hole. Perhaps t=
here is a middle ground to be found?
>>>>>
>>>>>
>>>>>>
>>>>>> Ergo, I think it's best to not break the format twice. Even if a ne=
w
>>>>>> raid implementation is years off.
>>>>>
>>>>> I very agree here. Btrfs already suffers in public opinion from the =
lack of a stable and safe-for-data RAID56, and requiring several non-compa=
tible chances isn't going to help.
>>>>>
>>>>> I also think it's important that the 'temporary' changes actually le=
ads to a stable filesystem. Because what is the point otherwise?
>>>>>
>>>>> Thanks
>>>>> Forza
>>>>>
>>>>>>
>>>>>> Metadata centric workloads suck on parity raid anyway. If Btrfs alw=
ays
>>>>>> does full stripe COW won't matter even if the performance is worse
>>>>>> because no one should use parity raid for this workload anyway.
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Chris Murphy
>>>>>
>>>>>
>>
