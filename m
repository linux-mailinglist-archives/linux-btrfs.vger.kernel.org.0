Return-Path: <linux-btrfs+bounces-19474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1796BC9D3FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 00:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8923834A718
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 23:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85304200C2;
	Tue,  2 Dec 2025 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="HNGgeLKu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117DAE555;
	Tue,  2 Dec 2025 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716421; cv=none; b=TrREm+w5AnlWYW7RHkUOmdUQ/SUgK67nD1jtquZn1DNt8YSpxobxvVfS/+tL+uAyoAsfG1ZR1GZ1h1fkYzS/LPpBd7uwI4Qmx8HfQXZms2G4BHdo++NgjRBtyxs8Nn0GtTKWZ9HhNx+HiXS7br6ivrHgpnfIkvm+BTqESjDY9fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716421; c=relaxed/simple;
	bh=uLQ79qfXiToHSw/KLhJO1U15ORfz05ux3TyIYajAAyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqYMkWCxQ/AKuzRITHo85xiGT0nmGrS6iyDTX0Da7tdeU7Bdo21OuiBM3wifi0jIRd25uGtDCuhrI76vMswRb2xO7VDi++jFhMuiJCZl1iisgIFqSCHEFhcl/6/w1rlajPZhkQ81gItZspAhpqW9KOBR4KHVCdS8qWbC2DDfY2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=HNGgeLKu; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764716403; x=1765321203; i=quwenruo.btrfs@gmx.com;
	bh=uLQ79qfXiToHSw/KLhJO1U15ORfz05ux3TyIYajAAyk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HNGgeLKuv98ZJ7ISzalGY0HjojvXqLs0NN6GGcnAksTYqFG/BqY/BqnfAmCdGI7m
	 6P0p86ly/Ih3xx4kmM9NXfSHPgehJSfGduhXmwJTVQKtnoyCxllNzm/YGt+LrOghY
	 BlG/JfJqq/sUQxxwAidJL6Ge6yUaCEWwwWWXGXhBSJYr49FYBLlL3TL3bW7OE/WSh
	 6m0VsjFAY38/nL4SJbCWcwFICQWDWzQuIIcI0Asf+t+c7CaJ5vcwoMRv83rPRYOdK
	 X0PsBY8gBQ7undRfc1BKr1I/J/o9f9c2aIlBow6+Nx4i1o5veJ6hpVac7J9bWW2v6
	 lv/MPm2vkxNl2hV8ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My36N-1wHi8L457v-01892r; Wed, 03
 Dec 2025 00:00:03 +0100
Message-ID: <789ad2e4-ce6f-40fe-8e56-9bbfdc86e29f@gmx.com>
Date: Wed, 3 Dec 2025 09:29:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: dsterba@suse.com, herbert@gondor.apana.org.au, Qu Wenruo <wqu@suse.com>,
 clm@fb.com, terrelln@fb.com, linux-btrfs@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com, cyan@meta.com,
 brian.will@intel.com, weigang.li@intel.com, senozhatsky@chromium.org
References: <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
 <c4f89df0-9373-4329-9e61-9b5592ddc2f2@gmx.com>
 <aS2nA8+YpNbKjXeo@gcabiddu-mobl.ger.corp.intel.com>
 <aS2v6g3f5nYi6hC+@gcabiddu-mobl.ger.corp.intel.com>
 <453951a9-0c8d-4e1a-be4f-2617c6a51fbe@gmx.com>
 <aS4UNIfxGK0y6HzO@gcabiddu-mobl.ger.corp.intel.com>
 <e532ff5c-a5a6-4ebf-977a-721471594908@gmx.com>
 <aS8dNt3gCzlIxBIs@gcabiddu-mobl.ger.corp.intel.com>
 <0bd22b17-97e8-4b8f-a7a5-5e79d280c078@gmx.com>
 <aS9qQwPeM6UVvcQ+@gcabiddu-mobl.ger.corp.intel.com>
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
In-Reply-To: <aS9qQwPeM6UVvcQ+@gcabiddu-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xh6MFSy+GAzDrrTV+BqpK4Rf/BGbB/TfP2bXX2kbJ52Csc2p8zn
 VD/QQ3dj7nVz00l+OMC2CEk+N9DDS8OnKSrpoGko7zrI+6yGteIrBDsOUIWum1UEtnBCcyp
 W2+e61Wog18evBOzwHkFKDI3dzMpHT8kILZUY5Ltl73wl+880O1n6kC7qi95cs6cBlTQbvo
 Mu/KTiCtOi+qUUgzn7e/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uBoj6SMxrCY=;xUG17OIkU9zt7PfKS5mEGgmFVOL
 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

[...]
>>> So there is nothing QAT specific here. The mechanism is generic.
>>
>> But only QAT requires this, a "generic" mechanism only for QAT.
> If this solution is adopted for other accelerators, they will need it as
> well.

Does this sound sane to you? Every future acomp user needs to implement=20
a removal? At least it doesn't sound sane to me.

>=20
> I tested sending traffic to another device that plugs into the acomp API
> (Intel IAA) and then tried removing the module while in-flight
> compression operations were ongoing. It was not possible to remove it
> (as expected!).

I know, but that doesn't mean it's the correct way to go.

You're pushing for a workaround of QAT into an acomp user, completely=20
breaking the layer separation.

If the current acomp layer can't handle this feature (dynamically=20
deliver to different implementation), then please add such feature to=20
acomp layer.

>=20
> IAA currently only implements deflate (not zlib-deflate), so it cannot
> be used for this specific case, but the same limitation applies. There
> are also other drivers in drivers/crypto, including non-Intel ones, that
> integrate with acomp for compression.
>=20
> So this is not QAT-specific. The problem exists for any accelerator usin=
g
> acomp when dynamic removal is required.

Then please give an example where such removal is needed in the existing=
=20
code.

I tried searching for those acomp users, but none of them seems to need=20
bother the removal of an implementation.

Again, if QAT requires a new ability (dynamic removal) from acomp, add=20
it into acomp not the acomp user.

Thanks,
Qu

>=20
> Thanks,
>=20


