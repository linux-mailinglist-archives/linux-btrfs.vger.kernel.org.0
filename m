Return-Path: <linux-btrfs+bounces-18948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097C2C57BAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 14:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E934A751D
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20052351FDF;
	Thu, 13 Nov 2025 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FuarDKh5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D8350A04;
	Thu, 13 Nov 2025 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039878; cv=none; b=CB9RbjzXV+g3fKqbhFlNJRZybI9Gln23EWXRCGCSdSMO2TksyHk1gnQOJfF7CsQrGWX/8N7yF0ye8PEZLV5yoKIzuuQoXO3G2O26M60m3OyM+GxTQBRgU+IGm6JlBKpDKiRoRliEWE3Do+SMAdlzvWyW6KBwJHpxVOz2EWtq93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039878; c=relaxed/simple;
	bh=YhGP57/3A8QZP0hrlify74LiHpmFtAlmEoZ6cQ+scOE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CebMFPgREa81yzDPP2gWP7QyOTmTUj8JoolwCtuG0VB4Xr4h/p10yAZlXuf/46GwITXg/V051Ecxr+N3DA/FbehuUyUdHatdIR1pnk3Opogwv1x1NAGGd2EL6kSZbMOjAKkzxk+WraH0xjNTQGJFdQwlk8JKfMN1L1eQ4+iR7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FuarDKh5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD6vmtm030536;
	Thu, 13 Nov 2025 13:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Rf7V4J
	YIm3XgTUpjAotcVSWNzmqUtUmoW8Kh94hAy/I=; b=FuarDKh5faOQvw/1vj3bDT
	cZzv3TIN4rTw76YnKB4YbFV2tjM61bO6NylzhzNf3f76zDRgkh7VP+nmUTz/OMuC
	05CHi1Bg7nkpYPEwAxIY/H4cLp1DVW0Da4zTMhwEpXrWDdN8iOWNYrk+smgl2DA9
	fBRn9um+q7rJXsIdZBQxPO1h7KYAgl1ERwcNJRSoA/ehRwlmGT/CucrqQyn1nm06
	xFeQvmfNga7xKS3gUoBnEKBHlmjqfVcLJCB/boIynMm2uevXLDoTFeEYE9hRqGsQ
	LZVoU4pZi4blZJQlgGBjK0jQuxYiaw+1HihxwP3+9NtTA74WFTftN3ZplkWyos6A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7g7cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 13:17:49 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ADDCn9W022568;
	Thu, 13 Nov 2025 13:17:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7g7cd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 13:17:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCwMwa007325;
	Thu, 13 Nov 2025 13:17:47 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjnr1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 13:17:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADDHl0n22676196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 13:17:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8AC658056;
	Thu, 13 Nov 2025 13:17:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D2CF5803F;
	Thu, 13 Nov 2025 13:17:44 +0000 (GMT)
Received: from [9.61.246.65] (unknown [9.61.246.65])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 13:17:44 +0000 (GMT)
Message-ID: <65b02403-25e5-4ec3-8577-de1409b0a765@linux.ibm.com>
Date: Thu, 13 Nov 2025 18:47:43 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next20251112]Kernel OOPs while running btrfs/023 test case
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: riteshh@linux.ibm.com, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <83749167-c479-46df-a749-e3f65ffc3964@linux.ibm.com>
In-Reply-To: <83749167-c479-46df-a749-e3f65ffc3964@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfXz7Z2qnzQEpHp
 4ueagBXwZwj4c4qLvW8wJ30FSE+pGoHRESOS156MCR872UQd2asPMd8mY5lYRCOJ7W1U8AITPAD
 TvcymfWTK9GUCQomyp8n9JUo9kuwfrcIIvwQOOw6lTiGwrq4nRIDMa77odWoQtpUl2QefMC68Wk
 reD5c4/iWQAJBa8f66/r8YPg8Ea3qqYKTZRC9B6r0tXLeDTFBAQV/pmlZwMVHe5yJYcwOTBiyVP
 OxszzyV5JiebUWls5WC5I0/L/zQ7U6KwaigqWNSVMj/oeDWqJwESAdbb8uAuQJ2l2HlxE01tdAf
 pks9BVGGlJKA9AwCxLo+b65yzZFU+3Dyk0sPiclZR8nsPIaH4EbtdK8OMon0qOTIGQaRRXxDjyU
 Zpd7HNVKxCoOq4HiHh5l5eTjPXTyFw==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=6915da7d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Qaz22dlSkarScz2rei4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: r2wxRtbciKNXoTH6E_0K6Q97a1WQOzg8
X-Proofpoint-ORIG-GUID: VF3BhNlhs35Kw5IOpFlYidRrItbuCk2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018


On 13/11/25 6:21 pm, Venkat Rao Bagalkote wrote:
> Greetings!!!
>
>
> IBM CI has reported a kernel crash while running btrfs/023 test from 
> xfstest suite on IBM Power11 system.
>
>
> Traces:
>
>
> [  184.714500] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
> devid 1 transid 8 /dev/loop1 (7:1) scanned by mkfs.btrfs (2697)
> [  184.714612] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
> devid 2 transid 8 /dev/loop2 (7:2) scanned by mkfs.btrfs (2697)
> [  184.714731] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
> devid 3 transid 8 /dev/loop3 (7:3) scanned by mkfs.btrfs (2697)
> [  184.714825] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
> devid 4 transid 8 /dev/loop4 (7:4) scanned by mkfs.btrfs (2697)
> [  184.714918] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
> devid 5 transid 8 /dev/loop5 (7:5) scanned by mkfs.btrfs (2697)
> [  184.720659] BTRFS info (device loop1): first mount of filesystem 
> b8c762d5-3f1a-4020-bca9-2e7e107e5363
> [  184.720694] BTRFS info (device loop1): using crc32c (crc32c-lib) 
> checksum algorithm
> [  184.720708] BTRFS info (device loop1): forcing free space tree for 
> sector size 4096 with page size 65536
> [  184.725011] BTRFS info (device loop1): checking UUID tree
> [  184.725060] BTRFS info (device loop1): enabling ssd optimizations
> [  184.725068] BTRFS info (device loop1): turning on async discard
> [  184.725075] BTRFS info (device loop1): enabling free space tree
> [  184.735050] BUG: Unable to handle kernel data access at 
> 0x6696fffdda1ea4c2
> [  184.735072] Faulting instruction address: 0xc0000000007bd030
> [  184.735087] Oops: Kernel access of bad area, sig: 11 [#1]
> [  184.735101] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [  184.735118] Modules linked in: loop nft_fib_inet nft_fib_ipv4 
> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
> nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 
> nf_defrag_ipv4 bonding tls ip_set rfkill nf_tables sunrpc nfnetlink 
> pseries_rng vmx_crypto fuse ext4 crc16 mbcache jbd2 sd_mod sg ibmvscsi 
> ibmveth scsi_transport_srp pseries_wdt
> [  184.735316] CPU: 22 UID: 0 PID: 1948 Comm: systemd-udevd Kdump: 
> loaded Tainted: G    B               6.18.0-rc5-next-20251112 #1 
> VOLUNTARY
> [  184.735342] Tainted: [B]=BAD_PAGE
> [  184.735352] Hardware name: IBM,9080-HEX Power11 (architected) 
> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [  184.735369] NIP:  c0000000007bd030 LR: c0000000007bcef4 CTR: 
> c000000000902824
> [  184.735386] REGS: c00000006fdb7910 TRAP: 0380   Tainted: G B       
>       (6.18.0-rc5-next-20251112)
> [  184.735404] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
> 28004402  XER: 20040000
> [  184.735460] CFAR: c0000000007bcf98 IRQMASK: 0
> [  184.735460] GPR00: c0000000007bcef4 c00000006fdb7bb0 
> c0000000026aa100 0000000000000000
> [  184.735460] GPR04: 0000000000000cc0 000000013470ff60 
> 00000000000006f0 c0000009906ff4f0
> [  184.735460] GPR08: 669164fddb1e9c02 0000000000000800 
> 000000098d420000 0000000000000000
> [  184.735460] GPR12: c000000000902824 c000000991e0e700 
> 0000000000000000 0000000000000000
> [  184.735460] GPR16: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [  184.735460] GPR20: 0000000000000000 0000000000000000 
> 0000000000000000 0000000000000000
> [  184.735460] GPR24: 00000000000006ef 0000000000001000 
> ffffffffffffffff c00c000000402680
> [  184.735460] GPR28: c0000000008f312c 0000000000000cc0 
> 6696fffdda1e9cc2 c00000000701e880
> [  184.735688] NIP [c0000000007bd030] kmem_cache_alloc_noprof+0x4ac/0x708
> [  184.735711] LR [c0000000007bcef4] kmem_cache_alloc_noprof+0x370/0x708
> [  184.735729] Call Trace:
> [  184.735738] [c00000006fdb7bb0] [c0000000007bcef4] 
> kmem_cache_alloc_noprof+0x370/0x708 (unreliable)
> [  184.735766] [c00000006fdb7c30] [c0000000008f312c] 
> getname_flags.part.0+0x54/0x30c
> [  184.735793] [c00000006fdb7c80] [c0000000009028a0] 
> sys_unlinkat+0x7c/0xe4
> [  184.735814] [c00000006fdb7cc0] [c000000000039d50] 
> system_call_exception+0x1e0/0x450
> [  184.735839] [c00000006fdb7e50] [c00000000000d05c] 
> system_call_vectored_common+0x15c/0x2ec
> [  184.735866] ---- interrupt: 3000 at 0x7fff9df366bc
> [  184.735881] NIP:  00007fff9df366bc LR: 00007fff9df366bc CTR: 
> 0000000000000000
> [  184.735897] REGS: c00000006fdb7e80 TRAP: 3000   Tainted: G B       
>       (6.18.0-rc5-next-20251112)
> [  184.735913] MSR:  800000000280f033 
> <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48004402  XER: 00000000
> [  184.735989] IRQMASK: 0
> [  184.735989] GPR00: 0000000000000124 00007fffe0b3a3a0 
> 00007fff9e037d00 0000000000000006
> [  184.735989] GPR04: 000000013470ff60 0000000000000000 
> 0000000000001000 00007fff9e0314b8
> [  184.735989] GPR08: 0000000000000271 0000000000000000 
> 0000000000000000 0000000000000000
> [  184.735989] GPR12: 0000000000000000 00007fff9e8c4ca0 
> 00000001161e5a78 00007fffe0b3ab10
> [  184.735989] GPR16: 0000000000000003 0000000000000000 
> 00000001161aaed0 00000001161e9750
> [  184.735989] GPR20: 00007fffe0b3a780 00000001161eb260 
> 00000001161eb320 0000000000000008
> [  184.735989] GPR24: 00000001347061c0 0000000000000000 
> 0000000000000009 00000001347061c0
> [  184.735989] GPR28: 0000000000000006 00007fffe0b3a53c 
> 0000000134715740 0000000000100000
> [  184.736216] NIP [00007fff9df366bc] 0x7fff9df366bc
> [  184.736231] LR [00007fff9df366bc] 0x7fff9df366bc
> [  184.736251] ---- interrupt: 3000
> [  184.736262] Code: f8610030 4082fccc 4bfffc28 2c3e0000 4182ff98 
> 2c3b0000 4182ff90 60000000 3b40ffff 813f0030 e91f00c0 38d80001 
> <7f7e482a> 7d3e4a14 79270022 552ac03e
> [  184.736362] ---[ end trace 0000000000000000 ]---
>

Mostly the issue got introduced by one of the below three commits. As 
reverting these three, this issue is not seen.


9299051573d9 e8ea54f86241 cd93c0aad7e3

>
> If you happen to fix this, please add below tag.
>
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
> Regards,
>
> Venkat.
>
>

