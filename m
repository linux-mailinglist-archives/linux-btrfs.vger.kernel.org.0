Return-Path: <linux-btrfs+bounces-19116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DF2C6C00D
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 00:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 6411B291C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA4A316185;
	Tue, 18 Nov 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cmfMmwVe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC7D3112B6
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763508603; cv=none; b=hxTAoIFBlLGT7wIF97e2BnSfrQUJsYEVhUeyfV6eZmEDQxeBCp01ZadqEht5mzAMDQN+gATXfi/8yaX6qSjQviX4YgK6uJ+JgqgoEEd3ly2V31g2Klo2n7RUJeIC2QWh3OSQT480Qrxv76ffPI5LtioToOgZtImc057xzLgVRWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763508603; c=relaxed/simple;
	bh=rBnQu1co3QpLqdb/FAVAr+L1CfHG6Z70dtTkIYlY/jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QmQW96N0GOpWR+n5q2mDRAoHhCETSh9GNL1JyFSej4ajnVNISzOUlgkwxbX3yKnXF54tkJjh8bHCIj0jyfyJr36Ed9es+AwFV8hWFfdwA0sVy0Ghvh8JlFXEZKYs8iw7sraiGSmJqJy+54+jKcIaC7IpzoLmECVvWElvRgpbUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cmfMmwVe; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763508598; x=1764113398; i=quwenruo.btrfs@gmx.com;
	bh=rBnQu1co3QpLqdb/FAVAr+L1CfHG6Z70dtTkIYlY/jM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cmfMmwVeLZ0pHIAjOYfHgEIFcVgF/o4baUI39lFzeX+WxGMUv6l73NWJRCx+Trdk
	 JIXOsUxWf1bEJtJBR4iRMLVg/OznKHCt3fzzoa/umO5qkLve4NarZXs+Oh+amK7zt
	 W59nyD+y0jWV8fKKR1QWl+VHzuxL3yrU3VzX0+x/IpdN13zkJiuEkuINMi4lpJQkn
	 +4n3Dyl3UVgj4ConZ8tCCxSnB/6ZpJx4PhRN/lJabGYMFJFAvs25jKUVllC/8n7y1
	 6UPs1l3hpxp3PEVFqN17Tc2yEV3I77jLKXCVY/MfE/jTp16St40IJHxF2zgptoJuE
	 N17RDeVG7A19olEoTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9Bu-1vykEN3v7u-00qgQ3; Wed, 19
 Nov 2025 00:29:58 +0100
Message-ID: <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
Date: Wed, 19 Nov 2025 09:59:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: We have a space info key for a block group that doesn't exist
To: Christoph Anton Mitterer <calestyo@scientia.org>, Qu Wenruo
 <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
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
In-Reply-To: <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cHs/btG5byzfBv13VTaJEzyC1UZAthIyqPdk/XvEVyEKm1mFLAQ
 OBLRpT/XK/p3ffSpzsxqlMAgyCefiRmOXXix6hof3xECCj81iMaU70sZA59faopIO+8gNxm
 3T+jwiZ4YP+5HSye8TPck4PW8rpj+8lJBz4KhknOxz320uKzWWLdjjmnJEY0yzbhOTwqZY6
 mzXaJK/KZZ1q3Tp37zrUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LUwuxZFDUCU=;dBNRk+ROyadLVep5TQeLx2xQcwH
 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
 h8PuIboddbakDIKJWr696VkMXOx3iXF4dQqPp8



=E5=9C=A8 2025/11/19 09:57, Christoph Anton Mitterer =E5=86=99=E9=81=93:
> Hey Qu.
>=20
> On Mon, 2025-11-17 at 12:48 +1030, Qu Wenruo wrote:
>>
>> Nothing to worry about.
>=20
> Thanks :-)
>=20
> So even without clearing the cache as you've proposed below, it
> couldn't have caused any post or future corruption, right?!

Yep. Allocation is always happening based on a block group, such orphan=20
space info/bitmap keys won't cause the allocator to use it anyway.

So no corruption or whatever.

>=20
>=20
>> If you want the problem to be gone immediately, mount with
>> "space_cache=3Dv2,clear_cache" should handle it.
>=20
> Good. I may just wait for the mount time patch.

You may need to wait for a while though...

IIRC there is no patch submitted yet.

Thanks,
Qu

>=20
>=20
>> No. That's over-reacting.
>=20
> O:-)
>=20
>=20
> Best wishes,
> Chris.
>=20


