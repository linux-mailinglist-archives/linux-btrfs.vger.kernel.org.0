Return-Path: <linux-btrfs+bounces-17050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83078B8FBFD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 11:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E6118A194C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 09:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A84284B33;
	Mon, 22 Sep 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sEDOCkEn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99ED12C544
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533274; cv=none; b=SoVuSpKepV1Uhpjte1ujrbgJ+D/yZnw5I/JicdxOiuNN62f42EsR6IJLVFVPikRS9j0FrtwN8NADooEMQ7A6YzH983qUn3fm6GA9fE8aK/jg0CpTB+lzq/ZN75NRVWzUPJby1P+SX3Por13eO8t/G7JcQYiasAudvzpKp3lOD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533274; c=relaxed/simple;
	bh=VYunXhhb3Oscp24zUnLM9K1XCg4N3x12nuuZgd9xWK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DFbyAHYd2vOsFMEUIiMLu+oa293CZSvvGpKSGHeiBu5u8BI4KS+CMux3Z6BxGJcTYFxDILmF26clEX5E159x04kzfKFmeE71ALtCaMCs9R0uI6QwQrTdQIDLK5x8fZw1Uy9K5Zm0PvpsXyCDmNL4LREFrDWjko1GK51aoV7kkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sEDOCkEn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1758533269; x=1759138069; i=quwenruo.btrfs@gmx.com;
	bh=VYunXhhb3Oscp24zUnLM9K1XCg4N3x12nuuZgd9xWK4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sEDOCkEnfAJW2gi527i5VvF4yPLE2oDF1J8kHwqgz8/ssNDU2oji9yST+RcixPLU
	 Q3GtbPJnuqEau6q/Pb79hjtnIXwtT2xt7a1gT97ZOPTuBKOoFnLngy232BQomR/Ub
	 CaTD6fXCTlZSsnHocW6lk0+Ows+WEayUQXwL7r+SrWvGyI+jSiVZ3ow42/A35yLuw
	 oz0bVD1ycGny5e3AO7MeQS+XDxsRMSAfRsUpGlE5tq6X7RLUV0y8GwaXtEB8APJdq
	 gXW6PTidJnIgnp/P+i/3l0qEQB/yJA/QO8qaGeuMGVn5pC+E/8vIarkDMlVBkFYOq
	 hs4OMl22KV6LKNHlUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N17YY-1uLcoJ1TlS-0122e6 for
 <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 11:27:49 +0200
Message-ID: <1e4baff2-1310-437a-be62-5e9b72784a54@gmx.com>
Date: Mon, 22 Sep 2025 18:57:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <20250922082854.GD2624931@tik.uni-stuttgart.de>
 <95ece5d8-0e5a-4db9-8603-c819980c3a3b@suse.com>
 <20250922092300.GA2634184@tik.uni-stuttgart.de>
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
In-Reply-To: <20250922092300.GA2634184@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gn9o0qaGQnL1juLDDAGl9k8tH1Zs8LqgQ/6CommfWKaVGvXpCob
 gYBKNn3qlnvEqOiaPApnW/5i5w+oKJTsL27KZUCBiWcxB5mWX67bwQb/OG1P+raAElgPhGf
 FR3d7spd7w1ssiwrb37z5bKqmnUmjXfap7s6cvl9KH9v3m64w9N5pSpywxoGxPGKe7CjWQe
 7/29uLB2Q5v/B6murenEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FWMDYa6ee38=;P7Iz0fT+IFXKNPrfPDUut847Oie
 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
 OrudjUHhmah4ts88Ra5vcwEY/h8A6npkgrXAL



=E5=9C=A8 2025/9/22 18:53, Ulli Horlacher =E5=86=99=E9=81=93:
> On Mon 2025-09-22 (18:36), Qu Wenruo wrote:
>=20
>=20
>> Write-hole means during a partial stripe update, a power loss happened,
>> the parity may be out-of-sync.
>>
>> This means that stripe will not get the full protection of RAID5.
>>
>> E.g. after that power loss one device is lost, then btrfs may not be
>> able to rebuild the correct data.
>=20
> It must happens both, power loss and one device is lost?
> Then this is a more rare situation: unlikly, but not impossible.
>=20
>=20
>>>> So you either run RAID5 for data only
>>>
>>> This is a mkfs.btrfs option?
>>> Shall I use "mkfs.btrfs -m dup" or "mkfs.btrfs -m raid1"?
>>
>> For RAID5, RAID1 is preferred for data.
>=20
> Then the real usable capacity of this volume is only the half?

No, metadata is really a small part of the fs.

The majority of usable space really depends on the data profile.

If you use RAID1 metadata + RAID5 data, I believe only less than 10% of=20
real space is used on RAID1, the remaining is still RAID5.

Unless you put tons of small files (smaller than 2K), then those files=20
will be inlined into metadata and takes a lot of space...

Thanks,
Qu

> With 4 x 4 TB disks I get 2 TB, in opposite to 3 TB with RAID5 data?
>=20
>=20
>>>> and ran full scrub after every unexpected power loss (slow, and no
>>>> further writes until scrub is done, which is further maintanance burd=
en).
>>>
>>> Ubuntu has (like most Linux distributions) systemd.
>>> How can I detect a previous power loss and force full scrub on booting=
?
>>
>> Not sure. You may dig into systemd docs to find that out.
>=20
> So, no recommandition from you. Difficult situation :-}
>=20
>=20
>>>> Or just don't use RAID5 at all.
>>>
>>> You suggest btrfs RAID0?
>>
>> I'd suggest RAID10. But that means you're "wasting" half of your capaci=
ty.
>=20
> Ok, it is a trade off...
>=20
>=20


