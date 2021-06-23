Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2743B1448
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 08:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFWG7C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 02:59:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12052 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229801AbhFWG7C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 02:59:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15N6WX52026702;
        Wed, 23 Jun 2021 02:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=qAhqpwKrPL/Wf3Apg5E9yUNXCMGcscfxC4OKW0jFBQs=;
 b=pyZlu6dSIyz8AQ6gf6lWCddXqibT5YIdkPhTtxWo29Wj/sG+o/e1z1tajiuNuwz4yl5t
 adbx/MhQuLQobWrTmo2uBRqajo7BQBH12wAmOF9xFRk3wA7/LU/ZGcY78gz+lvltICAg
 gWEDQXU0lQMztU28wHyBl6G9QeRJcW2Bf7oA//ej2UgtgNUBtRcJlWaTPEv4V6iJTj0c
 JsH1wmNteMEIbkZdkA52iFAfSTupivW5A5bMCebKMCXNYrdMrvk6VFq+nfyM+wHhSdP4
 AFgP2EMORitFPbUv9chdmIYUz6kZSgTiin8vt8a65FLvw9RGJaY376RG2mdbnPbaxxXG hA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39btvqy872-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Jun 2021 02:56:42 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15N6pq0f026473;
        Wed, 23 Jun 2021 06:56:40 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3998789072-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Jun 2021 06:56:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15N6ub1W30146972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 06:56:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DAC24C064;
        Wed, 23 Jun 2021 06:56:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A3CB4C046;
        Wed, 23 Jun 2021 06:56:37 +0000 (GMT)
Received: from localhost (unknown [9.199.33.234])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Jun 2021 06:56:37 +0000 (GMT)
Date:   Wed, 23 Jun 2021 12:26:36 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/10] btrfs: defrag: rework to support sector perfect
 defrag
Message-ID: <20210623065636.l7uqokq7dcf6m5tc@riteshh-domain>
References: <20210610050917.105458-1-wqu@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610050917.105458-1-wqu@suse.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5M3B-Wis8A_d1-5846ysvaTG_23AkBkS
X-Proofpoint-ORIG-GUID: 5M3B-Wis8A_d1-5846ysvaTG_23AkBkS
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-23_02:2021-06-22,2021-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106230037
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/06/10 01:09PM, Qu Wenruo wrote:
> This branch is based on subpage RW branch, as the last patch needs to
> enable defrag support for subpage cases.
>
> But despite that one, all other patches can be applied on current
> misc-next.
>
> [BACKGROUND]
> In subpage rw branch, we disable defrag completely due to the fact that
> current code can only work on page basis.
>
> This could lead to problems like btrfs/062 crash.
>
> Thus this patchset will make defrag to work on both regular and subpage
> sectorsize.
>
> [SOLUTION]
> To defrag a file range, what we do is pretty much like buffered write,
> except we don't really write any new data to page cache, but just mark
> the range dirty.
>
> Then let later writeback to merge the range into a larger extent.
>
> But current defrag code is working on per-page basis, not per-sector,
> thus we have to refactor it a little to make it to work properly for
> subpage.
>
> This patch will separate the code into 3 layers:
> Layer 0:	btrfs_defrag_file()
> 		The defrag entrace
> 		Just do proper inode lock and split the file into
> 		page aligned 256K clusters to defrag
>
> Layer 1:	defrag_one_cluster()
> 		Will collect the initial targets file extents, and pass
> 		each continuous target to defrag_one_range()
>
> Layer 2:	defrag_one_range()
> 		Will prepare the needed page and extent locking.
> 		Then re-check the range for real target list, as initial
> 		target list is not consistent as it doesn't hage
> 		page/extent locking to prevent hole punching.
>
> Layer 3:	defrag_one_locked_target()
> 		The real work, to make the extent range defrag and
> 		update involved page status
>
> [BEHAVIOR CHANGE]
> In the refactor, there is one behavior change:
>
> - Defraged sector counter is based on the initial target list
>   This is mostly to avoid the paremters to be passed too deep into
>   defrag_one_locked_target().
>   Considering the accounting is not that important, we can afford some
>   difference.
>
> [PATCH STRUTURE]
> Patch 01~03:	Small independent refactor to improve readability
> Patch 04~08:	Implement the more readable and subpage friendly defrag
> Patch 09:	Cleanup of old infrastruture
> Patch 10:	Enable defrag for subpage case
>
> Now both regular sectorsize and subpage sectorsize can pass defrag test
> group.
>
> Although the tests no longer crashes, I still see random test failure on
> 64K page size with 4K sectorsize, reporting nbytes mismatch for fsstress
> + defrag workload.
>
> So please don't merge the branch into v5.14 merge window at least.
>
> This normally means defrag has defragged some hole without setting it
> with DELALLOC_NEW.
> But I haven't find any location which makes it possible, as the new
> defrag_collect_targets() call timing (with both page and extent locked,
> no ordered extents) should be as safe as the original one.
>
> Thus I'm wondering if the check timing is even correct for the existing
> code.
> But at least I can't reproduce the nbytes problem on x86_64, thus no yet
> sure what the real cause is.

Hi Qu,

Sorry for getting back late on this. I was using my test machines for other
tests hence this got delayed.

I did test this whole patch series from your github https://github.com/adam900710/linux/commits/defrag_refactor.
I didn't find any crashes (as you also mentioned). But some tests did fail e.g. btrfs/072.

Is this(btrfs/072) what you are referring to in above (random test failues with subpage
sectorsize)?

Please do let me know if you would like me to try any of the fstest in loop for
reproducing any error. Or if there is any other tests that you would like me to
run?

1. output from btrfs/072 test.
	_check_btrfs_filesystem: filesystem on /dev/vdc is inconsistent
	*** fsck.btrfs output ***
	[1/7] checking root items
	[2/7] checking extents
	[3/7] checking free space cache
	btrfs: csum mismatch on free space cache
	failed to load free space cache for block group 22020096
	btrfs: csum mismatch on free space cache
	failed to load free space cache for block group 1095761920
	btrfs: csum mismatch on free space cache
	failed to load free space cache for block group 1364197376
	[4/7] checking fs roots
	root 5 inode 323 errors 400, nbytes wrong
	ERROR: errors found in fs roots
	Opening filesystem to check...
	Checking filesystem on /dev/vdc
	UUID: b638db59-981c-4502-831e-038930e65cf4
	found 28282880 bytes used, error(s) found
	total csum bytes: 15196
	total tree bytes: 442368
	total fs tree bytes: 331776
	total extent tree bytes: 36864
	btree space waste bytes: 163191
	file data blocks allocated: 37101568
	 referenced 27430912
	*** end fsck.btrfs output

2. btrfs/124 (- I guess this we have seen in past w/o your changes too).
	[ 2565.969989] BTRFS info (device vdc): balance: start -d -m -s
	[ 2565.970727] BTRFS info (device vdc): relocating block group 1513488384 flags data
	[ 2570.693594] BTRFS error (device vdc): bad tree block start, want 31821824 have 0
	[ 2570.725804] BTRFS info (device vdc): read error corrected: ino 0 off 31821824 (dev /dev/vdi sector 21192)
	[ 2581.579592] BTRFS info (device vdc): found 5 extents, stage: move data extents
	[ 2581.818799] BTRFS info (device vdc): found 5 extents, stage: update data pointers
	[ 2582.086796] BTRFS info (device vdc): relocating block group 976617472 flags data
	[ 2598.759264] BTRFS info (device vdc): found 6 extents, stage: move data extents
	[ 2598.991059] BTRFS info (device vdc): found 6 extents, stage: update data pointers
	[ 2599.274253] BTRFS info (device vdc): relocating block group 943063040 flags system
	[ 2599.525191] BTRFS info (device vdc): relocating block group 674627584 flags metadata
	[ 2599.788734] BTRFS info (device vdc): relocating block group 298844160 flags data|raid1
	[ 2609.746593] BTRFS info (device vdc): found 4 extents, stage: move data extents
	[ 2609.989663] BTRFS info (device vdc): found 3 extents, stage: update data pointers
	[ 2610.234642] BTRFS info (device vdc): relocating block group 30408704 flags metadata|raid1
	[ 2610.234889] ------------[ cut here ]------------
	[ 2610.234970] BTRFS: Transaction aborted (error -28)
	[ 2610.235172] WARNING: CPU: 3 PID: 26186 at fs/btrfs/extent-tree.c:2163 btrfs_run_delayed_refs+0x108/0x330
	[ 2610.235364] Modules linked in:
	[ 2610.235426] CPU: 3 PID: 26186 Comm: btrfs Not tainted 5.13.0-rc2-00393-gc0e4bc6f271f #43
	[ 2610.235547] NIP:  c0000000009f0bb8 LR: c0000000009f0bb4 CTR: c000000000e5fb30
	[ 2610.235665] REGS: c000000078fb7320 TRAP: 0700   Not tainted  (5.13.0-rc2-00393-gc0e4bc6f271f)
	[ 2610.235802] MSR:  800000000282b033 &lt;SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE&gt;  CR: 48004222  XER: 20000000
	[ 2610.235961] CFAR: c0000000001cea40 IRQMASK: 0
	               GPR00: c0000000009f0bb4 c000000078fb75c0 c000000001c5dc00 0000000000000026
	               GPR04: 00000000fffff5ff c000000078fb7280 0000000000000027 c0000000ff507e98
	               GPR08: 0000000000000023 0000000000000000 c00000000c286580 c000000001a11050
	               GPR12: 0000000000004400 c00000003ffeae00 0000000000000002 c000000045e4e088
	               GPR16: c000000045e4e000 c000000001334eb0 c000000012654000 0000000001d00000
	               GPR20: c000000012654000 0000000000000e5c 0000000000000000 c000000001662dc8
	               GPR24: 0000000000000014 c000000009ec9800 c000000009ec9b48 c0000000410f6e08
	               GPR28: 0000000000000000 0000000000000001 c000000012654000 ffffffffffffffe4
	[ 2610.237012] NIP [c0000000009f0bb8] btrfs_run_delayed_refs+0x108/0x330
	[ 2610.237111] LR [c0000000009f0bb4] btrfs_run_delayed_refs+0x104/0x330
	[ 2610.237213] Call Trace:
	[ 2610.237254] [c000000078fb75c0] [c0000000009f0bb4] btrfs_run_delayed_refs+0x104/0x330 (unreliable)
	[ 2610.237404] [c000000078fb7680] [c000000000a0c4e4] btrfs_commit_transaction+0xf4/0x1330
	[ 2610.237533] [c000000078fb7770] [c000000000a96e74] prepare_to_relocate+0x104/0x140
	[ 2610.237657] [c000000078fb77a0] [c000000000a9d524] relocate_block_group+0x74/0x5f0
	[ 2610.237770] [c000000078fb7860] [c000000000a9dcd0] btrfs_relocate_block_group+0x230/0x4a0
	[ 2610.237886] [c000000078fb7920] [c000000000a56a60] btrfs_relocate_chunk+0x80/0x1c0
	[ 2610.238002] [c000000078fb79a0] [c000000000a57d3c] btrfs_balance+0x103c/0x1560
	[ 2610.238117] [c000000078fb7b30] [c000000000a6ab98] btrfs_ioctl_balance+0x2d8/0x450
	[ 2610.238232] [c000000078fb7b90] [c000000000a6eb90] btrfs_ioctl+0x1df0/0x3be0
	[ 2610.238328] [c000000078fb7d10] [c00000000058e048] sys_ioctl+0xa8/0x120
	[ 2610.238435] [c000000078fb7d60] [c000000000036524] system_call_exception+0x3d4/0x410
	[ 2610.238551] [c000000078fb7e10] [c00000000000d45c] system_call_common+0xec/0x278
	[ 2610.238666] --- interrupt: c00 at 0x7ffff7be2990

3. There were other failues, but I guess those were either due to mount failure
   or since no compression support yet for subpage blocksize.

-ritesh
