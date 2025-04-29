Return-Path: <linux-btrfs+bounces-13531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279AAAA3B0D
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 00:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6916F7B19E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 22:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581B226FD9D;
	Tue, 29 Apr 2025 22:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="N55v/Lkm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EE726B972
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964658; cv=none; b=GGna6QmXg9E6y9JhqxHX7cRVIsb+16N377vna45HfMDEZy0RrufDtJ3W25ThwzFzTVarM5aWHx5Txe/mhJ2ZPZTC6uwMDGx3Q00XrdCdcaArESl/wMUCQbSsw/qLo/yp4hI3oe1pEMvRDmrxJgwXxJ72eDgGBkUlJjmf9YOGWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964658; c=relaxed/simple;
	bh=USLwC0K5d/7Ns+dSoOQPbELq/c1+HYEV/6Eu5joxeGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GMMhcVNwjlWBQT6SBTc2CM0/gDfq7veHCBXQKcFe1qyD/nBko5s3+ygpGScqLOntzozAQdRe1rDLvm6jo6Si+0XJgZJOD3UqjDUu/DlAKnljR0zwvZXKoPo7I8pOo5Y05Eug0AJ3jEZlCwa6X9tuBLrDhu93GwQk9HV4zgF2U2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=N55v/Lkm; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745964654; x=1746569454; i=quwenruo.btrfs@gmx.com;
	bh=USLwC0K5d/7Ns+dSoOQPbELq/c1+HYEV/6Eu5joxeGw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N55v/LkmcZtXh3PCqCJBOrOh37CCaN7xiu/VF3PVOOZNFmW/mSMSATkxfGXpoNLJ
	 4r1P1CGox7nNAD1nvd6VP3r9wNX17KubYPKDFDxlCBB3iPO6+ae8ra8ybh7befUYZ
	 kpgGfvi1h/EUMlpeflyLc6WXjlK91KEGbX2rwoXdi9cJ5lUgBEhwp6O91MOo8WMa/
	 1Lhi9+sp5Aq1NW7mzpASCU+8wPS9DF2Xc/Q2cfyKtLQcizFblsWdKMyKWKvMgAOoT
	 waS/my0yB9glSJLLnItLa3kkIx28obrxCfWjVM/Kq3BEK1a2FuVB69GpRaGPfpjGD
	 2N32V50vYyBymB/6sg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MysRk-1uwv5L1IN0-00xlTJ; Wed, 30
 Apr 2025 00:10:54 +0200
Message-ID: <0b279ab2-b1b0-4fc4-9375-bc024b6742c7@gmx.com>
Date: Wed, 30 Apr 2025 07:40:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bad tree block start, how to repair
To: Chris Murphy <lists@colorremedies.com>, "Massimo B." <massimo.b@gmx.net>,
 Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <180daac980bec43d45d0e6fa4f9e1d14fb126de1.camel@gmx.net>
 <bb9b6bd4-6638-4139-8ccc-dc677f85e3a2@gmx.com>
 <7c762297-2425-439a-916c-e61c0403c1fb@app.fastmail.com>
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
In-Reply-To: <7c762297-2425-439a-916c-e61c0403c1fb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MYhp0oFjs044t/7gwPT5vcimz10asvWoJNPldUJFW+6xDJ0vJ4N
 +sAgzRjt3CzDDgdQnzjXCqMNam4KQwQR4Pt3PdgBW4cVjGcKHonTvFz9QgQfFX487MSS7b4
 FV28FsrGMd4YMiM476j2y1zrNq1ZZcARNaiGHRbqGv2xpymjDfUeFzkXJCCisU21wg/Gu15
 L6UnYK4UXvPiCD0pCZJ8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H0EywTu30HM=;ipDrU30ZCxx5S52VTFw0+QYAzps
 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



=E5=9C=A8 2025/4/30 04:39, Chris Murphy =E5=86=99=E9=81=93:
>=20
>=20
> On Sat, Apr 26, 2025, at 3:08 AM, Qu Wenruo wrote:
>> Unfortunately I'm not aware of tools that can drop a corrupted free
>> space tree (the existing tools all requires a working free space tree t=
o
>> drop free space tree...).
>=20
> I thought btrfs check --clear-space-cache v1|v2 will just remove it, and=
 it gets rebuilt by the kernel at the next mount by using the extent tree?=
 It seems fast enough it's not actually checking the tree for validity?

The free space clearing is doing proper btree operations to delete the=20
free space tree.

If free space tree is already corrupted, it will not work at all.

>=20
> Is the btrfs rescue clear-space-cache <v1|v2> essentially the same code =
as the check subcommand? Or is there a meaningful difference between them?

They are the same code.

Thanks,
Qu


