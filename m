Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71AA35C539
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Apr 2021 13:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbhDLLdh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Apr 2021 07:33:37 -0400
Received: from mout.gmx.net ([212.227.15.19]:57503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237792AbhDLLdg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Apr 2021 07:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618227186;
        bh=6bj8UL/hYzU+twSAc4BS7HK329Ft2o/ZdgQnssZFC+Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=cfFwc+AbEGM7Aj+iDifX1lNhnPFpGrJ6dLuiWHsxavwcRjdfZjcPPnjnZ18GK+3e7
         EyLgLc3HU5Gg3JkOcPRWKEbMkb3wvVOEnAdk2MUVE5yKTTiTVnOylugU5iGreyvb0s
         kWmXn6CI/w99PfxCOL6bmNzsNvw8ERZZr2RLKN8Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8QS2-1lRX5l1Hqy-004S3j; Mon, 12
 Apr 2021 13:33:06 +0200
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Neal Gompa <ngompa13@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <20210325071445.90896-1-wqu@suse.com>
 <CAEg-Je_Bx6Yu6JHB0XXjBt0+0Ox_=kAUAVWWZan1DsiqvybYrQ@mail.gmail.com>
 <bc0306b6-da2c-b8c1-a88d-f19004331765@gmx.com>
 <20210328200246.xz23dz5iba2qet7v@riteshh-domain>
 <12dca606-1895-90e0-8b48-6f4ccf8a8a27@gmx.com>
 <20210402083323.u6o3laynn4qcxlq2@riteshh-domain>
 <f1acd25b-c0b6-31b4-f40b-32b44ba9ce4c@gmx.com>
 <20210402084652.b7a4mj2mntxu2xi5@riteshh-domain>
 <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
Date:   Mon, 12 Apr 2021 19:33:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9wZIBfA6x172UPL2OXxGodNF/AmerdkWzL8wnbjdX+D+ClVTS86
 uChExCqfvVC9n75lDMexUoodMwHRyQRPKatujQ7od5DY3tAOBQJqESUkAMPoY9VBCKlHqwQ
 tjENwv64wg+/jRfLidWislyfuWiecJ5x+Qayjke6XB50aZDgaJv3f6OnhQ1rW3ji+w1HVBI
 ZAbpX7SSesjsNYE+RGz4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LRHTWI3uaw8=:/mzON1sWpzY7Nl5VtDIcJz
 tjtKjBKPk0xNbHnb/gFBce/Lnu8+kaQrPn6DY4sqSNkJHTkyK0MrvltmnzcwWbiQhwXsyj0gL
 L4X+DaRtKbtH5GtA8ykGXso4olQ3fq1Fhp/bw4d8vXPvFyBnaSGAvuGAWfESAQ1pRNUz0fB1h
 Yg15ZP3R4AqtGG2lu78bLCt2tbzVSV9H2rEFJFnB0PB7axXbooU09SADMdeD0tOMe/2mDqUTL
 M7wpk3TtLebWbbXBbHskgwo78EB99O82MbXg8OFrFIamhpq/wjn/kqpDGLdsHtd6xg5t91Wic
 4kaJtWnmCluZR2mh7GrxHbmtEX/Dmz2Z3GDB6BeVWCeszSdZGOFXhOu3Tlx7Sciqm28VA1bka
 uElEC+A5HE0LOhHNgD12rE2qs0mCCYh6TkEyGt2poqTUogC4L2VWkJtvySFOsQEBNxEjgf3IB
 uGNlceaRIO54n7l8+34d/UjId99Gl8uASJCjwCUI2RTvWI7pjL+9nt7n+er9pyhvRoPdPHuDa
 PPI2xKzstNkCqz4QZ7YHPxtHBOmnr5tg/ZBF8BW+nf4/yIawGBSNZElfex7lUGhdK6elezgos
 qupLUFfHYcgtwxWStncZcCJNCpmEKZgASEon2taIpnU+f324Mg8L6gMMC3ZyEuXW6K8qR5kwk
 9s52MaPXLIqHXlQ6GvQrc4G+noaW1lo1KucjrQ2lpAGEFml+Xhn5PNzVtmdVxKd3O5txTYvHt
 tR/dhxEkKMYisMB2AGxodr+GXxndzUXLkheAd/PdnJuZr+73hsflKLX260td4vT53NYu2EXXl
 6FwlG3pdcHk9cPv410zFvgPDqs7X11MvooNHovE/J6FpDOpTafP+k52ThON66OuyNI91x/AOH
 mx3AlOmcd3MgHQt5ZLGEVVjj38oC5sChr2eQMcMo2D3S9zuM3scoK5cKzfsW8qvz9fh8dXm3f
 lpLBlft3SadHFoX+MKykyZzNi1PNBqqS/lgkZYji0epk3IAr8UKt0NcCcNy+PP+akxcADagmy
 EzmLBjRmaJ6cZE/yfPciiHWV+nRvxhUNhQyFQVFhSTRTC8GI+OhzwOrrsw3sdk4jApYhIBEmp
 lRveyRTUR0WlJ0fvUVIWasb5YfJhZdM72LVUXN8Qi2LN06Asa6bcLyfmSI6Z+8rAF8xU9TXqU
 7VgsnoApcOuox8pslmNCqwU9YvngfuWTUUUGBm4/Z3GENOd4ey3r7KnrC7f9riSE2kNlmdpzT
 CCtVBJF5zJj+mcAsS
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/2 =E4=B8=8B=E5=8D=884:52, Qu Wenruo wrote:
>
>
> On 2021/4/2 =E4=B8=8B=E5=8D=884:46, Ritesh Harjani wrote:
>> On 21/04/02 04:36PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/4/2 =E4=B8=8B=E5=8D=884:33, Ritesh Harjani wrote:
>>>> On 21/03/29 10:01AM, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/3/29 =E4=B8=8A=E5=8D=884:02, Ritesh Harjani wrote:
>>>>>> On 21/03/25 09:16PM, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2021/3/25 =E4=B8=8B=E5=8D=888:20, Neal Gompa wrote:
>>>>>>>> On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>>>>>>
>>>>>>>>> This patchset can be fetched from the following github repo,
>>>>>>>>> along with
>>>>>>>>> the full subpage RW support:
>>>>>>>>> https://github.com/adam900710/linux/tree/subpage
>>>>>>>>>
>>>>>>>>> This patchset is for metadata read write support.
>>>>>>>>>
>>>>>>>>> [FULL RW TEST]
>>>>>>>>> Since the data write path is not included in this patchset, we
>>>>>>>>> can't
>>>>>>>>> really test the patchset itself, but anyone can grab the patch
>>>>>>>>> from
>>>>>>>>> github repo and do fstests/generic tests.
>>>>>>>>>
>>>>>>>>> But at least the full RW patchset can pass -g generic/quick -x
>>>>>>>>> defrag
>>>>>>>>> for now.
>>>>>>>>>
>>>>>>>>> There are some known issues:
>>>>>>>>>
>>>>>>>>> - Defrag behavior change
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Since current defrag is doing per=
-page defrag, to support
>>>>>>>>> subpage
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defrag, we need some change in th=
e loop.
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E.g. if a page has both hole and =
regular extents in it,
>>>>>>>>> then defrag
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will rewrite the full 64K page.
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thus for now, defrag related fail=
ure is expected.
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 But this should only cause behavi=
or difference, no crash
>>>>>>>>> nor hang is
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expected.
>>>>>>>>>
>>>>>>>>> - No compression support yet
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 There are at least 2 known bugs i=
f forcing compression
>>>>>>>>> for subpage
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Some hard coded PAGE_SIZE screw=
ing up space rsv
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Subpage ASSERT() triggered
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is because some =
compression code is unlocking
>>>>>>>>> locked_page by
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calling extent_clear_=
unlock_delalloc() with locked_page
>>>>>>>>> =3D=3D NULL.
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 So for now compression is also di=
sabled.
>>>>>>>>>
>>>>>>>>> - Inode nbytes mismatch
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Still debugging.
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The fastest way to trigger is fsx=
 using the following
>>>>>>>>> parameters:
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fsx -l 262144 -o 6553=
6 -S 30073 -N 256 -R -W $mnt/file
>>>>>>>>> > /tmp/fsx
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Which would cause inode nbytes di=
ffers from expected
>>>>>>>>> value and
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 triggers btrfs check error.
>>>>>>>>>
>>>>>>>>> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
>>>>>>>>> The metadata part in fact has more new code than data part, as
>>>>>>>>> ithas
>>>>>>>>> some different behaviors compared to the regular sector size
>>>>>>>>> handling:
>>>>>>>>>
>>>>>>>>> - No more page locking
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Now metadata read/write relies on=
 extent io tree locking,
>>>>>>>>> other than
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page locking.
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is to allow behaviors like r=
ead lock one eb while
>>>>>>>>> alsotry to
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read lock another eb in the same =
page.
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 We can't rely on page lock as now=
 we have multiple extent
>>>>>>>>> buffers in
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the same page.
>>>>>>>>>
>>>>>>>>> - Page status update
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Now we use subpage wrappers to ha=
ndle page status update.
>>>>>>>>>
>>>>>>>>> - How to submit dirty extent buffers
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Instead of just grabbing extent b=
uffer from
>>>>>>>>> page::private, we need to
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iterate all dirty extent buffers =
in the page and submit
>>>>>>>>> them.
>>>>>>>>>
>>>>>>>>> [CHANGELOG]
>>>>>>>>> v2:
>>>>>>>>> - Rebased to latest misc-next
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No conflicts at all.
>>>>>>>>>
>>>>>>>>> - Add new sysfs interface to grab supported RO/RW sectorsize
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This will allow mkfs.btrfs to det=
ect unmountable fs better.
>>>>>>>>>
>>>>>>>>> - Use newer naming schema for each patch
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No more "extent_io:" or "inode:" =
schema anymore.
>>>>>>>>>
>>>>>>>>> - Move two pure cleanups to the series
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Patch 2~3, originally in RW part.
>>>>>>>>>
>>>>>>>>> - Fix one uninitialized variable
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Patch 6.
>>>>>>>>>
>>>>>>>>> v3:
>>>>>>>>> - Rename the sysfs to supported_sectorsizes
>>>>>>>>>
>>>>>>>>> - Rebased to latest misc-next branch
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This removes 2 cleanup patches.
>>>>>>>>>
>>>>>>>>> - Add new overview comment for subpage metadata
>>>>>>>>>
>>>>>>>>> Qu Wenruo (13):
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: add sysfs interface for su=
pported sectorsize
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: use min() to replace open-=
code in
>>>>>>>>> btrfs_invalidatepage()
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: remove unnecessary variabl=
e shadowing in
>>>>>>>>> btrfs_invalidatepage()
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: refactor how we iterate or=
dered extent in
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_invalidatepage(=
)
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: introduce helpers for subp=
age dirty status
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: introduce helpers for subp=
age writeback status
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: allow btree_set_page_dirty=
() to do more sanity
>>>>>>>>> checkon subpage
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 metadata
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: support subpage metadata c=
sum calculation at write
>>>>>>>>> time
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: make alloc_extent_buffer()=
 check subpage dirty bitmap
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: make the page uptodate ass=
ert to be subpage
>>>>>>>>> compatible
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: make set/clear_extent_buff=
er_dirty() to be subpage
>>>>>>>>> compatible
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: make set_btree_ioerr() acc=
ept extent buffer and to
>>>>>>>>> be subpage
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs: add subpage overview comme=
nts
>>>>>>>>>
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 fs/btrfs/disk-io.c=C2=A0=C2=A0 | 143
>>>>>>>>> ++++++++++++++++++++++++++++++++++---------
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 fs/btrfs/extent_io.c | 127
>>>>>>>>> ++++++++++++++++++++++++++++----------
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 fs/btrfs/inode.c=C2=A0=C2=A0=C2=A0=C2=
=A0 | 128
>>>>>>>>> ++++++++++++++++++++++----------------
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 fs/btrfs/subpage.c=C2=A0=C2=A0 | 127
>>>>>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 fs/btrfs/subpage.h=C2=A0=C2=A0 |=C2=A0 =
17 +++++
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 fs/btrfs/sysfs.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 15 +++++
>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 6 files changed, 441 insertions(+), 116=
 deletions(-)
>>>>>>>>>
>>>>>>>>> --
>>>>>>>>> 2.30.1
>>>>>>>>>
>>>>>>>>
>>>>>>>> Why wouldn't we just integrate full read-write support with the
>>>>>>>> caveats as described now? It seems to be relatively reasonable
>>>>>>>> to do
>>>>>>>> that, and this patch set is essentially unusable without the
>>>>>>>> rest of
>>>>>>>> it that does enable full read-write support.
>>>>>>>
>>>>>>> The metadata part is much more stable than data path (almost not
>>>>>>> touched
>>>>>>> for several months), and the metadata part already has some
>>>>>>> difference
>>>>>>> in its behavior, which needs review.
>>>>>>>
>>>>>>> You point makes some sense, but I still don't believe pushing a
>>>>>>> super
>>>>>>> large patchset does any help for the review.
>>>>>>>
>>>>>>> If you want to test, you can grab the branch from the github repo.
>>>>>>> If you want to review, the mails are all here for review.
>>>>>>>
>>>>>>> In fact, we used to have subpage support sent as a big patchset
>>>>>>> from IBM
>>>>>>> guys, but the result is only some preparation patches get merged,
>>>>>>> and
>>>>>>> nothing more.
>>>>>>>
>>>>>>> Using this multi-series method, we're already doing better work an=
d
>>>>>>> received more testing (to ensure regular sectorsize is not
>>>>>>> affectedat
>>>>>>> least).
>>>>>>
>>>>>> Hi Qu Wenruo,
>>>>>>
>>>>>> Sorry about chiming in late on this. I don't have any strong
>>>>>> objection on either
>>>>>> approach. Although sometime back when I tested your RW support git
>>>>>> tree on
>>>>>> Power, the unmount patch itself was crashing. I didn't debug it
>>>>>> thattime
>>>>>> (this was a month back or so), so I also didn't bother testing
>>>>>> xfstests on Power.
>>>>>>
>>>>>> But we do have an interest in making sure this patch series work
>>>>>> on bs < ps
>>>>>> on Power platform. I can try helping with testing, reviewing (to
>>>>>> best of my
>>>>>> knowledge) and fixing anything is possible :)
>>>>>
>>>>> That's great!
>>>>>
>>>>> One of my biggest problem here is, I don't have good enough testing
>>>>> environment.
>>>>>
>>>>> Although SUSE has internal clouds for ARM64/PPC64, but due to the
>>>>> f**king Great Firewall, it's super slow to access, no to mention doi=
ng
>>>>> proper debugging.
>>>>>
>>>>> Currently I'm using two ARM SBCs, RK3399 and A311D based, to do the
>>>>> test.
>>>>> But their computing power is far from ideal, only generic/quick can
>>>>> finish in hours.
>>>>>
>>>>> Thus real world Power could definitely help.
>>>>>>
>>>>>> Let me try and pull your tree and test it on Power. Please let me
>>>>>> know if there
>>>>>> is anything needs to be taken care apart from your github tree and
>>>>>> btrfs-progs
>>>>>> branch with bs < ps support.
>>>>>
>>>>> If you're going to test the branch, here are some small notes:
>>>>>
>>>>> - Need to use latest btrfs-progs
>>>>> =C2=A0=C2=A0=C2=A0 As it fixes a false alert on crossing 64K page bo=
undary.
>>>>>
>>>>> - Need to slightly modify btrfs-progs to avoid false alerts
>>>>> =C2=A0=C2=A0=C2=A0 For subpage case, mkfs.btrfs will output a warnin=
g, but that
>>>>> warning
>>>>> =C2=A0=C2=A0=C2=A0 is outputted into stderr, which will screw up gen=
eric test groups.
>>>>> =C2=A0=C2=A0=C2=A0 It's recommended to apply the following diff:
>>>>>
>>>>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>>>>> index 569208a9..21976554 100644
>>>>> --- a/common/fsfeatures.c
>>>>> +++ b/common/fsfeatures.c
>>>>> @@ -341,8 +341,8 @@ int btrfs_check_sectorsize(u32 sectorsize)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (page_size=
 !=3D sectorsize)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 warning(
>>>>> -"the filesystem may not be mountable, sectorsize %u doesn't match
>>>>> page
>>>>> size %u",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 printf(
>>>>> +"the filesystem may not be mountable, sectorsize %u doesn't match
>>>>> page
>>>>> size %u\n",
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 sectorsize, page_size);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>> =C2=A0=C2=A0 }
>>>>>
>>>>> - Xfstest/btrfs group will crash at btrfs/143
>>>>> =C2=A0=C2=A0=C2=A0 Still investigating, but you can ignore btrfs gro=
up for now.
>>>>>
>>>>> - Very rare hang
>>>>> =C2=A0=C2=A0=C2=A0 There is a very low change to hang, with "bad ord=
ered accounting"
>>>>> =C2=A0=C2=A0=C2=A0 dmesg.
>>>>> =C2=A0=C2=A0=C2=A0 If you can hit, please let me know.
>>>>> =C2=A0=C2=A0=C2=A0 I had something idea to fix it, but not yet in th=
e branch.
>>>>>
>>>>> - btrfs inode nbytes mismatch
>>>>> =C2=A0=C2=A0=C2=A0 Investigating, as it will make btrfs-check to rep=
ort error.
>>>>>
>>>>> The last two bugs are the final show blocker, I'll give you extra
>>>>> updates when those are fixed.
>>>>
>>>> Thanks Qu Wenruo, for above info.
>>>> I cloned below git tree as mentioned in your git log to test for RW
>>>> onPower.
>>>> However, I still see that RW mount for bs < ps is disabled for in
>>>> open_ctree()
>>>> https://github.com/adam900710/linux/tree/subpage
>>>>
>>>> I see below code present in this tree.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For 4=
K sector size support, it's only read-only */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (PAGE=
_SIZE =3D=3D SZ_64K && sectorsize =3D=3D SZ_4K) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sb_rdonly(sb) ||
>>>> btrfs_super_log_root(disk_super)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 btrfs_err(fs_info,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "subpage=
 sectorsize %u only supported read-only for page
>>>> size %lu",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sectorsize=
, PAGE_SIZE);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 err =3D -EINVAL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto fail_alloc;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> Could you pls point me to the tree I can use for bs < ps testing on
>>>> Power?
>>>> Sorry if I missed something.
>>>
>>> Sorry, I updated the branch to my current development progress, it's n=
ow
>>> at the ordered extent rework part, without the remaining subpage
>>> functionality at all.
>>>
>>> You may want to grab this tree instead:
>>> https://github.com/adam900710/linux/tree/subpage_old
>>>
>>> But please keep in mind that, you may get random hang, and certain
>>> generic test case, especially generic/075 can corrupt the inode nbytes
>>> and leaving all later test cases using TEST_DEV to report error on fsc=
k.
>>>
>>
>> Thanks for quick response. Sure, I will exclude generic/075 from the te=
st
>> for now.
>
> Not only generic/075, but all tests running fsx may cause inode nbytes
> corruption.
>
> Thus I'd recommend either modify btrfs-check to ignore it, or re-mkfs on
> TEST_DEV after each test case.

Good news, you can fetch the subpage branch for better test results.

Now the branch should pass all generic tests, except defrag and known
failures.
And no more random crash during the tests.

And for btrfs/143, it will no longer trigger a BUG_ON(), although at the
cost of worse granularity for repair.
(Now it's per-bvec repair, not yet fully per-sector repair).

I'll rebase the branch in recent days to latest misc-next, but the
current branch is already good enough for full subapge RW support.

Thanks,
Qu
>
> Thanks,
> Qu
>
>>
>> -ritesh
>>
