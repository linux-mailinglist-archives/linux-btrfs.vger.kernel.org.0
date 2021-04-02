Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1C63525AF
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 05:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhDBD0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 23:26:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:50003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233894AbhDBD0u (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Apr 2021 23:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617334004;
        bh=5/7wWpyFFqmXE44cP9ZJbA8wFnZX9EHkUAXtWw5GwXU=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=H8zvGHiDSaBczoI6h18DRtL7Dydbyi76JXItw7AB/nnmZ10Lo99awev8HBw+CbaWq
         5rF96vU6h+M8oOMlsVw8gm7XxIJvgqJqYx+T8n033bqUK1t+O+wt5sBHcN1mLUOkGG
         jhfRjD3vXV+K1qnOO/P7QFz2rNa0FzOej4A903dw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK4f-1ljyOA48eH-00rH5q; Fri, 02
 Apr 2021 05:26:44 +0200
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <20210325071445.90896-1-wqu@suse.com>
 <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
 <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
 <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
 <12dca606-1895-90e0-8b48-6f4ccf8a8a27@gmx.com>
 <663dec3c-96f8-3d46-561d-dcc2db7c47a7@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <ca2f40b5-4ca3-f7ee-032c-fb9b6c715908@gmx.com>
Date:   Fri, 2 Apr 2021 11:26:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <663dec3c-96f8-3d46-561d-dcc2db7c47a7@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BP/SWLwpXWY1siDSlUFwgpgSFuQrcBH5+L1Z3IVBNgryCXplh87
 xFSw88HooiQ2xu2aXPhXSO5VhmB7dBuF1cVemE1+pO93PozIExolCV/V7CKpBw4JqE8afjg
 Oau4ypUiqTfYOxC8fLsi2q6Txvz9m9esOqlem92gK3NhjL6DocvCp9cINsNo6Obk0+XIMvC
 3DXUHYwZGQX4SvDCCgnjw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GqyQsORhgZA=:2ThrjBHDnGj1gnl2mfwTH7
 gvq8mIHr6fINRD5OQECLuzFvaJZl3DFoat/XSyFv0yOIrdx/rxmtsfVU8G+sb251G8l1CYVIs
 AsBjmhtt4TdEV8cfYmlp6tcNjbTKB5/U4DYjngN0jezbp5fjuuix8ndBelg1VSXXYQPSeqTby
 KhJb/geC+WgTRMdZjUGdJhNoSUWUPCFwb6Q74qdZ4v5f13K+YMJxuus13F2ylN9+3GaO//1rE
 dksuw0ZTl61A7MeqAxjSj+EDvSATikCMMETDXqkxUBXGdmzS3uy1c5BrC0+PE/Zv0DeG/x0Fc
 LwKw00y4VaNRXHzKy3f/jZuVizdQ5SwXTcChtibZGlZZ8tK8z+UEKy+lbQ1YagVrUx2wFzMK5
 mz9NcqQ/Ah+XnIPTDxwP93oAnwg0AuHK2KeAj51ksn+c43mSkf4gUXtCqcMk3LgQ+UWA+w5/a
 UyagcFDW0whiOSZ6VSljpOJyD2hh2LpgEmyJzkDWeipRcA4dB5zEYk1I+CWRQtL+BVnZenJVN
 BQg3FZeBIwqX69u6oYASX6geOQrBMUh4s94SBnRNuKD2nv3PkFHBYyeN3rgHPsty2Q6OJIJX4
 XFJcWrJzBcSmoT9T5BtSXWp7AxUABNTRQBBQb514D2y+y1pH+719Yrr2BzxaJfK6xQfwl0RXK
 a8U66UPdpaueRXua4IH3/5prOyTRtY3WxgmqoXl1vFWmNalYRq/p9usGw3cZGQH1C43qhVxX4
 P2qLne8jzYM2RkKt9Qft00FpVW3YkkvelThC6sszDuKgUZmVMm1D3JJeH26/mpRg/M6pnTrqb
 vECfkJrRfoRKfJwtL9Mxab3n99s4csvHGi94M7WyotcJGovXoiKV2dOLV09uVNU6asNezTyyC
 kQGar/Fyx3tqF/Zx4loBtjKknUkAtF7IgwNKAWgJvVHwnzYI5stWg5+UGV61myr+cqxjh5RmM
 Ga6jboJ7i5xFNzZLb2d8whfSl7uUrl1zYHnGI0gvX0DVR/nb+O7dL2NbArGLQ4TDX/62L6NVU
 6WTUAXiK0WZL6YCl2B9JyqymRjNpzxNGdB0JklcDCSWGVkFcItiDCVaF24LodcB5UgDb6oWRO
 0qGNyH5Md0E/U0xmqX0fBt7XdsJ0gEalCZKetMeokZQ35Q+yoLjZDZoudc71EpGa8AtRu2cUJ
 fx4rg166mwgCbPUL32ZoMXKpgSv76e3NkV2siT89PUbI1FSa9Dw9GGa8LctELam6/ybXD7Mfv
 QX0mZXyOo4ejK8CZV
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/2 =E4=B8=8A=E5=8D=889:39, Anand Jain wrote:
> On 29/03/2021 10:01, Qu Wenruo wrote:
>>
>>
>> On 2021/3/29 =E4=B8=8A=E5=8D=884:02, Ritesh Harjani wrote:
>>> On 21/03/25 09:16PM, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/3/25 =E4=B8=8B=E5=8D=888:20, Neal Gompa wrote:
>>>>> On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>>>
>>>>>> This patchset can be fetched from the following github repo, along
>>>>>> with
>>>>>> the full subpage RW support:
>>>>>> https://github.com/adam900710/linux/tree/subpage
>>>>>>
>>>>>> This patchset is for metadata read write support.
>>>>>>
>>>>>> [FULL RW TEST]
>>>>>> Since the data write path is not included in this patchset, we can'=
t
>>>>>> really test the patchset itself, but anyone can grab the patch from
>>>>>> github repo and do fstests/generic tests.
>>>>>>
>>>>>> But at least the full RW patchset can pass -g generic/quick -x defr=
ag
>>>>>> for now.
>>>>>>
>>>>>> There are some known issues:
>>>>>>
>>>>>> - Defrag behavior change
>>>>>> =C2=A0=C2=A0=C2=A0 Since current defrag is doing per-page defrag, t=
o support subpage
>>>>>> =C2=A0=C2=A0=C2=A0 defrag, we need some change in the loop.
>>>>>> =C2=A0=C2=A0=C2=A0 E.g. if a page has both hole and regular extents=
 in it, then
>>>>>> defrag
>>>>>> =C2=A0=C2=A0=C2=A0 will rewrite the full 64K page.
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0 Thus for now, defrag related failure is expected=
.
>>>>>> =C2=A0=C2=A0=C2=A0 But this should only cause behavior difference, =
no crash nor
>>>>>> hangis
>>>>>> =C2=A0=C2=A0=C2=A0 expected.
>>>>>>
>>>>>> - No compression support yet
>>>>>> =C2=A0=C2=A0=C2=A0 There are at least 2 known bugs if forcing compr=
ession for
>>>>>> subpage
>>>>>> =C2=A0=C2=A0=C2=A0 * Some hard coded PAGE_SIZE screwing up space rs=
v
>>>>>> =C2=A0=C2=A0=C2=A0 * Subpage ASSERT() triggered
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is because some compression cod=
e is unlocking
>>>>>> locked_page by
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calling extent_clear_unlock_delalloc=
() with locked_page =3D=3D
>>>>>> NULL.
>>>>>> =C2=A0=C2=A0=C2=A0 So for now compression is also disabled.
>>>>>>
>>>>>> - Inode nbytes mismatch
>>>>>> =C2=A0=C2=A0=C2=A0 Still debugging.
>>>>>> =C2=A0=C2=A0=C2=A0 The fastest way to trigger is fsx using the foll=
owing parameters:
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsx -l 262144 -o 65536 -S 30073 -N 2=
56 -R -W $mnt/file >
>>>>>> /tmp/fsx
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0 Which would cause inode nbytes differs from expe=
cted value and
>>>>>> =C2=A0=C2=A0=C2=A0 triggers btrfs check error.
>>>>>>
>>>>>> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
>>>>>> The metadata part in fact has more new code than data part, as it h=
as
>>>>>> some different behaviors compared to the regular sector size
>>>>>> handling:
>>>>>>
>>>>>> - No more page locking
>>>>>> =C2=A0=C2=A0=C2=A0 Now metadata read/write relies on extent io tree=
 locking,
>>>>>> other than
>>>>>> =C2=A0=C2=A0=C2=A0 page locking.
>>>>>> =C2=A0=C2=A0=C2=A0 This is to allow behaviors like read lock one eb=
 while also
>>>>>> try to
>>>>>> =C2=A0=C2=A0=C2=A0 read lock another eb in the same page.
>>>>>> =C2=A0=C2=A0=C2=A0 We can't rely on page lock as now we have multip=
le extent
>>>>>> buffersin
>>>>>> =C2=A0=C2=A0=C2=A0 the same page.
>>>>>>
>>>>>> - Page status update
>>>>>> =C2=A0=C2=A0=C2=A0 Now we use subpage wrappers to handle page statu=
s update.
>>>>>>
>>>>>> - How to submit dirty extent buffers
>>>>>> =C2=A0=C2=A0=C2=A0 Instead of just grabbing extent buffer from page=
::private, we
>>>>>> need to
>>>>>> =C2=A0=C2=A0=C2=A0 iterate all dirty extent buffers in the page and=
 submit them.
>>>>>>
>>>>>> [CHANGELOG]
>>>>>> v2:
>>>>>> - Rebased to latest misc-next
>>>>>> =C2=A0=C2=A0=C2=A0 No conflicts at all.
>>>>>>
>>>>>> - Add new sysfs interface to grab supported RO/RW sectorsize
>>>>>> =C2=A0=C2=A0=C2=A0 This will allow mkfs.btrfs to detect unmountable=
 fs better.
>>>>>>
>>>>>> - Use newer naming schema for each patch
>>>>>> =C2=A0=C2=A0=C2=A0 No more "extent_io:" or "inode:" schema anymore.
>>>>>>
>>>>>> - Move two pure cleanups to the series
>>>>>> =C2=A0=C2=A0=C2=A0 Patch 2~3, originally in RW part.
>>>>>>
>>>>>> - Fix one uninitialized variable
>>>>>> =C2=A0=C2=A0=C2=A0 Patch 6.
>>>>>>
>>>>>> v3:
>>>>>> - Rename the sysfs to supported_sectorsizes
>>>>>>
>>>>>> - Rebased to latest misc-next branch
>>>>>> =C2=A0=C2=A0=C2=A0 This removes 2 cleanup patches.
>>>>>>
>>>>>> - Add new overview comment for subpage metadata
>>>>>>
>>>>>> Qu Wenruo (13):
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: add sysfs interface for supported sectors=
ize
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: use min() to replace open-code in btrfs_i=
nvalidatepage()
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: remove unnecessary variable shadowing in
>>>>>> btrfs_invalidatepage()
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: refactor how we iterate ordered extent in
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_invalidatepage()
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: introduce helpers for subpage dirty statu=
s
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: introduce helpers for subpage writeback s=
tatus
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: allow btree_set_page_dirty() to do more s=
anity check on
>>>>>> subpage
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 metadata
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: support subpage metadata csum calculation=
 at write time
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: make alloc_extent_buffer() check subpage =
dirty bitmap
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: make the page uptodate assert to be subpa=
ge compatible
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: make set/clear_extent_buffer_dirty() to b=
e subpage
>>>>>> compatible
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: make set_btree_ioerr() accept extent buff=
er and to be
>>>>>> subpage
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible
>>>>>> =C2=A0=C2=A0=C2=A0 btrfs: add subpage overview comments
>>>>>>
>>>>>> =C2=A0=C2=A0 fs/btrfs/disk-io.c=C2=A0=C2=A0 | 143
>>>>>> ++++++++++++++++++++++++++++++++++---------
>>>>>> =C2=A0=C2=A0 fs/btrfs/extent_io.c | 127 +++++++++++++++++++++++++++=
+----------
>>>>>> =C2=A0=C2=A0 fs/btrfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0 | 128 +++++++=
+++++++++++++++----------------
>>>>>> =C2=A0=C2=A0 fs/btrfs/subpage.c=C2=A0=C2=A0 | 127 +++++++++++++++++=
+++++++++++++++++++++
>>>>>> =C2=A0=C2=A0 fs/btrfs/subpage.h=C2=A0=C2=A0 |=C2=A0 17 +++++
>>>>>> =C2=A0=C2=A0 fs/btrfs/sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 ++=
+++
>>>>>> =C2=A0=C2=A0 6 files changed, 441 insertions(+), 116 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.30.1
>>>>>>
>>>>>
>>>>> Why wouldn't we just integrate full read-write support with the
>>>>> caveats as described now? It seems to be relatively reasonable to do
>>>>> that, and this patch set is essentially unusable without the rest of
>>>>> it that does enable full read-write support.
>>>>
>>>> The metadata part is much more stable than data path (almost not
>>>> touched
>>>> for several months), and the metadata part already has some differenc=
e
>>>> in its behavior, which needs review.
>>>>
>>>> You point makes some sense, but I still don't believe pushing a super
>>>> large patchset does any help for the review.
>>>>
>>>> If you want to test, you can grab the branch from the github repo.
>>>> If you want to review, the mails are all here for review.
>>>>
>>>> In fact, we used to have subpage support sent as a big patchset from
>>>> IBM
>>>> guys, but the result is only some preparation patches get merged, and
>>>> nothing more.
>>>>
>>>> Using this multi-series method, we're already doing better work and
>>>> received more testing (to ensure regular sectorsize is not affected a=
t
>>>> least).
>>>
>>> Hi Qu Wenruo,
>>>
>>> Sorry about chiming in late on this. I don't have any strong
>>> objection on either
>>> approach. Although sometime back when I tested your RW support git
>>> tree on
>>> Power, the unmount patch itself was crashing. I didn't debug it that
>>> time
>>> (this was a month back or so), so I also didn't bother testing
>>> xfstests on Power.
>>>
>>> But we do have an interest in making sure this patch series work on
>>> bs <ps
>>> on Power platform. I can try helping with testing, reviewing (to best
>>> ofmy
>>> knowledge) and fixing anything is possible :)
>>
>> That's great!
>>
>> One of my biggest problem here is, I don't have good enough testing
>> environment.
>>
>> Although SUSE has internal clouds for ARM64/PPC64, but due to the
>> f**king Great Firewall, it's super slow to access, no to mention doing
>> proper debugging.
>>
>> Currently I'm using two ARM SBCs, RK3399 and A311D based, to do the tes=
t.
>> But their computing power is far from ideal, only generic/quick can
>> finish in hours.
>>
>> Thus real world Power could definitely help.
>>>
>>> Let me try and pull your tree and test it on Power. Please let me
>>> know if there
>>> is anything needs to be taken care apart from your github tree and
>>> btrfs-progs
>>> branch with bs < ps support.
>>
>> If you're going to test the branch, here are some small notes:
>>
>> - Need to use latest btrfs-progs
>> =C2=A0=C2=A0As it fixes a false alert on crossing 64K page boundary.
>>
>> - Need to slightly modify btrfs-progs to avoid false alerts
>> =C2=A0=C2=A0For subpage case, mkfs.btrfs will output a warning, but tha=
t warning
>> =C2=A0=C2=A0is outputted into stderr, which will screw up generic test =
groups.
>> =C2=A0=C2=A0It's recommended to apply the following diff:
>>
>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>> index 569208a9..21976554 100644
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -341,8 +341,8 @@ int btrfs_check_sectorsize(u32 sectorsize)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (page_size !=3D sectorsiz=
e)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 warning(
>> -"the filesystem may not be mountable, sectorsize %u doesn't match page
>> size %u",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 printf(
>> +"the filesystem may not be mountable, sectorsize %u doesn't match page
>> size %u\n",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sect=
orsize, page_size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> }
>>
>
>
>> - Xfstest/btrfs group will crash at btrfs/143
>> =C2=A0=C2=A0Still investigating, but you can ignore btrfs group for now=
.
>>
>> - Very rare hang
>> =C2=A0=C2=A0There is a very low change to hang, with "bad ordered accou=
nting"
>> =C2=A0=C2=A0dmesg.
>> =C2=A0=C2=A0If you can hit, please let me know.
>> =C2=A0=C2=A0I had something idea to fix it, but not yet in the branch.
>>
>> - btrfs inode nbytes mismatch
>> =C2=A0=C2=A0Investigating, as it will make btrfs-check to report error.
>>
>> The last two bugs are the final show blocker, I'll give you extra
>> updates when those are fixed.
>
>  =C2=A0I am running the tests on aarch64 here. Are fixes for these known
>  =C2=A0issues posted in the ML? I can't see them yet.

Not yet, even in my subpage branch.

The problem here is completely in btrfs_invalidatepate() race against
writepage endio.

The current problem is we're using page Private2 bit to indicate if
there is any pending ordered io to be finished.

But for subpage case, just single bit in page Private2 is no longer
sufficient.

The following case can happen:

	T1			|		T2
=2D-------------------------------+---------------------------
Page [0, 16K) dirtied		|
Page [0, 16K) delalloc start	|
|- New ordered extent created	|
|- With PagePrivate2 set	|
				|
[0, 16K) write page endio	|
|- Clear PagePrivate2		|
|- OE [0, 16K) IO_DONE		|
|- Queue finish_ordered_io()	|
    But OE [0, 16K) still in tree|
				|
Page [16K, 32K) dirtied		|
Page [0, 16K) delalloc start	|
|- New ordered extent created	|
|- With PagePrivate2 set	|
				| invalidatepage on [0, 64K)
				| |- TestClearPagePrivate2
				| |- Dec OE on range [0, 16k)
				| |  |- Underflow OE [0, 16K) <<<
				| |- Dec OE on range [16K, 32K)
				|    |- This is proper dec

In above case, in invalidatepage(), Ordered Extent [0, 16K) should not
get decreased, as its endio has finished.

Normally we rely on PagePrivate2 to prevent such problem, but for
current subpage case it doesn't have bitmap for it, and causes the problem=
.

The invalidatepage() part is also responsible for the inode nbytes mismatc=
h.

IMHO, the btrfs_dec_test_.*ordered_pending() API is pure garbage.
It require callers to handle the Private2 bit and do the loop, but it
should be completely integrated into ordered extent code, not exposing
those details for callers.

I'm currently reworking the involved APIs,
btrfs_dec_test_first_ordered_pending() has been converted to subpage
friendly one and passes tests for 4K page systems.

But the btrfs_dec_test_ordered_pending() in btrfs_invalidatepage() is a
much harder hassle to handle.
Will keep working on the problem in recent days to completely solve it,
then rebase all the subpage code on the refactor ordered extent code.

Thanks,
Qu
>
> Thanks, Anand
>
>
>> Thanks,
>> Qu
>>
>>>
>>> -ritesh
>>>
>>>
>
