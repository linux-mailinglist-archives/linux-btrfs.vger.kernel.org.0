Return-Path: <linux-btrfs+bounces-14216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89097AC2DA7
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 08:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B59116AD38
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 06:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528B1C4A20;
	Sat, 24 May 2025 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ORUgODi1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FDE225D7;
	Sat, 24 May 2025 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748067451; cv=none; b=O1gkV08U6RGEjtkMXti9CEntav12caHoJNod80kz/wYPoLBzwejp3sM7xVcC35Qofvz1784IedSTlimNy3LHYDO/ACSCATHvCR5Rja1+RnR+E3m6F9um7y9eskMhzIU6Xniu7mM8Wviz4gHiLwfvKltbqDqrCvu8JBE9zQ4YbKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748067451; c=relaxed/simple;
	bh=gyIVeynlGXT0Dkk9gRi0ejHr20pq1RIEasesZ6iLMgY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qhxoiW55U8uVnuUtNQ4TWuV31ibNZmXH+J+hlrDNeEPVGhUkXxM+ZyzWmFKT6cxWwhN9Mm6vPMd+4fAyzALySJSGxUO1vS7rpYOI030YlplQYHg3sQD8e+sUBe0CCWe9+ZNORC25w3bwvqHkYtSDHWSKWJKhhu/ZPYDUHwIWt0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ORUgODi1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748067442; x=1748672242; i=quwenruo.btrfs@gmx.com;
	bh=gyIVeynlGXT0Dkk9gRi0ejHr20pq1RIEasesZ6iLMgY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ORUgODi1ElEwf8TBBQvdlcuiVRSOuDTLyZasVydgjY8WnA3bHRT/Xbm+1ux3JdYw
	 yk5wHtJrE6um8SkBhRc+9nm4wshMZtAM9GwwA4/fOpMwL/PSzaWXvkEBSknRmfvuO
	 k+dF1mmtG6/TeBvFHUwqyeuIHRImSQ9ah42Mi+1CJ+KrARcfKseFVrUD4Dgtc4B+V
	 /PdOAQc1ZWQXn+ihJMEnuGIBSbYXpuP4xCsGOcsCfYQgZmkrwrgnZKVlJrFN8xFHV
	 o0GYj0Wo3+YSkXJrMoAL28rX4R2yAZQDLqhn5Suwjy5HRgbbJGeFg1E9LUGAdJLS8
	 Vi2PMC/zav8ezHH3AA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWih0-1uPEXx1drE-00VtDP; Sat, 24
 May 2025 08:17:21 +0200
Message-ID: <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>
Date: Sat, 24 May 2025 15:47:16 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <20250524040850.832087-1-anand.jain@oracle.com>
 <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
Content-Language: en-US
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
In-Reply-To: <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mgE1nO6eN8bk+OtB5e6WM2IoI7z0NXBFyNoaO80BVuNsaR1QgW1
 8GilZCAShEW8kiuHdzpatws+NFow8v+SLg9zEvPu/NROZg7g7q/o1pW2wz4oUx/fp8sintp
 n8azPs/z7jRRBap+Wzo5lx5JyawoghObifQDQRj4z6JHRE2sSinPzupwbQUzm1nHaBKonCN
 32+O3KtxJkzzhVB1Ry0cg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hYnGac9Ay88=;wteecdmmK3Vka16MV5eHtrTRI+O
 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



=E5=9C=A8 2025/5/24 15:14, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/5/24 13:38, Anand Jain =E5=86=99=E9=81=93:
>> Zorro,
>>
>> Please pull this branch containing fixes for btrfs testcases.
>>
>> Thank you.
>>
>> The following changes since commit=20
>> e161fc34861a36838d03b6aad5e5b178f2a4e8e1:
>>
>> =C2=A0=C2=A0 f2fs/012: test red heart lookup (2025-05-11 22:30:30 +0800=
)
>>
>> are available in the Git repository at:
>>
>> =C2=A0=C2=A0 https://github.com/asj/fstests.git staged-20250523
>>
>> for you to fetch changes up to c4781d69797ce032e4c3e11c285732dc11a519e3=
:
>>
>> =C2=A0=C2=A0 fstests: btrfs/020: use device pool to avoid busy TEST_DEV=
=20
>> (2025-05-14 09:49:15 +0800)
>>
>> ----------------------------------------------------------------
>> Johannes Thumshirn (1):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fstests: btrfs: add git commit ID =
to btrfs/335
>>
>> Qu Wenruo (2):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fstests: btrfs/220: do not use nol=
ogreplay when possible
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fstests: btrfs/020: use device poo=
l to avoid busy TEST_DEV
>=20
> There is another patch that got reviewed but not yet included, and it's=
=20
> again related to nologreplay (this time it's norecvoery):
>=20
> https://lore.kernel.org/linux-btrfs/20250519052839.148623-1-wqu@suse.com=
/

Nevermind, Zorro has already included this in the queue.

Sorry for the noise.
Qu

>=20
> Thanks,
> Qu>
>> =C2=A0 tests/btrfs/020=C2=A0=C2=A0=C2=A0=C2=A0 | 49 ++++++++++++++++=20
>> +--------------------------------
>> =C2=A0 tests/btrfs/020.out |=C2=A0 2 +-
>> =C2=A0 tests/btrfs/220=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++-----
>> =C2=A0 tests/btrfs/335=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>> =C2=A0 4 files changed, 22 insertions(+), 40 deletions(-)
>>
>=20
>=20


