Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE08B35277A
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 10:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhDBIgP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Apr 2021 04:36:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:44971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhDBIgP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Apr 2021 04:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617352572;
        bh=ZvbFGY5RKLIetiXFkZrzdCt59Ol65Plq8AncByeYHKk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Mofnc4Vqy0rxjandDG9hvUqIcno3MYvcgVmbqDNM+dMDqeFmfv34FsuBraUWinmLd
         Tz/iCfTzuko/kaphCHdPvwrnq2Y+2KUEzTdXgCGDNRkIN2Lmm3HdY0alHoU5Wsebw5
         UH+vxu7Vedv+9Qhjn29E3qF84XHoHKfCrHcx0fuU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49hB-1lb9Ba11G5-0104OH; Fri, 02
 Apr 2021 10:36:11 +0200
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <f1acd25b-c0b6-31b4-f40b-32b44ba9ce4c@gmx.com>
Date:   Fri, 2 Apr 2021 16:36:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210402083323.u6o3laynn4qcxlq2@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JBaVtpcbWjjrcEjXlUuc8H3fvXJreXkrSiN7MAFzAHoEPo9fKsJ
 RTXg+35F8j1VOWcGqy02nCDsIEeYHe/BVRJKOH1TGjHLXPUtpDBrzQ6V/GLqbggPMrsteoh
 bT8JGQR8jAaSuTWs8QFT4+5i+tEFj/jsqrbfgBywvDkh799lOUgXNWXhGaRbl4A46MUtLtf
 ab2LIMk0/HdioaGQIBQmA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d2FN/gdO9w8=:/CuLGS5m1LmquIjZjkH5gw
 nKVgaj3CRk5JhlynvZquUXERorVZRj/HDTEg4VMStoS9TdkdPfLtdrVgSR0nFzBYok4rDyQ/O
 V0wjWCjLgL/HSnH4yLXnbafqXJxTwG99/cIHbs+e2xf/CUMT7LhahBfaX/VIzpQ5MGb12thsY
 A4Y02xdAQJGPY5XLDRRECwUDVHkNKTMl3fvtVJD/PsmFf8XyRVF2eFGWZ6qXAoDWZB6xRv9pz
 SUrnz+bmtmz81piqciRtgg0jvtS5+qAu267noKmlNIM8RLYU4POz3LJ/9KQ23qKsrgMyC+2aJ
 EESj4Ac6Cm2gyZdeCK3pbkArE9GDlEa1jHak+sSmQ/oB18xijLY12hWybPm/Yeqi8Peqf6c8D
 ueuwfZ0FUZp/mCnm/FDFYqiSUMUXn4KscqBz28NGKklp/t+nrKcji9FCJAKrCkuW1PieHhe1l
 BCkO9v2nTrYQe15/plE6Cu0kt4W2H//Tc6DOyPuvgaIjhg7zRxQWnjxUrZrzSXhYc0s0KIbnH
 peU2NiqwkZ2c2DQVgVHZUPHlFpZjkEuHzLSl/WFPytJUlvGKwnsTM4QPVoZoLs5H2bdjUheTh
 5rMozkVWpi5I/TtmpGHScEZHrB8hNPTtYeseSjdOUQtXBcGIi9RlXAM4zewuDOAetJNY5VcjL
 JqQEriT5SasW1uBAILJzbE3KAjZy86Lsyfgmi0JBKGMMXKi6AENzgXvED6PYFdK/0bYhSzo1K
 xS8buZF5Hbg0IovhEbthd9lkyUf4DH7/JYHYxrimZhnQo6EBMOae2xLIQ+uXJS946EgyjPmyQ
 SYmmxslTi4gxYZVfqvVdljRzOKMbtjRZQ/2sZUpmtw33SGXodgXoi3QR2GRrdOElwMpuK2rx6
 UiHcTHoH8tgK3pb+uT7hvvjgkxBRC7CFymh2+S6pEdEsLpwBc0PnEjr1PQTwJb91nkiGIGYtc
 w5XPhCDsPVmoV5rDfUMyIHTs7QOR+/OL0bFCsxO26tE8VhOo7xitnA6O6DSNxhHR5UAUt7T22
 qvr2uVq2n1tWIp3OtTe2saqycrppAoIoX59Pf5K5aOTtBnKskplGj7BxQslBRi6FLFGAGY4YG
 H4Ym1XI+QjnXO9QtWpWIie3YPeOvlz3R1oNSfwRT2lLbEjMYMSKULlSi1UCHQR2F4uqN/fLg0
 N/dVVf9jHwMqUMW5X9Z+hCsRavS63CKmmzTNwyec1yTQQL8tnKdFNdv2zPpwKCJFu0QmElgZx
 woiPLIv78iS/7cSeU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/2 =E4=B8=8B=E5=8D=884:33, Ritesh Harjani wrote:
> On 21/03/29 10:01AM, Qu Wenruo wrote:
>>
>>
>> On 2021/3/29 =E4=B8=8A=E5=8D=884:02, Ritesh Harjani wrote:
>>> On 21/03/25 09:16PM, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/3/25 =E4=B8=8B=E5=8D=888:20, Neal Gompa wrote:
>>>>> On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>>>
>>>>>> This patchset can be fetched from the following github repo, along =
with
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
>>>>>>      Since current defrag is doing per-page defrag, to support subp=
age
>>>>>>      defrag, we need some change in the loop.
>>>>>>      E.g. if a page has both hole and regular extents in it, then d=
efrag
>>>>>>      will rewrite the full 64K page.
>>>>>>
>>>>>>      Thus for now, defrag related failure is expected.
>>>>>>      But this should only cause behavior difference, no crash nor h=
ang is
>>>>>>      expected.
>>>>>>
>>>>>> - No compression support yet
>>>>>>      There are at least 2 known bugs if forcing compression for sub=
page
>>>>>>      * Some hard coded PAGE_SIZE screwing up space rsv
>>>>>>      * Subpage ASSERT() triggered
>>>>>>        This is because some compression code is unlocking locked_pa=
ge by
>>>>>>        calling extent_clear_unlock_delalloc() with locked_page =3D=
=3D NULL.
>>>>>>      So for now compression is also disabled.
>>>>>>
>>>>>> - Inode nbytes mismatch
>>>>>>      Still debugging.
>>>>>>      The fastest way to trigger is fsx using the following paramete=
rs:
>>>>>>
>>>>>>        fsx -l 262144 -o 65536 -S 30073 -N 256 -R -W $mnt/file > /tm=
p/fsx
>>>>>>
>>>>>>      Which would cause inode nbytes differs from expected value and
>>>>>>      triggers btrfs check error.
>>>>>>
>>>>>> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
>>>>>> The metadata part in fact has more new code than data part, as it h=
as
>>>>>> some different behaviors compared to the regular sector size handli=
ng:
>>>>>>
>>>>>> - No more page locking
>>>>>>      Now metadata read/write relies on extent io tree locking, othe=
r than
>>>>>>      page locking.
>>>>>>      This is to allow behaviors like read lock one eb while also tr=
y to
>>>>>>      read lock another eb in the same page.
>>>>>>      We can't rely on page lock as now we have multiple extent buff=
ers in
>>>>>>      the same page.
>>>>>>
>>>>>> - Page status update
>>>>>>      Now we use subpage wrappers to handle page status update.
>>>>>>
>>>>>> - How to submit dirty extent buffers
>>>>>>      Instead of just grabbing extent buffer from page::private, we =
need to
>>>>>>      iterate all dirty extent buffers in the page and submit them.
>>>>>>
>>>>>> [CHANGELOG]
>>>>>> v2:
>>>>>> - Rebased to latest misc-next
>>>>>>      No conflicts at all.
>>>>>>
>>>>>> - Add new sysfs interface to grab supported RO/RW sectorsize
>>>>>>      This will allow mkfs.btrfs to detect unmountable fs better.
>>>>>>
>>>>>> - Use newer naming schema for each patch
>>>>>>      No more "extent_io:" or "inode:" schema anymore.
>>>>>>
>>>>>> - Move two pure cleanups to the series
>>>>>>      Patch 2~3, originally in RW part.
>>>>>>
>>>>>> - Fix one uninitialized variable
>>>>>>      Patch 6.
>>>>>>
>>>>>> v3:
>>>>>> - Rename the sysfs to supported_sectorsizes
>>>>>>
>>>>>> - Rebased to latest misc-next branch
>>>>>>      This removes 2 cleanup patches.
>>>>>>
>>>>>> - Add new overview comment for subpage metadata
>>>>>>
>>>>>> Qu Wenruo (13):
>>>>>>      btrfs: add sysfs interface for supported sectorsize
>>>>>>      btrfs: use min() to replace open-code in btrfs_invalidatepage(=
)
>>>>>>      btrfs: remove unnecessary variable shadowing in btrfs_invalida=
tepage()
>>>>>>      btrfs: refactor how we iterate ordered extent in
>>>>>>        btrfs_invalidatepage()
>>>>>>      btrfs: introduce helpers for subpage dirty status
>>>>>>      btrfs: introduce helpers for subpage writeback status
>>>>>>      btrfs: allow btree_set_page_dirty() to do more sanity check on=
 subpage
>>>>>>        metadata
>>>>>>      btrfs: support subpage metadata csum calculation at write time
>>>>>>      btrfs: make alloc_extent_buffer() check subpage dirty bitmap
>>>>>>      btrfs: make the page uptodate assert to be subpage compatible
>>>>>>      btrfs: make set/clear_extent_buffer_dirty() to be subpage comp=
atible
>>>>>>      btrfs: make set_btree_ioerr() accept extent buffer and to be s=
ubpage
>>>>>>        compatible
>>>>>>      btrfs: add subpage overview comments
>>>>>>
>>>>>>     fs/btrfs/disk-io.c   | 143 ++++++++++++++++++++++++++++++++++--=
-------
>>>>>>     fs/btrfs/extent_io.c | 127 ++++++++++++++++++++++++++++--------=
--
>>>>>>     fs/btrfs/inode.c     | 128 ++++++++++++++++++++++--------------=
--
>>>>>>     fs/btrfs/subpage.c   | 127 ++++++++++++++++++++++++++++++++++++=
++
>>>>>>     fs/btrfs/subpage.h   |  17 +++++
>>>>>>     fs/btrfs/sysfs.c     |  15 +++++
>>>>>>     6 files changed, 441 insertions(+), 116 deletions(-)
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
>>>> The metadata part is much more stable than data path (almost not touc=
hed
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
>>>> In fact, we used to have subpage support sent as a big patchset from =
IBM
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
>>> Sorry about chiming in late on this. I don't have any strong objection=
 on either
>>> approach. Although sometime back when I tested your RW support git tre=
e on
>>> Power, the unmount patch itself was crashing. I didn't debug it that t=
ime
>>> (this was a month back or so), so I also didn't bother testing xfstest=
s on Power.
>>>
>>> But we do have an interest in making sure this patch series work on bs=
 < ps
>>> on Power platform. I can try helping with testing, reviewing (to best =
of my
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
>>> Let me try and pull your tree and test it on Power. Please let me know=
 if there
>>> is anything needs to be taken care apart from your github tree and btr=
fs-progs
>>> branch with bs < ps support.
>>
>> If you're going to test the branch, here are some small notes:
>>
>> - Need to use latest btrfs-progs
>>    As it fixes a false alert on crossing 64K page boundary.
>>
>> - Need to slightly modify btrfs-progs to avoid false alerts
>>    For subpage case, mkfs.btrfs will output a warning, but that warning
>>    is outputted into stderr, which will screw up generic test groups.
>>    It's recommended to apply the following diff:
>>
>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>> index 569208a9..21976554 100644
>> --- a/common/fsfeatures.c
>> +++ b/common/fsfeatures.c
>> @@ -341,8 +341,8 @@ int btrfs_check_sectorsize(u32 sectorsize)
>>                  return -EINVAL;
>>          }
>>          if (page_size !=3D sectorsize)
>> -               warning(
>> -"the filesystem may not be mountable, sectorsize %u doesn't match page
>> size %u",
>> +               printf(
>> +"the filesystem may not be mountable, sectorsize %u doesn't match page
>> size %u\n",
>>                          sectorsize, page_size);
>>          return 0;
>>   }
>>
>> - Xfstest/btrfs group will crash at btrfs/143
>>    Still investigating, but you can ignore btrfs group for now.
>>
>> - Very rare hang
>>    There is a very low change to hang, with "bad ordered accounting"
>>    dmesg.
>>    If you can hit, please let me know.
>>    I had something idea to fix it, but not yet in the branch.
>>
>> - btrfs inode nbytes mismatch
>>    Investigating, as it will make btrfs-check to report error.
>>
>> The last two bugs are the final show blocker, I'll give you extra
>> updates when those are fixed.
>
> Thanks Qu Wenruo, for above info.
> I cloned below git tree as mentioned in your git log to test for RW on P=
ower.
> However, I still see that RW mount for bs < ps is disabled for in open_c=
tree()
> https://github.com/adam900710/linux/tree/subpage
>
> I see below code present in this tree.
>           /* For 4K sector size support, it's only read-only */
>           if (PAGE_SIZE =3D=3D SZ_64K && sectorsize =3D=3D SZ_4K) {
>                   if (!sb_rdonly(sb) || btrfs_super_log_root(disk_super)=
) {
>                           btrfs_err(fs_info,
>           "subpage sectorsize %u only supported read-only for page size =
%lu",
>                                   sectorsize, PAGE_SIZE);
>                           err =3D -EINVAL;
>                           goto fail_alloc;
>                   }
>           }
>
> Could you pls point me to the tree I can use for bs < ps testing on Powe=
r?
> Sorry if I missed something.

Sorry, I updated the branch to my current development progress, it's now
at the ordered extent rework part, without the remaining subpage
functionality at all.

You may want to grab this tree instead:
https://github.com/adam900710/linux/tree/subpage_old

But please keep in mind that, you may get random hang, and certain
generic test case, especially generic/075 can corrupt the inode nbytes
and leaving all later test cases using TEST_DEV to report error on fsck.

Thanks,
Qu

>
> Thanks
> -ritesh
>
