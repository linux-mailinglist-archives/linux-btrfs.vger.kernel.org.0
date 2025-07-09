Return-Path: <linux-btrfs+bounces-15369-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74E6AFE298
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2935485D89
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6902741BC;
	Wed,  9 Jul 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RLWc8yQ9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68E273D9D
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049785; cv=none; b=lqM1iL5alPLuAa0izLo+CXNz7oSh0fV61+YW/wg4uzNmMJtJzQi2Sw72LviP+rqVs9kzRD6x4GO26+uCz457CW6j1NdJu4oDp3U8VbjRdiQUMOO2NF9qQ08rFD/Z+bxHNgcjdVCIHmStNSWvyCZXS7opOZ+Nw85PSMRq79rS1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049785; c=relaxed/simple;
	bh=OwtNxbn59IimMbQ7II77wF9Cv1kJJa+mN47dmqRtUUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DatVvZipfUbJTmZiqarpUl2x0XbZSukVwvH05CpMEfSeBE8zzoZmjH18/EsGRL6o4k5s4sSJXaEtcA+yLiMCZFMS4/lUpqyWlUXPqngmigLsuR/Q+H18enQgYRlFN5x9STzucvp14cJ3UuaAaG7w32fzLtO31pSKFAMruZkaVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RLWc8yQ9; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752049780; x=1752654580; i=quwenruo.btrfs@gmx.com;
	bh=OwtNxbn59IimMbQ7II77wF9Cv1kJJa+mN47dmqRtUUw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RLWc8yQ9Z9ps+gJn/5UCxHDz5nxhGY3BjU9GapDOYjh+ubT5uuHCEMPKC9QSnyHy
	 6wMbpp5D8SXpb0k2uj5JLlsdD5vgWfTnijPzTGiJotpBuucaXyRsiGZZFXZlZ44P4
	 xrJLywYnZxr2jymkkzp26YTqaByOmO9TsgIiDtF9b6kByt/Pau65BQZ8YFcPmTpR4
	 /YnYdHV7rAE/Nru8vuujMJUG03CC3QbS3xl+BrgGSVVkyyXbLFe6WYMO5ALosjLn+
	 hHT3B4gEk0hLL9sKnnhkJHXmq5a/QXGSJOvQr86gf9WxwwGsLdk/6aoxC3mellCHn
	 nVKi4J0RDgOSl2POBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MFsYx-1uRQce1uQR-007aHW; Wed, 09
 Jul 2025 10:29:39 +0200
Message-ID: <68c81f63-d7ca-4222-948c-36b7e5c863c2@gmx.com>
Date: Wed, 9 Jul 2025 17:59:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: do not poke into bdev's page cache
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, WenRuo Qu
 <wqu@suse.com>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1752033203.git.wqu@suse.com>
 <d3fa291f-656b-4430-923d-567208146302@wdc.com>
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
In-Reply-To: <d3fa291f-656b-4430-923d-567208146302@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:15IGtNA5RNsdH63mxDI8exVe4qtIAAVGYbBi/JuedqtTgeN4oNc
 qcs6bnhObSE21SDIEOuNuPnV2Dn9wDPPNssZzquhp7oo6K1ScDzSi/KmsZyFpYApWxBsNCv
 vlYXpwfcAiMxguyaVGUXN0d4nbVAZV2v8M5DIiexgLO6wnGLlfiETlvC+tZxm0UINqPF3m3
 F3CD6lYuDeM3CfSlHZU0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:naXzyd3L/SU=;LikgJcTvdxvTA8CWCIQCNQs6rIm
 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
 UZxfeMQqCTw==



=E5=9C=A8 2025/7/9 17:13, Johannes Thumshirn =E5=86=99=E9=81=93:
> Minus the nit in 1/2
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> I'm also running it throught fstests on my CI setup (nearly done and
> looking good so far).

If your CI run has finished, mind to check if the generic/492 failed=20
randomly?

During my local runs, generic/492 will hit random failure, due to blkid=20
unable to find any useful btrfs super block.

And that is caused by the 2nd patch, which makes sense as that patch=20
changed how we write the superblocks.

So there seems to be something missing related to the writeback behavior.

Thanks,
Qu

>=20
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


