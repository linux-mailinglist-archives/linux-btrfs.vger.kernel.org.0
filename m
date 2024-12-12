Return-Path: <linux-btrfs+bounces-10323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 906139EECBC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F33281D04
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 15:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2852210DB;
	Thu, 12 Dec 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jp6frxlO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3E2135C1;
	Thu, 12 Dec 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017858; cv=none; b=KHT6f/uhb9lhS9up2m4pLreRYCN8gW7jIlPm9wBL1RU3bzbyt6GO4pwH2sBZMuVmDeaWl4i9oYgxrDGbXqSLTW0heYFTyJlJYa2depwD7WmhGYsOiBoup+JjLjpmYqPtjtrn/CclBIRyf6v/zL9Ky0W2oJEy40U2xoVX627HiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017858; c=relaxed/simple;
	bh=9NJoAGWx2pghEfc3rNKYfTIe5XjeR5Raa4KUfdF19to=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H5S72fzd9z/llIU3Aaz59BOH3NDnvc3eCCeL9xvKHnaRAV/6E+Uj35yXo/y1tJiGE7KYBf5AOdwqWwWNXSD0OAf5Etb2/JD8a3yjcmEfx1rqUOrp7Wli+hsAGCfVchIsW8FfJQFD7DFX6vfcmoybqaBUmRuw5LY5lduWqAOd6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jp6frxlO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCDVd9x001731;
	Thu, 12 Dec 2024 15:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9NJoAG
	Wx2pghEfc3rNKYfTIe5XjeR5Raa4KUfdF19to=; b=Jp6frxlOC/xCTD9M5/FSsA
	IjmVFbQ4mTgZx4Uqjvj6z/oY4W1lEZvUnq8xPRG0UEiM0BRhhW/uDTCxXV5R8AV2
	+/P01/MLhX2RooTAZrt84JeROxMC+V3hQweDz+n5t6T6viv+yJVgx6pyNK1C0Cpm
	rfTOZT1wK+Hyh6NkjPAbb631yEM/onO6wkvFrKnp1mNg0hGDSJM5AL9gsAPIohAq
	Y9uDSzevea9uGPod2iV+IagNLM6BI1VM5n+yWmn+qd3ghzVWYPYv0ECCXihr1ux9
	MsK0SBNkewz7PiXt4h/H5ia1oddKrXrsTsJO0Xqth0nG2ZaeE4NuAKtMBQBR9aFw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43g0sbgs05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:37:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCFGATn007776;
	Thu, 12 Dec 2024 15:37:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11tqgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 15:37:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCFbRSb17039666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 15:37:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76C3920043;
	Thu, 12 Dec 2024 15:37:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7A2D20040;
	Thu, 12 Dec 2024 15:37:26 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 15:37:26 +0000 (GMT)
Message-ID: <32b98d12e822557f23939a90dbaa091d9f8a4c97.camel@linux.ibm.com>
Subject: Re: [PATCH] btrfs: Fix avail_in bytes for s390 zlib HW compression
 path
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
	 <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Date: Thu, 12 Dec 2024 16:37:26 +0100
In-Reply-To: <20241212135000.1926110-1-zaslonko@linux.ibm.com>
References: <20241212135000.1926110-1-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nA6Yft9oKMLV31pWKHEtdPdA4AONx9MP
X-Proofpoint-ORIG-GUID: nA6Yft9oKMLV31pWKHEtdPdA4AONx9MP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412120112

On Thu, 2024-12-12 at 14:50 +0100, Mikhail Zaslonko wrote:
> Since the input data length passed to zlib_compress_folios() can be
> arbitrary, always setting strm.avail_in to a multiple of PAGE_SIZE
> may
> cause read-in bytes to exceed the input range. Currently this
> triggers
> an assert in btrfs_compress_folios() on the debug kernel. But it may
> potentially lead to data corruption.
> Fix strm.avail_in calculation for S390 hardware acceleration path.
>=20
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Fixes: fd1e75d0105d ("btrfs: make compression path to be subpage
> compatible")
> ---
> =C2=A0fs/btrfs/zlib.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

