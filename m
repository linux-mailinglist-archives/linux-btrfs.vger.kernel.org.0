Return-Path: <linux-btrfs+bounces-6159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D169924B79
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 00:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA9C7B26A2F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57B91DA309;
	Tue,  2 Jul 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="B8tmTM4U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA441C77
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719958798; cv=none; b=Kwyn+Kci98VcnY7zriqEZvJCeCPMgD4/haPTU30ejMjiZCtxJ9U+Kd6tsblbhTNdjTTUEIpCN1E9fRIC4cfFyqRxuMLDGIvdcBnHMGSSdcmzu359Imw7zlaq4DwZWKdqo353TXBKUn8BIBZaCR2ImUym/dKE30w02JGZwnjuD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719958798; c=relaxed/simple;
	bh=81K4Dd24Q7Jt2DNBYFmLZCbccPGABgg3ISG5uycwLkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2JoJ02d0ViAR4GEBTpvutTh/JW9ly/vQ0wXT5f+QvsDAmc1R90zSxzsG0wl15K7cdeq3lNccpgyKenTmCxB3+nlesYPH+oMn8PUJ28nesTzt/X1r7ZVlDGzkcBzX0CQJPKLD0ExiCKJCXrA4EM3iGcFDaFVI9YBIL7xGGBhIfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=B8tmTM4U; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719958793; x=1720563593; i=quwenruo.btrfs@gmx.com;
	bh=HsT7DPcjYWghVXOFA0/PlUoVIxCeqxcDN9laqCDiKwE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=B8tmTM4UPKs+fKGwfjBeAw9kmkFZjEDelJcp167i0zdNAtfHLxsAulD/EKs9piLn
	 BZZLG4Ilsztu4zBAVjdMKJJCo/6xwKJfvUujCC2oPNxLt2KZF05Ytgl4pMxJCSHWH
	 X3zbANb7Y0f4mYE8bHrqLkU319hzdxqwMFX/rfg/CgzrSaTP1cZ3fEXZ57fqtbc4J
	 p9lF/eEQoJkQCTTqQr6ll+T2kx4pQ61/dDmfDHj8YlZGgsDalczPhXwxRYghVtDG6
	 fuTJpdMVO9/mEa4KBPGJIeo+zfGBoHmKZCYTPz9L6jgUW6mzFvi7uhxr6Z32jL+SS
	 kl+4HvuE9Q2D2ybltw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDhlV-1sXG2x1jhH-009L9x; Wed, 03
 Jul 2024 00:19:52 +0200
Message-ID: <8a0251c7-b594-4992-bdeb-1064d04be3b4@gmx.com>
Date: Wed, 3 Jul 2024 07:49:49 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: prefer to allocate larger folio for metadata
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <96e9e2c1ac180a3b6c8c29a06c4a618c8d4dc2d9.1719734174.git.wqu@suse.com>
 <20240702161131.GH21023@twin.jikos.cz>
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
In-Reply-To: <20240702161131.GH21023@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:esxZtPxQ8ouCVMdJ+H7e8kNS4KLM8TYIR3EspjCus59xLrrJzfI
 BlQD4xZG1SbLEAqcbVwnjThtJrKeY3Kjp6Zx369Cmif9rVU2uCW2/V1BDwce2VcRADr4bny
 Vtm2I6XfQqwz337Ra2Clm7zbgLNJU1xNevK/c+YpGconSstkZEy4GuvGEWMCie6W1E27dEK
 /5We3AsX1BT9f17YF4JDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X6b0UZldH78=;qygCjRjlr0wHHUXl3ngK/EylvQP
 JcBJmhWgLUHk4ZhWBtuWROfg40a0Ss5HkNDaBs9O5HPpLEzV1lEFXbIyL3L9ctyKLkXlV/uJ8
 CFxsAugOSzHkbHglnpze4Uu7J3dNYYhJK4gN7qJZXMILz22vjcr3M7YC+lsJ1iAXZ+BdSv2uK
 ILsrmOOrG9Hr8ERRlSDaNMYzxS9AC6GicZxSzJABYns7eeqmlaJ0pyu45C09zskNKPGdBQVn2
 Jci+p9hp+TshuHhORBnFVk5kTL+3w4EXUrZumVafJJnZZe5rqGHY8qfSTpC1eQHTtsJ9lCice
 MwOXa48oWSquhWEl9lFxEoux1lz4Bdfdhn3xnZneI0cBGU5VvNAyDunkq7MCKRvPLKgaPnHN4
 D00Ua/KYuL/jApcpb1LOBdBHiPu2AiUYy7XnbwS5faJ3Cq9SdqBce4Zrmw2zEKJK+qLhNWhab
 LxCjEbM0YR29i0ehhKeH+eEwEZxlgzts14BlFbEyHuh/rT4oU2k4eqUZhow7udIxBGkcw7ZAu
 OyGGNovyc0qta6GxGtyLw32Ega8qC09kBCTP4+0ZYXMILpVhytmbzDlZb9Zr4zskHBUDmrISV
 4LQH5ZQFmZEOQoTbO6BxO2JCdO+Bbt2uxK/LAD/4txn0UTBALEqyGYgrMOSwfWXpwnZHDdoZY
 FqVpCGUMWnWshiihGxPNoForD8lI5iwLMJdMD+bjPnXGEXn89tl6NLuitgVv2OFc6iykeCYeT
 tYGyRXsTQGJ/hES0haswXh2XIIw3Pnm+/4nvz1BpbWifyJBAqmr+PNL+K8r0Uyv2gjUnufNXl
 lcnlw3TjIUuFFi5cTLYl3f3P0odypOVofG1HXApTmGPv0=



=E5=9C=A8 2024/7/3 01:41, David Sterba =E5=86=99=E9=81=93:
> On Sun, Jun 30, 2024 at 05:26:59PM +0930, Qu Wenruo wrote:
>> For btrfs metadata, the high order folios are only utilized when all th=
e
>> following conditions are met:
>>
>> - The extent buffer start is aligned to nodesize
>>    This should be the common case for any btrfs in the last 5 years.
>>
>> - The nodesize is larger than page size
>>    Or there is no need to use larger folios at all.
>>
>> - MM layer can fulfill our folio allocation request
>>
>> - The larger folio must exactly cover the extent buffer
>>    No longer no smaller, must be an exact fit.
>>
>>    This is to make extent buffer accessors much easier.
>>    They only need to check the first slot in eb->folios[], to determine
>>    their access unit (need per-page handling or a large folio covering
>>    the whole eb).
>>
>> There is another small blockage, filemap APIs can not guarantee the
>> folio size.
>> For example, by default we go 16K nodesize on x86_64, meaning a larger
>> folio we expect would be with order 2 (size 16K).
>> We don't accept 2 order 1 (size 8K) folios, or we fall back to 4 order =
0
>> (page sized) folios.
>>
>> So here we go a different workaround, allocate a order 2 folio first,
>> then attach them to the filemap of metadata.
>>
>> Thus here comes several results related to the attach attempt of eb
>> folios:
>>
>> 1) We can attach the pre-allocated eb folio to filemap
>>     This is the most simple and hot path, we just continue our work
>>     setting up the extent buffer.
>>
>> 2) There is an existing folio in the filemap
>>
>>     2.0) Subpage case
>>          We would reuse the folio no matter what, subpage is doing a
>> 	different way handling folio->private (a bitmap other than a
>> 	pointer to an existing eb).
>>
>>     2.1) There is already a live extent buffer attached to the filemap
>>          folio
>> 	This should be more or less hot path, we grab the existing eb
>> 	and free the current one.
>>
>>     2.2) No live eb.
>>     2.2.1) The filemap folio is larger than eb folio
>>            This is a better case, we can reuse the filemap folio, but
>> 	  we need to cleanup all the pre-allocated folios of the
>> 	  new eb before reusing.
>> 	  Later code should take the folio size change into
>> 	  consideration.
>>
>>     2.2.2) The filemap folio is the same size of eb folio
>>            We just free the current folio, and reuse the filemap one.
>> 	  No other special handling needed.
>>
>>     2.2.3) The filemap folio is smaller than eb folio
>>            This is the most tricky corner case, we can not easily repla=
ce
>> 	  the folio in filemap using our eb folio.
>>
>> 	  Thus here we return -EAGAIN, to inform our caller to re-try
>> 	  with order 0 (of course with our larger folio freed).
>>
>> Otherwise all the needed infrastructure is already here, we only need t=
o
>> try allocate larger folio as our first try in alloc_eb_folio_array().
>
> How do you want to proceed with that? I think we need more time to
> finish conversions to folios.

That's for data folios.

For metadata, the conversion is already finished for several releases.

> There are still a few left and then we
> need time to test it (to catch bugs like where fixed the two recent
> __folio_put patches).
>
> Keeping this patch in for-next would give us mixed results or we could
> miss bugs that would not happen without large folios.

I want it to be tested by the CI first.

It passes locally, but I only have aarch64 4K page size system available
for now.

> For a 6.11 devel
> cycle it's too late to merge, for 6.12 maybe but that would not give us
> enough time for testing so 6.13 sounds like the first target. I don't
> think we need to rush such change, debugging the recent extent buffer
> bugs shows that they're are pretty hard and hinder everything else.
>
Yes, that's totally true.

Thus I hope more CI runs can be excerised on this change.
And it needs the MM change in the first place, and I'm pretty sure the
MM change would take some time to be merged anyway.

Thanks,
Qu

