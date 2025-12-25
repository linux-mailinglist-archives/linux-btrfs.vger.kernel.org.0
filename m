Return-Path: <linux-btrfs+bounces-20001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA2ECDE122
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 21:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 171D1300A35B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 20:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4948A1F541E;
	Thu, 25 Dec 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cL3TidH5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7331367;
	Thu, 25 Dec 2025 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766694035; cv=none; b=i47W5UJCDXXw1xbdYDLP2m4GBea8ghxZp21+Byc4F+8RlXaCtrDzOJ8qqbV+fL+X2Wnw9FjQh+oQvbWt2U0IVZ2X43dWxQzVCp7zw/pIiOUHZ2T9XqvHM9khbwzrYNFpVi2ZlMoMTZMh3aEfYcqL7XlSvTHYb6q+3/O+xXyEOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766694035; c=relaxed/simple;
	bh=LcG3W5iQF+rY78NyPY3MGcVjSBhKt1dfRrBXkv2Zv98=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QXAsQ2xZdE6kYgByme1/Op7Q6aLEEDIvv1q19Ypu2oMRtzSZmoRk7UbaRt9m9BiIFBWOkmm2jlAMvLJnm11amRZRj4P7YDJm/qyZjHQeUBfUx/9HoC4AOhNzQQ6qV11RfSI9viXyBMy1qtXJj4tcGrw/097HaxBcHl/Qq7gAqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cL3TidH5; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1766694030; x=1767298830; i=quwenruo.btrfs@gmx.com;
	bh=LcG3W5iQF+rY78NyPY3MGcVjSBhKt1dfRrBXkv2Zv98=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cL3TidH5B83DiwkJn6g+XIqSJTai7tCgRPNESFy1vIGWPR0uW7NGWwVMWCeM7Je3
	 veo4+AjFGpku0dt8rDkj/eY+ZBBHieNEdJbUWA8cUJKx0vd5wrh+AFSE1JWzVsg8i
	 C2h0zr6cR0/FkkrR6Vnv8b8ahIGn1/muezI+K0belNrOe3o64/kN31P/noStb/jng
	 5M5MOk0FLTj9TRpCRnWWCSEGvV592rrjkq1O2Xr0w5wnVqeVKtFh6C1/8I0ICDo3J
	 Mr14lTI6fxsu567PRjR3FlmmoMK9pO3/MaxKxtGhbXDirg6x1zgYm0dJ//p383k8M
	 89Y/Cyz7mLaqsIUoaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1vh9IJ1QeM-00B6xo; Thu, 25
 Dec 2025 21:20:30 +0100
Message-ID: <33aa3873-15f1-48c5-9291-77dc883aef8b@gmx.com>
Date: Fri, 26 Dec 2025 06:50:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/131: remove deprecated v1 space cache
 tests
To: Anand Jain <anajain.sg@gmail.com>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20251223073939.128157-1-wqu@suse.com>
 <5a733a1e-dbc4-4761-bc85-bc811e8fa195@gmail.com>
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
In-Reply-To: <5a733a1e-dbc4-4761-bc85-bc811e8fa195@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MwkutJVj7SFHpAOVZhV9ZqlQOEom+DRMChorg6kvD1Jx0X/Md0y
 zU2mgwUqLMVQ93cPxac1Uu2waqGFApB7JFqexWByiudCzWe4/09EoJgxmnhtSfHSRdWxNaE
 lRWyGwC2gaY7sqtLCsh9NNcHeEiKGN7Ja6dn4WLJ2G1kpfHLlJPkNJS030Qf/wClGcff/jB
 BkBg0R69ujo7J6JPmxv3g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o6FHlicRGBo=;FjMotC1OnCgWsH12NgUM6/8dS0x
 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



=E5=9C=A8 2025/12/25 21:06, Anand Jain =E5=86=99=E9=81=93:
>=20
>=20
> On 23/12/25 15:39, Qu Wenruo wrote:
>> Since upstream kernel commit 1e7bec1f7d65 ("btrfs: emit a warning about
>> space cache v1 being deprecated"), v1 space cache is deprecated and
>> we're considering to remove the support soon.
>>
>> This means soon v1 space cache mount option will no longer be accepted,
>> and the test case will fail due to such change.
>>
>> Update the test case to remove all v1 cache usage, so we only support
>> two cache modes, either nospace_cache or space_cache=3Dv2.
>>
>> This also allows bs < ps btrfs to be tested for this test case which ha=
s
>> no v1 space cache from day 1.
>=20
> We need testing space_cache=3Dv1 for LTS kernels for its maintenance.
>=20
> So why not duplicate this test case: one for kernels that support
> both space_cache=3Dv1 and FST, and another for kernels with FST
> support only? Kernels would then either run or _notrun each test
> case accordingly.

I'm fine with that solution, although it will introduce some duplicated=20
code between the two test cases.

>=20
>> -mkfs_v1
>> -echo "Disabling free space cache and enabling free space tree"
>> +mkfs_nocache
>=20
>> +echo "Clearing free space cache and enabling free space tree"
>=20
> The message should be =E2=80=9CClearing no space cache..=E2=80=9D. ?

Will be changed to something like "Enabling free space tree on no space=20
cache space fs".

Thanks,
Qu

>=20
> -Anand
>=20
>=20


