Return-Path: <linux-btrfs+bounces-16293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B56B31B5D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 16:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D0D1D40F51
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 14:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A8A30E84D;
	Fri, 22 Aug 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X+wvJLB7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF8301476;
	Fri, 22 Aug 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872351; cv=none; b=jJZLSl8ekCOEdQO1QDsAHBIuGtQ/i99Fjeb77iLsb2eYEXjTcwI60W3v9Htm/9j6Tm2DOUX9VEOMGHzcPRVyMpap/BKze4VJefsCgKX2IUjBvFMjAYmQnc2gsX1PkqZaIvM2Yz1E8C+wiX16F7alc/mFhO1TOIieo0kc7LyejYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872351; c=relaxed/simple;
	bh=WRokWTnxCLPeTqdFMLrlXZcMpdtYNRxgG4shIryou7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8YaWa47e5h2GVokos1tvShD72b2oNYBLvnu0NGgKdv8mqKvPZ7UkVkTWBCZSRkA4+I/DWC/v7qVmRKJkvgZhhv8WiYhiuREGHE/7JLYmTYd5LvqJS1ltShQ7/gFHHVeaImHDCG834vuqUypfzhnh/DGBDnGJZ0kYNbKGD7AsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X+wvJLB7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCZ4H7012075;
	Fri, 22 Aug 2025 14:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ASMVx9
	rK4O5ZwAnPYsdo/EcOlfjZnXjy6qSOE3tN0p8=; b=X+wvJLB7GQTh+NWWegJkqH
	5KtnZTQxVtYquXnCenWJbnowdYvhFo4hrwp4URBg2Vg8CsR4OZR95/G2haym/dnL
	B/rgBCnzy/4lZ5cexZyOSxqcyz8F7rir7TJ5v1rJy4hBIK/ReebjO/tNbcMRyAYM
	ODA6q+sLdSCXdzz53rD8RkhWILBcVVl3i0If/aZWn5jwYnkQh4t7W4uLzmvVK6NS
	lZOutTB1aNi7NEeQ49uBLhdMzQ3D4tK/k4F+9mFT+s24j5fjtCuTIAL+BjrGimw8
	8sU4tQfx6lhgKZCKmDdKtbupwzLwRmRaQThUQLmgkiIS9GlQd69IJpugDlPrrHbw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vq01v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:19:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ME5AMD010464;
	Fri, 22 Aug 2025 14:19:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vq01u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:19:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57MBrxxp016047;
	Fri, 22 Aug 2025 14:19:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my42dnau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:19:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57MEJ3WG46858610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 14:19:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D54AD2004E;
	Fri, 22 Aug 2025 14:19:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2D0420040;
	Fri, 22 Aug 2025 14:19:01 +0000 (GMT)
Received: from [9.124.211.112] (unknown [9.124.211.112])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 14:19:01 +0000 (GMT)
Message-ID: <fcc241b7-2323-4375-9ce2-40eada4966f8@linux.ibm.com>
Date: Fri, 22 Aug 2025 19:49:00 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] btrfs/301: Make the test compatible with all the
 supported block sizes
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        djwong@kernel.org, zlang@kernel.org, fdmanana@kernel.org,
        quwenruo.btrfs@gmx.com
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
 <83e91ed9d2b55bdf6e63f9607267d36e31548f07.1755677274.git.nirjhar.roy.lists@gmail.com>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <83e91ed9d2b55bdf6e63f9607267d36e31548f07.1755677274.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O4BQDj4XSRS3CY_bv3G_GH_8UYz3LSsU
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a87c5b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=7uthoOmeVXD2Lgiy:21 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=iox4zFpeAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=koGjpdFuyeTUt37SJvoA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX7bckOKCLjgkP
 xSL24T+L9X6xg0GcYz9MxX7IKD2fk7CCzgLlLif2MfEd6sOOG1/UD3JCbItNOmwMos6uvFh287w
 QX7TJ8EC+HfiUCWVMwm3T9FLhQOzH51TKR4B+o57Mv3lYCVBseE0OWqTJtz3TLhWpoiqNgH4W1g
 zJeMVlmQr7ssDTs1UtymDnuRF3GmrekpBKrdyzQT7O0nVDoMaZth3TLsU19OjzlDCsNij2UWpj7
 pRNbc23roR0O/f7VWifSz7+dPdHIMgQORzf51zNNVI3jIUWJGtKUKJkIFyYeG41hRKDG4UhK24/
 EbV1NouU757JPgAwx0uxQ6/tRMOPgLNWu0JHqSjHBZIbRUSXkZK8D9CK8UR2AyE4Ov53HagcPVm
 Rqw39pDpph1ir7WnWRI9itdWslCiDg==
X-Proofpoint-ORIG-GUID: f0CgAXpT8xlVUlcTNwfyZsDM4Gj0bmvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

On 20/08/25 1:45 pm, Nirjhar Roy (IBM) wrote:
> With large block sizes like 64k the test failed with the
> following logs:
> 
>       QA output created by 301
>       basic accounting
>      +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 168165376 vs 138805248 (expected data 138412032 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
>       fallocate: Disk quota exceeded
> 
> The test creates nr_fill files each of size 8k. Now with 64k
> block size, 8k sized files occupy more than the expected sizes (i.e, 8k)
> due to internal fragmentation, since 1 file will occupy at least 1
> fsblock. Fix this by making the file size 64k, which is aligned
> with all the supported block sizes.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

I tested it on Power, and the btrfs/301 test passes with both 4k & 64k 
block sizes.

SECTION       -- btrfs_64k
RECREATING    -- btrfs on /dev/loop0
FSTYP         -- btrfs
PLATFORM      -- Linux/ppc64le localhost 6.17.0-rc2-00060-g068a56e56fa8 
#3 SMP Thu Aug 21 17:54:04 IST 2025
MKFS_OPTIONS  -- -f -s 65536 -n 65536 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

btrfs/301 67s ...  111s
Ran: btrfs/301
Passed all 1 tests

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/btrfs/301 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index 6b59749d..be346f52 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -23,7 +23,7 @@ subv=$SCRATCH_MNT/subv
>   nested=$SCRATCH_MNT/subv/nested
>   snap=$SCRATCH_MNT/snap
>   nr_fill=512
> -fill_sz=$((8 * 1024))
> +fill_sz=$((64 * 1024))
>   total_fill=$(($nr_fill * $fill_sz))
>   nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
>   					grep nodesize | $AWK_PROG '{print $2}')


