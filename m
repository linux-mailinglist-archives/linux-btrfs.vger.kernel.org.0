Return-Path: <linux-btrfs+bounces-10462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6499F45AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 09:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311EE188DB50
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A2A1D9592;
	Tue, 17 Dec 2024 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nYT2uJd9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07F1D5CFE
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422819; cv=none; b=f2gcppEegZd5yPmPhpnkggPNH3NPc7s2B0ei7kM9Y1Z7g5CqNbFLw9Fss5NKzYwV+gmbOZeIvvZwkm28CalaJXz/LMR8Lre1EZkZqml7UwBJptCseqElrh5Alal5seMwnIwrGknfM909lToyV94+89cYoQhF1oxT1c0Cwfj7HSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422819; c=relaxed/simple;
	bh=WIPXAyhKQy4wyCTSS9vQ23bXCeD4pRrPrPGaJ1zbH1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qakWaJ0DArXU8oCVDTiMRYmtS/Xn/93Bt/xd3wMMNXr1Ne+UAjopHBdyRNe/p+vOHucIzRaBUTmOc56FXxbzpXRo2XWbHK9e9zcD3hpuSzauBuCI/vkJWfSl3SLbk5OEm7ye174MS3fiKYR/grOU+o9pKI8x5sYngJF3qyRgEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nYT2uJd9; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1734422808; x=1735027608; i=quwenruo.btrfs@gmx.com;
	bh=sQjKYU7AZRVco1LsRnuhc8Ehhae//Yi9z6AOWR2fiqI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nYT2uJd917VifhaXkbj9+X6KkYHnzWmaooiVl2ox5itqYXIT6hVO+sKEazJ6DlNC
	 a6r89nZ/CHvEeScA9lVDD/O0f3vsgcL3df5c0WBl6GWTsYG53Z+pPLi1x0/iqHZ/+
	 /mEBrPgqvD64C2wwGXNhbAQKxNT46dcN7lOTJjyZ9+wAxo+MZ7sI9Ltm2V5WYZXrx
	 /s9BLjcL8SHCRDPvjWraPuiuWF3bVR1cUkv0ZaoDZV1PxwtC4E/3CzjUFLAFMiZ0L
	 8dDPR5APE8aMDUyM/4xLWqvzNerGRU+gBFpt3qSpELmzorWhzNoKNtvjav/UeDldE
	 ndUSNm1aEWLpsQ35MA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sHy-1tSOXy0cAE-006PhO; Tue, 17
 Dec 2024 09:06:48 +0100
Message-ID: <da2306c3-7b41-4d4a-91dd-e53510f91e9c@gmx.com>
Date: Tue, 17 Dec 2024 18:36:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] btrfs: move btrfs_is_empty_uuid() from ioctl.c into
 fs.c
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "fdmanana@kernel.org" <fdmanana@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1734368270.git.fdmanana@suse.com>
 <7aef21820a6bad0e41699f18660038546adbbc9c.1734368270.git.fdmanana@suse.com>
 <785dadec-8352-46d2-864d-3df93d979db1@gmx.com>
 <252bbd01-e4b3-4523-807a-f9bdd3647a24@wdc.com>
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
In-Reply-To: <252bbd01-e4b3-4523-807a-f9bdd3647a24@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FMul/rj1WH/e+aKZBjla5kmHKQ4IwmMr24MK46OYyzB2aUBgIA+
 FbgAv90jNSSOmJdrGq3UNXOVo7SOVwQtcXQwg0x3kAXvLG4QfQuqEFt180k4X91HKaapQJ9
 6J8keS9RdCzbVGVYmTjKBcXOzNxcc385UU7NK0ZPavFxasFYwMspaITI0JOC6fqT9XISvsI
 KUAtJNliwtW/rr5Ipr0uw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H6ofiRFiKWk=;cQg3cuO3lO+UqgUJIzC6h+faZPM
 o/YKugxZVt1qon3rzv27IPlA5+PNBuPf8JEQVdEz2dJltuJMgcfFvVhxVTp2C/rdXBRaMlgLr
 QQhe2ui2+xSMCJYFoJinDXoeJE/hdg2c93LQCotw5Z72bYormNVjabGTM96PObczqbJ7HpPrN
 pPpPNjaG/Yn4gxyhKyzJ8jIACfZ2Brc24ArN9fWOEo8nxmWuEdjZ6hHNbcRllqOHGiGeu8FP5
 ioLsb3cTOPr88ZSmttlhGti127ywhKBjMfl+M4ca+TIaaiJEeWd23HUOwUdRI6T/ppHCFd2Xp
 x4k224RgjHoDQPD6+jWBkwJ4MaWWcR9MOir1YJMIHxzdOR1DGzLgJYokPanhDnz+kE9j3bQBc
 mOImuueqDvpMqSvSXuXQru9oAxwaLBPO1ZNUDxYhBGfHfgTX+/7+1JowGUjJR0WG6KU1phkBv
 /JwzluaSzRUehDDcp0TXuup+VM4VB4WfrVJy93YEfL5/uNweYLmv8rHmL23aUazopRsRgLwH7
 urUPFKLLQ5bbZTfbmKum96FouFKuKCDWh3bVCrM/9c5QaPbft8NozB8Z/tlj/Owc4p+aKeIP4
 mGDbIeruYayYzpWWyfzzP4emetRzHEFlGCkQDY/oyNgHM7T6gdyCiLhLDY7PzqB81gwyJnpzz
 yEP33afEdgP+PKAETbWit/QKSrJSe5Lo2EZES/VNAU0J47ZSjJrbFKuVr+i8iR86/IqxHmjZQ
 kwqODtfXXbt7lt+RINsKS6Y2245nXRUjpnABb20WJownWLlmSwTT6zAHXA00hHq/XyGFT2Kxy
 opUDbaGdDrgDyyEM1Rjn7fJUlZ/b5w9qca5G8v4UgCFpuKNva2zbaFx7974rz0WZixQwDy/zb
 Hl2WBFmw98qPIDEZ12gK6ItrtyPsY9IuiIUykZfgMLAkgOcxjNhc0XwFk0GoxinTucpB3EhRt
 0wluEbmjvdzi/Qa8yx4YZsN1K2z9MCttifi7HyQwIE8UNfPH0pF0gPRL8UAvrfRKW7igF0se+
 YYwVHbKiMVgcgMj2CM3qyy9smSrqzgTOSgu6bz9VPupGVF29maotOPJNuHWcILDPmerQ1vXZc
 u6aBLu+w1NyMnydGpS87xPxa9VFs2N



=E5=9C=A8 2024/12/17 18:23, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 17.12.24 01:32, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2024/12/17 03:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> It's a generic helper not specific to ioctls and used in several place=
s,
>>> so move it out from ioctl.c and into fs.c. While at it change its retu=
rn
>>> type from int to bool and declare the loop variable in the loop itself=
.
>>>
>>> This also slightly reduces the module's size.
>>>
>>> Before this change:
>>>
>>>      $ size fs/btrfs/btrfs.ko
>>>         text	   data	    bss	    dec	    hex	filename
>>>      1781492	 161037	  16920	1959449	 1de619	fs/btrfs/btrfs.ko
>>>
>>> After this change:
>>>
>>>      $ size fs/btrfs/btrfs.ko
>>>         text	   data	    bss	    dec	    hex	filename
>>>      1781340	 161037	  16920	1959297	 1de581	fs/btrfs/btrfs.ko
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>     fs/btrfs/fs.c    |  9 +++++++++
>>>     fs/btrfs/fs.h    |  2 ++
>>>     fs/btrfs/ioctl.c | 11 -----------
>>>     fs/btrfs/ioctl.h |  1 -
>>>     4 files changed, 11 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
>>> index 09cfb43580cb..06a863252a85 100644
>>> --- a/fs/btrfs/fs.c
>>> +++ b/fs/btrfs/fs.c
>>> @@ -55,6 +55,15 @@ size_t __attribute_const__ btrfs_get_num_csums(void=
)
>>>     	return ARRAY_SIZE(btrfs_csums);
>>>     }
>>>
>>> +bool __pure btrfs_is_empty_uuid(const u8 *uuid)
>>> +{
>>> +	for (int i =3D 0; i < BTRFS_UUID_SIZE; i++) {
>>> +		if (uuid[i] !=3D 0)
>>> +			return false;
>>> +	}
>>
>> Since we're here, would it be possible to go with
>> mem_is_zero()/memchr_inv() which contains some extra optimization.
>>
>> And if we go calling mem_is_zero()/memchr_inv(), can we change this to
>> an inline?
>>
>> Otherwise looks good to me.
>
> The generic uuid code also has a uuid_is_null():
>
> bool __pure btrfs_is_empty_uuid(const u8 *uuid)
> {
> 	return uuid_is_null((const uuid_t *)uuid));
> }
>
> should work as well, but I've not tested it just eyeballed.

Wow, uuid_is_null() is better, because it goes easier to understand
memcmp(), which also has extra comparison optimization.

Thanks,
Qu


