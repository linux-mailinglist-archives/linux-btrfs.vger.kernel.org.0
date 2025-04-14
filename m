Return-Path: <linux-btrfs+bounces-12977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5145A87702
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 06:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11B816F10C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 04:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD08199EBB;
	Mon, 14 Apr 2025 04:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OxHdkdlr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962543FF1
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 04:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744605615; cv=none; b=YN4AzUgB/nz8GYWh4k5KOVZzkmKgcGMRxO13HWf1UKEol06aegJALtX2tgdwUYzwZ8gXkk2Y9dw34oScgVCAemkU1qu5MP1PQpPtRnt87mKGNifw9+Zhlmp/2/D/LJt1oroi+krVhhd2viSS9/kNxopTP9jTuRh8Jbr6AoIiRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744605615; c=relaxed/simple;
	bh=Mk1Pcn+9zLBbf4T9NZ7bhv+l33QdAVW+sw13A8E+A8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZL0i96G55Y335dV12KwiicbKOnM3gzspTaiAq4tgPol2/SPthmPGM3xiGf1zciwAah4qxCA+7ZBttdBk8uTY7Px94i7plwq0+Uspevco65ZTc42nnKU+IfF3qFX1JG00rS9aDRa29hjkZdJooVaV34ftFQ5rcmTQbmGaC3txWKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OxHdkdlr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744605605; x=1745210405; i=quwenruo.btrfs@gmx.com;
	bh=YcD5eomXDApwfcVS+NCtBUedokXmQ+f4sK63oQCEfKw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OxHdkdlrdJ6xJ9gFf7WKvu1PbGLgW37L/RuGpmyHb2Sfbaq36BD/WfqPyff29gEF
	 lWNkjrD3wWjk9BB5cWKHLHwHKhrB4/WUsKG/qR+3cLzRdAo2vqEUphIxoSL+jmlCz
	 nU4z0mkVxXY/8DAhEO1R3eZfT3Zc3UJEH1bIBSOxGWG6TpFE9w+XPnxhLNrDnM30L
	 3hHoRIVZ+RLsH2iseaupPm78HK4UI612fbVR9k1ia8oJ3J2y1z6Wj+fLxeFOHoOfP
	 lKsP6LGQft1iHd8+eVUK2Zj1kTkj/AhSAUrJLUu7If1pojNB9wN7d5QrXCn4YuPfw
	 wAEnwaDek12ZMqPLUw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MSKy8-1tbhSm2X3w-00QUxD; Mon, 14
 Apr 2025 06:40:05 +0200
Message-ID: <31bd0214-955a-49a9-a4ae-f102044fcbdc@gmx.com>
Date: Mon, 14 Apr 2025 14:09:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests generic/619] hang on aarch64 with btrfs
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250413125349.w5jxnnphr7wliib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <17cd9240-99eb-49e1-8843-0a80a18f8ac2@suse.com>
 <20250414042322.ehea2rb5g5bo34zq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250414042322.ehea2rb5g5bo34zq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E2RFifi+wye8J6xLuhcrmP8NLoxkoG/B9omA7znWWZnkVpWauLZ
 FC/YXFDNmxV6SafLrHbOS5TqyafvTt8A67arhrc1cw1iseC2k1tRk4Kek/lyVzh8I42hUfr
 bJ7+i2fHQU5RiHiPReEUDzWNuOOikMY0FVS+mxLZTeIisPU0KevBXfDVfWk/3+kynDYbpGv
 RWNLdYIqQ80LSH1OWUckQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LUtWeXZSxF0=;agt6znpJPwOCmrwcHKnzQ6RCUix
 wUUAn8M9vC28v3b2JB/dv5xtmx5QwZm+A7c5dL/A2Chc5YAlvhCmkbfmXK4PX/EqfCQp2zenc
 tvrj+hd5kcZXx1PS1+1AfrAZNjs+qJ9klEoI5Xa3j6t2JibZhrdOe4aieGSxlQrqNChf/YKEs
 yjloVBe7fDyoGFPXOud5wGv6VhOyeSVmlEM09+ftYFmFVRbQpWtZ9308zXS3hzZdSk/y4jpms
 ECHkJq40JK2lLcVL69HwnLFF92ZluWJut/Y5XVSn/jOUId8ZYuI3/hgi+uS0zvpV8rkEFHZvl
 Old2F6o2uolHmzIcoFvZvdpeg7uSXOZCbxo4LAc7bImyaNFMPxsMF5d+xAetc35FREDNgrtVD
 mqp9UVoHCvhiKi75Q+MtwWV9yblaHYqYbVdVy93fzYbvZC2rxIi/b2aAHMYbu1VKDdL/J7dIz
 gWSEa+1NJZKVAx8FV78cFP61CIrZ9hgatXf+lMUb1PNwgFP4FhVvV6EUijo3WeBPn0kxzj3pi
 qdBlUbLiob03lBkloAdbBIDxxQ+t0WgUHHYMs/6TSvybjHfgsPjJ92JRGWznWMyWc8ZbGQplg
 pOIIaKzpa5FgiLz0CcSOvPpI1Ca6emuorgpyP4gKnqa34iZzME6SjmzH3i9+O25kDBBK23rT4
 o9lC0o0GPX33TV9T8xvmUAul0v34rTrumZhaXmyWq0AiBrrQW9Uck2MjGCGPw757C9YuTF0PH
 +oRiFgEW2GsC4yegn07/c9Vkt/mk+DBsmSY1+T3McPvOtALW9jZ5+4GrpaTMsPMnTRauLhy7e
 ocxX/MOIFM4MOh3U2ErWcb6nI+v1AA7jOdzv0KQilRwszYhBuUYEXUb09pPArPsjCkwqrpqKa
 u3OQApCndnxOVdkr9oZWRsKYQ/+Y8B4NFsuwOR2MXFRW6nWaIB+nGJUL3UUSmWC7GUvcyrmrn
 XnXR4qjL5+0/kgmR3u7/xR606lPDFPPdXdXesDkBmfucgbOKDwW1ohi8FeqnFCmUCeOvDzxVN
 f9HC6cHo8yOddLAaTiwkBDcYKWRuqlVzkperIcqh42DSG9gvVEPco4eNObuDxf6X9tXTfrvEl
 x1SvF/RUIw4HvdU2v/fith8qXuN4t2Kn5BNY7tI5K6RyRyRq0pH4pFpvkJzsGOmj45t0jdYTQ
 RptgARRm+qBSpuxYI6Ao1STeBlSm46KbAy97J23cmAOJ9fvhE+sAIj3L2HhGk741P0rjY3PL2
 WIlWSWN1fyd+Pf+PWe7rCo5y4S+1/ljG0XDLcmIVGpuiCVlqafWfnoBSXad6skRf4HATEcRTz
 i0Bv1Och8dcAKkmRkOHIzzBKqHw46a9md/F3xHPIM17qlA6XRNHSNLMO5YIDZoEK2hGKNqY/J
 NChWkylpJg9+NA8mtdWlfFcmrXnmZpfGULpUfGL+dMKWRfxDYNN6xPHBY7vFfiHNcfLxY/1y3
 sjsE5AL7xao4rIyCgK2G6F1F0KKY=



=E5=9C=A8 2025/4/14 13:53, Zorro Lang =E5=86=99=E9=81=93:
> On Mon, Apr 14, 2025 at 10:05:21AM +0930, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/4/13 22:23, Zorro Lang =E5=86=99=E9=81=93:
>>> Hi,
>>>
>>> Recently I ran fstests on aarch64 with btrfs (default options), then I=
 the test
>>> was always blocked on generic/619:
>>>     FSTYP         -- btrfs
>>>     PLATFORM      -- Linux/aarch64 nvidia-grace-hopper-02 6.15.0-rc1+ =
#1 SMP PREEMPT_DYNAMIC Sun Apr 13 01:44:03 EDT 2025
>>
>> Mind to provide the kernel config? Especially the page size.
>>
>> I guess since you're running on nvidia SoCs, they are pushing 64K page =
size
>> already.
>>
>> At least on my aarch64 (our for-next branch, based on v6.14-rc7), I did=
n't
>> hit any hang here.
>> Neither any hang in my older runs on aarch64.
>>
>> And my test is done with 64K page size and default mkfs options (4K fs =
block
>> size, 16K node size).
>
> Hi Qu,
>
> Thanks for looking into it. Although aarch64 supports 64k page size, but=
 my
> test kernel was built with CONFIG_ARM64_4K_PAGES=3Dy, so
>    # getconf PAGE_SIZE
>    4096
>    #blockdev --getsz --getss --getpbsz /dev/sda6
>    20971520
>    512
>    512
>

Now this means it's no different than x86_64, at least for the page size.

> The whole config file is large, I paste it at the end of this email (hop=
e it's
> not out of the size limitation:)

I'll try to reproduce it on aarch64 with 4K page size.

Meanwhile if you can reproduce it, the early "sysrq-w" call traces will
definitely help us a lot.

BTW, you can use attachment instead of pasting all the config into the mai=
l.

Thanks,
Qu


