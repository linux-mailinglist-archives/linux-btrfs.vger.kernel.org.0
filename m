Return-Path: <linux-btrfs+bounces-18749-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27678C38D38
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 03:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F394188383F
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 02:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE737238149;
	Thu,  6 Nov 2025 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sUBMpI/8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A21222578;
	Thu,  6 Nov 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395141; cv=none; b=ZvFKFA805YofEqgKGPyC3E7H2zvYnupkmb7cf0qaa2DRKhkK+phF/2C4QxSP57FM16M5Gafnkds3Me/utM13KQEHwS+v2S7SAyawf8M4UK3bq3yDCoJ5ogWHBF+u2CdOVx/OOjEEUC26gfDGpd0rpfOF8Ca6Byn0MViHiN8tVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395141; c=relaxed/simple;
	bh=HLlaUMQx5ZVcb48HGFptrnTlQp9O6RS8rC/Y+jg4gh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENxs/0wBv71joErx+5bfei8BizDh6Uv/YRDfdZrWJxkyyfGRlgDHMdkxiExq0irNNcNK/0upfo5lVbR0Rn/raUlIScyyY5ZNt6nfC0mYqihOx2VGeV1KM8NIg4+Y/kvcT11yxXm/B8UDjpLhdt5TCQgiG4zxeCFNHmHfKDPfsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sUBMpI/8; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762395134; x=1762999934; i=quwenruo.btrfs@gmx.com;
	bh=HLlaUMQx5ZVcb48HGFptrnTlQp9O6RS8rC/Y+jg4gh0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sUBMpI/81o9d9GBc0dWiOt4v9CbJqft/kEe8ihAh7QRgki+9IAltTl2TS3DUzYni
	 GbS1PWaGGoTSw75UC5hOnV0v6bnItMGhPPXhMgG4F5gpqaXd3AptqQya9t7xXs5y5
	 mmqGeLqVJJvDqFQh5sYvQ05WUD3eMsU85N9gqB86qKuNSAZwEGjqgDPCxAToeaM94
	 zJv3zqbvfpvLwfa8Uz24CGjb+tEFGB0l2mN8rzBR97oRWSc+5JcrK+w5JllxrrhHm
	 P2fmCrAJwhcC37yW2AfO3xk2DYbte8q8Dl0qgSs88bIKaYNenBWf3FW7MUsaWajDA
	 5NyVkk1iOLaVTihbGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHXBj-1vULzr020f-002k7z; Thu, 06
 Nov 2025 03:12:14 +0100
Message-ID: <a2d629ab-9f21-4b98-a442-fd73cbbb2dcd@gmx.com>
Date: Thu, 6 Nov 2025 12:42:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: fix memory leak in
 scrub_raid56_parity_stripe()
To: Markus Elfring <Markus.Elfring@web.de>, Zilin Guan <zilin@seu.edu.cn>,
 linux-btrfs@vger.kernel.org, Chris Mason <clm@fb.com>
Cc: LKML <linux-kernel@vger.kernel.org>, David Sterba <dsterba@suse.com>,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20251105035321.1897952-1-zilin@seu.edu.cn>
 <2603afff-0789-46d3-9872-3911132a53b1@web.de>
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
In-Reply-To: <2603afff-0789-46d3-9872-3911132a53b1@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p0xvlCXFi3o6U/zxZKMdQqs7EXxbLWpLGClIFhHnrn2uKYYueJK
 bGG07k3Q7t8fkhXVzbwy+/891S+xcok1UH/cyTnmcClzsx6RpFKKxI8BsR/zPCMh6b8ZWCo
 M5Ib5m9OBK2LeuPwV3ahQo4NsmTdii7JI9U98KNNhfqRxgYOyh0IfX2iqXJuRp8YWiKQ5mV
 laG6WmI5BSpEzAwPHK1PQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xU5IM9Y84lI=;z3fvum/VAyMk3JL7ErhietSUmjO
 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
 FwEGacQgDtR6M1acXRcCH1Or5w=



=E5=9C=A8 2025/11/5 20:56, Markus Elfring =E5=86=99=E9=81=93:
> =E2=80=A6
>> Add the missing bio_put() calls to properly drop the bio reference
>> in those error cases.
>=20
> How do you think about to use additional labels?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?h=3Dv6.18-rc4#n526

I believe the current hot fix is fine.

As in the long run we're going to use on-stack bio for this particular=20
call site.

Thanks,
Qu

>=20
> Regards,
> Markus
>=20


