Return-Path: <linux-btrfs+bounces-7349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710089590BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 00:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA38285524
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 22:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD471C823F;
	Tue, 20 Aug 2024 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="r25VS0wG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACD1C8221
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194527; cv=none; b=i5svpKpQlfamaXJNw4/xVi2ye5V7AzxrP0I015BV9pPXiCrqfC/jKae+QqgwxijlEyiYdYSIpU90h5l6b+zgJ9feizvJE4/vxL+8nk3542lxVaaKoRBHGK9lSitzXuxvt0wYPplzLA/OvU2JTHLBx3Ho5uxVZCWnNcm09FNdhNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194527; c=relaxed/simple;
	bh=xeLlTrAUZY5NmDHNQWJx3O2ToNlLI/PqPEDRw2UAsnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M9zjv/aP5Xpfdc1iEL3pK9SGUWNwZpSXhogdax2XMW+DT+nBeqgy0AMqWNoxiXpQEKUUQGEXPYrURqKqZPiHcQW3CbhZJdu2PhhOxNCZR5am+mZrWY1pR2fJ0ShO7WEYny+fTkqgLoOe7Yb2hy2mdGR/UOCc2fkgUj1ZmywnbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=r25VS0wG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724194520; x=1724799320; i=quwenruo.btrfs@gmx.com;
	bh=xeLlTrAUZY5NmDHNQWJx3O2ToNlLI/PqPEDRw2UAsnA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r25VS0wGncdD6WIWnxUiBt5amTKRarUxT02JIlOh5TAexBgO3E/cXjY6CKsiMcU1
	 ZXAUdW2rolW3XGqsx66I6ujBMtxWWxB1wDokhkEBgzijUFxVGnIcBP/ghwE4ezXmv
	 eqzfGEI2h1Mr9JC5i9iS16wHOEqHhVuOwsy2mYsqtYdSn094mrHQisyBcW+GCYZxC
	 NimoEyVR/tMhqTSro0RBX1qGskD/4RTUx7se7PBrl1mV6tBJbhZ9ILeomNsM43iIW
	 Gwb6MXFd8j+yRfea01kGUmxPWbV7gP4nIpo6RVDGoriqsVKZJjr7X0eNjijU1IpQM
	 8lDp+TCHKuNOoJOYVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbRjt-1s9OrZ0Qfp-00ZLjs; Wed, 21
 Aug 2024 00:55:20 +0200
Message-ID: <a60d90ae-a8df-492b-adaa-35fc8724ff83@gmx.com>
Date: Wed, 21 Aug 2024 08:25:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree (single bit flipped)
To: Pieter P <pieter.p.dev@outlook.com>, linux-btrfs@vger.kernel.org
References: <AS8P250MB0886A81B469CD5F707144EA38F852@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
 <AS8P250MB0886FC6ADE47901FBD009A6D8F8D2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <AS8P250MB0886FC6ADE47901FBD009A6D8F8D2@AS8P250MB0886.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4P9lbHZ2J9Yj4maIqzQ9ASQN39gystr5bwGfINUN9pI9JkIMuqR
 5/btIqjm8WUN+zb5IrJTIBaoHk0oZuY+FQ+fb/c8OVCsXrUOjxYhjfIK2pWhGhkzU+HyHo0
 UHKYD9rWsLS9y6UlqgZC1AcEuIRYQFLldwJ/AYba9hf7a3VumXk35qoKfTThmG4bAJ8DFtl
 dZa8Zg8JIkoDT9qD5rnCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H3mREW1QjsI=;8nNAFce+6J5975XO9dz6xL+JzS5
 4yKqTxvn4SERDPQm+hqEYftVhWNHOOwdqKsno7/CcAFBG7jNzfr1BvMG6DYVlkfwnrt3nm+ex
 Q7BzvRED6tRMVr3oQs8Q0dEOt+gWpnhcxnHnj+sbiOoiOKXKlVZ380XZX/IGsux5O9hQe4/yU
 UD4cCcPf8qVIbBR8yDl8vDeyal2w/CKQYlFUzHfsPRuSEIuAwUCj5GyobHDo0rQgE2mqxXuIk
 J9XDXcR+pkNlUQdk+EhJBHTFx28Om5oloieshSMGyc8XEFTWM0rqN6zU2OkxJH2ThPcvnxqf5
 szfkx0xfyHLjUOuTOmPKynqBaWV8Ja65KwEVoYU14tOX73Z2NGfDDzKD0F79hOMF6u8KmICX8
 AIf0L6HujV6+zKKStIdpR83ZTIA5DlcdhO/SmXV32Reybkk6bqf2yUT/WaQ4w9EFvPJkoX/NZ
 kznE8rBJUkME2jIfbvIgjiuGTI8ePDWmMuVGONiKgk5MwbHtGxpgNAgRdvbW5MFy3WQCOunPL
 tWUoZ8QgUlDhVRrlOrkjkvXLblfw3CcuHzVGwIlaGNC2BJjsjLaoK2196XJkNnCqUsNFcGjvE
 lQ8nIZ6cUidfPx6MpJn6MVs+iTkwzWpm7TW5RHaPGMpwGUIzg8wrxU1iyAKoYDE7IOAyihxvr
 Dbdyrx3J7aR0/VKRvbtrMp1TUMR5pX/61SJiDM3Kvz8xJV8PVgTuXGjuVyBakLtoGaTFEDGJQ
 xikBtrb+3JX8iQNwgOTs77Q+CNEZz6CYpYPBS2TlO7W9szk4Q7GWKCcvRPasyaM9LZ3HjeIxM
 KaFE2tm2blBLV484SMwZF33g==



=E5=9C=A8 2024/8/20 23:31, Pieter P =E5=86=99=E9=81=93:
> On 12/08/2024 16:57, Pieter P wrote:
>> Can this problem be fixed by running btrfs check --repair from a live
>> USB? (I'm using Ubuntu 22.04 with btrfs-progs v5.16.2).
>
> Turns out, the answer is no :(
> I tried this on (a copy of) a backup image of the corrupt file system,
> and btrfs check --repair simply failed in step [2/7].

The corruption is not in extent tree, but seemingly inside the subvolume
tree.

And in that case, "btrfs check --mode=3Dlowmem" output may help a little
more, and the same for "btrfs check --repair --mode=3Dlowmem".

>
> 1. What should my next move be? How can I fix my file system?

If above lowmem mode still doesn't work, I can craft a tool for your
specific corruption if really needed.

But that will need the dump of your subvolume 257 inode 50058751.


> 2. Or if that's not possible, how to figure out which files may be
> lost/corrupt when copying everything to a fresh btrfs partition?

Subvolume 257, inode 50058751.


> 3. When creating a new file system, can I somehow "clone" the subvolumes
> on my current file system (e.g. @ and @home, and the dozens of
> subvolumes created by Docker)?

Btrfs send should still be fine, except subvolume 257.

Thanks,
Qu

>
> Thanks,
> Pieter
>
>

