Return-Path: <linux-btrfs+bounces-15848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A653FB1B15B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F12AC7A6B88
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF09F261581;
	Tue,  5 Aug 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sw7Jqllq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FFF25F99B;
	Tue,  5 Aug 2025 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386918; cv=none; b=KjYDfCYm2CtKhI/io/GwpappvM2aeZiU3c6cOQP931/P7PxpmVjnFNQvsnZz77+sWtceLlwHP5DFUosShhm/WWBnXbl1AYhfWNqo+4HxT1av1m7RVulgR8t2m0uIlm4zo4GdmA9zo5CICNP6F/bweyOM7Go40gqJiVeA2R2F63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386918; c=relaxed/simple;
	bh=HAODYPF2rBhKemulCuoz/ctOy4RvHAOg5oksFUxstMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6sFFbzdyQ8szUKvDF/oQBfwrf9LVKJX/ubWZI3qXohfyBnV4YBoDxiQ/PUF+iFq3cNRRhEA82mpv7OXNO8q9ZxtgtGXaCv2fqYAYTVh42Duxo12Xl8GdK74QS37z6B0M9snTU8t9Js04uhu/u1yEpRq3404UucKzccqFky/BkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sw7Jqllq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5759b4DJ029114;
	Tue, 5 Aug 2025 09:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fNoiiw
	Wi08cK8p4mDoTlMP+o89qoOBFT3QPIgZXmUfA=; b=Sw7JqllqU1ibmbq6jbUAPf
	QQwXXoBQSJixNrU3oL2yZdYKReehejgg5AspbBTLYErNC5KYrFfC/rkVSPW3UiW3
	rC5MOJ3QonlFHQEy/dIHQJOGp8OEJ8I1N0ldDrEKXX47benv2XvqjtEpPZt4WWfc
	9Tnqaf6P8jSJwFE8koTMI1FLXnYaX8k9JtHzVhNGwt6XWozq7BYAoWRWbvP7p+Xi
	JswcYGIPPH8AriXm058BXVeeGEdcN/LCc2bAJxfLzj00Em5qB1EwQogqXRZhfWb+
	2L3LLINi8LOpVBbY+jCilQnsZa8/aqsVMOMUXdqOFVV7aMMPsg76Ge+j2dkfTT3A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3nm21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 09:41:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5759asX8018125;
	Tue, 5 Aug 2025 09:41:52 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ab3nm20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 09:41:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5755neq7004567;
	Tue, 5 Aug 2025 09:41:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2hjwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 09:41:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5759foRP56623482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 09:41:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0DEF2004B;
	Tue,  5 Aug 2025 09:41:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1494120043;
	Tue,  5 Aug 2025 09:41:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Aug 2025 09:41:47 +0000 (GMT)
Date: Tue, 5 Aug 2025 15:11:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ritesh.list@gmail.com, djwong@kernel.org,
        zlang@kernel.org, fdmanana@kernel.org
Subject: Re: [PATCH 3/7] btrfs/137: Make this compatible with all block sizes
Message-ID: <aJHR2fsx8ltPUuh5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <991278fd7cf9ea0d5eed18843e3fb96b5c4a3cac.1753769382.git.nirjhar.roy.lists@gmail.com>
 <c1feb41e-608b-4578-b7f7-bf9dd0801836@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1feb41e-608b-4578-b7f7-bf9dd0801836@gmx.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z+jsHGRA c=1 sm=1 tr=0 ts=6891d1e1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Ww7aUnnIYBbqKrYQ4FgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Kdnk-EGRROhbORvFkMmPRRGIuqTTp4r4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA2OCBTYWx0ZWRfX6jdL7bxDNDYA
 8lO32YS67vFpmugJ/IX6SOgbe8B39pEE+3Ik7uhEF8TOgxbaC8EtcUdDFitC1EZsUp5ni5QDpZV
 VZ5jc8z0BHzlr8EZepe292Y5Ha37sfQoB00z37J6Xv3P18wjduE8H2djWJ0Vxq+vAnCpjYJnwk/
 EkhhlXorIO8DlfkBUV45O4n6pzX45YdLMc5mpVCidqeMez8TcgUCHHFgHpFVoi/I1ovwUIGuOf6
 BVZc9eFizm3zcloPGbohr3/zzHeQWqLY7+YmaKVkIbTT7NtF/CUn8XTFiiIjdpz/jJVSTbO5kn7
 VkztCyUe86FkBSMWp6PM6o5yO+AWa0kEQ4uzwdnAWIxataMYho7HcGHEI/POkbiuVu0yVBXIIpa
 WuYtIV2VVl6A6ZhXccv3rHiWweKOY8Aw3Er4zift2C454pXy+4cFi8GpUjb+Dl/wlq4DcEUp
X-Proofpoint-GUID: _O_O4Z8pdmJ-IWHRCjDROMECnVOMmwWz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050068

On Mon, Aug 04, 2025 at 01:28:24PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/7/29 15:51, Nirjhar Roy (IBM) 写道:
> > For large blocksizes like 64k on powerpc with 64k pagesize
> > it failed simply because this test was written with 4k
> > block size in mind.
> > The first few lines of the error logs are as follows:
> > 
> >       d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
> > 
> >       File snap1/foo fiemap results in the original filesystem:
> >      -0: [0..7]: data
> >      +0: [0..127]: data
> > 
> >       File snap1/bar fiemap results in the original filesystem:
> >      ...
> > 
> > Fix this by making the test choose offsets based on
> > the blocksize.
> 
> I'm wondering, why not just use a fixed 64K block size?

Hi Qu,

It will definitely be simpler to just use 64k io size but I feel it
might be better to not hard code it for future proofing the tests. I
know right now we don't have bs > ps in btrfs but maybe we get it in the
future and we might start seeing funky block sizes > 64k.

Same goes for not hardcoding block mappings in the golden output. 

Regards,
ojaswin


