Return-Path: <linux-btrfs+bounces-11238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769AA25AD0
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 14:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC845165EED
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 13:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F9C204F94;
	Mon,  3 Feb 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AHtunDDM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952832040B5
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589068; cv=none; b=XIUJuKz91NZa2fqplLc2O44HP+eYzYCQYUgtLoHr4lZixpADOop2b/IX3cCwNEAhTV5r6p8fJ1p59Jf8mTceVAIzIY8NaqbyR57YVYyvVlaYWoO9ve4O79lK4wfcz9eZY7FruId6Gl5eQUDNiKxsi6QWoD3a43mJT5KJgtN8PTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589068; c=relaxed/simple;
	bh=bC58ZbxOqrWm4WBeGh1U9NXjSYnsRuHa/Frf2nB9chc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=AJS6imdNyG25lIgGln22wI2KVPpW/PwN9udA6l3GGv+q9oqgJ/LJx6PWPGaAUlOQivhKWxZuUaomZ0VagSREPSHUEivV3Lu3i0OabE3JMC+GNxv1a/c4MgkjShLH9JjukzD9Mtvc1LcH+SX22w5rZTqGa7T3RODdnbi5dSjV4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AHtunDDM; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250203132418epoutp0167d06ee72b5144c11749628038169c91~gtYmBgiBL1291312913epoutp01H
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 13:24:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250203132418epoutp0167d06ee72b5144c11749628038169c91~gtYmBgiBL1291312913epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738589058;
	bh=Sn+l8rsPtEhyWYMBjkIq4jtvzDpqY2GJAHjNtkksugQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=AHtunDDMi6rEsI3gTIFeSBgoKszxjVcgGim08o5J0D5v0iUnsARHkIQERo6TfhsPD
	 7xvJ7wZtb0BcqTUV2Q2fY0VlNKFZ9i0fDdZM2jmZ5qoJRrlcoAjzBX+8aDjRXSuhaR
	 ucERe/0nU6gmsAygUwqEcrJe1wTghvqj7TTzJIa0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250203132417epcas5p3c4586138db1e4f70dccd7f85835b0023~gtYlld50F2449724497epcas5p3G;
	Mon,  3 Feb 2025 13:24:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YmnJw39bWz4x9Px; Mon,  3 Feb
	2025 13:24:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	15.9B.19933.083C0A76; Mon,  3 Feb 2025 22:24:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250203132416epcas5p29b636c04f0bef56c8f90bb30d21273a6~gtYj689-N2636126361epcas5p2f;
	Mon,  3 Feb 2025 13:24:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250203132416epsmtrp11bb8e49ea840d78ca84826ba12ec386e~gtYj6Q_GA2429824298epsmtrp1g;
	Mon,  3 Feb 2025 13:24:16 +0000 (GMT)
X-AuditID: b6c32a4a-c1fda70000004ddd-c8-67a0c3805888
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.66.18729.F73C0A76; Mon,  3 Feb 2025 22:24:15 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250203132414epsmtip1fa462c58e50f2fd28bf556d2e12d2b06~gtYiSTaaN2785527855epsmtip1I;
	Mon,  3 Feb 2025 13:24:14 +0000 (GMT)
Message-ID: <f336dbed-895c-4aa6-a621-84112e047989@samsung.com>
Date: Mon, 3 Feb 2025 18:54:13 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Btrfs checksum offload
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmhm7D4QXpBi8mi1qsvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWkw5dY7TYe0vb4tLjFewW85c9ZbdYfvwfkwO3x8Tmd+we
	l8+Wemxa1cnmsXlJvcfumw1sHh+f3mLx6NuyitFj/ZarLB4TNm9k9fi8SS6AKyrbJiM1MSW1
	SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoXiWFssScUqBQQGJx
	sZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaUWU2sBdO5
	K04tmMjWwPiXo4uRk0NCwERi9/qZzF2MXBxCArsZJeb/vMoG4XxilNi0eD0LhPONUeL+gd3s
	MC2/Lr5mhEjsZZRYdeUtVMtbRonuzxNYQap4Bewkpj+YxAJiswioSJz9eY4dIi4ocXLmE7C4
	qIC8xP1bM4Di7BzCAroSO6JBoiICphKTP20FG8kscIdRYubRuYwgCWYBcYlbT+YzdTFycLAJ
	aEpcmFwKEuYUMJbY/ucRO0SJvMT2t3OYIe68wCHRtlsYwnaRuDqrmxXCFpZ4dXwL1C9SEi/7
	26DsbIkHjx6wQNg1Ejs290HV20s0/LnBCrKWGWjt+l36EKv4JHp/PwG7RkKAV6KjTQiiWlHi
	3qSnUJ3iEg9nLIGyPSReTDgGDaitjBI//u9ln8CoMAspTGYheXIWkm9mIWxewMiyilEytaA4
	Nz212LTAKC+1HB7dyfm5mxjBiVnLawfjwwcf9A4xMnEwHmKU4GBWEuE9vX1BuhBvSmJlVWpR
	fnxRaU5q8SFGU2DkTGSWEk3OB+aGvJJ4QxNLAxMzMzMTS2MzQyVx3uadLelCAumJJanZqakF
	qUUwfUwcnFINTAnmp2zUezrm84e+7yw+0DHXz6R13rcLU363+IqGnHUpijxy4IXv1PVPjjSu
	i7ERjhaL1fHxYdt6wNL2uNVln0VMnZ3V8We+N72zcAtNdVn1WcCAP/nGmrLLs2/vn8xZYr52
	bc72/2sEluWb7L3m83yBld3R/Z0hth2661WLcwJEg+eGGN0vnnzjuh+rrOL6cE3xxp35WivP
	xNQ/ncp6VjD7Z1mUYs+JuY4vnZcXlroEe0QoWn3LOHRTeE01U7SHNoP9MiF2xqzCiOl3zB72
	FF3eubYrV+nNn3dprxM87KOt7Y6yPzzhtdZRObPrd0xy6d3Q6y6GKS9iEsu3hCuqSm0+ssfm
	VOLsb8vtnsUosRRnJBpqMRcVJwIAuETp41UEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnG794QXpBhtf2VisvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWkw5dY7TYe0vb4tLjFewW85c9ZbdYfvwfkwO3x8Tmd+we
	l8+Wemxa1cnmsXlJvcfumw1sHh+f3mLx6NuyitFj/ZarLB4TNm9k9fi8SS6AK4rLJiU1J7Ms
	tUjfLoErY8qsJtaC6dwVpxZMZGtg/MvRxcjJISFgIvHr4mvGLkYuDiGB3YwSp/p+sEEkxCWa
	r/1gh7CFJVb+e84OUfSaUWLvgmZWkASvgJ3E9AeTWEBsFgEVibM/z7FDxAUlTs58AhYXFZCX
	uH9rBlCcnUNYQFdiRzRIVETAVGLyp61sICOZBe4wSvybe4MJYv5WRoltt88wglQxAx1x68l8
	oAQHB5uApsSFyaUgYU4BY4ntfx6xQ5SYSXRt7YIql5fY/nYO8wRGoVlIrpiFZNIsJC2zkLQs
	YGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRHIdamjsYt6/6oHeIkYmD8RCjBAez
	kgjv6e0L0oV4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUw
	Me1eff/IYd6loffrZmev9rNiX3bH/vh/hZrH95u0ViXM0hP0MXKarOPNZsf0l8sknWH14+vX
	oncUX32fqb1uwZwFF3ff3NfwOK10p5nt926717EL8ytt28LsGrec0nb/8veNfN0T74tH5lz3
	7JdRPnQ54IGv4vYJefdO/sk2+j930sEQyfjed5syjp59Fz/jEJu7FL/R+o6FOckJ2wQOrTmw
	q1fX/jzXytArfQofZRSfsNf0bhVw2f9b+d+iF5M/BTu+WbKp/e3DqAlzRe+YeD0SK/2setne
	x8jj8Zo5v7q3NIWp7QkyzHzP+fTjjO4v2XLuFSWKDAuqTqvlO7Q+2y9xduc7EyXlJZ/f7z+c
	cEuJpTgj0VCLuag4EQBWN79mMgMAAA==
X-CMS-MailID: 20250203132416epcas5p29b636c04f0bef56c8f90bb30d21273a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141039epcas5p11feb1be4124c0db3c5223325924183a3
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com>
	<yq134h0p1m5.fsf@ca-mkp.ca.oracle.com>

On 1/31/2025 1:51 AM, Martin K. Petersen wrote:
>> There is value in avoiding Copy-on-write (COW) checksum tree on a
>> device that can anyway store checksums inline (as part of PI). This
>> would eliminate extra checksum writes/reads, making I/O more
>> CPU-efficient. Additionally, usable space would increase, and write
>> amplification, both in Btrfs and eventually at the device level, would
>> be reduced [*].
> I have a couple of observations.
> 
> First of all, there is no inherent benefit to PI if it is generated at
> the same time as the ECC. The ECC is usually far superior when it comes
> to protecting data at rest. And you'll still get an error if uncorrected
> corruption is detected. So BLK_INTEGRITY_OFFLOAD_NO_BUF does not offer
> any benefits in my book.

I fully agree, there is no benefit if we see it from E2E use case.
But for a different use case (i.e., checksum offload), 
BLK_INTEGRITY_OFFLOAD_NO_BUF is as good as it gets.

[Application -> FS -> Block-layer -> Device]

I understand that E2E gets stronger when integrity/checksum is placed at 
the origin of data (application), and then each component collaborates 
in checking it.

But I am not doing E2E here. Call it abuse or creative, but I am using 
the same E2E capable device to do checksum-offload. If the device had 
exposed checksum-offload in a different way, I would have taken that 
route rather than E2E one.

