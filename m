Return-Path: <linux-btrfs+bounces-12502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CF9A6CCC1
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 22:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514A917388B
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Mar 2025 21:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EDB1EF38A;
	Sat, 22 Mar 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="amEjkhC4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A241DE2DC
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Mar 2025 21:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742679425; cv=none; b=OiBhQtxaIWicOnhc87ZQG5ufOkDcxOj0dpYgdmIsi3wO+ao25E//NNqHGb7autnH6I4g11hL3DNKc4DEhyHBTBYO+qMs7yp7yMgXLt95+Ikjk5obzYo5Ls4RGxDCxyHvycBgMWFcBi54x7efpeGsAYSLZIS+SKiD8As23AQqNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742679425; c=relaxed/simple;
	bh=EKIy4vZO8pX4qUg6zB83WZ6HoxHDKquPAnCzSLW5U4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SBzizYVQJsym9kdHa3Wnvxl0qA+oAOfRO6t8221942OBCzxwTt4/VmpJYGibFFsQ/xZ2njM/TLU5/DKapXuVrlpRl/QOIib/E4tLR59q/gCqleD/P8+lUtu3fjdOgNDLc0bht5ii6uRyC21guLw8DYFvAook137drkRjVIzalDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=amEjkhC4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1742679420; x=1743284220; i=quwenruo.btrfs@gmx.com;
	bh=7egBh8mgRY8gbUZc/YX54UxEYMsIbiyNk3edx27XXOw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=amEjkhC443PG1B3+0b6i/E38zHtbAobFz9hQBj/nm5+EFbGnHLJok/FTi87HCNAN
	 XChENA98lVlQjRITo10Tbwt226V7FR7kjoQevTJL1PieOCgNRPU7Ns8Mtf+K6x8D5
	 aHuv9yESaFdd6LPpUsU7uoUA+zLizhQDlG2Gfsrp/seXi1OL1qOfjYBNtrSyfHv6A
	 bZ1UXQQq/ka7nctQ7mVEJRZIIXBtQQMky586fkTeWsFdtVYnbEyJozIUFqoqQm+Zr
	 0jFS0e7R5NC37m9vuQ7Nk5ceqVZXeC91i57GnflZrWrioSFGDHAfDhtO0/acGmh3B
	 Ium7dsXStb3owCjhFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1ps8-1tttb93kUa-00Gy6z; Sat, 22
 Mar 2025 22:37:00 +0100
Message-ID: <81b64f4f-59dc-4ca1-81de-2b77cf38cd3e@gmx.com>
Date: Sun, 23 Mar 2025 08:06:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS error count 754 after reboot on Debian kernel 6.12.17
To: russell@coker.com.au, linux-btrfs@vger.kernel.org
References: <3349404.aeNJFYEL58@xev>
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
In-Reply-To: <3349404.aeNJFYEL58@xev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7CDpluI/eAbFl0G7R3Yxm3BaFSvRpO+ZRUTD/oTxk9odafaXKdO
 tdig1tw0O/dgQkMe8bFd4OM02Jm7wOKHBm6aRggORiN7U4CZLMra8f5PlzzvKOHsk3ZsrzJ
 g3cI6630Xq4SGzW/tHOFDh0orsReuYz/pf0+Yg6AEZtruz56CeKckkpafb7f1ME4nA44Jlv
 QmpT9vnf4DLTmOfGmiBBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vSTKMj6Z37c=;9nGCBkenrwBQ0bat/00hf6Y8MAN
 l85dX40xJUMP+XY9KymhCf4+efgKICX7MW1TvZ/rX2r+lW/ztDHDA25o4nzTX5oxAx7Giplok
 Co8HMbX1gFew6XW/xWziB97gW2thgGKLPwxiJdmPD6UuSYoPjegOFtPZemzdMdLZSJBXyrfVd
 CNgCcnPDT4QpIwe/3QH5djxyERkL44EIagbxb1NB4nfvqYCcYuPngo+rdQ6L1lOFWnnXyzEBk
 PeD96CrBZEx/YtBZtstlWoqz5aqrljpBkPcWPpF0ooh/LXqiPhS0OhUaEdWFfiKDkkISTXf1j
 yF3T+77H8o1wW0eKCiooU0aEk1V2LO3Yqpf45xU+pD/BftyRqDr9l92Y6h+t6+6DeIJqEID9x
 5Se1gkotWr/9CXTLnvthzz6r4GsHuZjSZjWQYitYruEund8UHocKpsHzqf3LS64WI5q2vEWev
 euWC7imU4IXPoJ/NA4C9KAOxPZEcAiGzEetO3ErmDX5CLNwoN8gtSOyn8TFOx0yeOflQeKiYK
 lnyvpv1hpADN1eMjcTQBxQ+JcXxfJlNewMElIlo/Z/Nh1wDajKACjGBYe3KZE76DxDhSdoMeP
 UBSsuxE3Vdf4sb6Sy+484E0BNM4z1CSVhvWxYQCqyTg2ps5l+mtgu5ZcMl8gVsUb/B6dzHJ1j
 2D0jzeTTspIiwJLDaGBpS8BFxB8NpH/iPP1XiwMLEwdxLbXquXGwq2RHMMzPS1uqNUC6CErfG
 rf7GrPCsLHQRdMr/yfApOfjz3ItCCIQIo7knk1/diZRklVQneoER+rof44mZ50cng0+LynOsI
 wGB7zHlqI2q9HJJkKP+calPX/IPW8LETLmoYbNnGkR3e4mo8JfFWFALhliTZwTQfztovpu6Ts
 c7VFz4Z8X9hcbwGcFDHS5ADW9HpEhdPsCbDysmG72IE5R/HeP+SSE6kh2MjTaha6l41Z2U1Md
 Uj06G020aplpoFMSASpgOdkEgIHOES5s5XprV9qbaLEpIwGYgVQB+byMlWYwFGN/f/i1MF3IB
 aqLb1fEtccirDxwooPVMBf+tiduBAzhsB2f6LqjGJJ0VxceIpYdL4qSuPxrdQ5jl8zKu3tbmw
 4mYouEeVM+jAB/tGhGlOvZ3XnkgbjfaBso7VQBRwhG06rM0/y3Wz/kIOxOAExcg7ebNOGWwyG
 Lqeo+RifqgymK4NpiLfKBSsTNGcMoZW/zKOB/upPeryLc8Mfg0+59rPBcAPlULFomJJq5jeeZ
 Kg/Sl4EiDceYKarFRA6KS1s8enbFgacq065f0gLH7dfhjrJuoddLLWod8AHRQTNzG5FQVkbxt
 KRs2M/rM505qo0svFfw8zHqLziUZbD0u1mF9NagugVYtuOdwJO/TcbNmf5rkg0PUh4qB8MRVn
 PEiJ2RjHOK9GcenRcXUGEuyn/MmFNPKW1atcLgRMtLg8uhluIKyo8TQOFCRm6X8lJUy8bfV6i
 EsEbBlg==



=E5=9C=A8 2025/3/23 00:14, Russell Coker =E5=86=99=E9=81=93:
> [/dev/sdd1].write_io_errs    753
> [/dev/sdd1].read_io_errs     1
>
> I have a test system which has a strange problem where the BTRFS error c=
ount
> on one device (out of four) goes to 754 after a reboot.

Mind to provide the full dmesg just in case?

It's better to cover the initial device removal/add to be extra safe.

>
> There are no BTRFS errors in the kernel message log after booting up.  T=
here
> are no log entries in /var/log/kern.log about BTRFS issues.  When I look=
 at
> the console as it's shutting down I don't see any errors being logged, s=
o
> either there are no errors logged or there are 753 errors logged in the =
final
> split second before power off or reboot so that I don't even see them.
>
> This is repeatable and it's 754 every time.
>
> After I get the error I remove the device from the array and add it agai=
n.

How did you do the removal and add?

"btrfs device remove" then "btrfs device add"? Or just power the machine
down and physically add/remove the device?

In the later case it won't reset the internal error count inside btrfs.

>  I
> can run it for days without problem with data being written to that devi=
ce and
> read from it without error.
>
> But when I reboot it says 754 errors.  When I swapped that device with a=
nother
> one in a different drive bay the same device has errors and the other de=
vice
> doesn't.  So it's not related to the drive bay it's related to the SSD.

Again, how did you do the swap?

>
> The system is a Dell PowerEdge T630.
>
> The SSD could have a fault, but if so why does it only show up on reboot=
 and
> why 754 errors every time?
>
The error counters are stored inside the fs, it records all the history
errors a device hit in the past.

You need to inform btrfs by either proper btrfs device removal/add, or
make btrfs to zero the counters.

Thanks,
Qu

