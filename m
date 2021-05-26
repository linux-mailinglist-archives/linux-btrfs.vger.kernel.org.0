Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA8390FFD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 07:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhEZFan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 01:30:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhEZFam (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 01:30:42 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14Q54atp095455;
        Wed, 26 May 2021 01:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0F9RvIYZIx2w6c7ChuJhLLDJTrcMhBgT1cseUFOl2ic=;
 b=hEA3r3WwGvmGzWaRmjzKS6FYWuKbAukkuHlyOwFpnd6HAlvseHXwDAXB6/d8TuubNSnK
 Wuu0+9ahwD0il/MDfoLmdjFmm6FHou/F4Uv2grsfx5CJ9BocU8+rBDY71S+qIzRA7Lxw
 QMlhZPud1BThjk5LF6J8sWw9U/RgDzls80I5/jQg8nci7lktJdEpoI1XqZ8x74BH41qn
 6PPSMKx/HfTWmxLIgUszH92A9GgcRiew/+phr/ny8pttX4+Y5MDsZzM0k8Dofr9OczSv
 K/ihCDOWD5HLKldXC49P6MIdGe4ZQCIW4Ja1Vxs12FrYrdO19fKcrSd/MtLq7LJnbBXS dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sf7b15rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 01:29:08 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14Q5FNtU128681;
        Wed, 26 May 2021 01:29:08 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38sf7b15r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 01:29:07 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14Q5T5Eo015134;
        Wed, 26 May 2021 05:29:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 38sba2r2t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 May 2021 05:29:05 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14Q5T3fW28770690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 05:29:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8015D42041;
        Wed, 26 May 2021 05:29:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AE1A4203F;
        Wed, 26 May 2021 05:29:03 +0000 (GMT)
Received: from localhost (unknown [9.85.91.152])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 May 2021 05:29:02 +0000 (GMT)
Date:   Wed, 26 May 2021 10:59:02 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <20210526052902.qsaodegp6emjg5bl@riteshh-domain>
References: <51186fd5-af02-2be6-3ba3-426082852665@suse.com>
 <20210525044307.xqfukx6qwu6mf53n@riteshh-domain>
 <ba250f72-ce16-92c0-d4b6-938776434ea2@gmx.com>
 <1a2171a5-f356-9a2e-d238-0725d3994f45@gmx.com>
 <20210525092305.3pautkpiv3dhi3oj@riteshh-domain>
 <5a3d0e6c-425b-9b6a-ffec-9243693430c5@gmx.com>
 <181af010-af18-9f78-4028-d8bb59237c05@gmx.com>
 <20210525102010.hckdsumqfil3vnsu@riteshh-domain>
 <82070e33-82f7-3a54-7620-b4a43bdaff50@gmx.com>
 <20210525130227.ldhbj4x7sryr63bk@riteshh-domain>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210525130227.ldhbj4x7sryr63bk@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pNhoLRbL3eYmnsEOOhvURrHO015WU9H9
X-Proofpoint-ORIG-GUID: cCs7BLWwQaB9mWp6jJPth-BBndu4nNRn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-26_02:2021-05-25,2021-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105260032
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/25 06:32PM, Ritesh Harjani wrote:
> On 21/05/25 07:41PM, Qu Wenruo wrote:
> >
> >
> > On 2021/5/25 下午6:20, Ritesh Harjani wrote:
> > [...]
> > > > >
> > > > > - 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-
> > > > >     bit memory addresses")
> > > > >     Will screw up at least my ARM board, which is using device tree for
> > > > >     its PCIE node.
> > > > >     Have to revert it.
> > > > >
> > > > > - 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")
> > > > >     Will screw up compressed write with striped RAID profile.
> > > > >     Fix sent to the mail list:
> > > > >
> > > > > https://patchwork.kernel.org/project/linux-btrfs/patch/20210525055243.85166-1-wqu@suse.com/
> > > > >
> > > > >
> > > > > - Known btrfs mkfs bug
> > > > >     Fix sent to the mail list:
> > > > >
> > > > > https://patchwork.kernel.org/project/linux-btrfs/patch/20210517095516.129287-1-wqu@suse.com/
> > > > >
> > > > >
> > > > > - btrfs/215 false alert
> > > > >     Fix sent to the mail list:
> > > > >
> > > > > https://patchwork.kernel.org/project/linux-btrfs/patch/20210517092922.119788-1-wqu@suse.com/
> > > >
> > > > Please wait for while.
> > > >
> > > > I just checked my latest result, the branch doesn't pass my local test
> > > > for subpage case.
> > > >
> > > > I'll fix it first, sorry for the problem.
> > >
> > > Ok, yes (it's failing for me in some test case).
> > > Sure, will until your confirmation.
> >
> > Got the reason. The patch "btrfs: allow submit_extent_page() to do bio
> > split for subpage" got a conflict when got rebased, due to zone code change.
> >
> > The conflict wasn't big, but to be extra safe, I manually re-craft the
> > patch from the scratch, to find out what's wrong.
> >
> > During that re-crafting, I forgot to delete two lines, prevent
> > btrfs_add_bio_page() from splitting bio properly, and submit empty bio,
> > thus causing an ASSERT() in submit_extent_page().
> >
> > The bug can be reliably reproduced by btrfs/060, thus that one can be a
> > quick test to make sure the problem is gone.
> >
> > BTW, for older subpage branch, the latest one without problem is at HEAD
> > 2af4eb21b234c6ddbc37568529219d33038f7f7c, which I also tested on a
> > Power8 VM, it passes "-g auto" with only 18 known failures.
> >
> > I believe it's now safe to re-test.
>
> Thanks. I will give your latest subpage github branch a run then :)

Hi Qu,

I am still running the tests, but I observed this warning msg with btrfs/062.
Sorry, did I miss any patches to take?

I am testing your below branch
https://github.com/adam900710/linux/commits/subpage

btrfs/062
<...>
[ 1466.928035] BTRFS info (device vdc): has skinny extents
[ 1466.928103] BTRFS warning (device vdc): read-write for sector size 4096 with page size 65536 is experimental
[ 1466.936997] BTRFS info (device vdc): checking UUID tree
[ 1467.295249] BTRFS info (device vdc): balance: start -d -m -s
[ 1469.177204] ------------[ cut here ]------------
[ 1469.177402] WARNING: CPU: 5 PID: 319 at fs/btrfs/extent_map.c:306 unpin_extent_cache+0x78/0x140
[ 1469.177597] Modules linked in:
[ 1469.177655] CPU: 5 PID: 319 Comm: kworker/u16:5 Not tainted 5.13.0-rc2-00382-g1d349b93923f #34
[ 1469.177773] Workqueue: btrfs-endio-write btrfs_work_helper
[ 1469.177845] NIP:  c000000000a334c8 LR: c000000000a334b4 CTR: 0000000000000000
[ 1469.177943] REGS: c00000000d7e7750 TRAP: 0700   Not tainted  (5.13.0-rc2-00382-g1d349b93923f)
[ 1469.178054] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 84002448  XER: 20000000
[ 1469.178187] CFAR: c000000000a3303c IRQMASK: 0
[ 1469.178187] GPR00: c000000000a334b4 c00000000d7e79f0 c000000001c5dc00 c00000002b15f968
[ 1469.178187] GPR04: 0000000000070000 000000000001a000 0000000000000001 0000000000000001
[ 1469.178187] GPR08: 0000000000000002 0000000000000002 0000000000000001 ffffffffffffffff
[ 1469.178187] GPR12: 0000000000002200 c00000003ffe8a00 c000000000213568 c00000000a1f1240
[ 1469.178187] GPR16: c00000002b934000 c000000026f4a2c0 c00000000d7e7ac8 0000000000000001
[ 1469.178187] GPR20: 0000000000000000 c000000026f49ec8 0000000000000024 c000000022bda000
[ 1469.178187] GPR24: 0000000000000020 000000000001a000 c000000026f49e08 000000000000000d
[ 1469.178187] GPR28: 000000000007b000 c000000026f49e88 c000000026f49e68 c00000002b15f968
[ 1469.179053] NIP [c000000000a334c8] unpin_extent_cache+0x78/0x140
[ 1469.179137] LR [c000000000a334b4] unpin_extent_cache+0x64/0x140
[ 1469.179220] Call Trace:
[ 1469.179254] [c00000000d7e79f0] [c000000000a334b4] unpin_extent_cache+0x64/0x140 (unreliable)
[ 1469.179371] [c00000000d7e7a50] [c000000000a23d28] btrfs_finish_ordered_io+0x528/0xbd0
[ 1469.179473] [c00000000d7e7ba0] [c000000000a64360] btrfs_work_helper+0x260/0x8e0
[ 1469.179572] [c00000000d7e7c40] [c000000000206954] process_one_work+0x434/0x7d0
[ 1469.179687] [c00000000d7e7d10] [c000000000206ff4] worker_thread+0x304/0x570
[ 1469.179771] [c00000000d7e7da0] [c00000000021371c] kthread+0x1bc/0x1d0
[ 1469.179855] [c00000000d7e7e10] [c00000000000d6ec] ret_from_kernel_thread+0x5c/0x70
[ 1469.179956] Instruction dump:
[ 1469.180007] 4887a5d1 60000000 7f84e378 7fc3f378 38c00001 e8a10028 4bfff949 7c7f1b79
[ 1469.180114] 41820010 e89f0018 7fa4e000 419e000c <0fe00000> 41820088 fb7f0060 395f0068
[ 1469.180222] irq event stamp: 1458062
[ 1469.180271] hardirqs last  enabled at (1458061): [<c0000000012ad654>] _raw_spin_unlock_irq+0x44/0x80
[ 1469.180411] hardirqs last disabled at (1458062): [<c0000000012a1cfc>] __schedule+0x31c/0xce0
[ 1469.180524] softirqs last  enabled at (1457908): [<c0000000012ae818>] __do_softirq+0x5e8/0x680
[ 1469.180661] softirqs last disabled at (1457899): [<c0000000001dc56c>] irq_exit+0x15c/0x1e0
[ 1469.180760] ---[ end trace f937e1c0f5a3b8fa ]---
[ 1469.537482] BTRFS info (device vdc): relocating block group 298844160 flags data|raid1
[ 1470.963925] BTRFS info (device vdc): found 343 extents, stage: move data extents
[ 1471.332749] BTRFS info (device vdc): found 341 extents, stage: update data pointers
[ 1471.656937] BTRFS info (device vdc): relocating block group 30408704 flags metadata|raid1
[ 1472.015159] BTRFS info (device vdc): found 84 extents, stage: move data extents
[ 1472.355357] BTRFS info (device vdc): relocating block group 22020096 flags system|raid1
[ 1472.689631] BTRFS info (device vdc): found 1 extents, stage: move data extents
[ 1473.052977] BTRFS info (device vdc): balance: ended with status: 0


-ritesh
