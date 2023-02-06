Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336D068B450
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 04:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBFDFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Feb 2023 22:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFDFO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Feb 2023 22:05:14 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE779771
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 19:05:12 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mv31c-1oY8he1Jtg-00r1Y3; Mon, 06
 Feb 2023 04:05:07 +0100
Message-ID: <7074289e-13cd-ced8-a4d8-0d0b23ba177d@gmx.com>
Date:   Mon, 6 Feb 2023 11:05:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
To:     "me@jse.io" <me@jse.io>
Cc:     Ochi <ochi@arcor.de>, linux-btrfs@vger.kernel.org
References: <a502eed4-b164-278a-2e80-b72013bcfc4f@arcor.de>
 <86f8b839-da7f-aa19-d824-06926db13675@gmx.com>
 <CAFMvigd+j-ARVRepKKrW4KtjfAHGu9gW0YFb6BCegGj5Lj07ew@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: RAID5 on SSDs - looking for advice
In-Reply-To: <CAFMvigd+j-ARVRepKKrW4KtjfAHGu9gW0YFb6BCegGj5Lj07ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:H8bVnBsRPSgHy/2omCF+JKgZr0Mf4XIyrONbU0+sd0ryqK0o3B2
 ZykiPUiUyyw71mW8nXgX2J4C2DMPvBVL7GLMDEqcviiwsC0dPKhQVdHbQKrkiFuJafnK2rV
 i8Md1Nru0mFqtvmyLZq/I9A83woeZx2HQ/LHUf2rHsv0G14KwHun+f5/gv1pRm+xvfj1/Xz
 a7yDTlf3p91O7WSfkIKFw==
UI-OutboundReport: notjunk:1;M01:P0:6Il8Jkd1ouE=;wXS6NRVtzIsuafMSwPNVxaloBzo
 3MKNE9Lml1buSWnhXqIlKnDdiv/ndkMjAmAoXHgwRKHj7FI+oP7XEJbf8qMRJMKxOxZ3689RA
 x5ds2x8600XHmjqz0k9DlONjby5QHl/jCW+XpFC05YBIqocatUvknD+0cUBMPRlnNu55xmp2+
 nQGqd7U46nlm+I41rTSIUHuPF0bGW6uMbZwagegK9Ih1PsJMQLOiNubOjOjLlRH8uheirI3q5
 yoJ9D7NB7DSkaayvFgvB5hz8rHahq1HWQ478q0V/GwhCDGx3VUCb3Ay+ow3lE8axOf/TZsCxF
 M3mi9XTnvy22egmLEKQidgDiKcciU0qVwAzDBKNOjD7mNyv4BaVdmaMcqrEweRP1LW7PcLj68
 gPLICSPSIAF2e+JHG9gp3eTxWn/lhUFD/TZQ0jziF7EOI1PiRAAVvHIU3CYDuidpBcFmYXuYM
 WFPw8IIkhguOt/cEE9ExKwlsquLhofjTXwVzxK7IZMpVFqFcWEZFKxUQgJMoQak5G3I98jMYj
 vtyFzeDW3gFwPhhUMtJZ/7uMRP+RxvXa/lW4Yet1zVkjETg3cYr1RETdAy3dnnB6yt9PVpzOE
 wy/PTBgkUrcyYttrwHrNbkbezBOVspVMimCA8zbpDDR2VqYLeEy+yzudwi0DhcfMPq6Y4d/f8
 IDfZfYPJMf1+ZTe0vbcX9874IN6aqNe7apXyyLwG1cN+g4aiIA/D6K7/vgzJCsTpg9UmWqFOe
 SoCOT2RqKK8UEZezIqCucZbjIwz+yvfDLnuMIlqV/bmhpkrfm7BQ5s/uIDvaO0JSZDp4QalZZ
 58UvJiFSBN3kjdd2vng+5WIlBUQJwf2z6bQhHJB82TnRfo5+a95PnoYDxD0YnFwpjCnCLS7E8
 gHZ4XVf6Wg6HmuFupHjnJNyn7j9T/p49NK6zS+ozkglvY4b3oS8/9qBlRIOS60EzckoR7pStN
 WKldG4mL0T1OGyeeNRfsnmdK/VA=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/6 10:34, me@jse.io wrote:
> Apologies for the duplicate, I sent the last reply in HTML by mistake.
> Take two lol.
> 
> Given that 6.2 basically has fixes for the RMW at least for RAID5, apart
> from scrub performance deficiencies and the write hole, are there any other
> gotchas to be aware of?

Firstly, 6.2 would only handle the RMW better for data.
There is no way to properly handle metadata easily, thus it's still not 
recommended to use RAID56 for metadata.

But still, things like parity-update-failure, read-repair-failure should 
be fixed with the RMW fixes.

Secondly the write hole is not yet fixed, the RMW fix would greately 
migrate the problem, but not a full fix.

Other ones look like regular scrub interface bugs.

> This mailing list post <
> https://lore.kernel.org/linux-btrfs/20200627030614.GW10769@hungrycats.org/>
> listed several concerning bugs, like "spurious degraded read failure" which
> is a concerning bug for me as I'm hoping to use Btrfs RAID5 for a media
> server pool and it would be nice to have it be usable when degraded
> without. It would be nice to be able to read my data when degraded. How
> many of these bugs listed here have since been fixed or addressed by the
> RMW fixes in 6.2?
> 
> Also concerning NOCOW (nocsum data), assuming no device failure, if a write
> to a NOCOW range gets out of sync with parity (ie, due to a crash/write
> hole) will scrub trust NOCOW data indiscriminately and update the parity,
> or does it get ignored like how NOCOW is basically ignored in RAID1?

NOCOW/NOCSUM is not recommended, as even with or without the RMW fix, we 
trust anything we read from disk if there is no csum to verify against.

Our trust priority is:

Data with csum (no matter pass or not, as we would recheck after repair) 
 > Data without csum (read pass, then trust it) > Parity

Thus data without csum can only be repaired if the read itself failed.
And if such data without csum has mismatch with parity, we always update 
parity unconditionally.

Thanks,
Qu

> 
> 
> On Sun, Oct 9, 2022 at 8:36 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2022/10/9 18:34, Ochi wrote:
>>> Hello,
>>>
>>> I'm currently thinking about migrating my home NAS to SSDs only. As a
>>> compromise between space efficiency and redundancy, I'm thinking about:
>>>
>>> - using RAID5 for data and RAID1 for metadata on a couple of SSDs (3 or
>>> 4 for now, with the option to expand later),
>>
>> Btrfs RAID56 is not safe against the following problems:
>>
>> - Multi-device data sync (aka, write hole)
>>     Every time a power loss happens, some RAID56 writes may get de-
>>     synchronized.
>>
>>     Unlike mdraid, we don't have journal/bitmap at all for now.
>>     We already have a PoC write-intent bitmap.
>>
>> - Destructive RMW
>>     This can happen when some of the existing data is corrupted (can be
>>     caused by above write-hole, or bitrot.
>>
>>     In that case, if we have write into the vertical stripe, we will
>>     make the original corruption further spread into the P/Q stripes,
>>     completely killing the possibility to recover the data.
>>
>>     This is for all RAID56, including mdraid56, but we're already working
>>     on this, to do full verification before a RMW cycle.
>>
>> - Extra IO for RAID56 scrub.
>>     It will cause at least twice amount of data read for RAID5, three
>>     times for RAID6, thus it can be very slow scrubbing the fs.
>>
>>     We're aware of this problem, and have one purposal to address it.
>>
>>     You may see some advice to only scrub one device one time to speed
>>     things up. But the truth is, it's causing more IO, and it will
>>     not ensure your data is correct if you just scrub one device.
>>
>>     Thus if you're going to use btrfs RAID56, you have not only to do
>>     periodical scrub, but also need to endure the slow scrub performance
>>     for now.
>>
>>
>>> - using compression to get the most out of the relatively expensive SSD
>>> storage,
>>> - encrypting each drive seperately below the FS level using LUKS (with
>>> discard enabled).
>>>
>>> The NAS is regularly backed up to another NAS with spinning disks that
>>> runs a btrfs RAID1 and takes daily snapshots.
>>>
>>> I have a few questions regarding this approach which I hope someone with
>>> more insight into btrfs can answer me:
>>>
>>> 1. Are there any known issues regarding discard/TRIM in a RAID5 setup?
>>
>> Btrfs doesn't support TRIM inside RAID56 block groups at all.
>>
>> Trim will only work for the unallocated space of each disk, and the
>> unused space inside the METADATA RAID1 block groups.
>>
>>> Is discard implemented on a lower level that is independent of the
>>> actual RAID level used? The very, very old initial merge announcement
>>> [1] stated that discard support was missing back then. Is it implemented
>>> now?
>>>
>>> 2. How is the parity data calculated when compression is in use? Is it
>>> calculated on the data _after_ compression? In particular, is the parity
>>> data expected to have the same size as the _compressed_ data?
>>
>> To your question, P/Q is calculated after compression.
>>
>> Btrfs and mdraid56, they work at block layer, thus they don't care the
>> data size of your write.(although full-stripe aligned write is way
>> better for performance)
>>
>> All writes (only considering the real writes which will go to physical
>> disks, thus the compressed data) will first be split using full stripe
>> size, then go either full-stripe write path or sub-stripe write.
>>
>>>
>>> 3. Are there any other known issues that come to mind regarding this
>>> particular setup, or do you have any other advice?
>>
>> We recently fixed a bug that read time repair for compressed data is not
>> really as robust as we think.
>> E.g. the corruption in compressed data is interleaved (like sector 1 is
>> corrupted in mirror 1, sector 2 is corrupted in mirror 2).
>>
>> In that case, we will consider the full compressed data as corrupted,
>> but in fact we should be able to repair it.
>>
>> You may want to use newer kernel with that fixed if you're going to use
>> compression.
>>
>>>
>>> [1] https://lwn.net/Articles/536038/
>>>
>>> Best regards
>>> Ochi
