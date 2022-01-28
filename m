Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE649F9C2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiA1MqE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:46:04 -0500
Received: from mout.gmx.net ([212.227.15.18]:58595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348652AbiA1Mp7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643373953;
        bh=MSkcrtTDVNHv7lIub4uqRmrIACXHZbcH6R/gloUQO7c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=hKyQhNRmBELVQ2vh5rTG0sE6Y4okipCodgk8bOgkKCfKy9YXUXctZKqoyACpjeslm
         VrCUm6A08e3sSZdSpjPHlFImYLRc51jOAEDrdVZQNmLV4npTrUqG3eW+ES/py1/8C2
         kqEwavsJx7lYqiYofO1dTkd36b6S2RWgJIGHTYRw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MgNcz-1mcBsl36VT-00huvY; Fri, 28
 Jan 2022 13:45:53 +0100
Message-ID: <9e1210d4-6648-ae8c-ac4b-053b1cab9797@gmx.com>
Date:   Fri, 28 Jan 2022 20:45:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/3] btrfs: fixes for defrag_check_next_extent()
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1643354254.git.wqu@suse.com>
 <YfPe6EeJ3Tr0p0zq@debian9.Home>
 <398c9f67-5b33-c107-cd38-500c102cd7a0@gmx.com>
 <CAL3q7H4A5JQeTjN6yKevfvzd4ZUaDjbWnaX-uXFCYmEZzibOkw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAL3q7H4A5JQeTjN6yKevfvzd4ZUaDjbWnaX-uXFCYmEZzibOkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6VddgZXnHGY56pYeAXUlUg4bktiTpGeBtAGEsg9IOyCdL0NQF/W
 wwURXqoEziLAPYtt9ys0UamO81310C6U5eK9l98tOytyWUBn0RTgnFQfC3ovxVS0cV9Rf5u
 idTmh+T/Q2xcDoN53WcuaFiiKl2H1rHDv4tbI02MksBYWDH2kR/4BB1H/Ry+HcLxF8abcHg
 h3o+gG2QA/YnSQrii+C5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mJNBqQ2pCPA=:PQJ/spwtVYf6V8Imp9CbgM
 9Z27Mus+ZKGr91GgjyAsibeGgiB42XAp8M80oWKZ639Ww0NqNkQ0NVTKlTy2TxjxhbQyyfCDg
 sT3WBGj4VF/SqXAIXtpld+6e0sB7Fp8PSQwe/EmvqgB7swlh54MyfDSI+golStOwopNHM08IZ
 a/fFmC2/OpB6pJQcr1SLGXpwg9TC8vYDfaz/uSkjPFQ6FjYoUY6v0Zabf8BCOT2I978/geula
 j3mJVPhq5vt0x4riSn+0+BvAcORYK1im/y47kXtd7KhLh5UwB5SaUfcB/zegfOV/IZ9PE3cOa
 mOGjRg+S0S9i+M8HrX+ItTcw4y1O1L5dVHt0YJ0uxmXOj0MD+nNuST4lXE3pABAeecczHcLR/
 mnrZi/JYQYpvWpEbcPckFF4I1iKG7ase0ersWAd+IPtg9ImtVIsQZbuXMg4Nz6FG01KaqHZZm
 NIrx/neWn5xxayj+xvNB3z+TnUoKyr9G8Y/GL0u0QyqOvOFJRhN0PNLXR3RS96MIszAzOBS5A
 65CpkyzVO8Ae7OQ9Nq8jN0xaiSvIHJHJmD8OMDf3i2cl9qW+wiuKxB1UcqwkdtvM+gKa9B2Br
 yR4NjGRwvV4yI0QQJlKGXAo98yk6FLMRxBZgDpSACnI3FX/Zev8QrPsyi7l8BO/zMX2njy0CR
 l4KYRr8l9sgP5OreW0HiTxq6NDqD2y8X7jbAuL3nZLIW8MhmKU6EKD261RnwPfhOhNXzO416f
 8vA79IOCkUaeYUXk5FVGpy+4OcRnccNJtWkKyWzlp4I/1etOwSXVk+c26d27Rp7oEPVfpkPV3
 kk5SOMNNpIBCHDDPxB182SrPik0n4iVc+4lxhB87t4j1cU9dLT2qYbnyk1fo+w8079evwgTgS
 1gYTE5JHl8GTXJ0ENdg5DMckWo8TxYRnd1JAbHhc/D34rliJz/iFJ6dN+QLbcUb7fT14Wt9YN
 mAmJ+b+5PvRVJV2oSeEO1A3zijVKSToVhNGZ3fPODtOMrS7ss8MPqIC5/Rv60XuLCTq+LcIhl
 sVKUjRuDRMF+MjQF3JPDH3kAMqOh8K15q93W2a+38pTx41WgKeqFY3s+3eVbwnFT5cN89S7ep
 CQD3Bx0LSXXScQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/28 20:43, Filipe Manana wrote:
> On Fri, Jan 28, 2022 at 12:38 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>
>>
>>
>> On 2022/1/28 20:17, Filipe Manana wrote:
>>> On Fri, Jan 28, 2022 at 03:21:19PM +0800, Qu Wenruo wrote:
>>>> That function is reused between older kernels (v5.15) and the refacto=
red
>>>> defrag code (v5.16+).
>>>>
>>>> However that function has one long existing bugs affecting defrag to
>>>> handle preallocated range.
>>>>
>>>> And it can not handle compressed extent well neither.
>>>>
>>>> Finally there is an ambiguous check which doesn't make much sense by
>>>> itself, and can be related by enhanced extent capacity check.
>>>>
>>>> This series will fix all the 3 problem mentioned above.
>>>>
>>>> Changelog:
>>>> v2:
>>>> - Use @extent_thresh from caller to replace the harded coded threshol=
d
>>>>     Now caller has full control over the extent threshold value.
>>>>
>>>> - Remove the old ambiguous check based on physical address
>>>>     The original check is too specific, only reject extents which are
>>>>     physically adjacent, AND too large.
>>>>     Since we have correct size check now, and the physically adjacent=
 check
>>>>     is not always a win.
>>>>     So remove the old check completely.
>>>>
>>>> v3:
>>>> - Split the @extent_thresh and physicall adjacent check into other
>>>>     patches
>>>>
>>>> - Simplify the comment
>>>>
>>>> v4:
>>>> - Fix the @em usage which should be @next.
>>>>     As it will fail the submitted test case.
>>>>
>>>> Qu Wenruo (3):
>>>>     btrfs: defrag: don't try to merge regular extents with preallocat=
ed
>>>>       extents
>>>>     btrfs: defrag: don't defrag extents which is already at its max
>>>>       capacity
>>>>     btrfs: defrag: remove an ambiguous condition for rejection
>>>>
>>>>    fs/btrfs/ioctl.c | 35 ++++++++++++++++++++++++++++-------
>>>>    1 file changed, 28 insertions(+), 7 deletions(-)
>>>
>>> There's something screwed up in the series:
>>>
>>> $ b4 am cover.1643354254.git.wqu@suse.com
>>> Looking up https://lore.kernel.org/r/cover.1643354254.git.wqu%40suse.c=
om
>>> Grabbing thread from lore.kernel.org/all/cover.1643354254.git.wqu%40su=
se.com/t.mbox.gz
>>> Analyzing 5 messages in the thread
>>> Checking attestation on all messages, may take a moment...
>>> ---
>>>     [PATCH v4 1/3] btrfs: defrag: don't try to merge regular extents w=
ith preallocated extents
>>>       + Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>>     [PATCH v4 2/3] btrfs: defrag: don't defrag extents which is alread=
y at its max capacity
>>>     [PATCH v4 3/3] btrfs: defrag: remove an ambiguous condition for re=
jection
>>>     ---
>>>     NOTE: install dkimpy for DKIM signature verification
>>> ---
>>> Total patches: 3
>>> ---
>>> Cover: ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_extent.cove=
r
>>>    Link: https://lore.kernel.org/r/cover.1643354254.git.wqu@suse.com
>>>    Base: not specified
>>>          git am ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_ex=
tent.mbx
>>>
>>> $ git am ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_extent.mb=
x
>>> Applying: btrfs: defrag: don't try to merge regular extents with preal=
located extents
>>> Applying: btrfs: defrag: don't defrag extents which is already at its =
max capacity
>>> error: patch failed: fs/btrfs/ioctl.c:1229
>>> error: fs/btrfs/ioctl.c: patch does not apply
>>> Patch failed at 0002 btrfs: defrag: don't defrag extents which is alre=
ady at its max capacity
>>> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
>>> When you have resolved this problem, run "git am --continue".
>>> If you prefer to skip this patch, run "git am --skip" instead.
>>> To restore the original branch and stop patching, run "git am --abort"=
.
>>>
>>> Trying to manually pick patches 1 by 1 from patchwork, also results in=
 the
>>> same failure when applying patch 2/3.
>>
>> My bad, I'm still using the old branch where I did all my test, it lack=
s
>> patches which are already in misc-next.
>>
>> The missing patch of my base is "btrfs: fix deadlock when reserving
>> space during defrag", that makes the new lines in
>> defrag_collect_targets() to have some differences.
>>
>> As in my base, it's
>>
>>          if (em->len >=3D extent_thresh)
>>
>> But now in misc-next, it's
>>
>>          if (range_len >=3D extent_thresh)
>>
>>
>> This also makes me wonder, should we compare range_len to extent_thresh
>> or em->len?
>
> In this case I think em->len is fine.
> Using range_len, which can be shorter for the first extent map in the
> range, could trigger defrag of an extent at the maximum possible size.

Then the patch can be applied without any problem too.

Really a win-win case.

>
> Thanks.
>
>>
>> One workaround users in v5.15 may use is to pass "-t 128k" for btrfs fi
>> defrag, so extents at 128K will not be defragged.
>>
>> Won't the modified range_len check cause us to defrag extents which is
>> already 128K but the cluster boundary just ends inside the compressed
>> extent, and at the next cluster, we will choose to defrag part of the
>> extent.
>>
>> Thanks,
>> Qu
>>
>>
>>
>>>
>>> Not sure why it failed, but I was able to manually apply the diffs.
>>>
>>> Thanks.
>>>
>>>>
>>>> --
>>>> 2.34.1
>>>>
