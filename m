Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC0D49F99B
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348575AbiA1Mil (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:38:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:34271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348584AbiA1Mij (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643373513;
        bh=lAVV61OC/JqiYO+FKS4NxHMv79S0KqzLU/rgVbLiMxE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=T7TgqN4wbZmAT3yJgchdNyqWWMohneSUqVNlizxx2nTtaYQ8dGbf3uBYpQmXqCxDA
         kDMrv1G74GiSJxbcuZsbhpOpBUnYc7+Vvd7hdfp7IYA5/kd6wb7vCMtvq+nE8HsW3G
         WNJIasmP8qRs+EutBO8xTk8A2P3qdXrxToi6GYE0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mf07E-1mbMgM2BQo-00gWzS; Fri, 28
 Jan 2022 13:38:33 +0100
Message-ID: <398c9f67-5b33-c107-cd38-500c102cd7a0@gmx.com>
Date:   Fri, 28 Jan 2022 20:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1643354254.git.wqu@suse.com>
 <YfPe6EeJ3Tr0p0zq@debian9.Home>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v4 0/3] btrfs: fixes for defrag_check_next_extent()
In-Reply-To: <YfPe6EeJ3Tr0p0zq@debian9.Home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2RqVhpBO3e9fRZ7ZmTCvtOopm/YPBRASqcq42O740dAoK2aVgRh
 i/PZOcVCxac2U8GaGiVNSJYcN07JTIj9rhZT/+iQV0LeYKgBhDgo3Pj/heDMIMYx8IbrP/H
 LXcSMrvJHxVUNdA7jMhAm28qRyNNm708g6ADvSPZdYDXf00ZLGLf5xdZ7lw8oxXSby+cAhh
 mGxLo0Cvow+W6mbJaVxZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ZGxlwbkOm4=:qdBvKJx4qNPu/uhOfmfsrh
 xs7QrMmxAdhzL+cGvyhHO5PAc8Hnkufr3FYsHNMkk+JLjAbbaJvSgLhiQqpksqIcDagrVBEkW
 UKC6ZQ2zjNWbMVC7bpKTzFAL0VWbtvjcD/YiqbV6uVd9GPVjNuVbFs08gFoOMAhEZpUSMb2Kc
 UhRorQhoeGJqA7PTc4ojLKSQTlbo2MQhjKvaz1BVrIUxvAT5hxY1Mm70EV7uzI3S0Xnsr7FCi
 HTPJY2BMl5TVIknS4FXhRHXxu4/g4jSy/OZcVBbbEkH0nQ9SeFl/XUWtqxgDRUIgg2EmgfnLJ
 DGMFiGDHalWmTkAnQZyLnndObSqzRMwqbciI38LBl4990UXcXMkxAPJb/Hy/uZWkCGIrIrZ8U
 Ct+AsNH9q6/bgcgdCriMMuVmtSnIJKUDxjB7a11VDivws5HjnWh8ItanVV2amzxsStUFOwpHh
 1P9GD+pjU9WRTu+ed7IkDyCwcjXr29JCkrUQZuY8ynz9UWaflDNy/kxI0sMspR6WHnMaGuRVy
 EBcYcdAUp5sh2ojjPIwdgJJidhz45TKgnVQzUwZaZNnmo4FokGR6Z5t9WxR0sGWMg6wiWpGY5
 H1XOXurHL6SDmGfpNopLa3botsotJruCQwR4Wk3WXmUHAOI20S+m4lEBX3uzKZAuBIxSVpGck
 wPJoy0KyTLgD7TTK+Jba9jYic+MYcEPOXO/7acEIaOlEtBHjSp5jNQuz/fJvC8n0+IyqXgG9k
 zQeZ+KlLc85GDwdr3QFNGGT6cApMq3h9Cbvf7FeJPvpqrUAt2yzbWwKa8vXonBJYBHI3WdFfJ
 +dkj5EQUgpCDyTTuxc5eyiD9PS5leDQX8/Z9oZreUKNkz6VP+gXeX6L1f4BBt8yFm2MQng2tF
 XQ9YdhJNpTJQPuPqHXZ60XdUYtxpEU7vrPsJAx2HaiXXglY5K9oBiDrOuncwIX5mxnAEL9kBN
 0gbiU+ycfN8NPJDZlgXyXKcvgKXvugghZIG7LIryhOQpn/t5IM5fZKf1WzJMbctN0//y5AqAw
 rdUAQCcuKkn9lXK3FdNFt9TtWpZeZvTkMoQLfs0521/DYxAPbqvT71m/R1RpvHBGh2009uINK
 33y7/h38cC0p+A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/28 20:17, Filipe Manana wrote:
> On Fri, Jan 28, 2022 at 03:21:19PM +0800, Qu Wenruo wrote:
>> That function is reused between older kernels (v5.15) and the refactore=
d
>> defrag code (v5.16+).
>>
>> However that function has one long existing bugs affecting defrag to
>> handle preallocated range.
>>
>> And it can not handle compressed extent well neither.
>>
>> Finally there is an ambiguous check which doesn't make much sense by
>> itself, and can be related by enhanced extent capacity check.
>>
>> This series will fix all the 3 problem mentioned above.
>>
>> Changelog:
>> v2:
>> - Use @extent_thresh from caller to replace the harded coded threshold
>>    Now caller has full control over the extent threshold value.
>>
>> - Remove the old ambiguous check based on physical address
>>    The original check is too specific, only reject extents which are
>>    physically adjacent, AND too large.
>>    Since we have correct size check now, and the physically adjacent ch=
eck
>>    is not always a win.
>>    So remove the old check completely.
>>
>> v3:
>> - Split the @extent_thresh and physicall adjacent check into other
>>    patches
>>
>> - Simplify the comment
>>
>> v4:
>> - Fix the @em usage which should be @next.
>>    As it will fail the submitted test case.
>>
>> Qu Wenruo (3):
>>    btrfs: defrag: don't try to merge regular extents with preallocated
>>      extents
>>    btrfs: defrag: don't defrag extents which is already at its max
>>      capacity
>>    btrfs: defrag: remove an ambiguous condition for rejection
>>
>>   fs/btrfs/ioctl.c | 35 ++++++++++++++++++++++++++++-------
>>   1 file changed, 28 insertions(+), 7 deletions(-)
>
> There's something screwed up in the series:
>
> $ b4 am cover.1643354254.git.wqu@suse.com
> Looking up https://lore.kernel.org/r/cover.1643354254.git.wqu%40suse.com
> Grabbing thread from lore.kernel.org/all/cover.1643354254.git.wqu%40suse=
.com/t.mbox.gz
> Analyzing 5 messages in the thread
> Checking attestation on all messages, may take a moment...
> ---
>    [PATCH v4 1/3] btrfs: defrag: don't try to merge regular extents with=
 preallocated extents
>      + Reviewed-by: Filipe Manana <fdmanana@suse.com>
>    [PATCH v4 2/3] btrfs: defrag: don't defrag extents which is already a=
t its max capacity
>    [PATCH v4 3/3] btrfs: defrag: remove an ambiguous condition for rejec=
tion
>    ---
>    NOTE: install dkimpy for DKIM signature verification
> ---
> Total patches: 3
> ---
> Cover: ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_extent.cover
>   Link: https://lore.kernel.org/r/cover.1643354254.git.wqu@suse.com
>   Base: not specified
>         git am ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_exten=
t.mbx
>
> $ git am ./v4_20220128_wqu_btrfs_fixes_for_defrag_check_next_extent.mbx
> Applying: btrfs: defrag: don't try to merge regular extents with preallo=
cated extents
> Applying: btrfs: defrag: don't defrag extents which is already at its ma=
x capacity
> error: patch failed: fs/btrfs/ioctl.c:1229
> error: fs/btrfs/ioctl.c: patch does not apply
> Patch failed at 0002 btrfs: defrag: don't defrag extents which is alread=
y at its max capacity
> hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Trying to manually pick patches 1 by 1 from patchwork, also results in t=
he
> same failure when applying patch 2/3.

My bad, I'm still using the old branch where I did all my test, it lacks
patches which are already in misc-next.

The missing patch of my base is "btrfs: fix deadlock when reserving
space during defrag", that makes the new lines in
defrag_collect_targets() to have some differences.

As in my base, it's

	if (em->len >=3D extent_thresh)

But now in misc-next, it's

	if (range_len >=3D extent_thresh)


This also makes me wonder, should we compare range_len to extent_thresh
or em->len?

One workaround users in v5.15 may use is to pass "-t 128k" for btrfs fi
defrag, so extents at 128K will not be defragged.

Won't the modified range_len check cause us to defrag extents which is
already 128K but the cluster boundary just ends inside the compressed
extent, and at the next cluster, we will choose to defrag part of the
extent.

Thanks,
Qu



>
> Not sure why it failed, but I was able to manually apply the diffs.
>
> Thanks.
>
>>
>> --
>> 2.34.1
>>
