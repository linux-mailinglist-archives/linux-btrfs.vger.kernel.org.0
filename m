Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995ED362608
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Apr 2021 18:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbhDPQx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Apr 2021 12:53:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235608AbhDPQx1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Apr 2021 12:53:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GGXmt6166784;
        Fri, 16 Apr 2021 12:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=lpK9soqTg1IvUMyxeWH+mhpiY5wvvLgFIa/uTogdeqM=;
 b=dfPdRm0uQq8lCci7slW3vS6TWk6hXsav78M2DZQbt+hJ98nNigD6c1fzjYj9InbWtDQV
 Fk6aCk7KZH3FST7F+gwavuSn651vFoYipR1mmYiQOYKGmvyMpklyZni1Eqssgad4vxi6
 J/1QIwXljrIH/PJmxcP1FBcZ3ZfyGm/d+YCw9tJIQsPdV1S60px2KU4QEh6N4T0vbkby
 /jQZuCN9YhtOtXh+z0VKRx0Tqi+wsbhsdJJe0P3G2FaKtSbjjzWllKd76ytqSiG/Jgs7
 lom0LeQWZcn31p69GQplJrpF7P6yaKPNk55RUiIPoftL+46Rd9qV1/4bZBrxBqUUOvu3 /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xxnps5hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 12:52:59 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13GGXmBr166868;
        Fri, 16 Apr 2021 12:52:58 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37xxnps5gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 12:52:58 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13GGeFeC008483;
        Fri, 16 Apr 2021 16:52:56 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 37u3n8afxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 16:52:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13GGqsjM46006534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 16:52:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8817F4C046;
        Fri, 16 Apr 2021 16:52:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 293944C044;
        Fri, 16 Apr 2021 16:52:54 +0000 (GMT)
Received: from localhost (unknown [9.85.70.169])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Apr 2021 16:52:53 +0000 (GMT)
Date:   Fri, 16 Apr 2021 22:22:53 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Neal Gompa <ngompa13@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/13] btrfs: support read-write for subpage metadata
Message-ID: <20210416165253.mexotq7ixpcvcvov@riteshh-domain>
References: <20210402084652.b7a4mj2mntxu2xi5@riteshh-domain>
 <a58abc5a-ea2c-3936-4bb1-9b1c5d4e0f77@gmx.com>
 <ef2bab00-32ec-9228-9920-c44c2d166654@gmx.com>
 <20210415034444.3fg5j337ee6rvdps@riteshh-domain>
 <20210415145207.y4n3km5a2pawdeb4@riteshh-domain>
 <8bdb27e4-af63-653c-98e5-e6ffa4eee667@gmx.com>
 <08954bca-98c1-1c9c-54a8-74ba95426d7e@gmx.com>
 <c06a013e-0f7d-21f5-0bd1-9c6c22024fd8@gmx.com>
 <20210416055036.v4siyzsnmf32bx4y@riteshh-domain>
 <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5478e5e-9be4-bc32-d5e1-eaaa3f2b63a9@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W0wckjLbeXqtLD6tioSTHV0JimO4sbug
X-Proofpoint-ORIG-GUID: 2fSozW0YJue4ptX1CLGEXECtPEBFbFkh
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_08:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160119
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/16 02:14PM, Qu Wenruo wrote:
>
>
> On 2021/4/16 下午1:50, riteshh wrote:
> > On 21/04/16 09:34AM, Qu Wenruo wrote:
> > >
> > >
> > > On 2021/4/16 上午7:34, Qu Wenruo wrote:
> > > >
> > > >
> > > > On 2021/4/16 上午7:19, Qu Wenruo wrote:
> > > > >
> > > > >
> > > > > On 2021/4/15 下午10:52, riteshh wrote:
> > > > > > On 21/04/15 09:14AM, riteshh wrote:
> > > > > > > On 21/04/12 07:33PM, Qu Wenruo wrote:
> > > > > > > > Good news, you can fetch the subpage branch for better test results.
> > > > > > > >
> > > > > > > > Now the branch should pass all generic tests, except defrag and known
> > > > > > > > failures.
> > > > > > > > And no more random crash during the tests.
> > > > > > >
> > > > > > > Thanks, let me test it on PPC64 box.
> > > > > >
> > > > > > I do see some failures remaining with the patch series.
> > > > > > However the one which is blocking my testing is the tests/generic/095
> > > > > > I see kernel BUG hitting with below signature.
> > > > >
> > > > > That's pretty different from my tests.
> > > > >
> > > > > As I haven't seen such BUG_ON() for a while.
> > > > >
> > > > >
> > > > > >
> > > > > > Please let me know if this a known failure?
> > > > > >
> > > > > > <xfstests config>
> > > > > > #:~/work-tools/xfstests$ sudo ./check -g auto
> > > > > > SECTION       -- btrfs_4k
> > > > > > FSTYP         -- btrfs
> > > > > > PLATFORM      -- Linux/ppc64le qemu 5.12.0-rc7-02316-g3490dae50c0 #73
> > > > > > SMP Thu Apr 15 07:29:23 CDT 2021
> > > > > > MKFS_OPTIONS  -- -f -s 4096 -n 4096 /dev/loop3
> > > > >
> > > > > I see you're using -n 4096, not the default -n 16K, let me see if I can
> > > > > reproduce that.
> > > > >
> > > > > But from the backtrace, it doesn't look like the case,
> > > > > as it happens for data path, which means it's only related to sectorsize.
> > > > >
> > > > > > MOUNT_OPTIONS -- /dev/loop3 /mnt1/scratch
> > > > > >
> > > > > >
> > > > > > <kernel logs>
> > > > > > [ 6057.560580] BTRFS warning (device loop3): read-write for sector
> > > > > > size 4096 with page size 65536 is experimental
> > > > > > [ 6057.861383] run fstests generic/095 at 2021-04-15 14:12:10
> > > > > > [ 6058.345127] BTRFS info (device loop2): disk space caching is enabled
> > > > > > [ 6058.348910] BTRFS info (device loop2): has skinny extents
> > > > > > [ 6058.351930] BTRFS warning (device loop2): read-write for sector
> > > > > > size 4096 with page size 65536 is experimental
> > > > > > [ 6059.896382] BTRFS: device fsid 43ec9cdf-c124-4460-ad93-933bfd5ddbbd
> > > > > > devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (739641)
> > > > > > [ 6060.225107] BTRFS info (device loop3): disk space caching is enabled
> > > > > > [ 6060.226213] BTRFS info (device loop3): has skinny extents
> > > > > > [ 6060.227084] BTRFS warning (device loop3): read-write for sector
> > > > > > size 4096 with page size 65536 is experimental
> > > > > > [ 6060.234537] BTRFS info (device loop3): checking UUID tree
> > > > > > [ 6061.375902] assertion failed: PagePrivate(page) && page->private,
> > > > > > in fs/btrfs/subpage.c:171
> > > > > > [ 6061.378296] ------------[ cut here ]------------
> > > > > > [ 6061.379422] kernel BUG at fs/btrfs/ctree.h:3403!
> > > > > > cpu 0x5: Vector: 700 (Program Check) at [c0000000260d7490]
> > > > > >       pc: c000000000a9370c: assertfail.constprop.11+0x34/0x48
> > > > > >       lr: c000000000a93708: assertfail.constprop.11+0x30/0x48
> > > > > >       sp: c0000000260d7730
> > > > > >      msr: 800000000282b033
> > > > > >     current = 0xc0000000260c0080
> > > > > >     paca    = 0xc00000003fff8a00   irqmask: 0x03   irq_happened: 0x01
> > > > > >       pid   = 739712, comm = fio
> > > > > > kernel BUG at fs/btrfs/ctree.h:3403!
> > > > > > Linux version 5.12.0-rc7-02316-g3490dae50c0 (riteshh@xxxx) (gcc
> > > > > > (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu)
> > > > > > 2.30) #73 SMP Thu Apr 15 07:29:23 CDT 2021
> > > > > > enter ? for help
> > > > > > [c0000000260d7790] c000000000a90280
> > > > > > btrfs_subpage_assert.isra.9+0x70/0x110
> > > > > > [c0000000260d77b0] c000000000a91064
> > > > > > btrfs_subpage_set_uptodate+0x54/0x110
> > > > > > [c0000000260d7800] c0000000009c6d0c btrfs_dirty_pages+0x1bc/0x2c0
> > > > >
> > > > > This is very strange.
> > > > > As in btrfs_dirty_pages(), the pages passed in are already prepared by
> > > > > prepare_pages(), which means all of them should have Private set.
> > > > >
> > > > > Can you reproduce the bug reliable?
> >
> > Yes. almost reliably on my PPC box.
> >
> > > >
> > > > OK, I got it reproduced.
> > > >
> > > > It's not a reliable BUG_ON(), but can be reproduced.
> > > > The test get skipped for all my boards as it requires fio tool, thus I
> > > > didn't get it triggered for all previous runs.
> > > >
> > > > I'll take a look into the case.
> > >
> > > This exposed an interesting race window in btrfs_buffered_write():
> > >          Writer                    |             fadvice
> > > ----------------------------------+-------------------------------
> > > btrfs_buffered_write()            |
> > > |- prepare_pages()                |
> > > |  |- Now all pages involved get  |
> > > |     Private set                 |
> > > |                                 | btrfs_release_page()
> > > |                                 | |- Clear page Private
> > > |- lock_extent()                  |
> > > |  |- This would prevent          |
> > > |     btrfs_release_page() to     |
> > > |     clear the page Private      |
> > > |
> > > |- btrfs_dirty_page()
> > >     |- Will trigger the BUG_ON()
> >
> >
> > Sorry about the silly query. But help me understand how is above race possible?
> > Won't prepare_pages() will lock all the pages first. The same requirement
> > of locked page should be with btrfs_releasepage() too no?
>
> releasepage() call can easily got a page locked and release it.
>
> For call sites like btrfs_invalidatepage(), the page is already locked.
>
> btrfs_releasepage() will not to try to release the page if the extent is
> locked (any extent range inside the page has EXTENT_LOCK bit).
>
> >
> > I see only two paths which could result into btrfs_releasepage()
> > 1. one via try_to_release_pages -> releasepage()
>
> This is the race one, called from fadvice() to release pages.
>
> > 2. writeback path calling btrfs_writepage or btrfs_writepages
> > 	which may result into calling of btrfs_invalidatepage()
>
> Not this one.
>
> >
> > Although I am not sure which one this is racing with.
> >
> > >
> > > This only happens for subpage, because subpage introduces new ASSERT()
> > > to do extra check.
> > >
> > > If we want to speak strictly, regular sector size should also report
> > > this problem.
> > > But regular sector size case doesn't really care about page Private, as
> > > it just set page->private to a constant value, unlike subpage case which
> > > stores important value.
> > >
> > > The fix will just re-set page Private and needed structures in
> > > btrfs_dirty_page(), under extent locked so no btrfs_releasepage() is
> > > able to release it anymore.
> >
> > With above fix I see a different issue with below signature.
> >
> > [  130.272410] BTRFS warning (device loop2): read-write for sector size 4096 with page size 65536 is experimental
> > [  130.387470] run fstests generic/095 at 2021-04-16 05:04:09
> > [  132.042532] BTRFS: device fsid 642daee0-165a-4271-b6f3-728f215c5348 devid 1 transid 5 /dev/loop3 scanned by mkfs.btrfs (5226)
> > [  132.146892] BTRFS info (device loop3): disk space caching is enabled
> > [  132.147831] BTRFS info (device loop3): has skinny extents
> > [  132.148491] BTRFS warning (device loop3): read-write for sector size 4096 with page size 65536 is experimental
> > [  132.158228] BTRFS info (device loop3): checking UUID tree
> > [  133.931695] BUG: spinlock bad magic on CPU#4, swapper/4/0
> > [  133.932874] BUG: Unable to handle kernel data access on write at 0x6b6b6b6b6b6b725b
>
> That looks like some poisoned memory.
>
> I have run 128 runs of generic/095 locally on my Arm board during the fix,
> unable to reproduce the crash anymore.
>
> And this call site is even harder to get race, as in endio context, the page
> still has PageWriteback until the last bio finished in the page.
>
> This means btrfs_releasepage() will not even try to release the page, while
> btrfs_invalidatepage() will wait the page to finish its writeback before
> doing anything.
>
> So this is very strange to me.
>
> Any reproducibility on your side? Or something specific to Power is related
> to this case? (IIRC some page flag operation is not atomic, maybe that is
> related?)

I doubt if this is Power related. And yes, I can reproduce the issue fairly
easily. For now I will exclude the test from my run to get a overall run with
these patches. Later will try and debug what is going on.

But if you need any debug logs - do let me know, as it is fairly easily
reproducible.

-ritesh

>
> Thanks,
> Qu
> > [  133.934432] Faulting instruction address: 0xc000000000283654
> > cpu 0x4: Vector: 380 (Data SLB Access) at [c000000007937160]
> >      pc: c000000000283654: spin_dump+0x70/0xbc
> >      lr: c000000000283638: spin_dump+0x54/0xbc
> >      sp: c000000007937400
> >     msr: 8000000000001033
> >     dar: 6b6b6b6b6b6b725b
> >    current = 0xc000000007913300
> >    paca    = 0xc00000003fff9c00   irqmask: 0x03   irq_happened: 0x05
> >      pid   = 0, comm = swapper/4
> > Linux version 5.12.0-rc7-02317-g61d9ec0f765 (riteshh@ltctulc6a-p1) (gcc (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #74 SMP Thu Apr 15 23:52:56 CDT 2021
> > enter ? for help
> > [c000000007937470] c000000000283078 do_raw_spin_unlock+0x88/0x230
> > [c0000000079374a0] c0000000012b1e14 _raw_spin_unlock_irqrestore+0x44/0x90
> > [c0000000079374d0] c000000000a918dc btrfs_subpage_clear_writeback+0xac/0xe0
> > [c000000007937530] c0000000009e0458 end_bio_extent_writepage+0x158/0x270
> > [c0000000079375f0] c000000000b6fd14 bio_endio+0x254/0x270
> > [c000000007937630] c0000000009fc0f0 btrfs_end_bio+0x1a0/0x200
> > [c000000007937670] c000000000b6fd14 bio_endio+0x254/0x270
> > [c0000000079376b0] c000000000b781fc blk_update_request+0x46c/0x670
> > [c000000007937760] c000000000b8b394 blk_mq_end_request+0x34/0x1d0
> > [c0000000079377a0] c000000000d82d1c lo_complete_rq+0x11c/0x140
> > [c0000000079377d0] c000000000b880a4 blk_complete_reqs+0x84/0xb0
> > [c000000007937800] c0000000012b2ca4 __do_softirq+0x334/0x680
> > [c000000007937910] c0000000001dd878 irq_exit+0x148/0x1d0
> > [c000000007937940] c000000000016f4c do_IRQ+0x20c/0x240
> > [c0000000079379d0] c000000000009240 hardware_interrupt_common_virt+0x1b0/0x1c0
> >
> >
> >
> >
> > >
> > > The fix is already added to the github branch.
> > > Now it has the fix as the HEAD.
> > >
> > > I hope this won't damage your confidence on the patchset.
> > >
> > > Thanks for the report!
> > > Qu
> > >
> > > >
> > > > Thanks for the report,
> > > > Qu
> > > > >
> > > > > BTW, are using running the latest branch, with this commit at top?
> >
> > Yes. Below branch.
> > https://github.com/adam900710/linux/commits/subpage
> >
> > -ritesh
> >
> > > > >
> > > > > commit 3490dae50c01cec04364e5288f43ae9ac9eca2c9
> > > > > Author: Qu Wenruo <wqu@suse.com>
> > > > > Date:   Mon Feb 22 14:19:38 2021 +0800
> > > > >
> > > > >      btrfs: allow read-write for 4K sectorsize on 64K page sizesystems
> > > > >
> > > > > As I was updating the patchset until the last minute.
> > > > >
> > > > > Thanks,
> > > > > Qu
> > > > >
> > > > > > [c0000000260d7880] c0000000009c7298 btrfs_buffered_write+0x488/0x7f0
> > > > > > [c0000000260d79d0] c0000000009cbeb4 btrfs_file_write_iter+0x314/0x520
> > > > > > [c0000000260d7a50] c00000000055fd84 do_iter_readv_writev+0x1b4/0x260
> > > > > > [c0000000260d7ac0] c00000000056114c do_iter_write+0xdc/0x2c0
> > > > > > [c0000000260d7b10] c0000000005c2d2c iter_file_splice_write+0x2ec/0x510
> > > > > > [c0000000260d7c30] c0000000005c1ba0 do_splice_from+0x50/0x70
> > > > > > [c0000000260d7c50] c0000000005c37e8 do_splice+0x5a8/0x910
> > > > > > [c0000000260d7cd0] c0000000005c3ce0 sys_splice+0x190/0x300
> > > > > > [c0000000260d7d60] c000000000039ba4 system_call_exception+0x384/0x3d0
> > > > > > [c0000000260d7e10] c00000000000d45c system_call_common+0xec/0x278
> > > > > > --- Exception: c00 (System Call) at 00007ffff72ef170
> > > > > >
> > > > > >
> > > > > > -ritesh
> > > > > >
> >
>
