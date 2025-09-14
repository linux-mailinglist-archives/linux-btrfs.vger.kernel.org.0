Return-Path: <linux-btrfs+bounces-16808-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2F0B56C97
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Sep 2025 23:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF503A632E
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Sep 2025 21:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71A4242D66;
	Sun, 14 Sep 2025 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JNhawGPt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D99217722
	for <linux-btrfs@vger.kernel.org>; Sun, 14 Sep 2025 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757885590; cv=none; b=OwwI2RjzG4c6/z308/YZUWqxON2txrFBMSgPh15h/0GUuT82J0rs8tHsD6O7Dvz0uGEaCmw/ZjJjUXbGvcjhBS1K7/EHUXU7YKNHrwOgZ5kIsi++845MENAlvkmv0Ifto7REd4HGRvkjW1ihDUn6yoO/b15NCJ5MKdAAiYdLX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757885590; c=relaxed/simple;
	bh=bQrkvGCT7ejPWUMMU4FSBo+UbrAJ9WMDaI6vJJrD72w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=b15QsmmeuN/Fe1Sbm6zw9bybe9bQyOQEjH1B9DuZB/N3511GoFBU7uf+DpZQTN+dgtC0Xhkn2aIR5drFtEkdlixHJUZiGHoUo9TbAFnHKQBkHlujAMtY2oVeYIVsSHrlu5IwSKtV/gkR4Z3od0beEGc8B8oVqkxO2xYDDQHpQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JNhawGPt; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1757885584; x=1758490384; i=quwenruo.btrfs@gmx.com;
	bh=bQrkvGCT7ejPWUMMU4FSBo+UbrAJ9WMDaI6vJJrD72w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JNhawGPtmprZFcGW9c+8FYU98havjM9WMK9k0tM82MJcoRUAqEML6I85+oPHEr8G
	 y+UitAK/ra6IMwHat2a3vH9CWkkN+WCGiOUSEsKJVSoqNUJ81t52Tt7qjPKepTuXA
	 FH/rcdSplsL3LBTP71v+Cb7GJawGTX7nY4Wk5Yf7DTPBwvePeDNAzgXWgLBXqhdI/
	 IqFT9xXs7PrTcloYJGJHm/vvDiNEvIskDgG3KMitOOBr50kr0q/e3yFy71gDCB9un
	 DCqHaO4S3hFopvHnHoJEu9am93/HmYZZ0FoV0lzlhD4UEsivriXDIvXBYgpcYWzm4
	 T5XxCPUQayxMhstgkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2O2Q-1uySqM0qoY-002jg5; Sun, 14
 Sep 2025 23:33:04 +0200
Message-ID: <45131321-5ed8-4abe-9edb-19b1936e83b4@gmx.com>
Date: Mon, 15 Sep 2025 07:03:01 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SSD overheating during scrub in laptop
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Martin Steigerwald <martin@lichtvoll.de>,
 BTRFS <linux-btrfs@vger.kernel.org>
References: <1938311.tdWV9SEqCh@lichtvoll.de>
 <44330134-4c22-4fea-9a14-84c78daecdb5@gmx.com>
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
In-Reply-To: <44330134-4c22-4fea-9a14-84c78daecdb5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lq3HchY0HrETxZhfCRjWY6IR+hftaT0GldcNhfHUmX3c3xlOkJk
 h+snmO+6+OHoWW6usCHExPad8Of+eA8wNG4O5s+2op4GEiaujJrmXEgBksPDINTqpiEOLWU
 P/WvxbT1eTEupwmTRA8cR26dhNEqot1II5OxPKmS6gO6F9LS+KlkP+ux9yiv9B471K4ikc1
 HXrjWw5iOk9DVselmneQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gpMsl3t2shw=;r74RpXJvRDZoHupWAMn0/9HP0bs
 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



=E5=9C=A8 2025/9/15 06:58, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/9/14 21:27, Martin Steigerwald =E5=86=99=E9=81=93:
>> Hi!
>>
>> Just to share an experience and ask whether others have experienced thi=
s.
>>
>> Already during summer it happened, that the Samsung 990 Pro 4 TB SSD in
>> this ThinkPad T14 AMD Gen 5 said goodbye during scrubbing a 2 TB BTRFS
>> filesystem with almost 2 TB of data in big files running at about 3,5 t=
o
>> 4,2 GiB/s. I concluded this being due to excessive heat.
>>
>> However it still succeeded with the 500 GiB /home with about 300-350 Gi=
B
>> of data in it back then. I worked around it, by scrubbing two minutes,
>> then canceling, waiting to cool down, resuming for two minutes until th=
e
>> 7-9 minutes of scrubbing were complete. I tried to work around with
>> lowered speed, but even then the temperature slowly rose till the SSD=
=20
>> said
>> goodbye. I think I went down to 1 GiB/s of speed maximum, maybe even=20
>> below
>> that. But then the scrubbing takes longer so more time for SSD to heat=
=20
>> up.
>> However=E2=80=A6 I would have thought it would not heat that much with =
a slower
>> speed. Maybe it would have worked with 50 or 100 MiB/s. But this takes
>> long.
>>
>> Now I had these SSD goodbyes during regular use in times of heavy I/O a=
nd
>> in the end it could not even scrub that /home partition anymore in one=
=20
>> go.
>> Linux hung and only way to recover was to forcefully power off the=20
>> laptop.
>=20
> Can you setup netconsole and catch the dying message?
>=20
> I doubt if it's really the drive dying.
>=20
>=20
>>
>> I opened the laptop and removed dust with high pressure air can while
>> holding the fan still so it would not generate current. And with disabl=
ed
>> laptop battery.
>>
>> This fixed the SSDs goodbye issue and I could even scrub that 2 TiB
>> filesystem again. However, according to sensors command it still had=20
>> about
>> 80,8 =C2=B0C composite temperature and even 100,8 =C2=B0C for sensor 2 =
for the NVME
>> SSD at "nvme-pci-0300" shortly before the end of the scrub, with critic=
al
>> for composite at 84,8 =C2=B0C, but no critical set for sensor 2. That i=
s still
>> quite high. Granted, it took about 7-8 minutes of scrubbing at 3,5 to 4=
,2
>> GiB/s in one go for it to heat up like this. But on the other hand it i=
s
>> not summer anymore and room is not as hot as in summer.
>=20
> I have hit similar situation, but the symptom is very different, the=20
> death come silently at boot, the drive is no longer recognized by the=20
> BIOS thus no longer bootable, and Linux kernel from liveUSB will not=20
> recognize it either.
>=20
> That's why I'm asking if it's really dying caused by the heat.
>=20
>=20
>>
>> Anyone had similar experiences?
>>
>> My solution to this will be to remove the dust inside laptop about ever=
y
>> half year. However=E2=80=A6 I was a bit surprised that the NVME SSD wou=
ld not
>> throttle itself before saying goodbye. Or maybe it tried and it was not
>> enough or to late? The laptop is a bit less than 15 months old. So I
>> conclude that it takes less than a year for the cooling system to becom=
e
>> quite a bit less effective due to dust. Good old ThinkPad T520 took way
>> longer for that. But it is way larger on the other hand with more=20
>> space to
>> distribute heat.
>=20
> You can refer to man page of btrfs-scrub, it provides the way to limit=
=20
> the bandwidth of scrub using cgroup or even the btrfs sysfs interface.

And I forgot my physical solution, with a thick thermal pad, you can=20
connect the NVME to the back plate of the laptop to dissipate heat.

If there is enough space (I doubt for laptop though), you can add some=20
thin heatsink for the drive.

It works fine for one of my laptop, and the drive keeps a healthy=20
temperature since then.

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>>
>> I bet it is out of scope for btrfs scrub command to monitor NVME SSD
>> temperature and pause when to high. And I conclude the NVME layer of th=
e
>> kernel is not throttling to hot NVME flash either.
>>
>> I checked my data filesystems, two BTRFS and one BCacheFS by scrubbing=
=20
>> and
>> fsck'ing without changing anything. They are okay.
>>
>> Best,
>=20
>=20


