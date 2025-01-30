Return-Path: <linux-btrfs+bounces-11173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA714A22A2B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 10:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A7166D79
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF701B4253;
	Thu, 30 Jan 2025 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UR/iiUHQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870D19CC3C
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738228953; cv=none; b=U3DQtlDg+O1NNUcR/fcwZDLXjVM08cQtQ1UEE+WQUozISefvP9c8kxz/d88vxMnoLUpNa1mN6gvoPLMP3D7USH6ewOAHbO08TynIykbCcbmS1xr2W77fpIxy42N1YvCWNyGngJVgtF5lGMafYWryXzFz6lwc8jJm2UjRCPtMXiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738228953; c=relaxed/simple;
	bh=DOCdZIHH/1FRG8QI3qLuBCgOBISF39Jb/YszNlNSb2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=nv7NN/r9H839f+Iqsif2v6zFCZH5RSGNYoEXYxd3xKZCv/nE4Qelqvz5iLTHHNH0gquP5f5OJHYstOwyXuk4/unr3TMjMbQqfxr1eDeFfKVV++eJ2el/KABid01acd4UhmClnInRW9q16283SKz6HvEi0d6z1Vwt3vqcoIUr/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UR/iiUHQ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250130092228epoutp040990b80a9bc9d29b8bb3703752ca9b12~fbgT3Y2Gy1242112421epoutp04J
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 09:22:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250130092228epoutp040990b80a9bc9d29b8bb3703752ca9b12~fbgT3Y2Gy1242112421epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738228948;
	bh=Wx7aZCGHZqI05fpqUcDZen/kuLIz9kgd4IntaYov6A8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=UR/iiUHQio+Ruwh19yWhLObeDCjsm65POfDFiWszE0VI0d0+wDPLB/CZ2sbPAd+uP
	 9xnh+MWIcZMxNluHZ5nzu5+r6Ys8uQcmfVq5vd0WAygW+eTPboLlebGkLTPJZ7QhOn
	 gsWedmxM9fbFO0K+1tV3JW8XxsgklOu1AatUucXo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250130092228epcas5p237fe7db3196715a946b65bda1c7b9a5f~fbgTMX06D2560325603epcas5p2I;
	Thu, 30 Jan 2025 09:22:28 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YkD7k5915z4x9Px; Thu, 30 Jan
	2025 09:22:26 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D2.EB.29212.2D44B976; Thu, 30 Jan 2025 18:22:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250130092226epcas5p4c8830a18efedb85436a2167c5146058c~fbgRcCQ5P3189131891epcas5p4U;
	Thu, 30 Jan 2025 09:22:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250130092226epsmtrp1fc9bfa099aecd7f940cedb88d2feb898~fbgRbMQ-q2846128461epsmtrp1r;
	Thu, 30 Jan 2025 09:22:26 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-6c-679b44d2dd6f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.DC.18949.2D44B976; Thu, 30 Jan 2025 18:22:26 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250130092224epsmtip1d983c41a07ed41df2dd58005c2805c44~fbgP7FMmy1288612886epsmtip15;
	Thu, 30 Jan 2025 09:22:24 +0000 (GMT)
Message-ID: <b5fe3e15-cd7f-41ce-9ac8-70dca0fee37a@samsung.com>
Date: Thu, 30 Jan 2025 14:52:23 +0530
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
In-Reply-To: <20250129153524.GB5356@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmhu4ll9npBg1fVSxW3+1ns5jUP4Pd
	4sKPRiaLmwd2MlmsXH2UyeLPQ0OLSYeuMVrsvaVtcenxCnaL+cuesjtweUxsfsfucflsqcem
	VZ1sHpuX1HvsvtnA5tG3ZRWjx/otV1k8JmzeyOrxeZNcAGdUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0JVKCmWJOaVAoYDE4mIlfTubovzSklSF
	jPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMTf1bWQtuclb8nWLUwPiUvYuR
	k0NCwESi7ch7li5GLg4hgT2MEpNnrGGDcD4xSqyY28wI4XxjlDhz6QQrTMv+O4+YIRJ7GSW2
	v+iAct4ySmzqXswCUsUrYCfxePIiZhCbRUBV4u+vq0wQcUGJkzOfgNWICshL3L81A+gQdg5h
	AV2JHdEgUREBJYmnr86CLWYWuMAosXLPI7BWZgFxiVtP5gPZHBxsApoSFyaXgoQ5BbQlfs88
	wwZRIi+x/e0csHMkBPZwSOw/+50R4mgXid+bT0LZwhKvjm+B+l9K4mV/G5SdLfHg0QMWCLtG
	YsfmPqiH7SUa/txgBdnLDLR3/S59iF18Er2/n4CdIyHAK9HRJgRRrShxb9JTqE5xiYczlkDZ
	HhIvJhyDBu5qRom7N6+xTWBUmIUUKLOQfDkLyTuzEDYvYGRZxSiVWlCcm56abFpgqJuXWg6P
	7+T83E2M4DSsFbCDcfWGv3qHGJk4GA8xSnAwK4nwxp6bkS7Em5JYWZValB9fVJqTWnyI0RQY
	PROZpUST84GZIK8k3tDE0sDEzMzMxNLYzFBJnLd5Z0u6kEB6YklqdmpqQWoRTB8TB6dUAxNT
	6B7/Q7cnMGRxvNsr1BZwaUKhOAPP0vdnJ9Sb+M7LLAyX/GVuPP33t3PbS8yLLzervbpj+O7o
	hi0dn6ynL/8q5HYtcpfQ/z2fL+9Yd2dtwBxxa9buGcnSaZ58fw6LG7LNFl6ZUtGRcGqJARdj
	SrbPpbn7pnf/i+3KLn7y/oKCkdOv+62PBPTFfN85Orto3CzNsDvnu3qJ1OwpdlXrMpdOWLru
	90zd4FMZWyTjp/R9kkk+uzXi5uuf4p6LNHaLBE+86eK4oj8ogDUo5y5vK6/YYkZJ/kqhzK/B
	k1cFNouxrvzMd0C7oH+6gdVL65ZgAZfey09rV0srbmPumJewuvZ/hPGSJrvnmjHZc/5r3ldi
	Kc5INNRiLipOBAAhsS8CTAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnO4ll9npBv+usFqsvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWkw5dY7TYe0vb4tLjFewW85c9ZXfg8pjY/I7d4/LZUo9N
	qzrZPDYvqffYfbOBzaNvyypGj/VbrrJ4TNi8kdXj8ya5AM4oLpuU1JzMstQifbsEroxN/VtZ
	C25yVvydYtTA+JS9i5GTQ0LARGL/nUfMXYxcHEICuxkldvbNYoRIiEs0X/sBVSQssfLfc3aI
	oteMEq2d05lAErwCdhKPJy9iBrFZBFQl/v66ChUXlDg58wkLiC0qIC9x/9YMoGZ2DmEBXYkd
	0SBREQEliaevzjKCjGQWuMAoseTyEUaI+asZJXb9PwJ2BDPQEbeezAeaycHBJqApcWFyKUiY
	U0Bb4vfMM2wQJWYSXVu7oMrlJba/ncM8gVFoFpIrZiGZNAtJyywkLQsYWVYxSqYWFOem5xYb
	FhjlpZbrFSfmFpfmpesl5+duYgRHnJbWDsY9qz7oHWJk4mA8xCjBwawkwht7bka6EG9KYmVV
	alF+fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUx8+xiyZj76+Gm2YdND
	WXX1KSHGbx+1MrWy7jyp+D+v0XDm77vP1OKjmNZ6Nrx54Ppraw1P/2bBNbYcHyx9mm++ufrV
	u5exRnKXcCFr6++VT4uUPmnkqwfw7bJj0LB3NhOUXfdk4fIrShPLLR7pyh2UTrQ6wnq/0ufa
	wVnJgWrxIqayOWc+Xli8pXl/m5TV25avT+e4bF+R1VWl5hJvUX7N+mxIYK3umrrp9r1S7nV+
	gXEnmeb/3P5z4hObnnUNr64Vsh9a7fRP5fY7tV0rz89SbN4XmBV2N6BhQdOdg1zf3kjetZrw
	x3SbMluV8qHvTUVaYT7r2jK2rVgZK3/ZO0rbfHKkVjtf9e7N84qvrVFiKc5INNRiLipOBACO
	1ZfqJwMAAA==
X-CMS-MailID: 20250130092226epcas5p4c8830a18efedb85436a2167c5146058c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141039epcas5p11feb1be4124c0db3c5223325924183a3
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com> <20250129153524.GB5356@lst.de>

On 1/29/2025 9:05 PM, Christoph Hellwig wrote:
>> This patch series: (a) adds checksum offload awareness to the
>> block layer (patch #1),
> I've skipped over the patches and don't understand what this offload
> awareness concept does compared the file system simply attaching PI
> metadata.

Difference is that FS does not have to attach any PI for offload.

Offload is about the Host doing as little as possible, and the closest 
we get there is by setting PRACT bit.

Attaching PI is not really needed, neither for FS nor for block-layer, 
for pure offload.
When device has "ms == pi_size" format, we only need to send I/O with 
PRACT set and device take care of attaching integrity buffer and 
checksum generation/verification.
This is abstracted as 'offload type 1' in this series.

For other format "ms > pi_size" also we set the PRACT but integrity 
buffer also needs to be passed. This is abstracted as 'offload type 2'.
Still offload as the checksum processing is done only by the device.

Block layer Auto-PI is a good place because all above details are common 
and remain abstracted, while filesystems only need to decide whether 
they want to send the flag (REQ_INTEGRITY_OFFLOAD) to use the facility.

