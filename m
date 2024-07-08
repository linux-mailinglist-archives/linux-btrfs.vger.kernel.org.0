Return-Path: <linux-btrfs+bounces-6277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06136929B82
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 07:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5EFB20C3D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 05:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F3CD304;
	Mon,  8 Jul 2024 05:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="WnsO9vuh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74E36FCC;
	Mon,  8 Jul 2024 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720416029; cv=none; b=rX4rh5sC9VPFURb7PljYZ12cxenoTx+m16LcrrVwD5iEiv2HjzbvtYdhNwOwakUHBT0lb2RW63W2I8BUgaAJCt788MBAgq902+ry0e8EuH2IlJn2hwu1UDxQpYKEc7ZmgIDlGdhx1leGein6OlpdCDlb5Vmk+Zv9uhGostiM0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720416029; c=relaxed/simple;
	bh=GckL64D37jrZIlvJDo0KtMZP1iFZsTMxQ7mIvSziZnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJzuoE3iQUlCWJaxrWZPKRBRDwg1w2xGkGpwTWkmfOG14CnePTPWAaPWi3LVSMQl7qhjvPH/zKuZjjNsvqkZQTqngYVvxFG1YmN9dnJd2P4ww1W1cFRU76I/jyrNS+FYNH9WDgK78RAwNJLLAQ7twv+F1WCGxllvc7KqYQDkIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=WnsO9vuh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720416012; x=1721020812; i=quwenruo.btrfs@gmx.com;
	bh=xh1PC1KpvsfDiu3WYc24IbhjgduzYppmOJMHenWUC68=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WnsO9vuh+b90gj7H1I+rpl8oBonOjtWk6IgUE4MpoKXc8rzT2XrsY4Eo5NsNIgY7
	 22DdGZvHi+ADpa0/cqXUvmQStcRiJMqWXxp/BT+NdSj3s3k6rt7pokr0Kgr0PHiP3
	 XF6BIoJ9U0LjAAKYr/dxxZIUGDeJQd7YWF3Ak3y9Jh0EqX1RBh3tY+M8PZciLtIQu
	 9n5ZKdRnlftkh3O2ikf8B6wO2tsWossNGNSba8h5XLroxe4kTjYbOxh2+mTQd1tAV
	 uuM6oCNAMoZn+r4IaeKR0z0p5OBnS3b3/0unYv9WUhFe9Eha8X1ZettprTER/+lU6
	 4nOz7V0rCHhkX12cBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLiCu-1siDgB3y1g-00Ys8D; Mon, 08
 Jul 2024 07:20:12 +0200
Message-ID: <ecd368a8-2582-4d23-a89d-549abb8c4902@gmx.com>
Date: Mon, 8 Jul 2024 14:50:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-3-f3eed3f2cfad@kernel.org>
 <e0041c2d-f888-41cb-adb8-52c82ca0d03f@gmx.com>
 <e3927e86-d85e-4003-9ce5-e9e88741afa3@wdc.com>
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
In-Reply-To: <e3927e86-d85e-4003-9ce5-e9e88741afa3@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HPL/K+hCXncaMbuI5AbXTGUtBZX6CYPY7mmBYaMYTMHcq9AIG29
 tCThzsFrBY3hXlzVM6PA0r1NfPsdT15xClFkkbeyIo6R+cOh/cs94T9G/+LSBHYl6OyFR2v
 H+jf4M4gtZz7FJWQ28MX95DCDKVo+V4H4y3jadjjBbN185i6B5WhEzYs+oAHqI2uwrwZui9
 3CLuMTDeeAE2dcLaZ3vmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:P916Mzac2hU=;rC7JTAKPnmwG/lw2OzdT/9ij7JG
 vxg+0+YNZScE+aB87UUiLzkw3X9Ga0mzdgE2XmlEXR/iyRA7aWEyAFXXWXC3/EC0xwrBE1RwJ
 R7dJ9AlDfW5zI+DP8pb9B84Uo07kCNa+4JeZxzhGswtVScKCeRBpctU4oyLE1YI0VYvr6etFc
 w5P+Eut9Z1Dh2xGnD3RMihM/wzIdTIVpMaOt9q8OP/58YV9hEc0QWnMltzbv6GVPjpJvXRGtn
 q5LHR8qlXpjN4U3FysIm3+EVwuo25DrPeD5/q34ThqNVzNaC2Od73XM52S/UM3R24LwzK+c1L
 PjUqVOxVxWq+nFLVuNsN6g5pX80m3BVgFgouEPzcNtLJ82b/ivAa0r6u8kOVBijPZoInFgeMa
 WlPYuy/BwJmupNlQn0kU8dWHQ0Wa24NrGppKzmnAcI1k8I0W7Fb4iJ8pNp6+oReBDXP1rMVDe
 8MeGn4Y5mQCTTEhhcYhbRZwH5SUP9DqMdTF7N4VM++dRIfZnKc76Tw8Mc0pF9H3IKZk/N4flq
 jrALpRZVVJTos5k0NsewZ8wmcSx4N6cEPdVfnA0ARvKlsGAa7y9P+C1KGgIki6aXjfxOnAO+N
 xZJg0mprVtYzfX/kMMjIxYTESXaX2UpaJpKSw/pkP4iSv7DGWHaZ0311E6fe/0i0Pke8zxHby
 WyihQVUftJIcqZWjh4z5Ks84PsBpVU/uEgx58HIWe6zYz7b+0QBERRak0tQunDWTMBivSDYnq
 92IGGTGbokOSuNQuR1MDE3rnSg0sbBIRm4fxRtZGiR7P3m991UccVFU8RsTAdOIcW5GTufOQL
 ePcVLaYgzWKI7Nt87tv7FDTAgBd92BbnJqUgaAg25OCy0=



=E5=9C=A8 2024/7/8 14:26, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 06.07.24 01:26, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/7/6 00:43, Johannes Thumshirn =E5=86=99=E9=81=93:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> The current RAID stripe code assumes, that we will always remove a
>>> whole stripe entry.
>>>
>>> But if we're only removing a part of a RAID stripe we're hitting the
>>> ASSERT()ion checking for this condition.
>>>
>>> Instead of assuming the complete deletion of a RAID stripe, split the
>>> stripe if we need to.
>>
>> Sorry to be so critical, but if I understand correctly,
>> btrfs_insert_one_raid_extent() does not do any merge of stripe extent.
>
> No problem at all. I want to solve bugs, not increase my patch count ;).
>
>>
>> Thus one stripe extent always means part of a data extent.
>>
>> In that case a removal of a data extent should always remove all its
>> stripe extents.
>>
>> Furthermore due to the COW nature on zoned/rst devices, the space of a
>> deleted data extent should not be re-allocated until a transaction
>> commitment.
>>
>> Thus I'm wonder if this split is masking some bigger problems.
>
> Hmm now that you're saying it. The reason I wrote this path is, that I
> did hit the following ASSERT() in my testing:
>
>>> -		ASSERT(found_start >=3D start && found_end <=3D end);
>
> This indicates a partial delete of a stripe extent. But I agree as
> stripe extents are tied to extent items, this shouldn't really happen.
>
> So maybe most of this series (apart from the deadlock fix) masks problem=
s?
>
> I'm back to the drawing board :(.

Can the ASSERT() be reproduced without a zoned device? (I'm really not a
fan of the existing tcmu emulated solution, meanwhile libvirt still
doesn't support ZNS devices)

If it can be reproduced just with RST feature, I may provide some help
digging into the ASSERT().

Thanks,
Qu

