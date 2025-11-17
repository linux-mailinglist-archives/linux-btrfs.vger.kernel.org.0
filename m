Return-Path: <linux-btrfs+bounces-19042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5DC6235F
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 04:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8FFC362D71
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 03:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95302749EA;
	Mon, 17 Nov 2025 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SQfHue1L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C9189BB0;
	Mon, 17 Nov 2025 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763348621; cv=none; b=suBUcg+yjSQBssGWQzbSTctGJ/rURd1r/yv2uiYil0Q5kIR8atvgfO4hWi4Zm17bFDoSvkr3wSavL3GYQchs1H+MegdcuMC6cihWOfiBNad3QqqiVph1BrvCAbUscJ2UuhjWg5/G36Vmm37HuB1sVgnXrF7j9EMNZyopv29K7Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763348621; c=relaxed/simple;
	bh=ZFt0RHcpjKtTEmO18X7eHKILMNUPleid3hD2qaxe2+g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ON9suYlX69DC0stPlOw+zQjkXt976AJAVIj88q3zynCEzWI5z/tf9/j5cDFjrl/W7PV7zgaySQqo7kW37pv0DRF7FRYcwnqBWEsuOkH2nT8egnPLoD6ErnQuxS/Ai7T7u2kGcA0d9wzsrzxoa2FOIAjKT7U1z/fE6UzbYi1SBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SQfHue1L; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763348616; x=1763953416; i=quwenruo.btrfs@gmx.com;
	bh=3HXK9Uu2Bztym7HnNXxpS6+rEagrOOcxmKcze7lmRgg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SQfHue1LUwb95lFD7k4ayZq84C4fD75nnpaT4KxOXjGKWHpjKfiELVJnImx1gkeR
	 Z08GdNx/KP8u5gbVRZ2T/sYtu38R88GTi3gjBmIi+wKpOmY+8+qWKTy0r3ApeRNEm
	 erdfxzsQyrT9hrab6oCN4zCXRU7ASK66XzBhC8cWRY9bRfVIM0rLa54sPE3iszi+P
	 M/Ry0C7B0Xxn+d8w77ox8aj+chUNwqx4raS+RwywhOBdSiDHaVgyWs2C7of4OWtl3
	 h1RbAn283zQBX2X98Thg3+DI4egrMCdeQeShJqvbUhkWFuTfHukFXjr0BJDBxWRnC
	 JXwblX/H3XfY3AQWmA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqb1c-1vyJ5b3qvg-00ee5M; Mon, 17
 Nov 2025 04:03:36 +0100
Message-ID: <cfc6e0f7-8924-4276-b29c-a6a72ebf2300@gmx.com>
Date: Mon, 17 Nov 2025 13:33:33 +1030
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
In-Reply-To: <0b7d3e02-0609-410e-a221-8e68a0bd89b0@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GcBS4nGSjk5Y0zOuW0O9BlPlAwnLWsEH+LbDOfqRZYLeIiRmxhs
 G1BOYuW0SysC7SY4Sx5Vtgw8/LJYFE0DW9gDNhAYuErBUYn9ulHa5gczsMXKE8oZQH51jCq
 kd4Khz13w9tJCHXIFtkpxPrO5TZucSZn0n0TpdTOsjB4+sMf4aKSeP4l8ziCln/8U/fR9f7
 hwNIxPV+9LZmlkHAeRriA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U0uBOcLw43E=;1OycRAm8ily3x5S2was4Bl2oN5w
 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



=E5=9C=A8 2025/11/17 13:10, Qu Wenruo =E5=86=99=E9=81=93:
> Hi,
>=20
> Recently I'm hitting pretty frequent objtool crashes, sometimes during=
=20
> module linking (btrfs in my case) sometimes during the vmlinux linking.
>=20
> Unfortunately I don't have a coredump for it.
>=20
> The only info so far is from dmesg (and obvious the compile failure):
>=20
> [=C2=A0 625.066787] traps: objtool[46220] general protection fault=20
> ip:563ab54c6eb0 sp:7ffd9c2ba7c8 error:0 in=20
> objtool[19eb0,563ab54b2000+1f000]
>=20
> The involved VM has the following spec:
>=20
> - Kernel branch
>  =C2=A0 Btrfs' development branch.
>=20
>  =C2=A0 The base commit is 24172e0d79900908cf5ebf366600616d29c9b417, aro=
und
>  =C2=A0 v6.18-rc6.
>=20
> - 10 vCPU, host CPU features pass-through, x86_64
>  =C2=A0 Host is using AMD HX370.
>=20
>  =C2=A0 Haven't yet hit the segfault on aarch64.
>=20
> - 8G vRAM
>  =C2=A0 Thus it should be enough for most cases.
>=20
> - Toolchain versions:
>  =C2=A0 gcc 15.2.1+r301+gf24307422d1d-1
>  =C2=A0 binutils 2.45.1-1
>=20
>  =C2=A0 All from the latest Archlinux.
>=20
>  =C2=A0 Older gcc (15.2.1+r22+gc4e96a094636-1) and binutils=20
> (2.45+r29+g2b2e51a31ec7-1) are causing the same segfault.
>=20
>  =C2=A0 Haven't yet tried LLVM.

Unfortunately LLVM is hitting the same crash.
I'm using llvm/clang/lld 21.1.5.

So it doesn't look like a toolchain specific bug, but something specific=
=20
to objtool of the kernel.


Thanks,
Qu

>=20
> - Kernel config
>  =C2=A0 Attached.
>=20
>  =C2=A0 Sometimes tweaking the config can workaround the bug a little,
>  =C2=A0 but not reliably.
>=20
> Is this a known problem and can I work around the segfault?
>=20
> Thanks,
> Qu


