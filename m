Return-Path: <linux-btrfs+bounces-10344-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5C29F07FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 10:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6974281A9A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDB01B21AE;
	Fri, 13 Dec 2024 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bS3j7q7M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCB71AF0D6;
	Fri, 13 Dec 2024 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082506; cv=none; b=k11sU3cXH2CRE0edAJpC3hn8vzkYZh4HtV1Vdpr6Dl38ffr1YBxrq3+1VFmFz22MJItAv3eEaqjvqlPrj60g5ZVfRzWw/hHmB52P/i/PyGPpKwOO8o5u+H55jC9wl3I6PAc3StMEPz4ZIcrI0HX4CnEoONL0VWWi6oV76o5bgb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082506; c=relaxed/simple;
	bh=dP3/CfozjEfuMPOoOTKCEAiW8yq14u8H4ZwmRPEKn5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stsIrAeZQcDoAx9T0TN1OVULrOI84w5dEqqwDQLTPKkPwJt7i0XtW3ZHcGT29ailBRL7C9PU0RyVlv+6wt6JA+tDNprpyV40jpm/MbgTa0s4VWUR+fXwUoA7gOPaomnz4fLZjiqstalNzfXHv9Q2Aq35dLgLcR9+N17m6+h0jG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bS3j7q7M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD57HDe029618;
	Fri, 13 Dec 2024 09:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aL90YR
	nXCctrHOIYUk/NI6Uyt5G4dfnsjIsH3GNjchQ=; b=bS3j7q7MTixoxkLSX2MjIM
	BAXzPXQd1Bq3cw84dJ0SPENdLLmQiG+V4BFf2kDa0bh9kvruFmqrhgQuSAwREtYK
	o8yMQce/hFVjNHLJ37aFxkCsbs9mVIUk4E4NhN1AlpAXG1BIlckXdwP2f1yxZ5a4
	vTR+ZpemY8j08PX1oyzRRvECjP7MBk66jehWlgqZ1BYwS8D/PDTAzhMPHayyKPMT
	EPduXZmMSfQ4waKIuYZES7bUhpmFH3XOkq3mw1NTmZ+a2ZoP6etFIGJJ2dfHoBSx
	pRO0jfDrSTHrigaWwmuwOAabMjNI5B5B5ud5TMG61QiXAKnkKnITUB42oj6BoJPA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsk034t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:35:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BD9TTeq000402;
	Fri, 13 Dec 2024 09:35:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsk034r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:35:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD7fX2t007781;
	Fri, 13 Dec 2024 09:34:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11xmgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:34:59 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BD9Yw8q62849386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 09:34:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EF7E58076;
	Fri, 13 Dec 2024 09:34:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D60A5808F;
	Fri, 13 Dec 2024 09:34:56 +0000 (GMT)
Received: from [9.171.36.222] (unknown [9.171.36.222])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Dec 2024 09:34:56 +0000 (GMT)
Message-ID: <22b856e1-39a9-4926-b3b7-41147519d2da@linux.ibm.com>
Date: Fri, 13 Dec 2024 10:34:55 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix avail_in bytes for s390 zlib HW compression
 path
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20241212135000.1926110-1-zaslonko@linux.ibm.com>
 <85bd7f9b-d9de-46ce-bda9-e7f2db31b8d6@gmx.com>
Content-Language: en-US
From: Zaslonko Mikhail <zaslonko@linux.ibm.com>
In-Reply-To: <85bd7f9b-d9de-46ce-bda9-e7f2db31b8d6@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _y206LWh0g9FAEwixpMv00J3p_2gXNh-
X-Proofpoint-ORIG-GUID: nYZM3PhHPD0sDAd1h40g1EeddOIcQa8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130064

Hello Qu,

On 12.12.2024 21:37, Qu Wenruo wrote:
> 
> 
> 在 2024/12/13 00:20, Mikhail Zaslonko 写道:
>> Since the input data length passed to zlib_compress_folios() can be
>> arbitrary, always setting strm.avail_in to a multiple of PAGE_SIZE may
>> cause read-in bytes to exceed the input range. Currently this triggers
>> an assert in btrfs_compress_folios() on the debug kernel. But it may
>> potentially lead to data corruption.
> 
> Mind to provide the real world ASSERT() call trace?

Here is the call trace triggered by one of our tests (wasn't sure whether to include it to the commit message):

[ 2928.542300] BTRFS: device fsid 98138b99-a1bc-47cd-9b77-9e64fbba11de devid 1 transid 55 /dev/dasdc1 (94:9) scanned by mount (2000)                            
[ 2928.543029] BTRFS info (device dasdc1): first mount of filesystem 98138b99-a1bc-47cd-9b77-9e64fbba11de                                                       
[ 2928.543051] BTRFS info (device dasdc1): using crc32c (crc32c-vx) checksum algorithm                                                                          
[ 2928.543058] BTRFS info (device dasdc1): using free-space-tree                                                                                                
[ 2964.842146] assertion failed: *total_in <= orig_len, in fs/btrfs/compression.c:1041                                                                          
[ 2964.842226] ------------[ cut here ]------------                                                                                                             
[ 2964.842229] kernel BUG at fs/btrfs/compression.c:1041!                                                                                                       
[ 2964.842306] monitor event: 0040 ilc:2 [#1] PREEMPT SMP                                                                                                       
[ 2964.842314] Modules linked in: nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat n
f_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables pkey_pckmo s390_trng rng_core vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel drm loop i2c_co
re dm_multipath drm_panel_orientation_quirks nfnetlink vsock_loopback vmw_vsock_virtio_transport_common vsock lcs ctcm fsm zfcp scsi_transport_fc ghash_s390 prn
g chacha_s390 aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkey autof
s4 ecdsa_generic ecc                                                                                                                                            
[ 2964.842387] CPU: 16 UID: 0 PID: 325 Comm: kworker/u273:3 Not tainted 6.13.0-20241204.rc1.git6.fae3b21430ca.300.fc41.s390x+debug #1                           
[ 2964.842406] Hardware name: IBM 3931 A01 703 (z/VM 7.4.0)                                                                                                     
[ 2964.842409] Workqueue: btrfs-delalloc btrfs_work_helper                                                                                                      
[ 2964.842420] Krnl PSW : 0704d00180000000 0000021761df6538 (btrfs_compress_folios+0x198/0x1a0)                                                                 
[ 2964.842426]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3                                                                          
[ 2964.842430] Krnl GPRS: 0000000080000000 0000000000000001 0000000000000047 0000000000000000                                                                   
[ 2964.842433]            0000000000000006 ffffff01757bb000 000001976232fcc0 000000000000130c                                                                   
[ 2964.842436]            000001976232fcd0 000001976232fcc8 00000118ff4a0e30 0000000000000001                                                                   
[ 2964.842438]            00000111821ab400 0000011100000000 0000021761df6534 000001976232fb58                                                                   
[ 2964.842446] Krnl Code: 0000021761df6528: c020006f5ef4        larl    %r2,0000021762be2310                                                                    
[ 2964.842446]            0000021761df652e: c0e5ffbd09d5        brasl   %r14,00000217615978d8                                                                   
[ 2964.842446]           #0000021761df6534: af000000            mc      0,0                                                                                     
[ 2964.842446]           >0000021761df6538: 0707                bcr     0,%r7                                                                                   
[ 2964.842446]            0000021761df653a: 0707                bcr     0,%r7                                                                                   
[ 2964.842446]            0000021761df653c: 0707                bcr     0,%r7                                                                                   
[ 2964.842446]            0000021761df653e: 0707                bcr     0,%r7                                                                                   
[ 2964.842446]            0000021761df6540: c004004bb7ec        brcl    0,000002176276d518                                                                      
[ 2964.842463] Call Trace:                                                                                                                                      
[ 2964.842465]  [<0000021761df6538>] btrfs_compress_folios+0x198/0x1a0                                                                                          
[ 2964.842468] ([<0000021761df6534>] btrfs_compress_folios+0x194/0x1a0)                                                                                         
[ 2964.842708]  [<0000021761d97788>] compress_file_range+0x3b8/0x6d0                                                                                            
[ 2964.842714]  [<0000021761dcee7c>] btrfs_work_helper+0x10c/0x160                                                                                              
[ 2964.842718]  [<0000021761645760>] process_one_work+0x2b0/0x5d0                                                                                               
[ 2964.842724]  [<000002176164637e>] worker_thread+0x20e/0x3e0                                                                                                  
[ 2964.842728]  [<000002176165221a>] kthread+0x15a/0x170                                                                                                        
[ 2964.842732]  [<00000217615b859c>] __ret_from_fork+0x3c/0x60                                                                                                  
[ 2964.842736]  [<00000217626e72d2>] ret_from_fork+0xa/0x38                                                                                                     
[ 2964.842744] INFO: lockdep is turned off.                                                                                                                     
[ 2964.842746] Last Breaking-Event-Address:                                                                                                                     
[ 2964.842748]  [<0000021761597924>] _printk+0x4c/0x58                                                                                                          
[ 2964.842755] Kernel panic - not syncing: Fatal exception: panic_on_oops                                                                                       

Let me know if I can provide any other details.

> 
> AFAIK the range passed into btrfs_compress_folios() should always have
> its start/length aligned to sector size.

Based on my tests, btrfs_compress_folios() input length (total_out) is not always a
multiple of PAGE_SIZE. One can see this when writing less than 4K of data to an
empty btrfs file.

> 
> Since s390 only supports 4K page size, that means the range is always
> aligned to page size, and the existing code is also doing full page copy
> anyway, thus I see no problem with the existing read.

The code is doing full page copy to the workspace buffer for further compression. But the
number of bytes actually processed by zlib_deflate() is controlled by strm.avail_in
parameter.

> 
> Thanks,
> Qu
> 
>> Fix strm.avail_in calculation for S390 hardware acceleration path.
>>
>> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
>> Fixes: fd1e75d0105d ("btrfs: make compression path to be subpage compatible")
>> ---
>>   fs/btrfs/zlib.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
>> index ddf0d5a448a7..c9e92c6941ec 100644
>> --- a/fs/btrfs/zlib.c
>> +++ b/fs/btrfs/zlib.c
>> @@ -174,10 +174,10 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>>                       copy_page(workspace->buf + i * PAGE_SIZE,
>>                             data_in);
>>                       start += PAGE_SIZE;
>> -                    workspace->strm.avail_in =
>> -                        (in_buf_folios << PAGE_SHIFT);
>>                   }
>>                   workspace->strm.next_in = workspace->buf;
>> +                workspace->strm.avail_in = min(bytes_left,
>> +                                   in_buf_folios << PAGE_SHIFT);
>>               } else {
>>                   unsigned int pg_off;
>>                   unsigned int cur_len;
> 


