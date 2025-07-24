Return-Path: <linux-btrfs+bounces-15662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D218AB113AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 00:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04475541146
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 22:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912FC23B612;
	Thu, 24 Jul 2025 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kGCZIHcd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727972376F2
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Jul 2025 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395250; cv=none; b=P/hXzgzjA82SS7eJkbHShT/VSUZ9qAlWnpOzO3M58bozlKra/0f6S1K17vheA/aaPzyheFS9rSnqEhV2Tam1ZmoR7wBcgKONeOnrIuExvGbt3C+KjapC8x1n0+fV78nxoBbqS8NUnO3wSEplWGYkb28Gd3Q1qMoFD/lZD7erJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395250; c=relaxed/simple;
	bh=FX9A9C7Jqvcrkick66yJY1mib0HIYvP2UVuMVKrcxb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCyojpNvgUTWzg+mMCT3p6x305bAV8bnW6Y4eg8nO4sN0mxVbocGY/lSjE/Q5EP3dmn7pFB78BOntOVjDh1WsHQAHX1ulfsO6O7+im0kvE7rNemzGtrT6P27xe1F+ZyLHF7D2ERfltV5eRWiteiunMVsNmwxOI8Wg5eueuIQ4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kGCZIHcd; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1753395246; x=1754000046; i=quwenruo.btrfs@gmx.com;
	bh=FX9A9C7Jqvcrkick66yJY1mib0HIYvP2UVuMVKrcxb4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kGCZIHcdBGZfxNpZsGsU6C5Xq27cy3h1wK35YzVxkCevKAqUWOwndI7e/q+lvnfy
	 lsWLJoiouFSiyyYpdJvWsGDMSkJx8hP8Zae1NIyeh59Bwimh8ytUUCi3Q+xx5G1Jx
	 l5TJ6WRO0F2NV/i2Dbg1AlfO0kwPapaS/YE27SdUz3lDyiXYAyQCnGojuPoiGdClX
	 wulNyA5vk8x5+/nq4+U58iCpjzWVEK51RaXCJCGNeOQfF1lgHKLvzOXwvNJrcPCeW
	 EpScRjpYXdkYLLG6nGor6s+vT4BymeEofA/bxNsGu0B531CzaOaQBzX/xbtUvcYv1
	 eKbT4UPYbGoVz+zb0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGRp-1v4hpQ2JPJ-00HlA7; Fri, 25
 Jul 2025 00:14:06 +0200
Message-ID: <3c2368c7-5d4e-40a1-8b32-74797272e9d9@gmx.com>
Date: Fri, 25 Jul 2025 07:44:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Null deref during attempted replay of corrupt TREE_LOG in newer
 kernel
To: Russell Haley <yumpusamongus@gmail.com>
Cc: fdmanana@suse.com, linux-btrfs@vger.kernel.org
References: <598ecc75-eb80-41b3-83c2-f2317fbb9864@gmail.com>
 <c781524c-dbb4-4f0b-947f-e781952b4c4f@gmx.com>
 <bc687d88-003b-4979-96d9-847dc63f77a7@gmail.com>
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
In-Reply-To: <bc687d88-003b-4979-96d9-847dc63f77a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hhPSItLyRR2wDSYvrcK10FjE0JPVMHgRj4Guwm1xr/mU44Ie2VN
 ifKMUSL4XCLJlT2RI/xr5V566eaK0/wVVkiP2Zasie5ZFWkSwOKPkc+8UfyE+p1t13krS90
 AHr6m5THO1qpe+GkbA/LVWNkx2qhZYJRIKa1NYWYs0RH0tYbLnmQ+Li1COAirCgcFxPKKp2
 PnDixE1qauNSRZOWa2MAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RoXywYP81+c=;yp59YgxkG/AHZQptcQyCHzEDl3e
 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



=E5=9C=A8 2025/7/25 06:11, Russell Haley =E5=86=99=E9=81=93:
> On 7/24/25 12:10 AM, Qu Wenruo wrote:
>=20
>> Hope you still have the fs at hand.
>=20
> I do, but I didn't image it, and it's been in active use for the last
> week. I've dumped what you suggested while running kernel 6.15.5.

In active use means all the important log trees are already gone.

>=20
>> In that case, I believe the following dump would help Filipe to pin dow=
n
>> the problem:
>>
>> # btrfs ins dump-tree -b 202645028864 --follow <device>
>> # btrfs ins dump-tree -b 202650877952 --follow <device>
>=20
> These begin with
>=20
>> leaf 202645028864 items 358 free space 329 generation 460240 owner CSUM=
_TREE
>=20
> and
>=20
>> leaf 202650877952 items 130 free space 6143 generation 460240 owner EXT=
ENT_TREE
>=20
> Owner not being LOG_TREE means those blocks have been reused and the
> evidence is gone? Attached just in case it's still useful, but I suspect
> not.
>=20
>> # btrfs ins dump-tree -t 256 <device>
>> # btrfs ins dump-tree -t 258 <device>
>=20
> These are quite large. The first is 17 MB and the second is 1.9 GB. Not
> attached, due to size and likelihood of being useless.
>=20
> I'm not going to start fipping the power switch to corrupt my disk
> intentionally, but if it happens again, I'll collect these dumps in the
> immediate aftermath. I assume you formed those commands from the
> ROOT_ITEM and bytenr in the -t TREE_LOG dump.

Yes. If possible please dump them if you hit it again.

Thanks,
Qu

>=20
>> Log tree replay is a very complex mechanism, it records changes into th=
e
>> log tree (dumped by the first two commands).
>> And replaying the log means we need to use the difference (the log tree=
)
>> to update the target subvolumes (dumped by the last two commands).
>>
>> Problems in either tree can cause replay failure, thus you need to dump
>> both the log trees (not only the log tree root, but the real log tree
>> for each subvolume) and the source subvolumes.
>=20
> It seems like there are two issues at play here. I posted to the list
> because the 6.15 kernel handled replay failure ungracefully, leaving the
> block device in an uninteractable state.
>=20
> Until I saw the other threads about a spike in log tree corruption
> reports, I had assumed the corruption itself was caused by hardware
> misbehaving during uncontrolled mains voltage brownout.
>=20
> Thanks,
>=20
> Russell


