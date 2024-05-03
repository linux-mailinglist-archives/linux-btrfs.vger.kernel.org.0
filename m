Return-Path: <linux-btrfs+bounces-4735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 712A28BB6F4
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 May 2024 00:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A405B246E0
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB34B1EB21;
	Fri,  3 May 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="licL9VZQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28045B1E9
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714774458; cv=none; b=KbKepvZ5gevQ12W05DO4GLQZD2cNOhPIc343ADzp6yrNB2rZhw6NFnV41TYAZNXz+M+bnXaPUhaVTfcxtt1epcg3G3jJ8lQ3a2+jinlieeHkbVNrz6/tlBqUsK7hXkPLBx7vqOTNYsjj9LlM4snIXCa07NJBq7sxn3Cf1Ttcyr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714774458; c=relaxed/simple;
	bh=p7eYLCFjC4yE0ky7w5UFOzFHiRXzB8WA2on5TNN2NOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdFufzYaukkBBGiM7OQI8K6FrZUseuOM+P47ilLBuTK0gg4pcyrt6e/GZ4oJRTw3HY9qgLri29jjtc+kVgjl19PA8tWEtgUXX2RSBVoAFlDVOSgOJqNv3vyH2cessFaJDQlfZ86h5bK8WY9xBYeOZEPtmfvq2zdj2F+vvOa7YKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=licL9VZQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1714774449; x=1715379249; i=quwenruo.btrfs@gmx.com;
	bh=p7eYLCFjC4yE0ky7w5UFOzFHiRXzB8WA2on5TNN2NOU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=licL9VZQYdkCk8NxxZb6shCrhHp4/37WaBC5G42gzrMuMcLvtXrS7R4/eWSSsyrh
	 henvccCNA0Oa0UDUw8g/9FQllm6ffmtNmCdXoM82na3gVEAT8Rh3hKc4RXzhoe5ub
	 WeCLgkITBe1K+l1eAnwTQov2uibGntnf2/mgWxfXZHr05Os3tE3gCT0MMql6ppv4p
	 cMnOHuwIYkHJCImN3NU0bKCJx9eqYizdZVepwVhgLN3l3bjCpZNXQfMZSVW6FOufo
	 9UYDdV5SekHh8QFL4t3E3uybmyo+4ce5rzO9LF6Cb5aPFhla48kbdflvxIoNSKTUQ
	 NQBV1Czi1If2y+dlrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9kC-1rqujs2bue-00GWa7; Sat, 04
 May 2024 00:14:09 +0200
Message-ID: <31af2fa9-a484-4313-abdc-3b4fbda7c071@gmx.com>
Date: Sat, 4 May 2024 07:44:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: automatically remove the subvolume qgroup
To: dsterba@suse.cz
Cc: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <9df817bc-f3a8-4096-aabc-12044447a900@gmx.com>
 <20240429131333.GC21573@zen.localdomain> <20240429163136.GG2585@suse.cz>
 <f8d3bf56-0554-44ec-ac1a-2604aaf37972@gmx.com>
 <20240430105938.GM2585@suse.cz>
 <4a83b326-9cde-45f5-8a53-da7b62c45619@gmx.com>
 <20240430221839.GA51927@zen.localdomain>
 <d49e13f2-59ff-49ef-b81c-8c2c96d8284b@gmx.com>
 <20240502150332.GS2585@twin.jikos.cz>
 <d1c91b71-8196-4ea3-943d-db30883acb8c@gmx.com>
 <20240503124606.GZ2585@twin.jikos.cz>
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
In-Reply-To: <20240503124606.GZ2585@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5k3Hqt6rcL2r2LNSOFcPoKTiV6pMdsuxs4p6GQzPShPfVCsI04L
 kUft4HyF3H4ZRLr6stS5zdQHulXndWVP56YbnPuueVsFT7i2iw92A+8eGHvKpqoCWGJFPmi
 no/iR8ZD9vF2xDNmfslZkuLJnXf0uLRoHKTlsOFsup3fz9woA5XJcYjMCUUxCpW2HOIOGQn
 /HLkdi44bR2RTqOBYkSeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ors+SJwBOKg=;pPFK1mmNJHZUrCJBlkpc84HBJ6M
 fDiPPAXdEi+F++q+bvN25wyODpZfRic6hkMkMCCE5QTgaZvHugvJPQIky4ZrNHWw844IeNfdb
 IiZ4qC9iVJp/fZKbfAUX9pAGr76YuyhM899NJ9RVtQxo4Lcsbim+MBUXjyHCKovJHq8XedRlI
 dWVKORGOpAdAaqeb7I0dVv+JIrW6NQgb8luvNzXW/h/f/cJGw3wf8v//C4elUFwmMxqzNtG4v
 EanUKYjeIbI8CPxB487ElkpcWs3onNYB7f7XnLwXV6uCrI6tCgY40eDsWGnqOttC+sbjNJPni
 puobS5BlVeuquXvT6Fgb1hE0r8OePJeAa+oXInsn88Uiw27tXsJk/Zu18Vqe0PrQxPyT46gs5
 52DeZkC4MrZ4Z2fbWHJV4v0Mj8rJRRHRuVUsb6Rn9vjqJxmXJGWSkPzYy3L+nwhCGZv0oxSIi
 znh3veY5aoQ0ivcYNg7H1AJXTsTpxPRLSF7HqockmiQyKmnY9su+Mjoxvse5RH3UP2wluLNUt
 1eaARn7R97OREofnETfXovVmjmY5e/C5xneXcVLMFOhQTYMkdq2AUv9POZsAwTN3uYht+6LRP
 WPp7JsQ3RLYG2GiWPBd2RlUStRttmit4pLr2TsP9Z59PB2K3/eGkUOC6bPyxgUPPv79/k6986
 ObAPJHpfHmaZwWQJzIg7QbAzXcrwzVj1IIYi7lTOcRNfdGtAuoHp2pZDGVdTJAWvM+Ie3UHIr
 1vc3OURmyRVKBIsRgT2Nj4HXjzCLo59V0MziOWZsflqTZGscpzyIZck+usazL8NOi/9kkLpgo
 sD21nnUEav3+0X/MCcBcMPkNvuXygifUYUilegSeCzfLw=



=E5=9C=A8 2024/5/3 22:16, David Sterba =E5=86=99=E9=81=93:
> On Fri, May 03, 2024 at 06:59:03AM +0930, Qu Wenruo wrote:
>>>> The problem is as mentioned already, it's not persistent, thus it nee=
ds
>>>> a user space daemon to set it for every fs after mount.
>>>
>>> My idea of using sysfs is to export the information that the
>>> autocleaning feature is present and if we make it on by default then
>>> there's no need for additional step to enable it. The feedback about
>>> that was that it should have been default so we're going to make that
>>> change, but with sysfs export also provide a fallback to disable it in
>>> case it breaks things for somebody.
>>>
>>>> I'm totally fine to go sysfs for now, but I really hope to a persiste=
nt
>>>> solution.
>>>> Maybe a dedicated config tree?
>>>
>>> No, we already have a way to store data in the trees or in the
>>> properties so no new tree.
>>
>> That means a on-disk format change.
>> IIRC everytime we introduce a new TEMP objectid, it should at least be
>> compat or compat_ro bit change.
>>
>> Or older kernel won't understand nor follow the new TEMP key.
>
> This is not necessarily a problem, if older kernel does not understand
> the key it'll skip it. The search treats the keys as numbers. If there's
> something more associated with the additional data that would prevent
> mount then a compat bit would make sense.
>
> The compat_ro does not make sense here, the same filesystem can be
> mounted and data read or written, the only difference is that qgroups
> are also removed. How is that incompatible on the same level as other
> features like BGT?

That's why BGT is compat_ro, not compat.
And exactly why I want to push a new compat bit just for qgroup auto reap.

Thanks,
Qu


