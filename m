Return-Path: <linux-btrfs+bounces-19043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D84C625D6
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 06:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0023F3ACA13
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 05:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C48530C600;
	Mon, 17 Nov 2025 05:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qTyF+d+V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CE158857;
	Mon, 17 Nov 2025 05:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763356242; cv=none; b=Zhw9M+MhDOrNsEkbA/7WqSrIwvxjDQHqYEP40CEgwFDji8n4ncpHRT/jtimQHM0HAIeqlxqqN7YMxuDbJpoEs+ZnG6wqi9H1L5FI6opJQlNvfXYMmo3GtcjQ5fE0OvolYeTKO6GuA7uhS1wY9aqxZT6Zd0rrrnArilKyW8xc98k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763356242; c=relaxed/simple;
	bh=wlbm2sMkFRipZCOhI695RC5wQwTZhVklFK6hU1Bu/58=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CosqJ4pV/WeXgbcW2sRPQsy1lG7bC9IotZhXVnc8+mbn/mf6GwWs+HXNTWjF5klK0v0I/xfvuQAcc5Qb1L3UiE5srEcSlhOa9SYp80bSCquEqo44dKKf5iNrgkMtQl5csMQrbEQtgk2f6TfZtjdaS/F/0/XJyc8qlTllETc992w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qTyF+d+V; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763356238; x=1763961038; i=quwenruo.btrfs@gmx.com;
	bh=wlbm2sMkFRipZCOhI695RC5wQwTZhVklFK6hU1Bu/58=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qTyF+d+VfYBQn/JaZYvGL4LYAKmyn4lW5ikDtryeMmrMWnLm3hObUdrcU7SoKgJp
	 1LvOBSt+foVIgXzETNsBP/SDOqotfvDd+QuiaGiRuANwUWTd6ChkDRz+CtyzGNuEQ
	 mC/AJi/zKiviqch1W3Kt6no6r2+h9L5qDLzGf1/NlthTcpWU/KPg+BA1ZVnfWYlej
	 rSC1BhpWYx4D42Ew0zfc0HHsm/VKPxYRJcjMwrWKwjb/4Icp21VVtLngqCx5z5+hs
	 APIxah26Q9svGX10/VkJzXYPy+aKdg0AMsJ3miN2fZ46vpljbMdmbB7cEI6SbrsPN
	 b8vdgQwQjZOHujo8jw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mg6Zq-1vnsKu07lW-00ZI62; Mon, 17
 Nov 2025 06:10:38 +0100
Message-ID: <9cd36c00-b2e0-4d57-94b1-840b084d0a3b@gmx.com>
Date: Mon, 17 Nov 2025 15:40:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Objtool segfault inside an VM, based on commit 24172e0d7990
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: LKML <linux-kernel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <0b7d3e02-0609-410e-a221-8e68a0bd89b0@gmx.com>
 <cfc6e0f7-8924-4276-b29c-a6a72ebf2300@gmx.com>
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
In-Reply-To: <cfc6e0f7-8924-4276-b29c-a6a72ebf2300@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ilLV57AhZYd2PRkhmQX+/RXWJnNnAYGtE63fR4W8lkOQVOyvOWK
 crisHkRRLv7D+rZJwSZYuyJjnHfyj/Ppi/Dp8wdT/Cf2y0I0Yl/d5D4hV1vYnGEs5DM/KFu
 ZQSFahQRENiLYXf6mYTRKq0ebR2WS0cjsaYppgmu1+GFBH2E+DPwXHBIpEMbsl3s0v/dPDC
 9u+a5dbjKsAXerYPZeEBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wRwSGcjy9dI=;FP7AJQj7FQn6KrHyOvuj4/QlGwq
 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



=E5=9C=A8 2025/11/17 13:33, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/11/17 13:10, Qu Wenruo =E5=86=99=E9=81=93:
>> Hi,
>>
>> Recently I'm hitting pretty frequent objtool crashes, sometimes during=
=20
>> module linking (btrfs in my case) sometimes during the vmlinux linking.
>>
>> Unfortunately I don't have a coredump for it.
>>
>> The only info so far is from dmesg (and obvious the compile failure):
>>
>> [=C2=A0 625.066787] traps: objtool[46220] general protection fault=20
>> ip:563ab54c6eb0 sp:7ffd9c2ba7c8 error:0 in=20
>> objtool[19eb0,563ab54b2000+1f000]
>>
>> The involved VM has the following spec:
>>
>> - Kernel branch
>> =C2=A0=C2=A0 Btrfs' development branch.
>>
>> =C2=A0=C2=A0 The base commit is 24172e0d79900908cf5ebf366600616d29c9b41=
7, around
>> =C2=A0=C2=A0 v6.18-rc6.

Furthermore, if just compiling on old kernels (in my case, 6.17.8), I=20
haven't yet hit a linking time segfault.

So it's something in the v6.18 release cycle.

Not sure if it's the recent Zen5 related hassles.

Thanks,
Qu

>>
>> - 10 vCPU, host CPU features pass-through, x86_64
>> =C2=A0=C2=A0 Host is using AMD HX370.
>>
>> =C2=A0=C2=A0 Haven't yet hit the segfault on aarch64.
>>
>> - 8G vRAM
>> =C2=A0=C2=A0 Thus it should be enough for most cases.
>>
>> - Toolchain versions:
>> =C2=A0=C2=A0 gcc 15.2.1+r301+gf24307422d1d-1
>> =C2=A0=C2=A0 binutils 2.45.1-1
>>
>> =C2=A0=C2=A0 All from the latest Archlinux.
>>
>> =C2=A0=C2=A0 Older gcc (15.2.1+r22+gc4e96a094636-1) and binutils=20
>> (2.45+r29+g2b2e51a31ec7-1) are causing the same segfault.
>>
>> =C2=A0=C2=A0 Haven't yet tried LLVM.
>=20
> Unfortunately LLVM is hitting the same crash.
> I'm using llvm/clang/lld 21.1.5.
>=20
> So it doesn't look like a toolchain specific bug, but something specific=
=20
> to objtool of the kernel.
>=20
>=20
> Thanks,
> Qu
>=20
>>
>> - Kernel config
>> =C2=A0=C2=A0 Attached.
>>
>> =C2=A0=C2=A0 Sometimes tweaking the config can workaround the bug a lit=
tle,
>> =C2=A0=C2=A0 but not reliably.
>>
>> Is this a known problem and can I work around the segfault?
>>
>> Thanks,
>> Qu
>=20
>=20


