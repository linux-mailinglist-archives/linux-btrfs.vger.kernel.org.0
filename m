Return-Path: <linux-btrfs+bounces-11197-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF76FA23C1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 11:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4ADF3A5E36
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2025 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379A1EED8;
	Fri, 31 Jan 2025 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OBifgiPF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917A171092
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318757; cv=none; b=Z36W5bMf4vtwT9UhbXm1esaS44H3evGVLBQ0sleEAncdcs11B5N2omsQgud1eTwRskTV+aBeCdUO379XYRrWnHYarYB47anYDIWd8U3YhIQNyhe5GKZfBIX6bNYKAJ4ONnYgMnrK2NBVPhd9TcIJPlN8s5c3KMF29qn1tF47nZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318757; c=relaxed/simple;
	bh=Ks/gPo0cRZYae4Ji1tZGYmvZfnsRsRmvsAfDZ6kg6CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=WKQhmRgXtuE9i8p056YIb6aLtBRh8J6iOVcHHvclqGvU+2jkrAj/roOq2eOSDMFG2KlZ2aZ53B1t8t1UKEfUxUltS/f8xPLpM9dIEELEj1XOBM8fiinZXUeX1jbWCSaFlS+T4P+dfZbTVIWZ8F2oqxw1NmfsSSeRnXf/DrdtC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OBifgiPF; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250131101913epoutp04ec6b40a8590d26a8bbc0458193199a78~fv7IlBj_Q2030120301epoutp04j
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2025 10:19:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250131101913epoutp04ec6b40a8590d26a8bbc0458193199a78~fv7IlBj_Q2030120301epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738318753;
	bh=loFgrXWvJRjGfwH8zqXYCRcdDPp53/pl9iAISReaC8Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OBifgiPFc2wsXmbCa6hJs1NFM+pdQ6Hfihb2FJ+RqPKuealy10eAn5zvzgqR7wugC
	 Q7SQDlKEcYc9wLy0IAcJjALHvls6cUHJPQeIwrDKO1y1WX+DmX+q9dVOEegGen1c8S
	 QJp/5TX7XMF2YcGnwVUcc+/7fGbg7TTGM7YKCJck=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250131101912epcas5p47465e0145a30e4e8ca42a0648ec96fe5~fv7IBaLme2409324093epcas5p4K;
	Fri, 31 Jan 2025 10:19:12 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YksLk74vkz4x9Pq; Fri, 31 Jan
	2025 10:19:10 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FB.92.19956.E93AC976; Fri, 31 Jan 2025 19:19:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250131101910epcas5p2e96869da67bdec816c5618af024f7dc5~fv7GDL7wT0831608316epcas5p2N;
	Fri, 31 Jan 2025 10:19:10 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250131101910epsmtrp2f0fe3baf733867b241ffdf528f4e8903~fv7GCYZbU0217902179epsmtrp2D;
	Fri, 31 Jan 2025 10:19:10 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-5e-679ca39ed390
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	AB.E6.33707.E93AC976; Fri, 31 Jan 2025 19:19:10 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250131101908epsmtip2d6d722168bf3a34eedda59ee873b8158~fv7EZsGqL1640116401epsmtip2V;
	Fri, 31 Jan 2025 10:19:08 +0000 (GMT)
Message-ID: <572e0418-de26-47ec-b536-b63291acff52@samsung.com>
Date: Fri, 31 Jan 2025 15:49:07 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "dsterba@suse.com" <dsterba@suse.com>, "clm@fb.com"
	<clm@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org"
	<kbusch@kernel.org>, hch <hch@lst.de>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <299a886d-c065-4b75-b0be-625710f7348c@wdc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmlu68xXPSDWbtM7FYfbefzWJS/wx2
	iws/Gpksbh7YyWSxcvVRJou/XfeYLP48NLSYdOgao8XeW9oWlx6vYLeYv+wpuwO3x8Tmd+we
	l8+Wemxa1cnmsXlJvcfumw1sHn1bVjF6rN9ylcVjwuaNrB6fN8l5tB/oZgrgisq2yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6V0mhLDGnFCgUkFhc
	rKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnbGrpYup4C1H
	xbXJE1gbGP+zdTFyckgImEg83/6LpYuRi0NIYDejxOTmF4wQzidGiVWrPrDCOdt3/mWEafnV
	0MoGkdjJKLH3x3OoqreMEhOnzWEBqeIVsJM4vesK2BIWAVWJu+1rWCHighInZz4BqxEVkJe4
	f2sGexcjO4ewgK7EjmiQMSICXUwSh9csB5vJLPCFUeLH8yNgvcwC4hK3nsxn6mLk4GAT0JS4
	MLkUJMwpYC2xs3ELE0SJvMT2t3OYQXolBI5wSJy4OZUd4moXibOL9kJ9ICzx6vgWqLiUxOd3
	e6GBkS3x4NEDFgi7RmLH5j5WCNteouHPDVaQvcxAe9fv0ofYxSfR+/sJ2DkSArwSHW1CENWK
	EvcmPYXqFJd4OGMJlO0h8WLCMWi47WWUeHjsFdMERoVZSKEyC8mXs5C8Mwth8wJGllWMkqkF
	xbnpqcWmBcZ5qeXwCE/Oz93ECE7OWt47GB89+KB3iJGJg/EQowQHs5IIb+y5GelCvCmJlVWp
	RfnxRaU5qcWHGE2B0TORWUo0OR+YH/JK4g1NLA1MzMzMTCyNzQyVxHmbd7akCwmkJ5akZqem
	FqQWwfQxcXBKNTDF3tNrCuR3KuGWONs91T3BTnNqV0MhZ/WB3UJeArOvC9w/uzBwmv2/uoTC
	hg25DM9WHq5p4lx1mVN8owFba0z/MTHNyGqNc6d/5aq6Mm9XXNQnqPbKyd/lnoVjgUj8+hSx
	T8eDwo7zzuXqfLonX8cjZlX0wZclJ18+mfFgloXNzORtsosEY17/09ylZCjSoSLmM2F95umn
	B87JfJ59lFNOfNemij8bBOpefF0WJJXJ0mq3ntufeeq0Ta0tjfn8784b7RfK2vCsnPXnzvMt
	4UU9N2WPGM7zkpjReVb2u3ah/tvvL+YZf3tY9vRagMTEJUfyVm/1Nb459+APllUVMlwcy9Z8
	UOVIkJjfW/72Xr0SS3FGoqEWc1FxIgCnwsnhVwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSvO68xXPSDVau5bJYfbefzWJS/wx2
	iws/Gpksbh7YyWSxcvVRJou/XfeYLP48NLSYdOgao8XeW9oWlx6vYLeYv+wpuwO3x8Tmd+we
	l8+Wemxa1cnmsXlJvcfumw1sHn1bVjF6rN9ylcVjwuaNrB6fN8l5tB/oZgrgiuKySUnNySxL
	LdK3S+DK2NXSxVTwlqPi2uQJrA2M/9m6GDk5JARMJH41tALZXBxCAtsZJb48+soIkRCXaL72
	gx3CFpZY+e85O0TRa0aJt7+PsoIkeAXsJE7vugI2iUVAVeJu+xqouKDEyZlPWEBsUQF5ifu3
	ZgA1s3MIC+hK7IgGGSMi0MMkce78LkYQh1ngC6PEzmtXGSEW7GWUeH5uCdgVzEBX3Hoyn6mL
	kYODTUBT4sLkUpAwp4C1xM7GLUwQJWYSXVu7oMrlJba/ncM8gVFoFpIzZiGZNAtJyywkLQsY
	WVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBEegVtAOxmXr/+odYmTiYDzEKMHBrCTCG3tu
	RroQb0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QD00rNivLN
	L2OkXl/mUPli7PpQlGFN3/+zzZGmNQ/+54Vorjy+4Z6wKdPVpbOKDfZUr1u11lK9/4/Bwt9G
	e71V158/k9vnuXjWv6cZJxNeWvVUriwvc8+QX3Cz96jZ9Oud1bFsy/5UpHbt+pLHYlE2ueu/
	hGPfnEX5e6Zca82J8Xz/wV6UlYPp/oz1ai/38e8/3r2zwOHf3O/CJ/qEGT1KDR8lTlUWNtfX
	Wq91K+L7cu1Nih9vPGC8u8vg9it3uYexb9YJeF0t/vBxh7ZQs8S5iykrko7lG/E3GoRaWPMr
	HQ7s2/7de9or788cbnKHGWzK/ngyfwwIS5Ou2pIZ8Pmjpa7KLQvHqb3catmv+y/8UGIpzkg0
	1GIuKk4EAC0pFDEvAwAA
X-CMS-MailID: 20250131101910epcas5p2e96869da67bdec816c5618af024f7dc5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141039epcas5p11feb1be4124c0db3c5223325924183a3
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com>
	<299a886d-c065-4b75-b0be-625710f7348c@wdc.com>

On 1/29/2025 8:25 PM, Johannes Thumshirn wrote:
> For instance if we get a checksum error on btrfs we not only report in
> in dmesg, but also try to repair the affected sector if we do have a
> data profile with redundancy.
> 
> So while this patchset offloads the submission side work of the checksum
> tree to the PI code, I don't see the back-propagation of the errors into
> btrfs and the triggering of the repair code.
> 
> I get it's a RFC, but as it is now it essentially breaks functionality
> we rely on. Can you add this part as well so we can evaluate the
> patchset not only from the write but also from the read side.

I tested the series for read, but only the success cases. In this case 
checksum generation/verification happens only within the device. It was 
slightly tricky to inject an error and I skipped that.

Since separate checksum I/Os are omitted, this is about handling the 
error condition in data read I/O path itself. I have not yet checked if 
repair code triggers when Btrfs is working with existing 'nodatasum' 
mount option. But I get your point that this needs to be handled.

