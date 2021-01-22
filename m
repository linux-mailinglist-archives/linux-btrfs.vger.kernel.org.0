Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646F92FFE32
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 09:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbhAVIa0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 03:30:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:44481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbhAVI0K (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 03:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611303874;
        bh=R2fYthOq4Iu/X82aK3zJ4UJ03jjZjPpPUNYWuQBqHsg=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=fbNqx0hIBhnTkzVw6Rl9bvQvm7SEAT+qDgEAT40Aj7P3yG9/H8kjZ+y8Y7paPbCpu
         0d7xVHFAKHruSQUWJ8Wxmd3RCxizjqFzYQ+W3/5KIht1wSor0FXuvB7BkgZ/OKKX/1
         ND2tVsAj2Dc+DIjBPYvA2VbWYN/Kn/IVseN4d03g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N4zAy-1m3WzN1eYG-010vPd; Fri, 22
 Jan 2021 09:24:34 +0100
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210122060052.74365-1-wqu@suse.com>
 <80e61dcf-e44c-44c9-ef8c-7efc81a136ea@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: make Private2 lifespan more consistent
Message-ID: <8c8c6722-4894-409f-13b1-fc877e9e2784@gmx.com>
Date:   Fri, 22 Jan 2021 16:24:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <80e61dcf-e44c-44c9-ef8c-7efc81a136ea@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n3SS0Ww++o+q1HY/pTLGumlah/c2Um+dYDbFOE6r9GY8HS8DiLd
 YtsQ359neZ/qn0OkfG7C7lyDzXAd9mlEVM7GwGU4pfrpQICsKtS9RAZu2y02yI5aaU+l/kP
 yK36k2uEEUK8KNBHpGBOM0RDPv7sl9T8m5ur+y9I2x6aMLeaSH1Ir4N3FNW1EKNucIGZfOa
 LEOA5ZoUG7aE6RlgTQe5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:sg4K2YpGLwE=:d+nN4x9UNSSrG3UUPXjWtp
 N4HbC8sz6z6OcaDhsFcEDbRpXqZpgTn43Lp9FWEhSF318ErgMxGy7gIZWZxu4eUSyNakdRUsL
 +Ejerd8x0UTzY2e0p6JdnMEpBPQXwH2FcuT6M0yxY2QIPbWgtAkyS89dnnP1UhbkuThr02V6Y
 sdsXsJHbpWkkogwkjLxHhmZNaZI3K8xnM41bw9n8g2EQTwqSRprcGAIJY+Ed4pakVbdJpbIf1
 061LTdFKzEXm6jq5MmCBY+aUsSXXE86KCNg20+dZUPIH7UioLmoRGlMs+h6YxdC55dCREkThz
 IUzdM/p6iQHNnZw8j2O9LyPFCjr6y/DaXCwOH4ThWyy4LcnQKaz36obs7mM/fbg0OX6eeI4Gp
 5vS69e3P2w4Jhd3vf4FArTZfe6Jr3o3SpFGQikFZGTn05VCCZ/mkgSLPSmB9kRRlqC8PSfVCz
 vH2LGC2PFoMkjIeaaqItsHt62nzADxZtif5ALZppw13Dy0fjdOcQdwoX1wyBLxpi6EKhYwxzT
 SFLL+z13oFBDV8I3vhT5siDt5+i2cq9GpA+gXngiQJnhWWf4f+q1eHDRccqaGaFhaAoyr3Wng
 iMUWDQtb80BPFd9bFEUhFRIhgPW02KeCAIrrKFwTZxBPss9ga2xsNlUTzGrCXu0JV49iO/kKa
 VI3i2T0k0GyfbOCC3Jk08l8O2BD4Wq4SE2yxcH/lkhYYAp0esNwftbeZupFpo4MGYYewQPpce
 yGnd/FYvSU1omYZuAaK2SbGUWREzsAV7GO+tCu04JQqcxijkkjdfqEQ9hSQHkiNhqGSjKm/bb
 ICvjY1TfZ979e/aqUmE5jtT8s1HVx3xHlMcrlA6ykQLlDJJiERetlSbyDIBt0Jsh7Jock/ywc
 BFRh23BH+YgZjTr5schQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/22 =E4=B8=8B=E5=8D=884:04, Nikolay Borisov wrote:
>
>
> On 22.01.21 =D0=B3. 8:00 =D1=87., Qu Wenruo wrote:
>> Currently btrfs uses page Private2 bit to incidate if we have ordered
>> extent for the page range.
>>
>> But the lifespan of it is not consistent, during regular writeback path=
,
>> there are two locations to clear the same PagePrivate2:
>>
>>      T ----- Page marked Dirty
>>      |
>>      + ----- Page marked Private2, through btrfs_run_dealloc_range()
>>      |
>>      + ----- Page cleared Private2, through btrfs_writepage_cow_fixup()
>>      |       in __extent_writepage_io()
>>      |       ^^^ Private2 cleared for the first time
>>      |
>>      + ----- Page marked Writeback, through btrfs_set_range_writeback()
>>      |       in __extent_writepage_io().
>>      |
>>      + ----- Page cleared Private2, through
>>      |       btrfs_writepage_endio_finish_ordered()
>>      |       ^^^ Private2 cleared for the second time.>     |
>>      + ----- Page cleared Writeback, through
>>              btrfs_writepage_endio_finish_ordered()
>
> Where exactly is page writeback cleared in btrfs_writepage_endio_finish
> or  finish_ordered_fn?

My bad. It's in finish_ordered_io().

>
>>
>> Currently PagePrivate2 is mostly to prevent ordered extent accounting
>> being executed for both endio and invalidatepage.
>> Thus only the one who cleared page Private2 is responsible for ordered
>> extent accounting.
>
> SO this patch likely fixes the race and double accounting you've seen on
> the subpage branch,

Nope, it's unrelated at all.

The subpage problem is in the patch where I convert
btrfs_writepage_endio_finish_ordered_io() to support subpage.

In that patch I wrongly moved the timing of ClearPagePrivate2() after we
queued the ordered extents.

Thus there will no be specific patch for that fix, just update that
patch to solve the problem.

> however it's still not clear how the race occurs.

There is no race in current code base.

The invalidatepage() will wait writeback, thus it means there are the
following possible combinations:

- Page Writeback | Private2
   Then invalidatepage() will wait for Writeback, and during endio,
   Private2 will be cleared.

   Accounting is done in endio.

- Page Writeback but NO Private2
   The same as previous cases

- Page Private2 but NO Writeback
   Invalidatepage() will just clear Private2 and do the ordered extent
   accounting.

   Accounting is done in invalidagepage()

- Page without Private2 nor Writeback
   Do nothing.



> IIUC PagePrivate must ensure that invalidatepage and endio don't run
> concurrently. To that effect invalidatepage indeed checks to see if it's
> the one which cleared pageprivate and if so it will run
> btrfs_dec_test_ordered_pending and btrfs_finish_ordered_io. However, in
> __extent_writepage_io btrfs_writepage_cow_fixup clears it
> unconditionally and calls btrfs_writepage_endio_finish_ordered for hole
> extents, right?
>
> But in this case invalidate invalidatepage can never have
> cleared_private2 set to true. IMO the actual problem this could lead
> warrants more explanation.
Your understanding is correct and it matches the correct code and my
understanding too.

Thus this patch is really just to make the life span easier to read, no
functional change at all.

Thanks,
Qu

>
>>
>> But the fact is, in btrfs_writepage_endio_finish_ordered(), page
>> Private2 is cleared and ordered extent accounting is executed
>> unconditionally.
>>
>> The race prevention only happens through btrfs_invalidatepage(), where
>> we wait the page writeback first, before checking the Private2 bit.
>>
>> This means, Private2 is also protected by Writeback bit, and there is n=
o
>> need for btrfs_writepage_cow_fixup() to clear Priavte2.
>>
>> This patch will change btrfs_writepage_cow_fixup() to just
>> check PagePrivate2, not to clear it.
>> The clear will happen either in btrfs_invalidatepage() or
>> btrfs_writepage_endio_finish_ordered().
>>
>
> <snip>
>
