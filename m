Return-Path: <linux-btrfs+bounces-9672-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C28FB9C9323
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 21:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FA61F2323A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 20:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAAE1AAE39;
	Thu, 14 Nov 2024 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="G5dCojic"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692D148827
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615638; cv=none; b=Z6IwnurZvBqEmrIa3D8Bqti7itMyEbQ/ppu4UIbFvhfdkWE5G3aBLNSrwhTizYdmP/0NzXv1dYfGTld3HOrow+MgYJ38RixsozIjtEsVeJL7v4IhN1eq7hEFeXGaOyLaVFtMnad7yFpYFOGrRLH7sBhLmMwn24ejayfSNs0Easc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615638; c=relaxed/simple;
	bh=I2ExtPSrJc4Aho5lY8KEjcmiV/Vp+nbOauASEqtK0Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ODhWe7nXMPDhfpVx/4RJhsF+6TbSCA8VYc6NYG8brBMpS0+acaaRgUzvBtrlHUWrx8t3q62x9XQ9+9lb4yxyTMBW/nEWSg6jUjAfr83fWExtJj5dT6cUrRVjFdxN0rvoV9+bBkzx39eAjwnM4CSO5kd4wegIAgf4OIE8NIZmilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=G5dCojic; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731615633; x=1732220433; i=quwenruo.btrfs@gmx.com;
	bh=I2ExtPSrJc4Aho5lY8KEjcmiV/Vp+nbOauASEqtK0Y8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=G5dCojicml3L35mf1F14Cb+d0IpZBx7zO43KLQt4rwSiezB4q697xlUbd5CnQ1FG
	 Amk1xNQlaaWtIigmXFcS99sPLCo531GLbpn+PbvTfOcv2svBXOESiuD8my6ou83Dm
	 +PLP0khiAZ5u0u2vReU4hWIKwnZ3748F4uwImrF1od4f31nCaICJHN4acRdYiwgua
	 OPo4CKXXM81tKjZGuAPKdAbw2cpwmoTalta278UzwuQ2wNGvHwFTZffeJflZVW1gS
	 RdQmwuEA3AaZyutuOjclILefKlQVXLIARPIW+z/aJZThACCFwtPoV/7ZGl4S8mw3B
	 FleU+D/3fQzloFuKCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MA7GM-1t4YX50zXu-009f7k; Thu, 14
 Nov 2024 21:20:33 +0100
Message-ID: <931d4609-6ad9-4232-a930-4c6866434a10@gmx.com>
Date: Fri, 15 Nov 2024 06:50:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs scrub results in kernel oops does not proceed and cannot be
 canceled
To: Sergio Callegari <sergio.callegari@gmail.com>, linux-btrfs@vger.kernel.org
References: <e4e79b2b-ebca-4ca2-a028-084a6dfcb3e8@gmail.com>
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
In-Reply-To: <e4e79b2b-ebca-4ca2-a028-084a6dfcb3e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:af0eOx6snp6mzm9JAPLUVIJoWgoQEWNG4CfVYi5o08NUZ68Hy1c
 qP7oFUKpPYjMp0qxQUTrKPL6GeIMbFSDXp2Vry6iaFTE47Z4xR65/ZTeOzGmUIDOwH1gXkc
 tlr9chQwzup+Z3ZaXafdQV4yTXUSYP2JwHa/lRmU49SqPoBwuaw52eWb4bsavpGCr5Pb5+W
 6xrvsmPJDGhxMa2QKsI2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u+DLhm5ZqNE=;mmeydH7nkdOzRnashidBf8E0Uno
 JPIuiY1CQEFjm2QdVKCPxHYpgcXDZMVwiYFHZ7eA1eX72sKT23ke0d4nxef+KDCT0LvffkFvf
 P2PQsbCDj63Er0zhZmgr24PrmMT3cknZxTVeqYk+gfoox5m3bNjoXOWH0Td2oBefSrwqW+Mfr
 3v1EbLQxuv4LB74yqL1dx9NoVH2sux4Qok8pmAptaDC0iVt922bLNIL32UgGxU0D84X5GgsCE
 a0/dQP+YxZCphW20czbbvz/s719HWJJKVWzfeTFyLFtK8oDFxZkzzwivJQpO4Eh8Sf31zLG0z
 h7sVDCCavPT+js7lnj0Z3V2asA9X5RkQwhtDHmIitJxtuPKvwy5XuVKiZWmKgTB/iNPNyiO8I
 AnWRiohvmUpleEF+5B1l6Z/XAGTADf/LaJkaKO94VdJJZL5xYYtI568ZjnpklDzIWVj1xkF7w
 ag+NHWBWQiFB4vs9AuakOyHHXwjZs/bsgmiwsG4aa5hDIaPIEl1ZJBCL25TcAXhy12Zd6i8Xd
 +Ikic9zHAyxIetjH2sMgPvaY1TqFuiC4dq6pc76dXTTWAuyVbNNjV2hyXTaOtBLQTLjL2H7Av
 +o/uhi3OKykn8PntSo8Mos8scfc6fT+0D0WghGw9QHsIMGsc9BSN++WNxo9Mt77aAurSabbFG
 tzplVww9pRBRrQrhvGvpXRF4SIev1uo3Wi0vYS0eX4KO08rWn4WwvKtGxJDkUp7kVQyAJZfhA
 tfTt16oi3iAlsTGR1PILXuye0G6VxfdbY3VeI9LCRAa+Sd+TKez6C1RCLd6cdC7qj2d4r0W8m
 +/6kXc+BqVrI1XaCu5hsBKk4XV2TA1rrn+EM7Yintly2SgT9m6r9LGy7op6e32zyWjAcHoV11
 uBcVKMY1vRe1FVj4P3qlaOZyYnnn6vRBYkf3MY2BIw4qQerfXh/QlqCBz



=E5=9C=A8 2024/11/15 04:08, Sergio Callegari =E5=86=99=E9=81=93:
> Hi,
>
> yesterday my laptop (kernel 6.10.13) froze coming out of hibernation.

Not sure why but hibernation/suspension doesn't see btrfs friendly.

> After that it will not boot anymore, saying that the root (that is on
> btrfs) cannot be mounted. I am dropped to an emergency shell and if I
> try to manually mount from there, I get level verify errors.
>
> Tried to boot a live iso (with kernel 6.11.5) and to see what might be
> going on.
>
> Managed to mount with -o rescue=3Dibadroots,ro getting transid errors.
>
> - As soon as I start the scrub the kernel oopses.

Dmesg please, for the regular mount (without rescue options) and the
scrub oops (with rescue options).

And I'm guess it's an extent/csum tree corruption, that caused some
btrfs_root_node() failure.

This patch should solve it:

https://lore.kernel.org/linux-btrfs/20241025045553.2012160-1-lizhi.xu@wind=
river.com/

> - The scrub does not seem to progress (calling it with status).
> - The scrub cannot be canceled.
>
> The kernel oops appears scary. Even if my filesystem is corrupted the
> way in which these tools break rather than erroring out in a nicer way
> is not very helpful.
>
> The plain btrfs check report a level error on one root and I think I do
> not have backup roots.
>
> - is there a way to find out if the problem affects all subvolumes or a
> single one?

So far it looks like the corruption is in extent or csum tree.
Not something you can easily fix.

> - is there a way to find out what can be trusted attempting a data
> recovery with the mount based on -o rescue=3Dibadroots,ro?

Just ibadroots will still verify datacsum when possible, unless the
whole csum tree is corrupted.

>
> Is there any way to find out if my nvme (the hardware device) can be
> trusted to be used again (namely if the problem originated from the
> hardware of from an error in the kernel)? The fact that the problem
> appeared when using hibernation makes me thing that maybe the nvme is
> not at fault and that it was something else.

Yes, I do not think it's the driver.
When hibernation and suspension is involved, things can get tricky.
(From ACPI bugs to btrfs bugs)

Thus my personal experience is, just do not utilize them.

Thanks,
Qu
>
> Any clue on what could be tried on my side? Why does the kernel end up
> in an oops?
>
> Thanks,
>
> Sergio
>
>


