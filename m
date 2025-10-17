Return-Path: <linux-btrfs+bounces-17923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530E3BE7544
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 11:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577DD626DEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C42D4B4B;
	Fri, 17 Oct 2025 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OcOtS70t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E672C029E
	for <linux-btrfs@vger.kernel.org>; Fri, 17 Oct 2025 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691509; cv=none; b=dPgO2Mg1nCJDcYw4EJf6fTCkL4YHYh6AzGsFRL5N7BU5NKmIHdc4lnqrv+t5yel4Aumm0wNI2YAYFSOQv/pqyG1sOEMu8hVJerXI9qfqdt4I6M/HLtLXkPviBALJo6VvqmrhV5tKKgsar0+veE+7hBeIxSYvJF6Pm10pM3vlpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691509; c=relaxed/simple;
	bh=oXQKO3A20s9LG0SV3aJG9Rb5bk+7zId3V28nZ5uuGCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qd98Q36Y7GSZ1pO5Coi9KLNmpYS15CHpZyHZNsvF6ITQljPcY2HtE1g7v84vup06Y0GWpuSTJvssNrr5ef2JeMKDg6PJ+Jz7HUJZjLfHUgOtGM7EanJqm3t4RF/vw3AYrgZKEEEuGPXj0IRy8vXv3SKTedu1MTzMwntx8L3wV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OcOtS70t; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760691502; x=1761296302; i=quwenruo.btrfs@gmx.com;
	bh=oXQKO3A20s9LG0SV3aJG9Rb5bk+7zId3V28nZ5uuGCQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OcOtS70tKr3rHanueQAw82slE1CDs+HIZlRgX4pI02HbddNWKkTRuUDpVM8cyMhA
	 aNHgAGqmkeCsgwePwRL6oohw3mTHYg4MG55Jn8Qq+Bxc01xPVreCFXGeyKtcKN2We
	 NXuO2q9IXV9FalyrbMwFy+MjfJLicLkqJA/wy5Ef938tzMmdIPW+XyLBAl1l+06Hj
	 HIMIThEYWkLb1LOYPGpmswgTIlWdLkfl4H7wuydrEaRXGI1h9IS0L2ywYN8W3MWOE
	 hBFbr6IMBdxmm08DjVsqQPrYuX9ucHM+2N9Z+c8CKqW0alxOFYXrS/VZGgfKEfRpG
	 1SJqEZcB1+5ZKGCHEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOiHf-1uqnas2JPL-00QcOa; Fri, 17
 Oct 2025 10:58:22 +0200
Message-ID: <f85f81cc-bfbf-49c7-8cec-d9e46f263c6e@gmx.com>
Date: Fri, 17 Oct 2025 19:28:18 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Any proper way to prevent system from power management
 suspension/hibernation?
To: Christian Heusel <christian@heusel.eu>
Cc: systemd-devel@lists.freedesktop.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <32690b57-86ac-49bd-b913-b080aab03b42@gmx.com>
 <2e47f358-69d7-43b2-985f-c2484be9469b@heusel.eu>
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
In-Reply-To: <2e47f358-69d7-43b2-985f-c2484be9469b@heusel.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GXL17Tay87BTy3K8cWjZc1tT6Wa+mS2NFYXkV1/OnUcy5DNN1W2
 NJZZOm5yGfmwWCWQe5ub5ZdkpMyazo/khaUFOpSZMAeQfzG0SLR0vtMuyjG0CW8IOKVEmnx
 PTx2SITyAkAUx31ELJuXvPIliwHBew/KKiVyVfwfinTJMDBz7MvsajswQLtlDeRm+8sw31R
 IHU3aM+VMU4B2X4rYlMVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gmfcDx2cTUE=;uwuPYDpEAg+VGDWHrgfnjRueeMT
 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



=E5=9C=A8 2025/10/17 19:11, Christian Heusel =E5=86=99=E9=81=93:
> On 25/10/17 03:08PM, Qu Wenruo wrote:
>> Hi,
>=20
> Hey Qu,
>=20
>> Recently I'm fixing a bug in btrfs scrub/replace where long running
>> scrub/dev-replace ioctl will prevent systems from suspension/hibernatio=
n.
>>
>> With that fixed, btrfs scrub/dev-replace will abort the current run if =
the
>> filesystem or the process is being frozen, thus allowing pm to freeze t=
he fs
>> then the process.
>>
>>
>> However this exposed another problem, now PM suspension/hibernation wil=
l
>> always interrupt scrub/dev-replace runs, and it's not that easy to resu=
me
>> from the last handled bytes.
>>
>> I'm wonder if there is any generic solution to prevent power management=
 from
>> entering suspension/hibernation (using systmed), and is generic enough =
to
>> handle not only pure systemd, but also various GUI environments (like
>> KDE/GNOME).
>=20
> I think this could be a good fit for [systemd-inhibit][0][1] which could=
 be
> used to wrap the relevant command in the systemd unit.

Thanks a lot!

That's exactly what we need for the systemd service files.

Although pulling in the full systemd dependency for btrfs-progs may be a=
=20
little overkilled, for btrfsmaintance service files it's definitely more=
=20
than enough.

Thanks you very much for this awesome hint,
Qu
>=20
>> If there is such solution, we can provide different systemd services fi=
les
>> to end users, and they can choose what version they want, either gives =
pm
>> the priority and accept scrub/dev-replace can be interrupted, or preven=
t pm
>> actions in the first place (no attempt to even suspend, thus no extra
>> timeout).
>>
>> Thanks,
>> Qu
>=20
> Cheers,
> Chris
>=20
> [0]: https://www.freedesktop.org/software/systemd/man/latest/systemd-inh=
ibit.html
> [1]: https://systemd.io/INHIBITOR_LOCKS/


