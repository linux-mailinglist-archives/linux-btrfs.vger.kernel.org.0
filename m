Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8116B3068A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jan 2021 01:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhA1AcC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 19:32:02 -0500
Received: from mout.gmx.net ([212.227.17.20]:50511 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhA1AcA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 19:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611793825;
        bh=YOaI6Mb8lV4KYNhUVIRax19hcqxS2evKHl/eZHPUNJg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=J5OKFMYLbJUwPHKYoZvLpk4EB7Kq3TmgwpR633K6l3R3VWez58XTiWYbcSuiYLds8
         iy8Xz242orRBbEFQtCcjyXs2VSk/XtAt+Em0wl64l6m8Nu1Jwkk2bYOYWxUp4TPosw
         jDXZOiHKcus2kt3OhNVV5oZPEu7tBpxPAPagg1Hs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4b1y-1l5TAU2Iv0-001hsh; Thu, 28
 Jan 2021 01:30:25 +0100
Subject: Re: [PATCH v5 00/18] btrfs: add read-only support for subpage sector
 size
To:     Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210126083402.142577-1-wqu@suse.com>
 <a448ea77-957b-b7fc-c05a-29a4a13352b8@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <e370c8d6-8559-c8a0-9938-160e003e933b@gmx.com>
Date:   Thu, 28 Jan 2021 08:30:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <a448ea77-957b-b7fc-c05a-29a4a13352b8@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hdlTzUEM6O+oYnTwvfMETl+oV+Tm2Iv8ZCgerFpIs1+g8KqiEW6
 il/sTPElBBCirb4/lr/CSqozpqqo+w1+UJnLMxvW0PaF4ddOPo+nMRdTRpxfGcBjPI5slwR
 /bQFloSXYYKPBxuBkxFLSzB0i3ucJ2HgCAku6rk0eKF50oTYQwrC3nGConbgEbduJOb5IMk
 WlcceUIT9TEylMwEJlilA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DXYOAvNe/FE=:0eoMYHnyVIorYMDG5OgiTA
 fIj0Mt/S+Hsv2eacE/OensBvyBIbuBePU8nLhNtBGV7TQwu0GChtsskXTDj7WwVTwgravFIJM
 6hE/aetZtfmPKOF9/sA+aVKPbQrZfctCbbo/RqVSZiLjyVKESbSuQkto6jnBKL9KqhO2Sye3o
 Rybb1oEsOU18CWk1IiFrtatAk3y3aNcpMxDfUantvmcsxB/l71kW0UouBawIe1cr0gt/wL/f5
 RZDNYJujjE5c75xYa9FFpWAFn4NFjfiFDnSN3tz58845xRuqOEiLLNe1Jj5TFsd/COnXQ7x5o
 j3e+E9TdaXisQaBukVaT7tEhXijAu6BMiz/RcApi6PKjb63bSsXFcBD4lp73hO7TONJ13gc2J
 5w+pNTK2k7XObDb6fWGCu4sa5I6teN88iHeAnAm52U4EWiXwAe8JZQVqS9y7kfSeD4I0Qd037
 AI8n/0sf/8roXxqCnowmrop/TCMVnCitT/OObGyJrR9ovLKGCUUrJK5nQGb5mXWpkfrmD1Lej
 TpO98oG/yoGlKw2DJj3RhUhAs7n9YppFk/MJngUCuTTZhmmKduDcpjBX3vHHd56tgsBlxuKTQ
 3O9AYjYNGH9Tb/QqmRlTxk/Y0Nk72rybvz2PvUspY5FSLiJil8NlRWB/gJGic4Vs+xgZxPIzO
 TVo71rCqjkmVkJllR7hsmjXJwlT8HO3q7ts/P0Jetf8wbFSaFj/eQBa3kBTW8tjSwB3SFu6VJ
 WwFEkW5ma2YZTWHzuu8mKa3po1yB8HiNZIsXocbXFRqqy/mrVZADeD9YAfa/uEpUqPs37C/Yu
 87zw6F7r+Bc3BxOiQRSrA91u7Ffb4K7hNWy/RREQsuk2j7e4z15jco97Cvup+/K+PDr2R76GO
 XhRCZ87AHeJMChiy4sCg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/28 =E4=B8=8A=E5=8D=8812:17, Josef Bacik wrote:
> On 1/26/21 3:33 AM, Qu Wenruo wrote:
>> Patches can be fetched from github:
>> https://github.com/adam900710/linux/tree/subpage
>> Currently the branch also contains partial RW data support (still some
>> ordered extent and data csum mismatch problems)
>>
>> Great thanks to David/Nikolay/Josef for their effort reviewing and
>> merging the preparation patches into misc-next.
>>
>> =3D=3D=3D What works =3D=3D=3D
>> Just from the patchset:
>> - Data read
>> =C2=A0=C2=A0 Both regular and compressed data, with csum check.
>>
>> - Metadata read
>>
>> This means, with these patchset, 64K page systems can at least mount
>> btrfs with 4K sector size read-only.
>> This should provide the ability to migrate data at least.
>>
>> While on the github branch, there are already experimental RW supports,
>> there are still ordered extent related bugs for me to fix.
>> Thus only the RO part is sent for review and testing.
>>
>> =3D=3D=3D Patchset structure =3D=3D=3D
>> Patch 01~02:=C2=A0=C2=A0=C2=A0 Preparation patches which don't have fun=
ctional change
>> Patch 03~12:=C2=A0=C2=A0=C2=A0 Subpage metadata allocation and freeing
>> Patch 13~15:=C2=A0=C2=A0=C2=A0 Subpage metadata read path
>> Patch 16~17:=C2=A0=C2=A0=C2=A0 Subpage data read path
>> Patch 18:=C2=A0=C2=A0=C2=A0 Enable subpage RO support
>>
>> =3D=3D=3D Changelog =3D=3D=3D
>> v1:
>> - Separate the main implementation from previous huge patchset
>> =C2=A0=C2=A0 Huge patchset doesn't make much sense.
>>
>> - Use bitmap implementation
>> =C2=A0=C2=A0 Now page::private will be a pointer to btrfs_subpage struc=
ture, which
>> =C2=A0=C2=A0 contains bitmaps for various page status.
>>
>> v2:
>> - Use page::private as btrfs_subpage for extra info
>> =C2=A0=C2=A0 This replace old extent io tree based solution, which redu=
ces latency
>> =C2=A0=C2=A0 and don't require memory allocation for its operations.
>>
>> - Cherry-pick new preparation patches from RW development
>> =C2=A0=C2=A0 Those new preparation patches improves the readability by =
their own.
>>
>> v3:
>> - Make dummy extent buffer to follow the same subpage accessors
>> =C2=A0=C2=A0 Fsstress exposed several ASSERT() for dummy extent buffers=
.
>> =C2=A0=C2=A0 It turns out we need to make dummy extent buffer to own th=
e same
>> =C2=A0=C2=A0 btrfs_subpage structure to make eb accessors to work prope=
rly
>>
>> - Two new small __process_pages_contig() related preparation patches
>> =C2=A0=C2=A0 One to make __process_pages_contig() to enhance the error =
handling
>> =C2=A0=C2=A0 path for locked_page, one to merge one macro.
>>
>> - Extent buffers refs count update
>> =C2=A0=C2=A0 Except try_release_extent_buffer(), all other eb uses will=
 try to
>> =C2=A0=C2=A0 increase the ref count of the eb.
>> =C2=A0=C2=A0 For try_release_extent_buffer(), the eb refs check will ha=
ppen inside
>> =C2=A0=C2=A0 the rcu critical section to avoid eb being freed.
>>
>> - Comment updates
>> =C2=A0=C2=A0 Addressing the comments from the mail list.
>>
>> v4:
>> - Get rid of btrfs_subpage::tree_block_bitmap
>> =C2=A0=C2=A0 This is to reduce lock complexity (no need to bother extra=
 subpage
>> =C2=A0=C2=A0 lock for metadata, all locks are existing locks)
>> =C2=A0=C2=A0 Now eb looking up mostly depends on radix tree, with small=
 help from
>> =C2=A0=C2=A0 btrfs_subpage::under_alloc.
>> =C2=A0=C2=A0 Now I haven't experieneced metadata related problems any m=
ore during
>> =C2=A0=C2=A0 my local fsstress tests.
>>
>> - Fix a race where metadata page dirty bit can race
>> =C2=A0=C2=A0 Fixed in the metadata RW patchset though.
>>
>> - Rebased to latest misc-next branch
>> =C2=A0=C2=A0 With 4 patches removed, as they are already in misc-next.
>>
>> v5:
>> - Use the updated version from David as base
>> =C2=A0=C2=A0 Most comment/commit message update should be kept as is.
>>
>> - A new separate patch to move UNMAPPED bit set timing
>>
>> - New comment on why we need to prealloc subpage inside a loop
>> =C2=A0=C2=A0 Mostly for further 16K page size support, where we can hav=
e
>> =C2=A0=C2=A0 eb across multiple pages.
>>
>> - Remove one patch which is too RW specific
>> =C2=A0=C2=A0 Since it introduces functional change which only makes sen=
se for RW
>> =C2=A0=C2=A0 support, it's not a good idea to include it in RO support.
>>
>> - Error handling fixes
>> =C2=A0=C2=A0 Great thanks to Josef.
>>
>> - Refactor btrfs_subpage allocation/freeing
>> =C2=A0=C2=A0 Now we have btrfs_alloc_subpage() and btrfs_free_subpage()=
 helpers to
>> =C2=A0=C2=A0 do all the allocation/freeing.
>> =C2=A0=C2=A0 It's pretty easy to convert to kmem_cache using above help=
ers.
>> =C2=A0=C2=A0 (already internally tested using kmem_cache without proble=
m, in fact
>> =C2=A0=C2=A0=C2=A0 it's all the problems found in kmem_cache test leads=
 to the new
>> =C2=A0=C2=A0=C2=A0 interface)
>>
>> - Use btrfs_subpage::eb_refs to replace old under_alloc
>> =C2=A0=C2=A0 This makes checking whether the page has any eb left much =
easier.
>>
>> Qu Wenruo (18):
>> =C2=A0=C2=A0 btrfs: merge PAGE_CLEAR_DIRTY and PAGE_SET_WRITEBACK to
>> =C2=A0=C2=A0=C2=A0=C2=A0 PAGE_START_WRITEBACK
>> =C2=A0=C2=A0 btrfs: set UNMAPPED bit early in btrfs_clone_extent_buffer=
() for
>> =C2=A0=C2=A0=C2=A0=C2=A0 subpage support
>> =C2=A0=C2=A0 btrfs: introduce the skeleton of btrfs_subpage structure
>> =C2=A0=C2=A0 btrfs: make attach_extent_buffer_page() handle subpage cas=
e
>> =C2=A0=C2=A0 btrfs: make grab_extent_buffer_from_page() handle subpage =
case
>> =C2=A0=C2=A0 btrfs: support subpage for extent buffer page release
>
> I don't have this patch in my inbox so I can't reply to it directly, but
> you include refcount.h, but then use normal atomics.=C2=A0 Please used t=
he
> actual refcount_t, as it gets us all the debugging stuff that makes
> finding problems much easier.=C2=A0 Thanks,

My bad, my initial plan is to use refcount, but the use case has valid 0
refcount usage, thus refcount is not good here.

I'll remove the remaining including line.

Thanks,
Qu
>
> Josef
