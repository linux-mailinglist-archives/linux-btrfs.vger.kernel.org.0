Return-Path: <linux-btrfs+bounces-14447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3A5ACDAAA
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D94617739C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 09:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBD528C85F;
	Wed,  4 Jun 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C9xbeXju"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9D28C5C0;
	Wed,  4 Jun 2025 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749028397; cv=none; b=MP+deKbhs92BlacKVeA95Xmr7gg/wDKQDnUIa3QrGddojQww7EDaXLUqngoul/yK1eIzpGBDQDbbEhs5R8C0MSTBlWbqJy5OMavt/Woh3eLunxOheXWuJKe2tEHqneDdkWlFfHl5YfIv2K11Ip9dtAc8J6PgSk4IlBEewBuq1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749028397; c=relaxed/simple;
	bh=ex4VvesIrnQACmVKO/o/zNSktijpCFgRg4SdxvD6s8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H/PIAgTAdv/r1LUY33//i6AK6tropl+5Dc6MZNzWAvPm7VfnF85D8vh3EMH7vvYZiif6x+fDPpvI8d5CSdPaqlIIp1sfXLgAJNDS/L3WbDLEu8GxqJTEps319vbPMCm2puwh5jC5Djkwh3Bv70vA2wo+qGIm1scUpAt+XF62cc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C9xbeXju; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1749028393; x=1749633193; i=quwenruo.btrfs@gmx.com;
	bh=6lOzKI+LwCe/d3tsZofDJEPCZ4aA1LPWSaajQ9InbB4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C9xbeXjuIqVI1zaIDJEaSiP6NQo4Y1hX/OuDtTjKx1BdpsAHBTasQOOWH6vN0tnZ
	 plESAOUlWZtXu0a2PM0kaE3XsjjV9B2khIYxcKMYAuPYsO2PdL5j/2pqMz+UVr25L
	 aQBqzCyEKDXfaxcjOWesX4o3g8VgmR1AuPhT+Js/Q3HssOziyEKBxkYT2YtWDG6Kc
	 uV9zi8F3jTlr6K6w9Zb53ZI2ijygvAlH67B+cUdJatcFEvYz5FpcpouyN0wZ12v/c
	 Cuz0pXD1qZ/BN/E1dSo5iUgvqMOCPELZzQh7eNYw7rPCRD1TSe6dL+jnYcHHkgbaf
	 CByGbnhmoA1cCzAtlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M5QJJ-1uO7ED0A3Z-007kWD; Wed, 04
 Jun 2025 11:13:12 +0200
Message-ID: <3fa2ea39-ffaa-4732-bf9c-8ae9636d0a9e@gmx.com>
Date: Wed, 4 Jun 2025 18:43:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: generic/730: exclude btrfs for now
To: Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250604071024.231586-1-wqu@suse.com>
 <bf4a8a9f-16cc-467d-a039-2a5705ac52f6@oracle.com>
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
In-Reply-To: <bf4a8a9f-16cc-467d-a039-2a5705ac52f6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fioTw0/MR6w+C+L9qEEvDmC+RpG+N0S2vRG1z/zgIS9mluUipmL
 wN63H3vHXC7AXRd3z4La9UqN5k9ryE2rlXp6aRAT1zkjzuf+4cSK7keUD64UgahzsZZm9z6
 Q/XsxE66xzHOJVso4ewpLYv3qrkaxiGI7vwCoC4ykDIqkUx3vxX89U7BqzNApbMT36fX69m
 uHrqTaQNXfx7wqgFYK57w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OLsq3hME+jI=;uVbJPG2Yr5Z6IzYFFOvtQ2hZCjg
 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



=E5=9C=A8 2025/6/4 17:40, Anand Jain =E5=86=99=E9=81=93:
> On 6/4/2025 3:10 PM, Qu Wenruo wrote:
>> The test case always fail for btrfs:
>>
>> =C2=A0=C2=A0 generic/730=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output m=
ismatch (see /home/adam/xfstests-dev/=20
>> results//generic/730.out.bad)
>> =C2=A0=C2=A0=C2=A0=C2=A0 --- tests/generic/730.out=C2=A0=C2=A0=C2=A0 20=
24-04-25 18:13:45.203549435 +0930
>> =C2=A0=C2=A0=C2=A0=C2=A0 +++ /home/adam/xfstests-dev/results//generic/7=
30.out.bad   =20
>> 2025-06-04 15:10:39.062430952 +0930
>> =C2=A0=C2=A0=C2=A0=C2=A0 @@ -1,2 +1 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 730
>> =C2=A0=C2=A0=C2=A0=C2=A0 -cat: -: Input/output error
>> =C2=A0=C2=A0=C2=A0=C2=A0 ...
>=20
>=20
>=20
> [PATCH v1 5/7] generic/730: add _require_scratch_shutdown

That works fine for btrfs, but that's only for now.

The _require_scratch_shutdown is only going to check the shutdown ioctl,=
=20
not the per-block-device shutdown.

I guess this means for fs supporting per-bdev shutdown, it must have a=20
dedicated shutdown ioctl.

Thanks,
Qu>
> Fixed it.
>=20
>=20
>>
>> The root reason is that, btrfs doesn't implement its blk_holder_ops whe=
n
>> opening a block device.
>> Thus when the underlying block device is marked dead, btrfs is never
>> going to know thus no way to shutdown (nor btrfs has a way to shutdown
>> either).
>>
>> I'm trying to improve the situation, but until then just exlucde btrfs
>> from the test case for now.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Update the root reason
>> =C2=A0=C2=A0 It's not the sb->s_op->shutdown, that is only for single d=
evice
>> =C2=A0=C2=A0 fs (through fs_bdev_mark_dead()).
>> =C2=A0=C2=A0 For a multi-devices fs, it should provide a blk_holder_ops=
 when
>> =C2=A0=C2=A0 opening the block device.
>=20
> Along with that, I think it is a good idea to bring=C2=A0 XFS_IOC_GOINGD=
OWN,=20
> per fs (all devices in a multi-device fs) and vfs level so that we could=
=20
> support unmount --force.
>=20
>> +if [ "$FSTYP" =3D "btrfs" ]; then
>> +=C2=A0=C2=A0=C2=A0 _notrun "btrfs doesn't support per-fs shutdown yet"
>> +fi
>> +
>=20
> _require_scratch_shutdown() will take care.
>=20
>=20
> Thanks, Anand
>=20


