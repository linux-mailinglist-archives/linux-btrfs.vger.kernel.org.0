Return-Path: <linux-btrfs+bounces-6901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7D9942387
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 01:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0891284335
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 23:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73617194122;
	Tue, 30 Jul 2024 23:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UOfDXaWK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B4518CC03
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722383075; cv=none; b=cCzJ2NNS5d68+3JIQWrENmIbRZPsdHNCGv86ikE8grRU0zT+p5+Hv58Q/1cJwsi5Jb5zQd260R+gWoV9rJCQjG2ZOVLOsM1EJoBRtv1EHHRvif0xnaqxlaTygO5mgCrzU2xIhL3q58OZdv3E4GqDTp6IdGsXJgCeq8QfhKQip0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722383075; c=relaxed/simple;
	bh=FTw9u8QvRe85VmLGPonbGeGet90o5eEqeBxwgw9SkcE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Osr7s6/YkEA+5VlDklbO+ZeTyvU/PpdLeKu6JJfwtfgBgMquoXjNu9pKTWVmnx0LcGAmh//iulbtWxhxhqzYfMsCyyJe7f7tN2cE/k1pNN//INsbePXrIn47GEw4azcPg1FxlJ9JgV3nIKUvpqK7j/7ydtpMPXHQYUGG+aUHAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UOfDXaWK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722383066; x=1722987866; i=quwenruo.btrfs@gmx.com;
	bh=FTw9u8QvRe85VmLGPonbGeGet90o5eEqeBxwgw9SkcE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UOfDXaWKJ+QKqp9n1Wa3tyOm0MG8ZfjWUDeFijPuvUYvZZ1qeEc77RBljkJ9U28j
	 1q1nzzVAxHP2XOvYWAueRQP9llf1a/W3qF96D+D1pBdlinSnea6csblZ8GbTbSWBi
	 2ePjOhOmbFFeVPnGJebNg+BPMT1tRvm8msAnTUnWiIDbnlnWxpoeE2v679+COq0vc
	 c4tk5Jp69Hh8HfrdZoB/uSX1P2kbJco2TmuJWMkrnrp/eCDWkfkKxy5Aaoy+SYZtZ
	 dSi8pw/4GR9wL5LKwnVPQK3KGinMmXd0ADC97SmVJnf5vd9AT14yKBbDcrhlkTDJW
	 iwEgoVexfpWiXA2mWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVHU-1soGRO0cuW-00TdBh; Wed, 31
 Jul 2024 01:44:26 +0200
Message-ID: <469357d5-45af-4e7d-818f-056fe79a14b1@gmx.com>
Date: Wed, 31 Jul 2024 09:14:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: add --subvol option to mkfs.btrfs
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: Mark Harmstone <maharmstone@meta.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20240730093833.1169945-1-maharmstone@fb.com>
 <d67ca8a6-9b5f-4ba1-aae3-70e1cb22ecda@gmx.com>
 <4dd099b3-8a2f-4a5b-9471-f01703e6b409@meta.com>
 <60aa212c-c1f1-478e-a108-1201ff5fb5ef@gmx.com>
Content-Language: en-US
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
In-Reply-To: <60aa212c-c1f1-478e-a108-1201ff5fb5ef@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hwA0X4xavDDHZbfipz8XzU5n1W/fYf2QGK9a+SDayVZy8TBecRk
 CkrMzm2pEn/Xh2BRfGGLkQnjoQAH3Bw0Cttw5VxG8AX/PL7l7o/fkUsMF0MaxxonJnPE3p9
 QFBjbBLAIigkRmrFeln/jn+QZYddBbUjchWF5McextsqBXR7xSTSsT3D4UPJMSe6YJU2W7g
 B3sOdSCct5ThMrq+Cbtew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b6WDjMhXi/Y=;p5Qb0QIz6g4SobnqjLl/94EgmsK
 2cK/MbGNxOkDY/uSY4nhFTFDrtNoPfCkXwCLHZIjI23NH0hZxvqJ2TtkXmLtiOeUg4BWHzwxV
 AuelmzDEuWF8qYsXrli9zJ47YyUN4VLWcP8P6Zk5MHV9s82+0Jy4L5DFzLfm9XJ7rVPkhiZAE
 gWf+W2efVeKOWMCgQKhM4qcIKAHSolZEYnY5+u7ghwQkhtun1s4CNFkrAIcOEsS3j4QGl2WKi
 I70j9kmNBk/9YW/bjbGeBVijQcJO32e+ioG15bdvMykf2MSnNcn6mtWTsGrfs3FrlW1upVbyp
 VwQp61V+FRuMLUQs35O1FAZmWAbe0rHOBlNttWjXfJ46oA3Q7w+Cs4VaWHZm8u4RgwJdhklKy
 533JfYBChwYZV02jV8SzKFkNMdQJGc5KE9ZqLHkkKsqSFQn607aPXDze2vyI1x0cwtoiZIpZS
 BrUJa5Yq4Z93wb+n+tcKa0Dt1KQDeEAw+KN2GTn8yYDsqHeQ2fahT6OCNUhilnSYr3LzFsrY4
 rN7pS5d5rfM+S9kCD/xY9/5/hzgZiMNrp8mj3/59hxANnDFizza2yWRwF1TTZreIjrM1mzeiX
 9xk3j1hG/lMoZIYo6oWrxEgqrq+1vLgbZyvFSGNB9puEowsXGBVlky7pePUNeTi/7nb4c8IU/
 VZJ0pPOcCJByplPFxyWWpr36d0SYrAITiculixYiP2s1cddCMo4F/yMFsaBvB8JLTgmB9xfXN
 IRSxRik0Vp7OKk/n2/xsu2iQfOYVpUY1Q8g6AEZTLbbWvxiT4VXL1+jv4SU+ktmaCHgson+LQ
 cWsWX6cTv8ubvDqB/GM+/KaQ==



=E5=9C=A8 2024/7/31 06:34, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/7/30 23:20, Mark Harmstone =E5=86=99=E9=81=93:
>> Thanks Qu.
>>
>> On 30/7/24 10:55, Qu Wenruo wrote:
>>> And before the --subvolume option, I'm more intesrested in getting rid
>>> of the function completely.
>>
>> With respect, I'd appreciate it if you waited for a version of this
>> patch to be upstreamed before doing any refactoring.
>
> But I really do not like the way new subvolumes are created.
>
> If we merge it for now, it will take way more time to change/fix it.
> I do not think that's how we do the development.

Just to be more clear, I'm not against all your awesome work on bringing
the new feature to mkfs.

It's the fact that we're making the --rootdir feature more and more like
a subset of FUSE btrfs implementation.

In that case, there is too much historic burden left to the code base,
and I believe it's the time to clean them up, other than building more
and more things on an unstable base and hoping new comers will clean
them up.


So please really consider making the existing code better, before
pushing a new feature for --rootdir option.

And the inode size calculating part is definitely not a proper thing
that would appear in a FUSE/kernel fs implementation, even it works fine
for now.

Thanks,
Qu

>
> Thanks,
> Qu
>
>>
>> Thanks
>>
>> Mark
>>
>

