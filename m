Return-Path: <linux-btrfs+bounces-18323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E5C08486
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Oct 2025 01:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13E083513BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E5930BF6D;
	Fri, 24 Oct 2025 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ojbjq5J2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445235B130
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761347610; cv=none; b=cuniFkIHDljoal+K8nA86zWNeGldcNIpqo84fxPE7xu+tmswkHrDABtBTsCml0/5EPtle2OFj0ncl7gFd0z890wfuUOrjkogY8zjhFrNk/mpOUTg0SQ3Pauh98Iqy4oBOwCpKfFbuWKPDus2Asefc/6FEdkb5uOOtKZeFcVjZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761347610; c=relaxed/simple;
	bh=4XfsWzA9tjp31JJOwE7hENUX0HYJ8hVh8/griJyrlLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8dGV5WzERLpMnLSOUclhBMQBlKefa2pBdz84Em5fM3Ckjngp4oVQZY6kcP+sWCDBxmFqN9TUVVYhvHgP/S9zVDn+/knCOmrFVTvFi8QLz2LswhbWZAk8OCB4ilLQaoJiPXAsrFvnqNCJLERK/2/WEy9CVMGd3UGQrzTzPEKt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ojbjq5J2; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761347601; x=1761952401; i=quwenruo.btrfs@gmx.com;
	bh=LwZbDY9QZa7T2Q5ONCnduQPWXsqj2hcaBA0EgUCZxhw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ojbjq5J2m8zJ4hl/DBlNwt3BbTRLGLYOeC7XDt2AhPxOF7TOuhIv0dp+3JhHFutO
	 NZShlc2sr2mL2c5I75vXPiiPLDSlvxvyWxFOOn80Eg4R6/P8LvH0YAPuBMe8liCFV
	 cJ7J7Z91rRLMF+/Gmdn7TApUbPOx6slpMdUej6dsk30VMitTeyh1aJ3HtyeJsSGLO
	 UJEnxowtjI4kKLjaSMC+7/JE5xD7Ufu09iFgCtX286cjydDZu9Vvukos1xMEe7rNp
	 ELS55MjjO/A18BVCCbuOPbo1++kKZ2E/ZsSm62QHRvXee7ARDgbvaeLdqfhZKXf6Q
	 9bOpuKJkDaDfexe4Vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59GG-1vBL2j0ASK-000MpI; Sat, 25
 Oct 2025 01:13:21 +0200
Message-ID: <b838815f-8ca8-406a-9511-c09680cb3ad6@gmx.com>
Date: Sat, 25 Oct 2025 09:43:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cover.1761302592.git.wqu@suse.com>
 <44a1532190aee561c2a8ae7af9f84fc1e092ae9e.1761302592.git.wqu@suse.com>
 <aPtbzMCLwhuLuo4d@infradead.org>
 <6e338563-97d9-46f5-bfe6-19a1effa8aca@gmx.com>
 <20251024225147.GA4182237@google.com>
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
In-Reply-To: <20251024225147.GA4182237@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hSyGKUz6ZNR5641KNgKYyMSdHYGzb6LTBgnsae30FTsF7GyANJy
 mWAt5Ni9CvrNmOihN/NMAi0KoibCbIuHKEygT/UTzq3VRmz+mn45bF3Uat+3PNkuns0H6hN
 hROkUSYW8ckxI86AE+iPoQe75kbpk8ZXYynosLr1t4EszXvylFw1lxrfW/TQ1Svp2n2vDQP
 xpmnJByGH71K0o3vdNG3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UJf/e188b2U=;998SLU+iA4nVc9tGanq9tW0nN7G
 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



=E5=9C=A8 2025/10/25 09:21, Eric Biggers =E5=86=99=E9=81=93:
> On Sat, Oct 25, 2025 at 08:45:09AM +1030, Qu Wenruo wrote:
>> Even if the new API can cause black magic to make CRC32C to be faster t=
han
>> DRAM bandwidth, it will not remove the latency.
>=20
> For what it's worth, crc32c checksumming is often faster than DRAM
> already.  Though, being faster than DRAM is still useful when the data
> is already in cache.
>=20
> For example, on AMD Ryzen 9 9950X (Zen 5), I get 89 GB/s crc32c with the
> kernel's current crc32c code for data that's already in L1 cache.
>=20
> However, Zen 5 tripled the number of ALUs that can execute the crc32
> instruction, resulting in new code being optimal.  I've tested that
> 130 GB/s crc32c is theoretically possible with Zen 5 optimized code.
>=20
> The indirect calls and other overhead in the traditional crypto API
> makes a notable difference in checksumming throughput when the actual
> calculation is this fast...

Wow, that's really awesome. I guess this change itself is already going=20
to help btrfs a lot, especially for locations where the csum=20
verification can not be done in parallel, e.g. verification after read.

But I guess for much slower checksums like SHA256, the API change is not=
=20
really going to improve that much, as the real slow part is still the=20
calculation.

Thanks,
Qu

>=20
> But absolutely, the real bottleneck for I/O is almost always going to be
> elsewhere in the stack.
>=20
> - Eric
>=20


