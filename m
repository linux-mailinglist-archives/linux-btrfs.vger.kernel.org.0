Return-Path: <linux-btrfs+bounces-16294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A510CB31C00
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 16:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B011D637DD
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 14:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9131733CE8A;
	Fri, 22 Aug 2025 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S/UW/rlC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92F311C12;
	Fri, 22 Aug 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872744; cv=none; b=hGlu4YSq0FBe18xV/4NVoK2isJGmaTZTS7shI2nc0cmR8+xvGmHvxNJqNjBA4BCdqg4QWf4jBNXk8joEB6DCW954xB8OZ6cD+PzTfXEIKQIcnEVFxBxZD8KoEFrdF6fwpHSYa6wMquYK0FM6/ykQx8DUXfA3NdKQla8YhuPtq5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872744; c=relaxed/simple;
	bh=W7cj8PVdksOVQCo6MBpxCJcaOB3wHTvywOyi3Ztf13g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bD9jSKF8MLS1J9JMal3UkTcKlzj1L7fn5UOrZhiYUkSFb9C7droGdULoKY15YOy5/VfKXwIjvKJLk48+bSL+21mq0eCF/l31GoHGDZ0r4Afss5Rh8sDl2495aPPvI/Kd81YPxwWqxenzwOmiAuEQ5rHxMfqS4MDuXN4VVaZpMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S/UW/rlC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MATC2e011984;
	Fri, 22 Aug 2025 14:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0HAuRt
	40y4XMwevWl3s8tmhIiiBGmgrI7p4PEXeLXFo=; b=S/UW/rlCKelLQer0jwwZW3
	+WSEWYwUqeEviMpHFsFfCm4T9GsePQoF4LXn7VQarAoIgSZZiPR3Nbb+K+41wgBG
	k5hIJsEiWvwtbfVt6vMRNUn6IWf+0jpRO5ZF9LfQyfR7UL0nJztU8ZnnhLHDT5yC
	FgZt/GHYXjnVXExqxw3LOA5Ufx48894CwNl1xf45VVHxWskHPNRnNd9C8sCQhlnz
	gmEzII0mI2PQx9pobuZH4KYuNZ4HioIv79Itz4iV6CPQuaV6G4/+CAT+Kyx5g6Pm
	wihPlZfQCbxRH709/UJ2Ni0s07yImMBu2b0cMB1eFwg3Wn0MCBUb5ae/x/Mrhwig
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vq11m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:25:40 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57MELZOq010362;
	Fri, 22 Aug 2025 14:25:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vq11j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:25:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCiGSZ024219;
	Fri, 22 Aug 2025 14:25:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my43wnq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:25:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57MEPbXT31916778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 14:25:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57AB92004B;
	Fri, 22 Aug 2025 14:25:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BF3320040;
	Fri, 22 Aug 2025 14:25:35 +0000 (GMT)
Received: from [9.124.211.112] (unknown [9.124.211.112])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 14:25:35 +0000 (GMT)
Message-ID: <e079aefa-b6d3-4f15-b320-6d2fe1beb3a9@linux.ibm.com>
Date: Fri, 22 Aug 2025 19:55:34 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] generic/274: Make the pwrite block sizes and
 offsets to 64k
Content-Language: en-GB
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        djwong@kernel.org, zlang@kernel.org, fdmanana@kernel.org,
        quwenruo.btrfs@gmx.com
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
 <1110f20bb5d26b4bef5596a00d69c3459709ab65.1755677274.git.nirjhar.roy.lists@gmail.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <1110f20bb5d26b4bef5596a00d69c3459709ab65.1755677274.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2XENdC3GvUbj0is8OZjjbaUMqZ0RmhPq
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a87de4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=9AFdbDJI52V1dAe_MRkA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX1IqVbQVTP7B5
 9sW8bX5NaC+SESQ0HwuKw6q19wTxw4JVun/slPs7i5D0MWpbi8Vr78hswAqTaEjN27r+Q8WCt4+
 a6SOyRQG1aDNA34frQwcWj/7N1n1FKJYDInPCvjfmVKuZXBAAytTieB3J4os3nGcCQt3OcKf18s
 D4lt8CMbN1F50RZCDW80pSHxTeh3vm8RZNIl1Lqmh6xpI81N7OpDqlTWdJysAUOtqYfv/SYUkcw
 jB8hhTKPrIhkfPqifbDGJcsqD3I75FNA5hzvNNoMGkO1oXmdlIOxgzwkkUXUZr/OD4OH5vNMsgi
 /BmznznmziJx2jSarsm5j8I/dk6ZcRGCh8bpTx/wKlh96ZWVcxo7OW2GHYI/U0eIVxgKkdKoSew
 T9i+bMaaA1GA1tpOWxTRG5nOqmpCRA==
X-Proofpoint-ORIG-GUID: xS4gXX0PHh7buloF1PxnPYFtlo9jAwx8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

On 20/08/25 1:45 pm, Nirjhar Roy (IBM) wrote:
> This test was written with 4k block size in mind and it fails with
> 64k block size when tested with btrfs.
> The test first does pre-allocation, then fills up the
> filesystem. After that it tries to fragment and fill holes at offsets
> of 4k(i.e, 1 fsblock) - which works fine with 4k block size, but with
> 64k block size, the test tries to fragment and fill holes within
> 1 fsblock(of size 64k). This results in overwrite of 64k fsblocks
> and the write fails. The reason for this failure is that during
> overwrite, there is no more space available for COW.
> Fix this by changing the pwrite block size and offsets to 64k
> so that the test never tries to punch holes or overwrite within 1 fsblock
> and the test becomes compatible with all block sizes.
> 
> For non-COW filesystems/files, this test should work even if the
> underlying filesytem block size > 64k.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

I tested it on Power, and the generic/274 test passes with both 4k & 64k 
block sizes.

SECTION       -- btrfs_64k
RECREATING    -- btrfs on /dev/loop0
FSTYP         -- btrfs
PLATFORM      -- Linux/ppc64le localhost 6.17.0-rc2-00060-g068a56e56fa8 
#3 SMP Thu Aug 21 17:54:04 IST 2025
MKFS_OPTIONS  -- -f -s 65536 -n 65536 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

generic/274 53s ...  57s
Ran: generic/274
Passed all 1 tests

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/generic/274 | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/274 b/tests/generic/274
> index 916c7173..f6c7884e 100755
> --- a/tests/generic/274
> +++ b/tests/generic/274
> @@ -40,8 +40,8 @@ _scratch_unmount 2>/dev/null
>   _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
>   _scratch_mount
>   
> -# Create a 4k file and Allocate 4M past EOF on that file
> -$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc -k 4k 4m" $SCRATCH_MNT/test \
> +# Create a 64k file and Allocate 64M past EOF on that file
> +$XFS_IO_PROG -f -c "pwrite 0 64k" -c "falloc -k 64k 64m" $SCRATCH_MNT/test \
>   	>>$seqres.full 2>&1 || _fail "failed to create test file"
>   
>   # Fill the rest of the fs completely
> @@ -63,7 +63,7 @@ df $SCRATCH_MNT >>$seqres.full 2>&1
>   echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
>   for i in `seq 1 2 1023`; do
>   	echo -n "$i " >> $seqres.full
> -	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
> +	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
>   		>>$seqres.full 2>/dev/null || _fail "failed to write to test file"
>   done
>   _scratch_sync
> @@ -71,7 +71,7 @@ echo >> $seqres.full
>   echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
>   for i in `seq 2 2 1023`; do
>   	echo -n "$i " >> $seqres.full
> -	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
> +	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
>   		>>$seqres.full 2>/dev/null || _fail "failed to fill test file"
>   done
>   _scratch_sync


