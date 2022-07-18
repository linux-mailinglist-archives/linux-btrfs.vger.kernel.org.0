Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B60577923
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 03:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiGRBFQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jul 2022 21:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGRBFP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jul 2022 21:05:15 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5A1BE2D
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Jul 2022 18:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658106296;
        bh=p3jtIXn5FfEPPfutOpHfeUZLp0I4D3TV+RHlRqHeJrw=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=F8gK49wKBHuH4wPLvM28mG/x5VHSBkh8p7i0WtP6+vgpVo1JjR2q/uD0h/xXFODJx
         UdLvuc34l1zM1MeCygf0LtwBkjqcHXnPsIq4byo0/+XrDKR9DTwaABsFQH5yHv93xz
         CSyy7Njsel6b+KIIHWBaFWVrqUVMvxT5vsdgKXX0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MaJ81-1nzExu3nuv-00WHOS; Mon, 18
 Jul 2022 03:04:56 +0200
Message-ID: <8be210dd-5c0f-f1ed-2eef-e736d672b81e@gmx.com>
Date:   Mon, 18 Jul 2022 09:04:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Thiago Ramon <thiagoramon@gmail.com>, kreijack@inwind.it,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAO1Y9woJUhuQ+Q2yWSvscnBJb9D5cYiBaY-WG3Re=7V=OzWVhw@mail.gmail.com>
 <1dcfecba-92fc-6f49-bdea-705896ece036@gmx.com>
 <YtSUjdgxwN+ghhXU@hungrycats.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
In-Reply-To: <YtSUjdgxwN+ghhXU@hungrycats.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zkMJXE4bxdvsMQzuL3vDK7XmEAf8xL4knY1Jqd5LWOp0C8zn6aD
 Ie77FGYcPc8Hm98hjYt31+3Baxn0D0StKK6mkJf+gQmvZzn+OEnfOX9PmWUv0IOv925BJSf
 nyBuoeqGmwGHNCVBW2goFl+DVu9mUJrltjFJW9tiwNaClulElZr+816ZiFdbNUmVVDAoQvp
 73DLARAhnhvKfM1ogR7iQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kk+ElQwRJAM=:TpLcIU+2SQRGo0ObrSugg6
 CpRTIbAYdbgxKY1xCvffVBFvHC4+D2MSLRJ1jfQkZFG6J4Pn+5P4BTiB0/a2Ox+3pylwtK79L
 u/KTbUtgV7bjtlELFSOJFtJ83y40CEMWdiK88Okjq5xzMvZXu2ekUGPid/TOL7iPrA3YYw0oO
 kkmN4+xorTl9y6rt0NIsSu2qh4a2deB8AamJjSQtVYskT4RdDEJBuG9A9RCRB8fxL3mreGG8c
 nximmG6pMk6tCtdWDS6Av0JtF6MUgrlp+O0pO7f3OevpgN0gTo8Py+WOrl62jYa7tJiPqad8D
 PErLBzc/5l2qF+JkE4q4Zh6dIBB4DYqRyJrYN8H15PZcQERf238snkxgKOEzgp67iHB00NMdY
 KT8vnxIoV/lwJ1ufKrm2zq/1PGSthUnF2YrGwpchvgPzASZPxOf3zs6ITFofK4dHHwhlju5pB
 UeqdD9sQKCFnjdE58/wNceh0zh5Thv75l9ghU9yC6ycYEz6EB6l6/jN/OrYEFPBubO+toDG/K
 jV2a/qVCl04Re1RAxUPW0XaAveOdOV0yyDGpSZ2g7OdcCxCdexrnxuSFio34Rc5lu2/0AxxbE
 w8ksTxjvuDZHVoXl15E6IelwX4JNaXfgd4eodxmckNFYdvT0AqjYatgRiMOx7IZQ59FZzY05A
 lRZF4yTy+zmvQ4n3sE6LDCG2L5Zo3M+4so8wOerHXASZZM+Iw+LX9ipQio3a28zk0vuyBop1m
 XMiAytTpAfwsYhCd36+W1hnYdIZVyOeCN6iBSIr7/IEdY0/c5yy+6eOjlOnyEcDmFZUOD30Tf
 r67Uw8Nj+wHxltfeANElprxmG5ocovWa7sm2oSnI5pByt8NLn3JJbSEHBmioNFsqOwm4GbV0+
 UKBOtO7iRNsJ8aGxMJ/NDkgAnwGFQYjxcks2mQmAsCXs7tmGcCT/B4jCyKBYze2jkVTNwPCtV
 n6lmYcHugk4sZHFeVffzsu6JGivAPnqIAHhO0HG3ob09FAMUuZkc0X/LHk/Aiwj/0leVTniuf
 4iE0Ukqt83962hHbsxArB2bE0tfAxbolyWTg8Ewk1AGDYzfz4twEVJRHNEV+lJ7TDF0aXlJ52
 ftQfI5AHOXNgu/oZpvdf9arqrFi5Sbjpb2QUnMphTXV/FbTWwrmBBShKQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/18 07:00, Zygo Blaxell wrote:
> On Sat, Jul 16, 2022 at 08:34:30AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/7/16 03:08, Thiago Ramon wrote:
>>> As a user of RAID6 here, let me jump in because I think this
>>> suggestion is actually a very good compromise.
>>>
>>> With stripes written only once, we completely eliminate any possible
>>> write-hole, and even without any changes on the current disk layout
>>> and allocation,
>>
>> Unfortunately current extent allocator won't understand the requirement
>> at all.
>>
>> Currently the extent allocator although tends to use clustered free
>> space, when it can not find a clustered space, it goes where it can fin=
d
>> a free space. No matter if it's a substripe write.
>
>> Thus to full stripe only write, it's really the old idea about a new
>> extent allocator to avoid sub-stripe writes.
>
>> Nowadays with the zoned code, I guess it is now more feasible than prev=
ious.
>
> It's certainly easier, but the gotcha at the bottom of the pile for
> stripe-level GC on raid5 for btrfs is that raid5 stripe boundaries
> don't match btrfs extent boundaries.  If I write some extents of various
> sizes:
>
>          Extents:  [4k][24k][64k][160k][--512k--][200k][100k]
>          Stripes:  [---384k--------------][---384k-][---384k---]

That won't be a problem for RST, at least for RST on zoned device.

On RST with zoned device, we split extents to match the stripe boundary,
thus no problem.
(At least that's my educated guess).

But this will become a problem for RST on non-zoned device.


>
> If that 64K extent is freed, and I later write new data to it, then
> in theory I have to CoW the 4k, 24k, 160k extents, and _parts of_
> the 512k extent, or GC needs to be able to split extents (with an
> explosion of fragmentation as all the existing extents are sliced up
> in fractions-of-384k sized pieces).  Both options involve significant
> IO amplification (reads and writes) at write time, with the worst case
> being something like:
>
>          Extents:  ...--][128M][-8K-][128M][...
>          Stripes:  ...][384k][384k][384k][...
>
> where there's a 384k raid stripe that contains parts of two 128M extents
> and a 4K free space, and CoW does 256MB of IO on data blocks alone.
> All of the above seems like an insane path we don't want to follow.
>
> The main points of WIL (and as far as I can tell, also of RST) are:
>
> 	- it's a tree that translates logical bytenrs to new physical
> 	bytenrs so you can do CoW (RST) or journalling (WIL) on raid56
> 	stripes
>
> 	- it's persistent on disk in mirrored (non-parity) metadata,
> 	so the write hole is closed and no committed data is lost on
> 	crash (note we don't need to ever make parity metadata work
> 	because mirrored metadata will suffice, so this solution does
> 	not have to be adapted to work for metadata)
>
> 	- the tree is used to perform CoW on the raid stripe level,
> 	not the btrfs extent level, i.e. everything this tree does is
> 	invisible to btrfs extent, csum, and subvol trees.

I'm afraid we can not really do pure RAID level COW, without really
touching the extent layer.

At least for now, zoned code has already changed extent allocator to
always go forward to compensate for the zoned limitations.

I know this is not a good idea for layer separation we want, but
unfortunately zoned support really depends on that.

And if we really go the RST with transparent COW without touching extent
allocator, the complexity would go sky rocket.

>
> It basically behaves like a writeback cache for RMW stripe updates.
>
> On non-zoned devices, write intent log could write a complete stripe in
> a new location, record the new location in a WIL tree, commit, overwrite
> the stripe in the original location, delete the new location from the
> WIL tree, and commit again.  This effectively makes raid5 stripes CoW
> instead of RMW, and closes the write hole.  There's no need to modify
> any other btrfs trees, which is good because relocation is expensive
> compared to the overhead of overwriting the unmodified blocks in a strip=
e
> for non-zoned devices.

Yep, that's why I'm so strongly pushing for write-intent bitmaps.

It really is the least astonishment way to go, but at the cost of no
zoned support.

But considering how bad reputation nowadays SMR devices receive, I doubt
normal end users would even consider zoned device for RAID56.

>  Full-stripe writes don't require any of this,
> so they go straight to the disk and leave no trace in WIL.

Exactly the optimization I want to go, although not in current
write-intent code, it only needs less than 10 lines to implement.

>  A writeback
> thread can handle flushing WIL entries back to original stripe locations
> in the background, and a small amount of extra space will be used while
> that thread catches up to writes from previous transactions.

I don't think we need a dedicated flushing thread.

Currently for write-intent bitmaps, it's too small to really need to wait.
(and dm-bitmap also goes this way, if the bitmap overflows, we just wait
and retry).

For full journal, we can just wait for the endio function to free up
some space before we need to add new journal.

>  There's no
> need to do anything new with the allocator for this, because everything
> is hidden in the btrfs raid5/6 profile layer and the WIL tree, so the
> existing clustered allocator is fine (though a RMW-avoiding allocator
> would be faster).
>
> On zoned devices, none of this seems necessary or useful, and some of
> it is actively harmful.  We can't overwrite data in place, so we get no
> benefit from a shortcut that might allow us to.  Once a stripe is writte=
n,
> it's stuck in a read-only state until every extent that references the
> stripe is deleted (by deleting the containing block group).  There's no
> requirement to copy a stripe at any time, since any new writes could
> simply get allocated to extents in a new raid stripe.  When we are
> reclaiming space from a zone in GC, we want to copy only the data that
> remains in existing extents, not the leftover unused blocks in the raid
> stripes that contain the extents, so we simply perform exactly that copy
> in reclaim.  For zoned device reclaim we _want_ all of the btrfs trees
> (csum, extent, and subvol) to have extent-level visibility so that we ca=
n
> avoid copying data from stripes that contain extents we didn't modify
> or that were later deleted.
>
> ISTM that zoned devices naturally fix the btrfs raid5/6 write hole issue=
s
> without any special effort because their limitations wrt overwrites
> simply don't allow the write hole to be implemented.

Not that simple, but mostly correct.

For zoned device, they need RST anyway for data RAID support (not only
RAID56).

And since their RST is also protected by transaction, we won't have the
sub-stripe overwrite problem, as if we lost power, we still see the old
RST tree.

But we will face the new challenges like GC and reserved zones just to
handle the script I mentioned above.

>
>> Now I think it's time to revive the extent allcator idea, and explore
>> the extent allocator based idea, at least it requires no on-disk format
>> change, which even write-intent still needs a on-disk format change (at
>> least needs a compat ro flag)
>
> This is the attractive feature about getting the allocator disciplined
> so that RMW isn't needed any more.  It can reuse all the work of the
> zoned implementation, except with the ability to allocate a full raid
> stripe in any block group, not just the few that are opened for appendin=
g.
>
> This would introduce a new requirement for existing raid5 filesystems th=
at
> several BGs are reserved for reclaim; however, this is not a particularl=
y
> onerous requirement since several BGs have to be reserved for metadata
> expansion to avoid ENOSPC already,

Sorry, we don't reserved BGs at all for non-zoned devices.

In fact, zoned devices can do reserved zones because they have the unit
of zones.

If for non-zoned devices, how to calculate the space? Using the similar
code like chunk allocator?
How to handle added devices or uneven devices?

That hardware zones really solves a lot of problems for reserved space.


In short, I'm not against RST + cow parity, but not comfort at all for
the following things:

- Zoned GC mechanism
- No support for non-zoned devices at all
   We still need GC, as long as we go Parity COW, even we can overwrite.

Unless there are some prototypes that can pass the script I mentioned
above, I'm not in.

Thanks,
Qu

> and there's no automation for this
> in the filesystem.  Also raid5 filesystems are typically larger than
> average and can afford a few hundred spare GB.  btrfs-cleaner only has
> to be taught to not delete every single empty block group, but leave a
> few spares allocated for GC.
>
>> Thanks,
>> Qu
>>
>>> there shouldn't be much wasted space (in my case, I
>>> have a 12-disk RAID6, so each full stripe holds 640kb, and discounting
>>> single-sector writes that should go into metadata space, any
>>> reasonable write should fill that buffer in a few seconds).
>>>
>>> The additional suggestion of using smaller stripe widths in case there
>>> isn't enough data to fill a whole stripe would make it very easy to
>>> reclaim the wasted space by rebalancing with a stripe count filter,
>>> which can be easily automated and run very frequently.
>>>
>>> On-disk format also wouldn't change and be fully usable by older
>>> kernels, and it should "only" require changes on the allocator to
>>> implement.
>>>
>>> On Fri, Jul 15, 2022 at 2:58 PM Goffredo Baroncelli <kreijack@libero.i=
t> wrote:
>>>>
>>>> On 14/07/2022 09.46, Johannes Thumshirn wrote:
>>>>> On 14.07.22 09:32, Qu Wenruo wrote:
>>>>>> [...]
>>>>>
>>>>> Again if you're doing sub-stripe size writes, you're asking stupid t=
hings and
>>>>> then there's no reason to not give the user stupid answers.
>>>>>
>>>>
>>>> Qu is right, if we consider only full stripe write the "raid hole" pr=
oblem
>>>> disappear, because if a "full stripe" is not fully written it is not
>>>> referenced either.
>>>>
>>>>
>>>> Personally I think that the ZFS variable stripe size, may be interest=
ing
>>>> to evaluate. Moreover, because the BTRFS disk format is quite flexibl=
e,
>>>> we can store different BG with different number of disks. Let me to m=
ake an
>>>> example: if we have 10 disks, we could allocate:
>>>> 1 BG RAID1
>>>> 1 BG RAID5, spread over 4 disks only
>>>> 1 BG RAID5, spread over 8 disks only
>>>> 1 BG RAID5, spread over 10 disks
>>>>
>>>> So if we have short writes, we could put the extents in the RAID1 BG;=
 for longer
>>>> writes we could use a RAID5 BG with 4 or 8 or 10 disks depending by l=
ength
>>>> of the data.
>>>>
>>>> Yes this would require a sort of garbage collector to move the data t=
o the biggest
>>>> raid5 BG, but this would avoid (or reduce) the fragmentation which af=
fect the
>>>> variable stripe size.
>>>>
>>>> Doing so we don't need any disk format change and it would be backwar=
d compatible.
>>>>
>>>>
>>>> Moreover, if we could put the smaller BG in the faster disks, we coul=
d have a
>>>> decent tiering....
>>>>
>>>>
>>>>> If a user is concerned about the write or space amplicfication of su=
b-stripe
>>>>> writes on RAID56 he/she really needs to rethink the architecture.
>>>>>
>>>>>
>>>>>
>>>>> [1]
>>>>> S. K. Mishra and P. Mohapatra,
>>>>> "Performance study of RAID-5 disk arrays with data and parity cache,=
"
>>>>> Proceedings of the 1996 ICPP Workshop on Challenges for Parallel Pro=
cessing,
>>>>> 1996, pp. 222-229 vol.1, doi: 10.1109/ICPP.1996.537164.
>>>>
>>>> --
>>>> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
>>>> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
>>>>
