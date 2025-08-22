Return-Path: <linux-btrfs+bounces-16295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF381B31C09
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC97966041F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Aug 2025 14:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B6D3375AF;
	Fri, 22 Aug 2025 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kumni1r7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790E92561AB;
	Fri, 22 Aug 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872885; cv=none; b=j20WYht63X1QyG6YCynFf7vsZfMU6ryJ6DFB5bI9Vpi1VM8jk3nKM4Di6NsaqBjbrE+AKD5H8r4jr1oPQWSagycw6hrQryZot4B4H46RXA17yg4PjImlXTY15Sne1sxZedk8S6HoyyWutWKIPLF53czzD2IoPwMADAsghkFbGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872885; c=relaxed/simple;
	bh=Uc/2YNo1B6sY+gGqwyjgH3Mq9wt6Mdw6eKN9/X03YiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kAJ5h4ru0zRfXAP4jmkvnTadLb1hkdWds7uhQ1hTH+pUgLZrnBQ7u98dwQMRkwUi+hjpqY827jBR5L0QGCluHUdh6ma3kcrffrCcYUfZgyt4owEdJJeGddqJi3xGQVzZYvsOhKpvfTT4FgjRRwIR/03InfOWMxkxIgpZS3Qe7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kumni1r7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7JX8T012800;
	Fri, 22 Aug 2025 14:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f3kfrr
	rY090nJ2lNiKPwnUTtCSLsRyWTuX3dPdeT3IU=; b=kumni1r7B6B3m1/q16GZ0W
	TfdcRU7BKvi4+UZnr/Ca5fCCxcyYDypXaWFMhjMFWgMC8ZHHoluoaeF4qJ5b2uoq
	ANsw5N5O4tg38Fj9O7a3suPR3Q1E3n5ZhS2A3fTVsTkVH3XZfdmhRg4VLAABNCMb
	tWHiC1w6bOaAiONhSShdzzqyJlwLs7a9qhvL0CV2t5hLiZ1Jfz48YNrn4KG2l0L6
	3vSrcmp46cGpcYabOgGCkn2wBea3xoqB2qk5z3gzGMO16CwruOF89pMmob/P6lvS
	24LSHKkW883jEJmDE8sNDpOuctMN877m6u3H8x/20tU0z1T4nTZi8JQY+6I9hqUQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vxu1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:27:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57MEPNDN008702;
	Fri, 22 Aug 2025 14:27:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vxu1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:27:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57MCeB0T024778;
	Fri, 22 Aug 2025 14:27:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my5w5mxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 14:27:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57MERuwt41288098
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 14:27:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E3CE20040;
	Fri, 22 Aug 2025 14:27:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A854820043;
	Fri, 22 Aug 2025 14:27:54 +0000 (GMT)
Received: from [9.124.211.112] (unknown [9.124.211.112])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 14:27:54 +0000 (GMT)
Message-ID: <845a62e3-2c10-4fd8-9a62-ff01e5f921db@linux.ibm.com>
Date: Fri, 22 Aug 2025 19:57:53 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] btrfs/137: Make this test compatible with all
 supported block sizes
Content-Language: en-GB
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
        djwong@kernel.org, zlang@kernel.org, fdmanana@kernel.org,
        quwenruo.btrfs@gmx.com
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
 <88dcfb6cea422cebc5bbdcd4a0ba912f9c8666fa.1755677274.git.nirjhar.roy.lists@gmail.com>
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <88dcfb6cea422cebc5bbdcd4a0ba912f9c8666fa.1755677274.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX7fwC2BfiqyyE
 IGYyRegB3ykQ1I/BPkfzwxoTl7vKzz2HG7yBK8UlGJl0kf4JcVM4cHfWBxjf/qCIUgSjk/a0ig+
 39TkHMEbub3Y2qL13b+PrCffKCMNihOIIE0R8kn/dyYcrEnhrAoyiMEuUNVR0UUxf3Hz2XUd6Ni
 iqyKzw06TfTBBRlZJyD+CNMgovP+/92bq4nuTgDjlGTpBNGWgCm4+KITE8gE7bMT4YL5bpuQry3
 RXZ7mTFVrT9BIdkfGCPV5pL191STfkPI+X1+osjT0scov31o/X++4l6NTAlDcCuOW34KifbBpxI
 QvSzl2dFXABgp7o8sWGqg1SsmQ2qqQg/Nph4cGNEA5320T6buaihGRLkwXvD5/Mtupwx57GcVwl
 ZIU15My3VGX1ReZDrLMndwtD8SC/vA==
X-Proofpoint-ORIG-GUID: MZlHaesuUGPUzSeV28DAKD6sHtG8PTg6
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a87e6f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=iox4zFpeAAAA:8 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=M7u16W5OUpISNRXCUzAA:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: RiBba16E8eWgoh2SpN56vSWzxDyevgOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

On 20/08/25 1:45 pm, Nirjhar Roy (IBM) wrote:
> For large block sizes like 64k it failed simply because this
> test was written with 4k block size in mind.
> The first few lines of the error logs are as follows:
> 
>       d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
> 
>       File snap1/foo fiemap results in the original filesystem:
>      -0: [0..7]: data
>      +0: [0..127]: data
> 
>       File snap1/bar fiemap results in the original filesystem:
>      ...
> 
> Fix this by making the test choose offsets and block size as 64k
> which is aligned with all the underlying supported fs block sizes.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

I tested it on Power, and the btrfs/137 test passes with both 4k & 64k 
block sizes.

SECTION       -- btrfs_64k
RECREATING    -- btrfs on /dev/loop0
FSTYP         -- btrfs
PLATFORM      -- Linux/ppc64le localhost 6.17.0-rc2-00060-g068a56e56fa8 
#3 SMP Thu Aug 21 17:54:04 IST 2025
MKFS_OPTIONS  -- -f -s 65536 -n 65536 /dev/loop1
MOUNT_OPTIONS -- /dev/loop1 /mnt/scratch

btrfs/137 2s ...  1s
Ran: btrfs/137
Passed all 1 tests

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   tests/btrfs/137     | 11 ++++----
>   tests/btrfs/137.out | 66 ++++++++++++++++++++++-----------------------
>   2 files changed, 39 insertions(+), 38 deletions(-)
> 
> diff --git a/tests/btrfs/137 b/tests/btrfs/137
> index 7710dc18..c1d498bd 100755
> --- a/tests/btrfs/137
> +++ b/tests/btrfs/137
> @@ -23,6 +23,7 @@ _cleanup()
>   _require_test
>   _require_scratch
>   _require_xfs_io_command "fiemap"
> +_require_btrfs_no_compress
>   
>   send_files_dir=$TEST_DIR/btrfs-test-$seq
>   
> @@ -33,12 +34,12 @@ _scratch_mkfs >>$seqres.full 2>&1
>   _scratch_mount
>   
>   # Create the first test file.
> -$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 4K" $SCRATCH_MNT/foo | _filter_xfs_io
> +$XFS_IO_PROG -f -c "pwrite -S 0xaa -b 64k 0 64K" $SCRATCH_MNT/foo | _filter_xfs_io
>   
>   # Create a second test file with a 1Mb hole.
>   $XFS_IO_PROG -f \
> -     -c "pwrite -S 0xaa 0 4K" \
> -     -c "pwrite -S 0xbb 1028K 4K" \
> +     -c "pwrite -S 0xaa -b 64k 0 64K" \
> +     -c "pwrite -S 0xbb -b 64k 1088K 64K" \
>        $SCRATCH_MNT/bar | _filter_xfs_io
>   
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
> @@ -46,10 +47,10 @@ $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
>   
>   # Now add one new extent to our first test file, increasing its size and leaving
>   # a 1Mb hole between the first extent and this new extent.
> -$XFS_IO_PROG -c "pwrite -S 0xbb 1028K 4K" $SCRATCH_MNT/foo | _filter_xfs_io
> +$XFS_IO_PROG -c "pwrite -S 0xbb -b 64k 1088K 64K" $SCRATCH_MNT/foo | _filter_xfs_io
>   
>   # Now overwrite the last extent of our second test file.
> -$XFS_IO_PROG -c "pwrite -S 0xcc 1028K 4K" $SCRATCH_MNT/bar | _filter_xfs_io
> +$XFS_IO_PROG -c "pwrite -S 0xcc -b 64k 1088K 64K" $SCRATCH_MNT/bar | _filter_xfs_io
>   
>   $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
>   		 $SCRATCH_MNT/snap2 >/dev/null
> diff --git a/tests/btrfs/137.out b/tests/btrfs/137.out
> index 8554399f..e863dd51 100644
> --- a/tests/btrfs/137.out
> +++ b/tests/btrfs/137.out
> @@ -1,63 +1,63 @@
>   QA output created by 137
> -wrote 4096/4096 bytes at offset 0
> +wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 4096/4096 bytes at offset 0
> +wrote 65536/65536 bytes at offset 0
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 4096/4096 bytes at offset 1052672
> +wrote 65536/65536 bytes at offset 1114112
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 4096/4096 bytes at offset 1052672
> +wrote 65536/65536 bytes at offset 1114112
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -wrote 4096/4096 bytes at offset 1052672
> +wrote 65536/65536 bytes at offset 1114112
>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   
>   File digests in the original filesystem:
> -3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/snap1/foo
> -f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap1/bar
> -f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap2/foo
> -d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
> +9802287a6faa01a1fd0e01732b732fca  SCRATCH_MNT/snap1/foo
> +fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap1/bar
> +fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap2/foo
> +8d06f9b5841190b586a7526d0dd356f3  SCRATCH_MNT/snap2/bar
>   
>   File snap1/foo fiemap results in the original filesystem:
> -0: [0..7]: data
> +0: [0..127]: data
>   
>   File snap1/bar fiemap results in the original filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data
>   
>   File snap2/foo fiemap results in the original filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data
>   
>   File snap2/bar fiemap results in the original filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data
>   
>   At subvol SCRATCH_MNT/snap1
>   At subvol SCRATCH_MNT/snap2
>   At subvol snap1
>   
>   File digests in the new filesystem:
> -3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/snap1/foo
> -f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap1/bar
> -f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap2/foo
> -d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
> +9802287a6faa01a1fd0e01732b732fca  SCRATCH_MNT/snap1/foo
> +fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap1/bar
> +fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap2/foo
> +8d06f9b5841190b586a7526d0dd356f3  SCRATCH_MNT/snap2/bar
>   
>   File snap1/foo fiemap results in the new filesystem:
> -0: [0..7]: data
> +0: [0..127]: data
>   
>   File snap1/bar fiemap results in the new filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data
>   
>   File snap2/foo fiemap results in the new filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data
>   
>   File snap2/bar fiemap results in the new filesystem:
> -0: [0..7]: data
> -1: [8..2055]: hole
> -2: [2056..2063]: data
> +0: [0..127]: data
> +1: [128..2175]: hole
> +2: [2176..2303]: data


