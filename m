Return-Path: <linux-btrfs+bounces-2726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2B58627E1
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 22:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CE91C20DD6
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 21:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A344A4D13B;
	Sat, 24 Feb 2024 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JdEBRwdx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610B4C615
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708811569; cv=none; b=dTOuPXnjGZ0unZh8pQJhq3fGjP2j/Zs4wWBR+m/kPqfKs3+liSNmIp5NfHnMN3sg7OtycKyBlRmkn78yPMltu6suURgGJni1m+yX6jX7JGCUoKin3YoSBCsNgAkTFWULps8cX+/1BGvwCZR7hKzQTPgmxQfsBxMxeuG4fCHjuAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708811569; c=relaxed/simple;
	bh=/A73o+36/B1x0Yft0uXk4XC37bffamZKRD6uNHPZ0xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tlb4s8pCBGUCMyp1tggM2XfrWlNB/wyMZD071/9fSCBcqIlOhfoxSy1FKvt+WMt6XwZ+f5N2m08BRSoW2vGPLj1ah498K7GuaM7K+Dbx75UyUAOzrou/co6V0KewcV2ReyJno4kYt2/ZE8kr6X+tNrob8ORArhzVXJr8cEJQye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JdEBRwdx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708811562; x=1709416362; i=quwenruo.btrfs@gmx.com;
	bh=/A73o+36/B1x0Yft0uXk4XC37bffamZKRD6uNHPZ0xQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=JdEBRwdxbqDOdTreMgyNTLs/ONm7fbfaBCcJ8KiZQhQjiAAtxtrXgIOYz69NNpup
	 htm5PDSkbmVsmeP6E+wScrw9Y6iRehkQ1GKQu5WYo1/29OS5y/sLPuR4Vmzjh1HBq
	 N8AdgYfxVtKsH2sHeNnQL2W1pxe+Rmu96t4g6ldGK0bObAbw2wyXT0z+Xn0HI6A2d
	 e62KAWJB82EXRt3zfx2dqViEAQ21IAkHDgb23jFrWZ1JmNdm2i/mvD5LgNvFC1Hsg
	 r4w/72+nZ4D/gsItjGqGSToPWQXSiDcTbyZoCgpg1NRFFEsOzu/XgFG/uBrwV29rS
	 UR1oHSaMK15R6ahY7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M1ps8-1rbo5R2NVw-002FJu; Sat, 24
 Feb 2024 22:52:42 +0100
Message-ID: <e88f9520-1d10-4d66-94fa-3ee86c515118@gmx.com>
Date: Sun, 25 Feb 2024 08:22:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Super blocks checksum error on HM-SMR device
Content-Language: en-US
To: WA AM <waautomata@gmail.com>, linux-btrfs@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, naohiro.aota@wdc.com
References: <CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com>
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
In-Reply-To: <CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EHNPKoZIvCG1+dF6Z7wUsxMPIr3s/8EM7YeL6PNLqd36PNNEJ1Z
 r9W1cuuSbOsDJQYpZ6vk+dP42Nov+3VPSPatiaam0YaqlLrGmmmqo25VkFJ1xSTTdyUdWWn
 pmy5o0+XAGOuBcWNC5FTKpw7ZkJls36KKrn9kUShGYINR9cXlYQ8FUIE7JLsaB3o7vJvNpn
 iK4VN5H42/Vq1FZ6HxxDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p7P4zKK+7gs=;SS4QU5WGor6FNp0lEi4Z++ODJoS
 5M6issddznIb0TZMR18ImoDUgZ5wtEEElXHYqqAJoegaW9J0xLkqhrAsKMJ/1slKgLbF+nQWa
 cUHoZpYxX9lDwksShgwHZMC088UAw5i6z//xxKv934VHJrUkEAP/BFwj0Nyc53pKQuJhmiwhi
 A26x62Izb57rsfidcKNIMsQVsEl2FehZjihLaCx2TWAk5ARRpYAhl7aqtHID6ackf72Y+qUXi
 TagAXyVS3bzWw09d9+WfMyyaBIKDJw9RUA9tjgUF6PJ2jtrOSFdkXETJqC4M7KSelhC+Ak3UH
 wQid9ObqynRLWsHLnJ1sUB2FwQLDocjmvWXVzZMvRHy3Tw0B5pydcJruQ5iN6rpubb1z1NH7j
 0EaimGauTjtQEnZBsRlxCGYBObIzXTsaghcYwzUW6mfkLJ5nF4YoNfHJNhfiFB5+WOXt8nOR1
 cvbBNRLaLRcVHSroP9Di6APhfeeuDHmdf0vhSTBYZ25KlhepcQy+Jk4ydckJRiCYhY8EvP2gX
 wtKnA8LKwKtfb7XpIQilo6ZRIPhZ1P28Gn/+YtjBOVid013JMtTipuGYgFYOL3kyEX8pNm5pF
 ShACIcYr+yRjOrxEOVAaYHrwPAvTu2sDhbQu3i/4RFi1gXTCa6ZdmNgQmYE+jOmpue8HAzA4C
 oOPFvUdpsxrdb17PPZ3y5TE+hpS87rWnpN+idQFrGgWXoE2V7iky5DSxHT1Kr1a7t8f4mFId/
 XYmLdwNfrBzEoA6LpFmeE971iowYa1Yb0YLvbi47auY9FHTY64XPIPzs0HkZHnzQCbruKWqT3
 N8cWT208mGB7K14zMPucQr437GqBZtIqm883PEgn5rBiE=



=E5=9C=A8 2024/2/24 22:46, WA AM =E5=86=99=E9=81=93:
> Greetings,
>
> I have a Western Digital Ultrastar DC HC620 (Hs14), a HM-SMR device.
> It is formatted to zoned BTRFS by `mkfs.btrfs`
> `btrfs scrub` reports the following errors:
>
> Scrub started:    Sat Feb 24 15:42:38 2024
> Status:           finished
> Duration:         0:09:34
> Total to scrub:   76.64GiB
> Rate:             136.72MiB/s
> Error summary:    super=3D2
>   Corrected:      0
>   Uncorrectable:  0
>   Unverified:     0
>
> [Sat Feb 24 15:42:38 2024] BTRFS info (device sdb): scrub: started on de=
vid 1
> [Sat Feb 24 15:42:38 2024] BTRFS error (device sdb): super block at
> physical 65536 devid 1 has bad csum
> [Sat Feb 24 15:42:38 2024] BTRFS error (device sdb): super block at
> physical 67108864 devid 1 has bad csum
> [Sat Feb 24 15:52:12 2024] BTRFS info (device sdb): scrub: finished on
> devid 1 with status: 0
>
>
> What went wrong with the super blocks?

I believe it's a false alert.

As for zoned devices btrfs no longer puts super blocks at fixed physical
locations, but I'm not an expert on zoned detailed.

@Johannes and @naohiro, mind to check the situation?

Thanks,
Qu

> Thanks.
>
> My environment:
> $ uname -r
> 6.6.18-1-lts
> $ btrfs --version
> btrfs-progs v6.7.1
>

