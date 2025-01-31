Return-Path: <linux-btrfs+bounces-11199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D33A23C46
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 11:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5442188A66A
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FCA1ADC6E;
	Fri, 31 Jan 2025 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cx3PalL4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609D1ACECA
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738319372; cv=none; b=LpgDRlhImCFphPMSvU2ureaF52b+lXxk3F0O1O+mTSlpHge5gRWZAPxVLpJEtgcLEJw+PDrloUB1m7J5rKDeRYwLlkzx6beSB7FUGQpPZ0btNcY0c8zvh7568FV48LNxu8tSgc5uyakrZq1vhKKrukwWRHvcLbBsWIEa4D8Pn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738319372; c=relaxed/simple;
	bh=9nJQjq9R3hBNLyelicqEGV2XcMx5dohm9QPNJXy8K3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XcfeqgXCtvH4FCRIXpshAcAgJtwKMxCSrgfuMH4w/aeBJGEzejRebB/TVmW4ImiiAdT7uz2iWZmcJrBhpNfxm6WZwtLyBnzVuY6w7cuBN5v3PzxyuLQ/WilPhF1UsbRpi5CkUBFOsdmtjhr1NKgkXku83XHh6j4nucXW3nD4nGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Cx3PalL4; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250131102922epoutp01cd44536b4942ebef728dc3adc80f6420~fwD--bNci2852928529epoutp012
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2025 10:29:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250131102922epoutp01cd44536b4942ebef728dc3adc80f6420~fwD--bNci2852928529epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738319362;
	bh=7DRdYruLuTGeDOp3T9CApmK93+wgaQobbfK2Y7ArqFM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Cx3PalL4DiokQv/BPJGipk832nhyfd9Y3+vj5XiSJF5sPnxWK7tPfyIQgpdU1O/fZ
	 BbHASga9V8qTT+E6dzEcYTJpYNXRHhIIZzbp4Rj3YzjS61s58IdxS4lINCTAnpACly
	 Aw/Y9ugfPJ+B2AchuCVFFBwAYDvPB8EizJithdQI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250131102921epcas5p1df271e2a76e61741daf442e23056a996~fwD-Eepfu2151321513epcas5p1X;
	Fri, 31 Jan 2025 10:29:21 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YksZR6tCPz4x9Pv; Fri, 31 Jan
	2025 10:29:19 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.5E.19710.FF5AC976; Fri, 31 Jan 2025 19:29:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250131102919epcas5p382301978fa8c4b90b653eb319b7858b6~fwD9ihjw81285712857epcas5p3C;
	Fri, 31 Jan 2025 10:29:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250131102919epsmtrp2625fcb350f65b6dfb1f05e1468c7b217~fwD9dfpm90770307703epsmtrp2k;
	Fri, 31 Jan 2025 10:29:19 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-17-679ca5ffef20
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.77.33707.FF5AC976; Fri, 31 Jan 2025 19:29:19 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250131102918epsmtip1b3413b2283500cdaeda4e9539fe6b040~fwD8CEDkU0826508265epsmtip1N;
	Fri, 31 Jan 2025 10:29:17 +0000 (GMT)
Message-ID: <12ee6895-aafe-491e-8dea-c024a2a34563@samsung.com>
Date: Fri, 31 Jan 2025 15:59:17 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: Christoph Hellwig <hch@lst.de>
Cc: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250130125306.GA19390@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmuu7/pXPSDbbvsbBYfbefzWJS/wx2
	iws/Gpksbh7YyWSxcvVRJos/Dw0tJh26xmix95a2xaXHK9gt5i97yu7A5TGx+R27x+WzpR6b
	VnWyeWxeUu+x+2YDm0ffllWMHuu3XGXxmLB5I6vH501yAZxR2TYZqYkpqUUKqXnJ+SmZeem2
	St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QFcqKZQl5pQChQISi4uV9O1sivJLS1IV
	MvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7IzjjTMYCnYyVWxaPFDtgbGhRxd
	jJwcEgImEhP3nmTsYuTiEBLYzSgx+cFNJgjnE6PE9l/bEZyV6+cxwrQ8X7SCHSKxk1FiQdMZ
	VgjnLaPEs74/LCBVvAJ2Eq3vW5hAbBYBVYlbV1sZIeKCEidnPgGrERWQl7h/awbQJHYOYQFd
	iR3RIFERASWJp6/Ogp3ELHABaPGeR2BjmAXEJW49mQ9kc3CwCWhKXJhcChLmFNCRePB0JxtE
	ibzE9rdzmEF6JQR2cEg0dr5lgTjaRWLB0ztQDwhLvDq+hR3ClpL4/G4vG4SdLfHg0QOo+hqJ
	HZv7WCFse4mGPzdYQfYyA+1dv0sfYhefRO/vJ2DnSAjwSnS0CUFUK0rcm/QUqlNc4uGMJVC2
	h8SLCcfANgkJNDFJrDriMIFRYRZSmMxC8uQsJN/MQli8gJFlFaNkakFxbnpqsmmBYV5qOTy6
	k/NzNzGCk7CWyw7GG/P/6R1iZOJgPMQowcGsJMIbe25GuhBvSmJlVWpRfnxRaU5q8SFGU2Dk
	TGSWEk3OB+aBvJJ4QxNLAxMzMzMTS2MzQyVx3uadLelCAumJJanZqakFqUUwfUwcnFINTOt7
	Dt8VnNAr/CL86CznpdopfpallpuefNE9zLtgc36te6fAqboJwaWJty9klelGy8RG2G02jXfa
	mbFbgGPdu5CsnVUncl7y+KbNt76w9Jpg/+Z9i1N5vl4qeXGXo4hlXeXStd0HQz5/7nPwr/iz
	WjPylvyDM7ynb2t8r5417QjjvAuGrz7o+/WqCmXaNs08kb3/unpnS/9c5bMXmVcInF90R9Xv
	1u2679u4fX52Hl28y9xwL5Mo25GdaWIby52zm38k8K6KuPz62BVz67SXkYIv/te9ujHxwdI7
	P7WvNX0v9D0UaMq4ecnqxM+PZz5M+zHzhfqDU+cu1YtPXLdNI8H0V0LDrUwBCYN5PcvtHn5T
	YinOSDTUYi4qTgQAsSJ9GUsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnO7/pXPSDZq+yFusvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWkw5dY7TYe0vb4tLjFewW85c9ZXfg8pjY/I7d4/LZUo9N
	qzrZPDYvqffYfbOBzaNvyypGj/VbrrJ4TNi8kdXj8ya5AM4oLpuU1JzMstQifbsErowjDTNY
	CnZyVSxa/JCtgXEhRxcjJ4eEgInE80Ur2LsYuTiEBLYzSjyet5MJIiEu0XztBzuELSyx8t9z
	qKLXjBI/XreygiR4BewkWt+3gDWwCKhK3LrayggRF5Q4OfMJC4gtKiAvcf/WDKBmdg5hAV2J
	HdEgUREBJYmnr84ygoxkFrjAKLHk8hFGiPlNTBL3muaAzWcGOuLWk/lA8zk42AQ0JS5MLgUJ
	cwroSDx4upMNosRMomtrFyOELS+x/e0c5gmMQrOQXDELyaRZSFpmIWlZwMiyilE0taA4Nz03
	ucBQrzgxt7g0L10vOT93EyM41rSCdjAuW/9X7xAjEwfjIUYJDmYlEd7YczPShXhTEiurUovy
	44tKc1KLDzFKc7AoifMq53SmCAmkJ5akZqemFqQWwWSZODilGpgkRZfm3gg57fHzgVrPi/dL
	sjO0j+SVuaxddcoyxHX2pdXWSysy1+y49a694dLKa66X0g1fx5XvSJ6TFTplpfydV+2HmHg8
	JrC/3fOuKi2aN/5axn0Gxi1Hvxs9uW7Tv2z1dJ0d98zu+7v/mXT5fGiUWZQ5z6Lvll8iDu1w
	XbfJe/VEA95bsk2MquGTq0VeTts9XU5RmnXx1+VX70+sF6hd/+6RlNcE9UvPl9o1RLGLZCXn
	b7x34qHQs729lpknemSUbjR6nFj0Oujz4vg/cX6z/h3UCbx5jG97ZmDEg/2H2cXvrrvwYppW
	5QpNS9/YE7Pe36+skD0oFbxnWlnj09dbavf+PfuIc/k+I6v1IbkrZJRYijMSDbWYi4oTAVnl
	AOskAwAA
X-CMS-MailID: 20250131102919epcas5p382301978fa8c4b90b653eb319b7858b6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141039epcas5p11feb1be4124c0db3c5223325924183a3
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com> <20250129153524.GB5356@lst.de>
	<b5fe3e15-cd7f-41ce-9ac8-70dca0fee37a@samsung.com>
	<20250130125306.GA19390@lst.de>

On 1/30/2025 6:23 PM, Christoph Hellwig wrote:
>> Difference is that FS does not have to attach any PI for offload.
>>
>> Offload is about the Host doing as little as possible, and the closest
>> we get there is by setting PRACT bit.
> But that doesn't actually work.  The file system needs to be able
> to verify the checksum for failing over to other mirrors, repair,
> etc.

Right. That sounds like reusing the existing code on detecting 
checksum-specific failure. So maybe that can be handled iff this gets 
any far.

> Also if you trust the device to get things right you do not
> need to use PI at all - SSDs or hard drives that support PI generally
> use PI internally anyway, and PRACT just means you treat a format
> with PI like one without.  In other words - no need for an offload
> here, you might as well just trust the device if you're not doing
> end to end protection.

Agree that device maybe implementing internal E2E, but that's not a 
contract to be honored. Host can't trust until device says it explicitly.

Since Btrfs already has 'nodatasum' mount option, I assume there are 
deployments that prefer to optimize for checksum. I thought Btrfs will 
be more comfortable to give up (its own checksum tree) and exercise this 
more often if it certainly knows that device is also capable.

