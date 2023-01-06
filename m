Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726F165F812
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jan 2023 01:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbjAFAUl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 19:20:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjAFAUi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 19:20:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086F3D5D0
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 16:20:36 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MdvqW-1ocssR1q7C-00b3Pw; Fri, 06
 Jan 2023 01:20:34 +0100
Message-ID: <b09e0dfc-a911-5eea-8a35-f829ab618b2d@gmx.com>
Date:   Fri, 6 Jan 2023 08:20:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To:     Antonio Muci <a.mux@inwind.it>,
        Robert LeBlanc <robert@leblancnet.us>,
        linux-btrfs@vger.kernel.org
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
 <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
 <4f134378-4298-bc28-c17a-8415ffdc19e9@gmx.com>
 <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
 <0de3f1eb-4131-774b-74bc-ab2cfdd022de@inwind.it>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: File system can't mount
In-Reply-To: <0de3f1eb-4131-774b-74bc-ab2cfdd022de@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tB6i/s+fMgXmhJB2Sz8GmqNEhpjN76pQ9IRhrwyF+TYEql0kDNq
 5jta8+wEb217ZEjoiDaMfUngs8dM/AqBRcWmDShUOi3F/6no9yiPuxUsPeHgy6cl3FbNOw2
 U/W8uhgZRdb4FgjOa92acakKJMLfLqWO3ObvbakezcoWEqo6verfVyremgBdFBItdxHg91t
 G5p4j0hrPudTE+Zr2hskg==
UI-OutboundReport: notjunk:1;M01:P0:Svo/M4oj22g=;IhG983oZzbJxyTgx2kqN5is9JK2
 JDIzQzeSH/RgtY8eYQtllCIzdmTv5yJ/FusA3wDn8rEnp5yYCEwv7tGrlhPA8FjfdHieN/Hc5
 yQQhex9gkSUZsvGhjQhzhtKe8/MvwzFTjIlMzMBJ/7MV86781c5keof8kxytZyCZAfHO7Wxcb
 covFyfsI6nAHnAWfDWBCjvSHd4apYLUR7zFAfl2e/k7f/m/dWvz+QQV9oM+SDiC2WQFLukL5K
 SyqwOMzbvuFeVZU0Mq93/873A6aGcpF9jq4D6p0KIQoKXpuFwGlMrWKFWk71DgDMhthjRGGVx
 XF5L/l1Q3WwLDaR6XYNFo86NzBSPy11Cy6KlTAtcFTrCxNXrt/7zd1fr1sb90hn06fCN9NX0B
 8/QNY6r/obqNnVEPi8HkGBlzUU126pxAwDHFlbOj3UV0Em9FfurpJEbCjvFUd6Rj4s3+RHzRS
 IkE8nhaNPA8FzeGZ4GOIW8kor66rt92nSykSfFGedAUhO2xVH2fmvXSnO7T6717K4zV4KtlWP
 jaLw4nP+mn8nKavIua+dI6Nzu2RIup9yrD8ve7/AKmiqBLMsd+EPmks26Jqz+n2t+DDwLYkMt
 MAqnXI9xFLrR/gfRnhkYRaz/QELeOLBP0kS/e1bB7Was37jYe1cSckQYU/P96hUFL8190yC18
 WoKQMYh5xslMsejfCWtCWC3wjz0ZFcT5ngSrUNS1o9ZUnwq0fQeU/gaN8fS9FkKksF/2uti7N
 qcsQa2HOeTcxNX6rP572pdQSeTBi9GNCZhbgDoYkAUGIX5aFed4IPbegdbU012Y7gcShHyPGj
 h3VWk7vUmq+9rOUSkBCp4QMDITJKkJG3+ZEBevGjEXkRvZwYSoMh6/z9wplx0bdNM+k53wSTR
 M42YFk9EZwgKBT3tAgobaFXrr/XeSt+VMRmgcq7unpx/cn4F0o7n2Pddts7iHKbZYaPb/LtcL
 p7qRSd1dX5wuYOM/nilzdpP7JCY=
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/5 23:48, Antonio Muci wrote:
> On 05/01/23 13:08, Qu Wenruo wrote:
>>
>>
>> On 2023/1/5 14:44, Qu Wenruo wrote:
>>>
>>> On 2023/1/5 13:24, Robert LeBlanc wrote:
>>>> On Wed, Jan 4, 2023 at 10:11 PM Robert LeBlanc 
>>>> <robert@leblancnet.us> wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>> #:~/code/btrfs-progs$ sudo ./btrfs check /dev/mapper/1EV13X7B
>>>>> Opening filesystem to check...
>>>>> Checking filesystem on /dev/mapper/1EV13X7B
>>>>> UUID: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
>>>>> [1/7] checking root items
>>>>> [2/7] checking extents
>>>>> WARNING: tree block [12462950961152, 12462950977536) is not nodesize
>>>>> aligned, may cause problem for 64K page system
>>>>> ERROR: add_tree_backref failed (extent items tree block): File exists
>>>>> ERROR: add_tree_backref failed (non-leaf block): File exists
>>>>> tree backref 12462950957056 root 7 not found in extent tree
>>>>> incorrect global backref count on 12462950957056 found 1 wanted 0
>>>>> backpointer mismatch on [12462950957056 1]
>>
>> And there are two extent items involved in the case.
>>
>> The number 12462950961152 is the incorrect backref, while extent 
>> 12462950957056 is the correct extent item which misses the backref item.
>>
>> I'm afraid that, there could be a memory bitflip:
>>
>> 12462950957056 = 0xb55c1c3c000
>> 12462950961152 = 0xb55c1c3d000
>>
>> The difference is one bit flipped in the larger one.
>>
>> Thus I strongly recommended to do a memtest before trying anything else.
>>
>> Thanks,
>> Qu
> 
> 
> Hi Qu,
> 
> I've been lurking the mailing list for a long time now (thanks everyone 
> btw: it is really a teaching experience), and I conditioned myself to 
> convert in hex whatever number I find in the logs in order to look for 
> bitflips.
> 
> In this case, however, even if I understand your explanation, I would 
> not have been able to deduce it by simply reading the logs. Maybe having 
> them also in hex would have helped a bit, but I am not really sure (how 
> to realize that 12462950961152 is the incorrect backref?).
> 
> Is there any way to give more hints to the user in the error messages? 
> Where to look?

There are several hidden assumptions.

- For recently created/balanced btrfs, there should be no tree blocks
   crossing stripe/64K page boundary
   Thus a single backref crossing the boundary is not some common thing.

   We should either get tons of such metadata, or none.

- Dmesg itself only contains the obviously bad info
   In your case, it's "btrfs check" result showing the details.
   As kernel rejects the mount directly, without giving any chance
   to look into the situation.

- One backref is missing, one backref should not exist
   This is already a hint to let us link those two backrefs.

   And if we compare the hex of the two backrefs, we got one
   bitflipped.

   Furthermore this does not only matches the symptom, but also possible
   to happen.
   The metadata itself is fine, but when adding the backref, bitflip
   happened in the key of the backref, resulting a missing backref for
   the correct metadata, while a backref doesn't has any metadata for it.

Thus I believe it's a memory bitflip.

Thanks,
Qu

> 
> Thanks
> Antonio
> 
> 
>>>>> extent item 12462950961152 has multiple extent items
>>>>> ref mismatch on [12462950961152 16384] extent item 1, found 2
>>>>> backref 12462950961152 root 7 not referenced back 0x56292931ae60
>>>>> incorrect global backref count on 12462950961152 found 1 wanted 2
>>>>> backpointer mismatch on [12462950961152 16384]
>>>>> owner ref check failed [12462950961152 16384]
>>>>> bad metadata [12462950961152, 12462950977536) crossing stripe boundary
>>>>> data backref 12493662797824 root 13278 owner 193642 offset 0 num_refs
>>>>> 0 not found in extent tree
>>>>> incorrect local backref count on 12493662797824 root 13278 owner
>>>>> 193642 offset 0 found 1 wanted 0 back 0x562920287070
>>>>> incorrect local backref count on 12493662797824 root 17592186057694
>>>>> owner 193642 offset 0 found 0 wanted 1 back 0x562929472ba0
>>>>> backref disk bytenr does not match extent record,
>>>>> bytenr=12493662797824, ref bytenr=0
>>>>> backpointer mismatch on [12493662797824 24576]
>>>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>>> [3/7] checking free space cache
>>>>> there is no free space entry for 12462950957056-12462950961152
>>>>> cache appears valid but isn't 12461878018048
>>>>> [4/7] checking fs roots
>>>>> [5/7] checking only csums items (without verifying data)
>>>>> [6/7] checking root refs
>>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>> found 13920420491265 bytes used, error(s) found
>>>>> total csum bytes: 13555483180
>>>>> total tree bytes: 17152835584
>>>>> total fs tree bytes: 1858191360
>>>>> total extent tree bytes: 563019776
>>>>> btree space waste bytes: 1424108973
>>>>> file data blocks allocated: 28183758581760
>>>>> referenced 19476700778496
>>>>>
>>>>> #:~/code/btrfs-progs$ git rev-parse HEAD
>>>>> 1169f4ee63d900b25d9828a539cee4f59f8e9ad7
>>>>> ```
>>>>>
>>>>> dmesg output:
>>>>> ```
>>>>> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): using crc32c
>>>>> (crc32c-intel) checksum algorithm
>>>>> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): allowing 
>>>>> degraded mounts
>>>>> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): disk space
>>>>> caching is enabled
>>>>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>>>>> /dev/mapper/8HJK8KGH errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>>>>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>>>>> /dev/mapper/8HHW90DY errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>>>>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>>>>> /dev/mapper/1EV13X7B errs: wr 0, rd 0, flush 0, corrupt 18, gen 2
>>>>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>>>>> /dev/mapper/K1KLMBZN errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>>>>> [Wed Jan  4 19:52:41 2023] BTRFS critical (device dm-5): corrupt leaf:
>>>>> block=45382409060352 slot=31 extent bytenr=12462950973440 len=16384
>>>>> previous extent [12462950961152 169 0] overlaps current extent
>>>>> [12462950973440 169 0]
>>>>> [Wed Jan  4 19:52:41 2023] BTRFS error (device dm-5): read time tree
>>>>> block corruption detected on logical 45382409060352 mirror 2
>>>>> [Wed Jan  4 19:52:41 2023] BTRFS critical (device dm-5): corrupt leaf:
>>>>> block=45382409060352 slot=31 extent bytenr=12462950973440 len=16384
>>>>> previous extent [12462950961152 169 0] overlaps current extent
>>>>> [12462950973440 169 0]
>>>
>>> Sometimes I have to say, tree-checker is more to-the-point than 
>>> btrfs-check.
>>>
>>> It's very plain that one metadata backref item overlaps with the 
>>> previous one.
>>>
>>> Which can be very problematic (the content of tree block overlapping 
>>> is not a good thing at all).
>>>
> [...]
