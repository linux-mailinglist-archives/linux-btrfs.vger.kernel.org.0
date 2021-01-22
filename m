Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9992FFE6F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Jan 2021 09:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbhAVIm2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Jan 2021 03:42:28 -0500
Received: from mout.gmx.net ([212.227.15.19]:49283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbhAVImJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Jan 2021 03:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611304826;
        bh=j+Jfvs9tM7jdLkQwr6+ujPn6gywR2lOCRcbbN2vs7Sk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=aUSz1NDuHl62OcqAOT1K8boU8d45V74JEahaEkeYrg/bRfVFXUuJghSzBZFsiXUuW
         RKC2KxLFymVFb9yQFSE0WBcP/QnMinc/Jx89BlGiiWSg8G10nfERaYXksRSVGCrG8t
         kAJujl55SJYNMv/QtWwRbh39JmnqS9PYcIWXq72U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Msq6M-1lrOD33rOy-00tAIL; Fri, 22
 Jan 2021 09:40:26 +0100
Subject: Re: [PATCH] btrfs: make Private2 lifespan more consistent
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210122060052.74365-1-wqu@suse.com>
 <80e61dcf-e44c-44c9-ef8c-7efc81a136ea@suse.com>
 <8c8c6722-4894-409f-13b1-fc877e9e2784@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <707e2847-a043-5dc6-bea0-21f5c4c0868f@gmx.com>
Date:   Fri, 22 Jan 2021 16:40:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <8c8c6722-4894-409f-13b1-fc877e9e2784@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J+Nx+YFGW06CVBebRBQV9QbeDdIPjSciCJe3Y/gp0QTtUeCtWEw
 tzQvo3ZjpBi1d5njF8tNHBD8Jix1y4yfwLB5v85rAKB+vMHMRfHAjwmCi74VkLKP4dcCA/b
 Rc7xt0iQYvEj06SurJg/5eqHZpZL/Z/r/tHT6fcJzSgYqIfaNqA6hISNxsTWQxVyWtHctNN
 o1jrk80m8Ie7dwtVMPEJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m3qn/lJMoxs=:/NlcU8sunq6XIjKuzzLHLY
 qj5p3m95jtaGwijulZEWSrKVhvsJbtql/re0GUsxvg2uWLbqk1PQ+ZTMryyV3MRB7QNGcs4WF
 9v/7Cn/COOvfnNiv74ACOaVvqk7UYINMaWDxqiqsEJxF/RoL6Dsrn0h9cOJ58p2ERa/UmaGE9
 dT+T9YjAPFQBxWCYx82j2ptAAvcVRzD/5JI3HRWUDwsDwEFUErA46WYLtdbKXdQaELIQWL9EY
 YQxpR+0FTQnJ/0s3TYhX4vILWJ1Vk4ow7EWzoUh1WHthaQGsrUjYL4odLjBwjMdWvGvlS2zxw
 Tkd3+tDJB1XSFL+5MzBfceX5PwwIYXh6kYhuzQmsfC3AUHEPRrcjYrgl0sxkJyTGJQNLTGBwQ
 ouT+POhJiyRdYjLhAd+HKmIR1dTrXuqZGUxFhmMZHNLmvlG7VZoWuR1BjLgUtLJrwDgV7Eqpk
 972RdRVivVK2DFPgELjwJawlu428ecQdV88DcIESWYovvOrV3YPaSriD8igZ+6sCHl6dAiKES
 gwY6N8OGQBOWaQwZT0/s/DquuGj3aRkWdgZPPHEho9pC8teJzIXmJ3eSLT7mKsZwRGFeECGzh
 nhWRJ+sbAX+z3TZOY/IJacGpclLOSsIOZtMBK0uWBRBWvhnIuUBFTu3q8/rKnR9xfqi/Kf2I4
 s7m3uK2PDhZtQ8a/+JehI2fD4+XSngiiMgyI4Yd/XtLTpj1d29RZiP9JfJ7HK3dgt8VQ9scIR
 ghFD1r6E7RWqDGtWlifITbWlk91XxZdpo4VYcAuf6E2jcFdagnwbijhiAABSaze7onVf6C5WS
 Cit6bNE7dzEQrvgb4F7kBPlS1ayUaHnViAGyDUJ/dAHPUUPZq5O8x5xEqZ1wq9l2QNB0zf1u2
 /xMr3dYD0oN/ddlT2Aow==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/22 =E4=B8=8B=E5=8D=884:24, Qu Wenruo wrote:
>
>
> On 2021/1/22 =E4=B8=8B=E5=8D=884:04, Nikolay Borisov wrote:
>>
>>
>> On 22.01.21 =D0=B3. 8:00 =D1=87., Qu Wenruo wrote:
>>> Currently btrfs uses page Private2 bit to incidate if we have ordered
>>> extent for the page range.
>>>
>>> But the lifespan of it is not consistent, during regular writeback pat=
h,
>>> there are two locations to clear the same PagePrivate2:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 T ----- Page marked Dirty
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + ----- Page marked Private2, through btrfs_r=
un_dealloc_range()
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + ----- Page cleared Private2, through btrfs_=
writepage_cow_fixup()
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in __ex=
tent_writepage_io()
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^ Pri=
vate2 cleared for the first time
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + ----- Page marked Writeback, through btrfs_=
set_range_writeback()
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in __ex=
tent_writepage_io().
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + ----- Page cleared Private2, through
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_w=
ritepage_endio_finish_ordered()
>>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^ Pri=
vate2 cleared for the second time.>=C2=A0=C2=A0=C2=A0=C2=A0 |
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + ----- Page cleared Writeback, through
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 btrfs_writepage_endio_finish_ordered()
>>
>> Where exactly is page writeback cleared in btrfs_writepage_endio_finish
>> or=C2=A0 finish_ordered_fn?
>
> My bad. It's in finish_ordered_io().

Oh no, it's in end_bio_extent_writepage().

This means my original subpage plan to fix is not corrrect at all.
The Private2 is cleared before clearing page Writeback anyway...

The fix should be reworked now...
>
>>
>>>
>>> Currently PagePrivate2 is mostly to prevent ordered extent accounting
>>> being executed for both endio and invalidatepage.
>>> Thus only the one who cleared page Private2 is responsible for ordered
>>> extent accounting.
>>
>> SO this patch likely fixes the race and double accounting you've seen o=
n
>> the subpage branch,
>
> Nope, it's unrelated at all.
>
> The subpage problem is in the patch where I convert
> btrfs_writepage_endio_finish_ordered_io() to support subpage.
>
> In that patch I wrongly moved the timing of ClearPagePrivate2() after we
> queued the ordered extents.
>
> Thus there will no be specific patch for that fix, just update that
> patch to solve the problem.
>
>> however it's still not clear how the race occurs.
>
> There is no race in current code base.
>
> The invalidatepage() will wait writeback, thus it means there are the
> following possible combinations:
>
> - Page Writeback | Private2
>  =C2=A0 Then invalidatepage() will wait for Writeback, and during endio,
>  =C2=A0 Private2 will be cleared.
>
>  =C2=A0 Accounting is done in endio.
>
> - Page Writeback but NO Private2
>  =C2=A0 The same as previous cases
>
> - Page Private2 but NO Writeback
>  =C2=A0 Invalidatepage() will just clear Private2 and do the ordered ext=
ent
>  =C2=A0 accounting.
>
>  =C2=A0 Accounting is done in invalidagepage()
>
> - Page without Private2 nor Writeback
>  =C2=A0 Do nothing.
>
>
>
>> IIUC PagePrivate must ensure that invalidatepage and endio don't run
>> concurrently. To that effect invalidatepage indeed checks to see if it'=
s
>> the one which cleared pageprivate and if so it will run
>> btrfs_dec_test_ordered_pending and btrfs_finish_ordered_io. However, in
>> __extent_writepage_io btrfs_writepage_cow_fixup clears it
>> unconditionally and calls btrfs_writepage_endio_finish_ordered for hole
>> extents, right?
>>
>> But in this case invalidate invalidatepage can never have
>> cleared_private2 set to true. IMO the actual problem this could lead
>> warrants more explanation.
> Your understanding is correct and it matches the correct code and my
> understanding too.
>
> Thus this patch is really just to make the life span easier to read, no
> functional change at all.
>
> Thanks,
> Qu
>
>>
>>>
>>> But the fact is, in btrfs_writepage_endio_finish_ordered(), page
>>> Private2 is cleared and ordered extent accounting is executed
>>> unconditionally.
>>>
>>> The race prevention only happens through btrfs_invalidatepage(), where
>>> we wait the page writeback first, before checking the Private2 bit.
>>>
>>> This means, Private2 is also protected by Writeback bit, and there is =
no
>>> need for btrfs_writepage_cow_fixup() to clear Priavte2.
>>>
>>> This patch will change btrfs_writepage_cow_fixup() to just
>>> check PagePrivate2, not to clear it.
>>> The clear will happen either in btrfs_invalidatepage() or
>>> btrfs_writepage_endio_finish_ordered().
>>>
>>
>> <snip>
>>
