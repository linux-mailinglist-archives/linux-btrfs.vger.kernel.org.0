Return-Path: <linux-btrfs+bounces-14218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21EAC2E12
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 09:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515551BC054C
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7502A1DF261;
	Sat, 24 May 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mO67050s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974C320F;
	Sat, 24 May 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748071448; cv=none; b=qNNRuGkZIZe0BWRe8qmBXACYyOcCAQ1jhS7bntStgChqZYh1pBTH03dfglZZC/tXUtr+TrFll4B2TJRPyizQC0tMugL3RAbMObvGB2Dgwt+akyjM6Ub0fRM5T0mE03Y5JGvmWkIrPDR+Bah5BBHFLeLczdbUW3uz+wTn2Q7Fz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748071448; c=relaxed/simple;
	bh=Z4/mevWHYB4sDO1r04QZSS1PfTSwdfkobvvvArvKFNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvdgaUQm4fgZP7Dbs+xtrCH4vMx9Lnb2s4GO5UUyXbnnk8AuRKKXHCYd+UXQdQ2HHgrdElpO59Ks0STikhf1dFpDIKEVE4XcWvl2ClFtO9R1hw6v7LAC7l6FsH7oGZ/LApLozgaDD9DXeFJq6+HhwQGvqDjJeiOqcvA7JBLQSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mO67050s; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1748071444; x=1748676244; i=quwenruo.btrfs@gmx.com;
	bh=libNomrObMCfJ24JLv1+EtyIO1PNQm1Iivxli7Gedvo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mO67050sg2E5/9UZygpzFPwbSgkVGH36yyt3jgU39/w9lhJZ2jUkHaBPLmZCvYXo
	 XgxP2h2TW4QuNUQeQSnEsXWqv+DW9mLk9UM48+euLGUXAnWg60glbzCmco0QSuydc
	 R1xuLbdYMdcNj9LmH7vVEioohuaKKBhEZRzBa7f9/vDC83CWt/IoO5n66MdC2iNZN
	 BIlAfh3LVTVYpVOBn/DTrxH/fo2eVJRZUfCYrYIH1QD07//EMYoT+rhVpVR2td8a7
	 Jmgkm/WO34mA5NynifxLPTIgZbNRoK+YhK9vxnFBnArEKeegDULOOTiWeisGZ76/4
	 pK9S9IAq90buTeRcbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N17UW-1v3WP42cl0-0121HE; Sat, 24
 May 2025 09:24:04 +0200
Message-ID: <d9d43c96-886d-4f2a-a736-3d9b225a0cd8@gmx.com>
Date: Sat, 24 May 2025 16:53:10 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] fstests: btrfs changes for for-next staged-20250523
To: Zorro Lang <zlang@redhat.com>, Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20250524040850.832087-1-anand.jain@oracle.com>
 <26d4ea00-3ea0-469d-b6e1-a58f717f4013@gmx.com>
 <b8e4f687-809c-47d6-8534-e2ffe0e85596@gmx.com>
 <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250524065222.v5ivpxkh5q57ke2v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cX26Mu8IpMvu2TC/HQ9FJFxksn0im0In3sVFj9CkXzXUyKLpLGH
 GxlHOzvhhUNKfyDV/QNyEKd6lKowsVKBs9mvPV+/pkyQAA/5/K32oOzR5J9/iYf+bNqqAI1
 /LlDIQ2WIR80up5UJP1M+IWKX17zOU85SMV+XKm3FRBKc5tWN1dIAOtgiwrrTbdgV9CWjOy
 5wBOV8O0cYT6c15iuEKng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IZ1FK5T4Am8=;fjVAlmTZtlq+etssQMxpfMYJ++5
 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
 uHBTtsi5DruAg=



=E5=9C=A8 2025/5/24 16:22, Zorro Lang =E5=86=99=E9=81=93:
> On Sat, May 24, 2025 at 03:47:16PM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/5/24 15:14, Qu Wenruo =E5=86=99=E9=81=93:
>>>
>>>
>>> =E5=9C=A8 2025/5/24 13:38, Anand Jain =E5=86=99=E9=81=93:
>>>> Zorro,
>>>>
>>>> Please pull this branch containing fixes for btrfs testcases.
>>>>
>>>> Thank you.
>>>>
>>>> The following changes since commit
>>>> e161fc34861a36838d03b6aad5e5b178f2a4e8e1:
>>>>
>>>>  =C2=A0=C2=A0 f2fs/012: test red heart lookup (2025-05-11 22:30:30 +0=
800)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>  =C2=A0=C2=A0 https://github.com/asj/fstests.git staged-20250523
>>>>
>>>> for you to fetch changes up to c4781d69797ce032e4c3e11c285732dc11a519=
e3:
>>>>
>>>>  =C2=A0=C2=A0 fstests: btrfs/020: use device pool to avoid busy TEST_=
DEV
>>>> (2025-05-14 09:49:15 +0800)
>>>>
>>>> ----------------------------------------------------------------
>>>> Johannes Thumshirn (1):
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fstests: btrfs: add git commit =
ID to btrfs/335
>>>>
>>>> Qu Wenruo (2):
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fstests: btrfs/220: do not use =
nologreplay when possible
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fstests: btrfs/020: use device =
pool to avoid busy TEST_DEV
>>>
>>> There is another patch that got reviewed but not yet included, and it'=
s
>>> again related to nologreplay (this time it's norecvoery):
>>>
>>> https://lore.kernel.org/linux-btrfs/20250519052839.148623-1-wqu@suse.c=
om/
>>
>> Nevermind, Zorro has already included this in the queue.
>=20
> Yeah, I've gathered some other patches due to I want to start my regress=
ion
> test on Friday night, to catch up the release on Sunday.
>=20
> You might care about below commits too, they're in patches-in-queue bran=
ch,
> feel free to check, and tell me if I missed anything:

All my bad, I only checked for-next branch as that matches the name of=20
btrfs development branch, forgot the latest one is patches-in-queue.

>=20
>    f405f5f6c fstests: generic/537: remove the btrfs specific mount optio=
n
>    3bbdf4241 fstests: btrfs: a new test case to verify scrub and rescue=
=3Didatacsums
>    282e4fe8c btrfs/023: add to the quick group
>    3c21ae673 btrfs: add tests that exercise raid profiles to the raid gr=
oup

Looks good to me, thanks a lot for merging.

Thanks,
Qu

>=20
> Thanks,
> Zorro
>=20
>>
>> Sorry for the noise.
>> Qu
>>
>>>
>>> Thanks,
>>> Qu>
>>>>  =C2=A0 tests/btrfs/020=C2=A0=C2=A0=C2=A0=C2=A0 | 49 ++++++++++++++++
>>>> +--------------------------------
>>>>  =C2=A0 tests/btrfs/020.out |=C2=A0 2 +-
>>>>  =C2=A0 tests/btrfs/220=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++-----
>>>>  =C2=A0 tests/btrfs/335=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
>>>>  =C2=A0 4 files changed, 22 insertions(+), 40 deletions(-)
>>>>
>>>
>>>
>>
>>
>=20
>=20


