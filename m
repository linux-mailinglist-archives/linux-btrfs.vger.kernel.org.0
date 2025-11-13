Return-Path: <linux-btrfs+bounces-18947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C70AC577C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 13:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FF564E6B44
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBC13502AE;
	Thu, 13 Nov 2025 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ath6boxO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6A2FFF8B;
	Thu, 13 Nov 2025 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038295; cv=none; b=uS5UZp8GOBuz6l/eG3/d31L7zHtU7UyyNKOBMY0v39CEhbbmvKErhQkrPRji1d20CabD5STgPtZy/sqpAe+0vwkGdUqxJbwpETj+C1T/InpuhAIrrWljjUItVW8pcAJ090dK/rV7D/3mXXofLwONCkTXd3q1mW8FR6GqSopKu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038295; c=relaxed/simple;
	bh=2b/mi2lloLGIcXzaj3h6NL6vBojEJTDY+DmChPaaOnA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=F7TbAcBJa8gxIbiTsWHiOHlYuzgc48dVwdiFKYGWYHL2hzf/6p8h97bUHKqEqky2B6NBHA7wQefqikiy9eu5O69rC+Kk1HHzxDr1KiAcwj0nOSEhcDWIoa07m0U5y6VYqdkP5dAdHk9YDY8J/zVzDXV1SDzQa2eLprHpqK3aaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ath6boxO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD8NWbj031615;
	Thu, 13 Nov 2025 12:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=K/1kQhnlBr+ALCh9jEHK1uWpQt/t
	CSc0s4jxAWwaMV0=; b=ath6boxOrrwuzUvXTUKalxQwFKNq5xDnr1I+RUQd3E4I
	UuE5gf4us5ok0VkkfciB3c0hZApFhQEtCVLtGJdV+GsgVkoxX+cjP0PL/mVyfKSt
	15vrrlJzhliAN7sHfWR8gUsxEAzfpiYfHRkfgIdfJHbYJFDJBn/rl5ArXXwoZjjE
	BQzkCfqu9NKEGNCdamLD0tVQgwASwgeYpf/jb5WHGc6cwpPDInS8D1TnZOpO0VLn
	CwcRrjO9HFpeB5jF/F3KlhAGC6OPuf4Bq4RY6PkARTRCYHhqiCzav6VCjT/Oq1vv
	CwXC1G4smuIv36yP3ceK5d6syKUsyjitj1V4KCE1ig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8g06e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 12:51:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ADCkknh018605;
	Thu, 13 Nov 2025 12:51:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8g06b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 12:51:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD90td3011428;
	Thu, 13 Nov 2025 12:51:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1ngfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 12:51:25 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADCpNTp27525790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 12:51:23 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16B405803F;
	Thu, 13 Nov 2025 12:51:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9B775805A;
	Thu, 13 Nov 2025 12:51:20 +0000 (GMT)
Received: from [9.61.246.65] (unknown [9.61.246.65])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 12:51:20 +0000 (GMT)
Message-ID: <83749167-c479-46df-a749-e3f65ffc3964@linux.ibm.com>
Date: Thu, 13 Nov 2025 18:21:19 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: riteshh@linux.ibm.com, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [linux-next20251112]Kernel OOPs while running btrfs/023 test case
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX/2F/9+2D13vR
 8qx1fmkhdOoOXQ36KUDMaVAiupOZGaTF5gL7jESfkDCmNXp41Uc6sdB1FBv+/E+l+aaI6UkPYhm
 vEW+DFwxCPiKhEa+yiO/JHeH1BjhghrBBZ0LJ4NLqxrgMrcyuyVH8INmjAQo2tEHQif+BdgR90U
 Gh8+5lX88cTd/5EtGoLBFX5Q2lmxL5eERJq+IjmfnZT6G7hSaE4Dsd52tREca1x7QPX78PhUBF+
 MDs+LY1mVzJxjx3hFlKu0Rueqn5sIRXkuezLvS4SGU3HG44JDAWkRO6IaMxk5GTA2IIRlVy3RQx
 NdBqr/XPiO4IEhaoR7uDDSOxXfE3gBd2Oky0wXIT1jdRu3lcoKDYazVY8DWf12n6uFOKE1SQTxM
 b0mY/P2B9mFln9spMVLLxYp4dX4Z5Q==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6915d44e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=-xG82UhcpxHdGwSs7ZEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 5Ns0_-OT-nVe6WYzIE9HSG8FTRiqZQHl
X-Proofpoint-GUID: chu-st7vAWBdjCHW-O1F8_TgxhxHbl0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

Greetings!!!


IBM CI has reported a kernel crash while running btrfs/023 test from 
xfstest suite on IBM Power11 system.


Traces:


[  184.714500] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
devid 1 transid 8 /dev/loop1 (7:1) scanned by mkfs.btrfs (2697)
[  184.714612] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
devid 2 transid 8 /dev/loop2 (7:2) scanned by mkfs.btrfs (2697)
[  184.714731] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
devid 3 transid 8 /dev/loop3 (7:3) scanned by mkfs.btrfs (2697)
[  184.714825] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
devid 4 transid 8 /dev/loop4 (7:4) scanned by mkfs.btrfs (2697)
[  184.714918] BTRFS: device fsid b8c762d5-3f1a-4020-bca9-2e7e107e5363 
devid 5 transid 8 /dev/loop5 (7:5) scanned by mkfs.btrfs (2697)
[  184.720659] BTRFS info (device loop1): first mount of filesystem 
b8c762d5-3f1a-4020-bca9-2e7e107e5363
[  184.720694] BTRFS info (device loop1): using crc32c (crc32c-lib) 
checksum algorithm
[  184.720708] BTRFS info (device loop1): forcing free space tree for 
sector size 4096 with page size 65536
[  184.725011] BTRFS info (device loop1): checking UUID tree
[  184.725060] BTRFS info (device loop1): enabling ssd optimizations
[  184.725068] BTRFS info (device loop1): turning on async discard
[  184.725075] BTRFS info (device loop1): enabling free space tree
[  184.735050] BUG: Unable to handle kernel data access at 
0x6696fffdda1ea4c2
[  184.735072] Faulting instruction address: 0xc0000000007bd030
[  184.735087] Oops: Kernel access of bad area, sig: 11 [#1]
[  184.735101] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
[  184.735118] Modules linked in: loop nft_fib_inet nft_fib_ipv4 
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 
nf_defrag_ipv4 bonding tls ip_set rfkill nf_tables sunrpc nfnetlink 
pseries_rng vmx_crypto fuse ext4 crc16 mbcache jbd2 sd_mod sg ibmvscsi 
ibmveth scsi_transport_srp pseries_wdt
[  184.735316] CPU: 22 UID: 0 PID: 1948 Comm: systemd-udevd Kdump: 
loaded Tainted: G    B               6.18.0-rc5-next-20251112 #1 VOLUNTARY
[  184.735342] Tainted: [B]=BAD_PAGE
[  184.735352] Hardware name: IBM,9080-HEX Power11 (architected) 
0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
[  184.735369] NIP:  c0000000007bd030 LR: c0000000007bcef4 CTR: 
c000000000902824
[  184.735386] REGS: c00000006fdb7910 TRAP: 0380   Tainted: G B          
       (6.18.0-rc5-next-20251112)
[  184.735404] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 
28004402  XER: 20040000
[  184.735460] CFAR: c0000000007bcf98 IRQMASK: 0
[  184.735460] GPR00: c0000000007bcef4 c00000006fdb7bb0 c0000000026aa100 
0000000000000000
[  184.735460] GPR04: 0000000000000cc0 000000013470ff60 00000000000006f0 
c0000009906ff4f0
[  184.735460] GPR08: 669164fddb1e9c02 0000000000000800 000000098d420000 
0000000000000000
[  184.735460] GPR12: c000000000902824 c000000991e0e700 0000000000000000 
0000000000000000
[  184.735460] GPR16: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  184.735460] GPR20: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[  184.735460] GPR24: 00000000000006ef 0000000000001000 ffffffffffffffff 
c00c000000402680
[  184.735460] GPR28: c0000000008f312c 0000000000000cc0 6696fffdda1e9cc2 
c00000000701e880
[  184.735688] NIP [c0000000007bd030] kmem_cache_alloc_noprof+0x4ac/0x708
[  184.735711] LR [c0000000007bcef4] kmem_cache_alloc_noprof+0x370/0x708
[  184.735729] Call Trace:
[  184.735738] [c00000006fdb7bb0] [c0000000007bcef4] 
kmem_cache_alloc_noprof+0x370/0x708 (unreliable)
[  184.735766] [c00000006fdb7c30] [c0000000008f312c] 
getname_flags.part.0+0x54/0x30c
[  184.735793] [c00000006fdb7c80] [c0000000009028a0] sys_unlinkat+0x7c/0xe4
[  184.735814] [c00000006fdb7cc0] [c000000000039d50] 
system_call_exception+0x1e0/0x450
[  184.735839] [c00000006fdb7e50] [c00000000000d05c] 
system_call_vectored_common+0x15c/0x2ec
[  184.735866] ---- interrupt: 3000 at 0x7fff9df366bc
[  184.735881] NIP:  00007fff9df366bc LR: 00007fff9df366bc CTR: 
0000000000000000
[  184.735897] REGS: c00000006fdb7e80 TRAP: 3000   Tainted: G B          
       (6.18.0-rc5-next-20251112)
[  184.735913] MSR:  800000000280f033 
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 48004402  XER: 00000000
[  184.735989] IRQMASK: 0
[  184.735989] GPR00: 0000000000000124 00007fffe0b3a3a0 00007fff9e037d00 
0000000000000006
[  184.735989] GPR04: 000000013470ff60 0000000000000000 0000000000001000 
00007fff9e0314b8
[  184.735989] GPR08: 0000000000000271 0000000000000000 0000000000000000 
0000000000000000
[  184.735989] GPR12: 0000000000000000 00007fff9e8c4ca0 00000001161e5a78 
00007fffe0b3ab10
[  184.735989] GPR16: 0000000000000003 0000000000000000 00000001161aaed0 
00000001161e9750
[  184.735989] GPR20: 00007fffe0b3a780 00000001161eb260 00000001161eb320 
0000000000000008
[  184.735989] GPR24: 00000001347061c0 0000000000000000 0000000000000009 
00000001347061c0
[  184.735989] GPR28: 0000000000000006 00007fffe0b3a53c 0000000134715740 
0000000000100000
[  184.736216] NIP [00007fff9df366bc] 0x7fff9df366bc
[  184.736231] LR [00007fff9df366bc] 0x7fff9df366bc
[  184.736251] ---- interrupt: 3000
[  184.736262] Code: f8610030 4082fccc 4bfffc28 2c3e0000 4182ff98 
2c3b0000 4182ff90 60000000 3b40ffff 813f0030 e91f00c0 38d80001 
<7f7e482a> 7d3e4a14 79270022 552ac03e
[  184.736362] ---[ end trace 0000000000000000 ]---


If you happen to fix this, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.



