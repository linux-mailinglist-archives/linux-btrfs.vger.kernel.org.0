Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F329660D4B
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jan 2023 10:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjAGJiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Jan 2023 04:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbjAGJhy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Jan 2023 04:37:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F58977AD7
        for <linux-btrfs@vger.kernel.org>; Sat,  7 Jan 2023 01:37:52 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1poA-1pBsij2R2m-002Hl4; Sat, 07
 Jan 2023 10:37:50 +0100
Message-ID: <42964604-a215-f856-2aeb-cf5664d84745@gmx.com>
Date:   Sat, 7 Jan 2023 17:37:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: File system can't mount
To:     Robert LeBlanc <robert@leblancnet.us>
Cc:     Antonio Muci <a.mux@inwind.it>, linux-btrfs@vger.kernel.org
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
 <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
 <4f134378-4298-bc28-c17a-8415ffdc19e9@gmx.com>
 <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
 <0de3f1eb-4131-774b-74bc-ab2cfdd022de@inwind.it>
 <b09e0dfc-a911-5eea-8a35-f829ab618b2d@gmx.com>
 <CAANLjFroTEUcOLjfRs-4FWdSf_rgnSHpP8TkU8fo--SYrfjKCg@mail.gmail.com>
 <3a220ba2-67a6-c3b8-6b07-cf70c1c80fc2@gmx.com>
 <CAANLjFr9OPyvoGfg7dfU314=ba01Ar=GuiXZmef+skCXEC+OzQ@mail.gmail.com>
 <CAANLjFoSoYa3ZXHsG7fML0_RXh4t8yQQ3qVzpBMJqpeM3hKSgg@mail.gmail.com>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAANLjFoSoYa3ZXHsG7fML0_RXh4t8yQQ3qVzpBMJqpeM3hKSgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CyVc3DoMl4/GVGhRWF284OJGE5XDKOHdBinV43hb0n+9iwQDj5n
 rDyVP+Kv+djyhpi2NcbqsG33G/PO/i0Xmo1cDn45tA7BGfcwBLoZ3pd/zejClmhZuo8lSVS
 7ELfj88ql7taESC3KOn4mFbQp9hmYT/RRuB2Ot5NixwBroMU4gLbkFBMpNtfaZKPIsQYXEg
 qE/bGZob8fzuQGv0ZljDQ==
UI-OutboundReport: notjunk:1;M01:P0:wijTvPhz+bA=;GOjr/Ok8XPy+h30KghcRvqTxauO
 UZKSey9v+42kwVQCO4ATu7aBfEYqn9Bu26RHA2sjTxUNsjO/7O3Y2d4yUnfgeEwmW3Yy4uEDU
 EC+zD8FEhPPZ0/odd7KAIQSu28vauoVyDdHxpm1Qi0QUimEi2ckILsZlwZ2PZ9tFNQGEfD5EN
 JnwRWIKJDKQqWComeD5lVZoxa0/EYc+Iu1s1g7xCoqfhOfcVGY/S7OyscZebWL4ED1dPEd1wU
 rhEII+nKDO+J9W11tnlf2lFH5rSl+LQYwuBi7/OnBOIIwKps6tX3DKTqCwwaw9CgC76pbTPYH
 JeoiuVm6ddeNHDwIuUou8w/CLQOdzda8fF9HdKaoRXHeoPxn39iIq+yWNEzSM3CJGkiV/Gf/+
 G09ntxG3uRKCC/WeppV2PsAKAAdfsvjNnbPwadYSu+y1UnMKkC7q6EUl+MOb6m64LvSv/yidU
 vWUUS54soAyKPTbs75V/NdaZbI0zN7Mq+LBWm2T3lZLX3/1uPn7mQ5AQx8g7Q4AK/T1JfyUYB
 /FxABXyJOIW50njpKLgUdKaq5gCE7SWeoNcyTXl67BRm9Vo9tzhq2728NpyGoze/p2vgwImOr
 6+qljze59XGAMq8tmM/YdCPdvl3a1/+iiSBqNJoQaASCqJn+O0tZlYZgQEB9cNMGem0mk2vTO
 iQ+Tn9+y4qo9kZ758KRUcdJ+dzLklEChQ+37PVFtgXkULd8KTtobxAeGDMlfdCXcjjCq2vLYq
 lMNfvDK2FLVrXehCLIT8PpmmOCYiUlHdYML47akJ/GxY6/ifDgzSvviiLdNqoa21UodjKELD4
 QAuYbrM5v1GYyjpQzIUUA2mnADJ+Pw8Dhd1q43PWfAMh8DxbX/Z4LvNkwE7Tqs2veZLNysOJU
 uoWDgg1jNCovofpmFSuu7xKKq8IaXU1/H+1p42TSFo41ZwTx1cdGf25Zx/WJt5P4j+N7FnElQ
 ZwhFngBmhQ0YWJWN613ksKcQBHg=
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/7 13:58, Robert LeBlanc wrote:
> On Fri, Jan 6, 2023 at 5:45 PM Robert LeBlanc <robert@leblancnet.us> wrote:
>>
>> On Fri, Jan 6, 2023 at 12:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>> Your assumptions are spot on. One of the two memory dims is either bit
>>>> flipping or stuck on 0/1. After running memtest86+, I can verify that
>>>> some memory addresses create spoiled data. I'm currently running off
>>>> the good DIMM as I get some new RAM ordered and recovering from
>>>> backups (apparently my backups stopped in September of last year) and
>>>> then trying to pull off the newer data that I need from the bad file
>>>> systems.
>>>
>>> Well, I'd say that filesystem should still be over 99% fine.
>>> Even the memory hardware is faulty, it shouldn't cause huge damages for
>>> the filesystem.
>>>
>>>> It's really odd that I never saw csum errors in dmesg and it
>>>> only appears that metadata got corrupted.
>>>
>>> That's because if the corruption happens for data, you won't be able to
>>> see any csum mismatch.
>>>
>>> Because the corruption happens in memory, we calculate the csum using
>>> the bad data, thus no csum mismatch would happen.
>>
>> I would have thought that the csum was being calculated as the data
>> was being written to memory and before being stored in memory, but
>> thinking about it more, I'm not sure the VFS will let you do that, so
>> you can only inspect the data after it's already been written to
>> memory and corrupted.
>>
>>> You can only be sure by comparing with the backup.
>>>
>>>> It looks like some of my
>>>> more critical subvolumes I could either do a `btrfs send/receive` or
>>>> do an `rsync` of them from my NVMe btrfs. I hope the HDD will have
>>>> similar luck and since there weren't a lot of writes to my large
>>>> volume, I'm hoping that it escaped corruption.
>>>
>>> In fact, that bitflip seems to be the only corruption (that matters).
>>> Thus you can go "btrfs check --repair", and still use the fs
>>> (if after repair, the fs can pass btrfs check).
>>>
>>>>
>>>> Thinking out loud here, with BTRFS being so good at detecting bit rot
>>>> on disk, could that be expanded to in-memory data structures kind of
>>>> like RAID with checksums?
>>>
>>> In fact, if you're using newer kernel from day 1, then such corruption
>>> can be prevented directly.
>>>
>>> Newer kernel (v5.15+?) would reject any write that has obviously bad
>>> metadata.
>>
>> I was on v5.18 for a while (months, maybe since the backups stopped).
>> The backups before didn't complain of empty streams or anything so it
>> probably happened between then and running v5.18. I created the new
>> NVMe btrfs filesystem on 6.0, but the HDD filesystem won't mount on
>> 6.0. So, I've got to decide to go with the demon that I know (boot
>> into v5.18 and try to get things off), or the demon I don't (repair
>> the fs in v6.0 and hope it gets better to mount).
> 
> Well, it refuses to repair the file system.
> 
> ~/code/btrfs-progs$ sudo ./btrfs check --repair /dev/mapper/1EV13X7B
> enabling repair mode
> WARNING:
> 
>         Do not use --repair unless you are advised to do so by a developer
>         or an experienced user, and then only after having accepted that no
>         fsck can successfully repair all types of filesystem corruption. Eg.
>         some software or hardware bugs can fatally damage a volume.
>         The operation will start in 10 seconds.
>         Use Ctrl-C to stop it.
> 10 9 8 7 6 5 4 3 2 1
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/1EV13X7B
> UUID: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> WARNING: tree block [12462950961152, 12462950977536) is not nodesize
> aligned, may cause problem for 64K page system
> ERROR: add_tree_backref failed (extent items tree block): File exists
> ERROR: add_tree_backref failed (non-leaf block): File exists
> well this shouldn't happen, extent record overlaps but is metadata?

OK, this part needs some update to properly handle it.

I can craft a dirty fix for it, but meanwhile would you try "btrfs check 
--repair --mode=lowmem" to see if lowmem mode can handle the case?
(Though it can be very slow).

If lowmem mode doesn't work either, I can work on a quick dirty fix first.

Thanks,
Qu
> [12462950973440, 16384]
> Aborted
> 
> ~/code/btrfs-progs$ ./btrfs --version
> btrfs-progs v6.1.2
> 
>> I enjoy exercises like this to learn more, but they always seem to
>> come at inconvenient times.
>>
>>>
>>> Thus in your case, it would result a RO mount, but no such corruption.
>>> (But of course, if the memory bitflip happens for data, there is no way
>>> to catch it)
>>>
>>> Thanks,
>>> Qu
>>
>> Thank you,
>> Robert LeBlanc
> 
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
