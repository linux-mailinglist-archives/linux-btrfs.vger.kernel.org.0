Return-Path: <linux-btrfs+bounces-11239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43087A25AD6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 14:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DF9164DF4
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79105204F92;
	Mon,  3 Feb 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nQhV/Tyt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C90204F94
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 13:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589147; cv=none; b=IPH/e3vYEtdJqt3QJMM7QxwIbeV7TenNVCJ97JRyAUOtzI/FRrm5q9irLOfzmfl5KONFu8KEExy5nFCDrv2UFczbDXZzhX5VZDfpHAlg10fw1eybQun73bxHWWE+J4Ht2O/g4IadCoRYiEci/pak6pi10+nqUtKpPBXpIu4UtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589147; c=relaxed/simple;
	bh=ETpYkKSW0ujAn/A4oFQI6Dw67ynCvWSY7+JPEvd/y50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kE1xt++rM+qiBr7HyRzfc303FxyhXOdqdYE729zFLcnn0CdwzWfMm93xqWIhp6+eG/+y9EBF3+bt6uBKv5s/YdM2bFfTYDald9jQJBn3d9iMv4DZSBOUb6yEZN2n8Z3DQjVTkn6oM6urL3X6zOpeXnI0+vTrGYPtDZwOm3Tyl2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nQhV/Tyt; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250203132543epoutp02c470503df1707b67e7b0bade826cc971~gtZ1aHdlW1766517665epoutp02k
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 13:25:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250203132543epoutp02c470503df1707b67e7b0bade826cc971~gtZ1aHdlW1766517665epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738589143;
	bh=cKUs4xdryHhIOGmxZcYZeIyaLRtkU1L2K7XqPjbU5BA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nQhV/TytyvuC5A/LphJhm0N/7ZAh4Gp/Mf/Ckdr87OQZCpYhSgsP93EmfOh4rxBNj
	 dBNeDhXqwbLQPtVqijMQZHDnbzvSwXjd7+qZPW7KVE41nbrtmG//0BgdYxcaPGoKXv
	 34zcsBR3zEsnfcZasK5wdiREaZdhnpwgp/BzajNE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250203132542epcas5p20fde6de67377981fca39c87b40e08034~gtZ0k3eiO2942229422epcas5p2f;
	Mon,  3 Feb 2025 13:25:42 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YmnLY21Dlz4x9Ps; Mon,  3 Feb
	2025 13:25:41 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	16.2C.19710.5D3C0A76; Mon,  3 Feb 2025 22:25:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250203132540epcas5p3108da1d357572d2569b2daacd0ff6e2a~gtZy4g1Pi1092310923epcas5p3F;
	Mon,  3 Feb 2025 13:25:40 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250203132540epsmtrp2b1eeefe62fc3ef763968c793c75ca427~gtZy3wHA83232732327epsmtrp2F;
	Mon,  3 Feb 2025 13:25:40 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-47-67a0c3d56e41
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.48.23488.4D3C0A76; Mon,  3 Feb 2025 22:25:40 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250203132539epsmtip1589e5dc6851fa5ef8adba0afe090ee70~gtZxL5cA52891528915epsmtip1K;
	Mon,  3 Feb 2025 13:25:38 +0000 (GMT)
Message-ID: <8e548c8f-7a05-4e82-aed7-6044a0d247c9@samsung.com>
Date: Mon, 3 Feb 2025 18:55:38 +0530
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
In-Reply-To: <73ba28f4-0588-4ca8-b64f-2a6dd593606b@wdc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPJsWRmVeSWpSXmKPExsWy7bCmhu7VwwvSDdbs5LRYfbefzWJS/wx2
	iws/Gpksbh7YyWSxcvVRJou/XfeYLP48NLSYdOgao8XeW9oWlx6vYLeYv+wpuwO3x8Tmd+we
	l8+Wemxa1cnmsXlJvcfumw1sHn1bVjF6rN9ylcVjwuaNrB6fN8l5tB/oZgrgisq2yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6V0mhLDGnFCgUkFhc
	rKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnTH38ByWginc
	Fc9W9LE2MH7n6GLk4JAQMJG4s8Wxi5GLQ0hgN6NES+MfdgjnE6PEvcUfmboYOYGcb4wS56+A
	2SANa9dfgorvZZRY0SUF0fCWUWJ2fzs7SIJXwE5i0poH7CAbWARUJL4+MoEIC0qcnPmEBcQW
	FZCXuH9rBlAJO4ewgK7EjmiQKSICXUwSh9csZwVxmAW+MEr8eH6EFaSeWUBc4taT+UwgI9kE
	NCUuTC4FCXMKWEs0f1zPDFEiL7H97RxmkF4JgTMcEnOv32CBuNlF4szsGWwQtrDEq+Nb2CFs
	KYnP7/ZCxbMlHjx6AFVfI7Fjcx8rhG0v0fDnBivIXmagvet36UPs4pPo/f2ECRKGvBIdbUIQ
	1YoS9yY9heoUl3g4YwmU7SHxYsIxNkioLWaSaDjuPoFRYRZSoMxC8uQsJN/MQli8gJFlFaNk
	akFxbnpqsmmBYV5qOTyuk/NzNzGCU7KWyw7GG/P/6R1iZOJgPMQowcGsJMJ7evuCdCHelMTK
	qtSi/Pii0pzU4kOMpsDImcgsJZqcD8wKeSXxhiaWBiZmZmYmlsZmhkrivM07W9KFBNITS1Kz
	U1MLUotg+pg4OKUamG4xcIXt29n5z41hpf6ZR+tOFjNlHL/zhUPT3/dI9FdL1p6tqZetX1ZX
	rLry02/C3bqHPFXTNbK2zEr/qXb6wP8rnj2hockq8wT61ym8rlhymE3IyJcrr/HvmZPv175V
	EnPZ/a5UMPPvEe4NbglG+5S8NZ/aZC61TPnyQKtlxuwXF47ZsfPuDZ4ppLHK3PPcz+j5Wzu2
	6GicmnVfzsdVaNV2CZcnjxUqWT97vv7vqSe3ub2190v1BsGmmPMm/P9PqahxT5oVp1LbmDF1
	9xORk4kdj2alTv9VGjPtY1S6F8s7yfVqCW6dMxL/VXjoL178uC1W5N/5N17BM5XK82+apHnG
	pi64arLA5XShonRavxJLcUaioRZzUXEiAGm48rJSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnO6VwwvSDc63G1isvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8XfrntMFn8eGlpMOnSN0WLvLW2LS49XsFvMX/aU3YHbY2LzO3aP
	y2dLPTat6mTz2Lyk3mP3zQY2j74tqxg91m+5yuIxYfNGVo/Pm+Q82g90MwVwRXHZpKTmZJal
	FunbJXBlzD08h6VgCnfFsxV9rA2M3zm6GDk5JARMJNauv8TUxcjFISSwm1Hi9aa/7BAJcYnm
	az+gbGGJlf+es0MUvWaUuHbxOBtIglfATmLSmgdACQ4OFgEVia+PTCDCghInZz5hAbFFBeQl
	7t+aAVTCziEsoCuxIxpkiohAD5PEufO7GEEcZoEvjBI7r11lhJi/mEni8auvYIuZgY649WQ+
	E8h8NgFNiQuTS0HCnALWEs0f1zNDlJhJdG3tYoSw5SW2v53DPIFRaBaSM2YhmTQLScssJC0L
	GFlWMUqmFhTnpucmGxYY5qWW6xUn5haX5qXrJefnbmIEx6GWxg7Gd9+a9A8xMnEwHmKU4GBW
	EuE9vX1BuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHelYYR6UIC6YklqdmpqQWpRTBZJg5OqQYm
	vW6BY8z+tb/mbOP8LKukXeW6zFJOJyVx+dIz6g1/AjU5dW27Oeyt2Z+c2L78oou07ce5683a
	+bQ32ez11ygp+zx18T4l5u673UvUtneeC/tb/uink7D7et7i/OkSMtoFOScnPvhqlfxujWt7
	+y8G0fsnFT72SZ14LSAqUPs9g/Oi0luuX4f3HpjxRiZm1b7K80dmburM+WJ9PyLW1+uWKb+i
	wy2J6ld3F8w1/bb4hL/qvMx9+SwTxQ1/pq4U+7UqeO7ESwurtq8rsJS8OtNTs26Tv0jEvIlL
	FPdtm336zd3NkQl//zhMlRbauS5kknBnM0ftyenPW90XeLj9Ltt3U8OmykhPpfb6Pr/IOU+F
	lViKMxINtZiLihMBam5g6TIDAAA=
X-CMS-MailID: 20250203132540epcas5p3108da1d357572d2569b2daacd0ff6e2a
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

On 1/31/2025 3:59 PM, Johannes Thumshirn wrote:
>> I tested the series for read, but only the success cases. In this case
>> checksum generation/verification happens only within the device. It was
>> slightly tricky to inject an error and I skipped that.
>>
>> Since separate checksum I/Os are omitted, this is about handling the
>> error condition in data read I/O path itself. I have not yet checked if
>> repair code triggers when Btrfs is working with existing 'nodatasum'
>> mount option. But I get your point that this needs to be handled.
>>
> So this as of now disables one of the most useful features of the FS,
> repairing bad data. The whole "story" for the RAID code in the FS is
> build around this assumption, that we can repair bad data, unlike say MD
> RAID.

Does repairing-bad-data work when Btrfs is mounted with NODATASUM?
If not, should not the proposed option be seen as an upgrade over that?

You might be knowing, but I do not know how does Btrfs currently decide 
to apply NODATSUM! With these patches it becomes possible to know if 
checksum-offload is supported by the underlying hardware. And that makes 
it possible to apply NODATASUM in an informed manner.

I have not reduced anything, but added an opt-in for deployments that 
may have a different definition of what is useful. Not all planets are 
Mars. The cost of checksum tree will be different (say on QLC vs SLC).

