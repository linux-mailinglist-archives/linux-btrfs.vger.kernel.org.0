Return-Path: <linux-btrfs+bounces-16297-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BFFB31C5C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 16:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53BF71CC10B9
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 14:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5754D305E05;
	Fri, 22 Aug 2025 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GxgHjcQd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B9301476;
	Fri, 22 Aug 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873482; cv=none; b=MyY4809ScY7g7fSX88238izXhEE7yrcf7a2l5CcMUcyxLib8H5iM5Or4vNmqH3YaD0Ij1ZHqnhvpgGWkLmhdWsIFcrSBW/aI2ugva4vYX46XOjVMgTUOuSlgyRbuGIWOXPd4JOsRgBE+IL4bX9wr6TNt3THbsysYZ3eeMXB9h3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873482; c=relaxed/simple;
	bh=0aQ87Z9YPm7YRzXx/jqudE3hhFx9OOJZrExPAgcEGQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qU4pVsIzigeno0R28Icac6xoTFw9q9oUAINKzhTQMwk6DB9UfypBkDZ10ti2iaHNrWNvjWlWgy4PyD5pD21Vglxwo7+sxr+yPlOjQTUWebClhJJkeL7CQ9tpLNH5XLlNaD0AgJzbHbe9YzClEs2tPuTMvY9lPh0rYqn0JJAKh98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GxgHjcQd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7rdj8026178;
	Fri, 22 Aug 2025 14:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5DZl15
	J8sjFwFeMO7jk4e5fCN/jkYuYnllKgv6wKg3s=; b=GxgHjcQdqIX/V5v1JxJPz/
	Vp2vOeqmoJJn3QEbzprrb3RoNsKOlgWt7NIThAxf36sMAaxPQNF+ey1CTMDCAiLp
	heQ/Xs3tyZipeRht/Q/3UauF3w1+PWVvlV1I71Cw4HIAff2R1QF4rN7A51jedUzN
	kSDKt4hbqg0NvihgMg9yXL+AjN4k0fO1kAVUxH8vdLfRYWpJM6ZP48rogiedP0Em
	IK4DtqNs5evPjm3subqzQyIAncBL1Y4dIpuOcSrKO5xzThw+MU6mPRsN4RjyQ9Oy
	BzJ33iBMO8Gqxjeyag8GL3f24lmIj0llbFSmEHfy8Hwd2a0S3VDakfjOijGVlb8w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vq37k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:37:58 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57MEY0T0028125;
	Fri, 22 Aug 2025 14:37:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vq37g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:37:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57MC0DTV016013;
	Fri, 22 Aug 2025 14:37:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my42dpxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:37:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57MEbtb032571930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 14:37:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48A6820043;
	Fri, 22 Aug 2025 14:37:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5329920040;
	Fri, 22 Aug 2025 14:37:53 +0000 (GMT)
Received: from [9.124.211.112] (unknown [9.124.211.112])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 14:37:53 +0000 (GMT)
Message-ID: <501cb5ba-4890-4f1c-815a-4b15cf7942e8@linux.ibm.com>
Date: Fri, 22 Aug 2025 20:07:52 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] generic/563: Increase the iosize to to cover for
 btrfs
Content-Language: en-GB
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        djwong@kernel.org, zlang@kernel.org, fdmanana@kernel.org,
        quwenruo.btrfs@gmx.com
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
 <7e337d30307b293b30c6ad00c1fc222bbeed640c.1755677274.git.nirjhar.roy.lists@gmail.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <7e337d30307b293b30c6ad00c1fc222bbeed640c.1755677274.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX6B2gZNbafu2e
 GAjM90lZA6fruu2RUq/jpkyR1ir4PgN5FYQtC+Xa3R8gzQTDCY26jJVc8cxYY+SwA9wsz4D3+yT
 Kx6dSBNRmqWo7Vl92S8/ZulEDIFnkaZqlMRKWl0x6iS9gGHhb5JTIWKyUvSS2bp/aBWL0oPESGb
 lIVOtEUj1RBlOui5C6aRmXJWd0wWGnY3XSu5DBpLUKvlviDk2x9CdF74gB7jolJ1k6MYC3T8W36
 fE4JQNSkWdYGY7ZBNzwIPdLR8ArUzkWV7RDK1nBmT4z10cNcBnYQ47LkzlJhiu5vON79G1L/Zod
 ZjvX0iI+wgDSYapKmvwsL1FphhmWSPAB7zVkHOgts44twm8jW0bct02fCIb/whzl0cGTPf2g8vO
 EePZC3DeLwpfNltpv+sZTQ9ozt93NA==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a880c6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=dg36b7u27vu_zB18:21 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=7YfXLusrAAAA:8 a=iox4zFpeAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=eZ7gknJ-1AbwHKOAYn4A:9 a=QEXdDO2ut3YA:10 a=SLz71HocmBbuEhFRYD3r:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: i7Srgv9yG9Rcgno0M7kbq1kM_E9hTI7T
X-Proofpoint-ORIG-GUID: uYZZ3Y9Jk21r-J07SJZE_luhWBHM1Lww
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

On 20/08/25 1:45 pm, Nirjhar Roy (IBM) wrote:
> When tested with block size/node size 64K on btrfs, then the test fails
> with the folllowing error:
>       QA output created by 563
>       read/write
>       read is in range
>      -write is in range
>      +write has value of 8855552
>      +write is NOT in range 7969177.6 .. 8808038.4
>       write -> read/write
>      ...
> The slight increase in the amount of bytes that are written is because
> of the increase in the the nodesize(metadata) and hence it exceeds
> the tolerance limit slightly. Fix this by increasing the iosize.
> Increasing the iosize increases the tolerance range and covers the
> tolerance for btrfs higher node sizes.
> A very detailed explanation is given by Qu Wenruo in [1]
> 
> [1] https://lore.kernel.org/all/fa0dc9e3-2025-49f2-9f20-71190382fce5@gmx.com/
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

The patch looks good. However, the subject line seems incorrect, could 
you please fix it.

I tested it on Power, and the generic/563 test passes with both 4k & 64k 
block sizes.

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/generic/563 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/563 b/tests/generic/563
> index 89a71aa4..6cb9ddb0 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -43,7 +43,7 @@ _require_block_device $SCRATCH_DEV
>   _require_non_zoned_device ${SCRATCH_DEV}
>   
>   cgdir=$CGROUP2_PATH
> -iosize=$((1024 * 1024 * 8))
> +iosize=$((1024 * 1024 * 16))
>   
>   # Check cgroup read/write charges against expected values. Allow for some
>   # tolerance as different filesystems seem to account slightly differently.


