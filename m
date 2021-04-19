Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C9F363B2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 07:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhDSGAD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 02:00:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46004 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhDSF7y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 01:59:54 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13J5Wmk8079275;
        Mon, 19 Apr 2021 01:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=ewNWYUzllVvHCfL8h0yaTE1ZJckkiyZpGrqgP2LEvDs=;
 b=helAjo/+hDK3UVqgsYF83CBt0kvFDw72a3FFbxRNF8QKo9JjAMkRDLiqM+BZBNaQKAJz
 fnv6nO4Kk6WMso20TNDrSzwPOZPtYvWQlYpxClnQeDoXK6HqLfluWwjmcu5mXEr+8oyS
 CJMtYRsMZWcNVNZIZ6BFDHCrxV729FQa+RSnbsyWrpakmIPuDq/S6CmgpS1cc0QUm2FK
 CCdbO4v2F0ds6UZ+jsDjssu3ZSNTaT+RC5bx8UmeaKaP0PcmitSY/NYll4lLG2hgpDb/
 HZ/dQ/mki4gh9VbdYRSiTs1RlN3/e/8AIhQyazl23LOojoKOklOtvWt8VRJlKOuFY26Y OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380cwxd2ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 01:59:21 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13J5nJbQ126663;
        Mon, 19 Apr 2021 01:59:21 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 380cwxd2k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 01:59:20 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13J5rkYi024964;
        Mon, 19 Apr 2021 05:59:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 37yqa8gujv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 05:59:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13J5xG0933554802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 05:59:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 534D5A4060;
        Mon, 19 Apr 2021 05:59:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F305EA4054;
        Mon, 19 Apr 2021 05:59:15 +0000 (GMT)
Received: from localhost (unknown [9.85.71.45])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Apr 2021 05:59:15 +0000 (GMT)
Date:   Mon, 19 Apr 2021 11:29:15 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210419055915.valqohgrgrdy4pvf@riteshh-domain>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RcqCgKS_iS2re50a4nn5nnJxVi2jEKNS
X-Proofpoint-GUID: 25qO_mSy6zPV_pCaBJ0bNN0X2EYuxGot
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_02:2021-04-16,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190037
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/16 10:22PM, riteshh wrote:
> On 21/04/16 02:14PM, Qu Wenruo wrote:
> >
> >
> > On 2021/4/16 下午1:50, riteshh wrote:
> > > On 21/04/16 09:34AM, Qu Wenruo wrote:
> > > >
> > > >
> > > > On 2021/4/16 上午7:34, Qu Wenruo wrote:
> > > > >
> > > > >
> > > > > On 2021/4/16 上午7:19, Qu Wenruo wrote:
> > > > > >
> > > > > >
> > > > > > On 2021/4/15 下午10:52, riteshh wrote:
> > > > > > > On 21/04/15 09:14AM, riteshh wrote:
> > > > > > > > On 21/04/12 07:33PM, Qu Wenruo wrote:
> > > > > > > > > Good news, you can fetch the subpage branch for better test results.
> > > > > > > > >
> > > > > > > > > Now the branch should pass all generic tests, except defrag and known
> > > > > > > > > failures.
> > > > > > > > > And no more random crash during the tests.
> > > > > > > >
> > > > > > > > Thanks, let me test it on PPC64 box.
> > > > > > >
> > > > > > > I do see some failures remaining with the patch series.
> > > > > > > However the one which is blocking my testing is the tests/generic/095
> > > > > > > I see kernel BUG hitting with below signature.
> > > > > >
> > > > > > That's pretty different from my tests.
> > > > > >
> > > > > > As I haven't seen such BUG_ON() for a while.
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Please let me know if this a known failure?
> > > > > > >
> > > > > > > <xfstests config>
> > > > > > > #:~/work-tools/xfstests$ sudo ./check -g auto
> > > > > > > SECTION       -- btrfs_4k
> > > > > > > FSTYP         -- btrfs
> > > > > > > PLATFORM      -- Linux/ppc64le qemu 5.12.0-rc7-02316-g3490dae50c0 #73
> > > > > > > SMP Thu Apr 15 07:29:23 CDT 2021
> > > > > > > MKFS_OPTIONS  -- -f -s 4096 -n 4096 /dev/loop3
> > > > > >
> > > > > > I see you're using -n 4096, not the default -n 16K, let me see if I can
> > > > > > reproduce that.
> > > > > >
> > > > > > But from the backtrace, it doesn't look like the case,
> > > > > > as it happens for data path, which means it's only related to sectorsize.
> > > > > >
> > > > > > > MOUNT_OPTIONS -- /dev/loop3 /mnt1/scratch
> > > > > > >
> > > > > > >
> > > > > > > <kernel logs>
> > > > > > > [ 6057.560580] BTRFS warning (device loop3): read-write for sector
> > > > > > > size 4096 with page size 65536 is experimental
> > > > > > > [ 6057.861383] run fstests generic/095 at 2021-04-15 14:12:10
> > > > > > > [ 6058.345127] BTRFS info (device loop2): disk space caching is enabled
> > > > > > > [ 6058.348910] BTRFS info (device loop2): has skinny extents
> > > > > > > [ 6058.351930] BTRFS warning (device loop2): read-write for sector
> > > > > > > size 4096 with page size 65536 is experimental
> > > > > > > [ 6059.896382] BTRFS: device fsid 43ec9cdf-c124-4460-ad93-933bfd5ddbbd
> > > > > > > devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (739641)
> > > > > > > [ 6060.225107] BTRFS info (device loop3): disk space caching is enabled
> > > > > > > [ 6060.226213] BTRFS info (device loop3): has skinny extents
> > > > > > > [ 6060.227084] BTRFS warning (device loop3): read-write for sector
> > > > > > > size 4096 with page size 65536 is experimental
> > > > > > > [ 6060.234537] BTRFS info (device loop3): checking UUID tree
> > > > > > > [ 6061.375902] assertion failed: PagePrivate(page) && page->private,
> > > > > > > in fs/btrfs/subpage.c:171
> > > > > > > [ 6061.378296] ------------[ cut here ]------------
> > > > > > > [ 6061.379422] kernel BUG at fs/btrfs/ctree.h:3403!
> > > > > > > cpu 0x5: Vector: 700 (Program Check) at [c0000000260d7490]
> > > > > > >       pc: c000000000a9370c: assertfail.constprop.11+0x34/0x48
> > > > > > >       lr: c000000000a93708: assertfail.constprop.11+0x30/0x48
> > > > > > >       sp: c0000000260d7730
> > > > > > >      msr: 800000000282b033
> > > > > > >     current = 0xc0000000260c0080
> > > > > > >     paca    = 0xc00000003fff8a00   irqmask: 0x03   irq_happened: 0x01
> > > > > > >       pid   = 739712, comm = fio
> > > > > > > kernel BUG at fs/btrfs/ctree.h:3403!
> > > > > > > Linux version 5.12.0-rc7-02316-g3490dae50c0 (riteshh@xxxx) (gcc
> > > > > > > (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu)
> > > > > > > 2.30) #73 SMP Thu Apr 15 07:29:23 CDT 2021
> > > > > > > enter ? for help
> > > > > > > [c0000000260d7790] c000000000a90280
> > > > > > > btrfs_subpage_assert.isra.9+0x70/0x110
> > > > > > > [c0000000260d77b0] c000000000a91064
> > > > > > > btrfs_subpage_set_uptodate+0x54/0x110
> > > > > > > [c0000000260d7800] c0000000009c6d0c btrfs_dirty_pages+0x1bc/0x2c0
> > > > > >
> > > > > > This is very strange.
> > > > > > As in btrfs_dirty_pages(), the pages passed in are already prepared by
> > > > > > prepare_pages(), which means all of them should have Private set.
> > > > > >
> > > > > > Can you reproduce the bug reliable?
> > >
> > > Yes. almost reliably on my PPC box.
> > >
> > > > >
> > > > > OK, I got it reproduced.
> > > > >
> > > > > It's not a reliable BUG_ON(), but can be reproduced.
> > > > > The test get skipped for all my boards as it requires fio tool, thus I
> > > > > didn't get it triggered for all previous runs.
> > > > >
> > > > > I'll take a look into the case.
> > > >
> > > > This exposed an interesting race window in btrfs_buffered_write():
> > > >          Writer                    |             fadvice
> > > > ----------------------------------+-------------------------------
> > > > btrfs_buffered_write()            |
> > > > |- prepare_pages()                |
> > > > |  |- Now all pages involved get  |
> > > > |     Private set                 |
> > > > |                                 | btrfs_release_page()
> > > > |                                 | |- Clear page Private
> > > > |- lock_extent()                  |
> > > > |  |- This would prevent          |
> > > > |     btrfs_release_page() to     |
> > > > |     clear the page Private      |
> > > > |
> > > > |- btrfs_dirty_page()
> > > >     |- Will trigger the BUG_ON()
> > >
> > >
> > > Sorry about the silly query. But help me understand how is above race possible?
> > > Won't prepare_pages() will lock all the pages first. The same requirement
> > > of locked page should be with btrfs_releasepage() too no?
> >
> > releasepage() call can easily got a page locked and release it.
> >
> > For call sites like btrfs_invalidatepage(), the page is already locked.
> >
> > btrfs_releasepage() will not to try to release the page if the extent is
> > locked (any extent range inside the page has EXTENT_LOCK bit).
> >
> > >
> > > I see only two paths which could result into btrfs_releasepage()
> > > 1. one via try_to_release_pages -> releasepage()
> >
> > This is the race one, called from fadvice() to release pages.
> >
> > > 2. writeback path calling btrfs_writepage or btrfs_writepages
> > > 	which may result into calling of btrfs_invalidatepage()
> >
> > Not this one.
> >
> > >
> > > Although I am not sure which one this is racing with.
> > >
> > > >
> > > > This only happens for subpage, because subpage introduces new ASSERT()
> > > > to do extra check.
> > > >
> > > > If we want to speak strictly, regular sector size should also report
> > > > this problem.
> > > > But regular sector size case doesn't really care about page Private, as
> > > > it just set page->private to a constant value, unlike subpage case which
> > > > stores important value.
> > > >
> > > > The fix will just re-set page Private and needed structures in
> > > > btrfs_dirty_page(), under extent locked so no btrfs_releasepage() is
> > > > able to release it anymore.
> > >
> > > With above fix I see a different issue with below signature.
> > >
> > > [  130.272410] BTRFS warning (device loop2): read-write for sector size 4096 with page size 65536 is experimental
> > > [  130.387470] run fstests generic/095 at 2021-04-16 05:04:09
> > > [  132.042532] BTRFS: device fsid 642daee0-165a-4271-b6f3-728f215c5348 devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (5226)
> > > [  132.146892] BTRFS info (device loop3): disk space caching is enabled
> > > [  132.147831] BTRFS info (device loop3): has skinny extents
> > > [  132.148491] BTRFS warning (device loop3): read-write for sector size 4096 with page size 65536 is experimental
> > > [  132.158228] BTRFS info (device loop3): checking UUID tree
> > > [  133.931695] BUG: spinlock bad magic on CPU#4, swapper/4/0
> > > [  133.932874] BUG: Unable to handle kernel data access on write at 0x6b6b6b6b6b6b725b
> >
> > That looks like some poisoned memory.
> >
> > I have run 128 runs of generic/095 locally on my Arm board during the fix,
> > unable to reproduce the crash anymore.
> >
> > And this call site is even harder to get race, as in endio context, the page
> > still has PageWriteback until the last bio finished in the page.
> >
> > This means btrfs_releasepage() will not even try to release the page, while
> > btrfs_invalidatepage() will wait the page to finish its writeback before
> > doing anything.
> >
> > So this is very strange to me.
> >
> > Any reproducibility on your side? Or something specific to Power is related
> > to this case? (IIRC some page flag operation is not atomic, maybe that is
> > related?)
>
> I doubt if this is Power related. And yes, I can reproduce the issue fairly
> easily. For now I will exclude the test from my run to get a overall run with

Here, are some other failures that I noticed during testing on Power.
Thanks for looking into this.

1. tests/btrfs/052
btrfs/052       [failed, exit status 1]- output mismatch (see /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/052.out.bad)
    --- tests/btrfs/052.out     2020-08-04 09:59:08.328299552 +0000
    +++ /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/052.out.bad      2021-04-16 17:18:17.762928432 +0000
    @@ -91,553 +91,5 @@
     23 05 05 05 05 05 05 05 05 05 05 05 05 05 05 05 05
     *
     30
    -0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
    -*
    -2 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02 02
    -*
    ...
    (Run 'diff -u /home/qemu/work-tools/xfstests/tests/btrfs/052.out /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/052.out.bad'  to see the entire diff)

^^^ this could also be due to below error found in 052.full
	ERROR: defrag range ioctl not supported in this kernel version, 2.6.33 and newer is required
	total 1 failures
	failed: '/usr/local/bin/btrfs filesystem defragment /mnt1/scratch/foo'

2. tests/btrfs/076 => looks a genuine failure.
btrfs/076       - output mismatch (see /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/076.out.bad)
    --- tests/btrfs/076.out     2020-08-04 09:59:08.338299786 +0000
    +++ /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/076.out.bad      2021-04-16 17:19:33.344981383 +0000
    @@ -1,3 +1,3 @@
     QA output created by 076
    -80
    -80
    +1
    +1
    ...
    (Run 'diff -u /home/qemu/work-tools/xfstests/tests/btrfs/076.out /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/076.out.bad'  to see the entire diff)

3. tests/btrfs/106  => looks a genuine failure.
btrfs/106       - output mismatch (see /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/106.out.bad)
    --- tests/btrfs/106.out     2020-08-04 09:59:08.348300020 +0000
    +++ /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/106.out.bad      2021-04-16 17:49:27.296128823 +0000
    @@ -5,19 +5,19 @@
     File contents before unmount:
     0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
     *
    -40
    +1000
     File contents after remount:
     0 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
    ...
    (Run 'diff -u /home/qemu/work-tools/xfstests/tests/btrfs/106.out /home/qemu/work-tools/xfstests/results//btrfs_4k/btrfs/106.out.bad'  to see the entire diff)

> these patches. Later will try and debug what is going on.
>
> But if you need any debug logs - do let me know, as it is fairly easily
> reproducible.

For tests/generic/095 can you pls retry reproducing the issue (with your latest
patch) on your setup with below configs enabled?
1. CONFIG_PAGE_OWNER, CONFIG_PAGE_POISONING, CONFIG_SLUB_DEBUG_ON,
   CONFIG_SCHED_STACK_END_CHECK, CONFIG_DEBUG_VM, CONFIG_DEBUG_STACKOVERFLOW,
   CONFIG_DEBUG_VM_PGFLAGS, CONFIG_DEBUG_SPINLOCK, CONFIG_PROVE_LOCKING


-ritesh
