Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649B3363B5A
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 08:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbhDSGRZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 02:17:25 -0400
Received: from mout.gmx.net ([212.227.17.20]:58715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhDSGRZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 02:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618813011;
        bh=0kKruluI1iZcycL6jJoGsmI/UixQEfshmf7s3ohSzwU=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=joeNjS3PASROCwNCBXgs9v/T6YtdyQHBhEiKDWhfJyiBAa8aaHhFMw0skmLrYoYSQ
         Q0ewuD6VjAIXJ8RPimmNpLhugqEbJV7P6a6VgucCcNFea0DtU4AX0SrOAJ5PJISe55
         R59pewC5LjmrvjTXbgLkr5OB0Qzo9brZK8/JHRIc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFbRm-1lIQFY0WBK-00H3EY; Mon, 19
 Apr 2021 08:16:50 +0200
To:     riteshh <riteshh@linux.ibm.com>, Qu Wenruo <wqu@suse.com>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
 <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
 <20210415034444.3fg5j337ee6rvdps@riteshh-domain>
 <20210415145207.y4n3km5a2pawdeb4@riteshh-domain>
 <8bdb27e4-af63-653c-98e5-e6ffa4eee667@gmx.com>
 <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
 <c06a013e-0f7d-21f5-0bd1-9c6c22024fd8@gmx.com>
 <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
 <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
 <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
 <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <93a2422e-6d5d-1c97-49ad-d166fe851575@gmx.com>
Date:   Mon, 19 Apr 2021 14:16:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LwqQAmz4nDib9ppMFnv77diG6Rcafx1DdT/btZqWxyOA95HYbAP
 kiRo9/REuh3XodexXe9yoZw6WWi3AWTyTnAURPdIiJoQ1QNxjdqQqK/jNL+DJFhG8/36CjE
 yOkdMNSpbxzE2ruN4EeRkXsdfyuxDoSLdNGtiIm6Hj7CTBvjNwYy3GlvabqxJ3UToyhRHW1
 sPyu+AB5/3i/1ZFfrKEVw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IK5g5266XSo=:rGz6mBQNcq3HI9p03X3397
 ZXoI/5f3vJ3L7+vzYaxkwBLvtUQpYn4LxlFYVCkHsZLgZl0FOLP6ftlCcuX+w/dpKh9tH3FPF
 J6vMgknz6ulV2nhXeeT7OfK2rM7zmGAD7yGwabMyeG7GWfxwssVHshvN+/uyK0JYZ1gsJfoSD
 WLTU0/0wxlQJ5t0aZnh43yUw8ozRdDPBI4ajjJITpmVwLmHA1RHNFO8fGymgAvJvPBqx4CIW+
 6IL+rwTuvIlnlt3W1VQHvgsdifjJg8PcTRPoMpZVgcIUQcYahKk8UbX6lMLOqLBXJ0ZQjyXBk
 IWWUwYHVOV4whTG2J/4s/6T2kgJfjpI4i3rUvhFYMsx47HjzRKOkv2r2b/dEVWoCOUEgqkmTM
 l0vqMYNibczjQIMNaV7aChIkT0KJdXe01/S41ocOH3S+nsCl5a6qylZFbmofFtdwcSDjsm8q5
 LHQg+kCSdDX3MCZHDrAxjJ5nSoBDNjFLOZfU1GZIKE9LsCjZyMsJJEITBlBvWTLBaW002Uq2H
 CwOu0Kh+6KPsGCwfljJm3oH64nJtnUzGj7SwjyCUVuVfFsR5mtMRy/FPGjjT/5Z64Fndz6ttS
 qraNbrfvfTJ4EbQWKv56969xr1qvYVb0GurpZ3lNUusyCOY0a/z5wGcK/uYZMDOdDXV/BhnKt
 bozh6ZD8W+Zt4yml4AArQIkHYc6UZgo4B9a/eXCxYJS4EiMWbkUfyz8RIbCqoIi/zBD1WprF6
 jKnKrQMbN90uZ3JLQS6FSUARZrmjyFBty4t3wnz5AY7UZgWVRgCOJhwQ0rdiODQXqBRPl0bQj
 wNzoV1M/OiNp8cDJLC30RXpushH7mzToUyqxcyzNAu2gKIQ96DJutHI/aWYyyMFFFIrmJFiAU
 ez5wqczvs4nc9Eop++fHdXlpZK9w23ewsS36QFA4ZfvtwfPVb44IW9zNDsfCCNSwBDxbeY2zq
 4aeE3Vtc55946cuBPHh0hbrMxJbUdJ/k4cNQ3+ZCJOVeCif62fCyMWb1zowBxWRbja015BMbS
 YDmZbUSk/Bcbdv9dgyr/6ulCqr0iGGNQZEcZ5p2y1THRfCZNcL3HuoJEOG+5+90VT/TwJooZl
 Hs7oi309/IZIaF83/g3kUN7hMASVPCHvAsC9KXLA9PiZ4O+N1UFL2e1+TGasZaYcZ98bKXO5F
 WqTKUxL0hvK3TAbLhnj4EMTp1Li1iCD93bsQDFmSiu+PhFM18uGLW1cdOHS1EsNnDSm33hpy3
 x1x9Ne/Mr0lLXZSmL
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/19 =E4=B8=8B=E5=8D=881:59, riteshh wrote:
> On 21/04/16 10:22PM, riteshh wrote:
>> On 21/04/16 02:14PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2021/4/16 =E4=B8=8B=E5=8D=881:50, riteshh wrote:
>>>> On 21/04/16 09:34AM, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2021/4/16 =E4=B8=8A=E5=8D=887:34, Qu Wenruo wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/4/16 =E4=B8=8A=E5=8D=887:19, Qu Wenruo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2021/4/15 =E4=B8=8B=E5=8D=8810:52, riteshh wrote:
>>>>>>>> On 21/04/15 09:14AM, riteshh wrote:
>>>>>>>>> On 21/04/12 07:33PM, Qu Wenruo wrote:
>>>>>>>>>> Good news, you can fetch the subpage branch for better test res=
ults.
>>>>>>>>>>
>>>>>>>>>> Now the branch should pass all generic tests, except defrag and=
 known
>>>>>>>>>> failures.
>>>>>>>>>> And no more random crash during the tests.
>>>>>>>>>
>>>>>>>>> Thanks, let me test it on PPC64 box.
>>>>>>>>
>>>>>>>> I do see some failures remaining with the patch series.
>>>>>>>> However the one which is blocking my testing is the tests/generic=
/095
>>>>>>>> I see kernel BUG hitting with below signature.
>>>>>>>
>>>>>>> That's pretty different from my tests.
>>>>>>>
>>>>>>> As I haven't seen such BUG_ON() for a while.
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Please let me know if this a known failure?
>>>>>>>>
>>>>>>>> <xfstests config>
>>>>>>>> #:~/work-tools/xfstests$ sudo ./check -g auto
>>>>>>>> SECTION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- btrfs_4k
>>>>>>>> FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- btrfs
>>>>>>>> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/ppc64le qemu 5.12=
.0-rc7-02316-g3490dae50c0 #73
>>>>>>>> SMP Thu Apr 15 07:29:23 CDT 2021
>>>>>>>> MKFS_OPTIONS=C2=A0 -- -f -s 4096 -n 4096 /dev/loop3
>>>>>>>
>>>>>>> I see you're using -n 4096, not the default -n 16K, let me see if =
I can
>>>>>>> reproduce that.
>>>>>>>
>>>>>>> But from the backtrace, it doesn't look like the case,
>>>>>>> as it happens for data path, which means it's only related to sect=
orsize.
>>>>>>>
>>>>>>>> MOUNT_OPTIONS -- /dev/loop3 /mnt1/scratch
>>>>>>>>
>>>>>>>>
>>>>>>>> <kernel logs>
>>>>>>>> [ 6057.560580] BTRFS warning (device loop3): read-write for secto=
r
>>>>>>>> size 4096 with page size 65536 is experimental
>>>>>>>> [ 6057.861383] run fstests generic/095 at 2021-04-15 14:12:10
>>>>>>>> [ 6058.345127] BTRFS info (device loop2): disk space caching is e=
nabled
>>>>>>>> [ 6058.348910] BTRFS info (device loop2): has skinny extents
>>>>>>>> [ 6058.351930] BTRFS warning (device loop2): read-write for secto=
r
>>>>>>>> size 4096 with page size 65536 is experimental
>>>>>>>> [ 6059.896382] BTRFS: device fsid 43ec9cdf-c124-4460-ad93-933bfd5=
ddbbd
>>>>>>>> devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (739641)
>>>>>>>> [ 6060.225107] BTRFS info (device loop3): disk space caching is e=
nabled
>>>>>>>> [ 6060.226213] BTRFS info (device loop3): has skinny extents
>>>>>>>> [ 6060.227084] BTRFS warning (device loop3): read-write for secto=
r
>>>>>>>> size 4096 with page size 65536 is experimental
>>>>>>>> [ 6060.234537] BTRFS info (device loop3): checking UUID tree
>>>>>>>> [ 6061.375902] assertion failed: PagePrivate(page) && page->priva=
te,
>>>>>>>> in fs/btrfs/subpage.c:171
>>>>>>>> [ 6061.378296] ------------[ cut here ]------------
>>>>>>>> [ 6061.379422] kernel BUG at fs/btrfs/ctree.h:3403!
>>>>>>>> cpu 0x5: Vector: 700 (Program Check) at [c0000000260d7490]
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 pc: c000000000a9370c: assertfail.const=
prop.11+0x34/0x48
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 lr: c000000000a93708: assertfail.const=
prop.11+0x30/0x48
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 sp: c0000000260d7730
>>>>>>>>   =C2=A0=C2=A0=C2=A0 msr: 800000000282b033
>>>>>>>>   =C2=A0=C2=A0 current =3D 0xc0000000260c0080
>>>>>>>>   =C2=A0=C2=A0 paca=C2=A0=C2=A0=C2=A0 =3D 0xc00000003fff8a00=C2=
=A0=C2=A0 irqmask: 0x03=C2=A0=C2=A0 irq_happened: 0x01
>>>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0 pid=C2=A0=C2=A0 =3D 739712, comm =3D f=
io
>>>>>>>> kernel BUG at fs/btrfs/ctree.h:3403!
>>>>>>>> Linux version 5.12.0-rc7-02316-g3490dae50c0 (riteshh@xxxx) (gcc
>>>>>>>> (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubu=
ntu)
>>>>>>>> 2.30) #73 SMP Thu Apr 15 07:29:23 CDT 2021
>>>>>>>> enter ? for help
>>>>>>>> [c0000000260d7790] c000000000a90280
>>>>>>>> btrfs_subpage_assert.isra.9+0x70/0x110
>>>>>>>> [c0000000260d77b0] c000000000a91064
>>>>>>>> btrfs_subpage_set_uptodate+0x54/0x110
>>>>>>>> [c0000000260d7800] c0000000009c6d0c btrfs_dirty_pages+0x1bc/0x2c0
>>>>>>>
>>>>>>> This is very strange.
>>>>>>> As in btrfs_dirty_pages(), the pages passed in are already prepare=
d by
>>>>>>> prepare_pages(), which means all of them should have Private set.
>>>>>>>
>>>>>>> Can you reproduce the bug reliable?
>>>>
>>>> Yes. almost reliably on my PPC box.
>>>>
>>>>>>
>>>>>> OK, I got it reproduced.
>>>>>>
>>>>>> It's not a reliable BUG_ON(), but can be reproduced.
>>>>>> The test get skipped for all my boards as it requires fio tool, thu=
s I
>>>>>> didn't get it triggered for all previous runs.
>>>>>>
>>>>>> I'll take a look into the case.
>>>>>
>>>>> This exposed an interesting race window in btrfs_buffered_write():
>>>>>           Writer                    |             fadvice
>>>>> ----------------------------------+-------------------------------
>>>>> btrfs_buffered_write()            |
>>>>> |- prepare_pages()                |
>>>>> |  |- Now all pages involved get  |
>>>>> |     Private set                 |
>>>>> |                                 | btrfs_release_page()
>>>>> |                                 | |- Clear page Private
>>>>> |- lock_extent()                  |
>>>>> |  |- This would prevent          |
>>>>> |     btrfs_release_page() to     |
>>>>> |     clear the page Private      |
>>>>> |
>>>>> |- btrfs_dirty_page()
>>>>>      |- Will trigger the BUG_ON()
>>>>
>>>>
>>>> Sorry about the silly query. But help me understand how is above race=
 possible?
>>>> Won't prepare_pages() will lock all the pages first. The same require=
ment
>>>> of locked page should be with btrfs_releasepage() too no?
>>>
>>> releasepage() call can easily got a page locked and release it.
>>>
>>> For call sites like btrfs_invalidatepage(), the page is already locked=
.
>>>
>>> btrfs_releasepage() will not to try to release the page if the extent =
is
>>> locked (any extent range inside the page has EXTENT_LOCK bit).
>>>
>>>>
>>>> I see only two paths which could result into btrfs_releasepage()
>>>> 1. one via try_to_release_pages -> releasepage()
>>>
>>> This is the race one, called from fadvice() to release pages.
>>>
>>>> 2. writeback path calling btrfs_writepage or btrfs_writepages
>>>> 	which may result into calling of btrfs_invalidatepage()
>>>
>>> Not this one.
>>>
>>>>
>>>> Although I am not sure which one this is racing with.
>>>>
>>>>>
>>>>> This only happens for subpage, because subpage introduces new ASSERT=
()
>>>>> to do extra check.
>>>>>
>>>>> If we want to speak strictly, regular sector size should also report
>>>>> this problem.
>>>>> But regular sector size case doesn't really care about page Private,=
 as
>>>>> it just set page->private to a constant value, unlike subpage case w=
hich
>>>>> stores important value.
>>>>>
>>>>> The fix will just re-set page Private and needed structures in
>>>>> btrfs_dirty_page(), under extent locked so no btrfs_releasepage() is
>>>>> able to release it anymore.
>>>>
>>>> With above fix I see a different issue with below signature.
>>>>
>>>> [  130.272410] BTRFS warning (device loop2): read-write for sector si=
ze 4096 with page size 65536 is experimental
>>>> [  130.387470] run fstests generic/095 at 2021-04-16 05:04:09
>>>> [  132.042532] BTRFS: device fsid 642daee0-165a-4271-b6f3-728f215c534=
8 devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (5226)
>>>> [  132.146892] BTRFS info (device loop3): disk space caching is enabl=
ed
>>>> [  132.147831] BTRFS info (device loop3): has skinny extents
>>>> [  132.148491] BTRFS warning (device loop3): read-write for sector si=
ze 4096 with page size 65536 is experimental
>>>> [  132.158228] BTRFS info (device loop3): checking UUID tree
>>>> [  133.931695] BUG: spinlock bad magic on CPU#4, swapper/4/0
>>>> [  133.932874] BUG: Unable to handle kernel data access on write at 0=
x6b6b6b6b6b6b725b
>>>
>>> That looks like some poisoned memory.
>>>
>>> I have run 128 runs of generic/095 locally on my Arm board during the =
fix,
>>> unable to reproduce the crash anymore.
>>>
>>> And this call site is even harder to get race, as in endio context, th=
e page
>>> still has PageWriteback until the last bio finished in the page.
>>>
>>> This means btrfs_releasepage() will not even try to release the page, =
while
>>> btrfs_invalidatepage() will wait the page to finish its writeback befo=
re
>>> doing anything.
>>>
>>> So this is very strange to me.
>>>
>>> Any reproducibility on your side? Or something specific to Power is re=
lated
>>> to this case? (IIRC some page flag operation is not atomic, maybe that=
 is
>>> related?)
>>
>> I doubt if this is Power related. And yes, I can reproduce the issue fa=
irly
>> easily. For now I will exclude the test from my run to get a overall ru=
n with
>
> Here, are some other failures that I noticed during testing on Power.
> Thanks for looking into this.

Thank you very much for the extra test!

>
> 1. tests/btrfs/052
> btrfs/052       [failed, exit status 1]- output mismatch (see /home/qemu=
/work-tools/xfstests/results//btrfs_4k/btrfs/052.out.bad)
>      --- tests/btrfs/052.out     2020-08-04 09:59:08.328299552 +0000
>      +++ /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/052.out.=
bad      2021-04-16 17:18:17.762928432 +0000
>      @@ -91,553 +91,5 @@
>       23 05 05 05 05 05 05 05 05 05 05 05 05 05 05 05 05
>       *
>       30
>      -0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>      -*
>      -2 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02
>      -*
>      ...
>      (Run 'diff -u /home/qemu/work-tools/xfstests/tests/btrfs/052.out /h=
ome/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/052.out.bad'  to see =
the entire diff)
>
> ^^^ this could also be due to below error found in 052.full
> 	ERROR: defrag range ioctl not supported in this kernel version, 2.6.33 =
and newer is required
> 	total 1 failures
> 	failed: '/usr/local/bin/btrfs filesystem defragment /mnt1/scratch/foo'
>
> 2. tests/btrfs/076 =3D> looks a genuine failure.
> btrfs/076       - output mismatch (see /home/qemu/work-tools/xfstests/re=
sults//btrfs_4k/btrfs/076.out.bad)
>      --- tests/btrfs/076.out     2020-08-04 09:59:08.338299786 +0000
>      +++ /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/076.out.=
bad      2021-04-16 17:19:33.344981383 +0000
>      @@ -1,3 +1,3 @@
>       QA output created by 076
>      -80
>      -80
>      +1
>      +1
>      ...
>      (Run 'diff -u /home/qemu/work-tools/xfstests/tests/btrfs/076.out /h=
ome/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/076.out.bad'  to see =
the entire diff)

This is really a compression related one. Since I hardcoded to disable
compression, the ratio is always be 1.

>
> 3. tests/btrfs/106  =3D> looks a genuine failure.
> btrfs/106       - output mismatch (see /home/qemu/work-tools/xfstests/re=
sults//btrfs_4k/btrfs/106.out.bad)
>      --- tests/btrfs/106.out     2020-08-04 09:59:08.348300020 +0000
>      +++ /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/106.out.=
bad      2021-04-16 17:49:27.296128823 +0000
>      @@ -5,19 +5,19 @@
>       File contents before unmount:
>       0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>       *
>      -40
>      +1000
>       File contents after remount:
>       0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>      ...
>      (Run 'diff -u /home/qemu/work-tools/xfstests/tests/btrfs/106.out /h=
ome/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/106.out.bad'  to see =
the entire diff)

That's a similar problem, compression needed
  while compression is hard coded to be disable, thus clone reports
different value.

>
>> these patches. Later will try and debug what is going on.
>>
>> But if you need any debug logs - do let me know, as it is fairly easily
>> reproducible.
>
> For tests/generic/095 can you pls retry reproducing the issue (with your=
 latest
> patch) on your setup with below configs enabled?
> 1. CONFIG_PAGE_OWNER, CONFIG_PAGE_POISONING, CONFIG_SLUB_DEBUG_ON,
>     CONFIG_SCHED_STACK_END_CHECK, CONFIG_DEBUG_VM, CONFIG_DEBUG_STACKOVE=
RFLOW,
>     CONFIG_DEBUG_VM_PGFLAGS, CONFIG_DEBUG_SPINLOCK, CONFIG_PROVE_LOCKING

Thanks, I'll retry using the extra debugging options.

But I have a more solid explanation on why the bug happens now.

You're right, prepare_pages() should have the page locked by calling
find_or_create_page(), so btrfs_releasepage() shouldn't sneak in and
just release the page.

But there is a small window in prepare_uptodate_page(), where we may
call btrfs_readpage(), which will unlock the page.

So there is a window where we have page unlocked, before we re-lock it
in prepare_uptodate_page().

By that, we got a page with its Private bit cleared.

I'm trying a better fix like the following diff.
But I'm not yet 100% confident if the PagePrivate() check is enough,
thus I'll do more test before sending the proper fix.

Thanks,
Qu

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 45ec3f5ef839..49f78d643392 100644
=2D-- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1341,7 +1341,17 @@ static int prepare_uptodate_page(struct inode *inod=
e,
                         unlock_page(page);
                         return -EIO;
                 }
-               if (page->mapping !=3D inode->i_mapping) {
+
+               /*
+                * Since btrfs_readpage() will get the page unlocked, we
have
+                * a window where fadvice() can try to release the page.
+                * Here we check both inode mapping and PagePrivate() to
+                * make sure the page is not released.
+                *
+                * The priavte flag check is essential for subpage as we
need
+                * to store extra bitmap using page->private.
+                */
+               if (page->mapping !=3D inode->i_mapping ||
PagePrivate(page)) {
                         unlock_page(page);
                         return -EAGAIN;
                 }


>
>
> -ritesh
>
