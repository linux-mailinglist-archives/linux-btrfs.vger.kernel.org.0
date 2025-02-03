Return-Path: <linux-btrfs+bounces-11243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F130CA25BD2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 15:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FC03A691A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF25111A8;
	Mon,  3 Feb 2025 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pj3XMqFO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75E205E06
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591441; cv=none; b=MCUCY+GhNH0KPhCMVAj5nvnl9OPDlF20UyVs3zB0ATg7q3K+bsHNV/Tp1xuhLkvRhQxIR+RUeiA8PSOLrA734QMYnvkTc5sfgk7mwwsip3eBVKHDZ6LY3YncYtxg1Ryti44GWRyoKP5y16jkLbF4b7ftZmARJVVCuIFTnRybZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591441; c=relaxed/simple;
	bh=nxq06s0DI0Ylg3jRif469JTU6nFclSqLO/fFYKyzB9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=k6p+PJpYSQqo/6y3YkWzq3HmHpcz+ULuQeVX8jhvY/HwRojtoYlF1w4NVnPlQsMHz1bypiL3/e5+JvY4VGI/TDaG1jwHSzoyo3UzGeXibRq03vb5+exzgBbciVURtjaTGgDa/awQqb+tYoybo/UPrH0sB32pKSx1rS3hxsuuj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Pj3XMqFO; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250203140357epoutp031744adf82bf758214fc3ed383ffb4a0c~gt7NdC28a2032320323epoutp03a
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 14:03:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250203140357epoutp031744adf82bf758214fc3ed383ffb4a0c~gt7NdC28a2032320323epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738591437;
	bh=+iNyyksu3oqdbKY7StoHcCgtEjGDaVz45hLSqCNeAQc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Pj3XMqFO768vu/L2hWZxg4bI8YMDpSrZ2T9FIBQLfSOFXHUb1MnKc/hcIoJjRM1PV
	 fiWTT37RZUPaZ6Ux2yN4p5OIA2hTCyfPcx6+3M3bivY74JHrdD5wPOwTPcdCi9k2Ro
	 JjBN0m2YZYqooGGdmBHAM9aJepR1O8dBmdSKhdfE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250203140356epcas5p4589e76aeacc793515748b236fce0f4ab~gt7NGV0pC1511215112epcas5p46;
	Mon,  3 Feb 2025 14:03:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YmpBg3BNhz4x9Q1; Mon,  3 Feb
	2025 14:03:55 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.2D.20052.BCCC0A76; Mon,  3 Feb 2025 23:03:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250203140355epcas5p39624b1d4924f53e2c4cb9dd0188160ec~gt7LfJReZ0816408164epcas5p3q;
	Mon,  3 Feb 2025 14:03:55 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250203140355epsmtrp262868bfe281810560d487e0ae97a3698~gt7LdpY7T2289522895epsmtrp2b;
	Mon,  3 Feb 2025 14:03:55 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-c9-67a0cccb6730
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	29.A0.33707.ACCC0A76; Mon,  3 Feb 2025 23:03:54 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250203140353epsmtip15aafa852148ac72e8e84f938bb4751eb~gt7J1A-Z81698316983epsmtip1i;
	Mon,  3 Feb 2025 14:03:53 +0000 (GMT)
Message-ID: <330a257d-e276-40d2-855c-8d108abfde02@samsung.com>
Date: Mon, 3 Feb 2025 19:33:52 +0530
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
In-Reply-To: <f2ccdba4-86df-49ae-a465-1f8003fc1fb3@wdc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmhu7pMwvSDW53iVmsvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8XfrntMFn8eGlpMOnSN0WLvLW2LS49XsFvMX/aU3YHbY2LzO3aP
	y2dLPTat6mTz2Lyk3mP3zQY2j74tqxg91m+5yuIxYfNGVo/Pm+Q82g90MwVwRWXbZKQmpqQW
	KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gDdq6RQlphTChQKSCwu
	VtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzjj5OaWgg6Vi
	9szXjA2My5i7GDk5JARMJKY+eMzSxcjFISSwm1GiZcM1FpCEkMAnRomVHyMgEkD2mt29rDAd
	L14+YIVI7ATqWHmIGcJ5C1T1vYMNpIpXwE7i/bYOpi5GDg4WARWJQ/cqIMKCEidnPgHbICog
	L3H/1gz2LkZ2DmEBXYkd0SBTRAS6mCQOr1kONp9Z4AujxI/nR8AWMwuIS9x6Mh9sJJuApsSF
	yaUgJqeAtcSXxa4QFfIS29/OgXrsCIfE5UmmELaLxKZ9c5kgbGGJV8e3sEPYUhKf3+1lg7Cz
	JR48esACYddI7NjcB/WuvUTDnxusIKuYgbau36UPsYpPovf3E7BjJAR4JTrahCCqFSXuTXoK
	1Sku8XDGEijbQ+LFhGNskHDqZJY4f7iNeQKjwiykMJmF5MdZSL6ZhbB5ASPLKkbJ1ILi3PTU
	YtMCw7zUcnhcJ+fnbmIEp2Qtzx2Mdx980DvEyMTBeIhRgoNZSYT39PYF6UK8KYmVValF+fFF
	pTmpxYcYTYFxM5FZSjQ5H5gV8kriDU0sDUzMzMxMLI3NDJXEeZt3tqQLCaQnlqRmp6YWpBbB
	9DFxcEo1MK1Qyzb94OgRKKt230vt0qWnDRGhPz+9cNVsyWaxZF7DKGx3V7H5KL/J5YkOb9br
	b/zK0TK1w0Nmn7l8t3km72/3Tys1+FiOcIcUN+QJpDRePbqmsWfxw98nVFvjHLguTu5pL2f0
	0JynUnI1e8q8G/vSvO1fs//IeH72GPO6AEvtlqjqGzIbuPa/eszj45HYL/J2bW9N19qDGRym
	Dv4HM7+9KZq6dG94a2r1nYc7boSrbWyZfmCKgI3z/HfNB3Rd9pi+fxG5ur5/hYGK2j+5tgsm
	pyoeRPBx6OpVves9Hc0oZNce3PllKvf5FTP+nym7Y2C/b1uVFE/y11syIp2yzw5+/R28lvOx
	t6tJl4K5EktxRqKhFnNRcSIAGudcC1IEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsWy7bCSnO6pMwvSDX6vNbVYfbefzWJS/wx2
	iws/Gpksbh7YyWSxcvVRJou/XfeYLP48NLSYdOgao8XeW9oWlx6vYLeYv+wpuwO3x8Tmd+we
	l8+Wemxa1cnmsXlJvcfumw1sHn1bVjF6rN9ylcVjwuaNrB6fN8l5tB/oZgrgiuKySUnNySxL
	LdK3S+DKOPk5paCDpWL2zNeMDYzLmLsYOTkkBEwkXrx8wNrFyMUhJLCdUWLrpaOMEAlxieZr
	P9ghbGGJlf+es0MUvWaUmHLnBVgRr4CdxPttHUxdjBwcLAIqEofuVUCEBSVOznzCAmKLCshL
	3L81A6iXnUNYQFdiRzTIFBGBHiaJc+d3MYI4zAJfGCV2XrvKCDG/k1ni1sWfYIuZgY649WQ+
	2Hw2AU2JC5NLQUxOAWuJL4tdISrMJLq2djFC2PIS29/OYZ7AKDQLyRWzkAyahaRlFpKWBYws
	qxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGCY08raAfjsvV/9Q4xMnEwHmKU4GBWEuE9vX1B
	uhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILUIpgsEwenVAOT662Ijsbv
	FaeCJFdyxSz94zx/hgXHM8Z/qbWrhLwX3uSXiL1RuX/D2jcids4pGiUVhn7CDPWnV+nt2aTj
	s8Ns5zrZY2k+HSUfPGpcTnQLrlqSEXf36dbF8x/ZtCs4+hu+FEwLVuxJ1lzefWvmGt/ff6Mr
	t7Ad3BTE4bxeWPam99UTL7M/PI5g2bZi5Zf410enrtgtw9Sn9cLZ6eXbdy3x7K0J7e4hU7+7
	B2x0MbxzqPOx+LbN8f8X5C6USU8z6ShTmjn5euJ6xwRBN+ngV8fWmuhpRTJdNda0jMjZIH7t
	zLMjCXtFREybNgox6qj3bblRoWllekQj/q/IniceLSqLXTcUvI77tunAHwZBm+9KLMUZiYZa
	zEXFiQBLIVlgLAMAAA==
X-CMS-MailID: 20250203140355epcas5p39624b1d4924f53e2c4cb9dd0188160ec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141039epcas5p11feb1be4124c0db3c5223325924183a3
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
	<20250129140207.22718-1-joshi.k@samsung.com>
	<299a886d-c065-4b75-b0be-625710f7348c@wdc.com>
	<572e0418-de26-47ec-b536-b63291acff52@samsung.com>
	<73ba28f4-0588-4ca8-b64f-2a6dd593606b@wdc.com>
	<8e548c8f-7a05-4e82-aed7-6044a0d247c9@samsung.com>
	<f2ccdba4-86df-49ae-a465-1f8003fc1fb3@wdc.com>

On 2/3/2025 7:10 PM, Johannes Thumshirn wrote:
> But NODATASUM isn't something that is actively recommended unless you
> know what you're doing. I thought of your patches as an offload of the
> checksum tree to the T10-PI extended sector format

You thought right, patches do "offload to T10-PI format" part. That part 
is generic for any upper-layer user. One only needs to send flag 
REQ_INTEGRITY_OFFLOAD for that.
And for the other part "suppress data-csums at Btrfs level", I thought 
of using NODATASUM.

