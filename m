Return-Path: <linux-btrfs+bounces-16319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94172B33610
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 07:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE2E1B211A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 05:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A189277C8A;
	Mon, 25 Aug 2025 05:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ua9c96SO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781323185D;
	Mon, 25 Aug 2025 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101321; cv=none; b=TylHxBqSuvImc5NgVBl/bIJ288bkyNXN9UA7V8vClbsUwI6WVBJs7iX9chgGVkMFgRy4IYHDmzafdjgKd1d50fYiwExBjFp6mp7OIo9RZHo1R+gOIlw0iQ+F6kRth0fP7/tNww0IBy0w6shDN5jAoYnwqiKFSMKI4wGxpzH5TCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101321; c=relaxed/simple;
	bh=iv8FwgtV/TpS3ZFOa/C5zoq7wyfeq82WHU2CpTcQUiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJv7vDXaZt5cmH58PEW76fYwd5ngOe3D3S1OJ8JxG5DMFXg8Mx/8xk6fKDevKLffJ0OgzXQOCBtJN2BBXz5ixWp8nJYtlp7Cqm/eJD8M03+j1tJGzpiTI+BUEmEN5plRf8cKJKmtiBjLpCdCXMq2msHIjnqyfHWDStEqPjkIPq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ua9c96SO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57OK06uX010633;
	Mon, 25 Aug 2025 05:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+8b175z+oFZqglTpRlNFkU6RXw6izm
	fcbCPkJCz/iKs=; b=Ua9c96SOBwsEAC5If/THDboYFRRQD/6QM1hiyr1aSyx3OZ
	JqbW8SEqH9Wiafk32nmw0AIyqT1X599hn70jnaaFjKJJRf8ZCS8DnAxHOIK05Cav
	tcsginyuKjHBfsx9VeTsuLOnFNU+5Y5q9n+r/AcaRoprBIWVYnIKSqQYiIdmkKhZ
	tL9shX8ARsdBBWAjM0grA425k+FHiiNPvh3RT1N8nlHp+nxq1/6goMSE+avgx8KL
	Lj12u6en7JsiHvOK8h5r3bWenQaoeC/FeHPWD8pa3Im4CEJ3kPa+nGpoUTrDL165
	gRS4M/PXq1npAluclgDsPzJSXAgzn5qspnxa20oA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q974xhfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 05:55:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57P5t9Rc022517;
	Mon, 25 Aug 2025 05:55:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q974xhfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 05:55:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57P1tQMP002473;
	Mon, 25 Aug 2025 05:55:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6m46du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 05:55:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57P5t6rX16843142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 05:55:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7CFE20040;
	Mon, 25 Aug 2025 05:55:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABDCD20043;
	Mon, 25 Aug 2025 05:55:04 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.34])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 25 Aug 2025 05:55:04 +0000 (GMT)
Date: Mon, 25 Aug 2025 11:25:02 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ritesh.list@gmail.com, djwong@kernel.org, zlang@kernel.org,
        fdmanana@kernel.org, quwenruo.btrfs@gmx.com
Subject: Re: [PATCH v3 0/4] btrfs: Misc test fixes for large block/node sizes
Message-ID: <aKv6tra6TKzX3x2l@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rcmw5JCIgbEjKHwp4H8YD5si8tWCwybq
X-Proofpoint-ORIG-GUID: J8T2suIDhglWO3MhJCWrd3-MPUUH5Qb9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA3MSBTYWx0ZWRfXw2lUA/BFdnii
 kVwX2xqf9odj3a4EPw0jLAJxgkq1g6HWCZ8IPe3xWlcy1G/GVsy+AkuLLEjSSpWlDYkxkBpEjTs
 ZN5kwk7OWG6LTvX49f75iTjMQAtfdfK2ZQ094fRkxzdyKWskHPP+yJ0j5DwMoQfEcWYAGUeNB2Y
 ZEhGhww6sfRqX2WLguMTx+OhITYtdNvD+OgpYXt2WP4WxvBmv36tJ6cpJj1BXL3zmxPCCKdbO3W
 UfsqACnY3CGonWtcpltC2K/nNvO6qPtL5K6Gsk8SyfMZYFmHF9IbE6oiGlm3JC1i8fwYGl5/umJ
 Co801DFV6EgxXCFi2vRJF2XdZN3KOiZVhxnzlEDc9IPafKTejh0bPyIBE+rGph0vBWA2uUhKILU
 mJieFE9b
X-Authority-Analysis: v=2.4 cv=RtDFLDmK c=1 sm=1 tr=0 ts=68abfabd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=syoCxIkN_KcqZOWISkMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230071

On Wed, Aug 20, 2025 at 08:15:03AM +0000, Nirjhar Roy (IBM) wrote:
> Some of the btrfs and generic tests are written with 4k block/node size in mind.
> This patch fixes some of those tests to be compatible with other block/node sizes too.
> We caught these bugs while running the auto group tests on btrfs with large
> block/node sizes.
> 
> [v2] -> v3
> 1. Added RBs by Qu Wenruo in btrfs/{301, 137}
> 2. Updated the commit message of generic/563 with a more detailed explanation
>    by Qu Wenrou.
> 3. Reverted by block size from 64k to 4k while filling the filesystem with dd
>    for test generic/274.

Hi Nirjhar, 

The changes look good. With the commit message typo fixed for
generic/563, feel free to add

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> 
> [v1] -> [v2]:
> 1. Removed the patch for btrfs/200 of [v1] - need more analysis on this.
> 2. Removed the first 2 patches of [v1] which introduced 2 new helper functions
> 3. btrfs/{137,301} and generic/274 - Instead of scaling the test dynamically
>    based on the underlying disk block size, I have hardcoded the pwrite blocksizes
>    and offsets to 64k which is aligned to all underlying fs block sizes <= 64.
> 4. For generic/563 - Doubled the iosize instead of btrfs specific hack to cover
>    for btrfs write ranges.
> 5. Updated the commit messages
> 
> [v1] - https://lore.kernel.org/all/cover.1753769382.git.nirjhar.roy.lists@gmail.com/
> [v2] - https://lore.kernel.org/all/cover.1755604735.git.nirjhar.roy.lists@gmail.com/
> 
> Nirjhar Roy (IBM) (4):
>   btrfs/301: Make the test compatible with all the supported block sizes
>   generic/274: Make the pwrite block sizes and offsets to 64k
>   btrfs/137: Make this test compatible with all supported block sizes
>   generic/563: Increase the iosize to to cover for btrfs
> 
>  tests/btrfs/137     | 11 ++++----
>  tests/btrfs/137.out | 66 ++++++++++++++++++++++-----------------------
>  tests/btrfs/301     |  2 +-
>  tests/generic/274   |  8 +++---
>  tests/generic/563   |  2 +-
>  5 files changed, 45 insertions(+), 44 deletions(-)
> 
> --
> 2.34.1
> 

