Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AB837FB8D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhEMQek (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 12:34:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233953AbhEMQeg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 12:34:36 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14DGXHd7044690;
        Thu, 13 May 2021 12:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=UTB8HLORDQgsJd225NISmOta8RDH1+6T/j7eTMhV+Ok=;
 b=FvdgPhHFViYbZt/jW+6u9tSAluNfMlp3Dr385iQJHqigIxqxCFUZNa3FT9vu/HLmgtW0
 4ECBeS+EbBb2HmNVQ3e77159ypnphALaUCgVt2z9UrMSWQBxdqz3u3c2PduLM8aqwmHh
 dfbkt32m+jeRwaBiIevxV6fE7OinGX3pmE2gQsCTws8oNNSOrntatuHTTxyygFF6AvD3
 datUfAXHynbYlmE2Y76IT1Xut8A5x9Q33++NhvcWq4ifmWHYuFwqosCrcwF5zTnh6tHD
 du40tYchbTKiFiowpTub15P9GZg9RTELEbTeI3w4geIz32OHspt5L7t94zhynbe+iUAc 0Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38h7nx82nm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 12:33:22 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14DGXLgR045107;
        Thu, 13 May 2021 12:33:21 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38h7nx82m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 12:33:21 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14DGXKsc020254;
        Thu, 13 May 2021 16:33:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 38dj98at6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 May 2021 16:33:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14DGXH6P33685956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 16:33:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B747FA4054;
        Thu, 13 May 2021 16:33:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64696A405B;
        Thu, 13 May 2021 16:33:17 +0000 (GMT)
Received: from localhost (unknown [9.77.196.130])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 May 2021 16:33:17 +0000 (GMT)
Date:   Thu, 13 May 2021 22:03:16 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [Patch v2 41/42] btrfs: fix the use-after-free bug in writeback
 subpage helper
Message-ID: <20210513163316.ypvh3ppsrmxg7dit@riteshh-domain>
References: <46a8cbb7-4c3a-024d-4ee3-cbeb4068e92e@suse.com>
 <20210507045735.jjtc76whburjmnvt@riteshh-domain>
 <5d406b40-23d9-8542-792a-2cd6a7d95afe@gmx.com>
 <e7e6ebdd-a220-e4ec-64e4-d031d7a9b181@gmx.com>
 <20210510122933.mcg2sac2ugdennbs@riteshh-domain>
 <95d7bc8a-5593-cc71-aee3-349dd6fd060d@gmx.com>
 <20210511104809.evndsdckwhmonyyl@riteshh-domain>
 <334a5fdd-28ee-4163-456c-adc4b2276d08@gmx.com>
 <fae358ed-8d14-8e14-2dc3-173637ec5e87@gmx.com>
 <20210512070931.p5hipe3ov45vqzjt@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512070931.p5hipe3ov45vqzjt@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZMrLPNR02lbNN4cTZZsyXQYxy0GiWFXF
X-Proofpoint-GUID: _do_yy7I9VAG0VPtWjBPmo-f7D7jPmZD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_10:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130115
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/12 12:39PM, Ritesh Harjani wrote:
> On 21/05/12 09:49AM, Qu Wenruo wrote:
> > Hi Ritesh,
> >
> > The patchset gets updated, and I am already running the tests, so far so
> > good.
> Sure, I have started the testing. Will update the results for both
> 4k, 64k configs with "-g quick", "-g auto" options on PPC64.

Hi Qu,

I completed the testing of "4k" and "64k" configs with "-g quick" and "-g auto"
groups on ppc64 machine. There were no crashes nor any related failures with
your latest patch series. Also thanks a lot for getting this patch series ready
and fixing all the reported failures :)

Let me also know if you would like to me to test anything else too, will be
happy to help. Feel free below tag for your full patch series:-

Tested-by: Ritesh Harjani <riteshh@linux.ibm.com> 	[ppc64]


FYI, I found this below lockdep warning from btrfs/112 with 64k config.
This may not be related to your patch series though. But I thought I will report
it to here anyways.

[  756.021743] run fstests btrfs/112 at 2021-05-13 03:27:39
[  756.554974] BTRFS info (device vdd): disk space caching is enabled
[  756.555223] BTRFS info (device vdd): has skinny extents
[  757.062425] BTRFS: device fsid 453f3a16-65f2-4406-b666-1cb096966ad5 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (29656)
[  757.111042] BTRFS info (device vdc): disk space caching is enabled
[  757.111309] BTRFS info (device vdc): has skinny extents
[  757.121898] BTRFS info (device vdc): checking UUID tree

[  757.373434] ======================================================
[  757.373557] WARNING: possible circular locking dependency detected
[  757.373670] 5.12.0-rc8-00161-g71a7ca634d59 #26 Not tainted
[  757.373751] ------------------------------------------------------
[  757.373851] cloner/29747 is trying to acquire lock:
[  757.373931] c00000002de71638 (sb_internal#2){.+.+}-{0:0}, at: clone_copy_inline_extent+0xe4/0x5a0
[  757.374130]
               but task is already holding lock:
[  757.374232] c000000036abc620 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x70/0x1d0
[  757.374389]
               which lock already depends on the new lock.

[  757.374507]
               the existing dependency chain (in reverse order) is:
[  757.374627]
               -> #1 (btrfs-tree-00){++++}-{3:3}:
[  757.374735]        down_read_nested+0x68/0x200
[  757.374827]        __btrfs_tree_read_lock+0x70/0x1d0
[  757.374908]        btrfs_read_lock_root_node+0x88/0x200
[  757.374988]        btrfs_search_slot+0x298/0xb70
[  757.375078]        btrfs_set_inode_index+0xfc/0x260
[  757.375156]        btrfs_new_inode+0x26c/0x950
[  757.375243]        btrfs_create+0xf4/0x2b0
[  757.375303]        lookup_open.isra.56+0x56c/0x690
[  757.375393]        path_openat+0x418/0xd20
[  757.375455]        do_filp_open+0x9c/0x130
[  757.375518]        do_sys_openat2+0x2ec/0x430
[  757.375596]        do_sys_open+0x90/0xc0
[  757.375657]        system_call_exception+0x384/0x3d0
[  757.375750]        system_call_common+0xec/0x278
[  757.375832]
               -> #0 (sb_internal#2){.+.+}-{0:0}:
[  757.375936]        __lock_acquire+0x1e80/0x2c40
[  757.376017]        lock_acquire+0x2b4/0x5b0
[  757.376078]        start_transaction+0x3cc/0x950
[  757.376158]        clone_copy_inline_extent+0xe4/0x5a0
[  757.376239]        btrfs_clone+0x5fc/0x880
[  757.376299]        btrfs_clone_files+0xd8/0x1c0
[  757.376376]        btrfs_remap_file_range+0x3d8/0x590
[  757.376455]        do_clone_file_range+0x10c/0x270
[  757.376542]        vfs_clone_file_range+0x1b0/0x310
[  757.376621]        ioctl_file_clone+0x90/0x130
[  757.376700]        do_vfs_ioctl+0x984/0x1630
[  757.376781]        sys_ioctl+0x6c/0x120
[  757.376843]        system_call_exception+0x384/0x3d0
[  757.376924]        system_call_common+0xec/0x278
[  757.377003]
               other info that might help us debug this:

[  757.377119]  Possible unsafe locking scenario:

[  757.377216]        CPU0                    CPU1
[  757.377295]        ----                    ----
[  757.377372]   lock(btrfs-tree-00);
[  757.377432]                                lock(sb_internal#2);
[  757.377530]                                lock(btrfs-tree-00);
[  757.377627]   lock(sb_internal#2);
[  757.377689]
                *** DEADLOCK ***

[  757.377783] 6 locks held by cloner/29747:
[  757.377843]  #0: c00000002de71448 (sb_writers#12){.+.+}-{0:0}, at: ioctl_file_clone+0x90/0x130
[  757.377990]  #1: c000000010b87ce8 (&sb->s_type->i_mutex_key#15){++++}-{3:3}, at: lock_two_nondirectories+0x58/0xc0
[  757.378155]  #2: c000000010b8d610 (&sb->s_type->i_mutex_key#15/4){+.+.}-{3:3}, at: lock_two_nondirectories+0x9c/0xc0
[  757.378322]  #3: c000000010b8d4a0 (&ei->i_mmap_lock){++++}-{3:3}, at: btrfs_remap_file_range+0xd0/0x590
[  757.378463]  #4: c000000010b87b78 (&ei->i_mmap_lock/1){+.+.}-{3:3}, at: btrfs_remap_file_range+0xe0/0x590
[  757.378605]  #5: c000000036abc620 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x70/0x1d0
[  757.378745]
               stack backtrace:
[  757.378823] CPU: 0 PID: 29747 Comm: cloner Not tainted 5.12.0-rc8-00161-g71a7ca634d59 #26
[  757.378972] Call Trace:
[  757.379013] [c00000002de07200] [c000000000c12ea8] dump_stack+0xec/0x144 (unreliable)
[  757.379135] [c00000002de07240] [c0000000002775d8] print_circular_bug.isra.32+0x3a8/0x400
[  757.379269] [c00000002de072e0] [c000000000277774] check_noncircular+0x144/0x190
[  757.379389] [c00000002de073b0] [c00000000027c500] __lock_acquire+0x1e80/0x2c40
[  757.379509] [c00000002de074f0] [c00000000027dfd4] lock_acquire+0x2b4/0x5b0
[  757.379609] [c00000002de075e0] [c000000000a063cc] start_transaction+0x3cc/0x950
[  757.379726] [c00000002de07690] [c000000000aede64] clone_copy_inline_extent+0xe4/0x5a0
[  757.379842] [c00000002de077c0] [c000000000aee91c] btrfs_clone+0x5fc/0x880
[  757.379940] [c00000002de07990] [c000000000aeed58] btrfs_clone_files+0xd8/0x1c0
[  757.380056] [c00000002de07a00] [c000000000aef218] btrfs_remap_file_range+0x3d8/0x590
[  757.380172] [c00000002de07ae0] [c0000000005d481c] do_clone_file_range+0x10c/0x270
[  757.380289] [c00000002de07b40] [c0000000005d4b30] vfs_clone_file_range+0x1b0/0x310
[  757.380405] [c00000002de07bb0] [c000000000588a10] ioctl_file_clone+0x90/0x130
[  757.380523] [c00000002de07c10] [c000000000589434] do_vfs_ioctl+0x984/0x1630
[  757.380621] [c00000002de07d10] [c00000000058a14c] sys_ioctl+0x6c/0x120
[  757.380719] [c00000002de07d60] [c000000000039e64] system_call_exception+0x384/0x3d0
[  757.380836] [c00000002de07e10] [c00000000000d45c] system_call_common+0xec/0x278
[  757.380953] --- interrupt: c00 at 0x7ffff7e32990
[  757.381042] NIP:  00007ffff7e32990 LR: 00000001000010ec CTR: 0000000000000000
[  757.381157] REGS: c00000002de07e80 TRAP: 0c00   Not tainted  (5.12.0-rc8-00161-g71a7ca634d59)
[  757.381289] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000244  XER: 00000000
[  757.381445] IRQMASK: 0
               GPR00: 0000000000000036 00007fffffffdec0 00007ffff7f27100 0000000000000004
               GPR04: 000000008020940d 00007fffffffdf40 0000000000000000 0000000000000000
               GPR08: 0000000000000004 0000000000000000 0000000000000000 0000000000000000
               GPR12: 0000000000000000 00007ffff7ffa940 0000000000000000 0000000000000000
               GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
               GPR20: 0000000000000000 000000009123683e 00007fffffffdf40 0000000000000000
               GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000004
               GPR28: 0000000100030260 0000000100030280 0000000000000003 000000000000005f
[  757.382382] NIP [00007ffff7e32990] 0x7ffff7e32990
[  757.382460] LR [00000001000010ec] 0x1000010ec
[  757.382537] --- interrupt: c00
[  757.787411] BTRFS: device fsid fd5f535c-f163-4a14-b9a5-c423b470fdd7 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (29753)
[  757.829757] BTRFS info (device vdc): use zlib compression, level 3
[  757.829948] BTRFS info (device vdc): disk space caching is enabled
[  757.830051] BTRFS info (device vdc): has skinny extents
[  757.837338] BTRFS info (device vdc): checking UUID tree
[  758.421670] BTRFS: device fsid e2a0fa31-ad7e-47b9-879c-309e8e2b3583 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (29850)
[  758.456197] BTRFS info (device vdc): disk space caching is enabled
[  758.456306] BTRFS info (device vdc): has skinny extents
[  758.502055] BTRFS info (device vdc): checking UUID tree
[  759.067243] BTRFS: device fsid b66a7909-8293-4467-9ec7-217007bc1023 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (29947)
[  759.099884] BTRFS info (device vdc): use zlib compression, level 3
[  759.100112] BTRFS info (device vdc): disk space caching is enabled
[  759.100222] BTRFS info (device vdc): has skinny extents
[  759.108120] BTRFS info (device vdc): checking UUID tree



-ritesh

>
> >
> > The new head is:
> > commit cb81da05e7899b8196c3c5e0b122798da3b94af0
> > Author: Qu Wenruo <wqu@suse.com>
> > Date:   Mon May 3 08:19:27 2021 +0800
> >
> >     btrfs: remove io_failure_record::in_validation
> >
> > I may have some minor change the to commit messages and comments
> > preparing for the next submit, but the code shouldn't change any more.
> >
> >
> > Just one note, thanks to your report on btrfs/028, I even find a data
> > corruption bug in relocation code.
> Nice :)
>
> > Kudos (and of-course Reported-by tags) to you!
> Thanks!
>
> >
> > New changes since v2 patchset:
> >
> > - Fix metadata read path ASSERT() when last eb is already dereferred
> > - Fix read repair related bugs
> >   * fix possible hang due to unreleased sectors after read error
> >   * fix double accounting in btrfs_subpage::readers
> >
> > - Fix false alert when relocating data extent without csum
> >   This is really a false alert, the expected csum is always 0x00
> >
> > - Fix a data corruption when relocating certain data extents layout
> >   This is a real corruption, both relocation and scrub will report
> >   error.
> Thanks for the detailed info.
>
> >
> > Thanks and happy testing!
> Thanks for the quick replies and all your work in supporting bs < ps.
> This is definitely very useful for Power platform too!!
>
> -ritesh
