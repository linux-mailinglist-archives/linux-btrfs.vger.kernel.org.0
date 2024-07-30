Return-Path: <linux-btrfs+bounces-6895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5639421FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 23:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A8B1F25497
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 21:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD93187853;
	Tue, 30 Jul 2024 21:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dE3eynyG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536E338B
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373468; cv=none; b=AV0v2FUvixyYa3vjQWkcy2h/eRw0IVl10y6GiS7lCNLG+Us0Lq6rHkv/KDqCclgwuE3cnvJck4/AMGw46agIbqmpcPLbm+cbmKovpl05GJsMaLRfUMCAbB8Khkk6iEO++hFOEaR6gfWWri+iLJTQYt5/3CR4aMMYsPPsSrp35kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373468; c=relaxed/simple;
	bh=n7F00dY/zpONlTpKyiX/+KGhQXfZZmGWi1Z+HkVTuLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eIlWZ6YfgD9+pmV4ktkiQfoWnKfX0b8zNFvvlQpnzObdX53uJfLiq/qfjg6ISw/BC8aYDv+5Q65eR4f2zJcaBpS8ej15LXPRlCVcvcHl4JvjZv1ok3hjBjxk/YNHHdd2gqraQ0L1fx1RTs9GzyfoXWY5kWxcvFZ+HeFb8tTfi0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dE3eynyG; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722373460; x=1722978260; i=quwenruo.btrfs@gmx.com;
	bh=n7F00dY/zpONlTpKyiX/+KGhQXfZZmGWi1Z+HkVTuLc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dE3eynyGfkfgSCjSOzic4R1O5cilfSlSdtQrdmQVUBPFG4cbjfq8I8CpmfwuWdjh
	 PoYsUBqsSCxrSr9v9fPH4aCJjulZ59dyyGi6vlfo5PsQK3YkYTtaUWC6SwtwrsZ/B
	 TtDbAM7HGad1+DT0iwfWLhRPAIxtcXX5bg07v++vNGxNYIV/48xmUkw3KvObW64DU
	 pLqaILg6Ug8EpMoc8Sf54J7OS5St+RhK4cux0v9/ogm52g9ooyAcU650bWLg83q7X
	 E5S2ZBICWmnt7MGoz+O25P2VQx4/sj2v7k87dMIa9srkzKnbZd3ya5MFW7XNCIH78
	 /ySRYnnfKB4fjFfuSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfHEJ-1s2JHr1PoZ-00q3zd; Tue, 30
 Jul 2024 23:04:20 +0200
Message-ID: <60aa212c-c1f1-478e-a108-1201ff5fb5ef@gmx.com>
Date: Wed, 31 Jul 2024 06:34:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: add --subvol option to mkfs.btrfs
To: Mark Harmstone <maharmstone@meta.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20240730093833.1169945-1-maharmstone@fb.com>
 <d67ca8a6-9b5f-4ba1-aae3-70e1cb22ecda@gmx.com>
 <4dd099b3-8a2f-4a5b-9471-f01703e6b409@meta.com>
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
In-Reply-To: <4dd099b3-8a2f-4a5b-9471-f01703e6b409@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MFI/fU3Y1zfzPO2DL/j3K00oj6DFpnoQxHYJTlt2w5rWqx+0Twf
 uP5SMlsxjMLL9S8GM7VjSYHp8+zFXO0xuxTQdm16d6XMc6wF1+px0cvLBq3LwUNYl+DjS4H
 xgcOC7o0M5p0c5ooMH3alfX1FUZjmKAI5ydclrsUsDtnMBgjt5kvZq90kEOj2Z1M/NC4t8N
 Wfz+zFzLPFU7JG3k+0HPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O1BBwJZ06Z0=;/GH0uuKt4AnJogrriYPaO1U60bg
 pzHWIwMQ7tHgoVY+i1FezOLLLD8XPruTarttA6j1QhrZRQQseoiwixx3jq14bPGwuLS9lJ5z+
 WDhwT+QlCXVS69YXibhDZDzzXU+HdHSDzGJOPwR/vP6xzA30yGv7ua1j45RFMzUgxJYkujHYP
 P3sMrvQHg34wxVbtlisQ/QijVf1a1uOiNfbv8Sgg+UynVktzDVeJsAD69Ybw6VemAG6cQS/fY
 EMftqqJFqS8u05IfW94etHUo5X82XDLvBdFIsFo41xqKUYctyTjvW6dJNS8mQhQXfZJGVjBda
 BINVRS9L6FUlQQjQTJAmpMqGQIIFa7YRU1cQEOY8kuz742lNzIlqnQ/kScPWTvZb8zSPZ/tPr
 Ci0536yGtHLGc/KBl+RnhrWSfOaT86aZ/RWQeIUMOrsdI3ZKx4LQ1MmAZZ+h1Y9tLAV1Nrnoh
 tzSG2POQ3x9iWSZXFv0Fvu32XXdQBpZYzi5YbxbWGjWz/A+NGsPLJziOiMwJBOgZSy1bUOUHn
 cNT2ao1oB0I4h9RqwhT2igrrNlen8AUr/+E5Ngyc68VFrZJpte11QanZRWULZU2sxz9lF2N6O
 aohSCfF0glsaoCwxwhTGx7FVcDLAfKabvQE5NIai0pZUz9ZTvxhoi+IUBJevbF7eTGabGILq0
 U/yU65spjE2pKpDkZptRSzYKL3drJOEz2vThFYhwghI7R+FqVXOtEuGBil0wuDa1YuLZ6j/UM
 zoV7Gt7SJRgFSK8hdJzzoi3mN01ShEKARTyvwmMOet98OT8B6B0Ku3wW/taJwGNxM3Fpkp93b
 sElA4YXZ2fp3atm9vJr+8iPw==



=E5=9C=A8 2024/7/30 23:20, Mark Harmstone =E5=86=99=E9=81=93:
> Thanks Qu.
>
> On 30/7/24 10:55, Qu Wenruo wrote:
>> And before the --subvolume option, I'm more intesrested in getting rid
>> of the function completely.
>
> With respect, I'd appreciate it if you waited for a version of this
> patch to be upstreamed before doing any refactoring.

But I really do not like the way new subvolumes are created.

If we merge it for now, it will take way more time to change/fix it.
I do not think that's how we do the development.

Thanks,
Qu

>
> Thanks
>
> Mark
>

