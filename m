Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D542352797
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Apr 2021 10:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhDBIwf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Apr 2021 04:52:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:37177 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhDBIwf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 2 Apr 2021 04:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617353552;
        bh=1sflLHFTUyWbddit6jkMW+a0vX+yNlevie2OYeitk0o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Y8o4DhLLZcFC06AzsZtIGo9pwN05sDMUW9Spn+SRmzehp3X/sMpZN7mmyR8z5FDjZ
         4rYgt54w61/Q21wx4aBJBD+OaTxhvuXoEyv0Gv/vLpqecaQaXMY3935/toaEc1wyz8
         PEwZIhyVHPCMJ0M4ndN2KNu4pSkZo+WExWsXWhjg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsHns-1llHWf0mGg-00tnLw; Fri, 02
 Apr 2021 10:52:31 +0200
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
Date:   Fri, 2 Apr 2021 16:52:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210402084652.b7a4mj2mntxu2xi5@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Wl2GEje091FKgYg5DyOseAIfcwjhARf/GaZk6Cjq+jG8UI6Gvf
 be9XStum3MthwgXLPctYPOcGDRblkPjBI7w2lSZHyfr/iw94qtWxpDSkfCN2DbWuwZeOUxk
 z4Vtt51KaL6y8yYmmqqg/tUlj3aDz8kPR5RJkWjdNbIpkRAod6o67xz7ZCzqrRcBO9yRAwu
 4qnVNV1pndmssjG+g7rQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BMeYvMtAj4o=:/+tlzh3Qetbu6wU29XSVs3
 DFnpv9pK3BdeLJYBmRVPdi6RKyJ2KaFB4xdgQta4/zGyUs6AX5yzbmXbfx+asyYHvAQAlRVcY
 8ecjzL+KU5BCjU8Z480rykypuytKAPa3dowDmVAs/sQNQhUcGseenA/rjs41yzXC/FSiSTNhq
 MIBJPmt5nl9N5Ltd2GlpRyDnMejvCMslLFrgkhbpUz/u9RbboMMljlI8QpIFBorP1GCZEallH
 QrMkysnxvjdYpeyuXK9QFavx58s2pSUOO29Im3LZeoZecqO1IFYzXfn+FEWijcmbzVjVV7fYS
 c4wX8wtFOy3Hn4ZrE5UQj1x7dOyAtiS2Z3xkIgcZclN2rmEyDS4g5YO+WdUpAuIYZ2FsUYoPd
 ivCGWoVHQSRHJ7wYX/EDEYNrn7ekT7+flKPBPuT0Q9qVC9jwr4aYVqvNDLzLzyb5sbeHHZyWM
 7l+exUA6/EuUwpEueBpjo/oeRH6SATz6q2h6Bfhhq+Hw9C9K8dgit6Pfc6RFdkUqOLtq2o1rp
 ZEPu+O3a8YkSoYMznpir0Fp7pyP3eAa8Ueg9G/GpohMDi/6vhKIS3yxsDrsbeCUNq1EigGtDq
 XlkVQemz4U91IJiQCKLwrmZiG3eKvU+0SCzwiVBEleRyOJWUgMIiKrsjMVn3C12gUxdEpOjk8
 SrvXLOe0kt33/yNH866ZileFyWQaJea53r6spJfO/2Aon7zqO+GWKE5kJLGtvNErh38gDVD3i
 PWB0d4MzoJcSQDL4smY0tNimg9NpzzySB2/AdzxuYbkSWA56TKRWCf5rIwffxNvUmbnwbjKVR
 5uJ/M2uxjsFgB+1j3WgsUq+ignoo8M5VM9kL1IgH6xlYwqZBzaxSAlumUKXidHHWjBCp9GZ7O
 Ah4mQl0zmMo3RDgkLGL66wPHwtBfGZSukQXLZQMppIcK9fxmCAFGIvze6UFZblh7mbhz4GgzI
 58oPqDzZtJt1QWe6D2ZTXagpOdh/kjknNzvEzRJPZqUi3uTwcVQgFhC4mZHhtiJk7oGUk/XGd
 iPlYoOZuEtsjpvT5iXWv74fc1iSPH4JJ4CfP5LT4v2FA//DrOUBb0vpRe206VvchWdqlPSxdr
 od4N68PTgddoiXCAde2B3MJb64Yzt5KTkpwQp3QUrPS7v/4Af/fkuG8T6sQfcnZpkIj4yk6b0
 4FkyajRL8zg+RJVlUhFTmxjN+QoydNB3Z/pTtl6tR545G8Sw3UVcFiuSYsSYyaimteATaKBxz
 4vs/IbjXTkfee84yQ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/2 =E4=B8=8B=E5=8D=884:46, Ritesh Harjani wrote:
> On 21/04/02 04:36PM, Qu Wenruo wrote:
>>
>>
>> On 2021/4/2 =E4=B8=8B=E5=8D=884:33, Ritesh Harjani wrote:
>>> On 21/03/29 10:01AM, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2021/3/29 =E4=B8=8A=E5=8D=884:02, Ritesh Harjani wrote:
>>>>> On 21/03/25 09:16PM, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/3/25 =E4=B8=8B=E5=8D=888:20, Neal Gompa wrote:
>>>>>>> On Thu, Mar 25, 2021 at 3:17 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>>>>>
>>>>>>>> This patchset can be fetched from the following github repo, alon=
g with
>>>>>>>> the full subpage RW support:
>>>>>>>> https://github.com/adam900710/linux/tree/subpage
>>>>>>>>
>>>>>>>> This patchset is for metadata read write support.
>>>>>>>>
>>>>>>>> [FULL RW TEST]
>>>>>>>> Since the data write path is not included in this patchset, we ca=
n't
>>>>>>>> really test the patchset itself, but anyone can grab the patch fr=
om
>>>>>>>> github repo and do fstests/generic tests.
>>>>>>>>
>>>>>>>> But at least the full RW patchset can pass -g generic/quick -x de=
frag
>>>>>>>> for now.
>>>>>>>>
>>>>>>>> There are some known issues:
>>>>>>>>
>>>>>>>> - Defrag behavior change
>>>>>>>>       Since current defrag is doing per-page defrag, to support s=
ubpage
>>>>>>>>       defrag, we need some change in the loop.
>>>>>>>>       E.g. if a page has both hole and regular extents in it, the=
n defrag
>>>>>>>>       will rewrite the full 64K page.
>>>>>>>>
>>>>>>>>       Thus for now, defrag related failure is expected.
>>>>>>>>       But this should only cause behavior difference, no crash no=
r hang is
>>>>>>>>       expected.
>>>>>>>>
>>>>>>>> - No compression support yet
>>>>>>>>       There are at least 2 known bugs if forcing compression for =
subpage
>>>>>>>>       * Some hard coded PAGE_SIZE screwing up space rsv
>>>>>>>>       * Subpage ASSERT() triggered
>>>>>>>>         This is because some compression code is unlocking locked=
_page by
>>>>>>>>         calling extent_clear_unlock_delalloc() with locked_page =
=3D=3D NULL.
>>>>>>>>       So for now compression is also disabled.
>>>>>>>>
>>>>>>>> - Inode nbytes mismatch
>>>>>>>>       Still debugging.
>>>>>>>>       The fastest way to trigger is fsx using the following param=
eters:
>>>>>>>>
>>>>>>>>         fsx -l 262144 -o 65536 -S 30073 -N 256 -R -W $mnt/file > =
/tmp/fsx
>>>>>>>>
>>>>>>>>       Which would cause inode nbytes differs from expected value =
and
>>>>>>>>       triggers btrfs check error.
>>>>>>>>
>>>>>>>> [DIFFERENCE AGAINST REGULAR SECTORSIZE]
>>>>>>>> The metadata part in fact has more new code than data part, as it=
 has
>>>>>>>> some different behaviors compared to the regular sector size hand=
ling:
>>>>>>>>
>>>>>>>> - No more page locking
>>>>>>>>       Now metadata read/write relies on extent io tree locking, o=
ther than
>>>>>>>>       page locking.
>>>>>>>>       This is to allow behaviors like read lock one eb while also=
 try to
>>>>>>>>       read lock another eb in the same page.
>>>>>>>>       We can't rely on page lock as now we have multiple extent b=
uffers in
>>>>>>>>       the same page.
>>>>>>>>
>>>>>>>> - Page status update
>>>>>>>>       Now we use subpage wrappers to handle page status update.
>>>>>>>>
>>>>>>>> - How to submit dirty extent buffers
>>>>>>>>       Instead of just grabbing extent buffer from page::private, =
we need to
>>>>>>>>       iterate all dirty extent buffers in the page and submit the=
m.
>>>>>>>>
>>>>>>>> [CHANGELOG]
>>>>>>>> v2:
>>>>>>>> - Rebased to latest misc-next
>>>>>>>>       No conflicts at all.
>>>>>>>>
>>>>>>>> - Add new sysfs interface to grab supported RO/RW sectorsize
>>>>>>>>       This will allow mkfs.btrfs to detect unmountable fs better.
>>>>>>>>
>>>>>>>> - Use newer naming schema for each patch
>>>>>>>>       No more "extent_io:" or "inode:" schema anymore.
>>>>>>>>
>>>>>>>> - Move two pure cleanups to the series
>>>>>>>>       Patch 2~3, originally in RW part.
>>>>>>>>
>>>>>>>> - Fix one uninitialized variable
>>>>>>>>       Patch 6.
>>>>>>>>
>>>>>>>> v3:
>>>>>>>> - Rename the sysfs to supported_sectorsizes
>>>>>>>>
>>>>>>>> - Rebased to latest misc-next branch
>>>>>>>>       This removes 2 cleanup patches.
>>>>>>>>
>>>>>>>> - Add new overview comment for subpage metadata
>>>>>>>>
>>>>>>>> Qu Wenruo (13):
>>>>>>>>       btrfs: add sysfs interface for supported sectorsize
>>>>>>>>       btrfs: use min() to replace open-code in btrfs_invalidatepa=
ge()
>>>>>>>>       btrfs: remove unnecessary variable shadowing in btrfs_inval=
idatepage()
>>>>>>>>       btrfs: refactor how we iterate ordered extent in
>>>>>>>>         btrfs_invalidatepage()
>>>>>>>>       btrfs: introduce helpers for subpage dirty status
>>>>>>>>       btrfs: introduce helpers for subpage writeback status
>>>>>>>>       btrfs: allow btree_set_page_dirty() to do more sanity check=
 on subpage
>>>>>>>>         metadata
>>>>>>>>       btrfs: support subpage metadata csum calculation at write t=
ime
>>>>>>>>       btrfs: make alloc_extent_buffer() check subpage dirty bitma=
p
>>>>>>>>       btrfs: make the page uptodate assert to be subpage compatib=
le
>>>>>>>>       btrfs: make set/clear_extent_buffer_dirty() to be subpage c=
ompatible
>>>>>>>>       btrfs: make set_btree_ioerr() accept extent buffer and to b=
e subpage
>>>>>>>>         compatible
>>>>>>>>       btrfs: add subpage overview comments
>>>>>>>>
>>>>>>>>      fs/btrfs/disk-io.c   | 143 +++++++++++++++++++++++++++++++++=
+---------
>>>>>>>>      fs/btrfs/extent_io.c | 127 ++++++++++++++++++++++++++++-----=
-----
>>>>>>>>      fs/btrfs/inode.c     | 128 ++++++++++++++++++++++-----------=
-----
>>>>>>>>      fs/btrfs/subpage.c   | 127 +++++++++++++++++++++++++++++++++=
+++++
>>>>>>>>      fs/btrfs/subpage.h   |  17 +++++
>>>>>>>>      fs/btrfs/sysfs.c     |  15 +++++
>>>>>>>>      6 files changed, 441 insertions(+), 116 deletions(-)
>>>>>>>>
>>>>>>>> --
>>>>>>>> 2.30.1
>>>>>>>>
>>>>>>>
>>>>>>> Why wouldn't we just integrate full read-write support with the
>>>>>>> caveats as described now? It seems to be relatively reasonable to =
do
>>>>>>> that, and this patch set is essentially unusable without the rest =
of
>>>>>>> it that does enable full read-write support.
>>>>>>
>>>>>> The metadata part is much more stable than data path (almost not to=
uched
>>>>>> for several months), and the metadata part already has some differe=
nce
>>>>>> in its behavior, which needs review.
>>>>>>
>>>>>> You point makes some sense, but I still don't believe pushing a sup=
er
>>>>>> large patchset does any help for the review.
>>>>>>
>>>>>> If you want to test, you can grab the branch from the github repo.
>>>>>> If you want to review, the mails are all here for review.
>>>>>>
>>>>>> In fact, we used to have subpage support sent as a big patchset fro=
m IBM
>>>>>> guys, but the result is only some preparation patches get merged, a=
nd
>>>>>> nothing more.
>>>>>>
>>>>>> Using this multi-series method, we're already doing better work and
>>>>>> received more testing (to ensure regular sectorsize is not affected=
 at
>>>>>> least).
>>>>>
>>>>> Hi Qu Wenruo,
>>>>>
>>>>> Sorry about chiming in late on this. I don't have any strong objecti=
on on either
>>>>> approach. Although sometime back when I tested your RW support git t=
ree on
>>>>> Power, the unmount patch itself was crashing. I didn't debug it that=
 time
>>>>> (this was a month back or so), so I also didn't bother testing xfste=
sts on Power.
>>>>>
>>>>> But we do have an interest in making sure this patch series work on =
bs < ps
>>>>> on Power platform. I can try helping with testing, reviewing (to bes=
t of my
>>>>> knowledge) and fixing anything is possible :)
>>>>
>>>> That's great!
>>>>
>>>> One of my biggest problem here is, I don't have good enough testing
>>>> environment.
>>>>
>>>> Although SUSE has internal clouds for ARM64/PPC64, but due to the
>>>> f**king Great Firewall, it's super slow to access, no to mention doin=
g
>>>> proper debugging.
>>>>
>>>> Currently I'm using two ARM SBCs, RK3399 and A311D based, to do the t=
est.
>>>> But their computing power is far from ideal, only generic/quick can
>>>> finish in hours.
>>>>
>>>> Thus real world Power could definitely help.
>>>>>
>>>>> Let me try and pull your tree and test it on Power. Please let me kn=
ow if there
>>>>> is anything needs to be taken care apart from your github tree and b=
trfs-progs
>>>>> branch with bs < ps support.
>>>>
>>>> If you're going to test the branch, here are some small notes:
>>>>
>>>> - Need to use latest btrfs-progs
>>>>     As it fixes a false alert on crossing 64K page boundary.
>>>>
>>>> - Need to slightly modify btrfs-progs to avoid false alerts
>>>>     For subpage case, mkfs.btrfs will output a warning, but that warn=
ing
>>>>     is outputted into stderr, which will screw up generic test groups=
.
>>>>     It's recommended to apply the following diff:
>>>>
>>>> diff --git a/common/fsfeatures.c b/common/fsfeatures.c
>>>> index 569208a9..21976554 100644
>>>> --- a/common/fsfeatures.c
>>>> +++ b/common/fsfeatures.c
>>>> @@ -341,8 +341,8 @@ int btrfs_check_sectorsize(u32 sectorsize)
>>>>                   return -EINVAL;
>>>>           }
>>>>           if (page_size !=3D sectorsize)
>>>> -               warning(
>>>> -"the filesystem may not be mountable, sectorsize %u doesn't match pa=
ge
>>>> size %u",
>>>> +               printf(
>>>> +"the filesystem may not be mountable, sectorsize %u doesn't match pa=
ge
>>>> size %u\n",
>>>>                           sectorsize, page_size);
>>>>           return 0;
>>>>    }
>>>>
>>>> - Xfstest/btrfs group will crash at btrfs/143
>>>>     Still investigating, but you can ignore btrfs group for now.
>>>>
>>>> - Very rare hang
>>>>     There is a very low change to hang, with "bad ordered accounting"
>>>>     dmesg.
>>>>     If you can hit, please let me know.
>>>>     I had something idea to fix it, but not yet in the branch.
>>>>
>>>> - btrfs inode nbytes mismatch
>>>>     Investigating, as it will make btrfs-check to report error.
>>>>
>>>> The last two bugs are the final show blocker, I'll give you extra
>>>> updates when those are fixed.
>>>
>>> Thanks Qu Wenruo, for above info.
>>> I cloned below git tree as mentioned in your git log to test for RW on=
 Power.
>>> However, I still see that RW mount for bs < ps is disabled for in open=
_ctree()
>>> https://github.com/adam900710/linux/tree/subpage
>>>
>>> I see below code present in this tree.
>>>            /* For 4K sector size support, it's only read-only */
>>>            if (PAGE_SIZE =3D=3D SZ_64K && sectorsize =3D=3D SZ_4K) {
>>>                    if (!sb_rdonly(sb) || btrfs_super_log_root(disk_sup=
er)) {
>>>                            btrfs_err(fs_info,
>>>            "subpage sectorsize %u only supported read-only for page si=
ze %lu",
>>>                                    sectorsize, PAGE_SIZE);
>>>                            err =3D -EINVAL;
>>>                            goto fail_alloc;
>>>                    }
>>>            }
>>>
>>> Could you pls point me to the tree I can use for bs < ps testing on Po=
wer?
>>> Sorry if I missed something.
>>
>> Sorry, I updated the branch to my current development progress, it's no=
w
>> at the ordered extent rework part, without the remaining subpage
>> functionality at all.
>>
>> You may want to grab this tree instead:
>> https://github.com/adam900710/linux/tree/subpage_old
>>
>> But please keep in mind that, you may get random hang, and certain
>> generic test case, especially generic/075 can corrupt the inode nbytes
>> and leaving all later test cases using TEST_DEV to report error on fsck=
.
>>
>
> Thanks for quick response. Sure, I will exclude generic/075 from the tes=
t
> for now.

Not only generic/075, but all tests running fsx may cause inode nbytes
corruption.

Thus I'd recommend either modify btrfs-check to ignore it, or re-mkfs on
TEST_DEV after each test case.

Thanks,
Qu

>
> -ritesh
>
