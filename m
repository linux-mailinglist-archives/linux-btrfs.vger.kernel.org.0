Return-Path: <linux-btrfs+bounces-12498-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17232A6CA83
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 15:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C228E1896087
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A10F22B8B1;
	Sat, 22 Mar 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I7VkODU6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA4EBE5E;
	Sat, 22 Mar 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742652969; cv=none; b=FwM8ZXurnwb4qW57ue+24WJSYekbiDTJGlSRK0kt1eVgVtvKbHpVP1NV52NHzQ2VDh0LDBeQHuoy3MgXmCLXJT5qEiHuQtvOIDQhzh4eZogqSqplfRBqL/BCbofoqni+5RZnt8mMeqgDIJjp+yH32UX2oeM87JdnGmw9vxUKQWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742652969; c=relaxed/simple;
	bh=RMGGxq+tUBiOVs9T6ATAZWHBhOsc8pa993iM1hplcqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NjT/EQ7+KmNCxZXtmyer0IngggpToAxgKHV1AhUwpfYPY4FHhX7oBCYbEJozXhCp+PvZxXOAsVMuEpVA0boX3SizzbeQLhGnJhRYJcETooTMBfWSYzyCABrMIl8nSKQXaosglNNU5r/Qu3uWXG8tCfV3gaNa1rMedUx6i1kuokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I7VkODU6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52MAx5sa000469;
	Sat, 22 Mar 2025 14:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2TRwiq
	SkbFHVjCTVROzGbvKy/nfUXvy3YcGeFnqWB5Q=; b=I7VkODU6KkjtmclVj6PYRc
	cHO2m6pysRNn031A3xNyJQxtf1MUivQIWnJTUcWYBGyrgbSEu4JAv3E4VQ1uOTGM
	XF+x7fVhcw9Eub1tXVMYQ5qAv4TPTzDchYzrKKIMnjNOBgHgC2cnVGkBp/mSMke+
	2AIMoli0Tmv7GKtITJT5jcNojfPRwFn6ILEwo6jxA9Cz3s7M9Abh404hcltcSoUl
	LMzmjrziTPoTOP1cow6HWE/J3xrLi2/exD7xLCBquG4Z3zxlxBXcIYMq0gAjaqQx
	M/am89aLCuCRKImtogy5/dSAsXsSiaRyMIFOj4mgsf1dJ+ebyAoUZFx63p4bzHHw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45hngm9jqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 14:15:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52MEFwOG031493;
	Sat, 22 Mar 2025 14:15:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45hngm9jqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 14:15:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52MEAxR7008337;
	Sat, 22 Mar 2025 14:15:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45hn89hrn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 14:15:57 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52MEFvjG21627596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Mar 2025 14:15:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ED7458058;
	Sat, 22 Mar 2025 14:15:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 451D758057;
	Sat, 22 Mar 2025 14:15:53 +0000 (GMT)
Received: from [9.61.252.95] (unknown [9.61.252.95])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Mar 2025 14:15:53 +0000 (GMT)
Message-ID: <49a741c3-2564-4d6f-b4e1-0402b52a4cb9@linux.ibm.com>
Date: Sat, 22 Mar 2025 19:45:51 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next-20250320][btrfs] Kernel OOPs while running btrfs/108
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>, linux-btrfs@vger.kernel.org
References: <e4b1ccf8-c626-4683-82db-219354a27e61@linux.ibm.com>
 <87h63ms7gk.fsf@gmail.com> <d3be2a1b-71d9-425f-bb56-30d3fd890270@gmx.com>
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <d3be2a1b-71d9-425f-bb56-30d3fd890270@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OA9wgwp_0YBtFP2HRLhfI2ThCS2mXqPQ
X-Proofpoint-GUID: NdxYPujSaY4vidPPINVvboNrHPigKlhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-22_06,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503220103


On 22/03/25 2:48 am, Qu Wenruo wrote:
>
>
> 在 2025/3/22 02:26, Ritesh Harjani (IBM) 写道:
>>
>> +linux-btrfs
>>
>> Venkat Rao Bagalkote <venkat88@linux.ibm.com> writes:
>>
>>> Greetings!!!
>>>
>>>
>>> I am observing Kernel oops while running brtfs/108 TC on IBM Power 
>>> System.
>>>
>>> Repo: Linux-Next (next-20250320)
>>
>> Looks like this next tag had many btrfs related changes -
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/fs/btrfs?h=next-20250320 
>>
>>
>>>
>>> Traces:
>>>
>>> [  418.392604] run fstests btrfs/108 at 2025-03-21 05:11:21
>>> [  418.560137] Kernel attempted to read user page (0) - exploit 
>>> attempt?
>>> (uid: 0)
>>> [  418.560156] BUG: Kernel NULL pointer dereference on read at 
>>> 0x00000000
>>
>> NULL pointer dereference...
>>
>>> [  418.560161] Faulting instruction address: 0xc0000000010ef8b0
>>> [  418.560166] Oops: Kernel access of bad area, sig: 11 [#1]
>>> [  418.560169] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA 
>>> pSeries
>>> [  418.560174] Modules linked in: btrfs blake2b_generic xor raid6_pq
>>> zstd_compress loop nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
>>> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
>>> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 bonding nf_defrag_ipv4
>>> tls rfkill ip_set nf_tables nfnetlink sunrpc pseries_rng vmx_crypto 
>>> fuse
>>> ext4 mbcache jbd2 sd_mod sg ibmvscsi scsi_transport_srp ibmveth
>>> [  418.560212] CPU: 1 UID: 0 PID: 37583 Comm: rm Kdump: loaded Not
>>> tainted 6.14.0-rc7-next-20250320 #1 VOLUNTARY
>>> [  418.560218] Hardware name: IBM,9080-HEX Power11
>>> [  418.560223] NIP:  c0000000010ef8b0 LR: c00800000bb190ac CTR:
>>> c0000000010ef888
>>> [  418.560227] REGS: c0000000a252f5a0 TRAP: 0300   Not tainted
>>> (6.14.0-rc7-next-20250320)
>>> [  418.560232] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR:
>>> 44008444  XER: 20040000
>>> [  418.560240] CFAR: c00800000bc1df84 DAR: 0000000000000000 DSISR:
>>> 40000000 IRQMASK: 1
>>> [  418.560240] GPR00: c00800000bb190ac c0000000a252f840 
>>> c0000000016a8100
>>> 0000000000000000
>>> [  418.560240] GPR04: 0000000000000000 0000000000010000 
>>> 0000000000000000
>>> fffffffffffe0000
>>> [  418.560240] GPR08: c00000010724aad8 0000000000000003 
>>> 0000000000001000
>>> c00800000bc1df70
>>> [  418.560240] GPR12: c0000000010ef888 c000000affffdb00 
>>> 0000000000000000
>>> 0000000000000000
>>> [  418.560240] GPR16: 0000000000000000 0000000000000000 
>>> 0000000000000000
>>> 0000000000000000
>>> [  418.560240] GPR20: c0000000777a8000 c00000006a9c9000 
>>> c00000010724a950
>>> c0000000777a8000
>>> [  418.560240] GPR24: fffffffffffffffe c00000010724aad8 
>>> 0000000000010000
>>> 00000000000000a0
>>> [  418.560240] GPR28: 0000000000010000 c00c00000048c3c0 
>>> 0000000000000000
>>> 0000000000000000
>>> [  418.560287] NIP [c0000000010ef8b0] _raw_spin_lock_irq+0x28/0x98
>>> [  418.560294] LR [c00800000bb190ac] wait_subpage_spinlock+0x64/0xd0 
>>> [btrfs]
>>
>>
>> btrfs is working on subpage size support for a while now.
>> Adding +linux-btrfs, in case if they are already aware of this problem.
>>
>> I am not that familiar with btrfs code. But does this look like that the
>> subpage (folio->private became NULL here) somehow?
>
> The for-next branch seems to have some conflicts, IIRC the following two
> commits are no longer in our tree anymore:
>
> btrfs: kill EXTENT_FOLIO_PRIVATE
> btrfs: add mapping_set_release_always to inode's mapping
>
> I believe those two may be the cause.
>
> Mind to test with the our current for-next branch? Where that's all of
> our development happening, and I run daily subpage fstests on it to make
> sure at least that branch is safe:
>
>   https://github.com/btrfs/linux/tree/for-next
>
> And appreciate if you can verify if the NULL pointer dereference is
> still there on that branch.


I verified with the for-next repo, and I dont see the issue. btrfs/108 
passes.

./check btrfs/108
RECREATING    -- btrfs on /dev/loop0
FSTYP         -- btrfs
PLATFORM      -- Linux/ppc64le ltcden8-lp1 6.14.0-rc7-g88d324e69ea9 #1 
SMP Sat Mar 22 07:47:48 CDT 2025
MKFS_OPTIONS  -- -f -s 4096 -n 4096 /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 
/mnt/scratch

btrfs/108        1s
Ran: btrfs/108
Passed all 1 tests

Repo: https://github.com/btrfs/linux/tree/for-next


Regards,

Venkat.

>
> Thanks,
> Qu
>
>>
>> -ritesh
>>
>>> [  418.560339] Call Trace:
>>> [  418.560342] [c0000000a252f870] [c00800000bb205dc]
>>> btrfs_invalidate_folio+0xa8/0x4f0 [btrfs]
>>> [  418.560384] [c0000000a252f930] [c0000000004cbcdc]
>>> truncate_cleanup_folio+0x110/0x14c
>>> [  418.560391] [c0000000a252f960] [c0000000004ccc7c]
>>> truncate_inode_pages_range+0x100/0x4dc
>>> [  418.560397] [c0000000a252fbd0] [c00800000bb20ba8]
>>> btrfs_evict_inode+0x74/0x510 [btrfs]
>>> [  418.560437] [c0000000a252fc90] [c00000000065c71c] evict+0x164/0x334
>>> [  418.560443] [c0000000a252fd30] [c000000000647c9c] 
>>> do_unlinkat+0x2f4/0x3a4
>>> [  418.560449] [c0000000a252fde0] [c000000000647da0] 
>>> sys_unlinkat+0x54/0xac
>>> [  418.560454] [c0000000a252fe10] [c000000000033498]
>>> system_call_exception+0x138/0x330
>>> [  418.560461] [c0000000a252fe50] [c00000000000d05c]
>>> system_call_vectored_common+0x15c/0x2ec
>>> [  418.560468] --- interrupt: 3000 at 0x7fffb1b366bc
>>> [  418.560471] NIP:  00007fffb1b366bc LR: 00007fffb1b366bc CTR:
>>> 0000000000000000
>>> [  418.560475] REGS: c0000000a252fe80 TRAP: 3000   Not tainted
>>> (6.14.0-rc7-next-20250320)
>>> [  418.560479] MSR:  800000000280f033
>>> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 44008804  XER: 00000000
>>> [  418.560490] IRQMASK: 0
>>> [  418.560490] GPR00: 0000000000000124 00007ffffcb4e2b0 
>>> 00007fffb1c37d00
>>> ffffffffffffff9c
>>> [  418.560490] GPR04: 000000013d660380 0000000000000000 
>>> 0000000000000000
>>> 0000000000000003
>>> [  418.560490] GPR08: 0000000000000000 0000000000000000 
>>> 0000000000000000
>>> 0000000000000000
>>> [  418.560490] GPR12: 0000000000000000 00007fffb1dba5c0 
>>> 00007ffffcb4e538
>>> 000000011972d0e8
>>> [  418.560490] GPR16: 000000011972d098 000000011972d060 
>>> 000000011972d020
>>> 000000011972cff0
>>> [  418.560490] GPR20: 000000011972d298 000000011972cc10 
>>> 0000000000000000
>>> 000000013d6615a0
>>> [  418.560490] GPR24: 0000000000000002 000000011972d0b8 
>>> 000000011972cf98
>>> 000000011972d1d0
>>> [  418.560490] GPR28: 00007ffffcb4e538 000000013d6602f0 
>>> 0000000000000000
>>> 0000000000100000
>>> [  418.560532] NIP [00007fffb1b366bc] 0x7fffb1b366bc
>>> [  418.560536] LR [00007fffb1b366bc] 0x7fffb1b366bc
>>> [  418.560538] --- interrupt: 3000
>>> [  418.560541] Code: 7c0803a6 4e800020 3c4c005c 38428878 7c0802a6
>>> 60000000 39200001 992d0932 a12d0008 3ce0fffe 5529083c 61290001
>>> <7d001829> 7d063879 40c20018 7d063838
>>> [  418.560555] ---[ end trace 0000000000000000 ]---
>>>
>>>
>>> If you happed to fix this, please add below tag.
>>>
>>>
>>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>>
>>>
>>> Regards,
>>>
>>> Venkat.
>>
>
>

