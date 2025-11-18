Return-Path: <linux-btrfs+bounces-19114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF1FC6BB09
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 22:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A74353643DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6909630CD87;
	Tue, 18 Nov 2025 21:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Bw7bdMl+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B31DF261
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500258; cv=none; b=EhxPAvMmTu9ULlMHblV35pJr8fMjQTQhRnzQ1XjwYxl2Y8R4vnp+64ADBcfX0QfF8WuZdds9AQWxt1sxt54PKRWMy0ULgPGVQT4QcrC+w/qTewCm0aBMW42lEBFRUFIUXgU65Vzsjyg9gI9arGihtPh/T6GbVLOKQ9AYtNFP61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500258; c=relaxed/simple;
	bh=6hAdysOeWPNTK1WY3c5BocGCMTYCtIIbg9Nkrb1rQzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKoi750Xb4TF0qOGUdm+bBMbvKFY1iF0vbGMzABHbwUR+0q64PWnhUeW+uvkaXPdZmTiXNZF+nHPZpSe9SjCYmcz8lWwGTAZFn9Z2YVCYZwU/MT3md+qsEia7Bipofcq1ehHRnQP/OPBOGPAtPAA+H2hpUyJ1W12X1wLfRNPhN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Bw7bdMl+; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763500254; x=1764105054; i=quwenruo.btrfs@gmx.com;
	bh=6hAdysOeWPNTK1WY3c5BocGCMTYCtIIbg9Nkrb1rQzs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Bw7bdMl+7Ul8IMkophXe+MDJ4pEe5dXQykxwHE5yvzFbNpKzsj9TBfRMEGWqXagn
	 BqzRceZOHblFvxzI4Fh4kJ/Q7A+zB1+d02GtxBCvlhZ2YSaNqxqZJ62gyjgpu+/gS
	 ZoaKiTbk1OWmx8yV/Cr4JwchJJv6W0EsNSBm24H0y+RHjuJgHd996yThU4AzCSP8B
	 SfO0/eqRjWDFBYXmr7/8jFxlL5PYXkEo2ClseosAV7A4pZesD3KM4mZ8l2Lr0mMKb
	 r5luHhOlubR+zRzwty0ow9SJPu5tR6KWXuvhIdtzchPtBztWanJI7CG4agVeCcXC0
	 ZDsbrYsSu38eFY0FGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mq2nK-1vzSd52bsQ-00e7vi; Tue, 18
 Nov 2025 22:10:54 +0100
Message-ID: <d381f2e2-ee08-4055-b91e-e1e0362d18d6@gmx.com>
Date: Wed, 19 Nov 2025 07:40:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] btrfs: add raid56 support for bs > ps cases
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1763361991.git.wqu@suse.com>
 <20251118151533.GX13846@twin.jikos.cz>
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
In-Reply-To: <20251118151533.GX13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U8I/CHetWCfnLA3LPb9RIXnUZhJ22lWQdxoywXHNz51ZURZ1sYo
 TkwF2GV9ZJ5tn5+c5kHQll1Ul9Iz8RtVCLCneoEdCBdaE7t9Eeytf/VO5AfruUNkM08Kk9o
 82FIffrk9dy7E9dCZjCaOY5AXj/eoXH9n9KLqKPrJdxYd064t5lohVdp4vHvQd2xG3VoQ0H
 OnyTTFw7DxASuWZvAcjBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zb787d/16aE=;z5+fXBHdesEp0tQdeOZny7+bQ6g
 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
 PAANNG66MM28zWP0g=



=E5=9C=A8 2025/11/19 01:45, David Sterba =E5=86=99=E9=81=93:
[...]
>>
>> The long term plan is to test bs=3D4k ps=3D4k, bs=3D4k ps=3D64k, bs=3D8=
k ps=3D4k
>> cases only.
>=20
> Yes the number of combinations increases, I'd recommend to test those
> that make sense. The idea is to match what could on one side exist as a
> native combination and could be used on another host where it would have
> to be emulated by the bs>ps code. E.g. 16K page and sectorsize on ARM
> and then used on x86_64. The other size to consider is 64K, e.g. on
> powerpc.
>=20
> In your list the bs=3D8K and ps=3D4K exercises the code but the only har=
ware
> taht may still be in use (I know of) and has 8K pages is SPARC. I'd
> rather pick numbers that still have some contemporary hardware relevance=
.

The bs > ps support has a hidden problem, a much higher chance of memory=
=20
allocation failure for page cache, thus can lead to false alerts.

E.g. ps =3D 4k bs =3D 64k, the order is 4, beyond the costly order 3, thus=
=20
it can fail without retry.

Maybe that can help us exposing more bugs, but for now I'm sticking to=20
the safest tests without extra -ENOMEM possibilities.

It can be expanded to 16K (order 2) and be more realistic though.


Although bs > ps support will be utilized for possible RAIDZ like=20
profiles to solve RAID56 write-holes problems, in that case bs > ps=20
support may see more widely usage, and we may get more adventurous users=
=20
to help testing.

Thanks,
Qu
>=20
>> [PATCHSET LAYOUT]
>> Patch 1 introduces an overview of how btrfs_raid_bio structure
>> works.
>> Patch 2~10 starts converting t he existing infrastructures to use the
>> new step based paddr pointers.
>> Patch 11 enables RAID56 for bs > ps cases, which is still an
>> experimental feature.
>> The last patch removes the "_step" infix which is used as a temporary
>> naming during the work.
>>
>> [ROADMAP FOR BS > PS SUPPORT]
>> The remaining feature not yet implemented for bs > ps cases is direct
>> IO. The needed patch in iomap is submitted through VFS/iomap tree, and
>> the btrfs part is a very tiny patch, will be submitted during v6.19
>> cycle.
>=20
> Sounds good.
>=20


