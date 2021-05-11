Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157437A4EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 May 2021 12:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhEKKtZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 May 2021 06:49:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25154 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229892AbhEKKtY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 May 2021 06:49:24 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BAX89S094454;
        Tue, 11 May 2021 06:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=pXIXJPdDKei7M9kvwJmdoxin34cc2/11+8m7D0SUJEM=;
 b=gXIm6/fAqKX67kvGcPTEq7dW5jfPN6qOKv4gF7Uv97aNYA124ro5xC7c8wS6xNjQLaNJ
 dXtIveTRQHWe99/cpYrGvkqHPDpZt3P+XEBmXLEW4lKQHQpGE8aKt5f2r6YOx9ouhEO8
 MOtoa+XvpJPmYmW1Q+ZXHNiKh61bE96ANsAOIK8ZDEpzYNXyTh92gMDAyjrN8GXZaiS+
 R6UkF9l+DTgUXQmKAHDXMJhN44qK9pyDnnTF+mePiI8wFGE0119pK6mmkuTLb3BVZkWP
 ZI3cgpVtDr7+K36t/Jh+XeNe9ZW8/175I94HJQm1J0tsmDbkH4XTlKfo8rpN1iNcZ3y1 FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fr70rhx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 06:48:15 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14BAXBrX094870;
        Tue, 11 May 2021 06:48:15 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fr70rhwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 06:48:15 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BAfrtj015983;
        Tue, 11 May 2021 10:48:13 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj989m46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 10:48:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BAmAos31392160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 10:48:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF581AE055;
        Tue, 11 May 2021 10:48:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 673F3AE051;
        Tue, 11 May 2021 10:48:10 +0000 (GMT)
Received: from localhost (unknown [9.85.107.233])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 May 2021 10:48:10 +0000 (GMT)
Date:   Tue, 11 May 2021 16:18:09 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <20210511104809.evndsdckwhmonyyl@riteshh-domain>
References: <20210427230349.369603-1-wqu@suse.com>
 <20210427230349.369603-42-wqu@suse.com>
 <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
 <20210507045735.jjtc76whburjmnvt@riteshh-domain>
 <5d406b40-23d9-8542-792a-2cd6a7d95afe@gmx.com>
 <e7e6ebdd-a220-e4ec-64e4-d031d7a9b181@gmx.com>
 <20210510122933.mcg2sac2ugdennbs@riteshh-domain>
 <95d7bc8a-5593-cc71-aee3-349dd6fd060d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95d7bc8a-5593-cc71-aee3-349dd6fd060d@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZUIq7drPPchuEuQSPso3YDzlnq5aMm7c
X-Proofpoint-ORIG-GUID: sOD34Ap9joSS2l6Ba7ukO9ZmHjoDfjuz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110080
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/10 09:10PM, Qu Wenruo wrote:
>
>
> On 2021/5/10 下午8:29, Ritesh Harjani wrote:
> > On 21/05/10 04:38PM, Qu Wenruo wrote:
> > > Hi Ritesh,
> > >
> > > I guess no error report so far is a good thing?
> > Sorry about the delay in starting of my testing. Was not keeping well since
> > Friday onwards, hence could not start the testing. (Feeling much better now).
> >
> > So -g quick passed w/o any fatal issues. But with -g auto I got a kernel bug
> > with btrfs/28. Below is the report.
> >
> > >
> > > Just to report what my result is, I ran my latest github branch for the
> > > full weekend, over 50 hours, and around 20 runs of full generic/auto
> > > without defrag groups.
> > >
> > > And I see no crash at all.
> > >
> > > But there is a special note, there is a new patch, introduced just
> > > before the weekend (Fri May 7 09:31:43 2021 +0800), titled "btrfs: fix a
> > > possible use-after-free race in metadata read path", is a new fix for a
> > > bug I reproduced once locally.
> >
> > Yes,  I already have this in my tree. This is the latest patch in my tree which
> > I am testing.
> > "btrfs: remove io_failure_record::in_validation"
> >
> > >
> > > The bug should only happen when read is slow and only happens for
> > > metadata read path.
> > >
> > > The details can be found in the commit message, although it's rare to
> > > hit, I have hit such problem around 3 times in total.
> > >
> > > Hopes you didn't hit any crash during your test.
> >
> > I am hitting below bug_on(). Since I saw your email just now, so I am directly
> > reporting this failure, w/o analyzing. Please let me know if you need anything
> > else from my end for this.
> >
> > I will halt the testing of "-g auto" for now. Once we have some conclusion on
> > this one, then will resume the testing.
>
> Thanks for the reporting, I was still just looping generic tests, thus
> didn't yet start testing the btrfs tests.
>
> But considering no new crash in generic tests, I guess it's time to move
> forward.
>
> >
> > btrfs/028 32s ... 	[10:41:18][  780.104573] run fstests btrfs/028 at 2021-05-10 10:41:18
> >
> > [  780.732073] BTRFS: device fsid be9b827d-28ee-4a5e-80a0-e19971061a58 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (21129)
> > [  780.759754] BTRFS info (device vdc): disk space caching is enabled
> > [  780.759848] BTRFS info (device vdc): has skinny extents
> > [  780.759888] BTRFS warning (device vdc): read-write for sector size 4096 with page size 65536 is experimental
> > <...>
> > [  784.580404] BTRFS info (device vdc): found 21 extents, stage: move data extents
> > [  784.878376] BTRFS info (device vdc): found 13 extents, stage: update data pointers
> > [  785.175349] BTRFS info (device vdc): balance: ended with status: 0
> > [  785.367729] BTRFS info (device vdc): balance: start -d
> > [  785.400884] BTRFS info (device vdc): relocating block group 2446327808 flags data
> > [  785.527858] btrfs_print_data_csum_error: 18 callbacks suppressed
> > [  785.527865] BTRFS warning (device vdc): csum failed root -9 ino 262 off 393216 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
>
> Checking the test case btrfs/028, it shouldn't have any error when
> relocating the block groups, thus it's definitely something wrong in the
> balance code.
>
> Thanks for the report, I'll give you an update after finishing the local
> btrfs test groups.
>
> Thanks for your confirmation, really helps a lot!

Hi Qu,

FYI - I re-tested "-g auto" with btrfs/028 test excluded. I didn't find any
other failure. Please let me know once you have a fix for btrfs/028, I can
re-test the whole tree again.

Thanks
ritesh


> Qu
>
> > [  785.528406] btrfs_dev_stat_print_on_error: 18 callbacks suppressed
> > [  785.528409] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> > [  785.528857] BTRFS warning (device vdc): csum failed root -9 ino 262 off 397312 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
> > [  785.529166] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0, flush 0, corrupt 2, gen 0
> > [  785.529412] BTRFS warning (device vdc): csum failed root -9 ino 262 off 401408 csum 0x8941f998 expected csum 0x667b7e1e mirror 1
> > [  785.529714] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0, flush 0, corrupt 3, gen 0
> > [  785.530321] BTRFS warning (device vdc): csum failed root -9 ino 262 off 393216 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
> > [  785.530637] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> > [  785.530882] BTRFS warning (device vdc): csum failed root -9 ino 262 off 397312 csum 0x8941f998 expected csum 0x9439dda4 mirror 1
> > [  785.531185] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0, flush 0, corrupt 5, gen 0
> > [  785.531428] BTRFS warning (device vdc): csum failed root -9 ino 262 off 401408 csum 0x8941f998 expected csum 0x667b7e1e mirror 1
> > [  785.531719] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0, flush 0, corrupt 6, gen 0
> > <...>
> > [  803.459877] BTRFS info (device vdc): relocating block group 10499391488 flags data
> > [  803.776810] BTRFS info (device vdc): found 29 extents, stage: move data extents
> > [  803.979572] BTRFS info (device vdc): found 18 extents, stage: update data pointers
> > [  804.276370] BTRFS info (device vdc): balance: ended with status: 0
> > [  804.427621] BTRFS info (device vdc): balance: start -d
> > [  804.454527] BTRFS info (device vdc): relocating block group 11036262400 flags data
> > [  804.623962] BTRFS warning (device vdc): csum failed root -9 ino 282 off 684032 csum 0x8941f998 expected csum 0x605aaa22 mirror 1
> > [  804.624147] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0, flush 0, corrupt 15, gen 0
> > [  804.624277] BTRFS warning (device vdc): csum failed root -9 ino 282 off 688128 csum 0x8941f998 expected csum 0xe90a7889 mirror 1
> > [  804.624435] BTRFS error (device vdc): bdev /dev/vdc errs: wr 0, rd 0, flush 0, corrupt 16, gen 0
> > [  804.624682] assertion failed: atomic_read(&subpage->readers) >= nbits, in fs/btrfs/subpage.c:203
> > [  804.624902] ------------[ cut here ]------------
> > [  804.624989] kernel BUG at fs/btrfs/ctree.h:3415!
> > cpu 0x1: Vector: 700 (Program Check) at [c000000007b47640]
> >      pc: c000000000af297c: assertfail.constprop.11+0x34/0x38
> >      lr: c000000000af2978: assertfail.constprop.11+0x30/0x38
> >      sp: c000000007b478e0
> >     msr: 800000000282b033
> >    current = 0xc000000007999800
> >    paca    = 0xc00000003fffee00	 irqmask: 0x03	 irq_happened: 0x01
> >      pid   = 23, comm = kworker/u4:1
> > kernel BUG at fs/btrfs/ctree.h:3415!
> > Linux version 5.12.0-rc8-00160-gcd0da6627caa (root@ltctulc6a-p1) (gcc (Ubuntu 8.4.0-1ubuntu1~18.04) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.30) #25 SMP Mon May 10 01:31:44 CDT 2021
> > enter ? for help
> > [c000000007b47940] c000000000aefdac btrfs_subpage_end_reader+0x5c/0xb0
> > [c000000007b47980] c000000000a379f0 end_page_read+0x1d0/0x200
> > [c000000007b479c0] c000000000a41554 end_bio_extent_readpage+0x784/0x9b0
> > [c000000007b47b30] c000000000b4a234 bio_endio+0x254/0x270
> > [c000000007b47b70] c0000000009f6178 end_workqueue_fn+0x48/0x80
> > [c000000007b47ba0] c000000000a5c960 btrfs_work_helper+0x260/0x8e0
> > [c000000007b47c40] c00000000020a7f4 process_one_work+0x434/0x7d0
> > [c000000007b47d10] c00000000020ae94 worker_thread+0x304/0x570
> > [c000000007b47da0] c0000000002173cc kthread+0x1bc/0x1d0
> > [c000000007b47e10] c00000000000d6ec ret_from_kernel_thread+0x5c/0x70
> >
> > -ritesh
> >
