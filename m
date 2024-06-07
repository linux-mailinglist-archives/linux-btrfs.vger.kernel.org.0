Return-Path: <linux-btrfs+bounces-5520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A528FFAD3
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 06:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBCEE1C21859
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 04:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040916079D;
	Fri,  7 Jun 2024 04:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="f80zWARC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A90168C02
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734476; cv=none; b=ENzv7pVrhG0JLCzPngVcvoLFoM0q8m2v5TrZ2IMWMsZqq9cywsbTcTTNVP1wyBZzj2p7o4QDvv0JB0VtKJK1N2q/JD/PdKRY2oz6YRSN62yGJc3exgErifwJodj70cC8EdT9FEkhnypQyPJ75ZTUcRxznqGiJngiSNsfjjiMyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734476; c=relaxed/simple;
	bh=0Sgfs3qaBd+0VSLTreZyz9MmHSzCp+OCrGQfEKrJ+qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esSmWXwX3vRSkqFZzi+LdsHHD1/kNoGU9LfjoWRewzyDJ9SCVhKUNhByF1HN6tZIZY5yBU8pYvntKHx8haWosAHsilKUZzEYNqm9Gyspc0T9ep2uLpWDHhIF0vdTo2cZ5lpuqC9JHDfQTaVYjxfVW+M7oMLWzrZdo9bTa27iORk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=f80zWARC; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717734465; x=1718339265; i=quwenruo.btrfs@gmx.com;
	bh=0Sgfs3qaBd+0VSLTreZyz9MmHSzCp+OCrGQfEKrJ+qg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f80zWARCXGzMNYq7Iy1JmReoFIB8PCZur8VTPvIUw3rSZcQlznuBGe0HpiLdhbCt
	 bmOAsdU32rlmmTtKfXoPDI+zIqYavtV75xeWjEcfkuD9wAwHkIM/sCS59v+Db/g27
	 xjheUNfZ+IyvdbZYWqEDwR8SL4ZFCnES71U27Bs4tuGr3wy1IHJhINWxUke/6fYgh
	 u6q3cok6qK9HAo009NO0OXgAbuvBmQ/hS+6CTCdkBZGHVjBW4P7YU3ov1//0PbUhZ
	 CDoOw2QLo2afcFoszClmw3KqQBJkS6vNUJexW8lU5jb3TYR2Z0g/Yn1F9+PCoLsst
	 UfWtnBZbdmWJeqEOFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGyxN-1sAomR0Y2l-002Us8; Fri, 07
 Jun 2024 06:27:44 +0200
Message-ID: <c3197ead-6393-4a80-9e7b-ed8eb9b8a298@gmx.com>
Date: Fri, 7 Jun 2024 13:57:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix a possible race window when allocating new
 extent buffers
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, Chris Mason <clm@fb.com>
References: <0f003d96bcb54c9c1afd5512739645bbdddb701b.1717637062.git.wqu@suse.com>
 <20240606192722.GF18508@twin.jikos.cz>
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
In-Reply-To: <20240606192722.GF18508@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nVPVzKfxvztkJXmC4GJZqUL6DITAjSk+8o3E9No2zpRnV5l7H7A
 KZZ0izus62CnnKrHw7K0MvFcZZGG7vc+Z8iJdZAn3pM00itH4KpMx2uR5IAsOm/UVSYkJAe
 2xUIAPtWOLnz3WWkH+UJCtPJu1Mu5cGkxqUTZcfnZhjih1Bv6sZ6yX5FYTv8s3sQFZfl30X
 d8gKRGRg/Etce3Y+O13Sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MlnFTae6+RI=;v2vFcNXT6RHiDkZ/rY5m1h6YIff
 EnLHVffhKk7z4tdfg33dt2/lmBnZ0Tm0bHNoao77QW4DkP94XiAeEQSm8tOh+qdasW+OEW8Yy
 QXO1UvNXsd0JQ4bZZlsHEefBJxYV/VA/WeJSqEr3FVZOlM8WzKN8594OKRJNkwRMW5ai2OsMz
 bEBtNTXs2uUsEOtfRUWCIEampeT2itF5eZt3KtihowR7RH7l693TDV8is0MYxQmpyoI52jF6w
 NkBQI4rDq+fRH6HuTsKUe1dzuETHpGCu074N74lr5HT09i/W+hUuIre2jzXeRcve4nLvgYmzI
 2HQUVxmqD4pbL6PlaCdj2p5XeaYYiIFKVB1+KHMuqWUUTTvEcIgVXWEN81D7X6edo2vgiAi+c
 jwMTfSCuuXFlSye8kn9h7jO50VTOHCzud9fg2dCCgneEZauQFIlHg14uKyUkZ1AreCZayMOnm
 r2Wp4f7MTNaMQrwszbwkouxkIxCTPUE39Podice924T3Ibs1EQw78aQ3IIVZwEUJyeQeM4YC9
 xDeKeTzKPu0cM5XF6Nyq5D/G4XwFDZQqvibKkXvKZapCJpFNls88w6eOGOIIXuhg8q55nSA7i
 zry96L5ohYdIdN1AISi5OI/dMJkwERMqxKI9ss3OE+Jx6GEbELw8PiorQCbU5Duf6AMQkAUYp
 HlF4kcv7I148mWiIcZMvnxYNhsPxoixCSiZqW3G2NyMoXTAYpKimYK5nb8F3zipfJlOu65/Zf
 TryecXMsQOUOEO40M4hOxApxhTy1IH9VuOD14LQFWAyAzryi9kQpDxFz8kGfSlUNjPxmmH/mX
 tuQWK7PrLxhUd93aetwfRa19rZHhMCWA8oxsYPQUHyeq8=



=E5=9C=A8 2024/6/7 04:57, David Sterba =E5=86=99=E9=81=93:
[...]
>
> Thanks. I'll pick the patch to branch for the next pull request, the fix=
 has
> survived enough testing and we should get it to stable without further d=
elays.
> I've edited the subject and changelog a bit, the problem is really the f=
olio
> private protection, it is a race window fix but that does not tell much =
what is
> the cause. I've also added the reproducer script from Chris.
>

Mind to push the updated version to for-next?

I'd like to restart the test of larger metadata folios.
Ironically if we force larger metadata folios (one folio one metadata),
the race can also be solved, as now folio lock would kick in to prevent
the race.

Thanks,
Qu

