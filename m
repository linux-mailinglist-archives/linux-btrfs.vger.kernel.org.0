Return-Path: <linux-btrfs+bounces-6161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889C192526D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 06:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11BCB256F4
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 04:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CDE288D1;
	Wed,  3 Jul 2024 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="U4X2Feoj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371317996
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981203; cv=none; b=GdxWt2D2SdRuiHpBSrB3YTCpx44n0lGqSWcV5PaDVU4VSa5j+BDFGv7iYR0WZIiT9XI9cWszvuUvI83ehICZb9+CMmxF0w7+0rbQnp73k/QRC3yEfALEZZuzgGvmYcqTPVVwKNCqVdHUOxADvUECFnScoca+61nE7wYQNWjaCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981203; c=relaxed/simple;
	bh=zWFSHEEdTrvtfUf8G3pnSRF5Xo39PpTrnHaVNvChQVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ce16NMB9ODbiBH3A4KP0zUZqgZDYl50kgxNLk357j+/4JHpg8317xsBYaloJufl3369WE+qrSOq4xI99mJoQhcI3e8pR7yotjvBDhI/JC1zplyNnakkkmlVUFgm4oQRrLECpwDMBzCt0J85j9uQCdaAS5wzGfvGR+zqJU/Gxmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=U4X2Feoj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1719981197; x=1720585997; i=quwenruo.btrfs@gmx.com;
	bh=zWFSHEEdTrvtfUf8G3pnSRF5Xo39PpTrnHaVNvChQVE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U4X2FeojrEB44mWYkiBjzF/YWWZ/qoo5A0791ZpNNpbyjtaHAj3kr1NMh2yw4IMl
	 6VdMMmintJzMU8LvTLKY3K0mRwz2hrkFbSsEJjIuMBf/Nly7l7ij1v3gCw/dcoi5r
	 QK6a0WwOGjFa2E/dVfwzC41IR9m2W8ojOPIrXNYCfPsz/umPt4ulK5ZxaUAMaprJJ
	 CFZZZNEs+7VCHnNokPlYvmRmdT5I1i1iLOZ3jImT1azTFqL0odUXOHMvFuHyi5YFb
	 dJIxSc1LOGukk1qyxp3CAgy3f2r/yZ9194FKWOTMo3/M00g/70m/GzYHObKAxltZ/
	 DtqzQcZRuN2BfDkSPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRTRH-1sjwwC07HR-00N15n; Wed, 03
 Jul 2024 06:33:17 +0200
Message-ID: <3bd15793-7a52-44ca-9e9f-e846563cb8ee@gmx.com>
Date: Wed, 3 Jul 2024 14:03:14 +0930
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
 <8a0251c7-b594-4992-bdeb-1064d04be3b4@gmx.com>
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
In-Reply-To: <8a0251c7-b594-4992-bdeb-1064d04be3b4@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GQ4UE2EWJi33e0RwI6xrsGgpCiO338yHpAOH+q/EBtG5VHdLmXG
 I2wHp9D7LMPVjZBkdMpbBUUcpIdid7eBF5lXAJOvrdPFZ3pbQ2qr7a+kzUAQmVvMklATKL1
 /1uph9Vd4ht0EYKh07LPGdl9VfSLSxgsZ/v6UqfmN2tNQ63InUvjkNeNSt45ulep55fNYh/
 Gic9McjPIL5Fa60K5AMtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:k21WdCyWbiA=;VEW/r2YxP14gBIhvYARoyCQ1ds9
 oDHRZBnoYmIM8Qqi+p/sfcfz1Z1wMv9NI/rMS1j8+bWAFiJL8M2RGxqLpCqkLqg3e3G3P2+kU
 B6cBpTqlzJ1eKu6kmO6l+lTHU7BPVoyHCEekizhkHgqA0/GFc7hnVJNH0Ffu6ZPFe2ZivsbJV
 UBIyniGTr8RXqBhgIqTBYnI1wUDtM08l1iPXkH1Clfq8y/o8CroxHn8yaQMcgf5HR0NpGXaUn
 zldqqP7PClP1IViIlEwkdmRBG3yR+pkJ0fwjXgIU8+s/RmSxurNBK2M/eqynSNIuVE6d52DD8
 HWYVs9runQDG7kTrYjmI4fhi/K/VEBf3MUijiJBVdI4WmyEk3anEAD7JR11Q+vFcywrb5Ks6I
 /1vsVmh7rYySOK0erS8QKMVOU0TVr510KOvPwBpgv4z8rU+l8Uz36mXA+inv9+Zxa1c4h5gJ0
 W8hqDlujQaRV/ooda9GrKPTar1LTG+f2X5jNeKbVCzEnwmm9ITq3rTRfGRlLXMGPvuM19mNbT
 WUV2DCwr1RDXjt1RuV77lRNhayFmoAkdUUbaiiworF3KWd5stxqNkuKwsXCvlNXNMCiKiHOxO
 WjyAJxH5IzQpgvwIkohsg/RJNZLmEQ7ntPv3SkGvFgQXHJqO9pkJigbwPtXx1FdvPvYOnCPby
 y4rUVLpGvHr6ji7Z4JaRP2kA+zRwUVPR7qt4cTtUeLOOsR3XMHXQVAovCNg0coNqB7OaACOdo
 KZFDQ/vBpBSIsyCaBB10TMgN1WB37KdpoqTP26kkQR7k9yRcd76BK++RGnUeYl4bERgM4Y4Fq
 6+LX+AGLC8SfmHzNlNhMH2B7sTGlXdy9ZmM5aSe1Hd27w=



=E5=9C=A8 2024/7/3 07:49, Qu Wenruo =E5=86=99=E9=81=93:
>
>
> =E5=9C=A8 2024/7/3 01:41, David Sterba =E5=86=99=E9=81=93:
>> On Sun, Jun 30, 2024 at 05:26:59PM +0930, Qu Wenruo wrote:
>>> For btrfs metadata, the high order folios are only utilized when all t=
he
>>> following conditions are met:
>>>
>>> - The extent buffer start is aligned to nodesize
>>> =C2=A0=C2=A0 This should be the common case for any btrfs in the last =
5 years.
>>>
>>> - The nodesize is larger than page size
>>> =C2=A0=C2=A0 Or there is no need to use larger folios at all.
>>>
>>> - MM layer can fulfill our folio allocation request
>>>
>>> - The larger folio must exactly cover the extent buffer
>>> =C2=A0=C2=A0 No longer no smaller, must be an exact fit.
>>>
>>> =C2=A0=C2=A0 This is to make extent buffer accessors much easier.
>>> =C2=A0=C2=A0 They only need to check the first slot in eb->folios[], t=
o determine
>>> =C2=A0=C2=A0 their access unit (need per-page handling or a large foli=
o covering
>>> =C2=A0=C2=A0 the whole eb).
>>>
>>> There is another small blockage, filemap APIs can not guarantee the
>>> folio size.
>>> For example, by default we go 16K nodesize on x86_64, meaning a larger
>>> folio we expect would be with order 2 (size 16K).
>>> We don't accept 2 order 1 (size 8K) folios, or we fall back to 4 order=
 0
>>> (page sized) folios.
>>>
>>> So here we go a different workaround, allocate a order 2 folio first,
>>> then attach them to the filemap of metadata.
>>>
>>> Thus here comes several results related to the attach attempt of eb
>>> folios:
>>>
>>> 1) We can attach the pre-allocated eb folio to filemap
>>> =C2=A0=C2=A0=C2=A0 This is the most simple and hot path, we just conti=
nue our work
>>> =C2=A0=C2=A0=C2=A0 setting up the extent buffer.
>>>
>>> 2) There is an existing folio in the filemap
>>>
>>> =C2=A0=C2=A0=C2=A0 2.0) Subpage case
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 We would reuse the fo=
lio no matter what, subpage is doing a
>>> =C2=A0=C2=A0=C2=A0=C2=A0different way handling folio->private (a bitma=
p other than a
>>> =C2=A0=C2=A0=C2=A0=C2=A0pointer to an existing eb).
>>>
>>> =C2=A0=C2=A0=C2=A0 2.1) There is already a live extent buffer attached=
 to the filemap
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 folio
>>> =C2=A0=C2=A0=C2=A0=C2=A0This should be more or less hot path, we grab =
the existing eb
>>> =C2=A0=C2=A0=C2=A0=C2=A0and free the current one.
>>>
>>> =C2=A0=C2=A0=C2=A0 2.2) No live eb.
>>> =C2=A0=C2=A0=C2=A0 2.2.1) The filemap folio is larger than eb folio
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is a=
 better case, we can reuse the filemap folio, but
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 we need to cleanup all the pre-allocate=
d folios of the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new eb before reusing.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Later code should take the folio size c=
hange into
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 consideration.
>>>
>>> =C2=A0=C2=A0=C2=A0 2.2.2) The filemap folio is the same size of eb fol=
io
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 We just f=
ree the current folio, and reuse the filemap one.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 No other special handling needed.
>>>
>>> =C2=A0=C2=A0=C2=A0 2.2.3) The filemap folio is smaller than eb folio
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This is t=
he most tricky corner case, we can not easily
>>> replace
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the folio in filemap using our eb folio=
.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thus here we return -EAGAIN, to inform =
our caller to re-try
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with order 0 (of course with our larger=
 folio freed).
>>>
>>> Otherwise all the needed infrastructure is already here, we only need =
to
>>> try allocate larger folio as our first try in alloc_eb_folio_array().
>>
>> How do you want to proceed with that? I think we need more time to
>> finish conversions to folios.
>
> That's for data folios.
>
> For metadata, the conversion is already finished for several releases.
>
>> There are still a few left and then we
>> need time to test it (to catch bugs like where fixed the two recent
>> __folio_put patches).
>>
>> Keeping this patch in for-next would give us mixed results or we could
>> miss bugs that would not happen without large folios.
>
> I want it to be tested by the CI first.
>
> It passes locally, but I only have aarch64 4K page size system available
> for now.
>
>> For a 6.11 devel
>> cycle it's too late to merge, for 6.12 maybe but that would not give us
>> enough time for testing so 6.13 sounds like the first target. I don't
>> think we need to rush such change, debugging the recent extent buffer
>> bugs shows that they're are pretty hard and hinder everything else.
>>
> Yes, that's totally true.
>
> Thus I hope more CI runs can be excerised on this change.
> And it needs the MM change in the first place, and I'm pretty sure the
> MM change would take some time to be merged anyway.

Another solution would be, hide it behind CONFIG_BTRFS_DEBUG, so that we
can still push it for 6.12 release meanwhile keep our CI farms running
for it.

Thanks,
Qu
>
> Thanks,
> Qu
>

