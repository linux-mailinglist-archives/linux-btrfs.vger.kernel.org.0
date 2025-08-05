Return-Path: <linux-btrfs+bounces-15853-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D24B1B398
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 14:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56251824E9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA827145B;
	Tue,  5 Aug 2025 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="apZddKRo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C516B17BA9;
	Tue,  5 Aug 2025 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397593; cv=none; b=D0mC0XZ3i8k4okKWgKRBYEf86YMpaU6GgetQg4EDh2l03iozKBu8uxZif/6gK5BqYsNe1xSWWGSS/m4oD1aqFtCxDibKq1QHLVbaMso0rH5/OjzBQzFerei14n2S1ytPGyNHXfDdrvUr/0kICQW53j2z7xUx6MTZfp1Apg33J28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397593; c=relaxed/simple;
	bh=edPDIt1AaX6UuckjuBvdVqpCltHRr3o6WOoAWZvTahc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdD+SCyZ/KMw+8rxeTjyJhzCM415TKBtfwWWfkJxdTMBVwRFu32TYMWjoJrAWqbr99mhH+3d+MGU4MNVKsaqLhnAP36EQsoDfz2V7f3LDlOel8czrim+MiLi96p6PSTpx7HynsfTEtcAA4pxNFrvBfwilWWEYR1Vr0vAXO5lhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=apZddKRo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5758KRHW012663;
	Tue, 5 Aug 2025 12:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B9gcwj
	wxnPQ9sIxLZFz59p94BDBGQfjqU8vRpNhd9gM=; b=apZddKRobNxFBnaq16P8pH
	jhTnMYdeyx00ShKRV7IsfRgCS25D0mZ0EH0UEstkj9lUT3KaZMFlQq/LQZWyh0kH
	idND6fEBQHRqS/KZUlnVEAVnz0lsxpC21UbHZh+eo4dst1Ehx8IMNd76Tf50OqFb
	bz74R2zeVOUxa+fd4JKcaYZNSPjhnPBv7xMs/UI3AMLtuzXGxTvNtpMCZNF2VK+B
	TeWfKKG4G4Oc9mDnmACIPjbqRuAeb7wC9pcMw79AZjGQ1DEZsoeDsn9D2D9aJSLk
	Mf7e0C+wpIdtz5rQ3RPlmXMRsmzLsK3l2eCL5cszdIhw+26BqmYJVBBLxw6Nqfpw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4aa2exj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:39:43 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 575Cdght018409;
	Tue, 5 Aug 2025 12:39:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48a4aa2exg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:39:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57588xuY009807;
	Tue, 5 Aug 2025 12:39:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 489w0tjhjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:39:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575Cdd2553215570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 12:39:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8FCA20043;
	Tue,  5 Aug 2025 12:39:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6387320040;
	Tue,  5 Aug 2025 12:39:37 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Aug 2025 12:39:37 +0000 (GMT)
Date: Tue, 5 Aug 2025 18:09:30 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ritesh.list@gmail.com, djwong@kernel.org,
        zlang@kernel.org, fdmanana@kernel.org
Subject: Re: [PATCH 3/7] btrfs/137: Make this compatible with all block sizes
Message-ID: <aJH7gnC30mpqgB-f@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <991278fd7cf9ea0d5eed18843e3fb96b5c4a3cac.1753769382.git.nirjhar.roy.lists@gmail.com>
 <c1feb41e-608b-4578-b7f7-bf9dd0801836@gmx.com>
 <aJHR2fsx8ltPUuh5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <dd96b969-6e3f-44e2-a749-20dc9802ff8c@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd96b969-6e3f-44e2-a749-20dc9802ff8c@gmx.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3uFPdSeqICW2Lhq9zM_XwYmc9IrJmRBe
X-Authority-Analysis: v=2.4 cv=dNummPZb c=1 sm=1 tr=0 ts=6891fb8f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=yS3VqQiebRMzLwL0G-EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: f4imbGl3iPqYqMvfc1HsV8fbcx2-Siyj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5MCBTYWx0ZWRfX4o+vPRB0+f2b
 DEYHetm3JjVwRYxmQ0WGSp06YG8UVh5bV+oR58OAX392CK50g2XsPrjUDbtX4uI5AMk31gmw8jr
 X3+MOHVYwHKxZbto4JZIWvwwdt5xV4+Ji+txgAfo61l6z22kgXCIZQLQJkt8nAdcMu2T3lZHxRM
 idRggt8arWu4e+oUKdDpahU9Y8Cuxuc4L7NgI2ppGkAGmC2u30Z7MufkFOg4wzyFOY7DHpvqBYJ
 TAOKcSv1XfZ41Wv6YAoXak/f25N1x0k3zwmOPgaqircCv68OuAI2HKFqLZi8WsqVzo2tD6W87d4
 WGk4mF0UMCOPnKxlhs6ws8hXLa69dM6EEIWj1eJFLnCoElJGN9YtGyRF2QmlPgnLOvAwK8hT9ZG
 61YiH4nj71VLdgBMh5+zrlU6k++HSIpZEEi82Zn0DmdVKyObZThY9O/vcX333ZoRem2S2nif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050090

On Tue, Aug 05, 2025 at 07:14:52PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/5 19:11, Ojaswin Mujoo 写道:
> > On Mon, Aug 04, 2025 at 01:28:24PM +0930, Qu Wenruo wrote:
> > > 
> > > 
> > > 在 2025/7/29 15:51, Nirjhar Roy (IBM) 写道:
> > > > For large blocksizes like 64k on powerpc with 64k pagesize
> > > > it failed simply because this test was written with 4k
> > > > block size in mind.
> > > > The first few lines of the error logs are as follows:
> > > > 
> > > >        d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
> > > > 
> > > >        File snap1/foo fiemap results in the original filesystem:
> > > >       -0: [0..7]: data
> > > >       +0: [0..127]: data
> > > > 
> > > >        File snap1/bar fiemap results in the original filesystem:
> > > >       ...
> > > > 
> > > > Fix this by making the test choose offsets based on
> > > > the blocksize.
> > > 
> > > I'm wondering, why not just use a fixed 64K block size?
> > 
> > Hi Qu,
> > 
> > It will definitely be simpler to just use 64k io size but I feel it
> > might be better to not hard code it for future proofing the tests. I
> > know right now we don't have bs > ps in btrfs but maybe we get it in the
> > future and we might start seeing funky block sizes > 64k.
> 
> And in fact I'm going to add that bs > ps support very soon, since we
> already have large folio support for data, it will be just a simple
> mapping_set_folio_order_range() with a min order.
> 
> But still for btrfs, we're only going to support 4K, 8K, 16K, 32K, 64K block
> sizes, thus I don't think we need to bother larger bs yet.
> 
> Thanks,
> Qu

Okay sure, if you feel 64k should be okay for considerable future then
lets hardcode it for simplicity.

Regards,
ojaswin
> 
> > 
> > Same goes for not hardcoding block mappings in the golden output.
> > 
> > Regards,
> > ojaswin
> > 
> > 
> 

