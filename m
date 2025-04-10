Return-Path: <linux-btrfs+bounces-12939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E830A83883
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 07:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDEE463802
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 05:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B409D1F0E3A;
	Thu, 10 Apr 2025 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YoXgJJkN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A94A1372
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Apr 2025 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744263574; cv=none; b=bMn/XEsG4RR16pV5uWuRxOaZOmE/Jm9pc9D9gP165CfD0hkt/GiYKrZF3VHsLMnkCQ9+TJX3/grl1KT6rMzIddr2qzBrTnv+xWK32s7fshhrKrg8yZQX2zTgHwwVyKFo2iXMUoXI31RGFNhKuI9tZ1oKsSSU9chFQSdLU0CSIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744263574; c=relaxed/simple;
	bh=9ANCXlngQ4W6L0MdflHnYH5vwxUt0ZDR9e/EVMqwOaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebF7ZpSImj+jispYyftrZjnyCmiiDNHFVKPi1ia3emOKxUPlysOVcSGL81MkLE1/e3zZmdS1k0ZCSB012m+5WMKnJ4JrHqj7X5VgCatk/Yhg0BJeIz0AY6r/d9VwX0Yo7PUTAnDmHwVBItCP0Q6r15HXlDvyiIrdu/gKO5mKvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YoXgJJkN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744263569; x=1744868369; i=quwenruo.btrfs@gmx.com;
	bh=de9oblnbZIxX76GY4N2SsucX4VoG9yt+i1NzCe+g2xo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YoXgJJkNtai08xrEN9CuSffltgDW31XXZgd3bxw6EZ+V5WpD1YO/a4Ju2/rS4DsS
	 b7eGjRVA96+iG9f6DtjD9dTqJquXvNsSTqVXGNIqiAoVGWATLzlN4/sgbkcrR38XF
	 kaEu793+LPofU5xBPHwhop+hbbCyDQYFqOPCZv/jsgEI6tn08y2FWognlMkkbqr/q
	 PAjR9g8ByTgBzt6PdnlrbYzYQJTh1CUx/YOnduUCLccS582vuArEUVhPv0d6+goK5
	 7oUU5dNbGLW7eFkq6iaCtcRkJY/usEUbmmPutB07WNDaCU2jmbCYOGEZED4fmliCE
	 O9dRHsoHtvKo7DkvlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mplbx-1tHKP736Rp-00q6fO; Thu, 10
 Apr 2025 07:39:29 +0200
Message-ID: <fdecb080-1398-45a5-9b41-9d9d5363ee6e@gmx.com>
Date: Thu, 10 Apr 2025 15:09:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] btrfs: remove the alignment checks in
 end_bbio_data_read
To: Christoph Hellwig <hch@lst.de>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-2-hch@lst.de>
 <d0f52e89-1bd2-4a06-b142-1e18381862b6@gmx.com>
 <20250410053036.GA30044@lst.de>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20250410053036.GA30044@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YmOQP6nu8qtTHUUZPGxvCelWtLWxxp+WAYg17zPoMpGnViGib+9
 RT13V+aOnNO4K6eZ5yjhkQcXENdtrPvatg/a6ExkPgNCTH9d4oKjx4ELE5aqbu0qcry391F
 1wT/l2ro1Hm0B9iftHlOVRF0vdXSxQPsHT9dOKXzqNZXuxcOCatQhB51bWoyzLRublJPdLO
 BDJIbK/4NGJDFC+uSzUyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:55IepGkrLLE=;Cl6uRZRhbeXvisu9Bbhp6m9dht4
 NVcC8d4BqYds9SUzfQsEY7IgnZIbUPB77z/TGHUWpMkqAYiNxC3Y4Id7I0CAXRQurbj7LCI/X
 7pDnOdh7VjpXIemnjaPlSv5Ga17xaYGiGFUVBf0gT8dPdG5dbs6CycHkdQBozVI2OGDBF3Dqe
 WkQYnTnIRlANQtFUbKF3vnneKbd8V966gxjizJA831Y86cY8VFDkoZXuxQIcqXbofZ6GZZNnX
 Fh2sMnvZZIYg9c62GshNEmpg36eTHG+KbUhTkBUTBcuPQLxEOyLvq6Ww6de/rpr+OZvp3hzDn
 8BTidIvfDY07Z86mWZ9TL6zOyeqCr3VZ04F4KptzE7Rpeak766AkGGeE7bW5MySQtDf4D5GiF
 BxVn33CE6HYNH9M20WXhQClUVoXw2eDovtbLiHllVfYU4C/UTM050aNW4ya+xufNqyjEtPG39
 a+p0UnCKL6KA93z0gDXGdsmM8kFrWIytGQiu5keC9gsNAuvkaRgsq6i/zWaM9iiROIxYLZLQv
 SVuzhlKUDc7pTQ7lUti4xRQDFzLSSijUs7ihZVylOU8IXkv5I1narmaVQtNHZ0TP/j1Eo6ap7
 MI4X47uTnQMBb24QlLT2RAacpFQP6ef+43ePQ78vIXS3AFiaKB/6F3EnMfIJLD+QmaJy/Tig6
 quVeJ8kqrHKFZjvlkh1TGbj16EpFuPxWYwsKQhFnqT6wX6RRyBsghZAKh1bpOJKJMFHEKetUx
 HNU6+byl9ZwXzRDZw+FrMmgArkYBufgy3jqT2sKR7+xu5TipBWsS5ANGhejKphfdQXZJBnQjC
 LGQ0f3FCLwWiBDt+t8vZpIEiPUoUPJM8Pxf0OnTAls35L7l1JQK7pN3xEwB0T+XBFWesFduZ5
 8duaIjO9OIX5KJtc6Ox1RC+Zb2ZePKJIKZLmPJXiuDrlJNkN+f/Lxr0G4JWlT1w9KtOa/nPHZ
 sP9Xz7+Exhg78ehnnUXfWn+MEbcpptlxafmQsRYYKCmKpW9tGvt38aQ2pJXIQNH/LbtZSOmRa
 g8TKsyxRxyRRnvYwgHK+0fyufzzyyX9uTc6+xwUsIh4+c79CWNL6eUAiXbDyKuEQWnQpMF4VB
 NYpGGOuTMSgH3JhlKquo+qMomclp36+eLFZuZ7Z04Wi9rdFk/sXR4ll63iJrPEBz8TWR4LkzF
 8E8D2uy8kVD43ABUwvvY9CJw+q8ZjaH6iPeq8N7g0AXwS7em3yAcZQIyDtqIAaodmWqmOMDqW
 gX2swnCDk3g7xFIEBlmGmCcrb6HGyuskbSjowLKKiLVVgwJ7Z8IIluOQCw4WS9NqQMxBsUFTa
 cYGCfr24IY9O7dqGOTxNaoyQTSlNAoHae2RmXp0Up//rDYROdXndGT0rOq0Qo7BuEOX+4Wv3e
 eqBmyUCUVeiYjWv7n5DKnC5WgydLVkiNhzFol8ahtwtQVLu4dglUibRls4YfVipbks63W6s1W
 916t8Gg==



=E5=9C=A8 2025/4/10 15:00, Christoph Hellwig =E5=86=99=E9=81=93:
> On Thu, Apr 10, 2025 at 07:43:54AM +0930, Qu Wenruo wrote:
>> The old comment indeed is incorrect, but can we still leave an ASSERT()
>> just in case to case any unaligned submission?
>>
>> It shouldn't cause anything different for end users, but should greatly
>> improve the life of quality for developers.
>
> What is is trying to check for? fi.offset isn't really a meaningful valu=
e
> to check for as it's just an offset into the folio.  bi_sector would be
> useful, but it's not owned by the file system after the bio was submitte=
d.
> Maybe adding that assert to the submission path would make sense?  Remem=
ber
> that the bio completed is exactly the one submitted by the file system,
> and cloned split bio never reaches back into the file systems.

OK, it makes more sense, and we already have the alignment checks in the
write path (submit_one_sector()).

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

