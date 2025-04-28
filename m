Return-Path: <linux-btrfs+bounces-13472-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F6EA9FAC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 22:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816A71A83DA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFCE1E766F;
	Mon, 28 Apr 2025 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hz7sGYA8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337D81DEFE9
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745873413; cv=none; b=f6MJeVc1Uoa92kUK8BhULiDWDatV/9EOUnUsJ/5QbWGBxGsIXpl+v2+ArON+LoDfwnSTEP9z2Cyu7t3IviU3MecCq+oa3O4Y1cSpNgge09lu/JKRBR7W+sHUrxNmHw1dyWDUKR440CV5nVNhRd15BhlIF8Yc1mlIJR0yCz3Dezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745873413; c=relaxed/simple;
	bh=NTgZC+2mqt3SsWPLii/w2PRvVh8y4vrWGWvKAq2A+fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DalnMg422abptPIV40sTMnHNLjLJ8vhCoBqPP1TTNglWzfkQ6KhBHpbGE9SQjmTyVPiW3+o5gOCGvUBhnnsNK79HZEgFglalMIDC0clKn+07YIkX185mgw1H8k2rdesHnIVLOCNyf0zt3frPzlp0YGwB4m6pSY1ED4dJ/G5EaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hz7sGYA8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745873408; x=1746478208; i=quwenruo.btrfs@gmx.com;
	bh=QO+7rOAoPg3Qemln3t73udTgcVFdnAT+L9m+/hJ1kY4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hz7sGYA8Zx6zwtfhNspwkcmUJ5Oi5DMyu953fuQsM2CjP/RGnUkTa50YjfJR9/+5
	 JaIXzHx0208SR0l/53bGCc9o93umSSTasOgBLW3ZZTQJX6wgTCgs7ruxHZO6HU6EQ
	 2AOTmGyJjpbSbJV4coOLTy4Z49lpqKTRu6drxVR8Cg4wuWnub40va1Sb/k1siqhAL
	 6sJDQM+9zAMHjKgwM3r6stQ2k2xkHcFJGoOX4+9bZtnDSzfyO69d5OO4npTbGuiRz
	 J+LL0utt/s/8zvbC/d6CXMq1kCb1O/BOkOh684l9qZThMawuG33a4PceSMZSGwAIT
	 87NplbFftFTAo7oWUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1uyS5J3Fdm-00wFqe; Mon, 28
 Apr 2025 22:50:08 +0200
Message-ID: <1ff78ee1-c647-4ab6-a285-37e464d872fe@gmx.com>
Date: Tue, 29 Apr 2025 06:19:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bad tree block start, how to repair
To: "Massimo B." <massimo.b@gmx.net>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <180daac980bec43d45d0e6fa4f9e1d14fb126de1.camel@gmx.net>
 <bb9b6bd4-6638-4139-8ccc-dc677f85e3a2@gmx.com>
 <579ce87edd7ac4ea92196ef7368331239d036717.camel@gmx.net>
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
In-Reply-To: <579ce87edd7ac4ea92196ef7368331239d036717.camel@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gPTqci8auq1sC7a54CFsxNh51jWYZzHicwk76QqBBjl0akZlE0a
 cEpp7CAI9qoyjwswB6ocZOEm+EcXqbsHxCGxxi9ure8cDfdco6dzBj8tyo7/GYtqNWH0vka
 7XCk2LCkEGs0GqZFApoPY5enPYWFDcUdGnZP5V7fy7HVAZzopjF5prLjKHag6hIt6u4Z+dO
 hNGMl7TSH2c0Ngrn+aZYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s8gmu4Pbfrg=;YzD4sZG5FOKRoGapqmm9QHQXoax
 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



=E5=9C=A8 2025/4/29 05:21, Massimo B. =E5=86=99=E9=81=93:
> On Sat, 2025-04-26 at 19:38 +0930, Qu Wenruo wrote:
>> It looks like only free space tree is corrupted.
>>
>> At least you can grab all your data using "resuce=3Dall,ro" mount optio=
n.
>>
>> Unfortunately I'm not aware of tools that can drop a corrupted free
>> space tree (the existing tools all requires a working free space tree t=
o
>> drop free space tree...).
>=20
> Ok, I preferred to have rescue=3Dnologreplay:ignorebadroots:ignoresuperf=
lags for
> not ignoring checksum failures.
> But I failed to mount like this and got
>   Bad value for 'rescue'.
>=20
> I need to do it like this:
>=20
> #=C2=A0mount -v -o ro,rescue=3Dnologreplay,rescue=3Dignorebadroots,rescu=
e=3Dignoresuperflags,subvol=3D/ /dev/mapper/mobiledata_crypt /mnt/usb/mobi=
ledata/
>=20
> Is that a bug? Kernel is 6.12.16-gentoo-dist

Dmesg please.

>=20
> I'm transferring all snapshots via btrbk archive now, that's working wel=
l so far.
>=20
> How would checksum failures look like?

Dmesg warning and the read fails with -EIO.

Thanks,
Qu

> Just a warning in syslog from [kernel] BTRFS ?
>=20
> Best regards,
> Massimo


